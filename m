Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B2C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 30 Jan 2022 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiA3SQV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 30 Jan 2022 13:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiA3SQT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 30 Jan 2022 13:16:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6611C061714
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 10:16:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so10533899plh.13
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 10:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUTPHSZB8lKbcN5X9fQAEQY4eG+Q45KibRaKjR9V6no=;
        b=WaXYSnDMYgpE22YYEaBoUF7YsSe7hnZm7tnKIGeAEsUVMY6hSH5Bzp3DTKaEl3psPl
         TKW//C5ohyOn56iAkVs5VkrFeO6OZt30RN4Fh7SqKi9geea4xM0KgShQyxV3OH/Qi2cE
         6xgAm5wifa+FtPUzHgNuh39b8G8VcU09AxQnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUTPHSZB8lKbcN5X9fQAEQY4eG+Q45KibRaKjR9V6no=;
        b=tOfc1mnwWyMYTDmEO8NGEoLWOx8j4XfK4C6p79K2j1tLVqnFNnDL2WAclUa15FrN2y
         pjF7HHisf47M/IkbwK+YPmRRIoS4eLgF6rTcMI2dXx/Ht8lmnfjbW7XOiWKLSTXFOXjc
         kpM3P7X+u8YMOK2/CsSGLz0LMQbwimkgV1vlhTKMmmbcXyvIycXL2J7VwfX0/luUJRLH
         t71aESlcmhZBYLhkYju3rMMSyPMRbC4e9EBCTiz8QJXPFI8yiGl3PJXcs4rYcj9qtyaB
         re1X0OwQ1xIy329Qg4vOhB+btKyvpV0UNgvBTm3D607/7liAzJ/x+wx4AZSr0NcG4HGW
         iHvA==
X-Gm-Message-State: AOAM530u3sDn3zfHldRCttW+AJP3dsbKoQaRm4QNiqVB7EUKkaF7Qf8Y
        DcD37EuCfIXTGAO607Gfi1CoTg==
X-Google-Smtp-Source: ABdhPJxS922LSEar3e+IGrSkOBYeH1NhSt0ZrGNr3dMGmfn+eZwOxAz+RxlNe7MtT6+Uam14AY31QQ==
X-Received: by 2002:a17:902:c612:: with SMTP id r18mr18375513plr.64.1643566579258;
        Sun, 30 Jan 2022 10:16:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm15375579pfk.65.2022.01.30.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 10:16:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Update compile-time tests for Clang 14
Date:   Sun, 30 Jan 2022 10:16:16 -0800
Message-Id: <20220130181616.420092-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; h=from:subject; bh=W5hUpBKUYkAQB5mlGYXbErF7oKWbamcl0yA13kKO2Hg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh9tXvXjihVpXb0Nwyu1NPps2o/Jeb/lCTFL9m9CG4 95zfhcSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfbV7wAKCRCJcvTf3G3AJrG7D/ 4i3Q4WoYVqrk/BRG2DzTRezzBzFoNJZ43ZgWaSp90pdBsBvZvzlfZ4G1TIkiibm3YRwvyQoxholLoY nkojg5drZFsOGSPNNIZhbCCiubj1WYJOLFFPeixZrUtrjbRhJJWRJq9koNjSrwXQPorSO0z3wMmcY5 9OpWiRkfNs+uWuhanSLS2Klzn6HiMibREhl2anNg22uD5f0xrT6hyMGadKs/+w9td4A/qSOc1R4Z4A C9ajWqrvUi7fUh245VlKYs0rf3uR1dd8V8RFOoXJdoV3QL3JJa87wa75SzuRaOIbpRFlR0miluVRQJ +Y05pZN+uWn4UKhxXyYay9XYndRcOFRnBrloPhGtmSgfLWXjUu2zMlm4rIgHaWHofYRDhgR9/n9Bix 0BxRLqy2t9+YXrkTGmdn9cKL/xWsYaDHWXRkbhoNL8vRs8SflNpi66nLIlkKbP8ransSrLPZ2Dulzg th9GbOVQxNpURYVgrwyDQPyhUYdUIjfZfisJijaVa+3ZLx2T0mB4tGBljLpoTLdtOREMbFAGFlKyzy l3djSIwRISMUatteq7/Jh2C6W+2bwWLsbkMaVSx1gnbywpu1VW6KVSF0kM5Z1YZcR1v7VSkHM8C6lQ 132pCbTqvvXfb8QhLwje7/c+Fy548hbCWsFKFSHqfklj2Q8K7e+Le4m3srbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Clang 14 introduces support for compiletime_assert(). Update the
compile-time warning regex to catch Clang's variant of the warning text
in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm splitting this patch out of the main Clang FORTIFY enabling patch.
---
 scripts/test_fortify.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
index a4da365508f0..c2688ab8281d 100644
--- a/scripts/test_fortify.sh
+++ b/scripts/test_fortify.sh
@@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
 		status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
 	fi
 else
-	# If the build failed, check for the warning in the stderr (gcc).
-	if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
+	# If the build failed, check for the warning in the stderr.
+	# GCC:
+	# ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
+	# Clang 14:
+	# ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
+	if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then
 		status="warning: unsafe ${FUNC}() usage lacked '$WANT' warning in $IN"
 	fi
 fi
-- 
2.30.2

