Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F1224AEB
	for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330259; cv=none; b=S1PZQG0BhRu/9hRmilg5WDXlo4kIhTWX+3aoM7eMF3TNawesE+H/fGN+CSG9N4Fdp1X9mM0B9Fmq2BLxDsB8MdDHoPA6iuP+pR7x16NAlLFuunZ9ydbkwRn7Wx8IrodRCo8C4q9rzdfO6fqo7hICRYFcYB/3HXcG9BrWBtj7/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330259; c=relaxed/simple;
	bh=B5nwRN0D/Gpfme4JMOlAX0pPFV8TVKGGlk+5USmaxrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7YsadJiCFffPZ/xeQFzZ11kprdpYGBq2lL/3DmEKsQwaZK5pKaIjQCkWMvj0l2MHBt2we6IjCqah2y3msYOx1G7OQimyC2c+CPNEXanrt59sTulaR7fh5/MzIGRgSESyMh4TESKgHUrCtR9T2gyEUMyxGjjci1d5pfopTJ0in4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJ+KtYGb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJ+KtYGb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a528243636so419886f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750330256; x=1750935056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYz7+pFibNw9xxyFYBk3NBPAjtW1pCVQhPTMzi/Ej7U=;
        b=RJ+KtYGbiRlCIc7NstwRwj6vudYAbpelduM+WWm5g2ojqqAoifyqlOdhitio7UEwww
         pnMdqWTdFlkLgcDI5vMgcRyKDd+Bx8Aue18sLuXXUh3SOsSOcMB6akG3GGMw/7MX63EP
         vy9sMz3tPwSzP7pI+RIipxsHdkvCHp00o5IHKZc2zap/Tu0TZUtbGtAAPFnZKRKV/6st
         Dwjw1QpMgmrRuDcdMbZFQROz3w3nQ3A1EJAZPo2WjUKvYRC5fyKf+T3fRUYRcHn2WU2R
         b7GSE9mij4V38TSBWZNyx86EDkMnS/cps9aee5Ckckh2SxT85+CQuqFxAKR+0YP4vg22
         gTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750330256; x=1750935056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYz7+pFibNw9xxyFYBk3NBPAjtW1pCVQhPTMzi/Ej7U=;
        b=aqcepAm6w6KRlJC9jaU0/SiOYrfFsnOpOlq+JrWu9j9TbZmRJYnv12dz2r+/7S8VNO
         +Jb7r5cMVYZ7oiTRqDcqsXZdIuzyCCNdvatsUGN2GMrEIA2bfG0oBFslQZyG58TpxvOQ
         sEWH/BaIjJnaQysABR4N1WUX01adsAjuaQY0AZQdnwvU302hrLTJdaZU+6ynXZAPCO8p
         kS+Z9wF8A0UMIQz8z5Sxz/a2pIfre93JhJmIN+qy2XmYQ2IaRIhxeMw0xYYnIbJrz19A
         H2zqZy7op6bWtCeT6xiwr6cQzWfyLQ3MepVkyiomRvjL90NDrAlLJglSgkf16/eFY+56
         cp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsN7MvsMEdeBpnTixOM/jeIKLGH51aKUdabM8lyTP8rQm3O2y9zlxxTgOpaobwBU+4QvfB2fzCjKp+245Y/p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NSRIh3oZ4meWbhGjvTJEie0Feqgz9mVEFyKlNCWYPvUFiKal
	428Xizkh5aE0HTTqBHQtWQ6NQo3PbOe7yvlqIMFpwT4wjTh8ceXl28f2tN1C2Wm+gSuVLOmCbfK
	/nU09VdrBlHonR45SiGwNWBG5cELq/i/QYf8fbY5H
X-Gm-Gg: ASbGncsx83ola6fHDB6URZxBjmvDRm5a7wJLGgqX3w+dlsSWCNFahwFIUg+rUh61Ohe
	nfZrPSTgTXk/U/bXhMrLLUkCwfPyibaNT8pX+lFSwVyw9PJlLHbHQUbbeybczyMOviAFJ2PK+pe
	0OQKzfGdfnwsQpp1glvNo6eIfLFrYF9D2aGEo22jwlVAIpz3wCZrxa4EI240/+WM2q8JRvfZISB
	w==
X-Google-Smtp-Source: AGHT+IFsqFDhKIv64ceK6XQrOc9Qsekzsih6MfirQI/OCI8WJNBcEkEExzxrQkUKIqsWyKy0KCKo5Y52KDNONSCzm6I=
X-Received: by 2002:a5d:64cb:0:b0:3a4:d274:1d9b with SMTP id
 ffacd0b85a97d-3a5723ad5eamr18216483f8f.25.1750330256321; Thu, 19 Jun 2025
 03:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
 <CAH5fLgiMCZuaCSYRDLCpZjaa=EZ=Zaw4y54zDED-7ox9K9++2g@mail.gmail.com> <CACQBu=UHdyxiqngiqE-5KPVyn4VFmCDapKiy2W27ic46uNO6sw@mail.gmail.com>
In-Reply-To: <CACQBu=UHdyxiqngiqE-5KPVyn4VFmCDapKiy2W27ic46uNO6sw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Jun 2025 12:50:43 +0200
X-Gm-Features: Ac12FXwUga8sxOhQeH5daHYwT8zCTot9A36Z2YfwsgBxPIWqgfMEo6I4tjBhdMk
Message-ID: <CAH5fLgh5pPRrPLCWFb1+iWF5ukK7ai0vek0eU5BRsEEHtdGt=Q@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
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

On Thu, Jun 19, 2025 at 11:49=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> On Mon, Jun 16, 2025 at 12:49=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > On Wed, Jun 11, 2025 at 9:48=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> > > +impl core::ops::DerefMut for Bitmap {
> > > +    fn deref_mut(&mut self) -> &mut CBitmap {
> > > +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ =
{
> > > +            // SAFETY: Bitmap is represented inline.
> > > +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> > > +        } else {
> > > +            // SAFETY: Bitmap is represented as array of `unsigned l=
ong`.
> > > +            unsafe { self.repr.ptr.as_mut() }
> >
> > Nit: You want NonNull::as_mut_ptr() here.
>
> Can you explain? That seems to be an unstable method that exists so
> one can get pointer to slice buffer.
>
> The repr.ptr case is NonNull<usize>, not a slice - though "morally",
> it is actually an owned C array.
> Are you suggesting we could/should represent it as a Rust one?
> However, we'd like it to use the C API to free etc.

Sorry I meant NonNull::as_ptr() which returns a mutable pointer:
https://doc.rust-lang.org/stable/std/ptr/struct.NonNull.html#method.as_ptr

Alice
