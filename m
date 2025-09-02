Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B192EE285
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807865; cv=none; b=r9Xtjbl8ArcNLHTsWTMYcMdo2jhgC8Bzc+iRPznL4SA9HE16hUB4DcEa8EDNjbXpGFcJGBUX9T9jY3kd4zpGS80IxXYKCq+xLPi+S+QUVpv3JJhvk7WqdNqq/DUPL3s9utZx7Zi7e/LLTgjSHgjbv4ldeku/6TRMYwtsDhcCzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807865; c=relaxed/simple;
	bh=f4FSCQOOsa/4OCBJBGTowZPZFe3uwXyHE8EAIbJ1KzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZHGNoXyWgQJ9iZ9We3iT+ofqyNhIkbZd/iw3vk2Icbk4/Yy5AHTjIuaCNm32swmdQ/zkckhIbghPGFYzXWPoBKybCHjAr9s8PU6AkB4nm4m8IYGJlek44SxM/yCzuBN3qunkJzUBSGO3Qxw8bqySZHsqYpLyJg5gY8VVvyR2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZrp67rN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZrp67rN"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f7ad815ceso2159656e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756807862; x=1757412662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9/dg3rMdImtSDs9qVPDpc7idBTBiPszJRQRzWERi5Y=;
        b=qZrp67rN8XplLKcepeAzOZpBM2vkxbddlAxns88NOS75WkWMp5a7tftIC5j31G/gZN
         vpDQ/U8CedvYpuOl5mU5/0UiKJntFTiucGBTT5etoEDlCR/Cw768+vOUWL0oR7rtsg3X
         ILfUyWmomFtemqMgb8+kwfc9WWGvbm507EDkPbJ0m5OrQdn4fM4jn2AXsdLIb2sROcX2
         BMb4IDp1xaSol6aVBAs6D13/rZGFPjqgbd1ItJD6mxwj8K+XE4uoADFV/FZqioEopMwF
         I3ojUVK6h5kNN0XS7Ib9AxJwDLyUyhe6adhZFeg2Eyo8CDhG8DFl/jFORKWPrWXxVsPf
         dBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807862; x=1757412662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9/dg3rMdImtSDs9qVPDpc7idBTBiPszJRQRzWERi5Y=;
        b=F5WY4iyRaiNnQ/O32D41cqHwbr9qzj5PNyRaaD+MHNP86WxofWAUnRzrW8p/vWnFoh
         QZ3I1HvZOgULQWLVQjwRtWBrdVJpT6qCcPTSWv6VMZ9eaccg02/tgA8tfodYd6WW5/RU
         t1STLghbQ65afEvpKfSGlJnnMSQY1UyEGxZQjktE2a6w6Mp35FDk71BjVdYtX1XrrwD3
         ko0kAyT3F+FyP6K2MvA/7jVyZT+qr0Hrz1zFDgw2CnsRI5zX6qtNkA12A/VKwYL6rIfw
         fWQTymxS/uK6JzC7M71G/KmudHVICdMggH5JRjyCub38SixxYvl+hnCf6vAeXQwUwh1r
         ZGFw==
X-Forwarded-Encrypted: i=1; AJvYcCVdVhmyiP+rC3Gw5ECWeAWMCG9Ie2KmbrMqXyE0HdCjhDSR7fO0h5L1wbQXo4JKICWcD53szLr20dY3TUTt4ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxulNHTV9sQvrdT8iFWAOCsBOvYAbd8bJCHQ8XMkfPN2i3opqLI
	Dy2GUxvAbLlI972GTK3MhoDHqwAhQgFslyKQMWenOzcHNsASqFeyyiruDHl41cyr9y1QyqnuHiu
	8ZRdogVv6U0wZzwu171dCzFWUKh+jhamcnMof8lLj1g==
X-Gm-Gg: ASbGncslAhRhgyFC1M4R1mcPKJfv91aKIVhqxe1k4XTKX0vh9/UOgWeu48CfNVaH7A+
	KsQ3OAsQHJarU4Rm2IG3BjEvndHqmnC7Lb85xu2IbGhVo6Anp8DXIo6n9W4wPfRfXCK+OY1duoA
	yWLfHobUTtvMOjZNKHRyMFWFBZASQunQJeX1BLVlelGjkO9q3Od7UP0mpTO6leSS4gdw8yIP+/F
	BcGqOI=
X-Google-Smtp-Source: AGHT+IGvJOVNe+LUFvOCbgL5wgN/h/Cjvl043KlTfsb1COy3EuiSQw/TerVuRTUEwrGuUBs+VE/GG3RycL486iAnqi4=
X-Received: by 2002:a05:6512:250d:b0:55f:34e8:b1a4 with SMTP id
 2adb3069b0e04-55f709dda1amr3184317e87.56.1756807861583; Tue, 02 Sep 2025
 03:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-pinctrl-gpio-pinfuncs-v6-0-c9abb6bdb689@linaro.org>
 <20250828-pinctrl-gpio-pinfuncs-v6-6-c9abb6bdb689@linaro.org>
 <61bad868-d976-4f49-805c-8d14d4d8b3e4@sirena.org.uk> <CAMRc=MfB_3e0sjCpV+XaKcKvit7Opk5LczH2wsxO=RftrAabjg@mail.gmail.com>
 <4a633387-08a9-43c8-81d7-488e7222aeda@sirena.org.uk> <CAMRc=Mf0dOvwsWb6uraCQXeauLYP0TqY6xsQnV3fM0w=wROW+Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mf0dOvwsWb6uraCQXeauLYP0TqY6xsQnV3fM0w=wROW+Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Sep 2025 12:10:50 +0200
X-Gm-Features: Ac12FXw4LKCvHHNtKGBjLfwABtGCHq93WPj_v3YPD6EUsw9OMGyVKBEoUj5pgYE
Message-ID: <CACRpkdbrRc6E5idzkdN53QPDCSGpPUfdjmFmEFsS3g+v=cB6LA@mail.gmail.com>
Subject: Re: [PATCH v6 06/15] pinctrl: imx: don't access the pin function
 radix tree directly
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> On Mon, Sep 1, 2025 at 4:37=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > On Mon, Sep 01, 2025 at 03:20:44PM +0200, Bartosz Golaszewski wrote:
> >
> > > That's not a lot of info but it fails in strcmp() which - I suppose -
> > > is the one in pinmux_func_name_to_selector(). Any chance you could
> > > check what the value of np->name is in imx_pinctrl_parse_functions()?
> > > Is it NULL for some reason?
> >
> > [    0.628245] imx8mp-pinctrl 30330000.pinctrl: np->name pinctrl
> >
> > https://lava.sirena.org.uk/scheduler/job/1758947#L705
>
> Linus,
>
> FYI: I reproduced the bug on qemu with an older ARMv7 IMX SoC. Should
> be able to debug it and figure it out shortly.

Awesome, thanks a lot for your perseverance on this important
patch series.

Linus
