Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D14C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 23:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F78261288
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 23:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350480AbhI3X7m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbhI3X7m (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 19:59:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE9EC06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 16:57:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so6001694pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5j14yW/PypKR9/SrD65vjQsfYpY9smLiA7zJp8BFIpg=;
        b=WUDQVGma0l2Gi8MnTvhtJyoerNkG/h/WMEFR+rm/XM5WuTHotMNFmuoICR1Jc0252F
         wyIag7onxIrqWq+pxX2kRMqDINTs3Zqy1CNw2lG+65uzuBFqXfWD766uE0LXXkFxOf0K
         lp/4MNMZX0yhppTdimTBMfBoZ4DzksB+OtkwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5j14yW/PypKR9/SrD65vjQsfYpY9smLiA7zJp8BFIpg=;
        b=vHv0ygkcNx2L/1jdwGfQcNFyQD5wkoMY7jDNdkuREMVnGiGH5Cd4cgIMeY+HyrDZEz
         G+oyzd8U9qURmuOY3jG4qG+BkMtjfrepoLcnBStOZcR579p1O/wpK5ahurmPZmQsAlhA
         kLQprvQA3Oh0FNDE1ASCk09YVxNLdQAahgL9YuuCouDXZeek/z8b+LL+ArEMNLHK8DOW
         K6Sg1Dc8AX362rfn1/6eTnLqc2AG5LYnn+cIKTQMGlwWvgZeRkG85oQWylkWFyK3zzsI
         N/8CaZXFnLm99uefm/Cs5/x2g15074N5FQVuj2i6/xz5yVuTwCBZ5C43qW5oZMhaJi9v
         vd8w==
X-Gm-Message-State: AOAM532haXElZT/GJJ8g5kF21QSpPZ5xbAxGv/YEbY+Rl7jtV4eJibAG
        W+uUCIuHkT4eU9H4EmlurBaKqT+Pf30sAQ==
X-Google-Smtp-Source: ABdhPJwuOq7B41EACaboD7SHo9y2ZqSCOJSJPrgHWzAce7aXLZEwM7+zwvveG7Li/nbR98kxbxoQBw==
X-Received: by 2002:a17:902:6e02:b0:13a:41f5:1666 with SMTP id u2-20020a1709026e0200b0013a41f51666mr8006363plk.39.1633046278609;
        Thu, 30 Sep 2021 16:57:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm4358170pfm.27.2021.09.30.16.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:57:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4] docs: Explain the desired position of function attributes
Date:   Thu, 30 Sep 2021 16:57:54 -0700
Message-Id: <20210930235754.2635912-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; h=from:subject; bh=59BKj9K6C4nRsKqbRsBlH2BSu9B8VLmTPJNoZZp8k+c=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVk8CauaXOjnvxaWiuW4a9hEnvYBhMGesbVq1iMZF 5JOMjQ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVZPAgAKCRCJcvTf3G3AJoEJD/ sHJfHWedBPEbJOXNVuGu6/X/7ZvYmpkZO4mku8tWkcmyk7FG/D3mkbLoO+M+Om67Ivz5JhLQ6noh8w q7SE/hfkWpX5z7Ga5d39BK6vEzz9R34TxjcXUtvIU0J/RBUK5G7SBJoAGMF9evK4aiElZix4u6tYaV sFH5it4+H41ac4cKORTnjdzZ3sRmvlO/vfsYEMsYR2f1GKVVOgP/KaB41jsDsCk2WcPx+HJ52MNqiu NsconvQBCbBaIZ6vklp83Rk/OheyvfsOx0Qu90+Rq7RXWeOgwOh6M4TOiMP8Nmisy5D3HQd+asVQ6f f6UmMeYp1J3UYG2J5jm/DDRZf1/wi9vnWo1zDsV7LhHMFE87lweRBYh8V6EjeXxUwvTo9W8eS7BCj9 WFJ58N/oV6dcLJdAiUIhD3vkEkAHv7axxqBism0OZnMVg1gUJjZoqd+MJi7s/Rfxj744w2KKpDM7j/ bLYkwWAKVlpwIodyZclDf4E/6eY/lTYA1+G3X/rd6RJI/Qv+9FjAgd3GDpSiaO6F32IVwUxzmcwHXR kIH4/7T8DvHZF6R/m1aVv665HbUJQSoHIpuAuPJfPLRit8KzGNbiZEwfrqynNFfKEuS3ukC5o83N/a DZDdx5H3fOaIyxGOMHTYg6YdKvNjub633C9HYWtSr3hqgHs8xBYcoioizMsA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While discussing how to format the addition of various function
attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
close as possible to Linus's preferences for future reference.

(Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
others that would prefer all attributes live on a separate leading line.)

[1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v4:
- fix another stray "void"! This is why code needs a compiler... (thx randy)
---
 Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 42969ab37b34..45b48510f5ec 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
 Do not use the ``extern`` keyword with function prototypes as this makes
 lines longer and isn't strictly necessary.
 
+When writing a function declarations, please keep the `order of elements regular
+<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
+For example::
+
+ extern __init void * __must_check action(enum magic value, size_t size, u8 count,
+ 					  char *fmt, ...) __printf(4, 5) __malloc;
+
+The preferred order of elements for a function prototype is:
+
+- storage class (here, ``extern``, and things like ``static __always_inline`` even though
+  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
+- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
+- return type (here, ``void *``)
+- return type attributes (here, ``__must_check``)
+- function name (here, ``action``)
+- function parameters (here, ``(enum magic value, size_t size, u8 count, char *fmt, ...)``, noting that parameter names should always be included)
+- function parameter attributes (here, ``__printf(4, 5)``)
+- function behavior attributes (here, ``__malloc``)
+
+Note that for a function definition (e.g. ``static inline``), the compiler does
+not allow function parameter attributes after the function parameters. In these
+cases, they should go after the storage class attributes (e.g. note the changed
+position of ``__printf(4, 5)``)::
+
+ static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
+ 		size_t size, u8 count, char *fmt, ...)
+ 		__malloc
+ {
+ 	...
+ }
 
 7) Centralized exiting of functions
 -----------------------------------
-- 
2.30.2

