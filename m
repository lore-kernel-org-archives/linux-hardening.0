Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252D2264CF
	for <linux-hardening@vger.kernel.org>; Fri,  3 Oct 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524474; cv=none; b=Brdox/bHYOw0kP4C2hnMRWyWKJ+yy0qdUQtEsThsKyk3r6Jzx4hcJD+2+JwMyd4ze2VhShPGZY0hIfoRhBwPb2WQaHhWh2rxofCTQcvhPvXxurc0xRfwbd4LEUCeEG3vG+nRKTw2rnYhImRvrocjHqcWBo/ujwad8W9wu7LfFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524474; c=relaxed/simple;
	bh=MHoXLWg3HvpW49PRCoLLv1E052ODwx10RLVlPGCpiHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syrxWYyIShauFm1mRqy4GwN8PChRuymlbh8bl/RybbU8/Vekr+nxWzoVcaN/CsKBimSaze4BpBb79+7zgSCiDXnW/bmjfhQjUrRWyvIqcDiO73TbmyfTMNKG2uvcOdJb3fTEqra7qE8q1ULwMeU9Px6M2hBEX4UVkZA1vbTVSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlKvIP96; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlKvIP96"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603acc23so30708757b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Oct 2025 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759524471; x=1760129271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=hlKvIP96ETlMNTcctkUps4Rp3bu8GayWk1dye8kfWKZeJmZPrn2xu5PWNK7tcDcnca
         8J6QOoYZz/UczJ53iUQ+ODjzYaCL9jCFbfKm5I5zDM/Y0qY8SHgfjS3ANDkQR3I7BV0N
         YTiCQm7+Z0opwMD0G7QvJa1N6+eytVQ5jmmM9pdfY+7uAEARJ1egzvqFrmhpoB+QmYwW
         L+pOCGclpsgtNd3b1VBcf+8oB6iuUAE1kC7KKnm9nXNMHV07GGi+b3wgj0JmqB+Vm2ZZ
         M9/8wI00qisEY3O42//cOu7x4TKc5BgSKtFRDvD63/pV2RGbhLo8fIoflI1ej5TRnpv2
         95dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524471; x=1760129271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=rhBsP3Ok1itfUOL6MJIKSY+zwbttZL8v4JCyyyk9Rm0oB5wZXA+qG4aHq2D6b70D5D
         smZZYpAc4lue1WxNyGRiQ4CC/FgURw2k4ZqGmZbUSctww7UEYUpSkR84eL4Ve74g2Wdw
         2SpOGodhjSO+w05c+tmOzdi6QUe8cRRhNQbsfNT66OZONGF73xHRUHCNbK96EjrEJI8/
         7FX6d8jZMq37n+M9wBDgiTAiGp2WN5fdisBnySSuHenZBbDha2arc7zGcb1n73yQZ4DD
         4kePKjnOKLsziTS2MvUz19eLTPC1324oLGmyan8BS9sRR5rs1KlicKsGOLUAGumR0W6t
         rN8w==
X-Forwarded-Encrypted: i=1; AJvYcCUUWCXInyFTfexROYFpUN400lM7kkrTZsihgSkbuM6YnKKm0ACs5O5rnAeMSfC85bbP7vaj0ccPt3/CAvv7Q70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaaLqdArPGWce0EdgL2149PqHnsIJ/rdRIXhqGfmQ+HfsNqBs
	qKh/RgKDU9ue7VhgzM1SgAUd5w2iSwCPkqXrbXybZQBtt5WG0G8TPbkubULA9hM8BIHkO8WEjV3
	uCJtdcbzmVHPpptKTEXiEtyfAfiL36EE=
X-Gm-Gg: ASbGnctym3aCovdgQC9WF8Jj/dSM8UgH40BuzibElbzuG/S+0eL4nT/tqEKmntQY+1g
	d1nbu/Oo69RRrtn5N3skJT2e4/t1cR6/JGVwL/krxEkiSjM2Bf9qWCDw3ZS1f6xcR8rOgBhWSiC
	0IZngkrsNpTNcbuBsLZh3BYjnD2RCwyJce4OX/q92MrYVjmtpaAFxNu5eY5wtyX8G4OeR0HLJ6r
	2G6ct0OCFLbG4kviGtxV6S5GyApTVgy2wbVnHtF312AUWMeKkSJlnTLbboFqagYuO06vQKycoQw
	T3GBQPJ43IBT0Uyiz3ZFQQ==
X-Google-Smtp-Source: AGHT+IGbRtPbh98BClkNFwaUaMJb45w8kt4Jk0KxRGScag36Tw0xGWcnBknxDwxYEhQPRsDsxQjX2aqyBPDcA2KuG7Q=
X-Received: by 2002:a53:8550:0:b0:638:53e9:bab0 with SMTP id
 956f58d0204a3-63b9a0ee753mr3639824d50.24.1759524470895; Fri, 03 Oct 2025
 13:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com> <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 13:47:39 -0700
X-Gm-Features: AS18NWBGD0pXXLOymrZv-_f8nOh4HIhBGy-SAER5xKOoIW_DOui92j81TfsOhUs
Message-ID: <CAPaKu7Q==RvuZR-pgJekF++Y4HOdkryEvYV8QGJd_os0_if_vQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] drm/panthor: Use existing OPP table if present
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On SoCs where the GPU's power-domain is in charge of setting performance
> levels, the OPP table of the GPU node will have already been populated
> during said power-domain's attach_dev operation.
>
> To avoid initialising an OPP table twice, only set the OPP regulator and
> the OPPs from DT if there's no OPP table present.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 26 ++++++++++++++++---------=
-
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 978f193a2aee561fadd9a976e9b1417118260889..6beb6170d6eea3dd65880dfe6=
4a61abbdd5f08da 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -143,6 +143,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev=
)
>         struct panthor_devfreq *pdevfreq;
>         struct dev_pm_opp *opp;
>         unsigned long cur_freq;
> +       struct opp_table *t;
>         unsigned long freq =3D ULONG_MAX;
>         int ret;
>
> @@ -152,18 +153,23 @@ int panthor_devfreq_init(struct panthor_device *ptd=
ev)
>
>         ptdev->devfreq =3D pdevfreq;
>
> -       ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> -       if (ret) {
> -               if (ret !=3D -EPROBE_DEFER)
> -                       DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n=
");
> -
> -               return ret;
> +       t =3D dev_pm_opp_get_opp_table(dev);
"t" is too short for a long function like this one. We should either
rename it to "opp_table" or refactor this out to a shorter function.

dev_pm_domain_set_performance_state is new to me. It might just be me,
but a short comment explaining that the opp table might have been set
up by the pmdomain can be helpful.

With that, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.

> +       if (IS_ERR_OR_NULL(t)) {
> +               ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> +               if (ret) {
> +                       if (ret !=3D -EPROBE_DEFER)
> +                               DRM_DEV_ERROR(dev, "Couldn't set OPP regu=
lators\n");
> +
> +                       return ret;
> +               }
> +
> +               ret =3D devm_pm_opp_of_add_table(dev);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dev_pm_opp_put_opp_table(t);
>         }
>
> -       ret =3D devm_pm_opp_of_add_table(dev);
> -       if (ret)
> -               return ret;
> -
>         spin_lock_init(&pdevfreq->lock);
>
>         panthor_devfreq_reset(pdevfreq);
>
> --
> 2.51.0
>
