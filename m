Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD119ADA4
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808882; cv=none; b=mOBrmeIe+IPg6gR+r8UlKTG7sRrau4yw6fiBaQ08VE7lZ86IkMHbetNcuzAV8Yqfay/1yLQ9cwS4P+SJGA29NusQPD0KK2bM5JJRuU4rI1ajjcmHB5Vn7o5Zy81YMcGg9I5rtefJiNO3AM+t34gk5YOhlSP6wsrEjnnT4hFfKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808882; c=relaxed/simple;
	bh=bQuIknwUAnLHPnKnNOKK5q/bQvPCDO39GmpJAik2LyE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/RI0uOxNEcUjl1xGohIWk3TI7oHzbGRC00BCieTBrqGKu6ZZdGoO1XF+XjhsDHO/DJLjF0nZC1dx+V+auYxBeY+02FrNDHS4SUFpu+beSXsu1xnYWgJ4wwrgfKHEvlCPT/k5kc7F6o74E5vg4a8RByRnDRf+JxBB0EXxH0O9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjLsIKbu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjLsIKbu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44509921fbcso6870903f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779808879; x=1780413679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xp8ClnbyHhWUm1Sal94B2cp4j1rAGYr4sDBJeF678B0=;
        b=UjLsIKbuiNhOuI8YsJwUBha/Vf4P6nR/kIKxBRn46odWyB7wSc0HPg3gn0ZbN1Uw+o
         PrAaeIXjfB0ekGvpBV+znTSnbI8Kt1b7pOJX+kZIMODbRYWk5MfzCLdhw0bPD6baOL0P
         gNA8aBei66XdSFrGfj0w/ZsGzOFwP/oAI0Qm2NdApNmzNfpPVeoMr9inpUim0eqUTClY
         ogyg6z445VESOlMp+4PSpXqE2tw5pcM1Y8qeUiYmD9BViRVdA5JPnbD6s4vznpmUQ38i
         BcUx4Bpx34TraktP7gyhFLiv+FOtd7/qgid/A7Jlbj7u+/wq3zVMAV/2tNq+mZt5wocB
         /yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808879; x=1780413679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp8ClnbyHhWUm1Sal94B2cp4j1rAGYr4sDBJeF678B0=;
        b=bkxAmt4MuQnOBLwvl+fevIr0ycRmmdlSigV+q56TpYUZ3CV6iIRtBF2uvlBJr5yC4u
         qTqKxYAgb63X+o03jNvY9Dhum9UyRDeQDy+AZduGX5/mvHpoed4qqV7wOn8S+uO2OEL2
         K6pBUyoqZNIT9tQ87eHz5X3QeZFp5UWZeiRzF2IZHiElFcr4XJtuY8B3gLM9mq/9HgEj
         4izAX/h0LlpmqVzKfDrO7tWwReRqn9WcuUdKZH7ljakKWh6su5RjMVzf+qmG1n7J0Ldv
         8Ualw4s570HysT9nRaqZxyHIq51j97CGnI75wE7yfILJma/GApGH159Pw4SLwS7uwVED
         Vhvg==
X-Forwarded-Encrypted: i=1; AFNElJ9LYLA/yHeDmoYBR2mFCjruQLvk+q8WpE22hmsPxZ7cZt7vSSfdfNkXI9UTgmOP8i360M5J5yxSUhD38Bnb5xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+X6lOmhz/efmTvneUN8JjlpRV0uVqsqvZCsXPy0JGqs6+SP+
	pqfdGo2DrFkTZkkJq+nXpCgBc3U+5ytgLL0LlWDaZ4EM+i2b5XIbW1gp
X-Gm-Gg: Acq92OEqKZdfgUGfYUOMqz8YvJ4kMJzyOiE6E/5EWJCbfpASMyBFCrxNAqnUTOdrJzG
	S2DWD6nCnMFqiIZlYR0eaRe9Y8ChHKV9vvya+tvpE9ToeytL54/ZkZlPzgIVd9L9PPRWqonQner
	UOkFtzbG+q7TXY3igDZLKaTpbZB99wJ6KXHldK4m84M50klYYztrLtHoDlqIKMUtEfyac1rjwn5
	C5MBabp8Mr0tgpQxkqlUkDzSamH7nV1tB+g2YVGFPbZuaCKyWldzPrI5fwmgZTk9l1lqJmCUpkZ
	R/I9S0eTHoqxKrEyiu6/BiCIIuF6KU4/ELpz6+42vuCFm+LQjbJmUCLMlSaYrCnc+o0KnI4j5tj
	rBPajj8qnc6+ggAx97IvTLLfDIDoVsBywCsJL+6zZIr1GPqHgwdVbVDidsaB2vfFJRlS32ZdlXe
	zYRLv8RNm5kzuu6+7+zJXFgzIwMsaB1l5Wvu+UfBgz+pV/KdZCUlGHEuo7oSntRaB+PxCKV+v0i
	zMi2OcRjlibVNyJ4ivcPEm9u+BzqoKE9Qy4AlUloPBfZwyjgQ==
X-Received: by 2002:a05:6000:1ac7:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-45eb36890ccmr33778656f8f.19.1779808879251;
        Tue, 26 May 2026 08:21:19 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm39351825f8f.27.2026.05.26.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:21:17 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 26 May 2026 16:21:15 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 11/13] iio: frequency: ad9910: show channel priority
 in debugfs
Message-ID: <fuitiyrpt5calptts43egdyggz6xa7xl5racf74pogpextfrrr@mavfidgywg4o>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-11-31599c88314a@analog.com>
 <20260522190746.4c802584@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522190746.4c802584@jic23-huawei>

On 26/05/22 07:07PM, Jonathan Cameron wrote:
> On Sun, 17 May 2026 19:37:55 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Expose frequency_source, phase_source and amplitude_source attributes in
> > debugfs. Those indicate from which channel the specific DDS parameter is
> > being sourced by returning its label. The implementation follows the
> > priority table found in the datasheet.
> > 
> 
> Examples here would be good.
> 
> I guess maybe this suffers the same label problem as the parent stuff.
> Same solution?

I suppose that labels here a more informative. Otherwise, we would have to
expose the interface that outputs the channel prefix to the drivers.
 
-- 
Kind regards,

Rodrigo Alencar
