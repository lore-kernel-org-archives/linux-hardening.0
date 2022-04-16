Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41039C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Apr 2022 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbiDPANp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiDPANj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Apr 2022 20:13:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE640A1F
        for <linux-hardening@vger.kernel.org>; Fri, 15 Apr 2022 17:11:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 2so8670896pjw.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Apr 2022 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9A2UwyUMqwygyoJjKT656y509wusEP5iGkP41Torw0=;
        b=BHjxNl04owpqw3Xc5tPjdyKb0CiRc9Zd9G5BUfSQoIep76U39rYqMnZtGsjNHN0UO1
         7X71aaw06/vmCfyHdTxIWimQ+nbafYYMFGQMH9E3TqH5HRTU9N6gqaHXDA+EQvuZRCmA
         fWY3FEvdKu7zMHrCs/Aai53MuX/OnWAT1dT9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9A2UwyUMqwygyoJjKT656y509wusEP5iGkP41Torw0=;
        b=ChPzbJu6pwjegBugAoYFbVRkpZEWypjBO2FDQPg6DgjUKRYQlAM393IEgemDo4ALWV
         DwtsFpbYqBsjAoH4po2f94JmHjR4WeSaruKK/Nhw5gZhrbGhXk6MzJh8eOtNwVc5gaeY
         7Q3Vq+NSyea9IR9X7JJxjPSwV09VXZzg+tO2E+X42gE8E4u/vjytoezMqVjnA94iH7pP
         UJzNT2DBgYdt/nQ796FpR4Ys0hcIF0HygabloZVrA0X9rqEtReg8X1h2FHdLAW4woOY7
         m9WCjhDIA6k+wmQuIdjtWXWmLJBxYTaCreruO2HZ+PLWFD7X4nbq864rS89pVBgy8FmB
         /ulA==
X-Gm-Message-State: AOAM531LtUdQB1jzxU5rOce2IMz47NJN/6KyC5S/cqP8w9Mg0PzpS0bb
        efvC0fCqDLvRiDCSqTEF5Q3j2w==
X-Google-Smtp-Source: ABdhPJztfkKbbYOzHuV4ywguTXh8JrEOGpO4bADO/zbJZZp6+kOAThSrng4JJnpRwq1eMOQlzY+9DA==
X-Received: by 2002:a17:90a:b890:b0:1cb:7ef2:8577 with SMTP id o16-20020a17090ab89000b001cb7ef28577mr1391403pjr.45.1650067868693;
        Fri, 15 Apr 2022 17:11:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm3758104pfl.164.2022.04.15.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:11:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Date:   Fri, 15 Apr 2022 17:11:03 -0700
Message-Id: <20220416001103.1524653-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371; h=from:subject; bh=P0lromEbkrJsMuNXkOggmhDWxld/MDuTK/Fe3Sv+Cr0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiWgmX+W6aixof+zlRev5a6rwcYR8x7Jptuscn8CSd wva6j6eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYloJlwAKCRCJcvTf3G3AJlRMD/ sFgNYH6PPPEC/1y0stBteH3Jjul9osWbO0vHLgIUCFI95t1jCMdc9g+vX1QGNuGFbwEY5yz6HRu4U+ Pl3bVcsJG3wawcd0NQrClaKPQu/trhiQogvxPJOUThNnobxMVw9OEkkZ2hdt8oM/eKzH0uQ50fUEA4 xvKNFimHtZ1t4WjhwF2n+AIactjClcgnVkHUdMk8t6SMTAxnsCJPnlBfr7J+3QR/9lHmmpZPBbjk60 C5dyXcfsH+6tmQCntn4hQWibuQPK5NjXIGgTgyEYwayIyPbH9kW2JX0HF/9KDI2gOIFtiJlRBbyQct ahx4CQ09SVZRKUVwhyZPCFZKR1SSexx7Izvit6UxyzPynH15vpDD0tIqQVIlMMTRyFkHbUKclt4wyM YP+C/q9V6S043ZtvwSi73giG8EOsrKTmvtqDKeXo9gWs/yK96qFEDY5BD/OaP5uhTAla8Sd5O650Lb xvna40gkXwOW/pSSbXotgssRRKUyPfnRShxrw9ClNx89KHOrny0/CKCxCFHFmBeIn7AhKdSDRf82F2 8spPk4oF2g2Ms04xcn5omkHtlzlFLGVNE7kxjVnGfWBTHhZbyjzaiQiN8E3mrkbDiCXtdW5wC2E0xh SrVOF34rhTT7XZDIFxctbMSim3Po5MNfQLnao4xMt1EVJ/ED61J2FQGIcXeQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to test various backward-edge control flow integrity methods,
add a test that manipulates the return address on the stack. Currently
only arm64 Pointer Authentication and Shadow Call Stack is supported.

 $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT

Under SCS, successful test of the mitigation is reported as:

 lkdtm: Performing direct entry CFI_BACKWARD
 lkdtm: Attempting unchecked stack return address redirection ...
 lkdtm: ok: redirected stack return address.
 lkdtm: Attempting checked stack return address redirection ...
 lkdtm: ok: control flow unchanged.

Under PAC, successful test of the mitigation is reported by the PAC
exception handler:

 lkdtm: Performing direct entry CFI_BACKWARD
 lkdtm: Attempting unchecked stack return address redirection ...
 lkdtm: ok: redirected stack return address.
 lkdtm: Attempting checked stack return address redirection ...
 Unable to handle kernel paging request at virtual address bfffffc0088d0514
 Mem abort info:
   ESR = 0x86000004
   EC = 0x21: IABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 [bfffffc0088d0514] address between user and kernel address ranges
 ...

If the CONFIGs are missing (or the mitigation isn't working), failure
is reported as:

 lkdtm: Performing direct entry CFI_BACKWARD
 lkdtm: Attempting unchecked stack return address redirection ...
 lkdtm: ok: redirected stack return address.
 lkdtm: Attempting checked stack return address redirection ...
 lkdtm: FAIL: stack return address was redirected!
 lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y

Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromium.org
v2:
 - add PAGE_OFFSET setting for PAC bits (Dan Li)
---
 drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |   1 +
 2 files changed, 135 insertions(+)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index e88f778be0d5..804965a480b7 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -3,6 +3,7 @@
  * This is for all the tests relating directly to Control Flow Integrity.
  */
 #include "lkdtm.h"
+#include <asm/page.h>
 
 static int called_count;
 
@@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
 
+/*
+ * This can stay local to LKDTM, as there should not be a production reason
+ * to disable PAC && SCS.
+ */
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+# ifdef CONFIG_ARM64_BTI_KERNEL
+#  define __no_pac             "branch-protection=bti"
+# else
+#  define __no_pac             "branch-protection=none"
+# endif
+# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
+#else
+# define __no_ret_protection   __noscs
+#endif
+
+#define no_pac_addr(addr)      \
+	((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
+
+/* The ultimate ROP gadget. */
+static noinline __no_ret_protection
+void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if (no_pac_addr(*ret_addr) == expected)
+		*ret_addr = (addr);
+	else
+		/* Check architecture, stack layout, or compiler behavior... */
+		pr_warn("Eek: return address mismatch! %px != %px\n",
+			*ret_addr, addr);
+}
+
+static noinline
+void set_return_addr(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if (no_pac_addr(*ret_addr) == expected)
+		*ret_addr = (addr);
+	else
+		/* Check architecture, stack layout, or compiler behavior... */
+		pr_warn("Eek: return address mismatch! %px != %px\n",
+			*ret_addr, addr);
+}
+
+static volatile int force_check;
+
+static void lkdtm_CFI_BACKWARD(void)
+{
+	/* Use calculated gotos to keep labels addressable. */
+	void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
+
+	pr_info("Attempting unchecked stack return address redirection ...\n");
+
+	/* Always false */
+	if (force_check) {
+		/*
+		 * Prepare to call with NULLs to avoid parameters being treated as
+		 * constants in -02.
+		 */
+		set_return_addr_unchecked(NULL, NULL);
+		set_return_addr(NULL, NULL);
+		if (force_check)
+			goto *labels[1];
+		if (force_check)
+			goto *labels[2];
+		if (force_check)
+			goto *labels[3];
+		if (force_check)
+			goto *labels[4];
+		return;
+	}
+
+	/*
+	 * Use fallthrough switch case to keep basic block ordering between
+	 * set_return_addr*() and the label after it.
+	 */
+	switch (force_check) {
+	case 0:
+		set_return_addr_unchecked(&&normal, &&redirected);
+		fallthrough;
+	case 1:
+normal:
+		/* Always true */
+		if (!force_check) {
+			pr_err("FAIL: stack return address manipulation failed!\n");
+			/* If we can't redirect "normally", we can't test mitigations. */
+			return;
+		}
+		break;
+	default:
+redirected:
+		pr_info("ok: redirected stack return address.\n");
+		break;
+	}
+
+	pr_info("Attempting checked stack return address redirection ...\n");
+
+	switch (force_check) {
+	case 0:
+		set_return_addr(&&check_normal, &&check_redirected);
+		fallthrough;
+	case 1:
+check_normal:
+		/* Always true */
+		if (!force_check) {
+			pr_info("ok: control flow unchanged.\n");
+			return;
+		}
+
+check_redirected:
+		pr_err("FAIL: stack return address was redirected!\n");
+		break;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL)) {
+		pr_expected_config(CONFIG_ARM64_PTR_AUTH_KERNEL);
+		return;
+	}
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
+		return;
+	}
+	pr_warn("This is probably expected, since this %s was built *without* %s=y nor %s=y\n",
+		lkdtm_kernel_info,
+		"CONFIG_ARM64_PTR_AUTH_KERNEL", "CONFIG_SHADOW_CALL_STACK");
+}
+
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_BACKWARD),
 };
 
 struct crashtype_category cfi_crashtypes = {
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 243c781f0780..9dace01dbf15 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -74,6 +74,7 @@ USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+CFI_BACKWARD call trace:|ok: control flow unchanged
 FORTIFIED_STRSCPY
 FORTIFIED_OBJECT
 FORTIFIED_SUBOBJECT
-- 
2.32.0

