Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2599C7618D
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 00:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjDFAJW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Apr 2023 20:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjDFAI5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Apr 2023 20:08:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0B134
        for <linux-hardening@vger.kernel.org>; Wed,  5 Apr 2023 17:08:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o11so35991788ple.1
        for <linux-hardening@vger.kernel.org>; Wed, 05 Apr 2023 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PneGamL/mgm+LpVlf2vTq3MuyA+fcdySlbCCimj/eTM=;
        b=W4BgfyEWUsaBx+vivd2BLpkQi/WGqzeS+VVula1M+B91wAnaQaALuUOaa8hKiLd4nB
         LqiTn5zkTIB85QCcdYl/L/UwYX4Q39T5EvRlreapcfypsJR4buVcXpOQmpe9pyXP4ZTc
         K2VwuYVzEvRLWOcfVDr1/xS4PoWZgLKDLOg/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PneGamL/mgm+LpVlf2vTq3MuyA+fcdySlbCCimj/eTM=;
        b=ti5Vpi6UCQTtiRCaagDUgs3OcEr/u1qstBJVqbAWkvkaMW170wa93Pd+hX616xOn0A
         Ewh6EI0295aoti45Rhz3K2QyYRFV5d23uXh4ApQZjNAoYbXlTWtNCBw5TF2MDsuuKn/i
         Lr63Yyb9Lu3SjnL4F/ff5yn0b4utdm4b0xAvnTINKkaNeRXSqGnd/JGzCtAYqdu8d3iF
         mH5O1M/yjbgat6vL9kday/17vXim3e1K85Y1s/d0a1Ah4n90mreSr5fK4s2NT6fZVhJa
         /qwBa9gGwVqaoKuzcLvm/QP6roL7fckT8RkDRKPCIZQF6D8i36mVHCHPpcTD++Kp050X
         ijXQ==
X-Gm-Message-State: AAQBX9dd62CImZ0k0Bq/dRnriJqq/nIlEERYR5BZuvKbMCkL+WzJkUPF
        I9M4N0IKSc3ZOHCNA21xoIgo0g==
X-Google-Smtp-Source: AKy350bYrY3LXp+tLT2F2M6EDrbqW93W3G0pJujFJ65kTJO2hzuYucdaHMEdU7U+ZpyMcR9amj+Irg==
X-Received: by 2002:a17:90b:4d05:b0:240:9e3d:d532 with SMTP id mw5-20020a17090b4d0500b002409e3dd532mr9052093pjb.8.1680739735192;
        Wed, 05 Apr 2023 17:08:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kf7-20020a17090305c700b001a06b33923bsm93820plb.164.2023.04.05.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:08:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 2/9] fortify: Allow KUnit test to build without FORTIFY
Date:   Wed,  5 Apr 2023 17:02:01 -0700
Message-Id: <20230406000212.3442647-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=keescook@chromium.org; h=from:subject; bh=SpdgFxHiZ4ARZf+4i1NeU7Y8FK+0OW7wyr+j9YHonQM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/+oSAYnNTJZYXyeczo+2pwrJiX+S998cIveOx dv7sKJaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJnxJEA CNJYzScMB7ymRkvO6c4S//HNJjuM0W5yyy0EvjjCUlx+L8sCNKXmdALc985icEfYzfD5K8vw1PRXX7 C8uiv3CUHvw2fVT6NTmm6CdrXNuNUcMHjoSEOkEAJFarAGJESKN4ypcJPmvyTozFIvWoKkftYd1KhH dobf/C5zPIXz88aI44knQFGTZE/z5uyP4dGtvp9Sf64lU4+MnfWbZkPE4MWUVuk7lnPpE5MEKQ1Yqe yI8e7XFRVNCDXgoY0ltDMizSrwjG5DyBONZA1/OrBczdieYgJ3/MycxAVBWNbG3QQpCW8iY0ALx1mo 8j2wQ6/IT7Xxyurhz/hcpPX9OqCnTz9gkf0lCX60Uju7iPFRC9G3wYJ2MTHVAbn4E0Vv3cWkZhmmpe AQPx6KAMIj09/u6UyAf2o6FP3j6K0vqCq1ZfSc5c2yNuoihFq8XOmeKkBZLFJ8tOnY7tdZcArLbrMA chRKxelhk3wW8wtvC22yNIlNpH8Y35VXuQeJea8Jarrr1kYRPPQENEMwzPEKb442KET5sIxAZtZQRw TUblyPfA+RF3czGsvA2osA4DnJqsXoSYOR3oZ44qJMvjsglAdBFVBkoK/znA2MOL4ocWT8N8/qcluK iWvxlRaHFVkdmNeGPO3FL7lUDKnxNB+LigII/C6c9r1SNNqxfRqz1GjaX08A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <kees@outflux.net>

In order for CI systems to notice all the skipped tests related to
CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
with or without CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 lib/Kconfig.debug   |  2 +-
 lib/fortify_kunit.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e2e9ad..d48a5f4b471e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
 
 config FORTIFY_KUNIT_TEST
 	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT && FORTIFY_SOURCE
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..d054fc20a7d5 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -25,8 +25,21 @@ static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
 
+/* Handle being built without CONFIG_FORTIFY_SOURCE */
+#ifndef __compiletime_strlen
+# define __compiletime_strlen __builtin_strlen
+#endif
+
+#define skip_without_fortify()	\
+do {				\
+	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))	\
+		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y"); \
+} while (0)
+
 static void known_sizes_test(struct kunit *test)
 {
+	skip_without_fortify();
+
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
@@ -60,6 +73,8 @@ static noinline size_t want_minus_one(int pick)
 
 static void control_flow_split_test(struct kunit *test)
 {
+	skip_without_fortify();
+
 	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
 }
 
-- 
2.34.1

