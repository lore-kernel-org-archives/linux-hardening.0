Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEF2367D9
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205160; cv=none; b=gFBL12q29+rV5iMKFoFQ4IeR9mWd4OjuW4ZSEGzQ93VLPsAkNev4ge+uslZ/sicKPab9hnG1SZhP6BZuRTcxBdB0Gsot70hpY+7yOQ0DHVCFCwdKl5gzt1e6ZIMYT52cr6tfwYyZeu3v7X1ZVAqGxU8r7n4lkRBuH2dgsjATfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205160; c=relaxed/simple;
	bh=dCkr/rXAgWPhiFwu4T4ZQjjXUMya5djMDbNuiUF43r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK3a1sx2Cb7/i3YWfxTwXrKwLRv3/RqN5ykwE2HZO/5ywIG/YdzillUDzBaHwVwcJ4aUEDy/FwBnlFke20oxyqw0xxgQOl9ol95eKHWsYV9p+rqBGssPdSRi+GAluu88PmgalTkSyiy2x1ucX3qso9RtIub8F7tofE5NrB327wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap+5Xt7s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap+5Xt7s"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445827be70so53749925ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756205158; x=1756809958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGOLh5cQuaV0+vt4hcjFj06C3bqSM1fNgF6Sjp1p1nM=;
        b=ap+5Xt7sne3+CTlfq42cMB/p8e2sZ5tyd+YMtKPApU+B6sgqPnJw7WDCVRmNjXuiwL
         oeWh2OvJf3mVe23GF8kGvJFqleyxVnI6QZRm2dBeMeCvRfAyxt45hYItlojv5k0Qe0F4
         BCot2jD1woKVsRSWbhzx6lqD+871dp20EO4HFh/LchrI7tRTj8TJNuhARq+jBWvm55pZ
         kHECC0hBiSqo+627ZuwITc9bvfS/jHFu/wSFm9NMhvSMVq2dS4hGLug6ydvC8oI7omnY
         NpnJj14hYz30FQQD91+mada1xeeaSugOb0HUUG8YjrwtwbBTSTl6dd0QiTqsB3p8hnuV
         y+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205158; x=1756809958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGOLh5cQuaV0+vt4hcjFj06C3bqSM1fNgF6Sjp1p1nM=;
        b=TYJvT1c6fyyTsUkEmRaLxndUGZS5JLpFn9PoZ57AQaxhZGwGODscc5irlVwAbDpE6g
         kJZGJUd+NZB1P5cp62eG12VjUGy4I/t71nH0qWmahPePQeSwVLMIRysTBej5KAA868tH
         b+SonlTlBUTUocPCGwEfJNJZ+BJyyIs7XyPWkVtk0O7YSWQqb4930siAw9vw0HPVqYzN
         +vP75cj63J0sqjgYW8UCpDg3/6pf7D4nMsRwku/y70+aekLofy4rgkLHRmOqpjRHTBNo
         7PTJMHr8dLGZYSu2NPeXDMybRHQ/q3h9QgHZkJgxKo2zS3k/ndFCxIb+ylEjvsLCdrTT
         6Wlw==
X-Forwarded-Encrypted: i=1; AJvYcCUTOA02W3c+VzGzO5DD5vIbNEg4A3NJZCbU6n6a7sAXrzhjWhNJMDLn++yV+npYHfLRxQRDq+ISA92lIRLb+rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqqsa0Wp1+aXFSB6uNi6bk1eAweLwTWQjugrzw9JkGmgTd/S0
	7JIN3/UxWu4pcRXXNMkOhMTe9nmXC0lX5Lyevt803EDGTverXCkTVMCS2hUCf2kwzFnbkYIjhqX
	lOUIkW1kh5aRWiNh07qXXjtEDBoeW+rP8X0OUe48K
X-Gm-Gg: ASbGncuiI8hPxF1956mDmajq4KLp7y+BdjPeLyZ7NYw4toTuuzeNQtB0ed0B0R0QhqU
	QZltJ6AS5XFN+DtOyJ74t7Xzm6Ja+r9bC3em2IsKZcn380h6TW1OQRLK6jdOOoDiFPXMXqPrPyV
	DdTs1aUQx0yD1wwDWgkhn0vmbyE0w5ErtoxkD/+srA/2GuwxSHEU8sPD9O5PVswsiDS1oPmlhHb
	1Qe+ns4iJvhVjO3MhK3MmrVOfs=
X-Google-Smtp-Source: AGHT+IHaZIymcSNO51VzrGvkl+EzFgf+EwvT7kBpe3gUWu+Fy0TGd2k7zRtskb+cPodn3Z41b2nZl1YDZatmO+4LcFc=
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-2462ee54512mr199229855ad.25.1756205157527; Tue, 26 Aug 2025
 03:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <aKyT2UKmlznvN2jv@hyeyoo>
In-Reply-To: <aKyT2UKmlznvN2jv@hyeyoo>
From: Marco Elver <elver@google.com>
Date: Tue, 26 Aug 2025 12:45:19 +0200
X-Gm-Features: Ac12FXxpah0HkZevruBg4QeHMNDjWXsh7--6Kjx5Kp37atP55Mt7D7-5zFmt0B8
Message-ID: <CANpmjNPUsbkyg5VvzUSYqVvaScXpqdfsb_oq2PuKV6VbkZLqFA@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, David Hildenbrand <david@redhat.com>, 
	David Rientjes <rientjes@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Florent Revest <revest@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 18:49, Harry Yoo <harry.yoo@oracle.com> wrote:
[...]
> > This mechanism allows the compiler to pass a token ID derived from the
> > allocation's type to the allocator. The compiler performs best-effort
> > type inference, and recognizes idioms such as kmalloc(sizeof(T), ...).
> > Unlike RANDOM_KMALLOC_CACHES, this mode deterministically assigns a slab
> > cache to an allocation of type T, regardless of allocation site.
>
> I don't think either TYPED_KMALLOC_CACHES or RANDOM_KMALLOC_CACHES is
> strictly superior to the other (or am I wrong?).

TYPED_KMALLOC_CACHES provides stronger guarantees on how objects are
isolated; in particular, isolating (most) pointer-containing objects
from plain data objects means that it's a lot harder to gain control
of a pointer from an ordinary buffer overflow in a plain data object.

This particular proposed scheme is the result of conclusions I
gathered from various security researchers (and also reconfirmed by
e.g. [2]), and the conclusion being that many successful exploits gain
a write primitive through a vulnerable plain data allocation. That
write primitive can then be used to overwrite pointers in adjacent
objects.

In addition, I have been told by some of those security researches
(citation needed), that RANDOM_KMALLOC_CACHES actually makes some
exploits easier, because there is less "noise" in each individual slab
cache, yet a given allocation is predictably assigned to a slab cache
by its callsite (via _RET_IP_ + boot-time seed). RANDOM_KMALLOC_CACHES
does not separate pointer-containing and non-pointer-containing
objects, and therefore it's likely that a vulnerable object is still
co-located with a pointer-containing object that can be overwritten.

That being said, none of these mitigation are perfect. But on systems
that cannot afford to enable KASAN (or rather, KASAN_HW_TAGS) in
production, it's a lot better than nothing.

[2] https://blog.dfsec.com/ios/2025/05/30/blasting-past-ios-18

> Would it be reasonable
> to do some run-time randomization for TYPED_KMALLOC_CACHES too?
> (i.e., randomize index within top/bottom half based on allocation site and
> random seed)

It's unclear to me if that would strengthen or weaken the mitigation.
Irrespective of the top/bottom split, one of the key properties to
retain is that allocations of type T are predictably assigned a slab
cache. This means that even if a pointer-containing object of type T
is vulnerable, yet the pointer within T is useless for exploitation,
the difficulty of getting to a sensitive object S is still increased
by the fact that S is unlikely to be co-located. If we were to
introduce more randomness, we increase the probability that S will be
co-located with T, which is counter-intuitive to me.

> > Clang's default token ID calculation is described as [1]:
> >
> >    TypeHashPointerSplit: This mode assigns a token ID based on the hash
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
> > also does not prevent cross-cache attacks, and SLAB_VIRTUAL [3] should
> > be used as a complementary mitigation.
>
> Not relevant to this patch, but just wondering if there are
> any plans for SLAB_VIRTUAL?

The relevant folks are Cc'd, so hopefully they are aware.

[...]
> > Additionally, when I compile my kernel with -Rpass=alloc-token, which
> > provides diagnostics where (after dead-code elimination) type inference
> > failed, I see 966 allocation sites where the compiler failed to identify
> > a type. Some initial review confirms these are mostly variable sized
> > buffers, but also include structs with trailing flexible length arrays
> > (the latter could be recognized by the compiler by teaching it to look
> > more deeply into complex expressions such as those generated by
> > struct_size).
>
> When the compiler fails to identify a type, does it go to top half or
> bottom half, or perhaps it doesn't matter?

It picks fallback of 0 by default, so that'd be the bottom half, which
would be the pointer-less bucket. That also matches what I'm seeing,
where the majority of these objects are variably sized plain buffers.
The fallback itself is configurable, so it'd also be possible to pick
a dedicated slab cache for the "unknown type" allocations.
