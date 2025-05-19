Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5D1F1319
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687052; cv=none; b=SlsiCZPkDw85S/b/wN9h7eT9gAADDiYsjEbz7/V43bO7PTvkbM2gzr7XNDmreypcxOPK3tWhOw3reeFFjaBTANF0vVilXJ4uBDGfuidnQUl8aTdk8RTT/YB3JSnkQqI37BaHqP7KHGpLIL/i67nLGjtIdoPTs9w5Q6bJmR/eBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687052; c=relaxed/simple;
	bh=SC3p5hC8hMDNnCQGdXHPO8UFcYi9C6ed8jvNAt2Ai+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcBn9ONm559PFj+NSzct1H85E2GGADJhv5iK7vvi/1s04nlgjk75h5W2Ks0rroI5EXvCMFPA5ZsGvi9qvtIqGEQmhSkz9x+ZUbo5KVj1I5nRJtFIsS72tf3ANtGx6jX6tm3JfU8W4YmoGEZgaK/+5ZDtTABBAiYwUwl7I6ZSzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WD1EOKB8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD1EOKB8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so17347a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747687049; x=1748291849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwjd8j4QyED9qdYBTT0Bo1zt4l0EzpY7sgoCO0roN34=;
        b=WD1EOKB8s4rDAq2mwVZDLVhzZfbvcn6jjqKwOWtSz9mKpgG9eJO2epK83AdgbM3hCF
         7+ec6fmypxjnG2UiK/bVtoOt1/GAat/FPbic5XW3ft8z5dIFoO/JgQyhUzXIocqu1lSw
         obrEpl+Iupb0GcoP2tJfIruDtWr/Xu+g1hKdcUMgT+H6oQSfG4nSJEnsET33LYoPEw4s
         y2Mp0/YUi/J8g/xAPt74yZY/MCG7nFk3aTFA28SVUSkuaDj5ovmUIZwPz17WPzhg5OkW
         KyCd9Uv5bkhNq5E7duV5CijT3OOw6WwvpXWVHykMDB3Dk9lQZDKNG+FcQkLyCsHOs3us
         Kglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687049; x=1748291849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwjd8j4QyED9qdYBTT0Bo1zt4l0EzpY7sgoCO0roN34=;
        b=pLE2EQnUEmBbXcMksfr9IXLxTF14G3Jdk+CXqIMOeWiTt8JUhAobm17l/avP4vA05j
         gS1p6SbzVgwwPk/JjlRBusSU0Xb7njbLN5Xd9DRlETb0bbjMJ6OLo23xan04PibEiZsF
         TPhADH1T3ozmhA1sAFtk5W72vNiFHcv7U8MF9g2ptOQ/9uVKx31UDiSCxO/2N0X2yIFg
         C8R0YB3OoolECgxu40zcXxnT089PzwaP+5PrpSmrCAck5OfLwJnQu8N1YL55PRBnCWGO
         kSrjgWQaj3u5cV6cEB1tr8GOlzETBZ+XKifoA9v7agyfR3QAWvP6Xwz2pjEjyRB0F03c
         K0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWWU96D6pTwgmieelh/ZHAPJN2HuGpYueR6rVwO2C0quHBHsgwVG+0B3zC7wZTDl40ORHBfOWvXn5PiRrt//JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5A/QEoT8jJXi8iAVkK6fn1uz3H2C5hNECZsAG70ounM4KPSx
	om6vUzXe0EaFMt6pan/r3g3Qw1r0tEZbN9EqFVu4K1DY40f2isCCo8OCPpYwTLjYgs6cJ6hM5nB
	Y4MtTFTupAhpgZfuHD91HgKlq/RcvFchlf3jmCBE5
X-Gm-Gg: ASbGncsdKPhPKLbv94NlE1jEdiXJrdM4dDHrRX2xscWxHIzVu0T0jgxeQIZUNhBnhAi
	BldZXu/aawFOoJmuZtm8aGVuDXMsviP1hp/LRWqZFRYD9cXjzAnlzF1xtvnZ85JTfgzR80Pdipx
	Kgpc2lcbn0YYZfVueSMAeYyAQnL9XEh5xNbna3UeTsvAnU9W5tCrQUHHpLPIc=
X-Google-Smtp-Source: AGHT+IH/u+qfIXXPEN3rnOUSM7iuh6vPNGj/l4Qc8eijLUmuYTxdqiITZPnWGZ6jYGmXZIBgL5nCJB7y+EVSlPfjHBg=
X-Received: by 2002:a50:9f08:0:b0:601:f23b:a377 with SMTP id
 4fb4d7f45d1cf-601f23ba435mr105591a12.6.1747687048635; Mon, 19 May 2025
 13:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-4-bqe@google.com>
 <CAG48ez0rGwFeVtj6AKg8YY=D9Atvp1h5FdW3szswEJsRmkR86A@mail.gmail.com> <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com>
In-Reply-To: <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 19 May 2025 22:36:52 +0200
X-Gm-Features: AX0GCFvbm9GK3YytAYW5KkKwW8G7S0FDKQ4iXt9eAphqt0Pv4tDqgAplSmqLVuU
Message-ID: <CAG48ez32BYaor4pWcG4+X6zqXgdskeC2UR3Kte_pp09-LeKMug@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:08=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
> On Mon, May 19, 2025 at 9:01=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Mon, May 19, 2025 at 6:24=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> > > +    /// Set bit with index `index`, atomically.
> > > +    ///
> > > +    /// ATTENTION: The naming convention differs from C, where the c=
orresponding
> > > +    /// function is called `set_bit`.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// This is a relaxed atomic operation (no implied memory barrie=
rs, no
> > > +    /// ordering guarantees). The caller must ensure that this is sa=
fe, as
> > > +    /// the compiler cannot prevent code with an exclusive reference=
 from
> > > +    /// calling atomic operations.
> >
> > How can atomic operations through an exclusive reference be unsafe?
> > You can't have a data race between two atomic operations, and an
> > exclusive reference should anyway prevent any concurrency, right?
>
> The atomic operations take a &self (shared reference).
>
> The patch is missing the implementation of Sync for now. With that,
> one would get concurrent write access through shared references.
>
> The "unsafe" here should serve as reminder to argue why it is ok to
> not have any ordering guarantees.
>
> The last sentence is supposed to say: when you have a &mut bitmap, you
> can reborrow it as &bitmap, and then happily call this atomic op.
> Even though it is unnecessary.

But using an atomic op when you have a &mut reference is not a safety
issue, right? You wrote a comment about behavior with exclusive
references in the "# Safety" comment block. If that's not supposed to
be a safety problem, this should probably not be in the "# Safety"
section?
