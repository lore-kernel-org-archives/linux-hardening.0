Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D571E521
	for <linux-hardening@vger.kernel.org>; Tue, 20 May 2025 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747712738; cv=none; b=GHiDcBU7V1An80j366l56YTuyPHc+K4OI2fGdrrYSw9RyL23pp1gYRxTmMs4oKktXFvAGYdT1u3/TisOM66MkU2gwc8IioJkdKPbj6LeEhVgS4jIx5n3n4udgkbJQmRpbvnxO2GmhdqD2Jf79yA78EJvEtg+bifZutYAMTJYBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747712738; c=relaxed/simple;
	bh=pSLJ1rZIha38+8POfxQCiqbGsguN4H2Sh1CVTbSw91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDKBRwZp5EQoAdzf4KqOog5OAl34WF8hCQZFa+v6wvNx4OGaEbfyI7e7/uY9L+i8eRG69jzkDs0idckdloHmCoEcc0SI7BNSXUbfCwGSfdobbPnD4BIXCQf+Dx9mZzTWEzLa5gJAzOtJg3oHFR08BUR05itFK2FCTzVGeJDIK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjHiZHeB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjHiZHeB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so41240555e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747712733; x=1748317533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSLJ1rZIha38+8POfxQCiqbGsguN4H2Sh1CVTbSw91I=;
        b=qjHiZHeBr4rHb2gs6rRQd1+ZAbfhoEZN6nqB40QUopNICXGDooz9J+rPkBS4LMoF01
         jqsr4TVHsWHj08t07uT0XM+XpPSHGjK3pZlh7h8NZ/dsRBOJHFGjPsRUIYno1d6P5yHU
         SxCTUHYKlWFdMAx27ApmfMDejtmJshXLcW9GOt3RXNHcRnLF42PdlDws3eSAGC3qMFXO
         /wKfEx2HFJG8N3fxhbT9dhGkWWxNH9fy9B0YryHA8nyq/liQPbuldorFOiTUUmldzNIV
         YDthFA30ESnEbOjaEDkTUsNpHEhyf/rGmGBcsKvnjMPKNyJ24CC4eI2LxR5kRmhjjDo1
         2G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747712733; x=1748317533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSLJ1rZIha38+8POfxQCiqbGsguN4H2Sh1CVTbSw91I=;
        b=iWSRrGt2s5GwJ40Zra/HXJytLtWUR0Nxvdeld58e9lWfTp5yEguTwJQB6pMhIak7uk
         lrG58JxOkaq+KJRnojE8LDfqlazMxmjzNawCxW6DcvO2GYQXGkycmLBfiU6AfypSZKxn
         AcqaldR5v3k2Q1spO2mDPMkeO+yI+uXyKil/cjFxg61SsmsmtyzReLN8klxP2UFLZqOz
         yuMES3GVYGfyA3GS0pLHTGhiKAgqVnOncHDjNtSxtNZSviIlXRGHcUyCGt1L0ImxunJg
         i/dvCgZxx2RALokUKhImkG037XOsgWTlJ/9ky8HGKmBA4pYc+0ASPq1awXu5r/GO8j5V
         poQA==
X-Forwarded-Encrypted: i=1; AJvYcCWKX6UDCGlYDI3bp/NENIMLP8YNL1mQdc06xaG9hl3SXceR7mLSxjZtmByB2UUN3H/ssNoiYK1P9l4CU8oFS4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLEblPW4kdDU19KIzbe2jHp6J8bPHRNNYmtKzdSDEnki36j8d
	Ln5hdAk6hTdGPT39tiGqJWUwLstH2IW8M4GRAzs5Y8eIVsI0M5jzHurU6PMnbJk60ToZGwfheRv
	+xDW6wi5ERGB3/3dXi6bYBHV+dGOGykfkaHY1sFG7
X-Gm-Gg: ASbGnct7Bnt4JBM+P3Rdh+egwDK+lLmn78PrIT1tns5HQFn+LAUxlWl2QsEDIgylHGF
	8Ra/K0AMIFvB2ucNsL3etDI+ArUG7qk935EnfYzyudj5ksQ7KFJATrzHTmijAVUI8voP0ZqSqCb
	idkxa2pSoaezCWrJYH5xagAGJSwmWDDOikY08to5P4kNiaQQTpPOlOPgI=
X-Google-Smtp-Source: AGHT+IH8X/lJ5SeG8ewqqxxZERoQQnwUa1MU2iPSatle46HsAaG76FaPHlefDAeshLx+mBj3URO2i+G7GCmIVG0QtwE=
X-Received: by 2002:a05:600c:5008:b0:442:f482:c429 with SMTP id
 5b1f17b1804b1-442fd622da0mr145614735e9.8.1747712733218; Mon, 19 May 2025
 20:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com> <aCvTYHMtuWZZizn9@yury>
In-Reply-To: <aCvTYHMtuWZZizn9@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 May 2025 20:45:20 -0700
X-Gm-Features: AX0GCFu4IaYlIifThAaursLttYT-OL_DniGPILfakLeQhGk7HXmTN9249JTNHlI
Message-ID: <CAH5fLggwSjBYyDAzsnOSdu-kb6Pq8bLPNcHgE84n9vT0HpQdkQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Yury Norov <yury.norov@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jann Horn <jannh@google.com>, Burak Emir <bqe@google.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 5:57=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> + Carlos Llamas
>
> On Mon, May 19, 2025 at 04:56:21PM -0700, Boqun Feng wrote:
> > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@google.com> w=
rote:
> > > > This is a port of the Binder data structure introduced in commit
> > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > > Rust.
> > >
> > > Stupid high-level side comment:
> > >
> > > That commit looks like it changed a simple linear rbtree scan (which
> > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > > scan to an O(log n) rbtree lookup, just like how finding a free area
> >
> > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> >
> > [1]: https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html#meth=
od.cursor_lower_bound
>
> Alice mentioned before that in many cases the whole pool of IDs will
> fit into a single machine word if represented as bitmap. If that holds,
> bitmaps will win over any other data structure that I can imagine.
>
> For very large ID pools, the algorithmic complexity will take over,
> for sure. On the other hand, the 15d9da3f818ca explicitly mentions
> that it switches implementation to bitmaps for performance reasons.
>
> Anyways, Burak and Alice, before we move forward, can you tell if you
> ran any experiments with data structures allowing logarithmic lookup,
> like rb-tree? Can you maybe measure at which point rb-tree lookup will
> win over find_bit as the size of pool growth?
>
> Can you describe how the existing dbitmap is used now? What is the
> typical size of ID pools? Which operation is the bottleneck? Looking
> forward, are there any expectations about ID pools size in future?

Generally, an Android phone will have around 3 processes with a large
ID pool (thousands of IDs), and essentially all other processes have a
very small number of IDs (less than 10). The large pools are typically
the same size as the number of concurrently running processes on the
device. The bitmap was added to the C driver to deal with perf issues
that came from doing linear lookups on the rbtree for the large pools
while holding a spinlock, and it did solve those perf issues.

Alice
