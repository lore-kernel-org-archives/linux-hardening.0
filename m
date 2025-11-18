Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF93314B9
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460576; cv=none; b=J/YzZwcmt85ZXUWnWon9e8nlQo6y0uzX0PBaHsx5OibfYYB/55XGbIOEnK0SRo/f7lOSdJksw++ogjHIBICv2u8x/HgxWmO4KLDqhtF6vMuXsQyCKVXEMzgBSndvqzGoXuWQ8dv8boAOxqz6HPdwO5V+ir9T6LrHob/OPhVayKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460576; c=relaxed/simple;
	bh=SbPyduLoPzx9opbtMiJIjyE1+37l/+vY2Yi4LhP7law=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aotzfbqgAe1XRBQ1KWUnz9k4iucbMOg379HYNvORX19H88/RIhjwc3AmAvJRjo93Khjia1Z2emg9n9gcnTPW0z6ai9b7JWqA2wjzwyjW+/j4E1m0O/OqPg6idEYjBUNgxoNtte0TF+TKHvxyel/B17GXpUSLQX9dxw3/HoWk1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrmpGfG0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrmpGfG0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b472842981fso659693066b.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763460563; x=1764065363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99+L/a6BzGP2qjLygPVazLcaKWQLM0CEl5yv6VmRsaI=;
        b=BrmpGfG09+KrBTCLFrA96vbj2aFmLFWgtHg8bWodcproATifcjnNuVP3C6ZhQgG2oS
         jhifBYrlsSMdwY/AN89jZ9bm/MVr4QvvEVYBX/GJwCN1+kNeaw5yU4zU8ZRJC6JzQEA8
         CThKMnhix+VMIK9Ayj+6kGsHMF7gtBael/biB1VPnAXo2516PUTf3wkksR1Glo9e70sj
         XPwHlwNV2Km/6Ka//aoJO4qR51f0JuMDXjuX/2O3qQazxmko4ilYh9MD2P9U1ghNFjoO
         U7JbQdKdH0jQqdPqdjicZdRwEkmeRTAOiT9SXiW/LmfS8OvT72WszrDIpv7dcFlmyrYu
         qnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460563; x=1764065363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99+L/a6BzGP2qjLygPVazLcaKWQLM0CEl5yv6VmRsaI=;
        b=M0AfJlYIRbGTofeh2HdDN6VmjSN4LzgcUtxF8wz2W1magwp9+rHk0hDz/mQPyPRDjt
         ttc6s9mfYkkDgEcaLjZNEMViMmrar4c2JDA2krDifzSve0WwrxXV3GccdPdYByrLuGic
         U0u2BZ/KykozyxoouERmOrXg1NHomqlEpyi+BzhPH4J9whwE3lpN4FKRXDB6YWXKpCtL
         Ocg+cjqdDbM3NNm1+x/YhcJgmx8EzykYxGj63o2DJ3/F+rAJVChuNw0FHB+THDBP84Rp
         AyGIXGSs4Z1DTUjyz3A+k0PKYKiq1hAiLqF12tjUg7L4pJuN3YPGbmrL+u/RGwMfR0+F
         Dyyg==
X-Forwarded-Encrypted: i=1; AJvYcCUZDi6YtkhWjbFXsdLUTyvHCdG6RZQ2feYTS+2uSlludn93M9rFHJP0zdTg4m8V/dVhqbr2jlXU1JJ3vF+FUT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysHoQWOptWRieCJ4B3qFkrQGA2xoyCrjLC7Ru00XUuQwPoNFVg
	JShZnGUlXfwCXkSEKY6CTRcoVJdDRqHJMYxKFb4Lt2aLbNZc0MQHiYYI+i41NG9Onuut4bvzcvr
	EaECK7elt6Qiyq7OJ2KHTjcMTopvlruc=
X-Gm-Gg: ASbGncu0Q1/e5DYFdexj1cY35ejolXri9Z5ixBunVYBjQ3MaNsTUTBMxS/0xM92WEvv
	MMQD2u23OMxZqc0kXJWbbfwprLAfkTHvt8ApzQmrkQt38ARq+uPrB4IwvSUrv9qRkmAAGOnKHun
	l6oSt3UQ59NCeOrqTnWNgrG8OOVUBbrwJ1bvugwLmDa2o4KEmNBq9St8er/Ai14Weq9Sa0qa+vn
	PVuQlpE31H5rGwKVE/X25UUul0CtUUepDZADN055skxL9QnMDb5mQQIJnrTHlBKl9NvUmzA7VMe
	xSNeWhFeaC7hQOk+jmtu6PrGjADEm3q7IXHupipJ7F2OkrB8IYobGncEvAHk
X-Google-Smtp-Source: AGHT+IHUzw6qWS2C+3JvSU6O95qqOlVKzGc5j8iqiIqr+BM+FKE5ftZJslXrugBbNo1/K7Q1yO4mVggA72cjjqNpJYo=
X-Received: by 2002:a17:907:1c28:b0:b73:8f33:eee6 with SMTP id
 a640c23a62f3a-b738f4336b3mr923645366b.23.1763460563397; Tue, 18 Nov 2025
 02:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
In-Reply-To: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 12:08:46 +0200
X-Gm-Features: AWmQ_bn41l6WVTfFulu3CXwZPQ0PycjfmB7LHfrGBjV0GmD9Uk123GrjcR0rLv4
Message-ID: <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> A couple follow-up changes to the new strends() string helper. This
> needs to go through the GPIO tree as this is where the strends()
> currently is.

It appears that due to some local issue my messages from the last 8
days disappeared and seemed to never be delivered. I tried to review
your v4 again and I have comments on this and patch 3. For the
strends() I proposed to get rid of strlen() calls by

  char *p;

  p =3D strrchr(str, suffix[0[);
  if (!p)
    return false;

  return strcmp(p, suffix) =3D=3D 0;


--
With Best Regards,
Andy Shevchenko
