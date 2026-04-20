Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADA389104
	for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677464; cv=pass; b=ORlEF044DPG8R3gSg3XAFRc5aa1KdkAhTkxk9jovYRQqvXfdEJgeDgpcuT9s/1LjEgi4huoHHvp0aNujsCjHl9KQcpqAOpvyfM1YfA9ffCkNrIWU0kgw3Ed1e8kCdIA8Ev4n/ncHtUtbSwokoQ+3Os+fu8GpTPjtin0XpqMWbw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677464; c=relaxed/simple;
	bh=AYtIN+DV/14zAGGZ+sPiagOSGUF1db+pHMUYlKur3JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVXELASMfEZxk0RSDIyAF4PjL1JwsNJXrNIlJtCCuq+rIxkwIb9br2ZWPqK+En7p+4UT0G1sT1xYY4YVKC5aFfW+DLD6JR4SjPTPILQ+/uIfQ903VlHwfo4eTVQsYXU8GSYpfiPj5hCo63GcVK9mZ3l3yffF2PD3xMYs2gkC7Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qu9qLn8H; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu9qLn8H"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8f9846c8so602194c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 02:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776677461; cv=none;
        d=google.com; s=arc-20240605;
        b=TyR1ELA8gqSyVmWJRcgiP9cCKfbDUl0eYS6YVnk4YoDI3uaoBKgGTdDihHijQkwXpm
         R2z93Jhasc2ywXMBNMjR8jszaMOUNE3rXAc2AW6diUyAmwgZ7+rbZYU326uhuCoZvHNr
         ipiYLu3zcgCrqkbQaoFuooG9Rz4+eBVJr1HgemZZ3A25XBO0OMg4g8wy+Ql53mFbR9rd
         wWUEJWaDQyLCTjF0B9Cu0xBhrnjEOTIvSlMu7LAJ7R1mhh3VNzZMvFM5fRxJaQsyQFz4
         Wb46Y6XkquiTuh+P69jmNKaRH5ReQ3aj0WLqKjaoR/6WOIt5U9m4oAfeIfAHEswbnfMS
         00xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Psv86sYw6WRRa2dc8XVnn4F/sQNlqX7p+36B++yB2PI=;
        fh=L5hmB2dHCsjuXK9sZ1Hjdvn+9dPX9vVSGOyhszKQ6MU=;
        b=Xt6iDyGxPrigH4Spz9ihkKpIFRMVSdrA7fpubrp8xvepKQDd8FoN6x5ukm3jm3p4Z3
         MdqdarekN55SNKHZk2PE4fyhdAVPb+elCldDYhhN37MABo+I1Eiwwyt+d6S/pMag5b0o
         +9fGSAP7tu5ub+IdYzGls6GzeS7WTkg53lHsmL72GgWdCBzVW13rUUSSPFqRknR6OGtj
         yaQyd0cXPC3UWEzm4RxwUojtR01MNRwQMcj+3Zgic3c19+31wmBdoTRBFD4Y7+FKMJPL
         /+nWEYNXog+8Z7nyKHNekSYDQoXmDUZR4z+YaCBUuU0roB24/fDLTo5ybSl6mNKWcnj7
         y9Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776677461; x=1777282261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Psv86sYw6WRRa2dc8XVnn4F/sQNlqX7p+36B++yB2PI=;
        b=qu9qLn8HHz61QR5V3SW7GrkOXBE5+bE97lfJkh6JZtn0V3ujhGqkUJb4wbV0pBRXc0
         QVJ8bXEFow/sWF5JhZ+oco58ZhXnG20vZMHXwyS60vLu5yEkMBmcC32msNmCGOIofjDL
         Z6tOOnCV0apr6slgRcgAshqO2yq02vHqk0t+d7o+F3BsklOWSZncR8/ups4LAbMbYHPi
         DY6SVMw83CC7IsHPRXPDeNhxVgkcu5RTwfL1t8uf267UYW/+kj0hhYQEKgx2l0rZ+Z9Y
         DZY2vQ3U4COK2q+XBazjAomqkMQoBQ69lw4pB5VEU9lDUw6rAbDGtVrblJv3pUpcHJ5u
         IQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677461; x=1777282261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psv86sYw6WRRa2dc8XVnn4F/sQNlqX7p+36B++yB2PI=;
        b=sar15ilCXXgPL2RH5VKbJaPth3NPlfzNcfLa65A3bT2GBFoq9GjUhjO/tmmUTXdEAN
         8ZAReFdlisNk+LZ8xpkYdExppmexrTsYCS0bsNA1Z+QAtta8ZwJqKczK/V6gwIjbnHuV
         +N7BMaTViaMjg1PF5VkPzVtBKiKBysd0SjZNkqgHKvXXQqlJJXk2w1ZGcdZZ1119s2pz
         xUWgt8mfOw7zCGbMlfaTP448PWHwbK4ik2RTIiW4cm5sAez697gv7Wei6eKQSYtBU1RT
         4IBxAtPE+ZwAsjF80bcdN7p/vKyAiXuHM0a13JflIQX8DYoTDJQeNcWuVPy/cx6LpN+c
         EjUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Tw76iaR6SKP4vVHRQBUJdYUsaoQ3HXMiBWQJCkbgZSNHvCRWqCYJKkD6kRI1tgAO0CypVntuvPvzTKnkc9eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQl5sD/rFIWv3gV2nbHMQwj/T0JWo+kH5BZnMMCuG3orkN57D
	ZHyEYxTNEMQfcRNNH7sJlya8k0OsCBDdnQhbnCkbBx96bDBKlANvlOMg0CgHfsHXwlOeglF8JPF
	Q36XApHO88SyYULkmBSiUF1iPpCKizGJq5yL5NXqy
X-Gm-Gg: AeBDietI6de8LdItxaH/RrZcHj52UTQZDewDMdtc1qo4HPT0rPm5+5yoLIeA2k3Wpaq
	MJtfHBrVIgfnIPNFOPJ3I2mVVl2dmEdNBq76rC9usWd4r96dMYP0QHiBddMz0n1DeJ/0rbtSQRk
	bt+6VhRb5iNzYNOAVWDIdWy1KBmA0sNXkugnwn1yRyWZNNOs2tXjmVQfE1qP+hbnZVrImqBKVh+
	iCqY7M1sn8Yb03dQ+kcFsB1mcWwwKNE4Gy5XgG3DCZWbJOQOrilDNRzM7NbDnHkXkb+4LQdl1Yu
	1ygJB280spn9K1oMwjPNLilkPNKc3z0uUjLHaKOxGeJ5yqFKFDTGlbWA1zLY0Xw4czX/
X-Received: by 2002:a05:7022:90a:b0:127:33e0:ea40 with SMTP id
 a92af1059eb24-12c73f7fbaamr5617278c88.15.1776677460282; Mon, 20 Apr 2026
 02:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415143735.2974230-1-elver@google.com> <aeXU-wwGSwcx2dvy@hyeyoo>
In-Reply-To: <aeXU-wwGSwcx2dvy@hyeyoo>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Apr 2026 11:30:23 +0200
X-Gm-Features: AQROBzCDqXBXEzcrST_0Skn6GXHUWSKau4IE3IO7VWholE-9v6QWyxVbFP_MsxE
Message-ID: <CANpmjNN0dYD8MB3PpPoxpz4ey2U9xA0w6oVO9hambtRwzSSkiQ@mail.gmail.com>
Subject: Re: [PATCH v2] slab: support for compiler-assisted type-based slab
 cache partitioning
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>, GONG Ruiqi <gongruiqi1@huawei.com>, 
	Danilo Krummrich <dakr@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 09:25, Harry Yoo (Oracle) <harry@kernel.org> wrote:
>
> [CC'ing RUST ALLOC folks for rust bindings]
>
> On Wed, Apr 15, 2026 at 04:37:05PM +0200, Marco Elver wrote:
> > Rework the general infrastructure around RANDOM_KMALLOC_CACHES into more
> > flexible PARTITION_KMALLOC_CACHES, with the former being a partitioning
> > mode of the latter.
> >
> > Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages a feature
> > available in Clang 22 and later, called "allocation tokens" via
> > __builtin_infer_alloc_token [1]. Unlike RANDOM_KMALLOC_CACHES, this mode
> > deterministically assigns a slab cache to an allocation of type T,
> > regardless of allocation site.
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
> > ---
> > v2:
> > * Avoid empty function argument if !PARTITION_KMALLOC_CACHES
> >   (co-developed-by Harry). While Clang does optimize out the empty
> >   struct argument (and generated code is identical to before if
> >   PARTITION_KMALLOC_CACHES is disabled), GCC doesn't do so. So we need
> >   to fully remove the argument if not actually required.
> > * Cover krealloc() which was missed before, resulting in ~100 additional
> >   objects in the pointer-containing caches in above histogram.
> > * Unify kmalloc_token_t definition.
>
> > * Expand Kconfig help text.
>
> Thanks. I find the help text much more useful.
>
> >
> > v1: https://lore.kernel.org/all/20260331111240.153913-1-elver@google.com/
> > * Rebase and switch to builtin name that was released in Clang 22.
> > * Keep RANDOM_KMALLOC_CACHES the default.
> >
> > RFC: https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
> > ---
>
> A few comments on V2:
>
> # comment 1
>
> I'm not a big fan of how k[v]realloc_node_align()
> and kmalloc_nolock() define and pass the token parameter.
>
> IMHO it'll be fine to use {DECL,PASS}_KMALLOC_PARAMS() in those
> functions, since SLAB_BUCKETS users already passes NULL bucket
> to most of __kmalloc*() calls anyway.

I'm not sure I agree. 2 reasons:

1. Even though it's "just" k[v]realloc_node_align() and
kmalloc_nolock() - despite their relatively less frequent use - just
put one of them in a hot path and you're sacrificing performance even
further. There are only so many arguments that can be passed in
registers (depending on arch), and may cause more stack spilling.

2. We'd misleadingly declare that these functions do something with
the bucket arg. This is wrong.

Both feels wrong, and would only make this change if you confirm both
are trade-offs that you strongly prefer.

> # comment 2
>
> This breaks Documentation/.
>
> Problems:
>
> - The document generator doesn't handle DECL_KMALLOC_PARAMS() well.
>
> - The signature of the function that users call (krealloc_node_align())
>   and the function that has kerneldoc (krealloc_node_align_noprof())
>   don't match.
>
> - Even worse, moving kerneldoc to the macro doesn't work because
>   it uses variable arguments (...)

Well, some were broken before, now it's just broken more. :-)

We could move the documentation to macros and switch to explicit args
instead of (...).

Otherwise, I don't see any way to fix this. Preferences?

> # comment 3
>
> Looking at how rust generates helper functions,
> in rust/helpers/slab.c:
> | // SPDX-License-Identifier: GPL-2.0
> |
> | #include <linux/slab.h>
> |
> | __rust_helper void *__must_check __realloc_size(2)
> | rust_helper_krealloc_node_align(const void *objp, size_t new_size, unsigned long align,
> |                               gfp_t flags, int node)
> | {
> |       return krealloc_node_align(objp, new_size, align, flags, node);
> | }
> |
> | __rust_helper void *__must_check __realloc_size(2)
> | rust_helper_kvrealloc_node_align(const void *p, size_t size, unsigned long align,
> |                                gfp_t flags, int node)
> | {
> |       return kvrealloc_node_align(p, size, align, flags, node);
> | }
>
> Rust code probably won't pass any meaningful token?
> (something you may want to address in the future)

Yes, it'll just pass '0' by default. We could force Rust's allocation
to be in the pointer-containing range - if we assume Rust code is less
prone to contain bugs, but the assumption is that such allocations
both originate and are confined to the Rust side. One easy way to do
this is to write:

       return kvrealloc_node_align(p, size + 0 * sizeof(long*), align,
flags, node);

But I'd defer that for now, until we're sure the above assumption
holds (Rust originated + confined).
