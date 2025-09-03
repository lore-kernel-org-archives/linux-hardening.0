Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A42874ED
	for <linux-hardening@vger.kernel.org>; Wed,  3 Sep 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901229; cv=none; b=qwkFeixHSFRxV96hsr2D/FZMu9ewrJDdsUQBEKCjyQI0uzoX5ZlzhI3qj0sdRSi+4mUkOIV4YWBtDRS2UgN9psDnFeIo1l0aRIV9u0G2kBF3DdzPbtvyyWhwX1NpbL1rsrPPzWnhY8NkeZEaerWtA4jIyZ9/+XjLOUtKTPJqvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901229; c=relaxed/simple;
	bh=Eo9UJfvaYgRET1kqEn1jPWXs6VN26Af35fGJeuqNMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxVGYR5P1q9Sudkd0HxyLT106EEgCKDeFD3y6F3jrKZz96tAfcHgufwMnelRqrMQd07Y+w1i685Awqbj8ri5Hv8JTIywg6LU382Wnebu6DMGa+REkkJ+WAtLezebtsqq8XtnZugO2Subw4DdDd0IoNqh1N0+VTrH3PUcOfWRH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Cr8iimpL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Cr8iimpL"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f6bdcc195so767798e87.0
        for <linux-hardening@vger.kernel.org>; Wed, 03 Sep 2025 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756901226; x=1757506026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo9UJfvaYgRET1kqEn1jPWXs6VN26Af35fGJeuqNMfk=;
        b=Cr8iimpLTHs6s53iq8k0SG84ZHh1xz4oDFb+ChINbIM9H4SVg8+DtMalnizQ3z3Xug
         5/rApOGhXUT8M2XKGKjs9Kn96w8+p8BMJz8kTdt05eRgw4ExQJbU9v8fYXckBw3VX6JC
         r1ggvthJXmy+zzv4Sv0a2TGRDB2A00n6FJrweI+Q6guDodtJNA8Aq+5gylYjm8sf9Wvk
         lRKDa44HoY7bRaOGPD6ed01x3JscIGqwrP054N/u/KzaAu/ARVmoEh0bEtpMPrvwCb07
         JwyPjq4bUJYlAwEkwQDjDyAyz1ABc/omrYXOn86f9x1gBdD3gaFENljq+iD4XTPvvKGM
         zDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901226; x=1757506026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo9UJfvaYgRET1kqEn1jPWXs6VN26Af35fGJeuqNMfk=;
        b=fC/gBnW9Bc00BGXwM3szNMPG3pVES/JhHXQRwuVwWIgB5IrKc6LENESXvAWOblknsg
         cpandaPdlkTM8UDndJxzWQRyT+eZyeKGCrgkLtITz5oeDrY/ukC6MV0+g9YMh6rOq9iY
         UFaEjnpkCaeycy7s8xcBBwGG9j6sWr8LwpzSQgvEQJBpNpdlhvtCbQg8S7fjv9MKVkoq
         wbubzDLPBTrrgADJB0oPd0wsrUmT/W9ED+91uxKRCgQyEpaAjYMO5SAwnhXt02HLNJBm
         MVcoMMq00556Fa7WAmasZc3f1XEuMi7wQJd2ptMQdEYeTSIm2LqObJlWHgI/h0I1u9Ek
         M9xw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQfb61zZe8AzjfF2XLQWUAYFp+eW9mfrYNXI4GfuChOoxNBeW6gU/wIEY0EF38LMy6BMu+ezuR5d04XQtMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/Zpky5SSfxsvN1mu8JMapwrHOnpnQEIxDfAdKjd29o5QI8Xq
	UA/3CNg9Cub/beBUkyH9YSckgQ87jTSYEwnOnoepQiDfAX9CeooiCmYFGJZU+a5zJPgRJk4J0KV
	Rx4z/eYPIIoyN3qiYMFv+knYuFQyoLddH1V/S6rMjXQ==
X-Gm-Gg: ASbGnct13WyGizVfaLjnAW3uTDQxoH9mKP1PK67HO5iJIvm4es9i9nq+WuyRJ76X1Za
	nOhGjHqwFwFJXRzzVHUFFXnvgcon7yuxFphZbNAMGDQF6le0PwwqMCEVEkPakUyyRV9xaDiCxmL
	z9q4kbiDoTWJLpPb1kFhaCy1Qgxj+XGU7kI6bJrCRe6eoEfxDu70mhlWR9N5HbI6jpjmZM6Nl3C
	4fNhYm8QXRk0HhX7GNXo0rymDVzS+74rDhn5tk=
X-Google-Smtp-Source: AGHT+IFCWFQpsNSj5HbtwgM9MCfjT0JGzQpT+8Q0JOxroU2mp8U3cFtE7ajM8EOI5676CpGuXoSnHTYyKyq5zkghPtU=
X-Received: by 2002:a05:6512:3ca9:b0:55f:6b08:e60 with SMTP id
 2adb3069b0e04-55f6f6aab17mr4829149e87.5.1756901225907; Wed, 03 Sep 2025
 05:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLcBcjvMbrxoDYoC@smile.fi.intel.com> <CAMRc=MfcFMgkNqWNZV5o0NxkAvxBTjC3vv56Cr98n0R2CkxuPw@mail.gmail.com>
 <CAHp75VcgaqnDrPH27wxfgyK6zz4RAKJQB0r7G2vbTONTxkEzTw@mail.gmail.com>
 <CAMRc=MfhhX2NJ0fhhX8u+7=sdyUy0G27n7caGf9=TpHxUDJVxg@mail.gmail.com>
 <aLgW7J-j4nn0u8uo@smile.fi.intel.com> <CAMRc=MdA21fwnamymG6YhqBjKDso_nJs_4xefPNONQNfEcPHXA@mail.gmail.com>
 <aLgaoivmBUgoeO6B@smile.fi.intel.com> <CAMRc=Me84OX=UEmAXxmwE8oOH=1UBsyHe-7XmU0c8a2gG9JnCA@mail.gmail.com>
 <aLgeDNLABpmkShIU@smile.fi.intel.com> <CAMRc=MdD9g4WiBCP0qYGuy5e3pnQf5MUHTqkUOnrUvcWUYK27A@mail.gmail.com>
 <aLgrqZETNLmuMHhv@smile.fi.intel.com>
In-Reply-To: <aLgrqZETNLmuMHhv@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 14:06:54 +0200
X-Gm-Features: Ac12FXx1vWTkfbwcKCR1G15N9111AA5z_ZoC4xZjaCT4bFZgzZIJamSIU5gFH4o
Message-ID: <CAMRc=MeX58XKmxaY1jYCMdy6fQJf7HWMR8f=DQpeovE8APw=og@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] pinctrl: qcom: make the pinmuxing strict
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> >
> > I don't see why this would stop these patches though, as they don't
> > break anything unless you decide to make your pin controller strict in
> > which situation you'd need to verify which functions can GPIOs anyway.
>
> It can't anyway, Linus already applied :-)
>

This would be the third time he did it so it's not like it's carved in ston=
e.

I see your point but I think we should cross that bridge when we get
there. Shouldn't be too hard, we already have an entry point:
gpiod_request_user() where we could set an additional flag marking the
descriptor as requested by user-space in which case, when we get to
the relevant pinctrl code, it could check this and refuse based on
whether the descriptor was requested from within the kernel or from
outside.

Bart
