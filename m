Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04156386C19
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260024; cv=none; b=Y2YDUxLg8zwxuIdoUibj4DE/gfbpJY3ZGNNap9DwvEbht5ADEcVTQrITxE23pzjXNqQtZwNqxpQDZ1UKGOULy57J01tbg0OnVTLBPlNwNKjN1B+WEp2hyG2fGqy5jzk46kmxfaN6fSGh3AzQLeE1q95adSvIeukP0M1t6niZtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260024; c=relaxed/simple;
	bh=2ZEySTGjzvEYD0+oL2rPnTK8VnmzmCs5n7mzP302FTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMt4yC5TNO7LHiCSzSUQCRjIocbXnS4D1hMGhMknAhSxSwEzQ9b/UsGGhb+Y0L/qQ+KASHJTARJijlpKXyOrIHqln6H+X2/SUjKw4jJt+1v3s/it8dXPf8w+s5NlrIEXDmokVBMsxer/vYIDUPq1Qq+FAw3uWsyFUq2tnSPGvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOQVXTdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOQVXTdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A2C2BC9E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774260023;
	bh=2ZEySTGjzvEYD0+oL2rPnTK8VnmzmCs5n7mzP302FTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MOQVXTdpZyrB1SZ6zK1Dq9v3RsCaNpEYWeAPWB6UzgfucCOv6JzFhj8eqDUvuqTkR
	 7N2+vldpoBdy2WrGTX9aWw3yICey55qa8nnrRtBywLFpgS1ID6Kn18JdKHVuElF6rH
	 OerjbF/sXD2hKZgTX6cjWUw+FpmSMxi2P4W2AA7QpQeDnpDw10J0UMjfD9HEA1zJxU
	 AmPSlUPuHOc1lkGpWzCVdGylFXWgkzJYjXoqu+OYudbvHHaeF6IRy4lJVgWI2D9Xyl
	 ybePWWv8QBS2PnrubvaSII6jm1nNojE0XJEwZxctBJ4ef2ON6SszZMOX1uM8X7CaU7
	 d5pn2DdZ+5NIA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a279ce9475so4160797e87.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 03:00:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6Jgmk/hcNkQtvoe/fv71NGRO8TrcMt4/a4mOKDBHJe4Wx3JqdbTOP0zKtq+4Fp7UqNdvtYfQVrg4Arqx980E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/0NBhohH7fmgM/xsCQTojfjo3ra93Wbx463otErzSyxcNJiW
	yCsa2FT8A85Q5NODPjJ+JZ8Zg4QQjLwU1uUHBFz8pkPra6SHGSD02lYYpKg2bgrb7fIC8r+kTM7
	55LAGcDJ2dyYbXxrwD7BQkMPh2mL5nTj5ebkPadSzRQ==
X-Received: by 2002:a05:6512:1388:b0:5a1:3273:37af with SMTP id
 2adb3069b0e04-5a27dde27a7mr4720127e87.5.1774260022227; Mon, 23 Mar 2026
 03:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
In-Reply-To: <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Mar 2026 11:00:10 +0100
X-Gmail-Original-Message-ID: <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
X-Gm-Features: AaiRm52TiXiM-9nvry-2dIKOcPo7jhE_iD_zrDEUXC_8gLkLh4_1u8Idt1ki1O8
Message-ID: <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Rosen Penev <rosenp@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> >
> > static int gpio_mockup_probe(struct platform_device *pdev)
> > {
> >         ...
> >         u16 ngpio;
> >         ...
> >         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
> >         ...
> >         gc->ngpio =3D ngpio;
> >         ...
> >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> >                                    sizeof(*chip->lines), GFP_KERNEL);
> >
> > But this begs the question: why add nr_lines when ngpio is already part
> > of the struct:
> Maintainers for some inexplicable reason want an extra variable for
> __counted_by works.

I believe what Kees means here is: you can use ngpio for __counted_by() lik=
e so:

  __counted_by(gc.ngpio)

I didn't think about it and I do prefer it of course over an extra field.

Bart
