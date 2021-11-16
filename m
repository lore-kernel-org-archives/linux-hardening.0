Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7AEC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Nov 2021 03:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AE261BE6
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Nov 2021 03:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhKPEA3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbhKPEAX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Nov 2021 23:00:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6DEC073AE6
        for <linux-hardening@vger.kernel.org>; Mon, 15 Nov 2021 16:41:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x64so16530183pfd.6
        for <linux-hardening@vger.kernel.org>; Mon, 15 Nov 2021 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYCggQgM7Hv14HFSqESLBpo6cv4sDLeY3VVnNudB4CE=;
        b=eRJXSwOuUDGmPnItRU0lH63q+4yo+VLJo33ilp5X4R6sdpi+NW5B4G1AF5OuFE2g4X
         tvn6QvCzrlneubSHuZ8kKR2SSCLkMvN9A68phXJ6rlTlDMRf2tzVamfWavi2CK/Ep4IY
         g4cwLS1E3tDuefFgZ+1zkoc6ftgBkeh3nGn1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYCggQgM7Hv14HFSqESLBpo6cv4sDLeY3VVnNudB4CE=;
        b=CFpTCIJHPHFotJxGLGM+k9hw+djelNFiPg6ig9CsmhGEA1oRtSiYrnX5534szfjJNh
         bzjis0g5577ilASYjEphK0uOe7oymB1mpq9LUX68mr7Wrm8BpJ0LywJ1fPLz32iPt0YA
         /NWWUKeELTk3ACES9Jf62Q46cmQCDj2L6VjvEbJKjJjhpdm4j+dCxngLolP9vnygG10w
         qBs/xbKuRlyEtGMF54NnjIolf/+JZCgar5WqMTofrPvFB7oggHAfxUburcx2+G5Z+dZO
         /xkRJC10zWwHeSof2O4qky19eI4hRFeIgdqXM3qazdpKnV/A39J4NNczGvYHwc55sCOL
         CEsg==
X-Gm-Message-State: AOAM5335T8MtUbCtUGSBlqo68AsLzP4NPN0GvV1KhSjG9wxdBNTcFarA
        SkLKt7JuEmpTsj9IoDOWJ/werEmmaIp8wg==
X-Google-Smtp-Source: ABdhPJyQEHnSAEiCut9FVSRNJYvxdM/+I+bkxuH+oGC23tco0vt4TAvPrOzQMMRiafuA4idMqtb1SQ==
X-Received: by 2002:a63:7c1:: with SMTP id 184mr2174203pgh.11.1637023274056;
        Mon, 15 Nov 2021 16:41:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj11sm425461pjb.46.2021.11.15.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:41:13 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kasan: test: Silence intentional read overflow warnings
Date:   Mon, 15 Nov 2021 16:41:11 -0800
Message-Id: <20211116004111.3171781-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; h=from:subject; bh=oTw/CUC/KuutWYAe3WotO4gW4yWeVdWkH/bgioWASI8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhkv4mvd6GwHkIJO9fQ+xSGSSiPaJlNQ06IPenoXOv PUPzH+CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZL+JgAKCRCJcvTf3G3AJr0PEA CV/Dk3AykdjYzMT0aiqyOW5Nc7joC2ew50WxzpazdoT7QhDPrULZLvH7Xp0Olo6DNG7ZKXmWpE+Dk7 6Z5ooMF4qbGtRfw5ZaCrXpbLUgui8PNcq3VuUlEbxErmVpa6avJ5EjI9pmIeEB+RRh/xgFIJbc9Jeu tGpc4LeJODoXjW1y3Ym5/gGMRaxa6hCroQ0yy77OYuzX4KpDa6xnQXffCPtBIet0iutZSAyYx+GeHT XDJdHFJXTN3YZCocJ72P8R/JLjyz0pJY2viN9h8vhRjang9udr8hDWsFyzIGoUd5spNqkXcx1PXSIn fXd/1jvrHIbk3scnUgh26kVjOlctTdQsQf8Y1hTUY5vz94JAtXX77qXwuOlqGlur+p2LSvDK7JkdD/ EsIh7siCd/xkuJ0VFU2T5lPcnryuKmr+u1WRuhyvDygJjxdifEXULYhwTEWQ9/H9l6zEvY787VqUy4 xFd/y5SlOTjLq9W31bhhGg8gyO3hgey6RKVGD/LhMH4AOUG6Y3iKutGUiCbHAF5PNz0IvEPVn+E92x w/Q+pxpTavHYQX3yJvux0YN/SWYfGQV73NuGjHgtD0XegV6dZcBDtZ3I211VRGZfsJieB1JtGLGYrr g+G7KkkHqVeJrrtahW8NsTmzi7pPr+R6+3tdVzEbRgRpAI+S95yUW99j5nMA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As done in commit d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
for __write_overflow warnings, also silence some more cases that trip
the __read_overflow warnings seen in 5.16-rc1[1]:

In file included from /kisskb/src/include/linux/string.h:253,
                 from /kisskb/src/include/linux/bitmap.h:10,
                 from /kisskb/src/include/linux/cpumask.h:12,
                 from /kisskb/src/include/linux/mm_types_task.h:14,
                 from /kisskb/src/include/linux/mm_types.h:5,
                 from /kisskb/src/include/linux/page-flags.h:13,
                 from /kisskb/src/arch/arm64/include/asm/mte.h:14,
                 from /kisskb/src/arch/arm64/include/asm/pgtable.h:12,
                 from /kisskb/src/include/linux/pgtable.h:6,
                 from /kisskb/src/include/linux/kasan.h:29,
                 from /kisskb/src/lib/test_kasan.c:10:
In function 'memcmp',
    inlined from 'kasan_memcmp' at /kisskb/src/lib/test_kasan.c:897:2:
/kisskb/src/include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
  263 |                         __read_overflow();
      |                         ^~~~~~~~~~~~~~~~~
In function 'memchr',
    inlined from 'kasan_memchr' at /kisskb/src/lib/test_kasan.c:872:2:
/kisskb/src/include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
  277 |                 __read_overflow();
      |                 ^~~~~~~~~~~~~~~~~

[1] http://kisskb.ellerman.id.au/kisskb/buildresult/14660585/log/

Cc: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Fixes: d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_kasan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 67ed689a0b1b..0643573f8686 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -869,6 +869,7 @@ static void kasan_memchr(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		kasan_ptr_result = memchr(ptr, '1', size + 1));
 
@@ -894,6 +895,7 @@ static void kasan_memcmp(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	memset(arr, 0, sizeof(arr));
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		kasan_int_result = memcmp(ptr, arr, size+1));
 	kfree(ptr);
-- 
2.30.2

