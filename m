Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C746217705;
	Mon, 19 May 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687770; cv=none; b=rhEebsmY19dwzAN7KtQrls0R9SKFlD5Q/tGcb14RyICLDX6XSoccI1ivvKZ4YLFDGVIYgAVkpJH4mkv2vtLZjLihDtW2MdSb2jkBIAixnVmTZD9NFUzXf5T64SuFmNMui4MoNUmvJIpllh4xUiO4Lns/Xllp8T1VwYJF+AQrzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687770; c=relaxed/simple;
	bh=61QUkV6FFeafFq9O8dDnfMdlriHIrLQIZlsBf0U+ry0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o05/q2QGfBsC/lxK66fSGJkTWsCr/+ArfvfVXRKwt5I4boQjk26FR3pi8gyNMb1DlgmmnaPCnGKZ7neTEHtbOLxSC/yc/PdMqK+rxctZZ0o3/FD/d9ExbbjEDu7jkp/rSKA2XEzQZ48CNd8y7Fadq1CbL6ruGb3ytbkH1Yjs0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR4VYt8V; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR4VYt8V"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c546334bdeso436016385a.2;
        Mon, 19 May 2025 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747687768; x=1748292568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmUS+xqCVn16FoWqjtvNjGBaJ530wNpl6spKg06DASg=;
        b=hR4VYt8VeXaTYTkGgzVqFEw7YLZyMEEA7lQ/O5Vu4Ak+QmoPPOAJElCqZ9lW1AarXD
         /2KD47TZQwxYUjYDTsQacy+vXDNGAlLLSqPx15H9JBHmGSDTZf0+VPDvQutf/3lNCYaG
         fh5GUBXUt0HUCd6ZmIjjZvaegUZ4hJIoUOEtBRCHij7h1oF07yAh5Q0fNv008MWyynEv
         GBKG8mScLRUJb+OUaIyPvo4b3NwgzQRNyLc4iVJTmaP+jfpCIbAL2qKYtqHwPKzG6VxX
         nD8umy34eug+WX86rKFhyYEdyApLhfZl0zdYSPOkK5JaFLyq3E2wMkc6EfiTsUwS4/xo
         a3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687768; x=1748292568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmUS+xqCVn16FoWqjtvNjGBaJ530wNpl6spKg06DASg=;
        b=rBbRY6aMyuDq68rLZbLZfyZAqVInQc3iNKpIb45Syfl0I0YRRTL725WNsN187foknb
         OuZThXwLTwdNmAByisySq9NReDhr/Y2EyGOiguG1P+vX85Zh82MZjYLb+hbdZ4YlcElU
         HqnO3OWOlWxSuK3E0KlLL21YPbl3YM4P0+MseWCl7V25LbLC2NKvolT2x1Yu7hdcKgVN
         53kjna398xtINwu3DE+OpaSvayfioUKL1R61EvcbFvceAhPWPxvh7LaBFqbRisC9IwM6
         xON0yFiAQdLFUX7EaN5AQk0tVM0DdAETWqW+fzPYN2OE6z2b+PbCyW88MSiLZmIVM0dR
         uxkw==
X-Forwarded-Encrypted: i=1; AJvYcCUELYcRj1Re5xK+MnC6YyLzSOyrrvGZW3pkObnvzLmIIWatNwcVpeUtpqc4UUuhO6gkg+habpZ5tPa8AAbz@vger.kernel.org, AJvYcCVnSJLGXJJrXmzuHq7e8pgVoyX9euItjqbCbm2jOPwWlgHEGnqtvB997+D59iMAFgs9sCl7mQVO48wJHtdB/8s=@vger.kernel.org, AJvYcCVz1ZdXes8svOgQZaFMlnsIkXuwOBS9/UmX93CDthtlB3sCdmCQjvy5qb7Lu+8JKwOtmmoVNL1spLXU7Stvyqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkTzorOpptirh7hDK9F9qI8iG6hawOFvNotJqG9oXI0jW5kPp
	sSRbAn3BzOkXE5lNpgBkinHmv26BHr/BciRv+9MiG8Ne9FXATcIJQ72e
X-Gm-Gg: ASbGncvlttstIjQ9/KsZMTkHLVE3SFW3Pw9zd2p5hQIlwHZyxqlNjZFkKBPgbyQrRoh
	0Sw+Pd460zMBfcQ8ynnDEwf65K26nLYNRtuSHOjbeRAqKsiFYQE+h8SgMzH4rwAMrrSsBjkNBvN
	QAZ01/9yGLOrp1PE8RDbONLgMg/7MSO2qO8eGW6+BTCUIdVqJjlJkLWtQjuqk/iMCPDlpI2b15y
	/vfDlWRxu7iev0dx60w/LFNWX9pH9K+KJbRmcqM1rotJKOoQEv/WkiCuu+EKXDahQJVMTfVClqh
	FCd2Zn7D8jnKgjUlRixVwrBBSDzoOpbUSR7h2X2NjfPTn4MA0cqVpNOCsFObHLH7eOzq4W/I5uB
	djBdmAB1qxjcMLYtaA7TJjI8CvKhwEJXs0N/MJL3iQNgERQDIJIbH
X-Google-Smtp-Source: AGHT+IE8WGoO383xB7RHGc6KxOPQi6O8WNGtDC2weY3CkPEhoXPFQzoQ0sLYxMGfAqd6kBPycEKSig==
X-Received: by 2002:a05:620a:318d:b0:7c5:5670:bd6f with SMTP id af79cd13be357-7cd47fee743mr2454708985a.53.1747687768078;
        Mon, 19 May 2025 13:49:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b69fcsm630949385a.81.2025.05.19.13.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:49:27 -0700 (PDT)
Message-ID: <682b9957.050a0220.3d035.a5e1@mx.google.com>
X-Google-Original-Message-ID: <aCuZVb6Lcdj4jyiP@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E06A1200043;
	Mon, 19 May 2025 16:49:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 16:49:27 -0400
X-ME-Sender: <xms:VpkraN7_1N5IrJGIFx0w1hL2NIn13XfDxGlQMEvHKq3o1U8j2bsi-g>
    <xme:VpkraK6BMOsdDMK0qVtClB8U9ZU84N9pElqQ54E6GXk--G103_MRbn0aHDo0F6F1M
    lQqgeiC29cN-EXO0w>
X-ME-Received: <xmr:VpkraEfj8R_LC71r5PjNRP_nCY3igq-nCR6Ls_k1fU0fSGQzsj3omE-BPX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepsghqvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohephihurhih
    rdhnohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgu
    khdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvth
X-ME-Proxy: <xmx:VpkraGL7hkjiZULRWkD-QemorhG_a92lkYfZjA32f1_Va26vjY7Scw>
    <xmx:VpkraBLZ7h3dcSLrDc3sm-jnpZRd63fjqBZSWznAfyojztB5EYaFnw>
    <xmx:VpkraPw0N4-l3z_DLPJiMLtS2ZQZpWE8hFH59j22ysPkuglM-zrezw>
    <xmx:VpkraNKICWeJi3sSAUm8Ai0N9ZEl5f4JSwlLEh9uKPXgIUt48Gdx9A>
    <xmx:V5kraEa6RLYP7LcH6f8v81o53ZiEBgEjxFrp5tM6LfYULPgjZyU5RSu3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 16:49:26 -0400 (EDT)
Date: Mon, 19 May 2025 13:49:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-4-bqe@google.com>
 <CAG48ez0rGwFeVtj6AKg8YY=D9Atvp1h5FdW3szswEJsRmkR86A@mail.gmail.com>
 <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com>
 <CAG48ez32BYaor4pWcG4+X6zqXgdskeC2UR3Kte_pp09-LeKMug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez32BYaor4pWcG4+X6zqXgdskeC2UR3Kte_pp09-LeKMug@mail.gmail.com>

On Mon, May 19, 2025 at 10:36:52PM +0200, Jann Horn wrote:
> On Mon, May 19, 2025 at 10:08 PM Burak Emir <bqe@google.com> wrote:
> > On Mon, May 19, 2025 at 9:01 PM Jann Horn <jannh@google.com> wrote:
> > > On Mon, May 19, 2025 at 6:24 PM Burak Emir <bqe@google.com> wrote:
> > > > +    /// Set bit with index `index`, atomically.
> > > > +    ///
> > > > +    /// ATTENTION: The naming convention differs from C, where the corresponding
> > > > +    /// function is called `set_bit`.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// This is a relaxed atomic operation (no implied memory barriers, no
> > > > +    /// ordering guarantees). The caller must ensure that this is safe, as
> > > > +    /// the compiler cannot prevent code with an exclusive reference from
> > > > +    /// calling atomic operations.
> > >
> > > How can atomic operations through an exclusive reference be unsafe?
> > > You can't have a data race between two atomic operations, and an
> > > exclusive reference should anyway prevent any concurrency, right?
> >
> > The atomic operations take a &self (shared reference).
> >
> > The patch is missing the implementation of Sync for now. With that,
> > one would get concurrent write access through shared references.
> >
> > The "unsafe" here should serve as reminder to argue why it is ok to
> > not have any ordering guarantees.

I don't think ordering is safety related. For example, relaxed atomics
are still safe function. I think it's wrong to mark this as unsafe, do
you have an example that you can construct an UB with pure safe code?

Regards,
Boqun

> >
> > The last sentence is supposed to say: when you have a &mut bitmap, you
> > can reborrow it as &bitmap, and then happily call this atomic op.
> > Even though it is unnecessary.
> 
> But using an atomic op when you have a &mut reference is not a safety
> issue, right? You wrote a comment about behavior with exclusive
> references in the "# Safety" comment block. If that's not supposed to
> be a safety problem, this should probably not be in the "# Safety"
> section?
