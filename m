Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB41F55F8
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861808; cv=none; b=tjKBiaZjvNKKZlpv0RR/Q7e6GZb01vrmI7rbxg9lQNGNqD32ljkcGBjL40KaR9KM8drrDQpUYE/BHIUwcdKxWLeV5BU5hDndkvGb0ZLPz+j5Y3wuMRAomF5aBQnVPMfqvY4o2rLFLbzzkJ95ELMz4E6r35UJEVHoXuPW1EVNuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861808; c=relaxed/simple;
	bh=Bo1Dn3w37seMAP+bw5pDOhXBdEtsC55jIbo6qBxZVSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOX3nj2CDiva4FyyBVytyqkfGb2dzLlIpCLGCXaTvZ2WewXQA8hbp0SLFeyx9R7HM9RwUk5mmaLAE0BCizOZXW487EotrzrKmw8rT03qPsnQRtzXPzvFsKPel7hKTlkdxiWp+EmFcrtPdxP+Q7vCs8Jw8uKh6JmboYCYvyh2lkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4Oqv6GL; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4Oqv6GL"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2e8f7ca7ca3so2389407fac.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748861805; x=1749466605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo1Dn3w37seMAP+bw5pDOhXBdEtsC55jIbo6qBxZVSk=;
        b=R4Oqv6GLLaD6df16lbj1nmmT+HNq/u21bPhjUNsupTvST40J6CW+5zKSaPSzeyC2Yu
         ZsdR2J9lij8N8wkho0QRoRq3VB4GC4YfOuuoYeL6O9lA4oEWp1CVxuGWL4TpjBNoymTj
         MU/KwmeLTNVxMXcnjecAqlthiNOZGUh8RDX4ijL2FMLCHQZ9RaTibdElardGyIY7ljcC
         7xiG9kujalVxaMwMtNNC/LrGzOXcUZZgsTUtr4Ituce2hqnlSR4DZb2DpIntaL0QK7pJ
         8Ysum07gZdD3rDvjkDfBc600ymfBF0pfCgveOmy3khWy2eNL6BJO99Wms8XjvdyJHxl/
         gUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748861805; x=1749466605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo1Dn3w37seMAP+bw5pDOhXBdEtsC55jIbo6qBxZVSk=;
        b=WOqBW0+moW2qgpjtOH9D0V9tG8p79cw8dxgElMZrCu3yofpjMrylCzPpoF7NapDMzq
         VsXvyf49eRcxYzz2o0+rrnDyUHxRuj/tG6uzgMA+yiOjMxYkZekw3pjr7hjop2Q8X3U7
         hnZxHYbJ05vFG0kerH6m0Lvy4sHE9FFiK4Y284s6mUrT+Jh091JUeJC01AjUoQ3rcBVk
         724e5ZN7A9vK7hHUZVdl3yTQ89FsHu84J66hwKHyg2mCyVUn/veaqE5s1/XGY4UKaAS0
         m1J6WV//1ipI0otSpjW0e5Gf6CN8puIEJ7k2DgN38TMKXqABya6LMF6E4pfejNpFuDts
         V4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU3p96F7OCUHypzrXStNMXaXEbPmC3Rc4o2F+0VH1SMlHMu/PT1zD+LpkZ8HSbTVPnYsDj9B9EMwBEOs3Gpu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBqO/+LQD616LvgBoey9lK6HWfW1jvFuI2w04Agm3WxZN7HFv
	p97m2cpcGuVYP01Sg7E7Me5b9aEe9P6FDXlQdDVRmBB+cS5B+LnJpbwNYJm/J4qvxT1yWfaQxUi
	1SyLyCic5aPKv185b83l94DC2wf/P3Dg00WEIolpg
X-Gm-Gg: ASbGnctXmPUQ1924M1ZaKIhM0OJivS6K5Ur/SRCIDOyxfsMf5HfVJoYo4ogV3AwPiBw
	6wQOa5arD0gJPzaRYhxnzpcV1DX3CyD3Ppc1A5YihIeTpDrQJZp9RX56aPMDoMpRPIgu1Yc3JeI
	GenXIdu73M9Jpn0vb0nyzbUO+yCXRrpCKTlnI6u31kN+JkSpkvA0gMi08p8CTaZcB3M6Rb/xKNB
	g==
X-Google-Smtp-Source: AGHT+IGCwnRveAFrn3m1cHd75Jseg91XQxQvUPPL0lIKIgwRZ6smz4rU2A5lacSedSenmk+Jlg2FWjdBjazxr2GujXg=
X-Received: by 2002:a05:6870:818e:b0:2c1:6948:d57c with SMTP id
 586e51a60fabf-2e948cb5422mr4678788fac.28.1748861805503; Mon, 02 Jun 2025
 03:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526150141.3407433-1-bqe@google.com> <aDXPhs79tQGTNU9b@yury>
In-Reply-To: <aDXPhs79tQGTNU9b@yury>
From: Burak Emir <bqe@google.com>
Date: Mon, 2 Jun 2025 12:56:33 +0200
X-Gm-Features: AX0GCFsptb4AjM3AXX__0mElF1fRr3ofVuwEuTFh0eet1zbR-ixQIe0moGlg4S0
Message-ID: <CACQBu=Wtd=b+BwCGqXgw=pJdFexDH8GfVXHdnGVcOKD9seeo0A@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Carlos

On Tue, May 27, 2025 at 4:43=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, May 26, 2025 at 03:01:29PM +0000, Burak Emir wrote:
> > We include set_bit_atomic and clear_bit_atomic operations. One has
> > to avoid races with non-atomic operations, which is ensure by the
> > Rust type system: either callers have shared references &bitmap in
> > which case the mutations are atomic operations. Or there is a
> > exclusive reference &mut bitmap, in which case there is no concurrent
> > access.
>
> Here I'm lost. In the other email you say:
>
> > You also commented on the API. The weirdness of the API is all due to
> > the separating "request to shrink/grow" from allocation.
> > Since allocation can happen while other threads may mess with the id
> > pool, one has to double check that the request to shrink/grow still
> > makes sense.
>
> And here you say:
>
> > there is a
> > exclusive reference &mut bitmap, in which case there is no concurrent
> > access
>
> So to me it sounds like if I want to resize, I just allocate a new bitmap=
,
> take this exclusive reference, copy IDs, swap the pointers in
> corresponding class, and that's it. What did I miss?

The two emails are about two related but different things:
1. the bitmap API which uses kmalloc with GFP_KERNEL, and what you
suggest could be done with &mut references
2. the id_pool and its fine-grained API that permits controlling the
time of allocation, which is used in binder which relies on a
spinlock.

My limited understanding is that calling kmalloc w/ GFP_KERNEL while
holding a spinlock is not good, since the kmalloc may sleep.
You can see this "first unlock, then alloc, then lock again" pattern
in binder code here:
https://github.com/torvalds/linux/blob/15d9da3f818cae676f822a04407d3c17b533=
57d2/drivers/android/binder.c#L1099

cheers,
- Burak
