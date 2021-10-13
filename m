Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A1C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7358661056
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJMPY6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMPY5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:24:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21B8060FDA;
        Wed, 13 Oct 2021 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138574;
        bh=3QKYbX40BAkjfGyywHOKL15UeIjZjw4M1Oc11N5kYpI=;
        h=From:To:Cc:Subject:Date:From;
        b=QlwdxR0tzdMfrSRenkLSppHNoWtRAvbB9bALtxylFy+BJlrac3meHiON/OeeWP5MN
         SRLdoCxUE1JfnJeTFiOvmwFlcfE3JNugV1BZk7GT8JT2ARnkcEsQWerXJLMSqqasON
         ds/U1wSUZ0tiylIAtg/p0X2MxgN67l4ykXK/HWV6vja9eXp4awW/AQ/xuT2AH/o5TE
         wlbHtj4ini50lkZMatlgkKsIMDrLhefQyHdN0KCj/BZvOcXvr8jRbLygivSTZ0xLJK
         O7fAloOZ7Mxu5GOoS2htkHad9W8D5SxPuhR8GqxtLZoZlWq7vAuiZTis1NmToh6CIP
         LfKnW9TiAgmlQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [RFC PATCH 0/9] arm64: use unwind data on GCC for shadow call stack
Date:   Wed, 13 Oct 2021 17:22:34 +0200
Message-Id: <20211013152243.2216899-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; h=from:subject; bh=3QKYbX40BAkjfGyywHOKL15UeIjZjw4M1Oc11N5kYpI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvmwMAIoN3Gz4XNADTFuRJ0SclDSJonUFYskZ//o F2OQxOOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5sAAKCRDDTyI5ktmPJNNeC/ 98Tu3fomVXDSKJJaXsQ1FB5cOr25X4MtN6mp2eVcAGTtSykIJXIQ2ByVId4G5y2riokQesizgzsJOH MschxCGF40BJanETy2eZj1+FW7rWPMK6TeMf3myrjMcJiFTq2K37taMWISGGKhoo4WVH0UekQGKXnc 1/lcFMtagUokH2j/aKktDhVa+MwsZn48H3oD4z0nwJiEaPrtSnFXICnJPaD4KIu0e3LwqGnmsukaZD bajx+0WjS8W5U9Hh+0mE22mOrOMk/xNDbqW3j+Rj5nwv9/4ffQ5VwunTVIf6V9vCyjwyLp3iLfJxPY v7Nb7ZBYLXkbx9g7uViOTKXFF6f+aaRBKZAtOd4n1IPAZkrVmzfGezWcZ81w/2KwcOwWohBUedP4Rn h20TDva2vrmnkG9v0kvEU6cVGQbtn/8MG2v6g+w1ikp//b8XsTR/e6IUpPrPMxL2t9vAiNLEuqhRDH ve0cK7aogucI/VM7WAeW1B6PrCrcYBAvUAbieTQM8PtVg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This series is a proof of concept implementation of using unwind tables
to locate PACIASP/AUTIASP instructions in the code, and patching them
into shadow call stack pushes/pops at boot time if the platform in
question does not support pointer authentication in hardware. This way,
the overhead of the shadow call stack is only imposed if it actually
gives any benefit. It also means that the compiler does not need to
generate the code, so this works with GCC as well.

In fact, it only works with GCC at the moment, as Clang does not seem to
implement the DW_CFA_negate_ra_state correctly, which is emitted after
each PACIASP or AUTIASP instruction (Clang only does the former).
However, GCC does not appear to get it quite right either, as it emits
the directive in the wrong place in some cases (but in a way that can be
worked around).

Note that this only implements it for the core kernel. Modules should be
straight-forward, and most of the code can be reused. Also, the
transformation is applied unconditionally, even if the hardware does
implement PAC, but this does not really matter for a PoC.

One obvious downside is the size of the unwind tables (3 MiB for
defconfig), although there are plenty of use cases where this does not
really matters (and I haven't checked the compressed size). However,
there may be other reasons why we'd want to have access to these unwind
tables (reliable stack traces), so this will need to be discussed before
I intend to take this any further.

Cc: Kees Cook <keescook@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Dan Li <ashimida@linux.alibaba.com>

Ard Biesheuvel (9):
  arm64: assembler: enable PAC for non-leaf assembler routines
  arm64: cache: use ALIAS version of linkage macros for local aliases
  arm64: crypto: avoid overlapping linkage definitions for AES-CBC
  arm64: aes-neonbs: move frame pop to end of function
  arm64: chacha-neon: move frame pop forward
  arm64: smccc: create proper stack frames for HVC/SMC calls
  arm64: assembler: add unwind annotations to frame push/pop macros
  arm64: unwind: add asynchronous unwind tables to the kernel proper
  arm64: implement dynamic shadow call stack for GCC

 Makefile                              |   4 +-
 arch/Kconfig                          |   4 +-
 arch/arm64/Kconfig                    |  11 +-
 arch/arm64/Makefile                   |   7 +-
 arch/arm64/crypto/aes-modes.S         |   4 +-
 arch/arm64/crypto/aes-neonbs-core.S   |   8 +-
 arch/arm64/crypto/chacha-neon-core.S  |   9 +-
 arch/arm64/include/asm/assembler.h    |  32 ++-
 arch/arm64/include/asm/linkage.h      |  16 +-
 arch/arm64/kernel/Makefile            |   2 +
 arch/arm64/kernel/head.S              |   3 +
 arch/arm64/kernel/patch-scs.c         | 223 ++++++++++++++++++++
 arch/arm64/kernel/smccc-call.S        |  40 ++--
 arch/arm64/kernel/vmlinux.lds.S       |  20 ++
 arch/arm64/mm/cache.S                 |   8 +-
 drivers/firmware/efi/libstub/Makefile |   1 +
 16 files changed, 347 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm64/kernel/patch-scs.c

-- 
2.30.2

