Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812ED2FF
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691384; cv=none; b=lhKkrJAbmz0RGhvHG7HHkDEo3yeLPk5C95vmzao0hGk8r/2pb3XtXyUY2hgSflj+4hQ4NjFGtnl4jJGUYd+SU8sS1FyJnlUY2zhQ2MOHJUSUYnhVK3A1aVso/hmdYm3k/3JLj25pz5yTl8oHvVlTfud/sbPzygji/RcyJrsXtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691384; c=relaxed/simple;
	bh=+u7PB1Z5VLEbrjkXeT5Fg1xx3+Xzkn0Fzy8bmheyQgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOLEO+dRKVssgtuATUUH8n1zaWuKLpM6s5SPjaZRkmMsrgNRtt3UVkDyI0Ffo7/odsSd/4oX4cpAHSOwWUr/w99IQLBul3GBj9JbEtpgrDoI4W7InSWo5mt7fpZLB+qDKMnfMvUtvm0t6jUzIm7iyZ8fKlTTHT1ZSgRc02cKRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxcnorgB; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxcnorgB"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601a8b6c133so3251515eaf.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747691382; x=1748296182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u7PB1Z5VLEbrjkXeT5Fg1xx3+Xzkn0Fzy8bmheyQgo=;
        b=dxcnorgBjLty/D3q1FdVhx2AEA2vra0KnwirFM36g6Xh6EfYEksr7z3AMVNJbaETBb
         Vh8F9WDsy2e0RSlt8lznVpchdyZZ8PtmJIL8hM9LJaBOcXCkTNIEf7DwoA3Q42Koxb2c
         5IO46GKTEci+b+WHlgKOlHmdFkOtbDR3lvfKMktTAqJJCZWdfhk3EfZrDbRvWej8KWjr
         SRcKkCPbaL0WSMDUnKeCLx0YOzH5zI3VxWCm4zOkcJ1rhlslJBjzUGI+7+pWoxT5Ob3G
         H4zhhnZyUXeakKcrj0fAXMLn3rGGiwv4hVZwPM6swvW14I4ARVXDYgBu7M9KS3cZQB4Y
         y5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691382; x=1748296182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u7PB1Z5VLEbrjkXeT5Fg1xx3+Xzkn0Fzy8bmheyQgo=;
        b=QVxZPETZkZBkQs0pjMSOODi42vVhuOf2ehMHWahBZdTaTFWi8QlftnvQIzYE9wC1zC
         erDsMm4qRQ3k9nGxGq/B9xJZd1AehtJbgrwJbCDeoYHAL87TtKsN0KdPJH7DcRIueD/J
         or2Gy8kTfCH7Z1B4fiz3oO9/IArmfoj/CnUuDs+F6yiwj2zDVKiaaAgEPwX3hvxS09ir
         45Ev6m3qGZmKb3HJIdIjdn2Yj4cvFnF0BYe0pW/9O7H9xbLe5iuv4QIfZj13PgMT1vjL
         V8tMUNOqtYbWDJZvujLaUZXNsu8QcoKwKEcQDD4Fb0ZFuZJcqXPycxA+yvrNwAKSPoUI
         992Q==
X-Forwarded-Encrypted: i=1; AJvYcCUntBFDq65MXANmO1aCd2z8G1vNPFK+zo27rRPre0a/rh5FnZwJg7rPcdfkeAOAmd+ODL99n1O+lEDLd011sro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjmK66WufWrxjXoPAbDGbIg40oMdy3q90IJBcGR5gLliFvOHc
	SJ9LDb0ycVcYtyrIwkV0DSoFUazlC6sJhbp8DoWz2CzcvA8UFieMOEZnrvk96JVl6l2MXaDIIlx
	xg5l0vW5omcVB2OSejJN1y2qLlSYsZB8isoHCzstY
X-Gm-Gg: ASbGncuTUyvtjjNxPZYBkr/DovzAUmLCRfc/06NrxhU1dbnQNYUSpKr1JrgfBM8aB9C
	oecV0FAJGuIpKiTI2uBnNKlDIwg2dOA5I8OSjNlopS7AHrxCWDWsUXJjdvzYJwfFd2s2KaY87dR
	EWCdOfM8QJ29i18ovLAvZM4inlrGU+iK/OC0/xsqXVWAAXuaBQF+1wjXs5qk4U
X-Google-Smtp-Source: AGHT+IHDHkRq58JIPNvvyPB5attty18ozlWf44b0VeRKkgwSND9j7m7Tdi8BgwfZq3B/e6Q6Hx/u8L0vzV3d9OtEQe4=
X-Received: by 2002:a05:6871:6115:b0:2d5:714b:f07c with SMTP id
 586e51a60fabf-2e39bc8c605mr11232672fac.5.1747691381732; Mon, 19 May 2025
 14:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-4-bqe@google.com>
 <CAG48ez0rGwFeVtj6AKg8YY=D9Atvp1h5FdW3szswEJsRmkR86A@mail.gmail.com>
 <CACQBu=UNAFjKw_m8oE5Mst_eThEf36zqgUWZ3a0u1m4zr6MoJw@mail.gmail.com> <CANiq72k6vhzR8W72B-vqHy3rrTv+y9rYECx9bfHX=eD6TXye8A@mail.gmail.com>
In-Reply-To: <CANiq72k6vhzR8W72B-vqHy3rrTv+y9rYECx9bfHX=eD6TXye8A@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 19 May 2025 23:49:29 +0200
X-Gm-Features: AX0GCFt_KNDRxySWbchXyhWaT6j0sKpaZ36nYbMjHgqpY54iLKrBcjTnijcS_7s
Message-ID: <CACQBu=VXAPfVGxVFiW4iZWF=kd4ZdwH4xwz0YgXnoqK1UnHRkA@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Mon, May 19, 2025 at 11:42=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 10:08=E2=80=AFPM Burak Emir <bqe@google.com> wrot=
e:
> >
> > The "unsafe" here should serve as reminder to argue why it is ok to
> > not have any ordering guarantees.
>
> `unsafe` should be used for unsafe functions, not as a general
> "danger" or "advanced" marker.
>
> (Having such a marker could be useful, but `unsafe fn` is not it)
>

I can see the appeal of having a strict definition "safe =3D no UB".

> > The last sentence is supposed to say: when you have a &mut bitmap, you
> > can reborrow it as &bitmap, and then happily call this atomic op.
> > Even though it is unnecessary.
>
> I don't think that is related to safety preconditions. A "# Safety"
> section is intended to explain what the preconditions are.
>
> So, for instance, stating "The caller must ensure that this is safe"
> does not add much.

I see what you are saying. Not being sensitive to order is a
precondition to a property.
There are many different kinds of (colloquial) safety e.g. crash
safety or data integrity.

Sticking to a technical definition of safety has the advantage that
one can be consistent.
So I'll remove the unsafe marker then.

Thanks,
- Burak
