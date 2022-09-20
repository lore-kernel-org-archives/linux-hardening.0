Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA8C6FA92
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Sep 2022 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiITTWQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiITTWN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Sep 2022 15:22:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D262CCBB
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so3384473plz.7
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1o1LGpQmDlpzu7Ike/ReIwaogbPO4zuoRH4aws7NQKw=;
        b=FXsWBJaEckAPDyoDiTuGCNmqPBDHU8OmeUYXqYEhHzpmgSVzhU9z/lEgbkR1kaUI6B
         pky8QUt2XZ7fpm7bVNYPfwkdR+NnTkqxrOFMRrhG0USUZJIluHryxIkbCc5bM1a2+KcF
         yKvv2CblYRVdr6M/Ht3buy67ScvtSCu7ccOx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1o1LGpQmDlpzu7Ike/ReIwaogbPO4zuoRH4aws7NQKw=;
        b=borYkiA3yfX0hzCACpP/62ThRl1q4E5mlcHl+fFqW+fNak4URu8EOgORChK/5qCUAD
         kPHeK5rQqA+Y4xcS5eXkESDN3v7kEArSJT7mMpFlOzaF9ZrV8Zag5FFwyFoLV1j8DSTq
         UmbSEz9I87IkIAoZ2zGGUD6rS4f5LT1JiJ5bg4y6nyfqKmGQL5svLRUB244nyreMK5Qn
         mmTnCXjqJ3thgyOOgrPLsqUQYa8o3VL9g0O4IdCN19j4WZ5Yi2sCv8XHQKUXNy20pMmt
         ONFyBSxYBQWwTbRtY9z1kqXffmkmj/oZR6HQBmTAx6irPC/F1WMAlWHx+s9YjLyvlgK0
         W6KA==
X-Gm-Message-State: ACrzQf2wAACN1IL1meQJD7bbgQUcfKV7b6AFS9xklUt8wTvA2/kIis5T
        Foz9gPC9q9ODNDv+6lv6Uw9enw==
X-Google-Smtp-Source: AMsMyM5cGE6yDYaNnkOQI2S/AY/raVeY3MQmtPRCA7w7Y1F/Hp50JUsxZyNnn8zkQ8BUw5iA6TjTdQ==
X-Received: by 2002:a17:90b:1b0a:b0:203:3947:1a73 with SMTP id nu10-20020a17090b1b0a00b0020339471a73mr5502968pjb.43.1663701732553;
        Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6-20020aa79dc6000000b00540b3be3bf6sm241957pfq.196.2022.09.20.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when available
Date:   Tue, 20 Sep 2022 12:22:02 -0700
Message-Id: <20220920192202.190793-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192202.190793-1-keescook@chromium.org>
References: <20220920192202.190793-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540; h=from:subject; bh=SuFYab5ne2I0fynfIO4bCDx/ZuEkBNyDkYK1dq1mYyM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjKhLZYIErDe7TJDRHJVXzahhQK/yb2r2Hf0BSFlIk 1TRe4CGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyoS2QAKCRCJcvTf3G3AJv/FEA Czrw6b87vzPgCg7ACdCSxIWAVzP/trBSumyV4j+mMLwNorFE6sFmGa1LuJ6nJ9vUo8EDqahBZ9CDBv CCFp8MECNgOMcPu/f9UeJe5xWlEhzXx50YVKLlo7VRhI8qaTjuwPStnIPCMhNAq5rUTrhFgzZ6TRNj OgfUKDOAKj66fCR9ZZF5XOrZ6L6jqb+s3UKC7cRRxMly4pF5kpDIWS5rDy8HCb62zZEpRWfx5keU+c wKIblI52S1m4B92gAPSzTovz30UDFmQ4h77kqjrD8IGfuxtaLDGCXoUdVjKB1MZt6aA2TmCffYyif3 r75kl/VnrhA8BgG2hSaLao8eLp5NVSB05oeoRAtH3Ihg1oD3Prs2u+TfZlAxa/tAqS+NUbEp2tr48c zWUXBJXPA6CBD+InglqErOPIokC1bYUX4B8zrszOm04+MWWFVwHHNyAQ81LXctDwofckcu/XDFOYVg zWXa9fVrGWo3xzHFwXi6s2wmVGfwoHO82cH+ZIk/Z73l+so0GgscIkOaRUt0T7PsgStttC0CCxYBYl JDjycZUlwUA7bGRdCcsWeiMYuUuplqYkIbj4spMC7TIhgRjE13n8QTklhFlA6cfQLyq+jXqw+jstdN +767zQnvbl3Litrhx7i4I4UpuOQxMl919VqKmJrB4aFHEaFW6iZpVe7aEffQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Since the commits starting with c37495d6254c ("slab: add __alloc_size
attributes for better bounds checking"), the compilers have runtime
allocation size hints available in some places. This was immediately
available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
updating to explicitly make use the hints via the associated
__builtin_dynamic_object_size() helper. Detect and use the builtin when
it is available, increasing the accuracy of the mitigation. When runtime
sizes are not available, __builtin_dynamic_object_size() falls back to
__builtin_object_size(), leaving the existing bounds checking unchanged.

Additionally update the VMALLOC_LINEAR_OVERFLOW LKDTM test to make the
hint invisible, otherwise the architectural defense is not exercised
(the buffer overflow is detected in the memset() rather than when it
crosses the edge of the allocation).

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c           | 1 +
 include/linux/compiler_attributes.h | 5 +++++
 include/linux/fortify-string.h      | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 62516078a619..0ce4cbf6abda 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -31,6 +31,7 @@ static void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 	char *one, *two;
 
 	one = vzalloc(PAGE_SIZE);
+	OPTIMIZER_HIDE_VAR(one);
 	two = vzalloc(PAGE_SIZE);
 
 	pr_info("Attempting vmalloc linear overflow ...\n");
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 445e80517cab..9a9907fad6fd 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -296,6 +296,11 @@
  *
  * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
  */
+#if __has_attribute(__pass_dynamic_object_size__)
+# define __pass_dynamic_object_size(type)	__attribute__((__pass_dynamic_object_size__(type)))
+#else
+# define __pass_dynamic_object_size(type)
+#endif
 #if __has_attribute(__pass_object_size__)
 # define __pass_object_size(type)	__attribute__((__pass_object_size__(type)))
 #else
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 3f1178584d7b..dd7f85d74ade 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -77,10 +77,17 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
  * size, rather than struct size), but there remain some stragglers using
  * type 0 that will be converted in the future.
  */
+#if __has_builtin(__builtin_dynamic_object_size)
+#define POS			__pass_dynamic_object_size(1)
+#define POS0			__pass_dynamic_object_size(0)
+#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
+#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
+#else
 #define POS			__pass_object_size(1)
 #define POS0			__pass_object_size(0)
 #define __struct_size(p)	__builtin_object_size(p, 0)
 #define __member_size(p)	__builtin_object_size(p, 1)
+#endif
 
 #define __compiletime_lessthan(bounds, length)	(	\
 	__builtin_constant_p(length) &&			\
-- 
2.34.1

