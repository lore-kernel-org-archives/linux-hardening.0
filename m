Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4B41742
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046757; cv=none; b=Nz/WXchwfgzCy8t2Zo0JS6YV8pyctX96CULdpkEK4y+Cvfz4VL3R4YMVzwTKh5Drr8OjyyhF1GnPmGZStmx0FN9WekDyVFYRkRx9OwHUMCRMeeEcl45szXParwrjBDoQ8ORVV1+B0DLPn1IxLbx9XtyrlE/nbqmdBVvmpQ0vUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046757; c=relaxed/simple;
	bh=VUhlMv0YIbLBaprVX+mmJCjmL8UnZ1q4FSBZdfn36Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwv4UsSncvApEQboLAsp97CIoggs9LmukxB8r+y55swykbSinZWSjtVE80RSKyFdjmgGbg5qzSvNjIOKgLsR6ZzloOv5gIEW1xMYUXm/cEShqiTTUKEEv3SjUjM/8AN6y3hXFPoFAzuGbKuEcfkZdjnThtltYK738TK58ElhDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P/fYp5fR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/fYp5fR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71e1d7c78so27710445ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046754; x=1706651554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sj6Rxvm207/3+H8NF8WKC7zBV6u0ee5y25nooD5f1tg=;
        b=P/fYp5fRzOsBDHkrucMCFg3aa0kOezEUiLMjLvA3Jud+3RS3VWgOm6rAu8HZMbRuF2
         J3s7mpYUvE0JjafMvkqHHs80gYIR+X9M+Ci77C97ue9UOdV5a6CybMTKzifJDZYFQSgO
         w1HqjBzbXWdcXrpkKp6OLIEAzLHdFV2P6Jm+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046754; x=1706651554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj6Rxvm207/3+H8NF8WKC7zBV6u0ee5y25nooD5f1tg=;
        b=tMeq9GD7faYxSm379RuCu6n+KFrOhPfFqPJEj1MuUJVAja7v57B+wdp+CX0KrxDzAQ
         hLcQBByCwpmjGDfuqJvGZRZ6O75KwRFSNsKJSq5CrYmQjKJ2QEr34NGb0oFJ4C/OpxBq
         TnOF3HkH7cpBttj9y4Q8j9iQg9JtP4y0+kzv5cZCZ0LTn4W9dk+a+aZKDcGwh+LylUtz
         TQ1qhMSU7IKxoLgOyWFqVVrxPX1Okt93frk5vA1QGfc4Z9FQPCFOAJPJppnep1olfC8z
         xgiyzqMVNarXgTANLmPg7MZi1oRzKJrSrtvpVtf4X/qNVshAeUJ9s5k39MtA7yFZ8NOG
         RsQQ==
X-Gm-Message-State: AOJu0YwnIHYQD++Z01Fi0iCX1bKd4hyMYxP2oeTMfP17/2EYGz1eq8FC
	e9ZWakl9CyBI0YXpTup+19+U53Tt/bcjnjSR0+Qwk8puxD0+Pnm5v3OaV90SpQ==
X-Google-Smtp-Source: AGHT+IFKAAxa7+zxk0HWVIDCHDWWNy0ZSAAupe8tRwFVU2gSFPlPb1yvRpztsCFviLTsRlN6y5jGJQ==
X-Received: by 2002:a17:902:e810:b0:1d7:6f5a:d390 with SMTP id u16-20020a170902e81000b001d76f5ad390mr1575176plg.55.1706046754292;
        Tue, 23 Jan 2024 13:52:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mf11-20020a170902fc8b00b001d748fb211csm4331068plb.276.2024.01.23.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:52:33 -0800 (PST)
Date: Tue, 23 Jan 2024 13:52:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/82] overflow: Introduce add_wrap()
Message-ID: <202401231352.7CE79C5F@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-3-keescook@chromium.org>
 <Za-FbFE7slBpwrbq@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-FbFE7slBpwrbq@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:22:52AM +0000, Mark Rutland wrote:
> On Mon, Jan 22, 2024 at 04:26:38PM -0800, Kees Cook wrote:
> > Provide a helper that will perform wrapping addition without tripping
> > the arithmetic wrap-around sanitizers.
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index ac088f73e0fd..30779905a77a 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		check_add_overflow(a, b, &__result);\
> >  	}))
> >  
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping addition
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Return the potentially wrapped-around addition without
> > + * tripping any overflow sanitizers that may be enabled.
> > + */
> > +#define add_wrap(a, b)					\
> > +	({						\
> > +		typeof(a) __sum;			\
> > +		if (check_add_overflow(a, b, &__sum))	\
> > +			/* do nothing */;		\
> > +		__sum;					\
> > +	})
> 
> It's really difficult to see the semicolon for the empty statement here; could
> we make that part:
> 
> 		if ((check_add_overflow(a, b, &__sum)) {	\
> 			/* do nothing */			\
> 		}						\
> 
> ... to be a little clearer (and less at risk of breakage in a refactoring)?

Yeah, agreed -- that stands out more clearly.

-Kees

-- 
Kees Cook
