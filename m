Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906A22652D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942536; cv=none; b=bdA7e8D+rTtQHNVYShflIrDJLQBozbDM4hbFySHJW1f9IbIaXt42m6ntyzAYgKWNsftqmkKHFRmm+LfkYA2dG6khRpfTGvXyJRTBq+4jZ9OKnxCjx4dLR3DDxXJvicscseEcBpq0wAbG/PbJ2pIDVQUL3nUsrooF74Ws2zBbFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942536; c=relaxed/simple;
	bh=oJsY/U/k4CbTYTTW70JIhrh7FeuaK8TVKU817s1X3EI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaaYW6J5bckyyNBmfi5wGrF6XhFSQSCgcsiGISKOabtkOSwVsqQGACMetmu7ziwOJy6ckYYC9c7MhoC2mEijCUpcswTuWnB4kjj/gdRJFh3gv9/loG50modrpc55G2PxWD7ktzXu1Z2WcKAlarmNdORk7ykCuVhP6/UOE9D6wkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Cs13VX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Cs13VX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so50859805e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771942533; x=1772547333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0iBNYLR3RydCyDm/jKb9Zog4KrMP0OiE2OvAMK19V0=;
        b=A8Cs13VXaVNteDkOhWIHpAvf2k84h+HJTopT+PPfdMiSvnXWqOb+HBfUuK8/PDZ1Ms
         U8TzJan66ztT1mr5wQGMSFDF+ERiKBXVevH2jY+TzgedvYPXNKH2iORIE8fpi9zpF1A4
         bBNVKX5KqKjT+Kyuk6iNnQ7SVOtDx8Iw3D9hPG3Jezh+F+novaSM5oktzMGggKI+faNY
         XaKqiMw4GAnE+cshOvuOpn8ssJIkE4g+c5RW3vQ3h3oNuZi10+MNr5nVbEsAa3x338/p
         +KGzM6sNmJoEMXqvHMrRMZWI5sKVX3sWSbQe8AtdxZgxrMrkZKkVJfHexBlpA03+X52V
         X76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942533; x=1772547333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0iBNYLR3RydCyDm/jKb9Zog4KrMP0OiE2OvAMK19V0=;
        b=dALOyJuuY2tvLQaxVt2CraGsarVLbpsd3yJcq5y1bti3lOymPbItOGSFnbW4cQ+83j
         aN/h+m27OlWYK7j1UIZqcv48cgb32wk5njcNBtYGv6vsk7OcO7224m0swB4HDedFn82x
         ymx/PLGJsJfdtoNpdXSj2XqHxF/B7MOgn4vArK7Y+eskblAGhqOz2UN1WCtA2/12px1b
         lo6OpfZaic5b3isdjN9Nl2g1mSa+sun4BmmwJ3J5gUYPqF0MWyy3bylYcVc3WaHjbZ9W
         U8qoEGj9RqG5pV6AJLmylMRfHKbTqk0wD5WJ0G5rAxMcoV6jmqzld5MTzE+9ZIDrOEAq
         IBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVY6PfjG5Mp5l1wDtrofkr8hXdAnDXxHWLxq6N0ZQHvTNRFnty3TIXIeOIo/0iEPOQ6DbqoPN7NXN86axUBfUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGkgzIFIEAr3d/45h6kRsyNF5DUWB2qxT4vhlsIKuRIhLaBTp
	JFLXCTNh2lf5Wn94LmwbGEq19hD2RD9fYPEya3tDmmgLZifjQ8GnEXm7
X-Gm-Gg: AZuq6aKMj91Wt/atjQK5S9Frw3DSjYKO4rp3BA7zroHXMHKmU6YXin1TXFR+ooXB62d
	H3HIdEoClNjWipGaVMFjvbNNvibCFN66JzUmUGwXOdOU4nyr+uZ1iT2OrjiEZ30t0csLt0up6Ei
	0O5ku/9D4FNBGSV7lph8lr4drZzut1h3mokalwAov0L0ktkVnAUdxugWsIZUy1i2ERIIEntkQx/
	p+CRa0G0vp+h+sfgjQGMG1GLs495lsngyEv/B/cIkiS4dkMs6zdYkTgYgWhkgL4LSHjLd23kDum
	DBGmmFPF5xVVg2dudaAJy10ujuByFT1QbWkKqo8hkwmESWvzXDhC8iBlFgB/RwuLVcBX+czw2v5
	yO+20RD3z5VUgGrTzWt964ZbjlRMhXOO0B3jEtuor7Q7yNwucYvMNlea/rXcwZGPdP3OfrAII7Z
	2W2QfCNe/swbkHKc4USQeWN9qnp1761fiJ7C6i7g9ZOvY5rmdyQFvCmWI8TqJhEqgstewB8qYF6
	DQuZfg1yuv7+3+yXwo+ZsQvlVbvitwDy1NeHgcmQlBMHiTcE1QL7DuiRsBoRQ==
X-Received: by 2002:a05:600c:3e8d:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-483a95f89b5mr183528345e9.30.1771942533151;
        Tue, 24 Feb 2026 06:15:33 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b890a3dbsm27223155e9.6.2026.02.24.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:15:32 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 24 Feb 2026 14:15:30 +0000
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] lib: fix memparse() to handle overflow
Message-ID: <pwycaqzyfpan3eglq6hwx4esyfm2w2buvvaqtcqw3aco5y3trq@2ft2ajxaqobu>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
 <20260212164413.889625-3-dmantipov@yandex.ru>
 <umfxjjw2iukw5knj5xn5lxtkr2keorq3sws2mnegmw3zr64bmg@77v4cqwi2fay>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <umfxjjw2iukw5knj5xn5lxtkr2keorq3sws2mnegmw3zr64bmg@77v4cqwi2fay>

On 26/02/24 12:32PM, Rodrigo Alencar wrote:
> On 26/02/12 07:44PM, Dmitry Antipov wrote:
> > Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> > capable to handle overflow, adjust 'memparse()' to handle overflow
> > (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> > use 'check_shl_overflow()' to catch an overflow possibly caused
> > by processing size suffix and denote it with ULLONG_MAX as well.
> 
> is returning ULLONG_MAX the proper way to indicate overflow with
> simple_strtoull()?
> 
> ...
> 
> >  unsigned long long memparse(const char *ptr, char **retptr)
> >  {
> >  	char *endptr;	/* local pointer to end of parsed string */
> > -
> >  	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);
> 
> ... or a new wrapper for _parse_integer_limit() is needed?
> 
> I am interested on having _parse_integer_limit() overflow check
> exposed to kernel modules.
> ...

I could propose the exposure of simple_strntoull() which is private
to lib/vsprintf.c, slightly changing its prototype:

* from:
unsigned long long simple_strntoull(const char *startp,
				    char **endp,
				    unsigned int base,
				    size_t max_chars)
* to:
int simple_strntoull(const char *startp,
		     char **endp,
		     unsigned long long *result,
		     unsigned int base,
		     size_t max_chars)

That would allow to tackle the FIXME tag. I suppose it is there
because the overflow flag is being ignored, so the returned integer
can be set to -ERANGE or -EOVERFLOW when overflow happens.

-- 
Kind regards,

Rodrigo Alencar
