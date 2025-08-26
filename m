Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEC30BF55
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207929; cv=none; b=KWLgUXyU4fBqW8FdIEBo2otdAEGLMPdRhyku2QXVhstw+8YSuq2+XfSDdjkXZ6mMCoTmSD8XdkID4k+FYPVcJ4n01o0CpBglkMxZ8lokxSOl3rauQz6NsHLh8BlSyPXfEh7WbxCkqq/zx/6P/fT9WNyY3aEi1KkWofZ9iKNw5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207929; c=relaxed/simple;
	bh=f8q+eThF8tpMuTG5oCEEYhTp9sfSYvEgg8hmv21YIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exLUeNd+UUyfmnMLX0UOloAvUZILopFapxuHyEyzYzq668nmQFskkvUe2mbVsAchcydAN/oTUF94D4XFoToDkmgFjnWXeCp1+yDjHhunNHwhAOetdInfzapALTh7cJ0VKDASeMiVQnVRwMMV4dUEXUlyYDod6tklprTojWz5SdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjUpf8Du; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjUpf8Du"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b29b714f8cso283361cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756207926; x=1756812726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgjl982rkJtQB6+NNyAU1pdVTWqd4G+6D2+THSotuPo=;
        b=tjUpf8DuenEeOPwVR46DCvQgol+qb82UjM7e97ji0gQ7+iyXi+nBYtdyqmzu8J9BgX
         spbbO3V+HocM0wtm9oTzRJgp2jsxdEj5BBSpuh+l2C2dt/TQKM2zeVZBm3utpPTP+Xhi
         QbArfHwbtUdqmqVgqGUOuRUKqED2F5kJ/QAcvVdIBc3kMEa4qpwoSWHBQamcsBUeDuIr
         lOnhTD86TsPnnnzeRr/+Ngqr6RvQoVKSR8pC3R0/CiX0Hl380fomvboCHyFbXZdNi8mK
         wqTBDrI/H/4OiNJdAmsgfPKLXk3QvWEsv+jDtTKyOUXR2lVAT/vjnZPgaULINvpgqMPs
         vDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207926; x=1756812726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgjl982rkJtQB6+NNyAU1pdVTWqd4G+6D2+THSotuPo=;
        b=TbErj8eHyDIbg8oJoTzhTBWHZ5nPy5hHa4tFGzbizqHixdyeLWBGk9d3ziNxUXrKqI
         bZ/FGghK1RN46iJWWf16zWXrV3T9CrI4zX2y91pj6Fe/H83Cgy+IcYsPBVMg9c1D4t1o
         nmK8cvnl2GpuTn5FXS1cf1K+q6O5RLIBHT3A/mPVxkIjGz2eumrIWLszlhsykyg6IrEO
         Bxz4IZIM15rrnv0rNAogTDJN/XRD4sPOGBrVkgA4ZqLvCI1Fo8NyEgCL6+Vu/pYrpd7c
         rCEOLwXijSHIMoWh+vpsq7SaZsfCQi3RT45tavJVJvvVQaeSEBRFJsaYc6v8tjtBv/Ee
         LxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4GBLUsEzryAQ4f/o4i/xYTBW1xFnpUZGWS3qbGxysIz0YMUjMDvl0r7K3PgpdFhTm/kufDxZswu9XIuRROqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJiMP7R17+WoMvxqyHeL0REet22njso4dq/y0KrucnWnfei7H
	cKGQNCA1+8LYn4ebe0FoXvofZnK0a09KQnmxAsB+UgWhBnVoAkI7HA15a0DqPboyzh7P2FJzLKr
	EJ0tbCNzDQVowNisS6/8lMmWtOXsLups3Y+Zm+hg1
X-Gm-Gg: ASbGnctbdkjv5vW8L47Vef5MM1Fsys7J7qx7PRRo52qgW/2/IfYWcxjUKNKIDW/xA0f
	24FaQnQ/0BwkVxuZAc6MQUaen5XLOma3CU6k0PcNQ3wDPBhuYm1Hep2Bs8NYJTNLYXyL1/Cc8Uo
	jhMe+QNPSmQpKvsZDcUuskibyLmTKzRSUkITkJzmTe7vFqi/Uhzoxlatg/NrF6nz5tHnIV0k/kf
	5R/zAQ7N0o+vbJewbkgfhxfzYygImC6rv37sZY1WIUCcuBqZzdL
X-Google-Smtp-Source: AGHT+IGIz0mfW/fdkVWrjqbaGzyt0+u7lbrcXJ+ddXu1DMsEf+ZPQnDOwsfrPc/mjKQ0Duj1yOEjprGa5se2wOTyim8=
X-Received: by 2002:a05:622a:148b:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4b2e2c1e0cdmr4401241cf.7.1756207925975; Tue, 26 Aug 2025
 04:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <97dca868-dc8a-422a-aa47-ce2bb739e640@huawei.com>
 <CANpmjNMkU1gaKEa_QAb0Zc+h3P=Yviwr7j0vSuZgv8NHfDbw_A@mail.gmail.com>
In-Reply-To: <CANpmjNMkU1gaKEa_QAb0Zc+h3P=Yviwr7j0vSuZgv8NHfDbw_A@mail.gmail.com>
From: Florent Revest <revest@google.com>
Date: Tue, 26 Aug 2025 13:31:54 +0200
X-Gm-Features: Ac12FXzALeR2tDEEna1F4OrekZEDGHVi9TgPcdxl6W-rTLz9deGbqXZWqVvOe9c
Message-ID: <CALGbS4U6fox7SwmdHfDuawmOWfQeQsxtA1X_VqRxTHpSs-sBYw@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Marco Elver <elver@google.com>
Cc: GONG Ruiqi <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:01=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, 26 Aug 2025 at 06:59, GONG Ruiqi <gongruiqi1@huawei.com> wrote:
> > On 8/25/2025 11:44 PM, Marco Elver wrote:
> > > ...
> > >
> > > Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages Clang's
> > > "allocation tokens" via __builtin_alloc_token_infer [1].
> > >
> > > This mechanism allows the compiler to pass a token ID derived from th=
e
> > > allocation's type to the allocator. The compiler performs best-effort
> > > type inference, and recognizes idioms such as kmalloc(sizeof(T), ...)=
.
> > > Unlike RANDOM_KMALLOC_CACHES, this mode deterministically assigns a s=
lab
> > > cache to an allocation of type T, regardless of allocation site.
> > >
> > > Clang's default token ID calculation is described as [1]:
> > >
> > >    TypeHashPointerSplit: This mode assigns a token ID based on the ha=
sh
> > >    of the allocated type's name, where the top half ID-space is reser=
ved
> > >    for types that contain pointers and the bottom half for types that=
 do
> > >    not contain pointers.
> >
> > Is a type's token id always the same across different builds? Or someho=
w
> > predictable? If so, the attacker could probably find out all types that
> > end up with the same id, and use some of them to exploit the buggy one.
>
> Yes, it's meant to be deterministic and predictable. I guess this is
> the same question regarding randomness, for which it's unclear if it
> strengthens or weakens the mitigation. As I wrote elsewhere:
>
> > Irrespective of the top/bottom split, one of the key properties to
> > retain is that allocations of type T are predictably assigned a slab
> > cache. This means that even if a pointer-containing object of type T
> > is vulnerable, yet the pointer within T is useless for exploitation,
> > the difficulty of getting to a sensitive object S is still increased
> > by the fact that S is unlikely to be co-located. If we were to
> > introduce more randomness, we increase the probability that S will be
> > co-located with T, which is counter-intuitive to me.
>
> I think we can reason either way, and I grant you this is rather ambiguou=
s.
>
> But the definitive point that was made to me from various security
> researchers that inspired this technique is that the most useful thing
> we can do is separate pointer-containing objects from
> non-pointer-containing objects (in absence of slab per type, which is
> likely too costly in the common case).

One more perspective on this: in a data center environment, attackers
typically get a first foothold by compromising a userspace network
service. If they can do that once, they can do that a bunch of times,
and gain code execution on different machines every time.

Before trying to exploit a kernel memory corruption to elevate
privileges on a machine, they can test the SLAB properties of the
running kernel to make sure it's as they wish (eg: with timing side
channels like in the SLUBStick paper). So with RANDOM_KMALLOC_CACHES,
attackers can just keep retrying their attacks until they land on a
machine where the types T and S are collocated and only then proceed
with their exploit.

With TYPED_KMALLOC_CACHES (and with SLAB_VIRTUAL hopefully someday),
they are simply never able to cross the "objects without pointers" to
"objects with pointers" boundary which really gets in the way of many
exploitation techniques and feels at least to me like a much stronger
security boundary.

This limit of RANDOM_KMALLOC_CACHES may not be as relevant in other
deployments (eg: on a smartphone) but it makes me strongly prefer
TYPED_KMALLOC_CACHES for server use cases at least.
