Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40BC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 08:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJRIdA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJRIc7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 04:32:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A21DF11
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 01:32:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p14so13451472pfq.5
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMgE1fyjrJY9vSnvRMz8bHn2yTvJe/km5liUet6OTaw=;
        b=YgTkaHRPQjsBsJNUHrik4HbQBzYewWyJ7ySyGTgdQ8p8w6U6zCfhpcFzjvfV59U62P
         3Da9gAOT1L3WBT5PcqX0ssxUuWmOH60c71ylOkujiiZ20i/VeNuvModSnHqPKb6nc5ZZ
         v/0FB6LL552bfW/aftPKoFJRAHyWo6Sg34ht0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMgE1fyjrJY9vSnvRMz8bHn2yTvJe/km5liUet6OTaw=;
        b=kdMLEYFpddCPCFFJOtS+nxcSgJJd/UkSoBwPyhgS/8B0k3pp7cakPiwjhxjata/slO
         06qA19xcT0cNFPy9iGxhEDXj+hJuz4B3TKIVPlUBpUJaGiN/Og6P/THT9qXnrtpmO2c2
         UlbCm245Qt+W2AwWDDGs58jMUU8Vpl4m1LWo5y4MHNKUWDLHo4RAzllQNE/jI9T4hScv
         HOmTgT9omBzCQ7LavRFkERzOffCuOfnPHwY1WiQvaos2DN2nlMOzOGIo+7kCGAf6C9ZG
         /5e4GTpxI6Ap6jx2V3TxYhncEOpDq1HTlh2xjPLTUkm7lAIvSr5ehSC5mbEAkvAcv2MA
         5kJw==
X-Gm-Message-State: ACrzQf2vRkFbhaW74juC9pm6QtQiTYnx/BrRcLuAedc1uY9+k7VWniZ5
        MyVaLCzNyYP8Iw4uY1SfqLelbXnprzEdzQ==
X-Google-Smtp-Source: AMsMyM5vFszCXPViIzTCoQXJeqBBtRWDaVBsj5nCFCpJrmEX5X5wQFGFwCc7yT0rI3q+/X3a4I9Bbw==
X-Received: by 2002:a05:6a00:238d:b0:563:b212:9257 with SMTP id f13-20020a056a00238d00b00563b2129257mr2052202pfc.21.1666081976812;
        Tue, 18 Oct 2022 01:32:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a1c1000b0020a81cf4a9asm11077191pjs.14.2022.10.18.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:32:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Short-circuit known-safe calls to strscpy()
Date:   Tue, 18 Oct 2022 01:32:51 -0700
Message-Id: <20221018083051.never.939-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; h=from:subject:message-id; bh=TuV6DsCHn4YM1pzSIZxk5kOcXo+TKcB3VVIFFMdDAmw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmSy9TMK14Z6uFIMcZ/T8ujj2hXR4Xr/JigD6sMv 42vJH2iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05ksgAKCRCJcvTf3G3AJsPHD/ 9PrjfaHojf06MfJOXnvTmaDU+LsTURln+B94F70PVDLDd2Dav7dKtEGqNxJuG3bEbC6c5oEREbdQXK RrYPH2Wx5O8CtmmUwkaSiYIjjZc5y7Y3CfO2dbjGBNiFYD2jWESj5dkgWJLbibCkVHtiSGIoBO63oE fICz4Gy2XDEfxp+a2fPArCNgKzXW7QU7OBNE/2VdFn6mbVrCJhSZdhOKlS6HOh+IE+ma4n6dYL0IB7 e/MHsdfllNhhxqZa36zBSWiq6fz4DJjUJ4V7z/WQ4Agsj2mjiGVDSTM8MD8SII9Jz4Uh9TJmvnZExd SjY8asnB9rEAS3FXN+DQbm87gFf2jtHZOwOWs6klYMkR6cBtBsJ+OUM+FTzqOtfmlv0IQd47QraSFx Vr8GiqaOY+Pn9G/Rjpb+rjIFeJ4YMiY/lEia9QPmxU36+ML52uBrhAlNe/QsAVCXdBzZ500FRIIu/d uXFSZfQfoYkf8+mTlUo30HujO84nZ/0JVpYarc/JbJLynPuBQPsG0PGCoGJyA2/M3ZBiL8DF20TdXg x5JsNVPwhpcJOklcCegGs7A+kGhW6kvKCxOpEa99xZYzhSy3ozTqvxOY023eMoIcEhAwCeDxVVojFf NnVntHm6jMPdmeR5EH0vHa0d1lMBerG4BgLsbTXcTGmmSVYjBZWvusnKSSKQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replacing compile-time safe calls of strcpy()-related functions with
strscpy() was always calling the full strscpy() logic when a builtin
would be better. For example:

	char buf[16];
	strcpy(buf, "yes");

would reduce to __builtin_memcpy(buf, "yes", 4), but not if it was:

	strscpy(buf, yes, sizeof(buf));

Fix this by checking if all sizes are known at compile-time.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 10 ++++++++++
 lib/strscpy_kunit.c            | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index aa1a50009632..c473adb55cf5 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -321,6 +321,16 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 
+	/* Short-circuit for compile-time known-safe lengths. */
+	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
+		len = __compiletime_strlen(q);
+
+		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
+			__underlying_memcpy(p, q, len + 1);
+			return len;
+		}
+	}
+
 	/*
 	 * This call protects from read overflow, because len will default to q
 	 * length if it smaller than size.
diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
index 98523f828d3a..a6b6344354ed 100644
--- a/lib/strscpy_kunit.c
+++ b/lib/strscpy_kunit.c
@@ -81,6 +81,8 @@ static void tc(struct kunit *test, char *src, int count, int expected,
 
 static void strscpy_test(struct kunit *test)
 {
+	char dest[8];
+
 	/*
 	 * tc() uses a destination buffer of size 6 and needs at
 	 * least 2 characters spare (one for null and one to check for
@@ -111,6 +113,17 @@ static void strscpy_test(struct kunit *test)
 	tc(test, "ab",   4, 2,	    2, 1, 1);
 	tc(test, "a",    4, 1,	    1, 1, 2);
 	tc(test, "",     4, 0,	    0, 1, 3);
+
+	/* Compile-time-known source strings. */
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 3), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 1), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", ARRAY_SIZE(dest)), 5);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 3), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 1), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
 }
 
 static struct kunit_case strscpy_test_cases[] = {
-- 
2.34.1

