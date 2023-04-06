Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9739C7618D
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 00:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDFACQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Apr 2023 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDFACP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F759D6
        for <linux-hardening@vger.kernel.org>; Wed,  5 Apr 2023 17:02:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ja10so35956239plb.5
        for <linux-hardening@vger.kernel.org>; Wed, 05 Apr 2023 17:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl4oifEwokFvb7UV+3PIm/IUduHGwu9hGuhtq+IOj7k=;
        b=c7cbXFjrLiWnvxHlZxDZRy65SnfcXBG7MdCPGJJ83MsAqWRNtFyns2n23kUsCLZ4hn
         1T6sKpu2EQkDDkQ+m4lUJDgXXOtOk/VsL2gbb+1TkufqBn5kU5ZaUZYe+ThMfK7bqEFC
         IfqkVj//dOEjYyHc7kOeioK5PrTiEFgxpKWAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl4oifEwokFvb7UV+3PIm/IUduHGwu9hGuhtq+IOj7k=;
        b=1RzdvGfaTQF2KhuyjDxjLM5/gVoPz/W/Hk4Dhjm0/wpcYT9cGWtwwbyNen/lSjn15S
         rt9fsKd29WCaNmsn/22kFBNH/85o9cFS9jL1olnj+PxNWsj1oLnugpf0EEnN06dADroT
         F6wHt8dCX/u3AnLyv/TsL4qCdLoxsRG9zl4g38+7iSmsbh5894o/7xMm7sOpsuihhpIK
         VMKu5vzAxSHjdtNSobIm/rdpRJ9ZmXBMX/GtZ7NxDHaCXebExZPs8cFuAcFrEoJbTpC9
         jP1y3XsRlLxOh4j9o7zbfEqa8DqMoa/oLyiWhH0XfDDx8JM6b7HzA328EiqmQQeWylYx
         HvxA==
X-Gm-Message-State: AAQBX9dpSuVOiQSI/l9jl/ssJh1JH9KzCFPkT5OH2YzFHzN4th6qZH/s
        LUFk98+t8Pf9a4vB8dIKdRqNpQ==
X-Google-Smtp-Source: AKy350by97Nmv8II4GIg/KLwtBFp+ZTS1qz68AIVZTb5hpgaSt6w6+s7Fz3PZ7U3GS1rlbLGdfb4/w==
X-Received: by 2002:a17:902:f685:b0:1a1:3320:be35 with SMTP id l5-20020a170902f68500b001a13320be35mr4569828plg.29.1680739334558;
        Wed, 05 Apr 2023 17:02:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b0019aa5e0aadesm94957plb.110.2023.04.05.17.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:13 -0700 (PDT)
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
Subject: [PATCH 1/9] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
Date:   Wed,  5 Apr 2023 17:02:00 -0700
Message-Id: <20230406000212.3442647-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=keescook@chromium.org; h=from:subject; bh=vJg4ej+0zf5184Cn6hZT9ZDebanjHiE9mcbmpwHm1/Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/xBxCluVnXo3PBfOHJyl251sCmrs8WnyVLVGG d0jLVMKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJioyD/ 45frMZpbUwAa/3Mzibgs8k057YB/OZAUl+jKPNwAm7gC4pvQX8tXYyGRlkhiJ1f4+gdXWDMUTws+Zb BtK5wLGDvCja19ksWutbgTiowgF3Uk3Ipzu1amZYOru+07rr9d1Oud0DGQPOxMqgTszbhRF9TjkR4k sCez3Ey9pylf9hHNakmuXr1RdGjlS4pysG1ELtNE82yUGf4T41/YHMspCYYUNI4Ww5KmaOX7blJxkV wqukEj2gAppyZPZAkUFKU59slkQLPUXP/VJGa7ZLCSEtVUxUNkf6tUBnQV4+NtkgQAffpTv40DHS0C bxGEkguixxvlv+m5yd2ONNaGfPSQGmcKn+JBgORFAo12/SOSPZ4tdiTguzhzDl4RQBlFvlpO9P33gG wuaHQt8MYZ937GrzO9nRpirP6ckub/I5mAwAHIMyeqb0fBn3/5EQrleyic/KAWZi3s+OgWVHl62rrq eUGR/yyXy//OEk5/9NvTUkzyjiRjY69IH/drENMObjunuJ8HUgSUdJfzycUmUjGbvjvnkRJ/uGW1L8 L9YKezQXJoANyGYQruQxZ/qq/CNLFiHWER4pDnXILHBDBsjIR8LuHIfHNtOYKyMf9tAjPMpEaoxAGw OUiWcRgLitBE2PJyEL+vPQgDLthqnJ/LYQRAKYmjRuWkQm1iKQeKd4oeQUEw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <kees@outflux.net>

Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
running with --altests to gain additional coverage, and by default under
UML.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 tools/testing/kunit/configs/arch_uml.config  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index f990cbb73250..0393940c706a 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -9,6 +9,8 @@ CONFIG_KUNIT=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
 CONFIG_KUNIT_ALL_TESTS=y
 
+CONFIG_FORTIFY_SOURCE=y
+
 CONFIG_IIO=y
 
 CONFIG_EXT4_FS=y
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
index e824ce43b05a..54ad8972681a 100644
--- a/tools/testing/kunit/configs/arch_uml.config
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -3,3 +3,6 @@
 # Enable virtio/pci, as a lot of tests require it.
 CONFIG_VIRTIO_UML=y
 CONFIG_UML_PCI_OVER_VIRTIO=y
+
+# Enable FORTIFY_SOURCE for wider checking.
+CONFIG_FORTIFY_SOURCE=y
-- 
2.34.1

