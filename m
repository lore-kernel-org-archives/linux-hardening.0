Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41454763
	for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016157; cv=none; b=ctHRj2D+On4vm1bHmFzEb3Q6umfHNz8PIdQuq6HNcFsDWW9VAeZ3wnZfbCLC3UwXkhKMG9VLbOytB8QIKREvib2YFhrCygc6ulGpp8hWFl0ultKCq7SJMr6lryNhrkeI9arE88e3xvgBzBXZY3PPBBCOgqfHZffSkyaT28oBC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016157; c=relaxed/simple;
	bh=wDgcirggJduBcVdRsft7PykNXrKztvJ+7d8v88xJsoc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBXJ5F+WE5Wgz7Yb8LTj1nDgFa1EJDrMcpMecxYWazJ5eJrAKtHthQm4yqasKh2UdTDfOOt2YLQKmVIjD7VGvBgf0iluQZJnyCbXKUV1HJ94ZJ9ssKK5Nbekyq4o7HEYA25dVUPkBSWhHWdJbHV5YyUGEfxkwTkWDyY7YR9fepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOLd6VB6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOLd6VB6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so92247815e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777016155; x=1777620955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o7ZPgK+KU82N6aJZP72mCPOuaPHic03cUfPsM2xL1A=;
        b=cOLd6VB6ZrbG0bDWdLWwbBehZiOi8Z1uPvgzo8dMz14WINH2iKKGA291sNLlIsjxWF
         VvRogTcwHflCsnbGKYy5QvE48D9H6sufRPlOHi5Kl3wIWW1fiwejVIGRV32aC58pySlm
         qfboBujzyP8yucqLRB3MkY7/eQCl3pcRzSJxpMPcLYMpRRHxpwr3EZxHZZHf39qGPQSF
         POp424KwlMib8NTmgZFTgoWKXMWNT/cg0tIVNnVJChSM4Szp2VKcf0OKuPgKeTvH3oJz
         tqP/0zarMpqkV5/FYF+QYGb+huqU0udwVX/ze4tgTXONYn+5Ucci5Pj9j5k3CX70BrGR
         bs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777016155; x=1777620955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o7ZPgK+KU82N6aJZP72mCPOuaPHic03cUfPsM2xL1A=;
        b=Wtyr5igXVUwdtrPdSqXUsS8uuaKKP2GZ2bbIj9XY5rpOtvRjGqAGD8NLe+FVXA8nzN
         4rkX5ms18xnAZcXWzp3aQFgC8tpv8zHqyox3I7vWxYPbMDq13GmgiWLjOw1OsRS73eDz
         T+ToIoTQcDzOU0hMwSEQFtZbvn8chGXngXwMmAw7Oxo600kQAvjntdheIHbbYxpbfCnu
         8fw9qKDqMXpWrNRSne0iM5u6QMya7c1sLf0WunBb8lYCG3ZltvSxZ7jG2CG1oUKJiwjg
         AXzKy346/dogJdGhsTZ+bSxHl45+fBhqb1U4HeydKeTSCzAGG3OMagtw+KkqYGZRSS92
         Hr9w==
X-Forwarded-Encrypted: i=1; AFNElJ/tcqJ+uNRufX0VGjwXG+1uS6C4eJE+APq9AjyTwAnAzsZe0F/+qOjBOGJHgUdGQMFrygJkkb7BgK7fYkY7UyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXXTuG5oFLgmiF3uP8uK7BQpf763f5NKLFKlbDpF5YFVHS7Xd
	U9JB0O9IBlRYN5lETGRkTnOVASP0HZdPL++mSVgLSypt/rMQZMJIgywc
X-Gm-Gg: AeBDievaPQXUF26noYhEJvd4OuoQMJMGzskWtX218GNXfuZDe2DP1s4lvgGB8Q0Ff94
	m0ey8meJ1WsG5JxXNnWbI5Otjm1ud9hr8YOTXG71IcxKDrf0LxvAGYqxlWX1HEha4KpVe43uArd
	YD5p/fMCP4D+UzOq7BUoaGeg8t9OX+yzwJs/h3RSYY0ZWcKrEbOiWhlX+S1puWEItVrBKw6A5bw
	wOxm3eV0nZ7uivTI8mw8AINAobCSCuux15g4fivMjWZnWhkHC+1XiqM/ASU4lDjGpYgOEkdw+S+
	R5mGQA6pmHZ+LFFXNejRaBm8D7yNzi1wn6Oc1j4ckZq6TtRTOOEREILVfcyaoShPYha7mPt38+l
	Tv8e2wkAnviOqrpz+8AU6sH1VvADUBVIXKkWce3hxnUET6bUulGBq08Hgq8Lpm/6PFb5x4HRwwm
	pHqV2ItZu7y33mpwDJXUNaF0cOxibJiQSI6du9k6PUBWrJC//e3JyclltFmK+Q8WKPiiDSYbIJq
	MOzQu7I9H0S1/eXwARizo6qAIZKcawGbYNBK/+fh6y+f6rUAY0APAzFM8mV/g==
X-Received: by 2002:a05:6000:2284:b0:43b:42af:75e with SMTP id ffacd0b85a97d-43fe3e23abbmr47806405f8f.44.1777016154793;
        Fri, 24 Apr 2026 00:35:54 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm59625994f8f.3.2026.04.24.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:35:54 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 08:35:51 +0100
To: Conor Dooley <conor@kernel.org>, rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/22] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Message-ID: <p76mchyeawpgqghojx6ww4yrw3fxxv7u32clkn4wwa7hzb3yx4@52ivn6p5hxu2>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>
 <20260423-revenue-sensation-c62f759e457a@spud>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-revenue-sensation-c62f759e457a@spud>

On 26/04/23 06:32PM, Conor Dooley wrote:
> On Wed, Apr 22, 2026 at 03:45:40PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> > property is deprecated. Certain devices require vref-supply to be
> 
> Why is it deprecated? Is the naming incorrect?

Yes, vcc does not exist. It is also misleading as it may sound as the input
power supply, but in fact it is being used a voltage reference for the DAC output,
which has a proper name, vref.
 
> > available once an internal reference voltage is absent. Still, this patch
> > does not add those as 'required' so that the ABI is not broken.

...

> > +  vref-supply:
> > +    description:
> > +      Reference voltage supply. If not supplied the internal reference is used.
> > +
> >    vcc-supply:
> > -    description: If not supplied the internal reference is used.
> > +    deprecated: true
> > +    description: Use vref-supply instead.

-- 
Kind regards,

Rodrigo Alencar
