Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506056;
	b=LXBVJ1wOU3h8DC/gFXvIbc4W9EXpDLCdgqbDdR8LJe6iRbfYZ8/KAv870IUUHW+ixFOa
	 a3L96fBgkVR62/kxTv0GKSwGYjhlr8JJbuY8ZyUpCwmQtOVKbu9CGXoLsf+h1Me0cYuxH
	 2c7YTQb0jGRZRH/YuQ8SVqSMxtL3LIn7O1p5jdnbnLnt3eWv8dBkKDj5DShQrG8Wj9JYj
	 7DIcfWLQWV1+GC4P9EmDA/3wevz1jwKKqGb0tMH3T6jQbCk7lL3rc+qngYHbvo57b+lTu
	 3eovPqIgRrNvamOyRiDUd6qdQlaWqYj+btcZWYvxkUF+yha0S9I9dYexAx5q/91niVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506056;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KZYx9D5fxjDb18mOMaOgK0XNDjq8bhnz9Ai6JNoRHvo=;
	b=f+YXbh5YEiEwpnAbaKHMP7Macc2DCin2vzDWkfcPrih9W9F+6X/MVw4Tg6k3J406bYfJ
	 mJGTe8CbaLO7bRc+9DsA8vQ19ZqaRTjAjBwpNn6L3xgGAgWxh0kDKD10HfoEbImoMQDek
	 w0GlfrvoFfeVPTHyTd3YRruiL+0NFhVqVPTj/x/12hVzV3WI90peqWawWxsHriqE6RQHQ
	 5B4PhdOW6deaMYlQdew++77YtJo/8kYz/sNgDKcbmVoQ/lJTorajkTwWUDBhK+QrIeIvD
	 bRAiaHgkD9/NKZiB056F6+L8YfpmMEXKxwYbFrxdTKvJmel1HFYBi5RlmIXZb7Pz/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9mRDRW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0E606A321;
	Thu, 12 Nov 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9mRDRW0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68CE1F000C4;
	Thu, 12 Nov 2026 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506055;
	bh=KZYx9D5fxjDb18mOMaOgK0XNDjq8bhnz9Ai6JNoRHvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k9mRDRW09luqcyp6rMVU0ujx3cG4mPrVn0q468qRauXrhRTmzlfziU7C4Zc6kBJ3K
	 bIK+lgfBM9fnF466E0vXW4Qp8wZ0zWftPBWhjlZsQ7OSKc8jroTRObMzKZTPDW0SZE
	 hrKNqW6lNjrPO80qGuKur1eCZbfLpqkkpbxMMAEKxgclGiAk7oLrTS4Mu7JPdRKt1a
	 afv5xBGXAV9nJtiL+a5f8rO7LF3lP0t+z6TPZA6LCCHuqwUaNxusqujy8Z1pWbkPdk
	 24E1lVHck8ICQwkK/75OL3mSeTYb6RVHBwmCx24Xs/cVO3xjnIluj2mLXs7D6a7njJ
	 PKAr2KzpgCqtQ==
Date: Thu, 12 Nov 2026 09:54:15 -0800
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <202611120947.AC428BE4B@keescook>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
 <avDmyLYpWOQ2WB-i@debian>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avDmyLYpWOQ2WB-i@debian>

On Sun, Nov 08, 2026 at 10:25:35PM +0100, Alejandro Colomar wrote:
> Hi David,
> 
> > Date: 2026-11-08 21:02:32+0000
> > From: David Laight <david.laight.linux@gmail.com>
> >
> [...]
> > 
> > seq_buf is just OTT.
> > Using to replace a single strcat() is just silly.
> > There is no point doing these patches until there is a sensible alternative.
> 
> Agree.
> 
> [...]
> > >  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > > -	strscpy(v->card, tea->card, sizeof(v->card));
> > > -	strlcat(v->card, " TEA5777", sizeof(v->card));
> > 
> > What is wrong with (and almost OTT):
> > #define TEA5777 " TEA5777"
> > 	BUILD_BUG_ON(sizeof(TEA5777) <= sizeof(v->card))
> > 
> > 	len = strscpy(v->card, tea->card, sizeof(v->card) - sizeof(TEA5777) + 1);
> 
> I can answer this one: bugs (particularly, off by one) are quite prone
> in such code.
> 
> From the Authors of strlcat(3), you can look at OpenBSD's manual page:
> 
> 	Since it is known how many characters were copied the first
> 	time, things can be sped up a bit by using a copy instead of an
> 	append:
> 
> 		char *dir, *file, pname[PATH_MAX];
> 		size_t n;
> 
> 		...
> 
> 		n = strlcpy(pname, dir, sizeof(pname));
> 		if (n >= sizeof(pname))
> 			goto toolong;
> 		if (strlcpy(pname + n, file, sizeof(pname) - n) >= sizeof(pname) - n)
> 			goto toolong;
> 
> 	However, one may question the validity of such optimizations, as
> 	they defeat the whole purpose of strlcpy() and strlcat().  As a
> 	matter of fact, the first version of this manual page got it
> 	wrong.
> 
> > 	if (len < 0)
> > 		goto fail;
> > 	memcpy(v->card + len, TEA5777, sizeof(TEA5777);
> > 
> > What might be useful is a helper that would let you write:
> > 	len = strscpy(v->card, tea->card);
> > 	len = strscpy_at(v->card, len, " TEA5777" [, implied_length]);
> > 	if (len < 0)
> > 		goto fail;
> 
> Indeed, as said in other threads, I have such an API:
> 
> 	p = v->card;
> 	e = ARRAY_END(v->card);
> 	p = stpecpy(p, e, tea->card);
> 	p = stpecpy(p, e, " TEA5777");
> 	if (p == NULL)
> 		goto fail;
> 
> Linus didn't like my function name.  We could indeed call it strscpy_at().

I really just don't want to have bare pointers or lengths being used for
any of these manipulations. strlcat needs to go away because it's part
of the whole C string API that is confused about array vs pointer and
has no sense of handling bounds. Yes, FORTIFY does its best, but between
lack of sane bounds and doing a strlen for every action, it has to go.

And I'd like _fewer_ APIs (I realize that didn't happen at all for
seq_buf, but that our current best direction). And I especially don't
want a "len" getting passed around. It needs bounds to be *in* the data
type. And that means either true arrays, or internal bounds tracking
(like seq_buf), and it shouldn't have "extra work" associated with it
(e.g. stpecpy above still has to find the current end of the C string).
C strings were a mistake, but here we are.

So, for "easy" constructions, sprintf-family, and for complex
constructions, seq_buf. And probably the large bit of thought at each
place where it is possible, is "how should truncation be communicated?"

-Kees

-- 
Kees Cook
