Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D58F4A
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143874; cv=none; b=eMC5eU60Ak0Qp0j4fW3FfLwUWceJMpXN002gOIIdQosKJe0p5YnNEJ+alwnjpZbtlEZYOcV3kLd3IKBLY9gm7aUjyBp6iGvGjj0Mt7Z6/y+2eElE9ZPwJxM6nm+tOl3AeUGgPuho3cYu7DLpeIdNxK/tQ5udF0f3pF7ENUi+hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143874; c=relaxed/simple;
	bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwTDzz/D7xSdSyhw+5W1sq1LhuA1l7JKTCdW8RMAN5kNgDoVq2dvARDkRu4Yq4EmCqvNhIvAKLncQO/TLFmdGUFjcmZWa4UOR3hrvmLo5R4Z3YnIqPy13HGf4hvDPa4NTNSAz5NWkwtZOJMWa77ffIQykCU3ftruWThS7tA1BGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EKHSha6q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EKHSha6q"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce528022eso505038e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143871; x=1755748671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
        b=EKHSha6qdcBlsS3gXN4Cw+T6fWwdA1YCyfFc5q8C+8u6tYxjS3yl3WEbF+GocUde6a
         Yr4akzI6BV7tlc0LbiOXzgB/ACP7W21rMCxsdytPp7bq7N3Oot9ZRftp5aDUg4ZN4OKs
         loF7b7jyJYM9Acbf/YX0K99D2wwAo400Usa/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143871; x=1755748671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
        b=oM6QLAwWt56kZr9oFQhpyH1W/tW+kwk1QHsnFsA3l453/h3fhKSA6US/kg6kveWRgV
         wY3pguk2dQtquPUNF9+z9vXZKRpu3cocVbcG395M96zPo5hprrRFWLaCI3P/yDCHIoR9
         ZOt+28LvUcFHOcSC9Tp/FOi8Ij+Qhbw+wMN6mTWVGJCM0v5ttecKqEKsTBW6LgC6dSpT
         WZHD2qenrKOBdUnTpCPFFObkxO8cTFvZqmU/1XS0odqC9fDmviwhyYpT34GXnJ/6/0Gb
         o7zlo5LLPn86eURmWXQEK7ja2tPLr2otX//4AhiZ+IiLBbsvS32l3F3wO5Mxb1UiY4N6
         iTjg==
X-Forwarded-Encrypted: i=1; AJvYcCUL1J1KFyQL6R7Waoj9kzKi+Z8J33h/qai0ZJ/dcNxGcuQ+4/3HWri5xy/w2FMjoU4LnQ+XVYLkv6H2oKqg92w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOHJQG0gOBGttnMv4csdfgP5P+u7QjK3PZMsS7/ctH3stzA/+
	4V/rJVZOCTE+4BQEM5yFV8n2BKCgrkwm7v8iLMA8QJcn9+RDPfNptREbCkMfAKX9hH9V2E4ky/H
	zW5XUbzhVkWEHFxqbfYnXw2ZUZDgS0KeCExpm2f2N
X-Gm-Gg: ASbGnct5KWKBCMB5in5ydEaMapDKt8pOTjja7DEP+AY4wsja94AdZLBAr8pZpStaYvX
	wTsWsg8rSzCU87Tp1pSc+Hqdom3oyTudr9Tk3kkyJZePJML+zatH73GKeV5DDJxQV6qzoFKTAe+
	4DucKeqGdqVgPcLGBN5DTunlcg5mr9YpsTJCPlPSO1MmhKR9qbi+pYT9ERJrQJ7iaj5dOb3/dMK
	0ppe1Boe66JPSa2f2uqVlIv0OvjI24H/mW3myp1WZkVMg==
X-Google-Smtp-Source: AGHT+IF+5iKv8rMK9YHb6myK/q855kRCdUIsQfOlyE7uVil4m3zuwOKJ3gr0xAyECxLHg6Jl7SqsZkrMsfX9UPSHH2s=
X-Received: by 2002:a05:6512:b8a:b0:55b:8211:cc88 with SMTP id
 2adb3069b0e04-55ce508ddefmr488807e87.51.1755143871084; Wed, 13 Aug 2025
 20:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org> <20250812-pinctrl-gpio-pinfuncs-v4-4-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-4-bb3906c55e64@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 11:57:40 +0800
X-Gm-Features: Ac12FXwH4SzGC_raZvHd6w5DhOOOwcWIZ0DYC3dWkFgv22xak8lk2qDrshBunvY
Message-ID: <CAGXv+5EDj4JEKAFC-Sv8kyiBNy8SViEXaepdssG5QTu_HtYQHw@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] pinctrl: mediatek: mt7988: use PINCTRL_PIN_FUNCTION()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
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
	Danilo Krummrich <dakr@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have a dedicated initializer macro for defining pin functions for
> mediatek drivers so use it here.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
