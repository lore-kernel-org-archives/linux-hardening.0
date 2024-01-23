Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572920DEF
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045889; cv=none; b=M/zjrRleNuvGZLWre7F19HPiNRHbWm9zjLU2B/v5Y+jNlMIfWHuBzHWgEBPgpMztov+WpcsFuw0EpzRYUozLFtuxbU7U0sXXr+B6jKZzNiJicX3ktK7mdEMBuQZTKbBS3xzDyKlPcpKyhwRJFgJy+fedhaNvmlCWI+LSv1iG+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045889; c=relaxed/simple;
	bh=Q1sznM/S5mqUKJJ+NwJ1o0bscr4Kus2dQ+61NX22TnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Rwa6wsQW4ZvWmtl2qoFOWKfCigTjXhxzT5UpWfCLVRjBJLalhJltiOXqrNzTJ+n/JeQDZW0I32LHpVvhDJs15T3AaxPCDg+39TDJlOnQaKO+Ar3fsw4ATsfOJwFCzrf4f6J3e4ls46mm5Wx3v8OKvuiW0/NDar3Pium0e/jRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NjzM2DSa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjzM2DSa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dd6c3c8a0eso1032144b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045887; x=1706650687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKF99EW1nwbD3BFEhWV3Q7Xu4D4ZSEv9qrH8VfYUa8Y=;
        b=NjzM2DSaFegrpn3uREWVmjQW3Eqh7IgT3S38qJDJGgHZri1/0dcLnxQ2sqx9q12OyH
         fitsz1tw3uz53+b0MeVtIIkiG3wLgFUk8BASgyEyVKmXEIgnwP30TmBuZbFln+N2rNc2
         uvC7RCOAEt6itr7G1QFdeTnQxvpLnIx5hMuQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045887; x=1706650687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKF99EW1nwbD3BFEhWV3Q7Xu4D4ZSEv9qrH8VfYUa8Y=;
        b=kZrwa1wVauTnKI574juRtuOfPavXEx/mR4JMJeDVYui/yN1HgWCWFo4SFtx9f0SfeB
         hhscOt12APw6pvifExD6AleIhi1UnYxCs6xbJV00y5kgAawTFOE3V7E28B5aZKGOmgDK
         eEwM5oH558l+9Li3QzdwBv3lUABcev1O4rb5gVDCYKBxYjP0dapm2edcq2NIsYmEIbP1
         4mTOSKtfb6B1EoIzm69A+otRwc9aLR9/cNO2uTGqfrNtwfbvT1KQWmxdPCNAHZJ9O2v5
         iE1HVGY8k/U0rnxQupoyBgdWIwAs9zpLjwTYd5T9WcQAErqeFb6Bg7o7Z942YlUi8ddO
         e+RA==
X-Gm-Message-State: AOJu0Yw578CW+1xh/KrkdQq4QJVwTLef+MHE0DLhdIc6sf7f3HqhOAgG
	KjCK/QgrkMTMxDbsA11e93hw1qfXLtUj6q0HGhdmB7blePyE5TheJsuqe+1UMw==
X-Google-Smtp-Source: AGHT+IH5n65f4ayBJ0shws4yKzuwCr37u50lJB8acovsMZ1i0lGrNKUQIKK1RcNlF0t2Naa5zvfiTw==
X-Received: by 2002:a05:6a00:9382:b0:6dd:84ce:4602 with SMTP id ka2-20020a056a00938200b006dd84ce4602mr1015895pfb.6.1706045886959;
        Tue, 23 Jan 2024 13:38:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fj1-20020a056a003a0100b006cbe1bb5e3asm12143746pfb.138.2024.01.23.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:38:06 -0800 (PST)
Date: Tue, 23 Jan 2024 13:38:05 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/82] overflow: Introduce add_would_overflow()
Message-ID: <202401231332.135AFC9@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-2-keescook@chromium.org>
 <53a886c9-10df-4bc5-9de2-d9f99ea78278@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a886c9-10df-4bc5-9de2-d9f99ea78278@prevas.dk>

On Tue, Jan 23, 2024 at 09:03:10AM +0100, Rasmus Villemoes wrote:
> On 23/01/2024 01.26, Kees Cook wrote:
> > For instances where only the overflow needs to be checked (and the sum
> > isn't used), provide the new helper add_would_overflow(), which is
> > a wrapper for check_add_overflow().
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 099f2e559aa8..ac088f73e0fd 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -108,6 +108,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		__builtin_add_overflow(__filter_integral(a), b,		\
> >  				       __filter_ptrint(d))))
> >  
> > +/**
> > + * add_would_overflow() - Check if an addition would overflow
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Returns true if the sum would overflow.
> > + *
> > + * To keep a copy of the sum when the addition doesn't overflow, use
> > + * check_add_overflow() instead.
> > + */
> > +#define add_would_overflow(a, b)			\
> > +	__must_check_overflow(({			\
> > +		size_t __result;			\
> > +		check_add_overflow(a, b, &__result);\
> > +	}))
> 
> Hm, I think this is a bit too ill-defined. Why is the target type
> hard-coded as size_t? What if a and b are u64, and we're on a 32 bit
> target? Then a+b might not overflow but this helper would claim it did.

Oooh, yes. That's no good. Thanks.

> But we also cannot just use typeof(a+b) instead of size_t, since that
> breaks when a and b are narrower than int (adding two u16 never
> overflows since they get promoted to int, but then if assigning the
> result to a u16 one truncates...).

The add_would_overflow() is aimed at replacing the "v + o < v" pattern,
so perhaps use typeof(a) ?

> Perhaps the target type must be explicit? sum_fits_in_type(T, a, b) ?
> IDK, I just don't think size_t is the right thing to use in something
> that is otherwise supposed to be type-generic.

I will use typeof(a) and check binary differences to see if there are
any places doing something unexpected...

-Kees

-- 
Kees Cook
