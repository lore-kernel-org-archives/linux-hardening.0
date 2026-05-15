Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56F382F28
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851499; cv=pass; b=dkU13DvshjO8LD3whdECkzr8oFK+nXdtiiydCySUNgLwKtCkifPVFV8y4csVWh0QD9idS8qG3NT1+OjtEWqtJTGJRPgBXj2JfxkX2HFrXaemQHcOCvSfPMuGbO34r2fwKhP0GCyMnCJzjXB3FvyPXToNq5npBmARrsL8ei0OBa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851499; c=relaxed/simple;
	bh=9S/wyijREW7prxTs0cpddfr7+xTXmq79rJi7zvdyiio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmqA7OcqdGBEO1NMbK6k2n9N4kFD7qJNgH3AH1eefrtFDSUQ6KZV/iGZ+Ar6Ty19talOnbB2DBo1m95QwMQlqaN6qwH4a/gxaLN/H75BlPnlbKaOE1pKCFJY/BtjQI/LcfTnF0kMHxVR+cpSf5/kPxevXINXrKS49ghAgB9fkQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4kOdYLl; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4kOdYLl"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c19d23b19so15209758c88.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 06:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851494; cv=none;
        d=google.com; s=arc-20240605;
        b=LbCipTUcdRZldF9+uC1m/10fEPqtLysc0Rf4NmFjIAT0sIxf7x6oPgQLYeTDrikanH
         RSuRC29Q9uh+nSmtnSSCWvWVnMAzXBbwb4get6AWXD23k98Rka05wduoB6m56tquXXjP
         9jCfKqoIKbS3mSrBzAc8kPIGrTaCqgwxEuC/c1gU+eLLjNkQbq5tthl6XU+K4O9jCLnR
         UxJfXOVK9Xq6C3Ogy8pAMhYVcBZKSX/ye37jQ4arAxPSHQxmADCSsGLBgExall8t0tFL
         hhy0ue+82R5i+gEwMISkYG/8BZ8mOaKgpi8o6BgqcgWnUOwKMRwuYJ6nX8VVOnEhyg7S
         oFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kJkIJ9MSSyAx7AMR5IamH1iN68B4UTFJP9CxVTr4bw8=;
        fh=aQM3dD2sx5303Er/gx8pQYIC4ZVq1Arn6kMFnra6SbM=;
        b=TIeGHtEHRLVHdNezDoPuLtyfWEpiqhP2b4Yv+gIu89xV/SE4mUw4GijKqH6lAnWHpI
         Gu7FimBANq2WApt7GjAgB88uUK223ibe0LL5br+3k+I+RQ7gpc5durVJOTkn+m1tqPzU
         1lw+Xqt4xA44h9BN25iI2fdcOX/LXiAHiiClxcTACQNVIj1q2pEnM+TI8KWl6pp6bTsM
         KvMwehZSNujkSmLqLXC75SrwHUX57ryCu4l9CEsmG+q/KvH9qsXYxzPyQyxm3BHgTfL6
         vdZQsp1t+9yrtCtDza35UDy8EBEPi+XZbSetrsGVOU70NK7O4OqvxD0xpZ0bTuvQyd2A
         CMBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778851494; x=1779456294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJkIJ9MSSyAx7AMR5IamH1iN68B4UTFJP9CxVTr4bw8=;
        b=s4kOdYLl+H/jtAnbqbvOEB+dbYZp7Repr3O/lj/BO58Ty493AoK2/dmP8jzC0OnQhA
         lknsCDwovXEvLM5NM7I28D7thoVsrpyH3YKXxh78fBybR7DQcs27zq1m/mCLT1m+tJzJ
         JKOQ2Njjrmv5n2/5l3iMLrOl3+LHxwD4n6ab/ES59MLGWdlRKpAQ4nv9HR+OzE4vGm0s
         RIWP6tJs63VCihku14pdJ5eAp1zDPxsRxO4DrARLWMQqLUSyAbgKtyrPGd5B+/xu+Eta
         FW5TyW3w0PfMLVUCb9hu3Tzja86RsBuif4pWoC7p4LDSmyvh6kMTu5+RDJxmcaaXfe/x
         xexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851494; x=1779456294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJkIJ9MSSyAx7AMR5IamH1iN68B4UTFJP9CxVTr4bw8=;
        b=IO5l37c6n5XB8jySvSFz7arJs/YQtjLPNobpvgWPhXxuWNpGntsaEZkla1uvf34C8R
         6MlMj4O1iJgkKbkNdfWM5OAG2v2ckpTK1Stsb7o460U77nIi5V4KeuWUJ+fhIe6zr3Ic
         574CfqSn4IPMYEA0mbs5AD8hipZYw+btl15eXkyx/tMGN6kjC/tuUsLE0h/HQrGTTnV/
         4V4J9HdRy1LClEOVa6BftDUSCkJLhCZNXcWvns3YwEcbO2BXeEl6m3SDzF1nY7esSA5d
         7y+ghZsKlIAXVSaA82qw8PWH7wGFj9oeY6Cyf0f46HwWECKfKGkN3dtTt7FHiFNUBlZl
         eS2w==
X-Forwarded-Encrypted: i=1; AFNElJ/jSbtOdpTJjSli4DgntxCRtVOc/RHC6QSXamAk5rCL1GAlBdILvNslfI8B73lOfKaGyIMHLbr0jF0gas/m8ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAR+REMNGpdIgVr11uIUf+t7bT3Es2Pa8MVfjc2XhgA+JrhT+
	RXcc1e5vhIvNCV7vwEXG8P2CO9XQsxLxxpy31UaBRMLGAeIAsx+KqHBE8MJWyOx0iVtMXS/ar6O
	EDFBWTQRRLGn/nb53jsaxi9SKeinQjuEJtA8RjuY2
X-Gm-Gg: Acq92OFaVWkCTI/qUu4mKNifGf0pEavaLZ5wcaEFnOFtDxhD3ZlTFUilVpSD1ZbvcN4
	gfi16HbPr0foNX4F06hcuXlyRmT3Yd8zDYJHjPJTGMnED1J8hl/ftiKpYBe0pgEWCe4jY+hLolB
	ZQbTTOf15wUl/w2lVht2pTTrfD4Rymaw/YGUZ95mc757UUX0wv8mq1oZQ3ZpXTvmszBjHQIbCSh
	BZumO1VZ4N63Uo9gf8BymCA6SCNJLszti59uMZMlXrT56G4XeIRl8ZzkfqepN81Rai5pJcCHJ9P
	y0uKRmAq0+jnz5e5s6T77gTaPwTUY/Ius0Azx7XhFv7KdXMm
X-Received: by 2002:a05:7022:62aa:b0:12a:72af:83d2 with SMTP id
 a92af1059eb24-1350441d7ccmr1656610c88.14.1778851492906; Fri, 15 May 2026
 06:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511200136.3201646-1-elver@google.com> <560a84ed-7daf-4a78-a314-b867c73bce22@kernel.org>
In-Reply-To: <560a84ed-7daf-4a78-a314-b867c73bce22@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 15 May 2026 15:24:16 +0200
X-Gm-Features: AVHnY4IK86MdHMyPl5dB4zdZDdnYGN0oaLGQAymJ1xrwo4kBW5Idcq4vVdQ8Oeg
Message-ID: <CANpmjNNHXvv8ruFGHzvom5V0mwmaoBoBenvt=ZLnEDmEy8dYeA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] slab: support for compiler-assisted type-based
 slab cache partitioning
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, 
	David Hildenbrand <david@kernel.org>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-hardening@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	GONG Ruiqi <gongruiqi1@huawei.com>, Jonathan Corbet <corbet@lwn.net>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 11:01, Vlastimil Babka (SUSE) <vbabka@kernel.org> wrote:
>
> On 5/11/26 22:00, Marco Elver wrote:
> > Rework the general infrastructure around RANDOM_KMALLOC_CACHES into more
> > flexible KMALLOC_PARTITION_CACHES, with the former being a partitioning
> > mode of the latter.
> >
> > Introduce a new mode, KMALLOC_PARTITION_TYPED, which leverages a feature
> > available in Clang 22 and later, called "allocation tokens" via
> > __builtin_infer_alloc_token() [1]. Unlike KMALLOC_PARTITION_RANDOM
> > (formerly RANDOM_KMALLOC_CACHES), this mode deterministically assigns a
> > slab cache to an allocation of type T, regardless of allocation site.
> >
> > The builtin __builtin_infer_alloc_token(<malloc-args>, ...) instructs
> > the compiler to infer an allocation type from arguments commonly passed
> > to memory-allocating functions and returns a type-derived token ID. The
> > implementation passes kmalloc-args to the builtin: the compiler performs
> > best-effort type inference, and then recognizes common patterns such as
> > `kmalloc(sizeof(T), ...)`, `kmalloc(sizeof(T) * n, ...)`, but also
> > `(T *)kmalloc(...)`. Where the compiler fails to infer a type the
> > fallback token (default: 0) is chosen.
> >
> > Note: kmalloc_obj(..) APIs fix the pattern how size and result type are
> > expressed, and therefore ensures there's not much drift in which
> > patterns the compiler needs to recognize. Specifically, kmalloc_obj()
> > and friends expand to `(TYPE *)KMALLOC(__obj_size, GFP)`, which the
> > compiler recognizes via the cast to TYPE*.
> >
> > Clang's default token ID calculation is described as [1]:
> >
> >    typehashpointersplit: This mode assigns a token ID based on the hash
> >    of the allocated type's name, where the top half ID-space is reserved
> >    for types that contain pointers and the bottom half for types that do
> >    not contain pointers.
> >
> > Separating pointer-containing objects from pointerless objects and data
> > allocations can help mitigate certain classes of memory corruption
> > exploits [2]: attackers who gains a buffer overflow on a primitive
> > buffer cannot use it to directly corrupt pointers or other critical
> > metadata in an object residing in a different, isolated heap region.
> >
> > It is important to note that heap isolation strategies offer a
> > best-effort approach, and do not provide a 100% security guarantee,
> > albeit achievable at relatively low performance cost. Note that this
> > also does not prevent cross-cache attacks: while waiting for future
> > features like SLAB_VIRTUAL [3] to provide physical page isolation, this
> > feature should be deployed alongside SHUFFLE_PAGE_ALLOCATOR and
> > init_on_free=1 to mitigate cross-cache attacks and page-reuse attacks as
> > much as possible today.
> >
> > With all that, my kernel (x86 defconfig) shows me a histogram of slab
> > cache object distribution per /proc/slabinfo (after boot):
> >
> >   <slab cache>      <objs> <hist>
> >   kmalloc-part-15    1465  ++++++++++++++
> >   kmalloc-part-14    2988  +++++++++++++++++++++++++++++
> >   kmalloc-part-13    1656  ++++++++++++++++
> >   kmalloc-part-12    1045  ++++++++++
> >   kmalloc-part-11    1697  ++++++++++++++++
> >   kmalloc-part-10    1489  ++++++++++++++
> >   kmalloc-part-09     965  +++++++++
> >   kmalloc-part-08     710  +++++++
> >   kmalloc-part-07     100  +
> >   kmalloc-part-06     217  ++
> >   kmalloc-part-05     105  +
> >   kmalloc-part-04    4047  ++++++++++++++++++++++++++++++++++++++++
> >   kmalloc-part-03     183  +
> >   kmalloc-part-02     283  ++
> >   kmalloc-part-01     316  +++
> >   kmalloc            1422  ++++++++++++++
> >
> > The above /proc/slabinfo snapshot shows me there are 6673 allocated
> > objects (slabs 00 - 07) that the compiler claims contain no pointers or
> > it was unable to infer the type of, and 12015 objects that contain
> > pointers (slabs 08 - 15). On a whole, this looks relatively sane.
> >
> > Additionally, when I compile my kernel with -Rpass=alloc-token, which
> > provides diagnostics where (after dead-code elimination) type inference
> > failed, I see 186 allocation sites where the compiler failed to identify
> > a type (down from 966 when I sent the RFC [4]). Some initial review
> > confirms these are mostly variable sized buffers, but also include
> > structs with trailing flexible length arrays.
> >
> > Link: https://clang.llvm.org/docs/AllocToken.html [1]
> > Link: https://blog.dfsec.com/ios/2025/05/30/blasting-past-ios-18/ [2]
> > Link: https://lwn.net/Articles/944647/ [3]
> > Link: https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/ [4]
> > Link: https://discourse.llvm.org/t/rfc-a-framework-for-allocator-partitioning-hints/87434
> > Acked-by: GONG Ruiqi <gongruiqi1@huawei.com>
> > Co-developed-by: Harry Yoo (Oracle) <harry@kernel.org>
> > Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Applied [1] to slab/for-next, thanks. That means including the kernel-doc
> workarounds in patch 3. I know Jon said someone might hate it, but maybe it
> will motivate them for creating a proper fix :) It seems better than leaving
> doc generation broken or not applying this series at all.

Thanks!

> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-7.2/alloc_token
>
> I did the following fixup to remove passing an unnecessary NULL argument for
> __kmalloc_nolock() with buckets enabled. Made bloat-o-meter happier a bit.

Good.

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c232f8a10af6..795455256329 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -894,7 +894,7 @@ unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf);
>   * with the exception of kunit tests
>   */
>
> -void *__kmalloc_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags)
> +void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
>                                 __assume_kmalloc_alignment __alloc_size(1);
>
>  void *__kmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags, int node)
> @@ -981,7 +981,7 @@ static __always_inline __alloc_size(1) void *_kmalloc_noprof(size_t size, gfp_t
>                                 kmalloc_caches[kmalloc_type(flags, token)][index],
>                                 flags, size);
>         }
> -       return __kmalloc_noprof(PASS_KMALLOC_PARAMS(size, NULL, token), flags);
> +       return __kmalloc_noprof(PASS_TOKEN_PARAMS(size, token), flags);
>  }
>  #define kmalloc_noprof(...)                    _kmalloc_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
>  #define kmalloc(...)                           alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> diff --git a/mm/slub.c b/mm/slub.c
> index a6e9015601d6..74652bbdd591 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5303,10 +5303,10 @@ void *__kmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags, in
>  }
>  EXPORT_SYMBOL(__kmalloc_node_noprof);
>
> -void *__kmalloc_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags)
> +void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
>  {
> -       return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags,
> -                                NUMA_NO_NODE, _RET_IP_, PASS_TOKEN_PARAM(token));
> +       return __do_kmalloc_node(size, NULL, flags,  NUMA_NO_NODE, _RET_IP_,
> +                                PASS_TOKEN_PARAM(token));
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);

Reviewed-by: Marco Elver <elver@google.com>

Thanks!
