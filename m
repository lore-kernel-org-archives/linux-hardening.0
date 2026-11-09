Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794198842;
	b=nc39bv3LLht4ntNX2wxdWevzpgYTGbTwbs0N3srzkvoDuFZSfUNpFM7vY/b2aniaYMcc
	 z20J6nOil4lwtS0sPKuuMORH6fq1lrDjG7SSJIEXM2hR639BAk/IKrpxZyOOP4HxDBYj0
	 KmbRgusHezsoIZ6eMfd6ZRG2xNqeAOMsKSvF0qCJDbFbf93XO+EVPU0sHE/RdRMFHQGN6
	 8lRIWzBfXv7rqdkaTOzzZz1P0lK4HuTHrhsjXKPObr5ZqltC9axy051i/Pn+rlcHs/WQX
	 0Pl4E/T+b+WX39XoO5afCUCqtDoA45gjvxqY0HNk9IRS9ZaUqZo661eQCCFHYXEAQXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
	b=qpw+xPzJrRw+6IQEwijYVT84ZjJK/QIOCZHNiMr6tgunaaRqf70DzNK1eT1vhiJ6Bosd
	 2pAxp+fCZh5TOgjO5S1UDnU0XhTNS5RVtzE8D2YJwHlccPfpSVWtdtpxjbg33GOr8fR1M
	 8QGekQkrzG3+g228Ja+g5JVAUTnvzWlQj0zkdXbx8Vpj9xFWCIckQYH6p49gLVChkl9OL
	 E4MzDvWcucZUR5zXlFtXjomMP4o5s/G+L1MJE+j+miudeqIa8HnW2onVSu/yuGyNMcYnV
	 UKCcgQPyjjsuMyGTifkmHWalDDipnCV+JB8mDbO6Mn5hN5PlinvkMjPtJF4YKLQNGOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE+TvgUh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DB606D801
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 04:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3DB606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE+TvgUh
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so59460466b.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 20:34:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794198840; cv=none;
        d=google.com; s=arc-20260327;
        b=ZqsURJ1E7yXZXFIsO2dpl76AiyINd7l1b/OeoZZE0d/fofMFMpooSUsGJVGyktTQvk
         Sq8DlKtVGpZiKsIRkmLQ2spC72RGtGLwZDtIheqdXRTBSiJcUnnAtMvOWjAVssdw/1y6
         n5EWzOfMZKs2qm/F4tyF3fcKSkrZAyuzBAnWWHNZOwKABMDQeE4/CqibGd51VZhawas4
         /AJh79a8DvSU/T+1kzAKJ3MAZdP9lHn8VhP9nOyP5uQVb6rIK6LLkNthRzz4xow1aigU
         AVVLWFQk8MC3AKNrhdy6mIJl/42KtRYZk9MuZEUk4UsWbLulkaNDQfsas38A50qIxC3s
         y+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
        fh=jZqGpdnAZMC2p6vMInuziNnIlGWPVw0qf0YuVDXgtRE=;
        b=k9UM19XiIRZmbbstjCrmcXKef3901AGuGHp7KFG/xqYwzi3LypnILgESaH1WwzfWwz
         oeJc6fyHfmrUysGSJ+2CguGgfA/RyPEd+eViqf5BPh8RZnDb3yBs1prCHRRxo8a/rMvC
         TeOpDPl4TKXvYv97OJirXsDC7aKGsw7G3ZeJS/gtSJnDzMW9+36D+OxCSWF75n3NFj2C
         Sa394AYgVoJr1z0dBFc2gJOCp90vbm/08SzbI4C56QfOuDnKqN0dicanx0XiQiwCqCo4
         4pdukr3Pt/VCqixmTD8NhKkhfZ5Ge61XHKCrRmEyEqbkqBywqJ/C8/t663iYO0Q5VkY/
         b7Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794198840; x=1794803640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
        b=cE+TvgUhFThTLr3JE+C1ZlQ+Q55N6LLNa0OrEiv09d8eghwiw2yMa6WZV12mkUrdMl
         6Mvy1LGFKpPerf4MWw5xwfnNBxN2q7iDFIUUYYvKZUI5mNWTU29YtpXqsIEYqb38YrVC
         87R94ilSNUWGde3/XNm3SoMTaPSPkCN/sD4icSKv0BxLBA0NndnohpeajtrujTTERf+o
         cyPO5iVi7O4afFUufZoGNOdUi+2WtqRUVXk7xsGwOd/glIUVjMg4D9DmY/t4Kk7N0J6E
         5sl3Ulzmz8xDP4ew87+pN+PBjCzZsZyUUn/faa1N5nFEUcx6Hbk6sgeo4HN371cKMSG+
         kM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794198840; x=1794803640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
        b=d+nfZiEbJu1lXiZhma9zhqTqPcXsp1pmUlYz5ujP97Ocmfk+w2sd14FC7DoO8rbMf1
         agM+F9SkumvHOtMs/gyz7dRjBsw51RSk+dpQnl5kK417ZdquZmFhOXz6FfJthOUetuca
         zffWnJIWC+GIX6J2cORAmZmDadYbDNoP9WiIO3qoRX0RyJInIQNvw3eWGcbZ6qpAkxnN
         fhYaFr/rg6rZUEGCZJTTEfFR9BVD7OmmF+YQ+PE/RBB8d9H+vVXYbRVKEoyOhT3nwkoo
         UubDO2A/CaD8buJmaUSgPzYuikla36P4F9YjWKQ2+hPhlp3dnwPVkwotcSIimkfXZBKP
         SFgw==
X-Forwarded-Encrypted: i=1; AL+hErGVWKQz1AnVlYlhy9RCWQ68NkvjYvvY0i27ZtfMwsc/pLT4VRqykz5dkGlNywsn3JwhWj1HUtLJiYM6OJNf4Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BLaxskAGA7yz1rKtRrZBmPGdmUVUJ+Pnq9b9UdhFLzyT6tOFc
	bJq4Go0+FMg3M/8AobTLcipIzodvTSOr8Ayd+5XOg+PU7X3tnqm6GhuMicde2yp8nH6pvHVEmOa
	EthT+4d8c23plvyBrQCjGXsFtEKUYP1w=
X-Gm-Gg: AYBFou21TceUWtWTglNFwV124OLlBdWlEhHrJSt/hI+rsUBeilsujhdD3N9N5WtxjU3
	l+lvNhCDczpLtPlWiD94w5OEjMp8L9Ska5RDlR0BlL55wb+YChQvqBVFrJDQo11WpwLTnoM4f3c
	yZgrnx6POs3XnuH7Kd7BTtuE583SPLbv4lHbCNSujqauQL0L+9NKdbWWKHlvNb5x7PRKY7yP9LX
	6qFK2g10pdP5emEK+JoRdMmCUfSnkNXUhKAtzdHpEPe/lL5oDCmkVFttrRT0GvNAoeCCpOkw0tP
	3r1b6dL8kJRLS4A2z0N3dH9D32pMYI31Ajw9ZmW6yX05TU4ddDU0oqsKv+nlt6Yuskb+jbBwUYD
	BXCvFUMW4b/FktyxxLbRh8hgKgSAscOsTtXIRcMuweiUErZanivleeZBX0AqERY1yyxozQ+w4yg
	PIyR0eLhW99t8Z
X-Received: by 2002:a17:907:72c2:b0:c2e:4292:d268 with SMTP id
 a640c23a62f3a-c4d6daf7c64mr226694166b.16.1794198840452; Sun, 08 Nov 2026
 20:34:00 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005001118.576198-1-rosenp@gmail.com>
In-Reply-To: <20261005001118.576198-1-rosenp@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:33:24 +0900
X-Gm-Features: AclHuK8JGFlUXZkSE5CgvPvR5Q5pqnVQnyO-MTmGLdNc0lY8Yjx1OxeFaWmjmHc
Message-ID: <CAAQKjZObmQm1X28cbpjd+dEVx93wfBwKNaaaxpU08o8JeFaZfA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fimc: allocate formats as a flexible array member
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
> referenced through the fimc_context. Make it a flexible array member at
> the end of the context and allocate both in one go with struct_size().
>
> Annotate it with __counted_by(num_formats) so the array accesses can be
> bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The allocation size, initialization order, and format array lifetime
look correct to me.
checkpatch.pl reports an error for Assisted-by: LLM like below. Please
describe the AI assistance in the commit message instead of using this
trailer.

WARNING: Non-standard signature: Assisted-by:
#57:
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#57:
Assisted-by: LLM


Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimc.c
> index 09e33a26caaf..079d24d0671c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> @@ -99,7 +99,6 @@ struct fimc_context {
>         void            *dma_priv;
>         struct device   *dev;
>         struct exynos_drm_ipp_task      *task;
> -       struct exynos_drm_ipp_formats   *formats;
>         unsigned int                    num_formats;
>
>         void __iomem    *regs;
> @@ -108,6 +107,7 @@ struct fimc_context {
>         struct fimc_scaler      sc;
>         int     id;
>         int     irq;
> +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_format=
s);
>  };
>
>  static u32 fimc_read(struct fimc_context *ctx, u32 reg)
> @@ -1273,20 +1273,16 @@ static int fimc_probe(struct platform_device *pde=
v)
>         if (exynos_drm_check_fimc_device(dev) !=3D 0)
>                 return -ENODEV;
>
> -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_=
formats);
> +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats),=
 GFP_KERNEL);
>         if (!ctx)
>                 return -ENOMEM;
>
> +       ctx->num_formats =3D num_formats;
> +       formats =3D ctx->formats;
>         ctx->dev =3D dev;
>         ctx->id =3D of_alias_get_id(dev->of_node, "fimc");
>
> -       /* construct formats/limits array */
> -       num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_=
formats);
> -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats),
> -                              GFP_KERNEL);
> -       if (!formats)
> -               return -ENOMEM;
> -
>         /* linear formats */
>         if (ctx->id < 3) {
>                 limits =3D fimc_4210_limits_v1;
> @@ -1320,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
>                 formats[j].num_limits =3D num_limits;
>         }
>
> -       ctx->formats =3D formats;
> -       ctx->num_formats =3D num_formats;
> -
>         /* resource memory */
>         ctx->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ctx->regs))
> --
> 2.56.0
>
>
