Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09658C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB5B6103A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhHRFJX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhHRFJU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 01:09:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17BC0612E7
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y190so946378pfg.7
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJoa4iKvyV5ZjcOKo8KLgCpzhWd1dLdAE7oHmS24kmI=;
        b=XoqR3saVnkwQdaMbo8v29/zLHplfZcejHyGEtGR80f/yvY/cgcEmJVBX6LB1twfOmR
         C57Wb9w3oBqxKggPS8I6LTjLP1Mg8N4TVD1yqljUPvsHHNnkxYnR3c6SZh+ZoDw4JYVr
         bSxIGT0JG05gMBr+nZxEAEA67uQJIh6d2QyNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJoa4iKvyV5ZjcOKo8KLgCpzhWd1dLdAE7oHmS24kmI=;
        b=YkazjL8MZ/faQKVcTpH+JzjT67DY3K0CfWmMZby0U68eYpsVjhRhoqwHVYS53BlFM/
         BpxK1330k/WMnEYszqrBzgkGtV2v4yUsDMpmyf7OPZwCo6sBx83NNCZQU5ys00JArzq0
         YjwaczOUBtNsQ8b9hWerZQI3WzMnpeoYJmc2Z761GtlqjZtsNGzzWI5GZ8Gx0UuI3VAD
         X23283tOjlxGNg+ty7IciPX+TFwrn9JsSGuhBVGkt0o9t4i3MxkqluxIxnGy+h/0AxwO
         p49KNvj0m1m/MdCPgWdqUHeD77m6BvUWIEr/RV98juwGrMbSgSBlv7WPGscotV6QtS9e
         KVow==
X-Gm-Message-State: AOAM532TKpuxlYEQOWhURzKGHoZ5JXptPrMDJfsuczIZkWKV4xKL0hRp
        jK07YI1gYyV0xgYfI7JDQmJ0cQ==
X-Google-Smtp-Source: ABdhPJwKgzp5vA4w6wkQdQaDJ9fAJpJsvxtDCO2cLAcpiN0uM8Y2YDiktkkEfIpYFuEAoycRcGb4Kw==
X-Received: by 2002:aa7:8058:0:b029:332:9da3:102d with SMTP id y24-20020aa780580000b02903329da3102dmr7352676pfm.21.1629263325814;
        Tue, 17 Aug 2021 22:08:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm5037394pgq.0.2021.08.17.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:08:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/5] slab: Add __alloc_size attributes for better bounds checking
Date:   Tue, 17 Aug 2021 22:08:38 -0700
Message-Id: <20210818050841.2226600-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818050841.2226600-1-keescook@chromium.org>
References: <20210818050841.2226600-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7084; h=from:subject; bh=mOKi2doWtdNTuoRZf7uNcQVzIU50qiNF7t9u3Nn55qQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHJXYMzR6/MsdNgjHLHDWQusu9UKxXGXBcBf1OYKK Sz9e4kaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyV2AAKCRCJcvTf3G3AJmNnD/ 4yTBX9z+fMGN8gDeZBU4fNrWeR2k4e14MeZzDbYV0BUqaiphoGMO9p570IWy3da8EoE65rBJYK1awp XvcnrLv86Vuzu6rHtLI4zcs4RRxNiF87TV2dbP8s1HWO06CHw45W9hJlWRbhRpJqElGhl9g1K5MKqs XidOG9M5i7z+sAs1BC+Uli1H+df+7CqijqxN7/2kqL2/ofwnVzpdVMf3paBst2Nh5fjiPmfRsf+tL2 0L3PfcWWT4+qLXaKE8dCaf69XkaLsMS3boQ30GBGLP4aClofiPF90eOBpqp2MnPNU1NADlJo+OmQ+W 4gmdLCmRi/+Tmtj6GQQgIJmJhsVA1AOUfeQdLjzuz4LbC5xa+7EbID0zlnXBWirdmrQeU2QFARrJSA g/3MwdNzqXo44qT5eFkC3n7j8gi0PYlfoOIFBX+hX9jAPFm56giDzgXIRTYp4gv53bsq6jhcquLpbs nEvse6BvVgBmwNKbKqJElqHbeV6+AkkctfP7+GHcytUqt4Vqp7IxAsxclM+5SwNuDb2SsCuc5CoHyo D42unWsvnFRPWkvTryy08B1bgojos+XmbygssJcfd3lBEAIknNjdAbNuouIw5chZTsKPTw/MACHxJF iqpKgOBq/btkAFocY2xjN0hDO/2MXd909gs1IViC61xu9yLty70IT9IrLw3Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for
regular kmalloc interfaces, to provide additional hinting for better
bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
optimizations.

Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/slab.h | 50 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c0d46b6fa12a..b2181c176999 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -181,7 +181,7 @@ int kmem_cache_shrink(struct kmem_cache *);
 /*
  * Common kmalloc functions provided by all allocators
  */
-void * __must_check krealloc(const void *, size_t, gfp_t);
+void * __must_check krealloc(const void *, size_t, gfp_t) __alloc_size(2);
 void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
@@ -425,7 +425,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
-void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
+void *__kmalloc(size_t size, gfp_t flags) __alloc_size(1) __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc(struct kmem_cache *, gfp_t flags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *, void *);
 
@@ -449,7 +449,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 }
 
 #ifdef CONFIG_NUMA
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment __malloc;
+void *__kmalloc_node(size_t size, gfp_t flags, int node) __alloc_size(1)
+							 __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc_node(struct kmem_cache *, gfp_t flags, int node) __assume_slab_alignment __malloc;
 #else
 static __always_inline void *__kmalloc_node(size_t size, gfp_t flags, int node)
@@ -574,7 +575,7 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
-static __always_inline void *kmalloc(size_t size, gfp_t flags)
+static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
 #ifndef CONFIG_SLOB
@@ -596,7 +597,8 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
-static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
+static __always_inline __alloc_size(1) void *
+kmalloc_node(size_t size, gfp_t flags, int node)
 {
 #ifndef CONFIG_SLOB
 	if (__builtin_constant_p(size) &&
@@ -620,7 +622,8 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *
+kmalloc_array(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
@@ -638,7 +641,7 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
  * @new_size: new size of a single member of the array
  * @flags: the type of memory to allocate (see kmalloc)
  */
-static __must_check inline void *
+static __must_check inline __alloc_size(2, 3) void *
 krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t flags)
 {
 	size_t bytes;
@@ -655,7 +658,8 @@ krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t flags)
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *
+kcalloc(size_t n, size_t size, gfp_t flags)
 {
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
@@ -684,7 +688,8 @@ static inline void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
 	return __kmalloc_node(bytes, flags, node);
 }
 
-static inline void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
+static inline __alloc_size(1, 2) void *
+kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
 {
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
@@ -716,7 +721,8 @@ static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline void *kzalloc(size_t size, gfp_t flags)
+static inline __alloc_size(1) void *
+kzalloc(size_t size, gfp_t flags)
 {
 	return kmalloc(size, flags | __GFP_ZERO);
 }
@@ -727,26 +733,31 @@ static inline void *kzalloc(size_t size, gfp_t flags)
  * @flags: the type of memory to allocate (see kmalloc).
  * @node: memory node from which to allocate
  */
-static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
+static inline __alloc_size(1) void *
+kzalloc_node(size_t size, gfp_t flags, int node)
 {
 	return kmalloc_node(size, flags | __GFP_ZERO, node);
 }
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
-static inline void *kvmalloc(size_t size, gfp_t flags)
+extern __alloc_size(1) void *
+kvmalloc_node(size_t size, gfp_t flags, int node);
+static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc_node(size, flags, NUMA_NO_NODE);
 }
-static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
+static inline __alloc_size(1) void *
+kvzalloc_node(size_t size, gfp_t flags, int node)
 {
 	return kvmalloc_node(size, flags | __GFP_ZERO, node);
 }
-static inline void *kvzalloc(size_t size, gfp_t flags)
+static inline __alloc_size(1) void *
+kvzalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc(size, flags | __GFP_ZERO);
 }
 
-static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *
+kvmalloc_array(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
@@ -756,13 +767,14 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 	return kvmalloc(bytes, flags);
 }
 
-static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *
+kvcalloc(size_t n, size_t size, gfp_t flags)
 {
 	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
-extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize,
-		gfp_t flags);
+extern __alloc_size(3) void *
+kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags);
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
-- 
2.30.2

