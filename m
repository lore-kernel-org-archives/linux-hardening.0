Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC11E32C6;
	Mon, 21 Oct 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502748; cv=none; b=TZ25Y8Y73q6bkSPR3e27iWUEGTtuOD+JVeYZoZmAP1sfR7cz/UvEtJdtVi1tpSqq22AKIaMgtqyBAWJd4By9oO1SWE/xPvJPw9dIULgKj7fKSpoHaaXBfJVl7aQpOLahUvAE316Gm/JzW/DxVeARaCAReT8WnsAHOmFSgJaL5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502748; c=relaxed/simple;
	bh=oys9EWp0+ZDi6O702j7ITYfHMy36XMdPdEAfHWz8hWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4/0SvGHSKtt3WAlJRCPWgB3m7GC4WJjHhcFT/n6L39WunCY4BjhhK4OiaNTYbT0DZ3IYTwyJEb955ZiJXyn7i+JnI09FZdicpDumSds7/ZuecCQn3927iyc6cyTVSp2FawhhuEyQwXvLr6OHSPLZw3Oi+Em9Irbcv8BILPv2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMAeYRHf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMAeYRHf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso627423366b.3;
        Mon, 21 Oct 2024 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729502744; x=1730107544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oys9EWp0+ZDi6O702j7ITYfHMy36XMdPdEAfHWz8hWs=;
        b=dMAeYRHfcE2p5Y0CydlA7XHaVHSniWNafzWPhGIPqamXZwEIgdoRt6ePHMBFwpMN0H
         2g8XuV3HzhMrvAxXV5nmekHFHEOsk52iPHYuQZMRrj9wzh/tmf1SxGYzU/WKqIriLNK+
         KF52Rrhip1Y3/U7gpXGnMo9+e3kEypNFpFymywfES0aBHN5FXa/E62vR3S9ZuY76Fd7K
         fJJG1dGQPEvHiD/J/Uk2omHxgQie1uNaALRZT+fepvGUJBHu3a8GclHcTkZ4F7dvQ1Mj
         waQ0spcS+cLe9lyxhdWYvIfZq6z9ffBC95YtznBJkd6savPcdZUX8sFS1uVYKCfQyaGn
         LVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502744; x=1730107544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oys9EWp0+ZDi6O702j7ITYfHMy36XMdPdEAfHWz8hWs=;
        b=B198osq82WD3zr1PzjgcOh5hgpybSvdOsPnll8HgOcy4XNHUjJr5hOYw9CyBAXWFx+
         fxS4o5cYGMyazO3WTppZgSZdpv0QFUluMTSyROklQp7Y6ELtjxAeAhxOKk73StmE347W
         thr21jUwMTTY3AjgG5lKUKau63qvr3hfHc2vvZuMnlc1cIC54kb75YpeYsb+rlEM6P5c
         5ZONSm+DPFHVgejeH2d2w9A6sskPI42UtDAiQn4CgV82QLjaf9xvTYNqhBXRq+13Zim7
         TMIIIbUkxO/GYUncLfjTEx+fJY7FEyKWmBrlJkCEyF/qHJvrS4glbw6du9BjSOxPowrI
         9rPA==
X-Forwarded-Encrypted: i=1; AJvYcCU8zXPBCd5QBhoD/NKazvGg0dFxdIvtUEQMgGa3qBO/epZozGi0cnejiqMYMfXxc+HbnrI0wNbwuhxzbA0U@vger.kernel.org, AJvYcCVgFWL1mDk11Y9xv7RI8N9JsJgMpniLZPce10lPlVpOkVgxwkDA3PoL40H7f3jIOvHYof9oWvjWaEI5krR+ZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQESAp+XWyqmHpWZbAyPogErey4z0mFSz9P8sEu2tArEqO/bh
	c70mlHPDyOMfGjt0ROA0fP6a0CJ+kWEauBXco89KRKsTzPizAsVLCIywkFVA3LVWkKutAZIqTMw
	1Ve6GL2+FEAoFOsLmAF9Gu979rCw=
X-Google-Smtp-Source: AGHT+IFm0gLisyhcjjngukS6vY82O8oUsw8+7BEJEc5i6j2uKOeRa+iIFgxIFXU1mwUV53zDxim0xYmh1qovBiBWu8o=
X-Received: by 2002:a17:907:7296:b0:a9a:f84:fefd with SMTP id
 a640c23a62f3a-a9a69bad1admr1212265066b.36.1729502744282; Mon, 21 Oct 2024
 02:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021091417.37796-1-brgl@bgdev.pl>
In-Reply-To: <20241021091417.37796-1-brgl@bgdev.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 21 Oct 2024 12:25:07 +0300
Message-ID: <CAHp75VdOvcfp8ZiONr9viieT9JavvZYMfS+wX8x40JyZuzfyUg@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The output of ".%03u" with the unsigned int in range [0, 4294966295] may
> get truncated if the target buffer is not 12 bytes.

I got the same warning last week, thanks for fixing it!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
