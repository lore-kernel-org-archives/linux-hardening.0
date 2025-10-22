Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A46347FC1
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140049; cv=none; b=MzpaeIGiasjH6f8qtOEDvPY8DIAv8hH2nsxTIJyHiXdmPvk+Mm4inxY7pDRqSyqp9Xy/FOpBYYvciPt6HW3R3h65cwcT4L1m6vP2gj5pwPO4TQK5Skzxr+QhqCRC4DtGr6wGdD50AaomGYydfc4DImn5uM03VDgAyIslSSHO8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140049; c=relaxed/simple;
	bh=gWtnyZCMZ79lGvtHTyeCn/sxtckldijN3FKie7XpzK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKgbLI1w79ss/+0/gBTEimd8kcgL1GHORDFDdEOz2Hihd7ZPGmnNtugFcCSfl2xK52PrupbCZ5f6wrB442t7sAemgPs56ih9wKxICfQpNy0lLJ7Yvz+QtKliHS75Oq18MI2pAfK4m9QlCETPoTf4F1XO1kPDEd5rFhOzBHvI1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDVnjz5j; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDVnjz5j"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1357919666b.3
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140046; x=1761744846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnDab3MvBR9d06ZmEVci9R2LEo8WZZltTef4oKgMrxE=;
        b=CDVnjz5jqOsaNOGf/xUBqTdky530gFLOTueh497tFpB3jkwYJP28o/3s45BjwsT3qr
         lxtZZfaUu9NuRQXrZQus0kZ+fVkvLKEZlTTPAjnn8L1AK83eyuMn7Wafr0Zx2aPo2m7B
         fOksJ515XZEh3M9ikP0Zi6ABQa5qKlirVffuN9zigqowVSbr8nMHixoqdkvTuY6pM1iV
         fQGnCgY4EBxF4s+0B7aI6fKEQq3+tw0kG1+xMoUyanJoZ+Fu6ARAN4wIWfTxh39VwOFr
         Wx5ZbOHMR6GU5w6ATE1Pq8Wi+CVOQETUwWCPGLKBJ6FEJg3fmGgB3Tv6eWF5BzUXgSL9
         dcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140046; x=1761744846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnDab3MvBR9d06ZmEVci9R2LEo8WZZltTef4oKgMrxE=;
        b=fhQq0YnSmtQ+K9tv9RPUTbS0fKPDezLEd+1dA8dGCKUnSpIlGqZsgxCdTJiPzSjpgE
         NmkipMCL1xtNtH9BMVZrDFwzE+Z6GjNetccd8PwCy3pvx40Jx2UG8Y9varULN1dHTtsj
         mVcMkdDxDhfbkqL/N5CLXh/NzCiPCUtJDSS4afAsrD0eWMWWBcbGXPqR/7y25CcLNVe/
         c86oM9atT2qA/ihtfLXpZ0wZE5xN9seDBk1qGaOCB25LlwfhJyc+TS6xHyLd/bCfhFoW
         p4Gfza0N5lYw4gwPQ4BBPJvD+o0GDtVap2kj667Y5M4AKG7zrVjHG+mp0dM09YdibGMZ
         13Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXfkNygNoy2VibwMZgrp4r/kyPhlLiJw1dvKNqczLJR7/muSNHTCfxmRgcr4WOTLMTr9JnvS/C7ZOneFdrscig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OGwRjzqY4h88WxvpMfTh9aS+khALzPtNo2QRj+2ggoktkxCu
	F2zz/sS58aN+d5oBCQ5VQtlj1tGT7mhEAJgWDLZstjknGza34QdNNNcLNZ82UrnUGLFCG1xMWnD
	IjaWl9w/UwZVZTi5HC0xeYbBQtcriEg4=
X-Gm-Gg: ASbGncviSswwYwl6g5tb2QbpuIzbHa1rsavGvhJHujtScruqaaMFD46OhlqjJySig4g
	54fvZmZx1Xsbrj9QGrOixEJ4zDMNjylvh4FAgtL3JNzl5kuHJIdowAWnSBe1+Ab74wx0KYQDM+Q
	R7uf7qvGe8NDUFNSdaISUMSVldwbJ+5QOW0rSOcOuz4T6jUE2PQ25RnphZU4KuF//V79GRRM3O9
	QX3G0ROMxRuIkiNRdjLW+5Jgr4lzgFl966q8nmMxIpTlMl8HOZ9ngPdMnVMkNilL/ILPmZl
X-Google-Smtp-Source: AGHT+IF+bGnEQc856DkdZpIAOaRV7nKVJQZfv8gn2VCNIJnjHmyCsahfWQqIidtzCF/ZoRQsNWSOtm7llM7J7h8TBP8=
X-Received: by 2002:a17:906:7314:b0:b45:420c:81c0 with SMTP id
 a640c23a62f3a-b6474b36a46mr2340985466b.36.1761140045360; Wed, 22 Oct 2025
 06:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 16:33:29 +0300
X-Gm-Features: AS18NWD8eeQXjXIPK4eXDVlSVPojwJxWfrcwXD-jC0yt5VNiNWjvrq9EAmjuWt4
Message-ID: <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> Implement a function for checking if a string ends with a different
> string and add its kunit test cases.

...

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -562,4 +562,6 @@ static inline bool strstarts(const char *str, const c=
har *prefix)
>         return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
>  }
>
> +bool strends(const char *str, const char *suffix);

Why not static inline as strstarts()?

--=20
With Best Regards,
Andy Shevchenko
