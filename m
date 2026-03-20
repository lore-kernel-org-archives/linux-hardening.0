Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655C3594F
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965497; cv=pass; b=CGQVs1ONSrlX3vrPcunIqNrZHww2sx81TUEjqE1zZLyd3TMfe7Vv5sitwDuBcXZCeoo5FsrsqWyfu2mD3Z6fjsV/ZxyStB3FZQyyRT3Iyq0SVHUzNkNWOG0vyy9mR9gvlsD2Hvax4Yi0OjbVCEqXN+iwPCirkjlYSVdQRhZR4O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965497; c=relaxed/simple;
	bh=gI9RF56rEVccfANAw0mjJRT6sIl7aJcBmX4u0k/0kLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irqH1bKNQxqITEdgVqOQf+5LxFTXEqKPq0MU8Iyh+zal4xKBqcg3WSOqpwpS847UwjBR3eCFea3BED6y7zZ/Y+dGb3NeaWjegdyy3d1b08t6PjFG7yWKWJFW0Lm32Yj6Dlp8sUwTRWTAElzUPCbZPzQ4crbRUnbX4Yomm9WmuGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn4Bb4VV; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn4Bb4VV"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97ed4ad579so16024166b.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 17:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773965494; cv=none;
        d=google.com; s=arc-20240605;
        b=gUYXSIkwoMQkmB8bw68JhOyU+jUfPdNXuGTkqsTJLbGfehc+7Q4REFQoCi2KqpKGc/
         oxcL3LofHfkyhgSr8ubXT65jE7df+sEzPuN6tng4cn+9E9la4VLwjw2bVMRyvbWucFg8
         HhaqyBHLr48CmQZlYuQscdbRyYUcDSy6cuEwYLENVSjMGyae+gW6I+8C2QCR5MOhdmnS
         /LRjbJN3WoL56eFBfa/Xwc2aJZfMep9g47H0Xbgjp6Z/xSsixQ2CRVTGLJgfg1CUviTi
         y3XLnkGJdJNm+rh/4KHMlOIDPvR1lV6neA8Q9uYwBEntFtgoWuRzKdx+TqwR7A20OlMH
         8IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NsqY7865Oc2d7isEI7t69HCmXThZdea9XKdAmAr2SZw=;
        fh=/Xx2/5zTwNm4oIfVD1uGc2J5Lzp+69FBra4i+bL7DeU=;
        b=XGk2LBLVjnatXHIyjDifNAevU2qA4gdJ/t4HA5CNOb5WDMJwLGMZt58+DWDeDOB0La
         l/CFCYqvKZs0R3uxJU/oC8hPno31jmE6zPSJeLPLtWvyAOz+E4Bu0MV4pSuVD26dbAC7
         2JODvX6joM2vHQUj9Fap9rBXReC2/dJOfjiiqJ2ucKsik8/RrzOBpxkL4WFJN5TQhvq/
         bw2uLCgCN50+YFDLtIq2ld9cHko71wWSEKabjVIu3/LDFHB3i4SENAfJFi2Pw8IXpjLW
         R3+wEm73fQLansdjLo0zRVl6+QQNr202OAeeve+eaQA0H7/16qzMDgNUVJsXUpGzkVf0
         fWZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773965494; x=1774570294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsqY7865Oc2d7isEI7t69HCmXThZdea9XKdAmAr2SZw=;
        b=Dn4Bb4VVwFQ2a9HnDZ4qzK2kBdn7HVO0V9Grp28Pirp0bXn9lyUUP7KB8oCZ7CqZwq
         OZqqg5BuBJOub7CKm4pf+XcDJlvaFSUbb4NMK+k2sXkCMtwPiC6fXAxiUaZhpIyw3skx
         NQPflVF/SgvWxgqGLapN+fchnNio/Q9krv8BlqNkQAASYmhhjP0XzRcq1YqF/+ohemN7
         D2r9Qb124gJu85M38R7SWM9OXS9EUOtMdvP3pEZxvlPjtJ8nx0Ui2P24hUfuzJVuEUiA
         40TYzYutZsMx1+QrL+ilOyIMG0UZ6793XBGaYgyniesySqo83gKbZqlfVyfGqb5cW8I2
         Ulqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773965494; x=1774570294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsqY7865Oc2d7isEI7t69HCmXThZdea9XKdAmAr2SZw=;
        b=I5jyZ9IwnfQ9V1pANI00UanKUfpBD/9xdVxBHtj2iThLFQLFdE75GNUycZiHLd94qx
         jZ7FtZQf61DufD5oCnlgdlCWG6OLJx1YpucY5m0RcHWzQtrrkkUWACrxn7LTux7yILx0
         y83+03/iI30Eo/l1sXwNuYOKN0z3G4NmeC9+Cq14FAm2HMFgrL8Z/QiOE7cZY9WwOQ1X
         YFaE+wm0Gox485CBwPGoWyv9xZJa233xq5MDBWwyNEHSSQ0WkBB625mDfhrUEY4KW0lJ
         ruDMeCmZlZ/v8eIjPOLPZ79rzWYlnGduiraFGL7n9najX7OJ+oi8MF2xjQvkEOLAPA0b
         ccKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTh62euwRyCFxzOvbso7J2NL8jvZ2wOP/BGXhCzW49Lxnso/5i5oJKCxWE2XjUHaOucbS5NP+13YZnqP8se90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3zQLktZ2mCmJFfDeH/33Cr1iZNh1SyjdHzIMEZvA2y8BGlIE
	Z6z8arkeCGrGNJvlnV1DorfHznLCjdDbuF+a54Rn+nacucwKdmjJJCJ5AOdxxCvAK9aVdauKHlL
	/f0bAmY+D/8PHILBQ6ivSQSj2HyNCy9s=
X-Gm-Gg: ATEYQzy+cBXf6H65A3ZVQTyJ66NFp8/um1B4uoyBL8sAS0H1C9KafYNtz4aDgwsdkIR
	eEkqoJdp4/tPuVjJxzMMqY00YRIUp1zk8mxrVj0aqCjM8urucet0LniZySuB1gtNFF75w/u+Ci+
	BMCYv2TGPuei2gyVEx+gSd0iqrlU2wYwtFFiKrGesGVbcwttFvj4qnrhPymIN56G9EOjrJ+OFUq
	KZYOau6nPDLycj+qihENEo9MA41qzo0FLf8FsguZaQ3ovlhWpwPMDpoRDfX6MZqTEKi3/qG2WIu
	Se6E8zmPH43Q+CmXu1D4tRXX+MfvGnrA3HEUI9RVd+4LUxyhRoUaC27IAatRHghiX3b89hIOMqU
	X9S+O5/oLucAI8tSA
X-Received: by 2002:a17:907:82a5:b0:b98:21eb:e362 with SMTP id
 a640c23a62f3a-b982f25b778mr71309566b.24.1773965493513; Thu, 19 Mar 2026
 17:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306044536.149204-1-rosenp@gmail.com> <20260319220901.GD950375@killaraus.ideasonboard.com>
In-Reply-To: <20260319220901.GD950375@killaraus.ideasonboard.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 19 Mar 2026 17:11:22 -0700
X-Gm-Features: AaiRm52ILjwYSbA2_rf4fpvc5tasK399kECRpWwjEnLOwZZm6-7yacGmgm9khGg
Message-ID: <CAKxU2N856yYXURRf3td-_RCpe9hyX=zAy3qtD3ki23RjgO+a4Q@mail.gmail.com>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 3:09=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Mar 05, 2026 at 08:45:36PM -0800, Rosen Penev wrote:
> > Use a flexible arraay member to combine allocations.
> >
> > It looks like pipes never gets freed anywhere. Meaning this effectively
> > fixes a memory leak.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 11 ++++-------
> >  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  3 ++-
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/driv=
ers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > index 16392420903a..657ffecc4d7e 100644
> > --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > @@ -459,25 +459,21 @@ static const struct dev_pm_ops mxc_isi_pm_ops =3D=
 {
> >
> >  static int mxc_isi_probe(struct platform_device *pdev)
> >  {
> > +     const struct mxc_isi_plat_data *pdata;
> >       struct device *dev =3D &pdev->dev;
> >       struct mxc_isi_dev *isi;
> >       unsigned int dma_size;
> >       unsigned int i;
> >       int ret =3D 0;
> >
> > -     isi =3D devm_kzalloc(dev, sizeof(*isi), GFP_KERNEL);
> > +     pdata =3D of_device_get_match_data(dev);
> > +     isi =3D devm_kzalloc(dev, struct_size(isi, pipes, pdata->num_chan=
nels), GFP_KERNEL);
> >       if (!isi)
> >               return -ENOMEM;
> >
> >       isi->dev =3D dev;
> >       platform_set_drvdata(pdev, isi);
> >
> > -     isi->pdata =3D of_device_get_match_data(dev);
>
> I'd keep
>
>         isi->pdata =3D pdata;
>
> here and not below.
Sure
>
> > -
> > -     isi->pipes =3D kzalloc_objs(isi->pipes[0], isi->pdata->num_channe=
ls);
>
> Wouldn't it be simpler to just replace this with devm_kcalloc() ?
That would only make sense if pipes remained a pointer. A flex array
member allows combining allocations since it doesn't take up extra
space.

Technically kzalloc_flex is simpler but I assume a devm version of
that will be handled in another treewide commit.
>
>         isi->pipes =3D devm_kcalloc(dev, isi->pdata->num_channels,
>                                   sizeof(isi->pipes[0]), GFP_KERNEL);
>
> No other change would be needed.
With a flex array member, that's a compile time error, which I use as
a hint to complete the conversion.
>
> > -     if (!isi->pipes)
> > -             return -ENOMEM;
> > -
> >       isi->num_clks =3D devm_clk_bulk_get_all(dev, &isi->clks);
> >       if (isi->num_clks < 0)
> >               return dev_err_probe(dev, isi->num_clks, "Failed to get c=
locks\n");
> > @@ -487,6 +483,7 @@ static int mxc_isi_probe(struct platform_device *pd=
ev)
> >               return dev_err_probe(dev, PTR_ERR(isi->regs),
> >                                    "Failed to get ISI register map\n");
> >
> > +     isi->pdata =3D pdata;
> >       if (isi->pdata->gasket_ops) {
> >               isi->gasket =3D syscon_regmap_lookup_by_phandle(dev->of_n=
ode,
> >                                                             "fsl,blk-ct=
rl");
> > diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/driv=
ers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > index 3cbd35305af0..99532efa4e41 100644
> > --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > @@ -286,7 +286,6 @@ struct mxc_isi_dev {
> >       struct regmap                   *gasket;
> >
> >       struct mxc_isi_crossbar         crossbar;
> > -     struct mxc_isi_pipe             *pipes;
> >       struct mxc_isi_m2m              m2m;
> >
> >       struct media_device             media_dev;
> > @@ -294,6 +293,8 @@ struct mxc_isi_dev {
> >       struct v4l2_async_notifier      notifier;
> >
> >       struct dentry                   *debugfs_root;
> > +
> > +     struct mxc_isi_pipe             pipes[];
> >  };
> >
> >  extern const struct mxc_gasket_ops mxc_imx8_gasket_ops;
>
> --
> Regards,
>
> Laurent Pinchart
