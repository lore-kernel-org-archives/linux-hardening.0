Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794201648;
	b=gdqutnzTEvDe6AUObPEv8iHZ5P5GXIoobbI8B1tU48T6JCzypmTWJVOUG/HKkP+lI5B4
	 twdNEahQXo/mqFCgf5KW4+coN1kbDGfMyuShFk1LaOsHfi2vM8Bn8L3CZxVMjdBal1HV1
	 mO/5bRrmaTFy4Vxh67PZqWmyHg1hs4yV//SlFgkHBBVFUJxqGdoK6XP3lV/eKL22Bm3db
	 AHKPMZuAy9cHy9X79TWecZxs7oMYnGWVW2AFUam+F9dM2KaKLbI0coHTzdiJsFz9sTJ4I
	 uwtCdgUYGxYQqWfo/uFpbZQRHTT8FNuwSPzjM0BUZpahRIVaNqrAY3EHe3PjEM7KcPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
	b=SEJjRTJEhLNAuI6R8gHmeYAkzn/GizKiLcMG1OOZQO+Jcm7DeJ+o7+6tYQfVLg3IObZA
	 3MSZ0qSLr8PqrPLjm4GyKJ+AMAivRCQ1oqnvrQj6jaspc/mG0bewgfbqcxrOMxptQdo/t
	 CfWX/uyt3F+v/9Iob6c44AWIE5bMM0jzW9dufXJmgcubpvhjWqNuiR6kyQVmkzSuGIXOY
	 efKNnDEt9H79aTzsBR6/fbrlqXALw01ElLbm3xKWFIQ5fH2ywHK4DNXNM9ax3UZDohsZg
	 We50i/hTX0yaAo/syA0rmFZRWFnhetgDWx4QmJRwfK/S/p9GZnwtLS2tk/DlPlQngfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rLQ3CpVu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782ED606A321
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 05:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 782ED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rLQ3CpVu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso475031a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 21:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794201647; cv=none;
        d=google.com; s=arc-20260327;
        b=LjK9Kqx2QWMW4Lq6DG4lj8TOlK7ZE7p01Ciijo1h6wsI1iUvTNMRMDAks0gsBLBmHO
         T+pRwAkAAq++kWixqaa/LAOtvphMswclOuXOAr4GYaGTGLpecmgzUxsanWEZcSFTuFzg
         +INFd22wVAXDsYEHj6neOvb7TqKdVOkLO/ALQaSDGTtSeYdJsQ1Rwp2t22NsFVUe8p7T
         v4eKsRMnuJuj268uC5VYjD8Jr/2J0k1sA2zd/EoADdlpY1oxm6efBSooOf9vGwt/ACEp
         eCZ4U3/1Yi3PrlDw7MZ0nkZRbeBLYWgQQvyxjsYEdKXaJ0uM9/bQSE52/LUv9hGrJlFN
         OlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
        fh=T3gwOCUrtdxMqW9LNzirIwWwnBu3zNSwadwLGl0xDRk=;
        b=SpQqZhio2mvx9fwhVFl7KObU2OdVv2JKk7b6JLSNbFuvm5hj/HHyushw14IOp4hdE/
         TPuKELntroqn6oXVwQ3BkHe0PBm5xcC/ZbjwqFXRYgU5QTWalplJIGmk/FCcGTS3Gm/7
         5+dr8R50d5ZXoMyMUIg9WXiH++7vRiBg6g1/cuBNrT8zsyFWTq/aiSxWxOLsGJfTjXHj
         d8jclBU4o0hnyjOtFCdlpqGFBjvDHnu7aeAQ+OB6tjSwVeCTfbyO8ZGhL6t43F9JYmCF
         H6kOG+F5tSHq2dkr4XY4Tuo3YOx2+bEMYt1mBi/YycT2a4Tkx4lk7euukdsdwUOK1RB6
         AAYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201647; x=1794806447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
        b=rLQ3CpVuTbT1dCl9LaJTjjKpvxV/Pd2DtsaX8crhoYCT5R3s/JdBhHA78HZiPAZS/8
         KoU9XA+q5I8jpGHV5bOs4oyK795ZZUFPm+Ntd+PNcjXvYQdBg3ssd2OLidnZrecjcPrj
         A0HfkLCCg2zuN5Rb54y+6iKIzvnfyzx0k8oP2D0dySWtEZz8x6Fd7mdZ9grSkvOCxrqV
         kmBKAY7y/Wp0qIlptLY8wyI38yQl1E6mnM6tpiNd3bUtefby9cCRXBtA2fI4c9MIdh4p
         BaPLgUnIAtwtUjO+I1uax7d/oj5moqwWBagQIYS1IFhM9G4jZ3YbvtLz5z2F1ExUYmVr
         jUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201647; x=1794806447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
        b=MwrakofarOhLjxxNj4fJ0VNAHgfp6T3JDgot/1aMp9BfCxqlMaZTQ64BxPFB810h8Q
         Paz25w4kgT2E5c22fRxg3+FY2EwbcuCsd7pK9GIHwGIsqyvnw8nb07STVl1aAH8GagPA
         FAZx40CczbC2FvJ29/O2l6WXgBkEcVcKJn9DBuCXRovE/VqozBwcRctLTBBJxHVhELXc
         WVL7TTb2Q/ckkwd1U4s4TM/OjtNEWu2eOdtXUS1Mqzo/l3F6+NBzg2YKwrc9rRK4UZ4I
         R+yB68ZCgRj+XaTsH4PZyGI8N+3FycmSLKa2P1wQtnZAnLa70huGIQw0T2T9aGuLm3Eg
         4s0Q==
X-Forwarded-Encrypted: i=1; AL+hErF3D7grvHFQLCTCfixDKf0OBaj2mdjgnX5QKFOdhQNE3sBNyF3BsmstlqBoiSybviBuykRa5xeJbwZnEOHFlho=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SvjZX9vJgjqljgr1AjwFK2SQqaqBQpeWlTAymzXbCGyp7XZJs
	ooMTH8iBZaqk/rJ2IeI8CVJLzbihJb81Cj33I2qnL618tfY+mlcAMN/ZKxzFi97hZ7wsgfTTPfQ
	3y+2Wy9VIk7aHlWeuwepAVWat36idwyg=
X-Gm-Gg: AYBFou0zZBuEKMISYfFzdUTZZakazVbSJyghSBxjfz6dewZklg9I83Ag4UTv+JXTorA
	6C3MpTNUUEnwZLLb5szieEiglI0ZV/rWnjfpxRUB68VivAmWJ9+TqeNBzo7myrLzjzN+geXBubY
	QEULqAQ9h4uf+cCoUi7aNg0TWYZqqKHvf0zxhgodeM/WOruVzhVc+Ez5vZXhHvk+9r7CHywL2Fg
	n8yebaXXa4ZlteZQ/+lECB6fnGvy56FP+0Befbx1lnopzG7qs4t6+lwlg1midtQ7a1J0FZQPVLK
	3qv4/tz5mTV+GEwB4AMmVRX95Nlw9zrS7sjQc9lX4hq2BADNBFW+UP28id+rAtyV5vYJudguDu3
	9i9zQfYlzuSOEq5Eol7zUK2Yu65wE79Wur1zxpOVenyFDNjTogtXshLC/24C+ieWfeNb0dZTDkL
	SzvR3ocI5elMN0zlHJtmuN4lAqqPb9kI+cZWKNOSwo+ctZ6t2VWc5k3QZ7GUM0INKEUtCUaNYpc
	kWYce8fhi1DiJMizwfl86MvoLomTrgRUQjdsDNursDvyL+vuQ==
X-Received: by 2002:a05:6402:2349:b0:6b1:d2ee:392f with SMTP id
 4fb4d7f45d1cf-6b722462c10mr1849087a12.25.1794201646678; Sun, 08 Nov 2026
 21:20:46 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005001143.576737-1-rosenp@gmail.com> <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
In-Reply-To: <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Nov 2026 21:20:34 -0800
X-Gm-Features: AclHuK-SIIyleRJSywdY0Z0pO7le2Nv4F_kttBOVsLQnGOrWIxGto2xb9JrsOXE
Message-ID: <CAKxU2N9a6+0DXxtTxNwxWm6yBxmZS+AHpBLzyNBsvfRBasgAWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: gsc: allocate formats as a flexible array member
To: Inki Dae <daeinki@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 8:41=E2=80=AFPM Inki Dae <daeinki@gmail.com> wrote:
>
> Hi,
>
> 2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:11,=
 Rosen Penev <rosenp@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The formats array is allocated separately with devm_kcalloc() and only
> > referenced through the gsc_context. Make it a flexible array member at
> > the end of the context and allocate both in one go with struct_size().
> >
> > Annotate it with __counted_by(num_formats) so the array accesses can be
> > bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
> >
> > Assisted-by: LLM
>
> The allocation and lifetime changes look reasonable to me, but
> Assisted-by: LLM causes checkpatch.pl to report a non-standard
> signature and an unrecognized email address. Please describe the AI
> assistance in the commit message prose instead.
It just wrote the description. No actual code. I'll use
devm_kzalloc_flex in the next one.
>
> Thanks,
> Inki Dae
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/=
exynos/exynos_drm_gsc.c
> > index d9637ddfcfc4..f1807ef664e1 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> > @@ -99,7 +99,6 @@ struct gsc_context {
> >         void            *dma_priv;
> >         struct device   *dev;
> >         struct exynos_drm_ipp_task      *task;
> > -       struct exynos_drm_ipp_formats   *formats;
> >         unsigned int                    num_formats;
> >
> >         void __iomem    *regs;
> > @@ -110,6 +109,7 @@ struct gsc_context {
> >         int     id;
> >         int     irq;
> >         bool    rotation;
> > +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_form=
ats);
> >  };
> >
> >  /**
> > @@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pd=
ev)
> >         struct gsc_context *ctx;
> >         int num_formats, ret, i, j;
> >
> > -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_=
formats);
> > +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats=
), GFP_KERNEL);
> >         if (!ctx)
> >                 return -ENOMEM;
> >
> > +       ctx->num_formats =3D num_formats;
> > +       formats =3D ctx->formats;
> > +
> >         driver_data =3D device_get_match_data(dev);
> >         ctx->dev =3D dev;
> >         ctx->num_clocks =3D driver_data->num_clocks;
> >         ctx->clk_names =3D driver_data->clk_names;
> >
> > -       /* construct formats/limits array */
> > -       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_=
formats);
> > -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats), GF=
P_KERNEL);
> > -       if (!formats)
> > -               return -ENOMEM;
> > -
> >         /* linear formats */
> >         for (i =3D 0; i < ARRAY_SIZE(gsc_formats); i++) {
> >                 formats[i].fourcc =3D gsc_formats[i];
> > @@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev=
)
> >                 formats[j].num_limits =3D driver_data->num_limits;
> >         }
> >
> > -       ctx->formats =3D formats;
> > -       ctx->num_formats =3D num_formats;
> > -
> >         /* clock control */
> >         for (i =3D 0; i < ctx->num_clocks; i++) {
> >                 ctx->clocks[i] =3D devm_clk_get(dev, ctx->clk_names[i])=
;
> > --
> > 2.56.0
> >
> >
