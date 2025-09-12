Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AD268C73
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717644; cv=none; b=cOT3G372yjoAOK2iuR/Pa5BTUwEyT2Pej5JTepzXl/OHcdavk/BGX+OIX4Tw76d3SmKH1r4QZEENrT8YtVI/qea6VCQCnAqyGSDC+3TV2RieEOpZ5+WCsvc74uj3LKJQ4CNVCEgmQ74sdZVZskL9tiwyZaApUCGXhK4lpQ6sUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717644; c=relaxed/simple;
	bh=MHrpa4Jwxgc+dQNTjUuLs2EeQFU4pffDsIDMZKMLqmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHD++LoO/9Q963qRa0tzvvPpZFLWHRCXX8fWp8oUmgmbeXI51PeQ5JZiuOixoRXXbtFhsuipZsNqaTb3fQy1zINIvlxdRcb4HC3n60cwQnNLiR9eqhDqbitZkJQaY26oD3X2HRKpn2QYQyIwDK4epk0beU1N1hrz2WEeI3e8kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PutVraYs; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PutVraYs"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-60170e15cf6so1684685d50.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717641; x=1758322441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/ALLDcBZ6nZwBY7ZN6L7gT+4ClMkunGI751uMEjico=;
        b=PutVraYsoT8gxPT4xt/376mhNjsh17LrtcO0pcCNQRGNVS5m5Q1WliSxIPEbFrayGu
         TgXJ+7M10CMLpAz64f/+YyNtvHzJCxwNO6iRD32fjXNIrDKaW68n9zp4tOd0v9ZV/z1Z
         kzJdu620IzX7snuNghL/mL/EfriWSy8vJWiIzX+zbh95ncUBEY4OwELqMl3pcNP55JL1
         KTfBuBP6o7eCrCzGduUf6nuAmTuYtmEKSL/Tt9eg8OaSlJisZ359ZY4oZzNkOeCVgdcz
         cS87zXcu8yKWLUybiIlpq14j58AgjUOauJq0jvcdh7AUSKuWwDrt16zeBjmGcMb65yZh
         ojMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717641; x=1758322441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/ALLDcBZ6nZwBY7ZN6L7gT+4ClMkunGI751uMEjico=;
        b=UlKrAuxEqERuVhYEaCU7r2m3e6j/yNzatz6ZYyCKwveEGzBvBQWGHh4rgvVh4QpXjg
         DuMcags7W7cTGnFVMKvY2iNUrI1r+xaR7X+kWzFWeYhMOxbyXCjG5NU9QJ65Z2mKe7Ff
         nDvKWtIcOS7ReqfZ6gdhDIa1jaasdHRhZ01cbr1LH3PO0BxHNXVuHnKqnacFNLQhgWpY
         8qEOnR6dqNFHXRI0jqHUMZfatlTzFHts1jlM7AiMxTY/nmVT3iqDD/jN85el3iADJIT2
         3Ep8y9T67+ZxogV2+L64OWX6SOssBzyoJsS+akXjA38k6+3hWgRs0cFIPki/KDMShYFO
         gBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVxJttx0zA+yTdHD9Im1ZKB50Wjd1445sP7vS5sXDBaOvohBhYG/n2kyezZRn9IHYweJqDC2E+1CBCccCqkwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQBDs7OeIx/7Nc9p6/ggsiL1r7SeasxESf25q3H3EoOcXetyg
	sigJZyAV9cGy9DxBr1XriCfbxJZoWtaUtHmMMGmvLNBwdCG+qqNk5jRSsAbaXEt4kvL93+Qjyuj
	7+04rx4tmSBnpUyDzvefHlt6+2xHPG5U=
X-Gm-Gg: ASbGncsu/LWIpYy8XRfy7yrEKLFMPyd4DQtWlTAcQSuBBHpDvv8VcHuMfEVz581+762
	gPHpkvnq+gh8nH70vQ8WLbRlwvKFGVxKnE1WHgIhlNxDZv4CfcdZdOJ8H+GI3BdJrvMNPrfR/qN
	T+SJiNt5pJ0xLupxumlgZz1rI7wSr5F+SAFlmX/cWt8yjjGOWauVA/WoiUN2KT8ZqIAfJcUjiG4
	7uU3PuKHZu9r6QvJvvULKzi4VAJJW6xVOfeq4EWbkkCnXgkpP7DExAzTt+XFcu3zwn1Xv9ubbPD
	j9SFtxY=
X-Google-Smtp-Source: AGHT+IGmrPKfHKqLuLVsedBSU1D7fMJ0SPSt1pUu9IK0SCtyHO6OiaCBaQyBDxty6OWXlqg3nf3oT3Kb2tAQnhUAUk8=
X-Received: by 2002:a53:7101:0:b0:626:842f:818c with SMTP id
 956f58d0204a3-6272297979cmr3570059d50.24.1757717641302; Fri, 12 Sep 2025
 15:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com> <20250912-mt8196-gpufreq-v2-9-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-9-779a8a3729d9@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 12 Sep 2025 15:53:50 -0700
X-Gm-Features: AS18NWAVsbHM7asbGyyRZapaZP5ufrQUasUcMY0V45b2pm9dui9MQp5I0XZOq0k
Message-ID: <CAPaKu7TEN++z8r68k_4-iCyMLMthqJBUX35pgXupAHPdfttrYg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/panthor: devfreq: add pluggable devfreq providers
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
<snipped>
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/=
panthor/panthor_devfreq.h
> index a891cb5fdc34636444f141e10f5d45828fc35b51..94c9768d5d038c4ba8516929e=
db565a1f13443fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -8,6 +8,7 @@
>
>  struct devfreq;
>  struct thermal_cooling_device;
> +struct platform_device;
>
>  struct panthor_device;
>
> @@ -43,6 +44,19 @@ struct panthor_devfreq {
>         spinlock_t lock;
>  };
>
> +struct panthor_devfreq_provider {
> +       /** @dev: device pointer to the provider device */
> +       struct device *dev;
> +       /**
> +        * @init: the provider's init callback that allocates a
> +        * &struct panthor_devfreq, adds it to panthor, and adds a devfre=
q
> +        * device to panthor. Will be called during panthor's probe.
> +        */
> +       int (*init)(struct panthor_device *ptdev, struct device *dev);
> +
> +       struct list_head node;
> +};
On mt8196, we have performance-domains to replace several other
properties: clocks, *-supply, power-domains, operating-points-v2.
There are also quirks, such as GPU_SHADER_PRESENT should be masked by
GF_REG_SHADER_PRESENT. It feels like that the scope of
panthor_devfreq_provider is more broader, and at least the naming is
not right.

Another issue is I am not sure if we need to expose panthor_device
internals to the provider. mtk_mfg accesses very few fields of
panthor_device. It seems we can make the two less coupled.

I might change my view as mtk_mfg evolves and requires tigher
integration with panthor. But as is, I might prefer for mtk_mfg to
live under drivers/soc/mediatek and provide a header for panthor to
use in soc-specific path.


> +
>
>  int panthor_devfreq_init(struct panthor_device *ptdev);
>
> @@ -57,4 +71,6 @@ int panthor_devfreq_get_dev_status(struct device *dev,
>
>  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
>
> +int panthor_devfreq_register_provider(struct panthor_devfreq_provider *p=
rov);
> +
>  #endif /* __PANTHOR_DEVFREQ_H__ */
>
> --
> 2.51.0
>
