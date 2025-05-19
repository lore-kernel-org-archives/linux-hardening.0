Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE5221FD8;
	Mon, 19 May 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690938; cv=none; b=IgJr26kGlyqzEPIRYoaUEe1DRdfJ+SWRW1mgqTEQPBfdaEi4y8ICyHn2Jh0BQYPNKALPoair5da5tr9m2igqh4TcbBuZVKxjFJ3JEBa5gC7A0CJ5rDk/CxwJ5OV/qmBM6KWfrP946ARf/XFXobmEhYSuAVMJE9g460LJuw/OB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690938; c=relaxed/simple;
	bh=WDSWE3gP7j2FIQSQ6D66Q8MzQi48NVrW+aW2lCu1W+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St9pk1KBzuZ/wmTmj7D74C7apo+Hixj8QpZgEHwhTowwBuJxpB/S2eG0fkOl1O9+OwkFcRiM6zV5zjtr7ID04APhvkFfalA6WY5XNlaYHcUVnSWr4VhF/PvVL/KdhbbLDTIoJvb2dOqHMKpZuQpIIFBeLCrmmfSrpUgaN172Aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLmyyNjM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLmyyNjM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231c790d558so4400235ad.2;
        Mon, 19 May 2025 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747690935; x=1748295735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDSWE3gP7j2FIQSQ6D66Q8MzQi48NVrW+aW2lCu1W+U=;
        b=HLmyyNjMrRsMdfnc3IWNwcAWtX+u3HqNfyGAxNwK8LUZfy4RqWmaRiIUIZz156GCHn
         hrVtMsjN/5sL7j1uhcyNkTwJEQlUBLD90XKZPFeHnYIA+Tu5Cby1/Ctt9QvT6gW5VrKZ
         xvkvSYPIAzB6GqxaVPHTV377216TWJVHkdx0Irg8wY0pYMeTF+8nxUU7L4Jx77crtt6C
         AZ3nQ02hqnMRQNLDTVbWbb8ZXrxtzh6aomVHFwqshZ1ARX4XVe4DZvFzLtkwC4WYzoV4
         tTTUrEftkpDRB+lYMF9BPWjVlaE7bwgp3lhCZDReKoRKk5YrteGO4xmTzCEVWJTQYusI
         eVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690935; x=1748295735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDSWE3gP7j2FIQSQ6D66Q8MzQi48NVrW+aW2lCu1W+U=;
        b=nmdKwC/5ksT8wj3ziFGRRYPY5zyMjqFMwhdPCINRhuFlyu7ioUsmWIY+TwNBkZxLNQ
         sCRqh/ZX86UupbIU6gvA5PSkH3bszRd/iizjqQW+NuNy/IS1mkDGvGw+iXoq9rT1rrBr
         G6J+M+2GH14s+w3TxAfxCMYhpy/XvODfITPIS/xV8YapOwePUBQRzwlAT+66hDmZqR4c
         SksQjXnoZdT5XnnhJG56gSfknFgsBQFd/zz7Bz9hBYCu34y0jK7jeiPQ5J1pLE6FXd7V
         MnfUDmxgf2WSWLp2Kx1ScucZFpkoejlLppFhVc1eDUf8MYkcPoZMLRS17wdZH17Oq9lV
         YGUA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ycb+vi+RlpJNHjID0o4g5mGq+z08mvbCcQvs2W+/hiJX/qxeLINNt4tsKWVAM2yku/AY+kVU52txem6U@vger.kernel.org, AJvYcCVY4SewXo8JpEcWPCwlEnWR1bB9rRVaqBCz61THrAU5GELi9JdhHoVXigFCDSbSk0on/VIDqov/BxQbCyyjV0o=@vger.kernel.org, AJvYcCXC3/JrV5peRMhMqjzHFZMzd4u5s2St5VPnq8E5DHHCotT5Mwmz6pPP0Ndcdso9KxMAHMqoqjsieo17mKWZl9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZUclV6kBQ+Ng1aHVX/Gn9K0Mw9JDfr4+MtzvVh9ZcD1Xu3ae
	pDtjWU7PmYnj2ukR3pTFNSY5RJCRGo3jGLQMoZaSA9ibbpWaKLRje3olyIwQ9wjQYFM9nPEzmLc
	ofXBciNMSIRkQjGAOj61K9PJQLdylCug=
X-Gm-Gg: ASbGncuH1osk7aL64W8hwkSo2ezMqa3ZYqARp1gqGjrcjOv32jprYDfTjU3RsdUA+5y
	fo/wqURhX0KXfm84qBzbCm1TbO0lciF4gXtwbqRjfoqcTpskRFeirq1rSF8ggmq0VtPGHr1Z3dG
	YdQfAZJZ5plnnnzAEa+pCgAizFgUQKFw7pyS2lstjWnV0=
X-Google-Smtp-Source: AGHT+IHsCi/2N7hotRXebV0RAh6cX3MQnlOwBcftF6PyORRv3ZN0aBa0lLT2G0MmNENbcLW97S2/HpW+KmHnXtWR5fI=
X-Received: by 2002:a17:902:7482:b0:231:ea68:4e27 with SMTP id
 d9443c01a7336-231ea685044mr50493575ad.6.1747690935028; Mon, 19 May 2025
 14:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-4-bqe@google.com>
 <CAG48ez0rGwFeVtj6AKg8YY=D9Atvp1h5FdW3szswEJsRmkR86A@mail.gmail.com> <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com>
In-Reply-To: <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 May 2025 23:42:01 +0200
X-Gm-Features: AX0GCFtL5_aVVhwA1lXMbrOYch4YCqsmIHX3-0KiBMzHqiX8Q82bwJNBae5DaXk
Message-ID: <CANiq72k6vhzR8W72B-vqHy3rrTv+y9rYECx9bfHX=eD6TXye8A@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
Cc: Jann Horn <jannh@google.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
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
>
> The "unsafe" here should serve as reminder to argue why it is ok to
> not have any ordering guarantees.

`unsafe` should be used for unsafe functions, not as a general
"danger" or "advanced" marker.

(Having such a marker could be useful, but `unsafe fn` is not it)

> The last sentence is supposed to say: when you have a &mut bitmap, you
> can reborrow it as &bitmap, and then happily call this atomic op.
> Even though it is unnecessary.

I don't think that is related to safety preconditions. A "# Safety"
section is intended to explain what the preconditions are.

So, for instance, stating "The caller must ensure that this is safe"
does not add much.

Cheers,
Miguel
