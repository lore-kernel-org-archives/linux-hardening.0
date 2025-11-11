Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA12E54D7
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858011; cv=none; b=GJFEsNrwQ4scDJSZoKKWutPbTFYRQ57e8s/DC6cKC1ux10VdGMHKZVm6m1xXhtjnyd3R/YJ5ARAU48RbgHDoe5tFZa+AA99z2PiM8JZC8VFknCzeXWq4iQq8Y9saEfB9SIB7rmLlUEKlolpGKZBCBVIeegK4B5HhFe4U9n6bcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858011; c=relaxed/simple;
	bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfyRUOD5wCt+JQf//YoYUcTRZYxWFSyN1wi9CDV9ck6ndS7h/Rzi4eN3X/Jg5JGK2Ar1ISmJMmZ4StoDvJk2/kA6jKaBB+KOiXMcM1ABe68pNkIzIwDv8jYgyIVcgS+PLo916abGPkZ4C54vbt6jJ+hUQvEKF3VrmsND6aggdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCzix8om; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCzix8om"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5930f751531so3758637e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762858008; x=1763462808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
        b=zCzix8ommVmBggohX2nU+Nx+FqVGx4/zUmmK+OjaJhvAI3brORS7qwNax8HvXSpXh8
         CcJa2oGucKwgAfdrStMagzvTnzRg7Bv65JgpYOlGqq4MObFK+/GMg4fEFgp2K8zCGhlo
         DWMiqIcU9N0+bL0z8Ft3BUIe1kSxP1tqyQD4Y3BHzWK89xnN9Fv14T/eU9BqR/EGOB6l
         HyUfRQHjhARMcL/wJNAimVU6ufIpLIyk35vSx3x6liplpDrfUXuklPWOcfdqusBZN4Q4
         b2tLhUe5Aw93PhHJN6fET/FppHDUWA8owqFT4k0oURldYsDci3275Vya8GOz8t+zI+wc
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858008; x=1763462808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vzxu8qssjIhFl+4HzQqYw3E2J9WYZzlt8qmmQpR/9RM=;
        b=PnNSBLZXIk9yp2g8mXYpRPeVzEwnHbqqsCFNxhka0ia6Kjd7GKFO/RORtA4Yqp93i6
         XcV8r+JIs0XG+iJBxfxdIvp5gUBNLYCCCfBlsW7EySENzEXH9+8tJlD5nXxl4slpUxY1
         oVI4MRjDzcyCuAqeFOxsfJ6j9Ry4lNRFpMEvSdg7EqZSjlp3sJHRE5K9cacyOpdP9Zgj
         w9UdArjPa7pK7NIS15EZjNF5YYUpiQ/vZOW9DVahuUhF/TywMa+b+eBVbofOSIube4T9
         eTGdsTWDbNulCEGX/GEb62lTrW2d8cgAmdK5FIgVq2wR0JFt8/xgy2aYIGXCx5Lr1Oxv
         QhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd2/2ZdYeSbwQkdgW4wPLHnUxmamDzhWhwtZRxSo1iLnUtrgKCmD7hjiv8u0TTJX4CGG+6Nl+b+laMjsiJr8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqALQAxKUm66f9WHuSIpmVQLg4vEmbWvCGdvrBNZVXBFLRzmf
	phGU4A3DtRRqyK0YdtiUt4dW2AgTRVhe3KbSW/arx73yPp83SPlPQOr3l/pCWJkNV4990V1sH5A
	C3vVSErInvXa5VUIZEDAgyPrvrtZsJM5NaUMZzqOkj5iqiFdO+6D/sGU=
X-Gm-Gg: ASbGncvMc7WWC2+caoCGIRiFTW9K9iNz6CkpwGdISA+FjKZan2cRdlNo4VkiE6YKsKL
	GKtVaRmnvDbRR8S0hFlzsBMTVakG9pFZsBkSmdmmR1x3CkgjJ8vW3YV8ilBL2ENa9ZBRHfki9+b
	L6sanFZx+wBe/fdg1SEZUWTHVeaqQnWmJ5i6VfO6GEzQpXi5SFa972UmvtOAyizlvHMIDF6iyxV
	moYTbFzP5WCVdd1s2crElsy5a0T+JKzSSvtE5fP4tNIYUj2XsqPwvrGcuEt
X-Google-Smtp-Source: AGHT+IE/zC5OMsYl03Nj0mPJmaD1a2IXwBvVIbEcz3pKu9CsBoN95WeMpa65Ti7xOQGESKhkoy/5byt8ZxIuQV5LRlc=
X-Received: by 2002:a05:6512:3ba6:b0:57b:5794:ccd9 with SMTP id
 2adb3069b0e04-5945f1465b9mr3570547e87.9.1762858007876; Tue, 11 Nov 2025
 02:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <CAMRc=Md4X-GWpeRgun6zv6dddKFqqrjUSveq3fNOe5AboLAcXg@mail.gmail.com>
In-Reply-To: <CAMRc=Md4X-GWpeRgun6zv6dddKFqqrjUSveq3fNOe5AboLAcXg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:46:33 +0100
X-Gm-Features: AWmQ_bmu8Uv97qyqiqkPQLTOzsrjTmZVCm9AYfJGSsxfxSYvRIGYvQTliDsDKgo
Message-ID: <CACRpkdYBZQJsptXhxOHvFdNwU5_-_QDfaLN6tiDqgL=bBWoXmQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpio: improve support for shared GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> Can I get some Reviewed-bys under the GPIO patches if there are no
> other open issues? I would like for this to start making its way
> upstream if there are no strong objections to the concept. After a
> release or two, I'd like to start enabling it on more platforms.

I'm convinced of the soundness of the general approach so I have
added R-B on the gpiolib patches, FWIW, for the rest:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

You clearly have an idea and a plan here, and it looks solid to me.

Yours,
Linus Walleij
