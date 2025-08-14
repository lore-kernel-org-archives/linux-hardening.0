Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69602188A3A
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143766; cv=none; b=dOGcPW/qCzEWgDmHpBLBLGzizXMVd9IdrNBOLuHoixlsuZnDZnStYHfJ83XpkSW026X90D4PEbBTDlXlVWmO1GgItWVJhA4M2bIMxRI352YzwkRaoS7PskcLvpk3BSN7+NCILQdp35yBl0FNPk0cdAHC4U/5iSSaUuvM525i6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143766; c=relaxed/simple;
	bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA8qVF9u6Un0M/IBLym827venVZwcuWRAsFD6WpqGqM29EL0Wtj6XS2Ge8Co+z9EevTAdgbo4MbP8m4pJO6G8cIC9QhRD+Hb0ndh8pJtdrL7MwHE3ksnxr5Fa2qc41B2AwTE/kJpjt7PeNMoJpOfcVLemRTtRA/91+By/xRZIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvInC0dP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvInC0dP"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce5243f6dso522646e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143762; x=1755748562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
        b=EvInC0dPxLsxOgrcXaABeghM/4bT5PLVmE6f2aI+gEfPRh5bcJCK3IFSzB//2toRIW
         qsHUSOgJq+PQj9Yw8ZwlWorNd/cPgDsXGTxs3D1Q4OZCWZN3kL9Xhmrk8WyxYsHAGyHm
         e/jNSSc8EsiSs9zykXjkkGMzt/KMzDxyZTVOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143762; x=1755748562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
        b=SppP8j4eI5gJN2Pf5Qewr6RyY32SQHnIfpAn+/haVvDfXNzkN94vDjsv20kW777yWS
         euB5mb9AAId9QWqZbEGOgxLDFuSOO1md/nWbcT2ycXE+iAutKKukbqWlAvkXx7zLPIR4
         FgW052H9vqGz8pX4md/Q+Sdhk3xTXm5xFEQrjVfyE7AqVI1nR4/jBcDtIORe4Po1ZiAW
         oKYygLiz23mXaAdIRvkfceZOg4FxdViPEWnEJk27p/P6+RgXHiblohX4hLeZMszKmzAg
         BHOH8VTuoz6EEVMVx9QrAbKqBAyLs44XXoL+OnEu5mKhODR3GdU+ysalywM+RhivvlBi
         I0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUqMKy9YFVfu+981+JaJruPduSXwnYp4C/MZFHHIWFxiG8JZRCv4ZfpRCbYwLNdvwnVqdPJrzx0iK1rS6+2FPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERpR0zug9gEaA8EmkqtD5zxS+V3zJ+n2lcARzgYTlm0T+HFZc
	FOsZbYrHsG23dMFV1WX0IMEpLk8hPEduoaBhbujhB2LhoUkwt4ig7Li3bJOEZM5H4eP7fKA96/F
	e4RLqhPwvunSLqiUWkjuWvnEI4JkGt/p4hWnZIwq1
X-Gm-Gg: ASbGnctUt++ylrQlBi6Zd5/7mQ3s7QLEqnYqN56JKce0TMc9lRDGCamHIrzzqxJoe7A
	7ft9bzkXNDGevEKTLJzC28EYjDoaBK8JdUmhmQyJH3bEURPw/K8GYdFcYospbQ/kkXeehdoXAf8
	cRyi+5igRkQ+cZlnFT5qyCICnWYQZilSZXry9G8w/HeTxwF4Qk4akUosVrsBGb/ySVKgTKBAqQ4
	mNUk/8UzXcgpyEZUpk+To+ploFzoyWj5zWkp+BH8Llvdw==
X-Google-Smtp-Source: AGHT+IHQMv69+04AP9otNVcxhwI8uWKlLmUkdvXFQ1PCUQkCenB9LDrLy/Vl+cHfeBSUvo7zV0jpH3UAnLNxpErRIuE=
X-Received: by 2002:a05:6512:4406:b0:553:2868:6355 with SMTP id
 2adb3069b0e04-55ce4ffa5f7mr485589e87.18.1755143762579; Wed, 13 Aug 2025
 20:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org> <20250812-pinctrl-gpio-pinfuncs-v4-5-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-5-bb3906c55e64@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 11:55:50 +0800
X-Gm-Features: Ac12FXwQl-cvQ51JsCsvzfEY1EzqeHLXUhAtiyz4lnmgFYbrRneNtPbyaTw1wc8
Message-ID: <CAGXv+5GE4eUjMhewRm9oa+GbJWt8tMC0RXvT0R5FEfVOAsJ3fQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] pinctrl: mediatek: moore: replace struct
 function_desc with struct pinfunction
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
> struct function_desc is a wrapper around struct pinfunction with an
> additional void *data pointer. This driver doesn't use the data pointer.
> We're also working towards reducing the usage of struct function_desc in
> pinctrl drivers - they should only be created by pinmux core and
> accessed by drivers using pinmux_generic_get_function(). Replace the
> struct function_desc objects in this driver with smaller struct
> pinfunction instances.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
