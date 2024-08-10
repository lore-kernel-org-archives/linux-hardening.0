Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AE1870;
	Sat, 10 Aug 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304400; cv=none; b=clubkSb24+oH/IQBXvaqb2SzqAqugHfRjHCZA4Z2qVItZ++Var5cnAhqZq17+Suc11ouRUBff5NSKl4zRZXrjFecT61W8q7VL/I0UadRIcxMTC4SDX6sNtdUhLcWwEe8VNWzGyu37bCiu3J04DuhydKuRXPL5L42rAmwR+KbxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304400; c=relaxed/simple;
	bh=HiDiD/Vl6USvlsydHRLj7zjEuU3+T1Z09cmxYg7M7cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyP4weHO3dPYN4onkj6AqbU5vULYANoFazdxkEiC/qNfLyZbSsm0hyI2nP9+O9YixhBiaOdOhh/YI6ThVOPp8eL2i03/5okQVoqgbBzazIzgmT9gRj+cODwKvVu5UZDajMfA+mg3vsH2sD6q2mxMJVXfKgUySLq1xaojy3naaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAHA4kTz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHA4kTz"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f025b94e07so34536581fa.0;
        Sat, 10 Aug 2024 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723304397; x=1723909197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKIBXeUHPOeUk9KK7mcaPVaWFm3r4O3HLvUz5rIXpAM=;
        b=EAHA4kTzIQN+agjyPJjSVByxz1JgLyMRdmBWE74L9SqX7zfl3ldlPKDg4KO50rXCsW
         J6Xu4lYpCTGBFdss8ZqUdSCclACZV/i+8eEjs36fFxYWl0w3NFxF85JbRriz1UpDfe65
         LxwKqLmCOGzKMGoL4PSksMABbPS+apk6DZkzPW6MuUl8PdlpmuyoGwJE8+iYM27V72ig
         r6yY1mc5x1zWVPi/xIEg9s/l/1MxMTJTxONZlTNKncAvZxweFmBalZVXWdDr2ZcLB1Gs
         absgI0FrMhpo2iN8MFHeteEaacEC2aLW/uPWtS8z3a04BtBQeNVIIyczxY3xWj0wvE3s
         tApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723304397; x=1723909197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKIBXeUHPOeUk9KK7mcaPVaWFm3r4O3HLvUz5rIXpAM=;
        b=b9G14Ldm3KLJRT+j+z6PqJpPL8BOXVXuNRcMAV+quwAd4o5DS4szxdxpKfPlRg+R9I
         T7q+aXdtf/FaST7ykjfYUa5tyl9MnlRN6oUc8X7x+q7l2hMQ1mMrLLdZVrhcOWhEJbCN
         aHWT9brgqF/ZP5ZyiBuxZOn8PjnFNrHXN54vTakLeBH7gIMPQZ2MAyXVzzB+gSUsURWP
         dZYq4uMHu2yImtwncwXXq9sC9vrZc3t36Y/9qz+7m7MqIpaJxrJoAnqUnZhuUIQB2jrs
         xYOUIu7Va/jYmXf2tp2S/eNXmZlbKvN6NKzd8R1f3Noe0DQpZUiptL9M8qFPIIrZjvbF
         1gVA==
X-Forwarded-Encrypted: i=1; AJvYcCWA1HwCZWP7WwCplJFH8ILphV8yRuJKU8xoilyyy26PAAkY1tS6UUQ4bFCs0p1apiQ1SyYVo73+uGnUqkhHrLP7FCa8n2aYA8PN/F5QsNAU1oyrvYNuEVNmq1oYLqWD9q6xmwuImTGE/7lnRTy7
X-Gm-Message-State: AOJu0YxUCEmloeCnIDGN5MJhtdz+D5ziz8YjOrSNJRjputwq262fXJsD
	lVf+dH/DOFvbjjj6aYXOWp9jmvRXxVdedQ7CdrqeiCcJfNFthb9sdyRjODboSVHkIIHuLMB1cqJ
	pZvLQWPjMOR2y0ux9ufZOl1GWNfA=
X-Google-Smtp-Source: AGHT+IHPlLVs3FLJyUL/zE0EGLj7c7V2EqrrIhIaWRbx96D6J0Wv7FOAPX6lQNQiAzkLg41JwA7AGP/SIyyMStskatQ=
X-Received: by 2002:a05:6512:b02:b0:52c:adc4:137c with SMTP id
 2adb3069b0e04-530ee984de9mr3205983e87.20.1723304397023; Sat, 10 Aug 2024
 08:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
 <202408081609.D08D11C@keescook> <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
 <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa>
In-Reply-To: <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Aug 2024 18:39:20 +0300
Message-ID: <CAHp75Vcpy3+wZ-UuLRMVtvhK8u7X9wAyB8_5t1v8M50NCyTYEA@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 2:53=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
> On Fri, Aug 09, 2024 at 02:07:57PM GMT, Andy Shevchenko wrote:
> > On Fri, Aug 9, 2024 at 2:11=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:

...

> > Okay, but the patch has an off-by-one error (which has no impact on
> > the behavior as it's close to unrealistic to have the SIZE_MAX array).
> > I prefer that patch can be reconsidered to keep original behaviour,
> > otherwise it might be not so clear why 0 is SIZE_MAX - 1 in _this_
> > case.
>
> Right, it is technically different but still functionally provides the
> "unlimited" behavior.
>
> But, we could  do this too:

>  int string_unescape(char *src, char *dst, size_t size, unsigned int flag=
s)
>  {
>         char *out =3D dst;
> +       bool unlimited =3D !size;
>
> -       while (*src && --size) {
> -               if (src[0] =3D=3D '\\' && src[1] !=3D '\0' && size > 1) {
> +       while (*src && (unlimited || --size)) {
> +               if (src[0] =3D=3D '\\' && src[1] !=3D '\0' &&
> +                   (unlimited || size > 1)) {
>                         src++;
> -                       size--;
> +                       size -=3D !unlimited;
>
>                         if (flags & UNESCAPE_SPACE &&
>                                         unescape_space(&src, &out))
>
> Really, I am fine with either.

This one is worse, I think.
Let's take time and not hurry up and think more about better approaches.

--=20
With Best Regards,
Andy Shevchenko
