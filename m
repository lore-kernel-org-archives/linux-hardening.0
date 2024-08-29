Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFE1B5835
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951055; cv=none; b=i9ADG+d3SHIKX0t1bSk/+nBMkmsX4Is0e+Tcr81WkXDIiVbzb2D/fLd3E+8qKO0VrZaAoo8G4NB70Dph0wqjHxLwq6aum51zmBfkXvxsLvJ2fMR/a/vy/Npf6Bi3b/hfo8yJ69S3yf2xptQWNbX5eDzty++fiDVFXClapGwCT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951055; c=relaxed/simple;
	bh=ggs2P8b2EjHr2ddRCQTSkVLRcmD9WtXyenDHI48AL5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfci8fV2VsaCJ1rkWnt9t8wdrPpMU8IwgdgYNcPt4O8gy4wIaEdTJqTOEO84XCn+5TN6XbkZVVYDoxZt0DlCgNOj8Sr2XIB895f+KdpVST690i6PcoCtP9HgMl5efH3Ge4DXoaAAPeWhUc0rV9f6X1WJix1plkNkDzH0VHsJ3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkfHAz8p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkfHAz8p"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20260346ca1so7435ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724951051; x=1725555851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nrWj+lbgwnv4pKqxuewQJzBbIqoUYBkPvZycuD61mM=;
        b=JkfHAz8pDOUJ1NyJHzS6NyZv4pYvSga6zEK7Ga5l4Dc09tKh1e7owtqOyCYSqe28DQ
         yNA5diC/bDfX/xNq0aATMuQeF1kVDMrKngf+3JJl1FO5YrntAZ2pvOiWrIGBm81x0kdK
         1aHqy5hy9jh3hrsNQmDzA7kbRDPWnEqvLSUy/krcUOWL2F1zCq8pvSJJgTseLfPA54mi
         +tsjS5FtmEa3vwO/ENoOgTTx4nUuyM2CcBXoZq70Fjr6J7qLILNWvnLxtvmyvI2gr/jJ
         42GJMESXw2OOa0PjLfk+a1rl9zV6p40XV+e0uml8iH5057wz/hT9Exrm/uB26P22Eqza
         8TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724951051; x=1725555851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nrWj+lbgwnv4pKqxuewQJzBbIqoUYBkPvZycuD61mM=;
        b=V4rq1RWGhczX7lH0M9Rc9bi9j8oAUrMjmu3mwIjjW05B4bBSkxzTeWxTJ6ZqQZb7rS
         7kjKTbOanuE89HdZTR03w+sQS+A76eWfPXBxBQDcUUOJ0NEEwFDOduu9lYbhvaIUXiOm
         gaWY83xFLSZcLuG1L2krm+EuahgETBX+QyQ6OC38zpjhlC6vRqt6hexjyQ5jQAIL0lZR
         Zdj2V2tYViyWZaz+hl7BMf8amY+u3jzt6gvxw9u4oyJ0dYJY50zaxRCreMUrft7x6XUO
         vavFbWxPo+95cjIduTXgA/Kr70QSznM7bXB1OY6jzWGDGVKyFmywKKLeL+Dl/5DIHuWp
         xpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJPLKVfni+1AVlVUxR4pBH7PQ+ztkgsHOeGMdx0FziCJRV+Ruzgqyzrb1cPawYRx5KJB1xBx0ZjQ+H0ce6eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWhBOiF0AWoYqBTJOVacyoczrG30m/VR7TgXWBHPVvd92Nr4m
	7ldFwhKY6Bmn0OE5Mato6IvzyGcC6XpmhI0MouPhHsl9krHqf96YR/BobwNhcbGr9f8L6xo1SiC
	Ms3gKoQDJiZgtke3R59bzxCipfJZOZTDx2FtS
X-Google-Smtp-Source: AGHT+IEKjHEI5fi8CACxEU/wuH7rLZWTlw6hmW+nXaPA8fFpOSL/sPXDl3XdQmTpStVXXT1hAiKSRn50zzP7b1kofVA=
X-Received: by 2002:a17:903:32ca:b0:201:fba5:3ed with SMTP id
 d9443c01a7336-20510d58008mr3167875ad.27.1724951050824; Thu, 29 Aug 2024
 10:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809072532.work.266-kees@kernel.org> <20240809073309.2134488-5-kees@kernel.org>
In-Reply-To: <20240809073309.2134488-5-kees@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 29 Aug 2024 10:03:56 -0700
Message-ID: <CAJuCfpHOqKPzbbkULpWU5g1-8mTLXraQM4taHzajY_cJ-YFWgQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] slab: Allocate and use per-call-site caches
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, jvoisin <julien.voisin@dustri.org>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Use separate per-call-site kmem_cache or kmem_buckets. These are
> allocated on demand to avoid wasting memory for unused caches.
>
> A few caches need to be allocated very early to support allocating the
> caches themselves: kstrdup(), kvasprintf(), and pcpu_mem_zalloc(). Any
> GFP_ATOMIC allocations are currently left to be allocated from
> KMALLOC_NORMAL.
>
> With a distro config, /proc/slabinfo grows from ~400 entries to ~2200.
>
> Since this feature (CONFIG_SLAB_PER_SITE) is redundant to
> CONFIG_RANDOM_KMALLOC_CACHES, mark it a incompatible. Add Kconfig help
> text that compares the features.
>
> Improvements needed:
> - Retain call site gfp flags in alloc_tag meta field to:
>   - pre-allocate all GFP_ATOMIC caches (since their caches cannot
>     be allocated on demand unless we want them to be GFP_ATOMIC
>     themselves...)

I'm currently working on a feature to identify allocations with
__GFP_ACCOUNT known at compile time (similar to how you handle the
size in the previous patch). Might be something you can reuse/extend.

>   - Separate MEMCG allocations as well

Do you mean allocations with __GFP_ACCOUNT or something else?

> - Allocate individual caches within kmem_buckets on demand to
>   further reduce memory usage overhead.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/alloc_tag.h |   8 +++
>  lib/alloc_tag.c           | 121 +++++++++++++++++++++++++++++++++++---
>  mm/Kconfig                |  19 +++++-
>  mm/slab_common.c          |   1 +
>  mm/slub.c                 |  31 +++++++++-
>  5 files changed, 170 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index f5d8c5849b82..c95628f9b049 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -24,6 +24,7 @@ struct alloc_tag_counters {
>  struct alloc_meta {
>         /* 0 means non-slab, SIZE_MAX means dynamic, and everything else =
is fixed-size. */
>         size_t sized;
> +       void *cache;

I see now where that meta.cache in the previous patch came from...
That part should be moved here.

>  };
>  #define ALLOC_META_INIT(_size) {               \
>                 .sized =3D (__builtin_constant_p(_size) ? (_size) : SIZE_=
MAX), \
> @@ -216,6 +217,13 @@ static inline void alloc_tag_sub(union codetag_ref *=
ref, size_t bytes) {}
>
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>
> +#ifdef CONFIG_SLAB_PER_SITE
> +void alloc_tag_early_walk(void);
> +void alloc_tag_site_init(struct codetag *ct, bool ondemand);
> +#else
> +static inline void alloc_tag_early_walk(void) {}
> +#endif
> +
>  #define alloc_hooks_tag(_tag, _do_alloc)                               \
>  ({                                                                     \
>         struct alloc_tag * __maybe_unused _old =3D alloc_tag_save(_tag); =
 \
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 6d2cb72bf269..e8a66a7c4a6b 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -157,6 +157,89 @@ static void __init procfs_init(void)
>         proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
>  }
>
> +#ifdef CONFIG_SLAB_PER_SITE
> +static bool ondemand_ready;
> +
> +void alloc_tag_site_init(struct codetag *ct, bool ondemand)
> +{
> +       struct alloc_tag *tag =3D ct_to_alloc_tag(ct);
> +       char *name;
> +       void *p, *old;
> +
> +       /* Only handle kmalloc allocations. */
> +       if (!tag->meta.sized)
> +               return;
> +
> +       /* Must be ready for on-demand allocations. */
> +       if (ondemand && !ondemand_ready)
> +               return;
> +
> +       old =3D READ_ONCE(tag->meta.cache);
> +       /* Already allocated? */
> +       if (old)
> +               return;
> +
> +       if (tag->meta.sized < SIZE_MAX) {
> +               /* Fixed-size allocations. */
> +               name =3D kasprintf(GFP_KERNEL, "f:%zu:%s:%d", tag->meta.s=
ized, ct->function, ct->lineno);
> +               if (WARN_ON_ONCE(!name))
> +                       return;
> +               /*
> +                * As with KMALLOC_NORMAL, the entire allocation needs to=
 be
> +                * open to usercopy access. :(
> +                */
> +               p =3D kmem_cache_create_usercopy(name, tag->meta.sized, 0=
,
> +                                              SLAB_NO_MERGE, 0, tag->met=
a.sized,
> +                                              NULL);
> +       } else {
> +               /* Dynamically-size allocations. */
> +               name =3D kasprintf(GFP_KERNEL, "d:%s:%d", ct->function, c=
t->lineno);
> +               if (WARN_ON_ONCE(!name))
> +                       return;
> +               p =3D kmem_buckets_create(name, SLAB_NO_MERGE, 0, UINT_MA=
X, NULL);
> +       }
> +       if (p) {
> +               if (unlikely(!try_cmpxchg(&tag->meta.cache, &old, p))) {
> +                       /* We lost the allocation race; clean up. */
> +                       if (tag->meta.sized < SIZE_MAX)
> +                               kmem_cache_destroy(p);
> +                       else
> +                               kmem_buckets_destroy(p);
> +               }
> +       }
> +       kfree(name);
> +}
> +
> +static void alloc_tag_site_init_early(struct codetag *ct)
> +{
> +       /* Explicitly initialize the caches needed to initialize caches. =
*/
> +       if (strcmp(ct->function, "kstrdup") =3D=3D 0 ||
> +           strcmp(ct->function, "kvasprintf") =3D=3D 0 ||
> +           strcmp(ct->function, "pcpu_mem_zalloc") =3D=3D 0)

I hope we can find a better way to distinguish these allocations.
Maybe have a specialized hook for them, like alloc_hooks_early() which
sets a bit inside ct->flags to distinguish them?

> +               alloc_tag_site_init(ct, false);
> +
> +       /* TODO: pre-allocate GFP_ATOMIC caches here. */

You could pre-allocate GFP_ATOMIC caches during
alloc_tag_module_load() only if gfp_flags are known at compile time I
think. I guess for the dynamic case choose_slab() will fall back to
kmalloc_slab()?

> +}
> +#endif
> +
> +static void alloc_tag_module_load(struct codetag_type *cttype,
> +                                 struct codetag_module *cmod)
> +{
> +#ifdef CONFIG_SLAB_PER_SITE
> +       struct codetag_iterator iter;
> +       struct codetag *ct;
> +
> +       iter =3D codetag_get_ct_iter(cttype);
> +       for (ct =3D codetag_next_ct(&iter); ct; ct =3D codetag_next_ct(&i=
ter)) {
> +               if (iter.cmod !=3D cmod)
> +                       continue;
> +
> +               /* TODO: pre-allocate GFP_ATOMIC caches here. */
> +               //alloc_tag_site_init(ct, false);
> +       }
> +#endif
> +}
> +
>  static bool alloc_tag_module_unload(struct codetag_type *cttype,
>                                     struct codetag_module *cmod)
>  {
> @@ -175,8 +258,21 @@ static bool alloc_tag_module_unload(struct codetag_t=
ype *cttype,
>
>                 if (WARN(counter.bytes,
>                          "%s:%u module %s func:%s has %llu allocated at m=
odule unload",
> -                        ct->filename, ct->lineno, ct->modname, ct->funct=
ion, counter.bytes))
> +                        ct->filename, ct->lineno, ct->modname, ct->funct=
ion, counter.bytes)) {
>                         module_unused =3D false;
> +               }
> +#ifdef CONFIG_SLAB_PER_SITE
> +               else if (tag->meta.sized) {
> +                       /* Remove the allocated caches, if possible. */
> +                       void *p =3D READ_ONCE(tag->meta.cache);
> +
> +                       WRITE_ONCE(tag->meta.cache, NULL);

I'm guessing you are not using try_cmpxchg() the same way you did in
alloc_tag_site_init() because a race with any other user is impossible
at the module unload time? If so, a comment mentioning that would be
good.

> +                       if (tag->meta.sized < SIZE_MAX)
> +                               kmem_cache_destroy(p);
> +                       else
> +                               kmem_buckets_destroy(p);
> +               }
> +#endif
>         }
>
>         return module_unused;
> @@ -260,15 +356,16 @@ static void __init sysctl_init(void)
>  static inline void sysctl_init(void) {}
>  #endif /* CONFIG_SYSCTL */
>
> +static const struct codetag_type_desc alloc_tag_desc =3D {
> +       .section        =3D "alloc_tags",
> +       .tag_size       =3D sizeof(struct alloc_tag),
> +       .module_load    =3D alloc_tag_module_load,
> +       .module_unload  =3D alloc_tag_module_unload,
> +};
> +
>  static int __init alloc_tag_init(void)
>  {
> -       const struct codetag_type_desc desc =3D {
> -               .section        =3D "alloc_tags",
> -               .tag_size       =3D sizeof(struct alloc_tag),
> -               .module_unload  =3D alloc_tag_module_unload,
> -       };
> -
> -       alloc_tag_cttype =3D codetag_register_type(&desc);
> +       alloc_tag_cttype =3D codetag_register_type(&alloc_tag_desc);
>         if (IS_ERR(alloc_tag_cttype))
>                 return PTR_ERR(alloc_tag_cttype);
>
> @@ -278,3 +375,11 @@ static int __init alloc_tag_init(void)
>         return 0;
>  }
>  module_init(alloc_tag_init);
> +
> +#ifdef CONFIG_SLAB_PER_SITE
> +void alloc_tag_early_walk(void)
> +{
> +       codetag_early_walk(&alloc_tag_desc, alloc_tag_site_init_early);
> +       ondemand_ready =3D true;
> +}
> +#endif
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 855c63c3270d..4f01cb6dd32e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -302,7 +302,20 @@ config SLAB_PER_SITE
>         default SLAB_FREELIST_HARDENED
>         select SLAB_BUCKETS
>         help
> -         Track sizes of kmalloc() call sites.
> +         As a defense against shared-cache "type confusion" use-after-fr=
ee
> +         attacks, every kmalloc()-family call allocates from a separate
> +         kmem_cache (or when dynamically sized, kmem_buckets). Attackers
> +         will no longer be able to groom malicious objects via similarly
> +         sized allocations that share the same cache as the target objec=
t.
> +
> +         This increases the "at rest" kmalloc slab memory usage by
> +         roughly 5x (around 7MiB), and adds the potential for greater
> +         long-term memory fragmentation. However, some workloads
> +         actually see performance improvements when single allocation
> +         sites are hot.

I hope you provide the performance and overhead data in the cover
letter when you post v1.

> +
> +         For a similar defense, see CONFIG_RANDOM_KMALLOC_CACHES, which
> +         has less memory usage overhead, but is probabilistic.
>
>  config SLUB_STATS
>         default n
> @@ -331,6 +344,7 @@ config SLUB_CPU_PARTIAL
>  config RANDOM_KMALLOC_CACHES
>         default n
>         depends on !SLUB_TINY
> +       depends on !SLAB_PER_SITE
>         bool "Randomize slab caches for normal kmalloc"
>         help
>           A hardening feature that creates multiple copies of slab caches=
 for
> @@ -345,6 +359,9 @@ config RANDOM_KMALLOC_CACHES
>           limited degree of memory and CPU overhead that relates to hardw=
are and
>           system workload.
>
> +         For a similar defense, see CONFIG_SLAB_PER_SITE, which is
> +         deterministic, but has greater memory usage overhead.
> +
>  endmenu # Slab allocator options
>
>  config SHUFFLE_PAGE_ALLOCATOR
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index fc698cba0ebe..09506bfa972c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1040,6 +1040,7 @@ void __init create_kmalloc_caches(void)
>                 kmem_buckets_cache =3D kmem_cache_create("kmalloc_buckets=
",
>                                                        sizeof(kmem_bucket=
s),
>                                                        0, SLAB_NO_MERGE, =
NULL);
> +       alloc_tag_early_walk();
>  }
>
>  /**
> diff --git a/mm/slub.c b/mm/slub.c
> index 3520acaf9afa..d14102c4b4d7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4135,6 +4135,35 @@ void *__kmalloc_large_node_noprof(size_t size, gfp=
_t flags, int node)
>  }
>  EXPORT_SYMBOL(__kmalloc_large_node_noprof);
>
> +static __always_inline
> +struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t flags=
,
> +                              unsigned long caller)
> +{
> +#ifdef CONFIG_SLAB_PER_SITE
> +       struct alloc_tag *tag =3D current->alloc_tag;
> +
> +       if (!b && tag && tag->meta.sized &&
> +           kmalloc_type(flags, caller) =3D=3D KMALLOC_NORMAL &&
> +           (flags & GFP_ATOMIC) !=3D GFP_ATOMIC) {

What if allocation is GFP_ATOMIC but a previous allocation from the
same location (same tag) happened without GFP_ATOMIC and
tag->meta.cache was allocated. Why not use that existing cache?
Same if the tag->meta.cache was pre-allocated.


> +               void *p =3D READ_ONCE(tag->meta.cache);
> +
> +               if (!p && slab_state >=3D UP) {
> +                       alloc_tag_site_init(&tag->ct, true);
> +                       p =3D READ_ONCE(tag->meta.cache);
> +               }
> +
> +               if (tag->meta.sized < SIZE_MAX) {
> +                       if (p)
> +                               return p;
> +                       /* Otherwise continue with default buckets. */
> +               } else {
> +                       b =3D p;
> +               }
> +       }
> +#endif
> +       return kmalloc_slab(size, b, flags, caller);
> +}
> +
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int n=
ode,
>                         unsigned long caller)
> @@ -4152,7 +4181,7 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *=
b, gfp_t flags, int node,
>         if (unlikely(!size))
>                 return ZERO_SIZE_PTR;
>
> -       s =3D kmalloc_slab(size, b, flags, caller);
> +       s =3D choose_slab(size, b, flags, caller);
>
>         ret =3D slab_alloc_node(s, NULL, flags, node, caller, size);
>         ret =3D kasan_kmalloc(s, ret, size, flags);
> --
> 2.34.1
>
