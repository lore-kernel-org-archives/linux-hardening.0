Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EF23AB94
	for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637493; cv=none; b=IKwzeKP6cmEXpv3vdTsVj6+wdowhaQRRDwRqIlU01ITqHFyvQOwQktJSikfPjcOQDluPPXmsHI0mhF6DSU1qA4KZUYDO7FCRUDzXjAHnZAmbGIYRUbIryYtR/ufYa2YxIlg2oyNgXtxMsygjyFe1Tw7QuzxnuS2gxKvWszp4Lsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637493; c=relaxed/simple;
	bh=eWihz0z0JIQWHYGwcOUGrAJbU4ImufZBgs86/4aLMoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrQUbLmzvTfJDDaibXjZBLrouv87IwgxbM6QV5X4vrQAaqNI5jRgWPAoq4AJzZf4K+PAChPd0J6zDadNdaJEEPuEbMn2z1Ul1zDRaaeJ7PyVjLNlIUWJoyJFveR7YsgalBziV5Dr2BRRpNmXXkhNx0TrwNxtqYLcA6ppstiNNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHxBtCsi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHxBtCsi"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d605c6501so39629987b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758637489; x=1759242289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=pHxBtCsiBu6wl15vhgceu5NmjwRm+WSuT4nmlU5xbJbgXM1CC+V7h0looIg2TWOXi2
         OWbJKH1lsLgMoGVbgtowHpn3x5VR9zXRAapC47D4/fspdZm2gIhOVgcI6ZKlS8M8k9X3
         VB/82nY+g6zZu6cl7Th7tFTxCw5fq8fUZbrG9PdIl1xYFyWTVyijyjYlo0AMV4OQvmXM
         a60l/I7BMwPBgKOdDQTAhP7YZi42jfEgLQ/xbu1cWGA5vEWDiwl3n+reIX5MbaB8Re/k
         kzPhghDlKOruwJvtm0xM4q5U8imEjK+Mq7gpxqKfmnNG6ugZJrJ8zItWjQFI38DShext
         h+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637489; x=1759242289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=BYAbhxCyg3Apd9T6EMClnEBGHonj0JpBDbeuSgX/YKcP9fZIpEPPrC/MJ0KkMWH0R/
         XaNP/qNluNUo9b6ZSNoGn206tQmyY1aA6EHi9elAO8VQrr6WtpkeA1/roli2W5/N3Cap
         XnXrYLdCYbX1MCe1pxJvvsao/+26qu+4EJN1FB47nbYabgZ8NYrvKDiYpQQxNCwj7wyE
         Ir1FyoJJN6fWH+79ug1bGd9DJq5hAqlYul5De4UW2t/l2GjNkM1lmBDDwQDMxtR/AkXk
         V5sW2zcUEVaWmR/re7iPJKGt+G93P+pSadViGCFtKXV6xR+9hmGz+Rkq9ij8BvUbWWyL
         GqPw==
X-Forwarded-Encrypted: i=1; AJvYcCXASwnQDlYXD3iPInzQPgqkFKhv1MJPTFQjxyD6WGoOFZeKS9L4qaAE3Lo8yWo9N6H9lCmXkSn2jYH1cbGRz2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSu0lWL1Uske6NHH2ke5rcIvVhEfRQRxPKCaHki28RxZM7o/Re
	iv7SZsT3cQVGI2qf4rUsvl8Pdp/jb1EPQKgg4v9N1fs6rkBvUKq8DnbuK8ws+lHKHXFidUjC2XB
	Zs6cZx/a6k/5J7GqO/rdObSKunC1vVjinfdWB+/tMgw==
X-Gm-Gg: ASbGnctA+MqayXhB8+KgAaCWYzVl2iKPwWpNVG68ClcSvlnYaA0pzeHswM71oL0xbs5
	tuUKa/cXu3NL1uctvJPutMlB9bVmgFz3XHvj3uhCYAIxewKJ265t7fsU/hnrBE1SNC6dAOSCZB4
	6s8RJA8BrAgW/wyUdvtHEXwcvyHqJyaNcjXJrCvoRVK5wwNIJAGXBwWUkfXl+CV/jKM+OWlVvf1
	2Qgbm41g+RMxQSWHx8=
X-Google-Smtp-Source: AGHT+IF1FCtcjMSOAGh57xMvLkahzg1nEGPiVoAht6L/S8rmvuZxjp7LQD0zrTATTe5JO0aUrJTq9dOrEPI1k3shK8c=
X-Received: by 2002:a05:690c:5511:20b0:720:5fbc:20c2 with SMTP id
 00721157ae682-758a5393f77mr18808297b3.36.1758637489554; Tue, 23 Sep 2025
 07:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com> <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
In-Reply-To: <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 16:24:13 +0200
X-Gm-Features: AS18NWC-sVzrTkGqH5gpcO5QSqPC0ul4k36msuT8kehXNT5ngXXnGDzn6xEf6ew
Message-ID: <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 13:41, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> integration silicon is required to power on the GPU.
>
> This glue silicon is in the form of an embedded microcontroller running
> special-purpose firmware, which autonomously adjusts clocks and
> regulators.
>
> Implement a driver, modelled as a pmdomain driver with a
> set_performance_state operation, to support these SoCs.
>
> The driver also exposes the actual achieved clock rate, as read back
> from the MCU, as common clock framework clocks, by acting as a clock
> provider as well.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/mediatek/Kconfig            |  16 +
>  drivers/pmdomain/mediatek/Makefile           |   1 +
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 928 +++++++++++++++++++++++++++
>  3 files changed, 945 insertions(+)

[...]

> +
> +static int mtk_mfg_set_performance(struct generic_pm_domain *pd,
> +                                  unsigned int state)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +
> +       /*
> +        * Occasionally, we're asked to set OPPs when we're off. This will fail,
> +        * so don't do it at all. We do foo != GENPD_STATE_ON instead of !foo
> +        * as to not depend on the actual value of the enum.
> +        */
> +       if (mfg->pd.status != GENPD_STATE_ON)
> +               return 0;

Returning 0 here, means that we may end up never restoring the
performance state for a device and its genpd, when the device is
getting runtime resumed. In genpd_runtime_resume() we are calling
genpd_restore_performance_state() before calling genpd_power_on().
This is deliberate, see commit ae8ac19655e0.

That said, I think we need to manage the restore in the ->power_on()
callback. In principle, it means we should call
mtk_mfg_set_oppidx(mfg, genpd->performance_state) from there.

> +
> +       return mtk_mfg_set_oppidx(mfg, state);
> +}
> +
> +static int mtk_mfg_power_on(struct generic_pm_domain *pd)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +       int ret;
> +
> +       ret = regulator_bulk_enable(mfg->variant->num_regulators,
> +                                   mfg->gpu_regs);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(mfg->clk_eb);
> +       if (ret)
> +               goto err_disable_regulators;
> +
> +       ret = clk_bulk_prepare_enable(mfg->variant->num_clks, mfg->gpu_clks);
> +       if (ret)
> +               goto err_disable_eb_clk;
> +
> +       ret = mtk_mfg_eb_on(mfg);
> +       if (ret)
> +               goto err_disable_clks;
> +
> +       ret = mtk_mfg_power_control(mfg, true);
> +       if (ret)
> +               goto err_eb_off;
> +
> +       return 0;
> +
> +err_eb_off:
> +       mtk_mfg_eb_off(mfg);
> +err_disable_clks:
> +       clk_bulk_disable_unprepare(mfg->variant->num_clks, mfg->gpu_clks);
> +err_disable_eb_clk:
> +       clk_disable_unprepare(mfg->clk_eb);
> +err_disable_regulators:
> +       regulator_bulk_disable(mfg->variant->num_regulators, mfg->gpu_regs);
> +
> +       return ret;
> +}

[...]

Note, I intend to have a bit closer look at this soon, but I just
observed the issue I pointed out above from my first quick look.

Kind regards
Uffe
