Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4141B0132
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947255; cv=none; b=hNSubWIVsxQkCZ8sbnchFu/+Aj3T2rtEeJFl3CnqYocbyEJiCt04guLpJHEfDunwrxWQoMJMU8rXqdxDpQO7PbUEeDebRnTSmHT+ypLjog5Pyf3AeDetntcz26GCBsfTjajls8yyb15Qf7psz+7oJzsSTeIVrO8B37VImdp5Jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947255; c=relaxed/simple;
	bh=ypIsJu61Ac+yhRwX3ww92z0cl8iaGYbjNqCLC5CdVOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M949FRRhr4zRp7vvi2BUYD153+/zSL86ZWrF00o6XnP9Kh73c9L5hOMrpH2nM0IuODFLzA8gfyX+XC8N6FSfF5bnxcyl8t4Du0X8GV0ThfUcFr1X3PisXzxGnrnCuvo6GzQpBR+Z3CPzv1ZqcFba8isI0xjJrI6LIPUnEhyX1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fprjFwCB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fprjFwCB"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4567fe32141so375441cf.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724947251; x=1725552051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faZRfuIh6tyx/STII3KFiHR3ZroVBJPLCECLO13IVSA=;
        b=fprjFwCB7g52s2Z2TZl91/VxZtg5LCEJWAW3ndF+JaQ08MHpOlr7ZLA2ERkyZPZ9AO
         nqIoNQq0hWWK0TFqwUCiJpAe6U05ho97bXLfMxE1VD36ijdb+Aeedf7+OsdWfUKfsgxC
         /2c2npnnFMSSmi+Xhd8fjVhOxzEgZTuhvFXAe51OoxG6WNdPNiPkk+qgUu/P9Mmfpa1g
         6ZY5Y4Oa1iYXnlNhJp0AAZj9xkcb5c23lzyOzGIhBFVfW/Cb3n8u2KocKTlB+ljzL9zk
         vBIWoR4MBwpa727/s3f4Wd0Gc607tFPlFpoku0TULjmyerC+RTR4zsNXnxnPrsaidLQh
         j7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724947251; x=1725552051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faZRfuIh6tyx/STII3KFiHR3ZroVBJPLCECLO13IVSA=;
        b=YuTUm1BRfguAP9Ms3HFzWKdinddFQhDPf4eeIYrolp3bCnJRxzSrEvoQNfLXbnaEmi
         JmKbL9h8cokjTcDmrNLgJjn9pzybcd3V3QFfL3v4LFcHIrTdqprHwu1F3k56QN3xa3Ad
         k3lRKkg+odDBvTq0J9saj6WKy4DKGnMBV2gf/FVxbbzC4IetIWsAROxsXbtSosQ/bmgL
         D/HR6yCy5tWpzJj0CxO6e/rmB0av5ESBFbADU2AUavTHzDH2uQBxZF7+IpaKQVXforao
         3Ipj9KVRAz9NQ8KYVHYlQuAAZye0so8Gsq+kOos29VDKK85tqzlXvAQa06Q09/cbIYy6
         HGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUgcwNrsDKzHoWfjhY6qv1UqsG1zydrGGXElPcuPov/DYC1SJgPYKvtcwYtr4mkPHsv9w5pnQE4POUkFQQUgyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYY//zfJuIgEwOwiFI+RKGIsxQM/zrJa9BTTYdjPRhKdaX/5XM
	yid/a+dw7FyzdTZNDqqXP2N6MTnBQ0FmWr1A1+wCOuCiHvJwS2E/mP/TEnAkwVyN1MZJ8kENh0E
	AGKSCdO43D6oWBqTphTcDJI68NuufUTMYf0Xq
X-Google-Smtp-Source: AGHT+IGClq65i5Muaoi1TfggLqS1pEc+H5xQXkuciLf9CNJ+ANij1+dnSrrj3ldpiRigHV4bJA1zM0r7w8EHkaU6qQY=
X-Received: by 2002:a05:622a:83cc:b0:447:e847:486 with SMTP id
 d75a77b69052e-45681509806mr3139301cf.3.1724947250230; Thu, 29 Aug 2024
 09:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809072532.work.266-kees@kernel.org> <20240809073309.2134488-4-kees@kernel.org>
In-Reply-To: <20240809073309.2134488-4-kees@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 29 Aug 2024 09:00:37 -0700
Message-ID: <CAJuCfpFXTDnqZphJ1z37KkqMt5nuOqaoWMJMRBOkA8Dnf1Dh2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] alloc_tag: Track fixed vs dynamic sized kmalloc calls
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
> For slab allocations, record whether the call site is using a fixed
> size (i.e. compile time constant) or a dynamic size. Report the results
> in /proc/allocinfo.
>
> Improvements needed:
> - examine realloc routines for needed coverage
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
>  include/linux/alloc_tag.h | 30 ++++++++++++++++++++++++++----
>  include/linux/slab.h      | 16 ++++++++--------
>  lib/alloc_tag.c           |  8 ++++++++
>  mm/Kconfig                |  8 ++++++++
>  4 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8c61ccd161ba..f5d8c5849b82 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -20,6 +20,19 @@ struct alloc_tag_counters {
>         u64 calls;
>  };
>
> +#ifdef CONFIG_SLAB_PER_SITE
> +struct alloc_meta {
> +       /* 0 means non-slab, SIZE_MAX means dynamic, and everything else =
is fixed-size. */
> +       size_t sized;
> +};
> +#define ALLOC_META_INIT(_size) {               \
> +               .sized =3D (__builtin_constant_p(_size) ? (_size) : SIZE_=
MAX), \
> +       }
> +#else
> +struct alloc_meta { };
> +#define ALLOC_META_INIT(_size) { }
> +#endif
> +
>  /*
>   * An instance of this structure is created in a special ELF section at =
every
>   * allocation callsite. At runtime, the special section is treated as
> @@ -27,6 +40,7 @@ struct alloc_tag_counters {
>   */
>  struct alloc_tag {
>         struct codetag                  ct;
> +       struct alloc_meta               meta;
>         struct alloc_tag_counters __percpu      *counters;
>  } __aligned(8);
>
> @@ -74,19 +88,21 @@ static inline struct alloc_tag *ct_to_alloc_tag(struc=
t codetag *ct)
>   */
>  DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>
> -#define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
> +#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)                        =
       \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
>         __section("alloc_tags") =3D {                                    =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
> +               .meta =3D _meta_init,                                    =
         \
>                 .counters =3D &_shared_alloc_tag };
>
>  #else /* ARCH_NEEDS_WEAK_PER_CPU */
>
> -#define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
> +#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)                        =
       \
>         static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr)=
;      \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
>         __section("alloc_tags") =3D {                                    =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
> +               .meta =3D _meta_init,                                    =
         \
>                 .counters =3D &_alloc_tag_cntr };
>
>  #endif /* ARCH_NEEDS_WEAK_PER_CPU */
> @@ -191,7 +207,7 @@ static inline void alloc_tag_sub(union codetag_ref *r=
ef, size_t bytes)
>
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
>
> -#define DEFINE_ALLOC_TAG(_alloc_tag)
> +#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)
>  static inline bool mem_alloc_profiling_enabled(void) { return false; }
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_ta=
g *tag,
>                                  size_t bytes) {}
> @@ -210,8 +226,14 @@ static inline void alloc_tag_sub(union codetag_ref *=
ref, size_t bytes) {}
>
>  #define alloc_hooks(_do_alloc)                                         \
>  ({                                                                     \
> -       DEFINE_ALLOC_TAG(_alloc_tag);                                   \
> +       DEFINE_ALLOC_TAG(_alloc_tag, { });                              \
>         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
>  })
>
> +#define alloc_sized_hooks(_do_alloc, _size, ...)                       \
> +({                                                                     \
> +       DEFINE_ALLOC_TAG(_alloc_tag, ALLOC_META_INIT(_size));           \
> +       alloc_hooks_tag(&_alloc_tag, _do_alloc(_size, __VA_ARGS__));    \
> +})
> +
>  #endif /* _LINUX_ALLOC_TAG_H */
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 86cb61a0102c..314d24c79e05 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -541,7 +541,7 @@ static_assert(PAGE_SHIFT <=3D 20);
>   */
>  void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
>                               gfp_t flags) __assume_slab_alignment __mall=
oc;
> -#define kmem_cache_alloc(...)                  alloc_hooks(kmem_cache_al=
loc_noprof(__VA_ARGS__))
> +#define kmem_cache_alloc(...)          alloc_hooks(kmem_cache_alloc_nopr=
of(__VA_ARGS__))

nit: seems like an unnecessary churn.

>
>  void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru =
*lru,
>                             gfp_t gfpflags) __assume_slab_alignment __mal=
loc;
> @@ -685,7 +685,7 @@ static __always_inline __alloc_size(1) void *kmalloc_=
noprof(size_t size, gfp_t f
>         }
>         return __kmalloc_noprof(size, flags);
>  }
> -#define kmalloc(...)                           alloc_hooks(kmalloc_nopro=
f(__VA_ARGS__))
> +#define kmalloc(size, ...)     alloc_sized_hooks(kmalloc_noprof, size, _=
_VA_ARGS__)
>
>  #define kmem_buckets_alloc(_b, _size, _flags)  \
>         alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), =
_flags, NUMA_NO_NODE))
> @@ -708,7 +708,7 @@ static __always_inline __alloc_size(1) void *kmalloc_=
node_noprof(size_t size, gf
>         }
>         return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flag=
s, node);
>  }
> -#define kmalloc_node(...)                      alloc_hooks(kmalloc_node_=
noprof(__VA_ARGS__))
> +#define kmalloc_node(size, ...)                alloc_sized_hooks(kmalloc=
_node_noprof, size, __VA_ARGS__)
>
>  /**
>   * kmalloc_array - allocate memory for an array.
> @@ -726,7 +726,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_=
noprof(size_t n, size_t siz
>                 return kmalloc_noprof(bytes, flags);
>         return kmalloc_noprof(bytes, flags);
>  }
> -#define kmalloc_array(...)                     alloc_hooks(kmalloc_array=
_noprof(__VA_ARGS__))
> +#define kmalloc_array(...)             alloc_hooks(kmalloc_array_noprof(=
__VA_ARGS__))

ditto.

>
>  /**
>   * krealloc_array - reallocate memory for an array.
> @@ -761,8 +761,8 @@ void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_=
PARAMS(size, b), gfp_t flag
>                                          unsigned long caller) __alloc_si=
ze(1);
>  #define kmalloc_node_track_caller_noprof(size, flags, node, caller) \
>         __kmalloc_node_track_caller_noprof(PASS_BUCKET_PARAMS(size, NULL)=
, flags, node, caller)
> -#define kmalloc_node_track_caller(...)         \
> -       alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP=
_))
> +#define kmalloc_node_track_caller(size, ...)           \
> +       alloc_sized_hooks(kmalloc_node_track_caller_noprof, size, __VA_AR=
GS__, _RET_IP_)
>
>  /*
>   * kmalloc_track_caller is a special version of kmalloc that records the
> @@ -807,13 +807,13 @@ static inline __alloc_size(1) void *kzalloc_noprof(=
size_t size, gfp_t flags)
>  {
>         return kmalloc_noprof(size, flags | __GFP_ZERO);
>  }
> -#define kzalloc(...)                           alloc_hooks(kzalloc_nopro=
f(__VA_ARGS__))
> +#define kzalloc(size, ...)                     alloc_sized_hooks(kzalloc=
_noprof, size, __VA_ARGS__)
>  #define kzalloc_node(_size, _flags, _node)     kmalloc_node(_size, (_fla=
gs)|__GFP_ZERO, _node)
>
>  void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, i=
nt node) __alloc_size(1);
>  #define kvmalloc_node_noprof(size, flags, node)        \
>         __kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, nod=
e)
> -#define kvmalloc_node(...)                     alloc_hooks(kvmalloc_node=
_noprof(__VA_ARGS__))
> +#define kvmalloc_node(size, ...)               alloc_sized_hooks(kvmallo=
c_node_noprof, size, __VA_ARGS__)
>
>  #define kvmalloc(_size, _flags)                        kvmalloc_node(_si=
ze, _flags, NUMA_NO_NODE)
>  #define kvmalloc_noprof(_size, _flags)         kvmalloc_node_noprof(_siz=
e, _flags, NUMA_NO_NODE)
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 81e5f9a70f22..6d2cb72bf269 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -78,6 +78,14 @@ static void alloc_tag_to_text(struct seq_buf *out, str=
uct codetag *ct)
>
>         seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>         codetag_to_text(out, ct);
> +#ifdef CONFIG_SLAB_PER_SITE
> +       seq_buf_putc(out, ' ');
> +       seq_buf_printf(out, "size:%s(%zu) slab:%s",
> +                               tag->meta.sized =3D=3D 0 ? "non-slab" :

"non-slab" term sounds overly specific and we might extend this to
some other allocations as well in the future. I would suggest
"unknown" instead.

> +                                       tag->meta.sized =3D=3D SIZE_MAX ?=
 "dynamic" : "fixed",
> +                               tag->meta.sized =3D=3D SIZE_MAX ? 0 : tag=
->meta.sized,
> +                               tag->meta.cache ? "ready" : "unused");

I don't see "struct alloc_meta" having a "cache" member...

Since you are changing the format of this file, you want to also bump
up the file version inside print_allocinfo_header().


> +#endif
>         seq_buf_putc(out, ' ');
>         seq_buf_putc(out, '\n');
>  }
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f78..855c63c3270d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -296,6 +296,14 @@ config SLAB_BUCKETS
>
>           If unsure, say Y.
>
> +config SLAB_PER_SITE
> +       bool "Separate slab allocations by call size"
> +       depends on !SLUB_TINY
> +       default SLAB_FREELIST_HARDENED
> +       select SLAB_BUCKETS
> +       help
> +         Track sizes of kmalloc() call sites.
> +
>  config SLUB_STATS
>         default n
>         bool "Enable performance statistics"
> --
> 2.34.1
>
