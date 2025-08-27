Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B62FA0E2
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276492; cv=none; b=TZW+hlZWEFpq3XGp253RzmbV9/rsgeGOCO7XRjvPXye5vZPv54M9z7d66mLUbk+PcWx7WXEoJKez0FNLh+XGSONx4ICSjV9Ghxl/Aptl45T1a0zad5CGndze1MnTscOo1oSpBeGaPev2lXG7wp+8VpU6Cv4z7OAFbzqBS7ViW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276492; c=relaxed/simple;
	bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAfQSdyG8HKZ4r3kU/XXF7i+WEzMXxAQgS9OnvFIlvP1pYj2+DxxEnJ4ddpyJ/GsCM9pxBfyvMBJnxrwWrU7bPiLBg8pyG5/4+u9ahZJyLVRRqzMSD6OVuifAk0R/bUvCAIfVukzdBmLC/GFwwelWqH1/peiCrUJR6F3UFdUemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYM86aQG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYM86aQG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so2359078f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756276488; x=1756881288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
        b=MYM86aQGmDiGJ1DSGwjfiaAG4hzrMe3wCquaVneCOVhvAVRZqvgHFil+F9z4jKOXjH
         /Ada35TI9RtLSjgsKiDYFj+4CFkczGhMALb7o23Cr2xC2vjy1pRYiOUkp5A909DYrE6l
         aDdozVWZdOJnmz+hpClXSWiGoxt8yP+LWUwIZIGqiwYgDIVKwL7Bfq0hxygsEx8JbEXx
         El++JPwU4w5gWVxl2mzIjpoVjL/u6RVMn04PD3wJctAyIqqdEAxU/TgWUEH4uvP7IY5o
         Ss3qdyRhjY+yEO57Ftm2nKOWzkJPFbJ5sAavV20iVtRB5gwOHK8IcLQTvUd6vVoYyrSb
         Xrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756276488; x=1756881288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
        b=w29W+18ogJh/zcmsXjTv2MpX+Kzq/FWrBOLIavSAnI1J9Sp4nckbw/liRyQFLKKzBd
         ja2F8EXDwFIhuNWe8bEeJPlEBkgVv7vuUtDUSJoaMSTM74ND+FdicZNAHpNbt6nZaK/r
         MDDuDihcGq0FQiupyjkDAF4gga3VclOEaYIemQ7ME5qPpaAnGLQqw8gObQsFC/mdj4bL
         E8w8A8oLyHJLHc4dT5DNKv50sS7/vKlLwb0KGQWATO8Yxz1XmGqTi7epMkHz/AUlXiAc
         fZpqzrkvC3ohVV75ALLMUfwTn4ZY8lJod3XA1AKPtZ7SOdx8KnsDanzSfbMVXoKt+kru
         Jntg==
X-Forwarded-Encrypted: i=1; AJvYcCXqbi0+98UeBqgKhoiLKqHxUfnJH3w2sAn04YGJ9V95Ie1m4SQ3q5TDHnq9L1FzxlHZH2hCTylmURFAhP7PhUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tLzU45gdrXWf/PVVJK+SOk5MyvRMBHSvVZksMwLxjO2GG7li
	qCONgNggnH6N4fgoOzaQVXAs3tafi6Mnu4hVKpsg8kEVQbNYrchuGl/Ape5VTGTHNBa27SuE/pN
	URxO0yFtU8xfoDqAUW4hcOV1k238eJcXI4clOygYs
X-Gm-Gg: ASbGnct3RyDjCxP58EgdOYwPCbuY+me5ma+bv5mlFnSDO9RLBTxdMaRWpUlYTCBA4ho
	GlpZFaUs+CuDNsW2WLcMWaq93WEePEAfMupCbc+1gqBOnI4tiFlyRVTDVl7J6lxnX0Yi0l0dG01
	SfzsiMlDyqL5jH80Jda+FfVSVEtjOjuFvAFP3TDIgEf88QhX6QtUCEjv1YG1Ce8FfYWxlHXoRVs
	nD896UP7TliX/y6IlMMr9wvSDphj9wV3hWbZjV/oZnlxoMYA5GCOBJFZY1plM7cRkXW35zPKzQS
	RgjVFknVNFA=
X-Google-Smtp-Source: AGHT+IHRMHJeg+OlS34CwVPeTSsJ6oKbe0SYtoe+2fYCZi20TFk6OnqX47DgEgm12EW1OVuqdS5DyjJt1m7YfsCFUbE=
X-Received: by 2002:a05:6000:4021:b0:3c9:2a0:1a9d with SMTP id
 ffacd0b85a97d-3c902a01d54mr8204739f8f.33.1756276488229; Tue, 26 Aug 2025
 23:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com> <aJ2Y21Yjs3a0CnAo@google.com>
 <aJ4Y_DAZe__0EWEm@yury> <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>
 <aK5KJDSDKiOsQ4gN@yury>
In-Reply-To: <aK5KJDSDKiOsQ4gN@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Aug 2025 08:34:34 +0200
X-Gm-Features: Ac12FXyexUrBaVTscx3URjfoCL-mSxtGR999p3jbzclq_r2ZesgUeNBJDls89MY
Message-ID: <CAH5fLgg0BXtbqR2Yw4xxsU4MWmiM0kz9CGCjm=HytAgQog4aoQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:58=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Aug 26, 2025 at 03:58:01PM +0200, Alice Ryhl wrote:
> > On Thu, Aug 14, 2025 at 7:12=E2=80=AFPM Yury Norov <yury.norov@gmail.co=
m> wrote:
> > >
> > > > Thanks a lot for doing this, Burak! I gave it a spin locally on
> > > > v6.17-rc1, and it seems to work.
> > >
> > > Does this mean Tested-by?
> >
> > Just to confirm, is the plan that you will pick this up through your tr=
ee?
>
> Yes I will.
>
> This series is very related to bitmaps, so I think my branch is the right
> place to move it. Let's wait for a few more weeks. If no any objections,
> I'll apply it.

I agree. Thanks a lot!

> Everyone, please send your tags if you had chance to test and/or review
> this series, especially the rust part.
>
> Thanks,
> Yury
