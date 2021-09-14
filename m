Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B6C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017876113E
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhINTMO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhINTMO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B54C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:10:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p200-20020a25d8d1000000b005a3a281bc11so293405ybg.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1oOz6kaFdaWVr/jQmAaRDSorIwh4Z5I78YdyCUUNK9s=;
        b=Mpm5cQyxv4z1foMX312l2Tgy7gTfZn2UKqiNEm/bDeCpNs2Z2PFSloOoHJZbl9naVQ
         zqBEYS3THb+8QyjMkgmxc7puYOFu37WsvvCCk/6UkKq4ej8f21HCMyVPWgDbpaQJiDcW
         w+fBeBgbzefjp3/omKonhEIcGN10jh9cTkqGGDyim/HTmHZeV33Gc7604YpJPeObUCs2
         d1y9TFpFItoYhXMBU67pq0VbC+GD++Rro/eLkWTCaJpM91IOrvQw4j+7aAZtd4+HTVHr
         tCig2fxlOqSR035A/SVkPOC6u6oHEu73HqFSGhY9E1vq8t3WpjjlGvfT9N/hCxLoMNJ3
         wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1oOz6kaFdaWVr/jQmAaRDSorIwh4Z5I78YdyCUUNK9s=;
        b=JEGKNv+dqYtTbGx5SEGAX5xX57akbMoPU6uyXy+jW20XQvRNLi2pB/pSM6yo4aw2As
         yfIP9RZrB1O4QkjjUi6giPix6vTPobosHdO2hilut0tXQqMFIKao38inToQvzA81Dmf4
         lQPFgbKWBOwVWoYlzOK/YJwNojGbDJzFQhwtO2AcZNxQxrCW4DgxA3q5tfovZYEG+y+R
         2xNDLmc3c7w0zNqT5lT/HM89CJCImdIjklX9gD5SUNEFYQgTZ3122LKJ333pTTAu7m8M
         nckrQQHswGkvYKc2H7veYsLYDs+qxHrX4P/onaBZBL83bme4Hl79NWBfNOU5ghPRn2nE
         6yHQ==
X-Gm-Message-State: AOAM532is3dJpik6a++TDiMKrILt8jYft04wmWYrvF9wU06XzB6rdhx5
        OVws344bbQW2KtKOBw914xRJXlgPxSpR2e97amk=
X-Google-Smtp-Source: ABdhPJygYL+QqEjY5IK1osIHUTbFG9QZLqmwDt4ruKmO9HXh0t15yJzZ0ETG7dkreOm0w+tD1mcKz/86mHGueJRp8Sc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:3046:: with SMTP id
 w67mr1001922ybw.134.1631646655540; Tue, 14 Sep 2021 12:10:55 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:32 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 03/16] linkage: Add DECLARE_ASM_FUNC_SYMBOL
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The kernel has several assembly functions, which are not directly
callable from C but need to be referred to from C code. This change adds
the DECLARE_ASM_FUNC_SYMBOL macro, which allows us to declare these
symbols using an opaque type, which makes misuse harder, and avoids the
need to annotate references to the functions for Clang's Control-Flow
Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/linkage.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..f1eac26b2dd6 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -48,6 +48,19 @@
 #define __PAGE_ALIGNED_DATA	.section ".data..page_aligned", "aw"
 #define __PAGE_ALIGNED_BSS	.section ".bss..page_aligned", "aw"
 
+/*
+ * Declares a function not callable from C using an opaque type. Defined as
+ * an array to allow the address of the symbol to be taken without '&'.
+ */
+#ifndef DECLARE_ASM_FUNC_SYMBOL
+#define DECLARE_ASM_FUNC_SYMBOL(sym) \
+	extern const u8 sym[]
+#endif
+
+#ifndef __ASSEMBLY__
+typedef const u8 *asm_func_ptr;
+#endif
+
 /*
  * This is used by architectures to keep arguments on the stack
  * untouched by the compiler by keeping them live until the end.
-- 
2.33.0.309.g3052b89438-goog

