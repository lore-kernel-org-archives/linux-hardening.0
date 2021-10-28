Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329EC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D6061039
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 11:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1L3m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhJ1L3m (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 07:29:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51EFA60FF2;
        Thu, 28 Oct 2021 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635420435;
        bh=mqqAUASEXEmeWPuWjveulgd7wWvfrjhXUvHaL7rogI0=;
        h=From:To:Cc:Subject:Date:From;
        b=QyM7gKNNuOakif3nBnIxTvjt/cjVRucMiUO0WqaGrf+99AvebwH9CJu8DEuzy3LnJ
         h+CoB5osS7RtklFyKzQ112SwDwSqzkcYi2UFoiIP6Q414d5azVw8BGZerw+ZIOql4N
         D3+Y/6yUk4MAWKbBzwuaa45pfcUqRCyJcJ8VTHP917nAK5OiLwyDuRiOYfMLknBVY7
         lTrbXrbtWHkMeDzJbaQUyp5zmTU2XSvDbBwpQOYAcU7T368Xmlv+2Y/lXML4r2gNDd
         YQ7wucQJUZHGB3ZFGcC+J8gPFtv7DSaZK4C86LcNQIJy6IlxqXQ1t35i5tG6oFPp/l
         iWRKfnHc3ZfdQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [PATCH v4 0/1] implement TLS register based stack canary for ARM
Date:   Thu, 28 Oct 2021 13:27:02 +0200
Message-Id: <20211028112703.1120709-1-ardb@kernel.org>
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

Changes since v3:
- force a reload of the TLS register before performing the stack
  protector check, so that we never rely on the stack for the address of
  the canary 
Changes since v2:
- fix the template for stack_protect_test_tls so it correctly conveys
  the fact that it sets the Z flag

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
 gcc/config/arm/arm.c        | 55 +++++++++++++++
 gcc/config/arm/arm.md       | 71 +++++++++++++++++++-
 gcc/config/arm/arm.opt      | 22 ++++++
 gcc/doc/invoke.texi         |  9 +++
 6 files changed, 163 insertions(+), 2 deletions(-)

-- 
2.30.2

