Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137F15380D
	for <linux-hardening@vger.kernel.org>; Fri, 28 Jun 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565621; cv=none; b=c9ORuc3cTDu6m3jZB5V2bqM3OFe5z9Dn9fYRukP76qgGGMhLyFRBRDOLFyOUcvxFyZk65IEc7R9SrYh1fuQJa0SIvpLRnSadeTuTxKWNhdBr4HZ7koisFYH0MiNBRZ7jhVfJwHVBKlaWaSSYLC6PY7d6YWgwU407LEkfvl48cw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565621; c=relaxed/simple;
	bh=6lILPXsSnuRcIB/1aRICDr7E5gU8xTfXClxW1Kv+tcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNLZs9AQRBj1500Evmg6tE1DtSq7wc2aqi1rK7F7LbX+J9Lky8NxcHLHgOhRbRdc1DYHDlMZB66oUMsj84RY4w/gU8dfzoY2zvR3FATyP5slm3+bDxtmeqS86YW5tx4Od7PaTtMVy9HqHDsVjZ+m6l1QNS4MDvngeGRPIMQo57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tt+TQqm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tt+TQqm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso3163725e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 28 Jun 2024 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719565618; x=1720170418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9XuEmOGKQmnl44REDZJmwUjYzwybPJMiDqkTMARv5k=;
        b=3tt+TQqm9H+hvHvRw7ccI2Oo6nQXQQE9yu9wC+Q+iSLf5Zc0iE2Bl912zkjMiBJnqk
         VWRSr3ymgsntgvf3zCENLNYs5XAdQq5SmQ6v7mRQ7CAUVxS5mrVLxD1OQj66s5JP9XLu
         UoHlmpyacSOr+/mwdjricc6g5hm+F6B0Iink9vuz9c6ThNtwiJ3Hs//S2uSrYveRAQv9
         QnkrYMAyav1DT0mnEWhc8Coj1ULXG9D/ioYzCtxZgTADvJ3C08NHX+KozSURWF3i6AZN
         K7x0EgCE7OeiRmDcV2vv01fOp8F64tP9WkdX19MnAi5U++lBU/8x6POmbHubaOrveG4G
         aShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565618; x=1720170418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9XuEmOGKQmnl44REDZJmwUjYzwybPJMiDqkTMARv5k=;
        b=XEpF46TfT9a3XxAehC6pFpCy55Xq/2lf5u5yQTTuXWuW1jayOn7qetlCNO3eyRpPhT
         Tp7ECa0OZ6IL7Xb/lDRLy2xtB2h6H14Lkek6GaR7y0JGq2RSupI5ZvOVtID+tKf39twm
         5TMutIclla6RenJJVUYZWMf1Wg6hy80tupUbmz7qTWCIi+ncR5XhQE3pZZBMOOKUciNJ
         2S4Ap2MJ6N+0WEQYKwMLB83lguiGr+tMqTHKLKdShgvP/BFbQo7+Wx5jDMewKp5ODZI7
         x8oE2S3sm73fXxFJDW8SQH8nG4igOmQEYIg85I1bQiKUbg+OgUH53Kg46tyt83U3m1o4
         kFDg==
X-Forwarded-Encrypted: i=1; AJvYcCXB5G226w2NeoybhNuZ+P17xX5vVZ75oNWkn+Bl4jjdo2qyuzmTlF4Vzodz0L+qbURybfya1Zb3hRSRC+wT9szrlEZKbuEU8BEoM06x1sku
X-Gm-Message-State: AOJu0YzNr39EO1hrfdeqtNk1Psj+BDH4/h/4eUjvWpQO5voHUw1Of1pq
	x6Nd9eSxyksv0bX+frMw8oq6fmNuwqxzKkXP5Vw9Z/r1Vcn/FR8yNXMLa8Is3q7uhQIWYjX2QU3
	1XHqvpC3OcIXJ4IevNuA+xw5I02sux5zUEq20
X-Google-Smtp-Source: AGHT+IH7t15ZxEn2LETHAyDOXDZSewj9x0ofxPVWbHBdCjBgMBIveOKBhoflOM22vJXoMJ9CySG9QwFCPP9ol/FJosc=
X-Received: by 2002:a05:6000:dcd:b0:35f:1c34:adfc with SMTP id
 ffacd0b85a97d-366e96bf06bmr10949760f8f.67.1719565618293; Fri, 28 Jun 2024
 02:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619192131.do.115-kees@kernel.org> <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz> <202406201147.8152CECFF@keescook>
 <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz> <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
 <c5934f76-3ce8-466e-80d1-c56ebb5a158e@suse.cz>
In-Reply-To: <c5934f76-3ce8-466e-80d1-c56ebb5a158e@suse.cz>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Jun 2024 11:06:45 +0200
Message-ID: <CAH5fLggjrbdUuT-H-5vbQfMazjRDpp2+k3=YhPyS17ezEqxwcw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and family
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Kees Cook <kees@kernel.org>, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, jvoisin <julien.voisin@dustri.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 6/28/24 7:35 AM, Boqun Feng wrote:
> > On Thu, Jun 20, 2024 at 10:43:39PM +0200, Vlastimil Babka wrote:
> >> On 6/20/24 8:54 PM, Kees Cook wrote:
> >> > On Thu, Jun 20, 2024 at 03:56:27PM +0200, Vlastimil Babka wrote:
> >> >> > @@ -549,6 +549,11 @@ void *kmem_cache_alloc_lru_noprof(struct kme=
m_cache *s, struct list_lru *lru,
> >> >> >
> >> >> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >> >> >
> >> >> > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int=
 align,
> >> >> > +                                 slab_flags_t flags,
> >> >> > +                                 unsigned int useroffset, unsign=
ed int usersize,
> >> >> > +                                 void (*ctor)(void *));
> >> >>
> >> >> I'd drop the ctor, I can't imagine how it would be used with variab=
le-sized
> >> >> allocations.
> >> >
> >> > I've kept it because for "kmalloc wrapper" APIs, e.g. devm_kmalloc()=
,
> >> > there is some "housekeeping" that gets done explicitly right now tha=
t I
> >> > think would be better served by using a ctor in the future. These AP=
Is
> >> > are variable-sized, but have a fixed size header, so they have a
> >> > "minimum size" that the ctor can still operate on, etc.
> >> >
> >> >> Probably also "align" doesn't make much sense since we're just
> >> >> copying the kmalloc cache sizes and its implicit alignment of any
> >> >> power-of-two allocations.
> >> >
> >> > Yeah, that's probably true. I kept it since I wanted to mirror
> >> > kmem_cache_create() to make this API more familiar looking.
> >>
> >> Rust people were asking about kmalloc alignment (but I forgot the deta=
ils)
> >
> > It was me! The ask is whether we can specify the alignment for the
> > allocation API, for example, requesting a size=3D96 and align=3D32 memo=
ry,
> > or the allocation API could do a "best alignment", for example,
> > allocating a size=3D96 will give a align=3D32 memory. As far as I
> > understand, kmalloc() doesn't support this.
>
> Hm yeah we only have guarantees for power-or-2 allocations.
>
> >> so maybe this could be useful for them? CC rust-for-linux.
> >>
> >
> > I took a quick look as what kmem_buckets is, and seems to me that align
> > doesn't make sense here (and probably not useful in Rust as well)
> > because a kmem_buckets is a set of kmem_caches, each has its own object
> > size, making them share the same alignment is probably not what you
> > want. But I could be missing something.
>
> How flexible do you need those alignments to be? Besides the power-of-two
> guarantees, we currently have only two odd sizes with 96 and 192. If thos=
e
> were guaranteed to be aligned 32 bytes, would that be sufficient? Also do
> you ever allocate anything smaller than 32 bytes then?
>
> To summarize, if Rust's requirements can be summarized by some rules and
> it's not completely ad-hoc per-allocation alignment requirement (or if it
> is, does it have an upper bound?) we could perhaps figure out the creatio=
n
> of rust-specific kmem_buckets to give it what's needed?

Rust's allocator API can take any size and alignment as long as:

1. The alignment is a power of two.
2. The size is non-zero.
3. When you round up the size to the next multiple of the alignment,
then it must not overflow the signed type isize / ssize_t.

What happens right now is that when Rust wants an allocation with a
higher alignment than ARCH_SLAB_MINALIGN, then it will increase size
until it becomes a power of two so that the power-of-two guarantee
gives a properly aligned allocation.

Alice
