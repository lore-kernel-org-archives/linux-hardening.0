Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F9C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Feb 2022 05:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBZFUr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Feb 2022 00:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBZFUp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Feb 2022 00:20:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC283201B9
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 21:20:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t14so3569435pgr.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 21:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJmu7tk8xpKWgNbS1VGsvLnHCFD03b7u0DqWAbwVAlY=;
        b=Gmaw4zGkCWLwlSAttIdxC2od4Vj4HVX00LVsVr4U/a2ha/XD/CS4LBGVL95CqESWvw
         +688rEm99/TrZ+Ah4nafBOrwfirz0zAc13OLS4cIJuo06p/A/vekT1ks1zI6kFxiTeoQ
         gf1P714kaAkMMDvEyaEy2T5ANb8hf5gXc/kFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJmu7tk8xpKWgNbS1VGsvLnHCFD03b7u0DqWAbwVAlY=;
        b=0K9HsVCnKuT5a4XETKIEDFnJGt9REOX2wQJ2tDql74OpN1D7XqZf274z7ZuyLLdxTg
         iftm75SdMV6KKp//k1lyBZVx8+3FgcpA3FGojBcF2XYFE4YS1EaJ9+Cr3UqsOB6pALGM
         2/RE1bs+1S0RiMHhKjRR1SGNIC3s5795COp7bFspGvH7czm8HE6mzxpx9Bqk0lsq5xje
         Ss+f3XayL0VylnKElOrM8Y50BU/RXtzskLZZNpdfj2pEPTfoVC4pCvq1vl8fo19HecX4
         MmkpRJV34weoxrTEPkQ1bbA8DSzgcHHVBOZha2Y2s3WBA6LYRrqoIURCaLsKCjpmZ3QA
         RH2Q==
X-Gm-Message-State: AOAM532XLnh1oYWhs9hKsDBl//sucoNLtK/zJoqpXtSUHQOG7aK2olNk
        xuwmKFq395xYkl8m+lmTCl6Rmw==
X-Google-Smtp-Source: ABdhPJxarm99G1J+berVF4Ui2IyEN1x3MoJnP2vQxP2xgKS+tGux0UIJeF3jiNPjtnHqtgwO+epytA==
X-Received: by 2002:a63:d354:0:b0:372:fbd2:a22a with SMTP id u20-20020a63d354000000b00372fbd2a22amr9001809pgi.438.1645852809965;
        Fri, 25 Feb 2022 21:20:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a00218700b004e0314bc83csm5155739pfi.139.2022.02.25.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 21:20:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] lkdtm/usercopy: Expand size of "out of frame" object
Date:   Fri, 25 Feb 2022 21:20:08 -0800
Message-Id: <20220226052008.3553312-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; h=from:subject; bh=kFzk9pTiN2SY6j6CSIXkIcPGBQLKynx1uz4PRq5mvTA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiGbiHPaLYl3NPgM80Man7jeQWKmN8DZ32AOmZzQYy u7RB/LyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhm4hwAKCRCJcvTf3G3AJinXD/ 9xQWn64MIPxSJenCXyfRMp/T7pe3T2i/c8G4HgUibyb4FRosmcyX7s9bZ1SKvaHmAcITVjX1T8KV9W XmzN09iuVHYEC3Eyc+Hb87Wqr/U3tIPz0GXDeeLNYV6Sxb33o/zLcbyogtZSG7AazS30+mTdcyVc7G 81iDM4EBPopkwyb5Bk7xFG86CyemUwgiJkj0yT0jgvI0QUt+Q0aTIS1VfdbHq5esCV4ILFKQjtrBTx 7aI+KSV9AR+dQsYfDtbBW/o7x+gmZnNv3CuVXREfNE/RrHfyVclN+Z/LcPeBrEHUqh5hxgY/Vkd3uU UJ1QNjrmNhLtZTgWdzi8s4ayd96S/Zwnc9yoE2ybcjf/WzTTh3bXroNTZE0FP5vqHIF/TFKOBwcGzt oESjCjpJnlHvzaWnaiEJoGY4SYM1wobcg2gwwbAHbPpsS+92j9xb776ISKRp9uC5kcvbfN9WlVyjxM 258YUjONvRotGy7dPw/aoPYIHUvg0WvkcYhy01fFSJ/vwdhh+ciBlnB4rBcmVeiX9pI44Io6km9vzr I7XTSXquZP3AheCfPIUchHc2bQIOSBq0nFXutfLdj6yUfOreCpXEhjjOMwPgS/2Q0ztjVx4zzSrO+D WK1bQVoUyZK9dGJSpvZEpYs5xxLJrPbdjDpXaszFeeyM6/Sv3/la88vf/erg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To be sufficiently out of range for the usercopy test to see the lifetime
mismatch, expand the size of the "bad" buffer, which will let it be
beyond current_stack_pointer regardless of stack growth direction.
Paired with the recent addition of stack depth checking under
CONFIG_HARDENED_USERCOPY=y, this will correctly start tripping again.

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/lkml/762faf1b-0443-5ddf-4430-44a20cf2ec4d@collabora.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220216201743.2088344-1-keescook@chromium.org/
v2: check for ARCH_HAS_CURRENT_STACK_POINTER (lkp)
---
 drivers/misc/lkdtm/usercopy.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9161ce7ed47a..3fead5efe523 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -30,12 +30,12 @@ static const unsigned char test_text[] = "This is a test.\n";
  */
 static noinline unsigned char *trick_compiler(unsigned char *stack)
 {
-	return stack + 0;
+	return stack + unconst;
 }
 
 static noinline unsigned char *do_usercopy_stack_callee(int value)
 {
-	unsigned char buf[32];
+	unsigned char buf[128];
 	int i;
 
 	/* Exercise stack to avoid everything living in registers. */
@@ -43,7 +43,12 @@ static noinline unsigned char *do_usercopy_stack_callee(int value)
 		buf[i] = value & 0xff;
 	}
 
-	return trick_compiler(buf);
+	/*
+	 * Put the target buffer in the middle of stack allocation
+	 * so that we don't step on future stack users regardless
+	 * of stack growth direction.
+	 */
+	return trick_compiler(&buf[(128/2)-32]);
 }
 
 static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
@@ -66,6 +71,12 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 		bad_stack -= sizeof(unsigned long);
 	}
 
+#ifdef ARCH_HAS_CURRENT_STACK_POINTER
+	pr_info("stack     : %px\n", (void *)current_stack_pointer);
+#endif
+	pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
+	pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
+
 	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE | PROT_EXEC,
 			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-- 
2.30.2

