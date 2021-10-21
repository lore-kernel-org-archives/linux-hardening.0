Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DCBC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26211610A1
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJUQxx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUQxx (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 12:53:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E35966141B;
        Thu, 21 Oct 2021 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634835097;
        bh=DrDmhjNEwrPqWEIACeKCn0BWBaWjrLtuoCQkwugBP6M=;
        h=From:To:Cc:Subject:Date:From;
        b=mWknZ40p4U29CEculaGRlC1ihYtlmbTPCZYknrOgqlKo7I1Wcz0VNIAA0jgz4Xyid
         OaJVGAzbY3dAaztaWqOOOkjJ5R31rOMlUGJfaEeAXJDP66IcsioX8BVb3/o4qfmELH
         ZIDkdpJFEE+ZWZDpnmxkBrNgDv/A/hcAtzivf+AQRG965TwgKF85Sj9Jvv7iggaRBW
         4Xp+PKURVntqZjRsW5k9IyTaRJ/Yk1Ut912ZyS39jfzboHbRUIwrP3VYZkYjTRKC2J
         R3ror/z0F4OBDITRN1clMiDh+NVCxHipueZgQmvlatNWZkw4h+4qscoqWd6Z1CJ5m7
         AISLV9NGWE1mQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [RFC PATCH v2 0/1] implement TLS register based stack canary for ARM
Date:   Thu, 21 Oct 2021 18:51:18 +0200
Message-Id: <20211021165119.2136543-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102352

In the Linux kernel, user processes calling into the kernel are
essentially threads running in the same address space, of a program that
never terminates. This means that using a global variable for the stack
protector canary value is problematic on SMP systems, as we can never
change it unless we reboot the system. (Processes that sleep for any
reason will do so on a call into the kernel, which means that there will
always be live kernel stack frames carrying copies of the canary taken
when the function was entered)

AArch64 implements -mstack-protector-guard=sysreg for this purpose, as
this permits the kernel to use different memory addresses for the stack
canary for each CPU, and context switch the chosen system register with
the rest of the process, allowing each process to use its own unique
value for the stack canary.

This patch implements something similar, but for the 32-bit ARM kernel,
which will start using the user space TLS register TPIDRURO to index
per-process metadata while running in the kernel. This means we can just
add an offset to TPIDRURO to obtain the address from which to load the
canary value.

As for the spilling issues that have been fixed in this code in the
past: I suppose a register carrying the TLS register value will never
get spilled to begin with?

Comments/suggestions welcome.

Cc: Keith Packard <keithpac@amazon.com>
Cc: thomas.preudhomme@celest.fr
Cc: adhemerval.zanella@linaro.org
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: Richard Sandiford <richard.sandiford@arm.com>
Cc: gcc-patches@gcc.gnu.org

Ard Biesheuvel (1):
  [ARM] Add support for TLS register based stack protector canary access

 gcc/config/arm/arm-opts.h   |  6 ++
 gcc/config/arm/arm-protos.h |  2 +
 gcc/config/arm/arm.c        | 52 ++++++++++++++++
 gcc/config/arm/arm.md       | 62 +++++++++++++++++++-
 gcc/config/arm/arm.opt      | 22 +++++++
 gcc/doc/invoke.texi         |  9 +++
 6 files changed, 151 insertions(+), 2 deletions(-)

-- 
2.30.2

$ cat|arm-linux-gnueabihf-gcc -march=armv7-a -mstack-protector-guard=tls -mstack-protector-guard-offset=1296 -mtp=cp15 -S -o - -xc - -fstack-protector-all -O3

int foo(void *);
int bar(void)
{

	return foo(__builtin_thread_pointer()) + 1;
}

	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"<stdin>"
	.text
	.align	2
	.global	bar
	.syntax unified
	.arm
	.type	bar, %function
bar:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mrc	p15, 0, r4, c13, c0, 3	@ load_tp_hard
	mov	r0, r4
	sub	sp, sp, #8
	ldr	r3, [r4, #1296]
	str	r3, [sp, #4]
	mov	r3, #0
	bl	foo
	ldr	r2, [sp, #4]
	ldr	r3, [r4, #1296]
	eors	r3, r2, r3
	mov	r2, #0
	bne	.L5
	add	r0, r0, #1
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L5:
	bl	__stack_chk_fail
	.size	bar, .-bar
	.ident	"GCC: (GNU) 12.0.0 20211021 (experimental)"
	.section	.note.GNU-stack,"",%progbits

