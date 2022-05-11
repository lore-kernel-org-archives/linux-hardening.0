Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D27C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiEKRpi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 May 2022 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbiEKRph (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 May 2022 13:45:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BE23725E
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 10:45:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r71so2079428pgr.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHf7ZrAH4PrrfQ8X/4WpEmrRmE9+0nPRk+51k/x4Pg=;
        b=TOER+O7VaqpBhXcNlHd69BxSLKP+mAQh8v/s9TpZa5MJTiTfWMTtNofMl4X86hWtdA
         aPmvvUYQRQJdHmTyWI89bnCpOvtfxZwn0x/6RsNJNuzpcAVLrRr0VM+iyn4o6TRPTO2N
         caIzydcLfDBFP7zRqTvpCBUvGl9MlTlQAA8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHf7ZrAH4PrrfQ8X/4WpEmrRmE9+0nPRk+51k/x4Pg=;
        b=2L6X9b3r+J/jENwAiDgJLkr6knt+MlzgqJSaGRlRm4ko2Rnf6Ha+sg1WWEWh7ncXs6
         cP1nHPjfWHmkGw24oswqaFXuwVMf6XjfUKqnfhFIQxnja6Q3NcCAQFab6OCXQFx7/QIx
         UVLzzWGb5FQ1B1CT9XmiyHdPdOSb2mVn2EV22us4YD8xnJl0QKOMu8C/lyz15ix9HeXe
         hJRPuVdXNLE7luY1k/aej7aiv+GJpDuRNd9BZ2S+L3MtEc0nEaff40Sspk8JF/+dessC
         wX5s1Q4n2WVRqXnvABjEOrAB999J3vlQswKidarjaH9nPyVXZ5+qR/NfxhXNh6vtmJX4
         x4vA==
X-Gm-Message-State: AOAM531JYiXkndsrgRpVvN+GttBxYE5/u9hA94hR4v2Cq6v66O8gptg7
        MMtrmGAMO7Ru8w4/3791PgzJag==
X-Google-Smtp-Source: ABdhPJz8MafUMLMmiPh2TPfTHw+Wd/WkD7AI9rIG8ZDT690/r5bid8PrhndlVGg4fTtJglDi1J+jFg==
X-Received: by 2002:a63:cf08:0:b0:3db:2558:aa66 with SMTP id j8-20020a63cf08000000b003db2558aa66mr3459845pgg.624.1652291135961;
        Wed, 11 May 2022 10:45:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k125-20020a628483000000b0050dc7628193sm2081797pfd.109.2022.05.11.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:45:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lib: overflow: Always build 64-bit test cases
Date:   Wed, 11 May 2022 10:45:31 -0700
Message-Id: <20220511174531.1098548-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; h=from:subject; bh=eiJn2Wl6nc4704YmTbh5pwPU8pZHWuWKyERY0Sg+mvo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBie/Y6HZp0vOkkjoDe+KyAaUAbsvxybtXQniz6E1rE zafXUnqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnv2OgAKCRCJcvTf3G3AJm+tD/ 0R/7Mm9NFYf2jEkB+SGZEyGUFEXJAnhj1jGXcuvzuiJfp0DHrTx1rIYF8Z4/UMVyKRc8BQlncO4aaY Epq9sEMb3DHlLd2gSF2p/ZWUxYTagcF0+Lt0pxFAUdZkXBzUSoJsMLsNjmCKuhzgAUJxIK4cKcnyWX mA0PLfg0p8S4XK+PFBw6IILtM0IVNH4fcJk7Q2TLaIB1YRrBrq61CVzQik0WY3jaydlKNNzq6Bz2i5 9sc9Aq+/aNTiEJ+1CNx0rVKfs9ooBkVyZgnLRawZPk/ECQNCLWgIIMn/wGpY91P1HarD7jBOUHOB0Z IMZWI/ivmPjDOjZ/EkuVCF0ukMXUmSYW8bwP4xlEqAKCdm3JG9aczfcrB+3OX4O7GN9bv2qT8u0GyU t95u8p9wOmirGCegajZg2uKy2mVv7C3M+YNcpYaBP6ftFZCgVfhFhFXqCLN6F0BPHVzB00yPa/K08d kfompYhsOTwGfkhCxlIGWcAyXW1gGEs7grESyA07sUc6K7+S6rKvRrRgLeaSAYgqVoCPdL36v0TaXI MTeEPmi7IgkGwJ7ezQcWlZyJkp6VYQFIWl0XelID4cAsZDjFmLVgOtGGxmONapigzIeSzhvV23ewgb zBojb9InwUHwvxauQ51nlBfm0JBv1kmw5z/WGgx3HOcXNllz3IT5JPkHQqzQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There shouldn't be a reason to not build the 64-bit test cases on 32-bit
systems; the types exist there too. Remove the #ifdefs.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vitor Massaru Iha <vitor@massaru.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 475f0c064bf6..ac37bb543476 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -255,10 +255,8 @@ DEFINE_TEST_FUNC(u16, "%d");
 DEFINE_TEST_FUNC(s16, "%d");
 DEFINE_TEST_FUNC(u32, "%u");
 DEFINE_TEST_FUNC(s32, "%d");
-#if BITS_PER_LONG == 64
 DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
-#endif
 
 static void overflow_shift_test(struct kunit *test)
 {
@@ -650,10 +648,8 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(s16_overflow_test),
 	KUNIT_CASE(u32_overflow_test),
 	KUNIT_CASE(s32_overflow_test),
-#if BITS_PER_LONG == 64
 	KUNIT_CASE(u64_overflow_test),
 	KUNIT_CASE(s64_overflow_test),
-#endif
 	KUNIT_CASE(overflow_shift_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
-- 
2.32.0

