Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29646C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C061051
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhKBIA7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:00:59 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36522 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhKBIA7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 04:00:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0Uuj7Ztb_1635839894;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0Uuj7Ztb_1635839894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 15:58:21 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        samitolvanen@google.com, masahiroy@kernel.org, rppt@kernel.org,
        mark.rutland@arm.com, frederic@kernel.org, yifeifz2@illinois.edu,
        rostedt@goodmis.org, viresh.kumar@linaro.org, andreyknvl@gmail.com,
        colin.king@canonical.com, ojeda@kernel.org, arnd@arndb.de,
        luc.vanoostenryck@gmail.com, nivedita@alum.mit.edu,
        elver@google.com
Cc:     linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
Date:   Tue,  2 Nov 2021 00:58:12 -0700
Message-Id: <20211102075812.122715-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I tried to submit a patch[1] to add compiler's SCS support on gcc-11.1.0.

Kernel can enable SCS under gcc based on this patch, commands as follows:

make ARCH=arm64 defconfig
./scripts/config -e CONFIG_SHADOW_CALL_STACK
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

[1] https://gcc.gnu.org/pipermail/gcc-patches/2021-November/583062.html

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

---
This function can be used to test whether the shadow stack is effective:
//noinline void __noscs scs_test(void)
noinline void scs_test(void)
{
            register unsigned long *sp asm("sp");
                unsigned long * lr = sp + 1;

                    asm volatile("":::"x30");
                        *lr = 0;
}

ffff800010012710 <scs_test>:
ffff800010012710:       d503245f        bti     c
ffff800010012714:       d503233f        paciasp
ffff800010012718:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
ffff80001001271c:       910003fd        mov     x29, sp
ffff800010012720:       910003e0        mov     x0, sp
ffff800010012724:       f900041f        str     xzr, [x0, #8]
ffff800010012728:       a8c17bfd        ldp     x29, x30, [sp], #16
ffff80001001272c:       d50323bf        autiasp
ffff800010012730:       d65f03c0        ret

 arch/Kconfig                 | 6 +++---
 arch/arm64/Kconfig           | 2 +-
 include/linux/compiler-gcc.h | 6 ++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 98db63496bab..35b27be0d7ee 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -593,11 +593,11 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 	  switching.
 
 config SHADOW_CALL_STACK
-	bool "Clang Shadow Call Stack"
-	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool "Shadow Call Stack"
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
-	  This option enables Clang's Shadow Call Stack, which uses a
+	  This option enables Clang/GCC's Shadow Call Stack, which uses a
 	  shadow stack to protect function return addresses from being
 	  overwritten by an attacker. More information can be found in
 	  Clang's documentation:
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 62c3c1d2190f..5d49c0c89645 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1062,7 +1062,7 @@ config ARCH_HAS_FILTER_PGPROT
 
 # Supported by clang >= 7.0
 config CC_HAVE_SHADOW_CALL_STACK
-	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
+	def_bool CC_IS_CLANG || $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cb9217fc60af..917c3bb6aa43 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -104,6 +104,12 @@
 #define KASAN_ABI_VERSION 3
 #endif
 
+#if __has_attribute(__no_sanitize_shadow_call_stack__)
+#define __noscs __attribute__((no_sanitize_shadow_call_stack))
+#else
+#define __noscs
+#endif
+
 #if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #else
-- 
2.17.1

