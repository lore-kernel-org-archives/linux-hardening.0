Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387922E285C
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905652; cv=none; b=OcqOEalmq/QfPXeOsGoxCA1C8UwPAk7vjQFuCKf8Ie4EMYYp6ZcfMn/J/9tYiaKxNtqIzY6PIh4rRYSlsemZXRgEqQu/LdA0cPZt0zQNQNiMQItTEFEiY+ktQIZJCcHpxgbqgQLARj7Ch5egMoKK63pmLmzRicGoRkgUVYgilqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905652; c=relaxed/simple;
	bh=xxGSfNEhIKCN3A5hPhCPaCefZunVyRLNKNOdvFsKOV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ndMmnIkly3hNGpKPwBV1Bs/pMIXfbQCbA/LvOGcgL5CgYFY4B1ZE0/ZlyzMvkFS/tLmYBt0CWxVAemS3OPRycLbuk1Y7qKsgpBD6X1hNT98YHN5c0habg9KqaTRmk22QrzvgnYcjGZ6p/4O8SkpiYTHbj7WLY7SERwOLYi+ztvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1V29NqNJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1V29NqNJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso2263898b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774905650; x=1775510450; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFHVzUWvS3ADraojc1oAhG0Cf/0/o+VUJl7DBlABpGk=;
        b=1V29NqNJSgkLIRK/b7H1d392zMhCjUecWDnnJZEyvfCX7Bp8bdWElLpeXyVTlL9Gm8
         19mPbKECJ+WTjIAGczfofTS812wGE5v/sj6BB6mqRXptSyoNVL3M/SqKMkoOf3HFK75A
         fmK3MNUD9g20ELjJ/NSxdnvuxzxfaLf/JZCOLjZ3LGWwCgABPNwDQGMH1/ncGtEifBy7
         VIMfWKI++E5Lagi9jh2TcrWtJtYse6yv03KdLBRwUeotGWPxqz/SgHlbnP1BCzenS7Xm
         +wW6HwKaDOFgAVVfyamWPeUg32Xt2xU2H+51I2zh73HauNvKSlK7sxm4+/UeRRspZAmq
         O5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905650; x=1775510450;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFHVzUWvS3ADraojc1oAhG0Cf/0/o+VUJl7DBlABpGk=;
        b=mVGBDaYPXfngSsXQabS6PWag50H7bdIwTlwPopVKcKH46fFf+Vn/yLAnRGdKhpODRa
         w+6nmbTCkMo2f3DVdk0CMhaKoNB1zKz6+qcbYqAJERKl1dNfUdN4nlXzJJLUw9E84jLV
         RamYve5p3dL3ULEpP2cJ2Hr5HSoHrDpforKvnSMdAsN2NgGo+4y1AdW4Q+ZqmnwMdyGR
         tUMJFFSJXJB3hmoOw6jF7J0IxImbYnplkkHJ48BG26nlJ87IHp6lGRx8FexaflMjlzA4
         EZ8SQ+7oehE0YphL+Q18j9reC01vo8hmAoWcK69ODFpKkjIfr2neAtcOWAUlhHcFAn4h
         Hrxw==
X-Forwarded-Encrypted: i=1; AJvYcCWGReeGxL0XKkeDez/OBn7vpDuHgbn7yJQc9iL+Gr2qgKyDDwtfyYQJu2l2s2k/KFqH44KxF/sZ+GtGXacxjr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7KZP5epm4Dj01bupnQUVUFI5itVbLaSoyMpRFOjABuykSGjn
	d7x6FjCTBmjkd2uDRhk2UpdDjaEaAUW+msM0/ibHnoRlHEt+s70JJ1WJwNOotEoQQKU=
X-Gm-Gg: ATEYQzw18gfs+7bB0vhVgBAWOJTKjNxosfV6i0HgAeLSVGG1l218SedTTSUv/+bpVb6
	ltlo2+HTPWNzlFLzIVlA96q3ze/GcLqFd7sLphxiKYVSo3ehBMY1CgTeFZiA4o7dpiZENvBPzC9
	eFaXYKgEpuW1wqFypEniHLcTbi5D6UqzN6TIHWrvclOkjqL/6X3vnqkR3WIH0/zliaNnv/GAZG2
	WPdcIC4VDgekDsO55GrbubOYo+tj+ajtNPB2+kuEkhtUtzvcdi6t9DC+UN4w4Sz6AJWjuf08gTg
	4xjrJ4LQ3ArQjAEjmZ38sGnXsU7JWgvX1R18BVTCkQC3w9NRU8xDuBwfTdU4dcwUfRAJ8Yo99zj
	TGPzxVRIGzc8L/Xyk+VIHkyr2gBj9/j6jXvzf0InKs40RgT2upqwA1g7VHeRjsKtLhAW/CY4uwJ
	uik5/rs519ksk+OIDyo6Q=
X-Received: by 2002:a05:6a00:23d2:b0:827:3093:901b with SMTP id d2e1a72fcca58-82c960961d8mr12314711b3a.43.1774905650561;
        Mon, 30 Mar 2026 14:20:50 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d030asm9550520b3a.38.2026.03.30.14.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:20:50 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rosen Penev <rosenp@gmail.com>, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM SUB-ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered
 by other areas):Keyword:b__counted_by(_le|_be)?b"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] ARM: omap2: simplify allocation for omap_device
In-Reply-To: <20260327191104.206512-1-rosenp@gmail.com>
References: <20260327191104.206512-1-rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:20:49 -0700
Message-ID: <7hwlytui8e.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Use a flexible array member to combine allocations.
>
> Add __counted_by for extra runtime analysis.
>
> Remove goto paths as they are not really needed anymore.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Could you please add a bit more explanation about the *why* behind this
patch.  Your description tells us *what* you are doing, but is a bit
light on the *why*.

Thanks,

Kevin
