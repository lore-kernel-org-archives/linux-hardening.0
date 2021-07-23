Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AFC4338F
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDB860ED7
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhGWVjN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhGWVjI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Jul 2021 17:39:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98664C0613D3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 15:19:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so5706924pjd.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8DwI8fnRArZqHUblKXlj4bT7xhIFIuBs/B+X1cQdyw=;
        b=MdmgAbLiBnkHjIj7AibPaMgyMFymg5wpuW8KVCy/+kzlmK8sCgYDC2iH4eJ0VkIi3s
         dlh/1LgW7nLtl0+mJi0iordvLi01Htcko3rr/K6upyjicHk9sYtzf179gK8ZRoc3aKT9
         UQKSXjAYu0HycKS14V4j8ug0dqKxe+J4Th73o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8DwI8fnRArZqHUblKXlj4bT7xhIFIuBs/B+X1cQdyw=;
        b=Vo/ht1Wc3OF/byj3HTa+QrPnI33hL6pydo8TsBMUX4bv0yoeZDyJJWeHLODHc5shU3
         MslqJGPBVWapGBq67mfymRlUwTICbjoABlAU4vvohCsoaiMFglf/rwwvWtpfME6bL2eY
         DDOC3H63PgH+WygL7w+bgD1e0XtH8T9e5mvu9LYhuPBTZ02Rl4tAjUDfAafjrnOKeTk9
         Zu3iIkXLFQ2OOczm15ZdPwE2rB8GQzPu85N8MrQLqOtxnQnUWqat1j4kJ7JyoTg4Uspp
         zf27yplpuaASvV31TtvhF+hv+Gpqwelb5U53pQ5s5GIdn09Hjr2PopM1+4kB75Cfpx2B
         z40A==
X-Gm-Message-State: AOAM532rH130r2kfdxPif6w/AdWxKIPNtsGIEtDC66V8xHpw1gq7a1dG
        iGWn0YnRSmTSdaxJ78VBD7Gpww==
X-Google-Smtp-Source: ABdhPJybkHO8b0aJDqpNP0wVQL+iQIMjRsONEsFrhkpm172q7s1kn56Z7Bus0oVCPWl3Ui5IFDF8Jg==
X-Received: by 2002:a63:ef44:: with SMTP id c4mr6675167pgk.162.1627078779266;
        Fri, 23 Jul 2021 15:19:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l65sm27825208pgl.32.2021.07.23.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 1/3] lib/test_stackinit: Fix static initializer test
Date:   Fri, 23 Jul 2021 15:19:31 -0700
Message-Id: <20210723221933.3431999-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723221933.3431999-1-keescook@chromium.org>
References: <20210723221933.3431999-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; h=from:subject; bh=aRRyyNpJICHvBcmxWEK59jlinDlwFKz/j7t+tY2LYcM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+0B0tjjRQRC2yzCBaDP86WMV114a/Nqov1cxgJHH oJBUUZ2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPtAdAAKCRCJcvTf3G3AJo2nEA CNcTtttQLSsbw4XgcOL4h+v/fRWOTBERUnZcZiXN/yjwqlEUmuhjdvEaRvCP8jNzHu8Dej65BvsJOV 7p9glRjTnOjCElxjXiVR876xW6U+7EcuEk1LOcIztZlKomjPiATMfRya0hXY4oXtXNuPxMk04t28W4 bB/kQBArrUlerB+dt5CHdhizLzPKegfXIHxRO1392dX8zwsnmNtieShoTaCky25OMkeRu5hkeiw6Sg MtM2VO2eNPj68LlYsOHnC+qtKYvV0h8h0MQF1HZ6dyb32VYdCnIO6optbIeIEfuIXStlIXjjEJNgff FHTZUn/ZnvoKvT237o5uABnl79Ipd+8AICohXJh2r6aSEC5nwFucd7WFxeC+j8SuXxI5d+9Uw3euGB csDlS6DJdWJyWZEXhFMnM0O+DpySmqx67T6xg0UuDdsK531gJf2YYaG+s8+qSkYHddcI6CEotCqumA d2Pw4pNhfLaIQKTJ+e/Xm9rM51O8p4FbFYgy9En3I+oZvzoc9HnUdoCMWO3hMZLDoQvRMvEOqOZBeq Ehs+JZFx7w+pwQFxgiQ8lGR/rSMBdLaRiNn+Tt/dInRyPXnt18jivIPexPjqsgnlwnO5+dgn2dgHwD +J4XZUMrXFxf6Zo9lfhC2B6L+AKPfy7VqKzrKFOPeA+qUjYvY8uN3MVs+FRQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The static initializer test got accidentally converted to a dynamic
initializer. Fix this and retain the giant padding hole without using
an aligned struct member.

Fixes: 50ceaa95ea09 ("lib: Introduce test_stackinit module")
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_stackinit.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index f93b1e145ada..16b1d3a3a497 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -67,10 +67,10 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
 #define INIT_STRUCT_none		/**/
 #define INIT_STRUCT_zero		= { }
 #define INIT_STRUCT_static_partial	= { .two = 0, }
-#define INIT_STRUCT_static_all		= { .one = arg->one,		\
-					    .two = arg->two,		\
-					    .three = arg->three,	\
-					    .four = arg->four,		\
+#define INIT_STRUCT_static_all		= { .one = 0,			\
+					    .two = 0,			\
+					    .three = 0,			\
+					    .four = 0,			\
 					}
 #define INIT_STRUCT_dynamic_partial	= { .two = arg->two, }
 #define INIT_STRUCT_dynamic_all		= { .one = arg->one,		\
@@ -84,8 +84,7 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
 					var.one = 0;			\
 					var.two = 0;			\
 					var.three = 0;			\
-					memset(&var.four, 0,		\
-					       sizeof(var.four))
+					var.four = 0
 
 /*
  * @name: unique string name for the test
@@ -210,18 +209,13 @@ struct test_small_hole {
 	unsigned long four;
 };
 
-/* Try to trigger unhandled padding in a structure. */
-struct test_aligned {
-	u32 internal1;
-	u64 internal2;
-} __aligned(64);
-
+/* Trigger unhandled padding in a structure. */
 struct test_big_hole {
 	u8 one;
 	u8 two;
 	u8 three;
 	/* 61 byte padding hole here. */
-	struct test_aligned four;
+	u8 four __aligned(64);
 } __aligned(64);
 
 struct test_trailing_hole {
-- 
2.30.2

