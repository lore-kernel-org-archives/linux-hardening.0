Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CC153812
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080668; cv=none; b=rqmiY/ANWstfZikz7OXvUUv0IVXAAo0k59xNC7H3a2lWUNK0ckji7PgwsHGZLOb4Upv68aetBGHAdnlvJz69KromZZ3HXdAq2NkTo6DVUM7OaF0ssd+tB2XbujH0/mAhoYFRxsXre2+QH/LYVmhBnI/83fZmqDjZ4vxPpHFlj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080668; c=relaxed/simple;
	bh=EdIaLSmjCOOt1zrYXppbX+KO0j1tb2IROQCIxD2dtLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U40N76Bj8f5LbXQMLJYsv0xpNFNiemIE2+6IVhdO2JvRq9Q7GqRfecRLgloeyVRXd2RHEDN3WOnbnBVjYk8NnbanZC/kUDoUgN6LuHM89uEFDd34YwzAISd+glgYLONKIve4Pm7ZYSY+Vtrco87ujJ3bcamBtkoemrMff0L04fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4E+Ihp9+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4E+Ihp9+"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de5a4d737f1so219667276.2
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714080666; x=1714685466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiewKxmK6Ch1JRpkm+LvVPlL0LObf9hp6GU9toLILKw=;
        b=4E+Ihp9+YJGIKA7Y32l4+DoNQ10oF/03F/CEKMd9F+/UzA6RDpYmp52SZhrO7eq5I0
         w4b3Nti/Bm2vqGrJ3q6zX7N6dH/YbkF8xBq4BJgeHD1S4gpcyoKNiw1fjPHOE5eZkeSD
         wJqqhU5A4EFoz/hOd9Fea3mcVHeH3KQClp387a5NnhXMbWEK4/dshAVJdCLwDR4muTah
         LTh77KV4J51jCWeMLF+QJsP4/Qd0IFjIHr5T7Zuqtw570PAJ4JurbaP+eBoTD5SmRZ9y
         iuIC0MJq6jMGPc75CoUhaHwrQmHrJogKouP2v3UWzqfWe2/TD9pbnaKBK0XnbZa0om4J
         6wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080666; x=1714685466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiewKxmK6Ch1JRpkm+LvVPlL0LObf9hp6GU9toLILKw=;
        b=evLrPHXnEXDmeGBOnTKxFr+ipcV9MGsJceYFFW5/p+ZcYeU6+RsVMisT5rvUjap3O7
         wUgJtWcM6eXopfG0JldR1M7W5/m5xiEzgIEkTxJSaAaXps/C9BEuWACKuF/HcNGQMtQ9
         UH8a28+Ai1RkxVuXzTxFmu3bvufVJ8hkOmTV+RvK7ncad3cJPQ8DZ3G03Uu84t5ey1CR
         O+VmK7LQI0m7b/Ymnnj9AzTqBLCtItwh2I0QXlLhh1s2ScEWTUvPhASVnCIVPfhfgpo2
         SDdkQAwNqwCgfHrzO4HqA9jfXjlTVKW9DJgHuvlGXq1aZ2iFBQRmMvSz6Ei1CEMNfGS+
         Azmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpz1q/24v2H+2R8DNpemhli90EhKOaYb/dVClu6LqIFv6iBzuTwq8mNFMFZEe5p9yRsGFJQR1PNkj6fXsgo4u1MVjmctfCdvHNSLl4xm0B
X-Gm-Message-State: AOJu0YzMWTdBmb2i44IzbWOdaQiiaxWxIIcO0zH5dPQQsTzr+/8WWd1G
	cHwlwebR5pcFc44rUggsRFhjL3e/W8+ZDFWrzR2iDczPTQkAKWljI7Yk4LPKFsGK+Uqt2KeFQrM
	+2H7wU/01onhZeQzGJiNqjb99F272uf0pavu2
X-Google-Smtp-Source: AGHT+IFZ1q3ipQeESd0wnp2IqOoKRLw1VF18WtCFxq+hKgD5VNAEI4uAesWuCPJa3UPiUmszv/cPtrW09cccyfGBTmw=
X-Received: by 2002:a25:8748:0:b0:de5:5a38:8e96 with SMTP id
 e8-20020a258748000000b00de55a388e96mr968314ybn.18.1714080666108; Thu, 25 Apr
 2024 14:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425205516.work.220-kees@kernel.org> <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
In-Reply-To: <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 14:30:55 -0700
Message-ID: <CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:09=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Apr 25, 2024 at 01:55:23PM -0700, Kees Cook wrote:
> > The system will immediate fill up stack and crash when both
> > CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
> > Avoid allocation tagging of kmemleak caches, otherwise recursive
> > allocation tracking occurs.
> >
> > Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allo=
cation and free paths")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > ---
> >  mm/kmemleak.c | 4 ++--
> >  mm/slub.c     | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index c55c2cbb6837..fdcf01f62202 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t=
 gfp)
> >
> >       /* try the slab allocator first */
> >       if (object_cache) {
> > -             object =3D kmem_cache_alloc(object_cache, gfp_kmemleak_ma=
sk(gfp));
> > +             object =3D kmem_cache_alloc_noprof(object_cache, gfp_kmem=
leak_mask(gfp));
>
> What do these get accounted to, or does this now pop a warning with
> CONFIG_MEM_ALLOC_PROFILING_DEBUG?

Thanks for the fix, Kees!
I'll look into this recursion more closely to see if there is a better
way to break it. As a stopgap measure seems ok to me. I also think
it's unlikely that one would use both tracking mechanisms on the same
system.

>
> >               if (object)
> >                       return object;
> >       }
> > @@ -947,7 +947,7 @@ static void add_scan_area(unsigned long ptr, size_t=
 size, gfp_t gfp)
> >       untagged_objp =3D (unsigned long)kasan_reset_tag((void *)object->=
pointer);
> >
> >       if (scan_area_cache)
> > -             area =3D kmem_cache_alloc(scan_area_cache, gfp_kmemleak_m=
ask(gfp));
> > +             area =3D kmem_cache_alloc_noprof(scan_area_cache, gfp_kme=
mleak_mask(gfp));
> >
> >       raw_spin_lock_irqsave(&object->lock, flags);
> >       if (!area) {
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a94a0507e19c..9ae032ed17ed 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2016,7 +2016,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, =
gfp_t flags, void *p)
> >       if (!p)
> >               return NULL;
> >
> > -     if (s->flags & SLAB_NO_OBJ_EXT)
> > +     if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> >               return NULL;
> >
> >       if (flags & __GFP_NO_OBJ_EXT)
> > --
> > 2.34.1
> >
