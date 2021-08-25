Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15494C4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9991610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHYVcf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhHYVce (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 17:32:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E3C0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:31:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m28so1848032lfj.6
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY0qbvVPjAOFzT8qiDPpTkDYSNAZtyk57huJIJzryLM=;
        b=M9bx0SOnsGDlg6EdWvfUJiOzp+LnJnCsliu6HetKE4lwMQsYMSjkRyiS3ej7A9NE0K
         DirdJBjr4GEtvvADd7Uc/jozQEKtnOFqDn0569t2NcV7iaelhyQwfhLPmCTbNgEqlliO
         6BgOXWTb5RqcSy2DGb2XzxNvSx0AhAIVNmRJyzySizRH7yVnnsCUJCGzNnYAT6gh1GBg
         8wIjkuqvRlbdWQs/Vzk0LX1gXpdNB/xsdOr4Z57Iqftv68a/gbamW2ZnkKJBfVJZKngN
         8vnPfc/n8NDG9AcAFmH+uVPJdHEjtz7lG2+/14IWR/DSRAujCLGzTFBIvdPFCAM8AWMm
         h/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY0qbvVPjAOFzT8qiDPpTkDYSNAZtyk57huJIJzryLM=;
        b=JFZVELOd5dViXAWuF3oZN/yc6OGBWCMABMvMZnuXMSMwxohhYic8Ra4y842hwW5HqM
         h/0ieSPfQ9hxtWPLfTiCeS80AgDaCao55XKbLYdrdUOjkBCEjIRjqFw2J+lAdkHCJeES
         TfDNAJbl9sJ5TNE2glQAQHQ9uDzXCKRFQibkGpzi+6bLtjBX+KiV7SjbFMYBUhnqL5qh
         lvbOl+UhFxuy1rQVwd1/6owCNgD1eKOZOJ0TmDll2UC3GkyE1BzWuzTszi3GV0QmSLaQ
         JmxLHWthSGFrOySu8DpV1GiQ4OEYik8iQxk9omAwoEqilICiOmozh7IXP3tL2Pvn+Gmw
         WBfA==
X-Gm-Message-State: AOAM530tz78WjDr3HpKvvzQ1UmP3XcaLLcSOQ9xna6vXzfGIyHcFWofA
        ZXnNJHgZA/UvJzdGxfFJBfIiTa5AEu/38bOGzjxyeg==
X-Google-Smtp-Source: ABdhPJz+RJT6IU3xUkzodKecOyUDoT1qdKVVe/S3mJKfCjuy3YGChtWjD6clJDWnMDm5h5aQ27DVyF2DNjR7rql3B48=
X-Received: by 2002:a19:7117:: with SMTP id m23mr134039lfc.73.1629927106160;
 Wed, 25 Aug 2021 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210818214021.2476230-1-keescook@chromium.org> <20210818214021.2476230-5-keescook@chromium.org>
In-Reply-To: <20210818214021.2476230-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:31:34 -0700
Message-ID: <CAKwvOdmxRMcwKtWt+FogVY8iXn=vQ+0AZ36maJP2LbSdo_NNjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] slab: Add __alloc_size attributes for better
 bounds checking
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 2:40 PM Kees Cook <keescook@chromium.org> wrote:
>
> As already done in GrapheneOS, add the __alloc_size attribute for
> regular kmalloc interfaces, to provide additional hinting for better
> bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> optimizations.
>
> Co-developed-by: Daniel Micay <danielmicay@gmail.com>
> Signed-off-by: Daniel Micay <danielmicay@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

This is a good start, so
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Do we also want to attribute:
* __kmalloc_index
* kmem_cache_free_bulk
* kmem_cache_alloc_bulk
* kmem_cache_alloc_trace
* kmalloc_order
* kmalloc_order_trace
* kmalloc_large
* kmalloc_node
* __kmalloc_track_caller
* kmalloc_array_node
* __kmalloc_node_track_caller

> ---
>  include/linux/slab.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 10fd0a8c816a..6ce826d8194d 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -181,7 +181,7 @@ int kmem_cache_shrink(struct kmem_cache *s);
>  /*
>   * Common kmalloc functions provided by all allocators
>   */
> -__must_check
> +__must_check __alloc_size(2)
>  void *krealloc(const void *objp, size_t new_size, gfp_t flags);
>  void kfree(const void *objp);
>  void kfree_sensitive(const void *objp);
> @@ -426,6 +426,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  #define kmalloc_index(s) __kmalloc_index(s, true)
>  #endif /* !CONFIG_SLOB */
>
> +__alloc_size(1)
>  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_kmalloc_alignment __malloc;
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
> @@ -450,6 +451,7 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  }
>
>  #ifdef CONFIG_NUMA
> +__alloc_size(1)
>  void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node)
>                             __assume_slab_alignment __malloc;
> @@ -574,6 +576,7 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
>   *     Try really hard to succeed the allocation but fail
>   *     eventually.
>   */
> +__alloc_size(1)
>  static __always_inline void *kmalloc(size_t size, gfp_t flags)
>  {
>         if (__builtin_constant_p(size)) {
> @@ -596,6 +599,7 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
>         return __kmalloc(size, flags);
>  }
>
> +__alloc_size(1)
>  static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
>  #ifndef CONFIG_SLOB
> @@ -620,6 +624,7 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>   * @size: element size.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> +__alloc_size(1, 2)
>  static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
>  {
>         size_t bytes;
> @@ -638,7 +643,7 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
>   * @new_size: new size of a single member of the array
>   * @flags: the type of memory to allocate (see kmalloc)
>   */
> -__must_check
> +__must_check __alloc_size(2, 3)
>  static inline void *krealloc_array(void *p, size_t new_n, size_t new_size,
>                                    gfp_t flags)
>  {
> @@ -656,6 +661,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size,
>   * @size: element size.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> +__alloc_size(1, 2)
>  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
>  {
>         return kmalloc_array(n, size, flags | __GFP_ZERO);
> @@ -685,6 +691,7 @@ static inline void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
>         return __kmalloc_node(bytes, flags, node);
>  }
>
> +__alloc_size(1, 2)
>  static inline void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
>  {
>         return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
> @@ -718,6 +725,7 @@ static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
>   * @size: how many bytes of memory are required.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> +__alloc_size(1)
>  static inline void *kzalloc(size_t size, gfp_t flags)
>  {
>         return kmalloc(size, flags | __GFP_ZERO);
> @@ -729,25 +737,31 @@ static inline void *kzalloc(size_t size, gfp_t flags)
>   * @flags: the type of memory to allocate (see kmalloc).
>   * @node: memory node from which to allocate
>   */
> +__alloc_size(1)
>  static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
>  {
>         return kmalloc_node(size, flags | __GFP_ZERO, node);
>  }
>
> +__alloc_size(1)
>  extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
> +__alloc_size(1)
>  static inline void *kvmalloc(size_t size, gfp_t flags)
>  {
>         return kvmalloc_node(size, flags, NUMA_NO_NODE);
>  }
> +__alloc_size(1)
>  static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
>  {
>         return kvmalloc_node(size, flags | __GFP_ZERO, node);
>  }
> +__alloc_size(1)
>  static inline void *kvzalloc(size_t size, gfp_t flags)
>  {
>         return kvmalloc(size, flags | __GFP_ZERO);
>  }
>
> +__alloc_size(1, 2)
>  static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
>  {
>         size_t bytes;
> @@ -758,11 +772,13 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
>         return kvmalloc(bytes, flags);
>  }
>
> +__alloc_size(1, 2)
>  static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  {
>         return kvmalloc_array(n, size, flags | __GFP_ZERO);
>  }
>
> +__alloc_size(3)
>  extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize,
>                 gfp_t flags);
>  extern void kvfree(const void *addr);
> --

-- 
Thanks,
~Nick Desaulniers
