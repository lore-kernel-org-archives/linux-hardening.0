Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159333DED9
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460830; cv=none; b=cd9HiRJyn+FJYsG9ATnvkN9tCYLu54wWwjku1g1BV8Dn+8z5QGief6xf57rVW1u+uGKWe8m5oGq876/uYRtAbMB259gsZw8/6lpnhy1Xa1vwKG478GyIZuoay102LuY0sfVaa4xpHYXefGMCNMnpFCuw4x9DR3febkWxDXR5xtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460830; c=relaxed/simple;
	bh=uFefpdoMFyMi27e5cexLCleGqXmlmnauCcO0f/wKf9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koVR6ikp2b2u45HxkWupm4ZJjarmrKAUXw++vM7S8BSGs3pQmqs05IAUfi8A/xxXO5jUQ6srYGIFaHvA/VMYNn3K+CRdR09dUxm4Cpc8dc2TvpokBVyFN7Ik7u6Ihd8cCuklQ2A62jJQweSne163Tstv37iq9CK2fPricY0PcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9cmm8Bs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9cmm8Bs"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b737cd03d46so429877666b.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763460821; x=1764065621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFefpdoMFyMi27e5cexLCleGqXmlmnauCcO0f/wKf9o=;
        b=Y9cmm8BsFk0UIt9LTXQ4X+ZBSdO7Sg/SdvUL5WStCnKBy5XT5JLPAJW2pFO6eg7IId
         6qL0vWAxmIrRfZkeTk9T3W9biEwYiblf0dVNhfSwC57/mdnA5K9koyWzkUP+ObNjC+Bj
         yXQbgknBo0KtnEUrd2bivKnK9byPVlZq3Y0bgByvdlIrjnBjRQdrVoqMkAAO+PxPajqo
         ASDohyxFrvYfJoIbMfN+l+/UniVTUb/wDv+E64ZnCc73iuxldKr5Gormu3lw30+u9TDD
         UxB+ng3pH6Ezf4ctVPDn8BftG+JQ398dgi3DLtm7wizmpBniiNzAajR6HhpRevJfcfD7
         h75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460821; x=1764065621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFefpdoMFyMi27e5cexLCleGqXmlmnauCcO0f/wKf9o=;
        b=am0BgXdG0WnPoUQ1R4IZnU5c/CEA58peX+5y1qS6U9MiflOETUTvma9fpc1LFW+kRo
         ITKSaswb0Chp0cF7eyMwlkLwP4w4+xVyNEXISEhwzFLyg/SNIzC/AQECKvzUM+gfuOr1
         1YvPxLAS0Jnx1VZDl2KxQ4tRFoW3D/MfuK0lCygd2lUtCb+WoO4Rt3HPLgdplDjxrUC4
         cSagRsNXMm+pqh77QZXvV1LWRji4EzXk/lBlltxsIUTpyoUnxAzrmHCGkrRpZ/v4HTJC
         df8W+OnK9xywNVWAhEJCHmCB4SIrG5FcBc+zUo6HXufRJsN1pqX1iYDtavWTQYBSs4zT
         qwZA==
X-Forwarded-Encrypted: i=1; AJvYcCUao4Catqq+aDRKY10e0Gy6T641G6B6V/BqXecsm5JALXD1tPMjWihiTHGz4WMzFiR7+fexCV4jJNh35EcGyuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzbue3JtB8/aLdFCEDuNchxrJKw36wI5gY0FPGMhx4dBA20u8
	0gturvDcBIa3cgIwRPqBVaM4cTklyE7GyS35TmLxtaZH2lQne5+5HH7QJvNnfleLtpAYpI5LWIG
	nIjeRchZUA3TJcNSBpX6iljLzcyqcBAw=
X-Gm-Gg: ASbGnctuET7dq//Gd84a/AWc1UWg1fhMvxtwAAHonP0lOFDnWMLnjPNWyYFXCD88DfY
	1VtHP/XR9haULcbjryY7IdJM4hcfNSDvY/6oixP2Ts62sN9n5ymkv9Fkn/MWCn0mPub1KqvFM0T
	z1aYfTWswCYgHJh1XKfajq2NCxiD2NjSPy8HYgeXLulHWNhQRBfOgpyNrmhDPBy3Y4ErMg5w5zS
	TgPIitSxbSygUryYFgV4PWHM7VPcSbGwt/0Hh38N6MAW9GqFyTsSsZGHQVdJmjsaS2KtubDm0JQ
	F4WNmcaYh40ImKAK+9Jt5bXE1UDfupDJewDq7fsVfiHZzO+g9cM3qB80JG2I
X-Google-Smtp-Source: AGHT+IEJTl+Y0nxnsqFxRaoeNJlW33h1PhyfMHfP+H08fkNstExAh/KMDUENdNIJwaldyRxp9vjkOUQWvebpfsJzkrQ=
X-Received: by 2002:a17:907:961a:b0:b73:1baa:6424 with SMTP id
 a640c23a62f3a-b7367bfbedemr1652125566b.55.1763460820308; Tue, 18 Nov 2025
 02:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <20251112-gpio-shared-v4-1-b51f97b1abd8@linaro.org> <202511171230.F83EE85D0@keescook>
 <CAMRc=Mekr=xcGbSBD583nUqR43aLYO9iGakbOSSFEWYdbXW73Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mekr=xcGbSBD583nUqR43aLYO9iGakbOSSFEWYdbXW73Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 12:13:03 +0200
X-Gm-Features: AWmQ_blpLOjcJSfageDQJ0p1yverbXLRzjhug3ph18HdqFCZGe_i141QG5p4Fcg
Message-ID: <CAHp75VeqaZ9BOYaEDdrShtZ=5o75HmeKBHv9dpiYpQLudCr2Ow@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] string: provide strends()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:47=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Mon, Nov 17, 2025 at 9:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> > On Wed, Nov 12, 2025 at 02:55:30PM +0100, Bartosz Golaszewski wrote:

...

> > > + * True if @str ends with @suffix. False in all other cases.
> >
> > Maybe added "empty strings never match"?
>
> But they do, please see the test.

I also think that "" =3D=3D "" (on the same page as Bart). Why should we
make it different?

--=20
With Best Regards,
Andy Shevchenko
