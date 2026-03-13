Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3E269D18
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438538; cv=pass; b=Pz4GzcqWGDp5cWVsPSOdRkbVC4fRUyBv7fqptIvqR81IqNPoTVe3SyLA5XwoSIyUtgM+iPKeD+F/8AQgdoLqO71Yoa9UQYBcExeOUACUuJMLVIt41oprJub8hegp+sUqv00wMWRZxpoBybSWMLZjwDdsswAuRBMNN5f39sYdrLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438538; c=relaxed/simple;
	bh=+ac43UU2AUQrSK97u9UGEOszTRTdeBowAhfRrskEKl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvYznYAOhov8sfYbIiPAt+YRD2vc6sudnf/K/yjmK+t26LnJWnxv3y0Ez0u10giSMG8Ad80DazSD9rRp+oY6lGsRgrY0D9GlS2r8x2gVuMHiZEGoBYd4RZ3MsxmL08PiI/023MivMF3C18EzFtukT7EYPlyFCaHZ0oEVoaL0BgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ6UO4Pc; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ6UO4Pc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9434f706a2so343677066b.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 14:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773438534; cv=none;
        d=google.com; s=arc-20240605;
        b=dtEy7DvgIn/mXogYfbXYU/QDV4JrRcfrDmMwznqRqhcW0Osf3p6Ojcqm2QrJD47g5g
         IYMz92Ul4O4i9Y65XMkw6JX9zKClt9NXMOaXJYuIH7qa1bxy1Wh0/yVzS351rhHVJ5Oa
         ncLY12FPJSB/DbjPFFnFjEEZOg9Wo7fZpGJT3oekUEakzb2hxePlOQVwWmMma8z6Xbud
         8mz4ZBXLPw457/YAwMkayWX7pTO41B2Yg8Rgr95j2BpQ8Q364ym/dxCx8wleS68h42RF
         045mYFf3Da7fK8pUoEVr2LfKOHIHy4ieYdTIXLIVLIvHugYFSf6mMqOPCedMH8e0sQI7
         ZLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        fh=k78cdFEKJdFPo9LgEB4i+qqigE5Cb73wwHMrd/Vz3wg=;
        b=C0vhCScTSZF7u3FVpe10EZsGoPIHCHLv8+chW9/QsnsFR4+WItyTJ0OIqqTmct4EL7
         97ifcO7lKpmzzpFumVWf646XVkHjyN+UddVDu89K3GyiXasGHnrBQiTPYBcqG4NvBjku
         SQBitUPp7VOZpSTDAJJOcwcfOWCa1mh95mcGVrMK3/CgCeo08CZJYZHj28D9gqCS3ZU3
         VD8xPjO3tFfMQnLwzumQgpaj4VAwKlCWjI8/4z8DV6Nc3X+6C6Ibpw4u+QT4SSlM6YhF
         yTr0fm6jmeU6jCUx2NZgole4d1CBt9vuFfM/yEyNRkszPsfP7TDuNiu6PYU+jyQSmwEr
         cdAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773438534; x=1774043334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        b=IQ6UO4PcxEv3rvX+xeEUU+rAojHW21nxxZKLikbbUoKsxdfevikzdsweD+fN1wb5uL
         1Z0rGEntEfVr2G6EspEudhkmkoh5jhqFbu5/vdaDjp8DhGvo0G09TSbYllIJVNH4IhFD
         IC4BJpR+kQoaezcxPJAGNmidIJ3jH9Dknveu19Uz468iozLrWukTFuof1uwfhlG9thqW
         5BnUoY+55lXG5Hmgs+MSfBwAfvzsdzUfte+TKgZH4Nosi5pyI0230iUdtdKhYpYGWosu
         a4eJ9iYKEeKkN06xaBx3RMP9qSaaxa+FKGXen+5s3dOQYiedcIqo+i8vPLNcBWSJFRt3
         620Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773438534; x=1774043334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        b=BMi3vykcMk+laW9knQlHxOuYKjUxxEaBFYKLaHQwlZP14IPB+u0y0O5Lcx7Ai8e+67
         QW7xO/cuoJ3CZH4MeFRlgQaFTFiCtUWRTg75LuPGHbW6HR2GhHJhXtcYrOf9aGW4jTu9
         aSfaYmSYvzGMUSVV0vXExTA9CaCKTVfj1bjyOpMoJ99FZBaXatYYWJjCS8RC4W8BG6Kq
         XMgKogH7k+IXxwby+SJU3PvBPLCEqnaQCO/NA1TjqyxC5BwXxUbI7HwfmaPQb764eqcn
         3ERxGxPKWHLMOZkB32OMnnWI1LMeL/+X2STIghFCk9UJM39Tc9QjkLn6OOuXwqY43eEl
         S18w==
X-Forwarded-Encrypted: i=1; AJvYcCXWvLA5S1uhAECmJ6khtGMa1aMCg8BDkZ0Nsz3GWKBv2T9QQyAHsCVcXvLlKUVRxutH9jQdUJxCHId1EJq8Lhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm98j/b3vbRvjQCUkoi20A3OhTu3wZqQ6JetJgWpsvhhTBmdMM
	+7M9Eq/lzk1B9mdNsk9g7unmoNetC/o19umNzjzJxWUVC391gpXvr6MWKn+b7RcYyLZxzLFxvvl
	UyQeYdC7TR0wHIthm54fnQTUzDBD/jm0=
X-Gm-Gg: ATEYQzxtrhStCS084PQEJweGqcDSc6GckbQqleiVNtsC7SA+7/Pbgh+cS5z9jn9YZUo
	JkLrODGbqRS6ZNxb6X+gRfHELZbBBvG1a8+a8d/xMjIhVZjrVZgM01Ss0yyTYFO611SuqMpQQTJ
	lZrglA1+kUJIhyLoKFY9lYZsggQY2ZJnGxxBNxuDc66/Rg1GdQ2J6DQ4bcHpte+9zDerK3UXzwn
	4SpllfoK6aMvf7rRmhFsxFKp9n8B9k1IfpOhI2cz3GMQ0RMGine0zkNmivCKHwp8YgrtWDlFdab
	x92nny9eUFDCVhTZEmoTIY28NSGbyarZND7OybK56SBaF2NfQHuTnruV0PcA5gtmf+vAEx33klW
	cA9web7Z93/sgjPjh
X-Received: by 2002:a17:906:2099:b0:b97:896:7c4 with SMTP id
 a640c23a62f3a-b9765352484mr178298666b.51.1773438533882; Fri, 13 Mar 2026
 14:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313002308.119343-1-rosenp@gmail.com> <DH1I88QT17NI.1MZERF8Z4M6P5@bootlin.com>
In-Reply-To: <DH1I88QT17NI.1MZERF8Z4M6P5@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 13 Mar 2026 14:48:42 -0700
X-Gm-Features: AaiRm51_uufIP7vby0iQyhJE9Np66DA5ybD5UNuzVwNcO2sPLvT_d9qY5sI1mJE
Message-ID: <CAKxU2N_sp+OGQWr_+vjHmCGfe+FDA0=4ZNJ6+MgThbbXU-3Aqw@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:23=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rosen,
>
> On Fri Mar 13, 2026 at 1:23 AM CET, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis. Move counting variable
> > assignment immediately after allocation as required by __counted_by.
>
> Not sure what you mean by the last sentence, you are not moving the
> assignment.
Yeah, will remove.
>
> > --- a/drivers/i2c/i2c-atr.c
> > +++ b/drivers/i2c/i2c-atr.c
> > @@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
> >
> >       /* Protects aliases and use_mask */
> >       spinlock_t lock;
> > -     u16 *aliases;
> >       unsigned long *use_mask;
> > +     u16 aliases[] __counted_by(size);
>
> Please reorder the parameters accordingly in the kdoc documentation above=
.
Will do.
>
> > @@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_a=
lias_pool(size_t num_aliases, b
> >       struct i2c_atr_alias_pool *alias_pool;
> >       int ret;
> >
> > -     alias_pool =3D kzalloc_obj(*alias_pool);
> > +     alias_pool =3D kzalloc_flex(*alias_pool, aliases, num_aliases);
> >       if (!alias_pool)
> >               return ERR_PTR(-ENOMEM);
> >
> >       alias_pool->size =3D num_aliases;
>
> I'm not really sure about that, but I suspect kzalloc_flex() does set the
> counter variable automatically if it's annotated using __counted_by. If
> that's true, you can drop this line.
It's automatic with GCC15+.
>
> Otherwise LGTM.
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
