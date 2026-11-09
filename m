Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794199309;
	b=Sx+pAQEYoa8PPj/8LXZM08B2NievAxe8ycZLQ5p0yJB/ydbxyyme88MEWV+N2rBBmlTA
	 6GIGbTGlvcLPXGIL6CZx3dE+QLXIPGlyazDUeeq6N0yyM/rNhsdbKdAxgwJDaPCkCxlTz
	 JxLU33+B/9lWlhGDgnEztMCm6XphLE0Nbhb3/x8vsWlDQ8yY2nXUnSU/TYdvFvPojT0h7
	 /lYYjUXbVa5ASHheMPC6oAu6MtUO3NbScPMemH9bFl7oF0btqpDtyCloIWyW1WJdt3pSA
	 GEMwDbeV8oOBraElWTYNNPNxhytTzlGhi44VXOROw4iV+c/FkShGsa7ii35lMCatF8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
	b=EZshkOxbYXrb2E4teYRwdpc/veheZRK1FGPw1S2SQsKycw29GwmnJvCjTAIbGcUwZEal
	 fuZ2as7dAV31WziSvjcyAVQB6ja+PYAcArE3DaOpegfTCz/pDbMm2Ll+oxuvfmGEgnzvU
	 inAO/NiZIh03V0z6prohbKKcwopQv4vm2vCWTWrLSpnojz68vmfF+IiO4dWClQM1l4GKq
	 7N5pGyjZQwJegdZ0agSXQDbBU8lFB8kqjxPmMJHf4/VY0uEGfg1dlRf4wTliAZ0acX+9B
	 /i+UcBIU6BfufsgDecA3GYrwcStHP7bQGoW5IxEXkH85n3FP4KKT2Zhopb9MmTnbAmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XL67E+6C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC1606A330
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 04:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DC1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XL67E+6C
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d581da0aaso41065866b.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 20:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794199307; cv=none;
        d=google.com; s=arc-20260327;
        b=OpZEkgon7k6RItNZvRVBW7w3L1/3tBZ42j5llG3sMwKhKaSP31aQNVrXd9Yio7fL1M
         99R0X5ZzJEGxeneqazjO+/tG1rPybOW6kUDGN0zb4WDoAn6C3SaFAUo3btoe14U+zG3X
         ONl5w66qQynxUWw327V0p6n4WwKoAkn6R8bCA4CxLmpiQUPb9FTKabUMB6WV8fIGP7p9
         dflS/wDZaMditypMtMkQMvRfgtf3MOucoxVUXpefW14ICLZh66tI2lL0ZRRQyYenfl1U
         BVk9TME7jiB3LPDjnN7C1YPTkXZI4CCP7bjCc3ZQQhdEZb/2bG4rvQRz0raBqLocvJfz
         AHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
        fh=/XtGEe3OKyxY3BRxeUR0Lj7ZOmEhKdRHXTTe/ObB5M4=;
        b=XFV8gpwS9uwaYwFXnPpzCZ4J9weGenTXmV/DD6ijzRMCK4woTr1jUX/BOWk10bsE/o
         5l2PZB/F9QZqsDlaqiyrOCZa/x0Lg76X4xu1YqRR+DGJ9K6Lu2oqJLwKmLpDIpFterAs
         MNNUOXu4KPrWrJPMfAOoA6Nu+5Yqt0Fbl+vMZNnkv2lGqM+hgGRNMo8+KKofmv1A7+zS
         aIBz5lC9fM2Lmlcdz+WMKgEjgnqup2ciMxG4y7Di9luTKVIk0KhEDRlBVZfVBSYrbAcm
         A4UyHczrJX/BJcd2VGP8QBpcVnb/oF0zbW03f6O1p4XyE9XWkjwQxsY9eqM8OKHcwt4i
         x7NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199307; x=1794804107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
        b=XL67E+6CWlgF6TMSKOxYtrmXheerI7gxjQHnzgaJ8fObVIn9fOePSsXpAm4jOuofTF
         JUa9+99lY+OsAfdXl17zL3hpp5FHvDYFIf9QjfViZnwYD0NNrDWWEqJ4hlW67FAJMPQB
         dQYuwABZR3fG8/wG3BSpt4hD2vPDv0MQ4bZ3WCwMGSQ0wz7vDhFUYrfW6deENy/fRobF
         G+5XDXtDBwA9XC5kYyw3Mv+ab8M405NnZp86LZuTYErY080guobrxmbyglJuPwyWkK8/
         xZTCgu0NmSgTNnE2WBiHipzOOotnAdFJ4HoM8GEXJYJWF51slx7oNW8Yovbo8OhkbFHu
         mwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199307; x=1794804107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
        b=H4F0Wdqh3Pa+lW6VaHpwLzenEYXJA07oOTxB1AGuP07tVIdhVAePwV05lYv7Cfif1T
         lVxzya+W3B62A246QeggTmi049Fz5DLbdQI+hYNzX7nQAyQH62C87CM0tDl3tTmij/lZ
         XOesXdvSiuBu07VWzx9ySZcddt078a5E5JItbUNIdsWtY4wnDBEw/fj4Ghnv7bmbSEf3
         B0PaZrX3ZPRf9Ixfmrqj/BRTZHglGS7wCA2EgxXcsNBA+jNagMY8XXx+85t8JD9XyaJ5
         v1+T1eXrV0S+Y/0KVC4fLHlY+WCr1X4kHESj3CeClt1KhyWuB4bctoylKNLm6TfNDdev
         uA7A==
X-Forwarded-Encrypted: i=1; AL+hErFGwwSdH9HaL7cb1Qkfzz/jX1Dp435hlliDVUPvKT4h8zj/zb2KSJo0jKAUibGMZZ6hZrCk8ISZlEz8wea1TLE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9ha9tgYRuoBFPlmgH/GmCX4V2f3/z1lLe5OYxETtUU6JYMHbl
	+koy94zWH2G4RAN6LV62oqS02/yMyNGtayHfWgtgk3JmdkpEBpjoh0X/TmuTIUnC/h7GRAblAi1
	Yep4ZYC9DYcrHyP0qjQbVT6r60hPbuNk=
X-Gm-Gg: AYBFou1a0WidELJnTrM9wVvMMnlNiVgqdet0SOZhI4mf9wQobnouwW7VndBLcxVFIvS
	NTAoWrooU4NmqNpRcC4wFI+xkiIymP9iZpCUYeX5qFHOyFlc5ulPhfkj5Xo+HW//141xx7GaRJk
	t9OBilzmynTTgkOm0LyLRQqUD62Jr8HzQUgjmOL81KLRm7vQ8cI/E0pMj6aJkM7tk/UENUippQ1
	lOuBoB6/6m7D+TDJBVWMRfspEABkajig5DFlu2wZfR0t4OqvS6tuuV8WgYnN7caP9C82UnEjRhw
	SnRVxZ8pI4J5MUQTG4Cow8QIa0pzKvk+OauqE692beO3rgcXs5fDnvoskzIbA8Wha7HXFIoq1yx
	+zoHIO57ik4k9mwESlpn6zB95Qfi083LkSfYRdZU/Dql9rcTnpDyN9Sc9Gh8ZYcXOm+A=
X-Received: by 2002:a17:907:2d93:b0:c26:19de:9aec with SMTP id
 a640c23a62f3a-c4d6dd8cb24mr224378766b.43.1794199307082; Sun, 08 Nov 2026
 20:41:47 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005001143.576737-1-rosenp@gmail.com>
In-Reply-To: <20261005001143.576737-1-rosenp@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:41:10 +0900
X-Gm-Features: AclHuK-aAUizeCRuM8WnAlvp8mvibSB9oiekBPg9ucUpGQvhhZ0l_iKHx8QZ7R4
Message-ID: <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: gsc: allocate formats as a flexible array member
To: Rosen Penev <rosenp@gmail.com>
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

Hi,

2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:11, R=
osen Penev <rosenp@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The formats array is allocated separately with devm_kcalloc() and only
> referenced through the gsc_context. Make it a flexible array member at
> the end of the context and allocate both in one go with struct_size().
>
> Annotate it with __counted_by(num_formats) so the array accesses can be
> bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
>
> Assisted-by: LLM

The allocation and lifetime changes look reasonable to me, but
Assisted-by: LLM causes checkpatch.pl to report a non-standard
signature and an unrecognized email address. Please describe the AI
assistance in the commit message prose instead.

Thanks,
Inki Dae

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gsc.c
> index d9637ddfcfc4..f1807ef664e1 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -99,7 +99,6 @@ struct gsc_context {
>         void            *dma_priv;
>         struct device   *dev;
>         struct exynos_drm_ipp_task      *task;
> -       struct exynos_drm_ipp_formats   *formats;
>         unsigned int                    num_formats;
>
>         void __iomem    *regs;
> @@ -110,6 +109,7 @@ struct gsc_context {
>         int     id;
>         int     irq;
>         bool    rotation;
> +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_format=
s);
>  };
>
>  /**
> @@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev=
)
>         struct gsc_context *ctx;
>         int num_formats, ret, i, j;
>
> -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_fo=
rmats);
> +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats),=
 GFP_KERNEL);
>         if (!ctx)
>                 return -ENOMEM;
>
> +       ctx->num_formats =3D num_formats;
> +       formats =3D ctx->formats;
> +
>         driver_data =3D device_get_match_data(dev);
>         ctx->dev =3D dev;
>         ctx->num_clocks =3D driver_data->num_clocks;
>         ctx->clk_names =3D driver_data->clk_names;
>
> -       /* construct formats/limits array */
> -       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_fo=
rmats);
> -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats), GFP_=
KERNEL);
> -       if (!formats)
> -               return -ENOMEM;
> -
>         /* linear formats */
>         for (i =3D 0; i < ARRAY_SIZE(gsc_formats); i++) {
>                 formats[i].fourcc =3D gsc_formats[i];
> @@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
>                 formats[j].num_limits =3D driver_data->num_limits;
>         }
>
> -       ctx->formats =3D formats;
> -       ctx->num_formats =3D num_formats;
> -
>         /* clock control */
>         for (i =3D 0; i < ctx->num_clocks; i++) {
>                 ctx->clocks[i] =3D devm_clk_get(dev, ctx->clk_names[i]);
> --
> 2.56.0
>
>
