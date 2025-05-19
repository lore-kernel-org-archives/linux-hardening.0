Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1D2165E9
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698254; cv=none; b=WsCLJVAeP/BTyPEHoYuFYD6sZag7RpvKr3MoXhazi5QbGmpBoVvboBI6ZsCfFTwJLYJfDMKOhcIGrmTxQY3S3XEX4OTmxdMU+qKtKJkKOkB7yRhVyJmb+aLhcf6DP8ehh5hA/MP3GgRw1eKLIDSCeD5zvD0cojzIgXECsais/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698254; c=relaxed/simple;
	bh=XjDLoT2QHXCTqz8BCXPXR1Qng/tmWuoD+g1I8LQifj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLNlHjhi6FXYlZiqVho5kelwSnuIDCLvea2Ms0xkYx+/JZWcpFirG9o4mwz1QjRUedcJyzIZBrrXQaKLAwmLbp3iTlXnSWgKLLgFKiIINs/AQ/a3OJuesIKkrvLPTyuBqrAskhAqogGE11R5jzYFPw1zsNj9dNupxbAdMb6HGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eilY/GR9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eilY/GR9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231f6c0b692so451195ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747698252; x=1748303052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjDLoT2QHXCTqz8BCXPXR1Qng/tmWuoD+g1I8LQifj8=;
        b=eilY/GR9kmizYIT8INKIn9VPWosDwcFG0tRilYWZUlOatghqDuv/XCGYIdtUFSIbcu
         5S9fqKmN6yi55oa97OheNv8XLfhLZr6KfYgumMwDGR1Kb6CptyQ6UGaWjX3dm5g3trSF
         bBz/kiWnMZUiNbEEF/8UVdJuVVxmzZJ4xUELf+gNQ1ne6Jvw4aYro+RGNOwKf4ZBinqO
         DKmSfO6NSI5vlzj6kYox4V7lNMM/KloXAjGAgUXpPB1b2L5mxDr+F9Rt1UF2l5RyIcF/
         FYWmsh26wfm0h9v7DoRtvFnxopgyysfHLnWbyC1Cf+uh4efNFcpbbB6bGxyqnh9s/jJJ
         CFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747698252; x=1748303052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjDLoT2QHXCTqz8BCXPXR1Qng/tmWuoD+g1I8LQifj8=;
        b=GiZ4AzLbAu383o1KlpF7j6TGZ9LlFdWc2FofVPP1clkBd8JFxl6ZEZ6KjWJ298u3cY
         OjGeesq45fnU16kiZObGmnW2W7cgSSWpop2jc/7iWwW7Tko5JbRZNCHrcA5IeBd1/68v
         cYO7qvf4vjkNhW8kt3DtHB+TBtFyleKuUcfRaX+vXFTqRmSvCivjeJLisSQig228lXmt
         HiGbeIsVcz2qZM0Bns7ZG2czy2MEVKKGHGNQSA1wiIf4p5DzH59qKhbOGcuR5qUs6fTM
         y2odvfqBO30l9njerHqOy8qsh6esVGxcUctrP8CyAV79Pv4s2fJu3EGdyBmrppHxcmn+
         Odbg==
X-Forwarded-Encrypted: i=1; AJvYcCWbcJxoGOHSMSSeYrMnVuXSBJWsxW0ji2ZwZiB8W3OI2YU6LvR8im0q3d6FpcCYbJYNNpZuPCIQ6K7sKP9L9ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJnV6D1k6yLgWTgvcaUDtDuJEyQ3AKXHY9oHGynRilcM5gijF
	NpW4DoS5jaFBCJ/8yEIvBthrjws4MTmut2V3G4GqCpgsNQL0rGzvOqY6WzwyP/r75cuQyNhPCsQ
	HAAc+INOuk7GHfDo4HuVYnw0S6vlYb/LtXidcEHi/
X-Gm-Gg: ASbGncsVqdW4l3QymWFgXv/ie6fmX3QpFNlgxB4NP1E4VSbFXWr1IpTg+Oov3cwzuEg
	tDh4PkvHUN1qE9raV82Jg6KSX8PuMIVObaV8z6jVBj430mo9dXZLUlzD+gUlFRUfExZoowd0uAD
	mHfgbtcIFBk4Lq6Vkdm2BuPodcQEsSOA8wwijmtBMgdxQs8nNxbkIQ/EW3WvV+4wauwbnmFQ==
X-Google-Smtp-Source: AGHT+IE7AXqNSM168pnSSbm7/Qdp/rsZ5MJVswN9Uamoq5240bQF4qJjFwhtWVm+iT8b7LVuXFvADMYtnY0OTDWxPkg=
X-Received: by 2002:a17:902:d4d0:b0:223:2630:6b86 with SMTP id
 d9443c01a7336-23204043e30mr5347595ad.7.1747698251850; Mon, 19 May 2025
 16:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com> <CAH5fLgiK3T24gf6tjXGGMsjqj17dh0PFbRZboE5oXXp16yOLTg@mail.gmail.com>
In-Reply-To: <CAH5fLgiK3T24gf6tjXGGMsjqj17dh0PFbRZboE5oXXp16yOLTg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 May 2025 01:43:34 +0200
X-Gm-Features: AX0GCFs2kKKvW7hzRLpDUAMJo7MeTUCLcCF-zBATZLkYTjuyGIG9AgDMXpbovfk
Message-ID: <CAG48ez0cspY1x1oaVs=Jz_9UN3YuFzWb-w=Q5iNfE0cmRek77g@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:12=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Mon, May 19, 2025 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> > > This is a port of the Binder data structure introduced in commit
> > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > Rust.
> >
> > Stupid high-level side comment:
> >
> > That commit looks like it changed a simple linear rbtree scan (which
> > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > scan to an O(log n) rbtree lookup, just like how finding a free area
> > used to work in MM code... That would let you drop that ID pool bitmap
> > entirely. But I guess actually wiring up an augmented rbtree into Rust
> > would be very annoying too.
>
> If we're talking approaches to avoid the bitmap entirely, it would
> probably be easier to replace the rb tree with xarray than to use an
> augmented one.

Ah, yeah, maybe. I'm not familiar enough with xarray to know how
annoying it would be to insert stuff in an xarray that you reach
through a spinlock, which seems to be the requirement that made the
API for the bitmap interface so complicated if I understand
correctly...
