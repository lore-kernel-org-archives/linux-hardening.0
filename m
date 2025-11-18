Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD252F2610
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461950; cv=none; b=GanYWLUraFRTiY1oE5cDI2Kfa2pbTVDNUXR3EK4/vv/011U8T7tDiXrIhRaHN9GgQIGmIOnt4xMA2lRxcREZrcGXbJ5yhfu0ajOt+mfj6+VhsnzkuTUdXzY9lmMi7xjLEQs00yu1dVJRppcpZ5MbfzIqSRsI5qADVhxQiNv1zxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461950; c=relaxed/simple;
	bh=IPyUjLMc+nUsRq1gxtNlMOARHoCuCmNHix3EZBJN35M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcFvnUcC6UJehQJf7+ngS8W5BeNLGuVx9a2TR2idRmbG+C2unHA8LFeABLGwseC3xuVICN0uDmBAs+K+KtTGki+M6iI7smC8Auabpe3jZBae0p2fxxxlA5kTc2dRcECgJuyJDaepN3w7tA7k72hQX702ImRXQqnYYfCWMC0XZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrtqriko; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrtqriko"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b739ef3f739so322961166b.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763461947; x=1764066747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAUXkykOzAD2KpyfJbQ2FrYnbtVUZPGgyTos1mgyJuw=;
        b=Rrtqriko3GoPa2Zy7sHUzNpuaNUPzIifNGrJdAyHXElScVADrVtPfDEbAMb554EA0I
         ovWqwZ90KMbFnyCztOHQCd8WTybYmusEl5NVJgdLStapf97cCIzfqpzB/Ng8njYninXj
         GgPaoNF7oQ6Q9Twz+orlbexiokfRDcuh7E5DT06JdyLADGaYx29pO65qXvYaP7Ml/ew5
         37vkpySpcIp2RwY5u/YMgjcGBjuaQtmrf8lJI8tXQ4vKeEsMgQHUKMUN5JWKi3UxYUa9
         5hRi8fnlzDxwNuMc5dYEfn+HGWtU22ZYhfO+jw9GaaPkq6Ln6Q9sTlWI9a2fuZyYcZjQ
         tm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461947; x=1764066747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAUXkykOzAD2KpyfJbQ2FrYnbtVUZPGgyTos1mgyJuw=;
        b=mnl2o6CDfwnxZ3uFnAyoLntgfnQ7ridddWXdCO84/eGPFxiTwNNhyAliJla87XjAR4
         m+BNSBUqsHWjQFFEBHwulrV1E7r9ekxcHtQaTdDGiAKbgKrMfe3is1CIX+moWcbAyS+l
         RlMPq65ygOM5D8Ce5YMXdwUiEaiKkydRiHXFyxHfXOPrDFxCorxNE8/fvf111bJHIL4N
         SY4b/kvUJ2Qq6KcNadFJmXZ6W5ukpDu5+67UNuVsgK0eZ0j2c9Ji7pE/D2Boqb9W/jEh
         10c0zHgvzo2qO+POOCo8xUzkbRtKjO3K6rf9SIXuEkcr2fFdzbc0wBZsZDRhOoxbKl6z
         kQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUzjDi7n8u/UQ5LAaKwH4wHl+0IVHcoOVC1U8cbMqLvvCCQg82GGPGnQdwUnk6uthOexAoiTS8wj2I9jW6ppoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAd4zZwQcDJ5fo6GVC1Xe6ZceTX59xfW5Qeb/gP3l1JYu26B5
	U88qYA2G8osfsP6qHXG5RYIVAzq4gU23ocXwRoty0taaiQXVYB0P4w70Nre9Bl3RHjovp2/dggZ
	C9CK64nCxukM117SwUOTDnt/slHfQeE8=
X-Gm-Gg: ASbGnctE02cP9xSJO2/Qn32jxqsBGI6COAAT4bVaP2Lj7VYOJBpRE6ZjA83KIWyLSUU
	SUAJonAQ5hxoNWkSY0CiZJHhV0M0COE578+2cuD74/VlRylfDo9Deel0fus4YQFFxARqUnkuYma
	oo16hUlI4W8Dn9+gequ3WfiI/mP6yO/PGS4PwcP38e8KNStXB4CzKyd449V3jbdx/wPHh+tnpWD
	wW0Y8QxSIjsYzzL4IwmNKwwOLe6E/S32hkx5LZOIvw5U10yWoJNOp2XRGhBt5LEfrOfomaKa8l6
	jGCV3NmDojXww6xsJ0/eFDPfgyDZsn3ZeTDJdWMCKGH6UfL9gStfpw/OcCqtQvnaa1jXfew=
X-Google-Smtp-Source: AGHT+IG4fHcX0ZIuccOuFnmydf7q86o10jsPRaXbgM4Jslw3X+UttayBhVv46L1i15DgU4KAnoThbGVvGnt12GxbYxU=
X-Received: by 2002:a17:907:7216:b0:b73:7b5d:e781 with SMTP id
 a640c23a62f3a-b737b5de9d2mr1501280366b.48.1763461947406; Tue, 18 Nov 2025
 02:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
 <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com> <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com>
In-Reply-To: <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 12:31:50 +0200
X-Gm-Features: AWmQ_bn1KZ6cufeIyoEmP0xwKIg9fyNs5eGMmFwbPPgLY2h_tYWMKth_oWrNAew
Message-ID: <CAHp75Vd962ASEjeiJpv_CcQALK=dayzSQRCN3b5Cyp5GmdjdVw@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Tue, Nov 18, 2025 at 11:09=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:

...

> > > A couple follow-up changes to the new strends() string helper. This
> > > needs to go through the GPIO tree as this is where the strends()
> > > currently is.

> > For the
> > strends() I proposed to get rid of strlen() calls by
> >
> >   char *p;
> >
> >   p =3D strrchr(str, suffix[0[);
> >   if (!p)
> >     return false;
> >
> >   return strcmp(p, suffix) =3D=3D 0;
>
> IMO that's a bit less readable. Unless you benchmark it and show it's
> faster than the current version, I'd say: let's keep the current
> implementation.

For the static suffixes the second strlen() becomes a hardcoded value,
and I expect the benchmark will be closer to the variant I propose.
Otherwise it will be definitely faster as the strrchr() implies
partial strlen() and strcmp() is the same or even faster in my case as
here we don't do the additional calculations with the pointers. Do you
really need a benchmark for this?


--=20
With Best Regards,
Andy Shevchenko
