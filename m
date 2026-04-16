Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D623B9604
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347016; cv=pass; b=VpR1LRqN3EU970C/5BQUoafkuUotuplE/eZbDtGvtAbLgUJlpPqkLd7wcIDmYnQOy7tUj3pBzN+1cgMqA5r4sJLVYgrEMaFnr3Ycy17wmxaEqurMNEToZVgu4crvliyQzpd/SKpzv4rl+FW5BkmmPn5IksX86VTy5ITcS2h0CP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347016; c=relaxed/simple;
	bh=kxOvVjqTd7DGEEZRsCC5oBNM7Qjhq1uj+hNMJ9dzIwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMzMEaObpanHpSGotGkNM2U1DSx7gYap11naeSBULeyvETZAbnQrELoyiBfOJuzt1wt3V7vK0Sq/I/KiPzIpwQKKB7GU8XSUY8h3gvjhITfALcB0np00xSPq0btDHGQ/AvtvOYap2jJ8w7DAHTiIByhrj2PYR/Xb1LU7dW/4MyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UndI+2Uo; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UndI+2Uo"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c080efc1eso502729c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 06:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347013; cv=none;
        d=google.com; s=arc-20240605;
        b=P+9lnFKfCqUHF2OhFGU3R+fZ74F9lT8YXdfGFHzlbGxDWLZsPYyvkmYAd21I9SA6gK
         3N5+Xv9TwtlozTJZkySPHj3BNrirbqTMbWHk1tdGxTr+ttBfQrSECfFUpLY/+66Hp/t8
         csGGk9i/JidtI3C4Q5K2Z+BJTCIlJdQc9sgbvlaVqXCbtYAV4OPgzhTZfdtVzEhCWVaP
         OW3XRAELKen2n5bPaiu1tQxvXTEZEOaJuyw+5licX3EwXYlbxwdNglMtEXEQsu1NiAQZ
         Z9WYA6bUHr6sXy6gaxI8fCAYU9wWgxvMpEsGFyKfcBxehqk0ll+KJ+xL3Ll50LSJQBcR
         k/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjOGwsDBOUpGKkFXC9SNbDoonfQ12TYXzDLlbb+FREQ=;
        fh=FN6jryBOHoOhRhRoGWr9/DTrht/3ZW9fQ5tCGSaFBIg=;
        b=bomLE1WhVKGABvBkJAfRCpyissxgRXgJslm+8Q8g3oLL/2F36MNZe08ajI0qNTQWz6
         7hVJQt4bVGpTZPMs8VStMPCsKxwvYX7kas0l+iVQUfV2Pcfjc/mbJUH3euOVprae1bU+
         uUQbuEGDpX5FHo/K08fGVpuCjBfaqpOQzvcMzFFVkO86wtUwqNmZfDOz8TKXqxGWZRk0
         4VM6JZzQhcqWMfsIltjpK6BsjUzOlQBqVdVOzOrnwvf6l9I8wylIXo2CHbs4XkGZzEvq
         InYNagdzl4UuvcFtCrtw8h0xV8pvUH/VCgPskLoxVdb5djHdAkrvUagfRFTVytkND+75
         DrAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776347013; x=1776951813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjOGwsDBOUpGKkFXC9SNbDoonfQ12TYXzDLlbb+FREQ=;
        b=UndI+2UoWQ6NXmS++oMPVLopDmEfWXMNBykpjx4ivtaTqBsL6BBO2ibHwTL7owAnGA
         cXBdm5zfMjLq50BP1frV98bXTLcC5zosCVTPXWuMi2W6V6lWFHpUNZS1wUZmtVM/W0Vl
         L/TJyqufbXM3wV/kTLV08eTGijjS/r5kEO7cZ45ZFp1uS1PqGb6AEAcrg2FnH1DxIvfv
         akKwKfwqI4Wse+Jaz6tWcd+Ee9JiQpInsdeeAWR+T9eK4sfjpG1rYLTd2BxD/yaXrFtl
         OtLIRPjAsiPNEBwe5AhNyxYIMJLRZcbqPrUjx8Pcue+4SP8abd7RYsjxIF6MrzdIHtLr
         pLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347013; x=1776951813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjOGwsDBOUpGKkFXC9SNbDoonfQ12TYXzDLlbb+FREQ=;
        b=GyPX55StXinx64UWsUoRrpr+b/l1N3MYgGHlsJhBbvWKgDWi+QyZbdjD2lOsrAfzbn
         Xmaul7rPr3JP0jzveQlBKyJom9kzBiSeQ5iqqaKBNQbd4FVHOS2kshlE4qVSw2J+Qd5X
         SkKTRmJX2rSH79Cul2nCWFytNJEjFlald7/7QibfNLoQcchuKwF9egsKo+81rbReELMQ
         1hA2t+JCRA/HtwkXnAf9DFFhEv4YBqoD/wWbufHTBHori/qxuHW4kfEhTmFHPKCpSbfZ
         BqIEEuO7tcjK6Mfl1Di4Yh261F4cE0Xmzdp9iVXU7NLshBRyWDD0FunaOm4t/VfnevL3
         TF7g==
X-Forwarded-Encrypted: i=1; AFNElJ9Da/NNsqtkIxIfmMjkqYminLJzXAqh8d2TGH+5Vpp0w4qR9C7K2qbAT2diELNxgnYNFufG5VoRLpxJi+QtLjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Rzaf5cF74AMArli07tm8htTRCJkhPaGo5gF9b6mQaDsutJJa
	fRLLjSSvgAXySeBo4ildA0QSd5SoN230bYirfcr7k6j9+eu8kITNsSLrVuKeGoGKrVXzwOrcg2t
	89E6PrCn1v8ZQk7F+T2SG2ZW+Uy0nVUfEsWjWLSLT
X-Gm-Gg: AeBDiev13heQA6R7fNKNCZEVFtNbPxEd0N5DnfxW7acLW636R8PNsBG+dsDkDHYBkAT
	bNPJfbCuEZ5I9kucXHzDJ5+zQXsTh1hXmHpZ6iZ/41JlLj2qHHwZKtHGyIxZ6MpBSqjo+niqj1y
	cbclLHRmegYPljjZBXLCmqI0iH5xhmgBQobNjzFFsKr2k73lRi1/wZZuUb8TUHJ8R1LikRzuXPC
	LdiRfxeyNwpLD5tCMWLDQAncV3EqhIKVa93+L+idts7AgZeKTjoV2e5JCi7RaDWkidwji4LvkZz
	R0DWWiuYjBmEC84uZKepK+jpNy0DohmAaWmuyw7/8mCBbhHa7Dv9LupQBw==
X-Received: by 2002:a05:7022:ef0e:b0:12c:43:3ffc with SMTP id
 a92af1059eb24-12c62f5a7fcmr1810164c88.0.1776347012365; Thu, 16 Apr 2026
 06:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415143735.2974230-1-elver@google.com>
In-Reply-To: <20260415143735.2974230-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 16 Apr 2026 15:42:55 +0200
X-Gm-Features: AQROBzAfkSpT2OeUn44qCzMc1NnP0-wCVBwGgeL2FJ0Hvp5au7FJaosCLAeJDF0
Message-ID: <CANpmjNPfunKnU=S9Gty-7MaO-3eJ2PUR=LZNd37pmgRwQDruCA@mail.gmail.com>
Subject: Re: [PATCH v2] slab: support for compiler-assisted type-based slab
 cache partitioning
To: elver@google.com, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, 
	Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 16:37, Marco Elver <elver@google.com> wrote:
>
> Rework the general infrastructure around RANDOM_KMALLOC_CACHES into more
> flexible PARTITION_KMALLOC_CACHES, with the former being a partitioning
> mode of the latter.
>
> Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages a feature
> available in Clang 22 and later, called "allocation tokens" via
> __builtin_infer_alloc_token [1]. Unlike RANDOM_KMALLOC_CACHES, this mode
> deterministically assigns a slab cache to an allocation of type T,
> regardless of allocation site.
>
> The builtin __builtin_infer_alloc_token(<malloc-args>, ...) instructs
> the compiler to infer an allocation type from arguments commonly passed
> to memory-allocating functions and returns a type-derived token ID. The
> implementation passes kmalloc-args to the builtin: the compiler performs
> best-effort type inference, and then recognizes common patterns such as
> `kmalloc(sizeof(T), ...)`, `kmalloc(sizeof(T) * n, ...)`, but also
> `(T *)kmalloc(...)`. Where the compiler fails to infer a type the
> fallback token (default: 0) is chosen.
>
> Note: kmalloc_obj(..) APIs fix the pattern how size and result type are
> expressed, and therefore ensures there's not much drift in which
> patterns the compiler needs to recognize. Specifically, kmalloc_obj()
> and friends expand to `(TYPE *)KMALLOC(__obj_size, GFP)`, which the
> compiler recognizes via the cast to TYPE*.
>
> Clang's default token ID calculation is described as [1]:
>
>    typehashpointersplit: This mode assigns a token ID based on the hash
>    of the allocated type's name, where the top half ID-space is reserved
>    for types that contain pointers and the bottom half for types that do
>    not contain pointers.
>
> Separating pointer-containing objects from pointerless objects and data
> allocations can help mitigate certain classes of memory corruption
> exploits [2]: attackers who gains a buffer overflow on a primitive
> buffer cannot use it to directly corrupt pointers or other critical
> metadata in an object residing in a different, isolated heap region.
>
> It is important to note that heap isolation strategies offer a
> best-effort approach, and do not provide a 100% security guarantee,
> albeit achievable at relatively low performance cost. Note that this
> also does not prevent cross-cache attacks: while waiting for future
> features like SLAB_VIRTUAL [3] to provide physical page isolation, this
> feature should be deployed alongside SHUFFLE_PAGE_ALLOCATOR and
> init_on_free=1 to mitigate cross-cache attacks and page-reuse attacks as
> much as possible today.
>
> With all that, my kernel (x86 defconfig) shows me a histogram of slab
> cache object distribution per /proc/slabinfo (after boot):
>
>   <slab cache>      <objs> <hist>
>   kmalloc-part-15    1465  ++++++++++++++
>   kmalloc-part-14    2988  +++++++++++++++++++++++++++++
>   kmalloc-part-13    1656  ++++++++++++++++
>   kmalloc-part-12    1045  ++++++++++
>   kmalloc-part-11    1697  ++++++++++++++++
>   kmalloc-part-10    1489  ++++++++++++++
>   kmalloc-part-09     965  +++++++++
>   kmalloc-part-08     710  +++++++
>   kmalloc-part-07     100  +
>   kmalloc-part-06     217  ++
>   kmalloc-part-05     105  +
>   kmalloc-part-04    4047  ++++++++++++++++++++++++++++++++++++++++
>   kmalloc-part-03     183  +
>   kmalloc-part-02     283  ++
>   kmalloc-part-01     316  +++
>   kmalloc            1422  ++++++++++++++
>
> The above /proc/slabinfo snapshot shows me there are 6673 allocated
> objects (slabs 00 - 07) that the compiler claims contain no pointers or
> it was unable to infer the type of, and 12015 objects that contain
> pointers (slabs 08 - 15). On a whole, this looks relatively sane.
>
> Additionally, when I compile my kernel with -Rpass=alloc-token, which
> provides diagnostics where (after dead-code elimination) type inference
> failed, I see 186 allocation sites where the compiler failed to identify
> a type (down from 966 when I sent the RFC [4]). Some initial review
> confirms these are mostly variable sized buffers, but also include
> structs with trailing flexible length arrays.
>
> Link: https://clang.llvm.org/docs/AllocToken.html [1]
> Link: https://blog.dfsec.com/ios/2025/05/30/blasting-past-ios-18/ [2]
> Link: https://lwn.net/Articles/944647/ [3]
> Link: https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/ [4]
> Link: https://discourse.llvm.org/t/rfc-a-framework-for-allocator-partitioning-hints/87434
> Acked-by: GONG Ruiqi <gongruiqi1@huawei.com>
> Co-developed-by: Harry Yoo (Oracle) <harry@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

Sashiko found 2 latent issues in the diff context :
https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
The fix is here:
https://lore.kernel.org/all/20260416132837.3787694-1-elver@google.com/

The irony is that TYPED_KMALLOC_CACHES would have helped mitigate this
kind of overflow bug.
