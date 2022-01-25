Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2FC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349659AbiAYJ13 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49176 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354910AbiAYJPb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E7A56151A
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B22C36AE2;
        Tue, 25 Jan 2022 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102122;
        bh=qGhOY8YQJel1prt+Wcubqyf0zwngNxVhOPLndl9FMfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s93SFyN35bOI9Z6aNnQsf1qauRkd/uLSm1TVtKHE4vOuujS6S+jKxKgxQ5x+0/fR2
         UfWGz5YGwCRDn7s2Z3gjXCBRsY1xetaaPROa8xECm28fz9RTvDre65XVQ9Bt6mTINw
         bVTidRUKrF5SmLw+BlgIxOzCOJjfNzxNuPkCN4Rh4/sA696Ip8TMKTnUe8xJFB40Y8
         0sNuJQE6oGGDVLQlmfo0VDh/bSUDLTDVGbz6c1Ut2ZHmBLlOUaVBg3dZVt/6UcPaTs
         ozAIAeRCa9YNqFYREuwr0q3TUZB7ouuEjWZAKDgY1CtnKhGp6p1jh8gGj7m8B7l5cK
         OKD7yfzL3UlOg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 8/8] ARM: make get_current() and __my_cpu_offset() __always_inline
Date:   Tue, 25 Jan 2022 10:14:53 +0100
Message-Id: <20220125091453.1475246-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; h=from:subject; bh=qGhOY8YQJel1prt+Wcubqyf0zwngNxVhOPLndl9FMfw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+Mms534Hv/4aXX2yfMUfiFF00l6CLMLG5NFfIS Td0eESuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/jAAKCRDDTyI5ktmPJJ1/C/ 9YGcMv7l2/9Js9kcZaeNh1wDWJM1Puq43wdMCJ5G684JaffjVfZktZJTguPFVO+RLayRNfhY0nCaN5 9eZjSchmQoI8QqE2CKisiQXnT1QdVLBQiKubmEakFiLwnX0joPyGVrLJUSa0QfpebTVz3Vu0ZpAIuM e0Vq9R2qd7tIfy+WXQq1w9iRPUPecQzuOvFkHCmzzXSwV9yaPMmkRlPp8aw3PM9Uw09xfDF3nOH+Z6 CCwEE721fIJ2FFtrG9eJ6L90uzOSMpaVp6DpfqhINbmdGICddsFajh0RpJw3TSs1Y/ziQGSTUGB3Lh 2kKi3iKwkgj21wo/usQE8lMW6DRKRkkYbxFgr6zgorXR9o0hAvMuwV9vzhYovpCAZ14tgXYHYPR3Vi 76GrJ4gjZ22ummS5FpILaCS9HFAdq8oQ5DItRy6aRXasFhOOxOsg7YZvYrSO35YR8g5SytOmkGPSa4 Tjdx7YERr0oZZzAmML0fJW8kW3LaJshQG7tH+KpflJaxg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The get_current() and __my_cpu_offset() accessors evaluate to only a
single instruction emitted inline, but due to the size of the asm string
that is created for SMP+v6 configurations, the compiler assumes
otherwise, and may emit the functions out of line instead.

So use __always_inline to avoid this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/current.h | 2 +-
 arch/arm/include/asm/percpu.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 131a89bbec6b..1e1178bf176d 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -14,7 +14,7 @@ struct task_struct;
 
 extern struct task_struct *__current;
 
-static inline __attribute_const__ struct task_struct *get_current(void)
+static __always_inline __attribute_const__ struct task_struct *get_current(void)
 {
 	struct task_struct *cur;
 
diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index a09034ae45a1..7545c87c251f 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -25,7 +25,7 @@ static inline void set_my_cpu_offset(unsigned long off)
 	asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
 }
 
-static inline unsigned long __my_cpu_offset(void)
+static __always_inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
 
-- 
2.30.2

