Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91763100
	for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866461; cv=none; b=snSUfmMu/uEi3jjuoZ8VdwxMgUR6U8Do01Qu9FfzXacpq6ZT8flozAHuNa1oREVBlawYsiRUhiFlSMX+KgXDp7Kwr8h1s27jbm34dYYuxXn6HNqEt3RBRKz0V8Qpb9HwGghovLlBiQlRXPtICpvSj50yP2SYbgMTJJKdAk1nhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866461; c=relaxed/simple;
	bh=BY5GoIGSOP7dLIG63O9VwREj4mpAu2roSy6H3SM/o2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed2d21WRtmSICmS5ixpRjSq7boKEfc0GCD7ZWsrQSqKIKww2i34G0u+zPbfkSTGYIeuxMYPseR4sE3Rr3wcXTjyS5KgB021rH+QZ0vPY78eNKCliJNVZrcF2oP15nKxsnA/5hU3Mlr8BoQGyG20X4JZpc+Njim4IZXa8VF9f22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYe52ioW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYe52ioW"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3726175a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707866459; x=1708471259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krbgXuktMmXDvx9RRRlz549Z3gZJaVVWAcsZQ2TwLyg=;
        b=BYe52ioWyrdtKDhW43xgl7IAsSt4i4qQca6n47xD4n8M5oNj2EjZuW4am3gta1dumA
         BjJJ8hdMU3HQztoAQSKVNk9ELOm2xpNG2+WGyVPlmkZge6FJSIjK45qULLgI7BXtbC6A
         1V7UqQtlnrEh9h5AhemVhB5zqBh8XVkF3mHkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866459; x=1708471259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krbgXuktMmXDvx9RRRlz549Z3gZJaVVWAcsZQ2TwLyg=;
        b=Ntbgq6mTQ+2Be3GhLAIf4eR+6cuukDho3uD0deUqeyqb36XoBiotxad5VrZy3+CeTF
         waVdSLAZ6LY8cfv13YOKfeqxkUpF3lpurkKgAUMG3Hvc13wRz0BHwfnxS+1EyeS4AsRe
         4viWsQ2jxxvhCw09psLnwMiHIxiFBcXIhgg4tjiDOtEpWdgTfEIXi9Vx+oV0QIXABVTK
         c7+sOY8nIFtHHlgw9g3sZcXz/hj43aKD3Qo+As4j7rLVSxn/IgLV4JxEEeiupMAORTVl
         u9EKE2IBTxwXcYTHywjhSY0/1moFHxgSDpa3Bb8dUNCf9u1ReLDULFcejBNrxapqgAmy
         UlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuyayn57xHAjwHc58cXiC5Jsf33y4GfkvLZqf0m+Yu5o5CXnCRXhrCWQpySHZMuzEw6ujBd3pxn3sy2WmxgwmFjFg+DrDKTQkDvsAAB94w
X-Gm-Message-State: AOJu0Ywjg2V7vUiUO09VtGc8UKjNSg29JGo3oIOnnkKAfbr99myEIUnk
	pxboEF3Y5VduZ845MaaMtdtTmk8dnCtbyZyh5mTjdN/I2Ayjm7qq6wLRz2fyXw==
X-Google-Smtp-Source: AGHT+IEIuNhWErXPZ9nXSxooGV1ezrrMMASQdK7KNyZegoK2alICLBJHRNefpd8UR9NyYC1J3nvTHQ==
X-Received: by 2002:a05:6a21:e85:b0:19e:4aa7:e6ab with SMTP id ma5-20020a056a210e8500b0019e4aa7e6abmr1139087pzb.47.1707866459244;
        Tue, 13 Feb 2024 15:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyenkEM0u8YInNl7wXozwjZjFy/pXcY9Apg99QhcV/RG5k0XYmMLfT5qvVBGU+4ublGB2Gh0IB+DvVFVX2LHoZaqPLwwP+UDSK61Y38mC4BzrV3YrV9ZndFHySmtg1MlF6QjEE6MU3aqhGrWVKBJ81hqkMZfHgkHa/Ex+SVf3Z6I4o+H2yYwcwPCpotd0owZpuVm9uMAb4vFZEpgecX9iu81mt0X0vJc5gj9XLK5hDy6UJNVzmuKTK34snoJebc1VU6J27iLfQerSVfqOKmKroKxtOgAQPBjWd8yWMAiF8nWyHwbySptDxlzRhQji66Aydeo4SVQktIxW9Qb93pzVSXFR/mqdQ+bTDb/kkhSZ38doMzgLKmHEHXVYLy+W6JjVRBR33GjVcXymuw17ZuQNDz5ZxCdD6yg20EF2K2WIsjF7c5rNfe5J3KlsUuSmIFeKTtLkFl6fuJ5fiMM2cNY0R7p0oYg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b006e08f07f0d1sm7971669pfc.169.2024.02.13.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:20:58 -0800 (PST)
Date: Tue, 13 Feb 2024 15:20:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] stddef: Allow attributes to be used when creating
 flex arrays
Message-ID: <202402131520.4C9A035AC@keescook>
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-1-keescook@chromium.org>
 <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>

On Tue, Feb 13, 2024 at 08:22:00AM +0100, Rasmus Villemoes wrote:
> On 10/02/2024 02.16, Kees Cook wrote:
> > With the coming support for the __counted_by struct member attribute, we
> > will need a way to add such annotations to the places where
> > DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
> > takes a third argument: the attributes to apply to the flexible array.
> > 
> 
> > - * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> > - *
> > + * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
> >   * @TYPE: The type of each flexible array element
> >   * @NAME: The name of the flexible array member
> > + * @ATTRS: The list of member attributes to apply
> >   *
> >   * In order to have a flexible array member in a union or alone in a
> >   * struct, it needs to be wrapped in an anonymous struct with at least 1
> >   * named member, but that member can be empty.
> >   */
> > -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> > +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
> >  	struct { \
> >  		struct { } __empty_ ## NAME; \
> > -		TYPE NAME[]; \
> > +		TYPE NAME[] ATTRS; \
> >  	}
> 
> Is it too ugly to not introduce a separate _ATTR macro but instead just do
> 
> #define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
>   ...
>   TYPE NAME[] __VA_ARGS__;
> 
> ?

Oh, yes. That will be much nicer, I think! I will send a v2...

-- 
Kees Cook
