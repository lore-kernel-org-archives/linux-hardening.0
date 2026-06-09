Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9637D133
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043483; cv=none; b=rShquBu17Pub6vpJrDEoh0h9LIr41GUvHeCyqp6LC9f6AGeyppAiA0wxkyltiFi0SXk1FS3SMcKSwMUz9w5fQTY8lDD4/xpvj/iJfmutOQdDwH3QforaIAX2NY6GrlE+ThyWpJ5umKVnBZCin9P9EgWihyOt+lz7WtyOstL7k2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043483; c=relaxed/simple;
	bh=bp9vN6jZ1qqJXo57oXyDMe2yeBIZWtXZAexmNXD2P/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAbScSs+r4vlvhrPHwgwquVfx0EaHIHPhbPoNlD5AJ6CIPVRWQapw6C+D2D/1ZKqlkP5OLmiSIzkEPBRN7gVeUecS253WXBlfhGIQf2nx7yamWa3QpmaO/JirfJB6yBX5pz5fE1f7mzOvnHF7y9Iuk11hKlfpP8Tezsk+q4R/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyR1GQUN; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyR1GQUN"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48657fc84a3so5515902b6e.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043482; x=1781648282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPAKqbhj+nb7blUntMtn89PVQtI2/C9ilf8/hnaPy4w=;
        b=ZyR1GQUNLbFPjXGNhgB7g5qHx9yztNjCUjWZScN1XU/RBw3DiSA3sq6RA8bRe3TC3V
         IvELDWIEMh9KjXA1n/uw6PkzB7hOzDZWWp6vp8mxaPKdlwFh93eIQXHbMv0ao2emwguU
         ySnwoNNzLN0CDZiFTpA3BE414plH4sE6O0EJB2EC8ACbTjlCdu/qiZ43n2CjVj8ZPvGH
         fccDuWbjxLAfS16cuO7/kPRL+DW0wUM1G5zDcvUYgazMHxLefqIoJTtirNYT9hYM8bNN
         zxccNn8AQH7Vf0HzCpvZXGbDBdx/wIMiOLc8V8pki3haI1t/ccAO6gLMx/7OENJz3BF6
         gQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043482; x=1781648282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPAKqbhj+nb7blUntMtn89PVQtI2/C9ilf8/hnaPy4w=;
        b=TdePfpMXRJH3/r7tKJi/Vmybgw+Vf4u3OxSTV6oqM5m7xNS7ZM1cR4I/JENFT0xJOJ
         fVo1y4kZSGSn4nIkCPIwPWdsSj1BCsrxqu0shTX/ObG+iVifzuZ1oVy5Dn4tMOBcxrHN
         2YyoJBUA8rUh10rFe97+Vk0yiJOYiu9oJdHeuSloBYlqYWwQFqP0KSb+rwQDZfOieQN0
         G/va+3whRVqI35/nMJEAEPT9v+T4k1N47l/oB7OY1Ae+C2+TS+KV6Abh1Op9ZRrTe2MC
         k9/j57IjccMKKPEP7O4108w+tveDNdfZCd17+3LSGzDWzrgJ9iX1Hfy6wT13saEBnAyt
         Ts2w==
X-Forwarded-Encrypted: i=1; AFNElJ8zoCrI4F9qyhyTvGD3S2PCaUjXbdntN92NumtzQjJxJOhIxNwyLpiz/2qLF19tmUCDQ7CkIDYZhTwzh0dyROQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEpuQS7+NXv1xlGb9CO+E7g7HJKSInO4TiZ0xUH4ys2Du4X1W
	TmECVNHZ96jptR5KaAE4v1kIfSk9c7yO6a1dpBmJVl+L0Fg+6QdVNWIA
X-Gm-Gg: Acq92OFiARDiD6g5j2rVXjzHBqFG3crPx81RgNKMPDzf0IJnqlY4XXb5uALgcfFqR7W
	dxI3Kc3LCnaAr8ovG+Gwqxp+iyIrExKtqRKdYSGsjPEUzgiDxJpJ70+6ORjdHf+vWUAVekaszTq
	zfwXH486V5bP0GcmvY/TJ7W6lfrbzh2fQVhU7rypxvs1NRv6mkVfHxjo6Uig1b47SzlSIJ0/qva
	WUlGFT4epZSCaagmSCnNptEvKqteEZLitW5UrG590wH/HSzF5m/EeuYYQzR4IQAUi49HqoO/xWw
	LeWF7JmdJvM4Jrif5c905GfgZyZm4JtUXKBbcJC9FvOcm5QUpcGwWIYbOibWAX9Ln7K1ttsXtBF
	U9TJS5Q7UUHDkZIhdyZ3ui9S8NPZdmHnteQtJ6ubLCaENsNHsj5ee6FYHrUKSfLD+xMaDQMnjOZ
	gzXblpEsGK98ojUpZVLj0KNDz9RWf33Pbr3U6yYydrVtNrRGdT4JWpGLYXoUHSvVKVHaw6fnQH/
	Q==
X-Received: by 2002:a05:6808:3510:b0:479:da60:7dcc with SMTP id 5614622812f47-486f0230e20mr3210573b6e.35.1781043481754;
        Tue, 09 Jun 2026 15:18:01 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865ba20b68sm17401625b6e.18.2026.06.09.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:18:01 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:17:58 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use
 guard(mutex)()
Message-ID: <20260609171758.2077ebd5@linuxescape>
In-Reply-To: <20260609171302.5764edb2@linuxescape>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
	<20260609171302.5764edb2@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 17:13:02 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, 09 Jun 2026 11:13:06 +0100
> Rodrigo Alencar via B4 Relay
> <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use guarded mutex lock to facilitate code review when adding new
> > attributes. This will allow for early returns, avoiding error-prone
> > locking and unlocking in error paths. Gain-control support will add
> > the scale attribute.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  drivers/iio/dac/ad5686.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >   
> 
> I agree with Joshua on this, linux/cleanup.h should definitely be
> included. However I don't think sending a v3 is worth the trouble
> (Jonathan may tweak while applying but I wouldn't count on it), so with
> or without:
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> 

Although I will note that it appears that you haven't converted all of
the locks to guard(mutex)(). While its only in two spots you should
probably convert all of them. Either way, patch is obviously correct
(besides IWYU), so I still stand by my rb.

-- 
best regards,
max
