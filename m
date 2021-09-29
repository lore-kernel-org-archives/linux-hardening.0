Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606AC4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F40661278
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 21:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbhI2V3S (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbhI2V3O (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 17:29:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02535C061778
        for <linux-hardening@vger.kernel.org>; Wed, 29 Sep 2021 14:27:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w4-20020a056902100400b005b6b29d9a27so5199479ybt.20
        for <linux-hardening@vger.kernel.org>; Wed, 29 Sep 2021 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=08MMqZQxkHJyz/VF+8d0XPyGY6ToAo0OA/OmmtaYHyg=;
        b=Xc0r7XDhQk/RWJL3VJzgIR6Z34QQY3yA7gfvyI2MR/G/ctI7q+99DthyY5LlcWg2e7
         yNZKWxRGgPdrPrKcdjVGfuLYpgUyyaxc9QM+cEdXLZO7cGIBk81SomjCOBT5pFHhS50s
         c6xbphtTxJebvIq+LQjYxHjM/EiPRt3x+0CttaNT3TVpxgt96Nx34le5hdAMHS1ggHKu
         uoCMduNUutZNaLiuUGpfAGsoSYuT04gWEbTvHxWTQXG9vA1xAV4uphxEGXqqwOYkP7G9
         Czl8saVkvd0Wswmv2h2fMTdekMv294gEiwyuHMbzXc/Mvk4eKvpBG3Q+5f1Pbd2ghoD/
         m3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=08MMqZQxkHJyz/VF+8d0XPyGY6ToAo0OA/OmmtaYHyg=;
        b=uFBrqbz88V87oIBvPwOPmsjp9ZKTFvYsBYxPav/8tma2p4JAWTMXc1nzxZV+bhYihh
         RlHPM9ma1wswUIasQQBnq+T2mlfIrRvCuWZxXepkiNCe953Qm8FdwJqJbLIRUr8INhBN
         3qZGNArouNm6OjL51sAm1RexlNdGhJpqWYaEXBEmNfFh+iTSV3mv5A1oY6+8+1VT3i+S
         3MsJg+9AMe9kh7QDK+0NSXpJ07Hpe7WxiGnCkjVLtCy39KVagHhi79njpiZPqIayTFmu
         wP3MyUcs7LxD9zuwZs0//buRcLiJkBk3+xsDL+1K+/VWigBvGXVegP7pfIytKsgatRwh
         lZGg==
X-Gm-Message-State: AOAM532V9AiKw8qwpo+9Wwe537ZQvg4kQEQndXQtXMK0LCJ/cBUQz7+K
        FnxVseXMcA+XdMrQ0NaV7LSbd3wnBDxdrcl5x89KuQ==
X-Google-Smtp-Source: ABdhPJydtA3evA/mok1g6x4rh7TZpUEjkOozHd/KU5sU/LKW6mja59yYtNHfsoGoBJBqAHbTDyWHKtYkEMdXaZ/OgKddcA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a25:1584:: with SMTP id
 126mr2372236ybv.126.1632950850186; Wed, 29 Sep 2021 14:27:30 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:13 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 5/5] bitfield: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The structleak plugin causes the stack frame size to grow immensely:

lib/bitfield_kunit.c: In function 'test_bitfields_constants':
lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes since last revision:
 - Dropped -Wframe-larger-than=10240 from CFLAGS.
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37c..a841be5244ac6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -351,7 +351,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
-CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
+CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
-- 
2.33.0.685.g46640cef36-goog

