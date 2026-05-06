Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F946AEE1
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072652; cv=pass; b=GfII8PviPKqI3+61IWixqJfk+vZX5BNSqZed+8EfXlij6lJlKn96oys6H9cX8qNn012XnWFflUrk/DmxetvpbF3sQ+8uj3TG3D74EjKs2+qPYTC0Tf3NO90RyRJryCJeyLLlyNvYlRVMLoyk+Sw6qValoLeNUEo5NJ/kKDoKoBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072652; c=relaxed/simple;
	bh=oQH4MCqtsx8PuDqkHCstgNaDMaf3tjzD1L/6gzNJxyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvCo2+8lNmFuktHhaBrBT6si1OgNgh7QzKSriZzCw4LcsTKQuYhTf5d8MN4N/HJ2OtJccaNS0rWY4vllIcXRkk7fTe2LFYPgE86Tqb6mkHJBG3A29uIw4b0qyV+yqPQfceboGRXk+JZwZaDKfFbjRPsSpJ1vfZmYwpsFQQV9n/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0kEHzIy; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0kEHzIy"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1305908ae11so5498083c88.1
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 06:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778072644; cv=none;
        d=google.com; s=arc-20240605;
        b=jy55qxMdWsDDxV4nfZirOGjGwTo3dxqVtL288cOUwki7V12mwR9s5mDMpbePkrIN7M
         XWy88Atx+thV9yIvcnzamtYTZevEIC4z1YPd9YLAz2g60hHJuqFa4ea//b05kMRHC01C
         cGtIaIXY+3hgzw2vU+XllFrz7efUKpPgOaCTXOc0F0S6xwvVknMGdl21O63/uZGhVhFN
         DZ+5+dbOZ8zGuZe7xTJj8E3b7Yt6N7MGADW3JXLYei4TDTpZRTc0AY7bCuGzJdPTADcK
         0qVCExfjkLlNXislwoTUoJ7Tv2kP1KZhed0DenMVd6/I89t2c8IrD45kK9K70IZwpUzM
         on1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VyxSzMGcG4YBihOth/kzEfCuby+TU4nCMC26Shuc0DM=;
        fh=Pwrkxi6+ZZqVVDKhii2zcDd2mEjmvKOL0w8RzzuDsr8=;
        b=a/Mq1CiOHM8A/cwHq5Ghz2n/fvPHb/nGv7ylwi3QO6F43eopelxdJzz40uH8xd4AgF
         EP3Qh3Z3jzI9Jwso6lT7+vAerQ+meg4h9E/nng9dhTWR+f5EfsBHJJhCTErnzDyCTJzs
         wtxQDq7NU5yPnBjr2yU5lpppYSVN5mLwaDclXO54IAoCilzxSpXui5L7zSwbJn6op/oD
         ulOKuIHR3fjczB5jiLYklZjNllE97j8VJA8j6yPAPjENG9T2rPouAzFAwnr554bEwM/o
         gZyCRr9fxsmXBzxOornY9mS9ylJf1HtdpDtYnlqq5fVhmVoFUgveuaKJ2hH73tAXPpgv
         zODg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778072644; x=1778677444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyxSzMGcG4YBihOth/kzEfCuby+TU4nCMC26Shuc0DM=;
        b=C0kEHzIyDwhVBmmjqxqHzs21svB+wnu99Y5niHFkAha16rE2wnsglrZgYOmOSlVbPA
         cmRrDaGaZ1uEnnMs1zi8/cO6O92ahFth3+1qqRQeKjTI+52e33nZU8vBbN465FqNBhGS
         CjAV27De+QhJMSPaoehxd0uUr94xvdXHjGCi0QegZLdiOUTYJMCtN/IqTbbHt7702/5R
         DSpAU43AFxuWBjdTDIUag3fGcllLiUcVI64kD/x4LNIGq/UUhSjpUU0bL+m6nZAfnaqO
         dvTUVekDpehqbDhaZ8HUuoQpZ0KnXS7nLzNR1SmZFUbz0syR1Z2hSClQRwiZpM40DFiV
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778072644; x=1778677444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyxSzMGcG4YBihOth/kzEfCuby+TU4nCMC26Shuc0DM=;
        b=GtBFR08V4gwdDPCyKMPWBXUty4NtzV1QyMH57Q3MrXysjW83gm7GzDETGDdDoc3YHy
         6LZn3AVo0Jvf9/yPOHeb5LN0UXcz5jIU3S8HjPOH3CY6PMQOsY1xqL7EMMgMVq3Xb7XY
         q0s5ADOBFYGKlDXLG02yjNoCBkWpyJv7GzHyH3rKbVuvMYkZd/8YtZcVhN5zG4l5bG0b
         12nXj1HvQ8HaiJxTEcmKrU/ebXSy5SMFtl1R56MJXguRGAV+wTU16XjJcLIi/tm79DZL
         nbfAofa7LAQmIprGdQjVzWFuJwzf0SNNecqfugQkvaByNcNKptUxtcy1ROqCmZKwVkvu
         rrNA==
X-Forwarded-Encrypted: i=1; AFNElJ9g9EqjEOn/jwsiyo5/n2ifRJwHOmV8RW4Kpmc9puLmMT0WeLFzUmkKgOD7BEUkZeJcl0a/DS51YcW/m5crHFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3WUvJs7AJ/88VyjsLwK8RlgI26V5YgLNq6r4qotzUxtCnlZm
	tiaaW1X9mesdNY7I9Ta2tFi0HW3HR7sMNPb74oyMQLQYkauwxJ4IaLo0HbK7KSx8isDiMF4ECid
	XCQdg3l+grIr0uUrY8koMMPsbEE6enc1AiNF6y47Z
X-Gm-Gg: AeBDievoVeR1lJlWI6YnFMWhvKbJNKsYFawfXOXi0qa3+GuEQkL0urdtBnbU305RGvN
	jhf4zvK5V+mt9GC6vDq6KED4e4DBuTjHqlbi0ETmqAMddEatkE+TXrfOMmcvpm9PiFYtlj5IkoR
	H5Igw6IiaeZTdMTNagGES2BOgd4/LcF8hmfdagBXtzHNhKDwVUg3SNdqJvDCfsxht4TheBPzJ9g
	DWjwa+Mj+cQX1+uXPSHefKVgyAzzKoxRUDxmfgBiPuNTL7fAHxGiMx2hoGJsxqawFYtYH7IZW0Q
	1DP15s0Bh2gQMjimzBpAzapTxTq0aT5MzhCJPxJFGIXhcpDMiYFjxEeFke46KtgHJAG7ujI=
X-Received: by 2002:a05:7022:ec0b:b0:12d:f7a6:e641 with SMTP id
 a92af1059eb24-1318e9178d9mr1882135c88.25.1778072643669; Wed, 06 May 2026
 06:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132427.2703076-1-elver@google.com> <6f2bd63a-dc02-4631-a3a5-7ec8e58a4a4e@kernel.org>
 <afkOMIPu1WNFE9MS@elver.google.com>
In-Reply-To: <afkOMIPu1WNFE9MS@elver.google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 May 2026 15:03:27 +0200
X-Gm-Features: AVHnY4I_sIIXoZtb7Dp2LdZncViXZn8dSOWAzjV1MMogggcywyvPBFhYkIJG5fI
Message-ID: <CANpmjNM261J5qefMvmUXWZGBVz-KBs7GkbpdNMfTOvNJ-=LiZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] slab: support for compiler-assisted type-based
 slab cache partitioning
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 23:23, Marco Elver <elver@google.com> wrote:
>
> On Thu, Apr 30, 2026 at 03:03PM +0200, Vlastimil Babka (SUSE) wrote:
> > On 4/24/26 15:24, Marco Elver wrote:
> >
> > > @@ -938,7 +968,7 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> > >   * Try really hard to succeed the allocation but fail
> > >   * eventually.
> > >   */
> > > -static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
> > > +static __always_inline __alloc_size(1) void *_kmalloc_noprof(size_t size, gfp_t flags, kmalloc_token_t token)
> > >  {
> > >     if (__builtin_constant_p(size) && size) {
> > >             unsigned int index;
> > > @@ -948,14 +978,16 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
> > >
> > >             index = kmalloc_index(size);
> > >             return __kmalloc_cache_noprof(
> > > -                           kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> > > +                           kmalloc_caches[kmalloc_type(flags, token)][index],
> >
> > While reviewing this, it occured to me we might have been using _RET_IP_
> > here in a suboptimal way ever since this was introduced. Since this is all
> > inlined, shouldn't have we been using _THIS_IP_ to really randomize using
> > the kmalloc() callsite, and not its parent?
> >
> > And after this patch, we get the token passed to _kmalloc_noprof()...
> >
> > >                             flags, size);
> > >     }
> > > -   return __kmalloc_noprof(size, flags);
> > > +   return __kmalloc_noprof(PASS_KMALLOC_PARAMS(size, NULL, token), flags);
> >
> > ... and used also here for the non-constant-size, where previously
> > __kmalloc_noprof() (not inline function) would correctly use _RET_IP_ on its
> > own ...
> >
> > >  }
> > > +#define kmalloc_noprof(...)                        _kmalloc_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
> >
> > ... and the token comes from here. With random partitioning that's
> > #define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
> >
> > so that AFAIK makes the situation worse as now the cases without constant
> > size also start randomizing by the parent callsite and not the kmalloc callsite.
> >
> > But there are many users of __kmalloc_token() and maybe some are corrent in
> > using _RET_IP_, I haven't checked, maybe we'll need two variants, or further
> > change things around.
>
> Good catch. I don't think we need multiple variants (otherwise the TYPED
> variant would be broken) - we're moving token generation to the callers
> (not even inlined anymore) with all this macro magic.
>
> I think this is all we need:
>
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -503,7 +503,7 @@ int kmem_cache_shrink(struct kmem_cache *s);
>  typedef struct { unsigned long v; } kmalloc_token_t;
>  #ifdef CONFIG_KMALLOC_PARTITION_RANDOM
>  extern unsigned long random_kmalloc_seed;
> -#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
> +#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _THIS_IP_ })
>  #elif defined(CONFIG_KMALLOC_PARTITION_TYPED)
>  #define __kmalloc_token(...) ((kmalloc_token_t){ .v = __builtin_infer_alloc_token(__VA_ARGS__) })
>  #endif
>
> Plus a paragraph in the commit message.  Let me add that.

Bah, this is why it doesn't work:

>> drivers/gpu/drm/msm/msm_gpu.c:272:4: error: cannot jump from this indirect goto statement to one of its possible targets
     272 |                         drm_exec_retry_on_contention(&exec);
         |                         ^
   include/drm/drm_exec.h:123:4: note: expanded from macro
'drm_exec_retry_on_contention'
     123 |                         goto *__drm_exec_retry_ptr;             \
         |                         ^
   drivers/gpu/drm/msm/msm_gpu.c:304:16: note: possible target of
indirect goto statement
     304 |                 state->bos = kcalloc(submit->nr_bos,
         |                              ^
   include/linux/slab.h:1173:34: note: expanded from macro 'kcalloc'
    1173 | #define kcalloc(n, size, flags)         kmalloc_array(n,
size, (flags) | __GFP_ZERO)
         |                                         ^
   include/linux/slab.h:1133:42: note: expanded from macro 'kmalloc_array'
    1133 | #define kmalloc_array(...)
alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                             ^
   include/linux/slab.h:1132:71: note: expanded from macro
'kmalloc_array_noprof'
    1132 | #define kmalloc_array_noprof(...)
_kmalloc_array_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
         |
                       ^
   include/linux/slab.h:506:55: note: expanded from macro '__kmalloc_token'
     506 | #define __kmalloc_token(...) ((kmalloc_token_t){ .v = _THIS_IP_ })
         |                                                       ^
   include/linux/instruction_pointer.h:10:41: note: expanded from
macro '_THIS_IP_'
      10 | #define _THIS_IP_  ({ __label__ __here; __here: (unsigned
long)&&__here; })
         |                                         ^
   drivers/gpu/drm/msm/msm_gpu.c:304:16: note: jump enters a statement
expression


Apparently using _THIS_IP_ creates a possible indirect jump target,
but because it's in a statement expression, it's invalid, so the
compiler complains. This is obviously nonsense, because the actual
indirect jump in this gpu driver code would never jump to the
_THIS_IP_ __here label, but that's what it is.

Given this pre-existing issue, we probably need to continue using
_RET_IP_, as before. I tried to fix _THIS_IP_, but it's incredibly
brittle (e.g. __always_inline function returning address of label
doesn't work on Clang, but would on GCC).
