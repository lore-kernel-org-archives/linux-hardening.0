Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B4C54EE9
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Sep 2022 18:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiIMSUP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiIMSTw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Sep 2022 14:19:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFB11836
        for <linux-hardening@vger.kernel.org>; Tue, 13 Sep 2022 10:31:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so12551812ply.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Sep 2022 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Gw0b/81HfJ5tL+5LyBxFbpOnUFRI9K6fakOJwgdIs4w=;
        b=L/oqvvV6GOLA1AiyhHGZl5HHSX6HegtB0t/8UtsP/YHCaFwH7cWF5SpmdWwRqigHnD
         rHbIidBu/xcmFbrHUWVkzxrLS4BadO+8BSR+/u9V12SsRldZIpeXH9dDiQxm49TRaOUP
         UV+V2bgYOE+YruaDs2eV0GMSqSL5Z3bJibdjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Gw0b/81HfJ5tL+5LyBxFbpOnUFRI9K6fakOJwgdIs4w=;
        b=XWOl/w6GAXhEhrt3l3rTmLzwglm7/cZskpIAAgKj4mIDjSdSf33cVvDMl4GD6AL7/A
         To+O2pf83Uvy+LIrwcI5K6Nrm8ksJJsqwwPVPzyF9hEKkRfoiFrujdyKBJUbe7YHDz9L
         LxmKjvty9dmFT9B23HGNOSNknmjcYUMs786Gyb5pMKNjaKdbH+Ls/FZLnl/7K9BwomXQ
         PuN5Xi+cUs5N0spqBEtDncxVnHGKSPM415KjDIfdUuVdwW3h578niuLcZ6j3AREC5IkE
         Ng0IiucXDEDk+DSWp3GCfLEPveGbJ/muKloDhHHkZvx7OQ7e5QqV0F3LZZfVhRHQ+tez
         Us/g==
X-Gm-Message-State: ACgBeo3A7/Cn4Y+wxvNwIFo3sV8GvlSIeSh686o/OBtbeu5t9MhtD14r
        nphdht04BdWfi0GRgU/nO+Qf1Q==
X-Google-Smtp-Source: AA6agR7epHxme3Qu6qPXLD/c5OHjVB8E45VPdhCLrqtLAHcFdhR6bw+VOK+ulm5XxPOfDDqRx7qt0g==
X-Received: by 2002:a17:902:d4d2:b0:178:491b:40d with SMTP id o18-20020a170902d4d200b00178491b040dmr3658887plg.79.1663090303562;
        Tue, 13 Sep 2022 10:31:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c199-20020a624ed0000000b0053ea0e5556esm8145068pfb.186.2022.09.13.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:31:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Adjust KUnit test for modular build
Date:   Tue, 13 Sep 2022 10:31:36 -0700
Message-Id: <20220913173136.1926909-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; h=from:subject; bh=DVKixzI/1Uq9/WcWKrACKKNlNlq3870R18e1hHH3W/s=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjIL538mxMOqQRTEL1TpLdBSueUkOmgI4R2uu80ed8 u7VM+fuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyC+dwAKCRCJcvTf3G3AJgFrD/ 43l3P5+2WCgY4LemxD7cZFJj22YwHfA7mLqBfkLnb/yOQpYk3WMvFc/x29tLsf/amlNX4E+oR871DU YCDueRMLNaNUmQo9IKyoK9kvbW3+vh5OqHBaM95S3y9FFPV3n1l/AFwwOU5b+Hq26k6bqLXM0ChGN7 qUeO5KajI4lsL6YuQfPr5wwxeB34ki63D0qiJYjJA5yKSKdko/aklacyY0Y4uNqT7FgF3RWpMSe50c AtqpuXhnvrfcC1It2EsV/ncAE4vjagxczAIMlZZHk+lkL0x22ukZZaeRm5TZQajnjBXW2xj5xsvc9s Du8SZ9l2Qlk0YVyMdXD6PvlFGvihKh6j+Bp8OaTej8ln1s2eFe7hRq0GUZaYgEoRamihHNPFvo+Wkt EzK7fy7Tnezck711uNYYinuhTX9pjvWpLGnloCTO7ph5XBdqI/s2GGMnLoOFICnVRXhci/1046+jSx P7+VJNLFnffcdHFbIb5OUZTKN6xuIY+0LRYK4BlEU9a9K7FMHPM1BfjYXvreOA9UDyw0jBAw2TdK1j 4SPRnGI5G67MRMcvaEDkkQFYX1xOYUAVvznJ7iSRHvT3nBcuCgk3Wbe2nGDD0P6/MDSDNsZ4u3boDj hZwOEBbRA6S57fZSFTBoTGw9xL58HJcq5AxwIH5r1ZHWPaM9MJWDjfWvqI1A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A much better "unknown size" string pointer is available directly from
struct test, so use that instead of a global that isn't shared with
modules.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/YyCOHOchVuE/E7vS@dev-arch.thelio-3990X
Fixes: 875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Whoops! Thanks Nathan! :) This fixes it for your reproducer.
---
 lib/fortify_kunit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 99bc0ea60d27..409af07f340a 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -17,7 +17,6 @@
 
 #include <kunit/test.h>
 #include <linux/string.h>
-#include <linux/init.h>
 
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
@@ -31,7 +30,7 @@ static void known_sizes_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
 	/* Externally defined and dynamically sized string pointer: */
-	KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
 }
 
 /* This is volatile so the optimizer can't perform DCE below. */
-- 
2.34.1

