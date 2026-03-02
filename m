Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E852E8DEF
	for <linux-hardening@vger.kernel.org>; Mon,  2 Mar 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476269; cv=pass; b=RzcqqwPSyVrsauK6S3a8F3RhhvH2eJV/BRFL1PtCa3YyPRuxfm8otykeQieapDpxaIEe2BgofdiRxLQPRQSllmmWpmFxmSKwKZ0w+RGOZqsip+at0ssRIs0JcIZpxSYomulB0SJoLsgKUf8N9mQI1Wwop62Ao1neoquzkCZSXFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476269; c=relaxed/simple;
	bh=kt2T9iC2Y/wd08xI3GU9gJHg4i4C2OvrhJg73KQ4pds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeaNplEc+S1Z9J+pBsCMWY2Z4/zwPgZsCmmFaMhxpXb8vwyH0Lk0dAeMrX3EkforhxBRiLPgb9bdd+IWkBZZ/jF2lAJU4HmpezM1YrrFKfkoJzRVtIYAzSYbLzUmB7vxE3zmXcOPruiiPtpEAE++5czG+jqnqTThNSkc2cp0CBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IsfZWYW4; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsfZWYW4"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64cb577e79cso4807331d50.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Mar 2026 10:31:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772476266; cv=none;
        d=google.com; s=arc-20240605;
        b=GEkuQ/3jrN86FDgWiZEbBnyx8iAaJFIOD28f5H9lFWsVqZF5DoUHy1ydYdYA4N9X++
         C6l2s3Gq4Rhj1A+mVIVNoTbtOTJfIxnnuoZVbXfuo+DzJ2k+AGe6vVuuiE2BKJSuxRLy
         7sGNx1Aid24j7RTAjh6nCNY1yP7iNRbzIixAI70vfRKAgClZhcJU8nRSqgklYaucXxt9
         QsnzjudiMj7FVDaxaXwQ+YFQIaN2NmbpLp1U+DIugmwnvuhLirhq7mKEb4dDWM7two0d
         VgTwr0B56c8NL1m0qKHFlGO5dMYwTHynZBEjnCrPuo3O2MFQTtDz74AjlmNVjf0+Zicj
         e94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=81g1AQ9LUBvNGZAcgE0oE1RFZWKZ81udvij0ADF9Goc=;
        fh=HC6KWeKWBB0WYoRuTQ209EQwMglxVFZBJieVljobzas=;
        b=kHSze61KuHFoeoxt0nfYV3/BYwcgdLJmgSAqpAFNQFs90f7ShtjbKBjqgh0Lu5DRn/
         01lBgBZ66saZMzCnea1MUTu0P/ren4wJ4XE3+ZnfhmJ5+DBvLT/x6gbZbXQI17xrBeO6
         CpwFs/dsWD1jj8zL+Tda4mvZGX+YvWmKsZGyyVsaFU6UGWtSMKZwYjzkCpxzl/pwbg6j
         gRQkUgUqLx7E6BjvgR/bZEmadrKC6LSVdjmT8cUuy/oOXdqKmuCvA+DyRl30fWMpYvmT
         iu5K+VPBR3shaf5Od/cDucxtI5Wng8Lvw30ZMED6jMjWsBs0Ezobr3C7Z09OXi/GNoCf
         RZ4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772476266; x=1773081066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81g1AQ9LUBvNGZAcgE0oE1RFZWKZ81udvij0ADF9Goc=;
        b=IsfZWYW4jZJ0ZN6TNJlkST4AU6gR+cnISCt1N6NZwSy40N2iZ+pY5KinFwN+vZUyEU
         DqmETpflSKqPtOnA2Dx0q2Be7tRAqv28/eouzOON68SCBUQwa1m50LEquroKh+jSSvkw
         JtDPAhSAW/L8akw/EJUKgH6BLJBPJ5lUN2eucqN+qsWqXlVJVLappLXdpl2YKgfzWk7C
         6RInREWG/HWugItMpcTiwTcVWaNcoSxF1x2utlSnMvjeQn2MK4xa0MoJugW3OtkOqi+I
         UlWf99I0+NY5idT6SgvJxVhJ5Xr0hOJihlbk4XedAKm6DexdTVUOV7cz927PWArNn3cI
         BXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476266; x=1773081066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81g1AQ9LUBvNGZAcgE0oE1RFZWKZ81udvij0ADF9Goc=;
        b=dccV13zjwyMsscLJ/4idAjXBPwjd3qK7Ud+EeBjPSKQ+U4ZKl8gw/Tu8lHuqN00d++
         qqwr27x8AIN7gDpHa1xpC5MYhulm82umRfN0kxCXNYeVSFXJS2+SkTUeeOW9uRvWW6Jz
         JxW+e5mkd8RtGw7zM/2AWlbZ0ts+N+4ogZGzc6Rndiq/ie0zMN+A3cnJc4T0emAS/GWj
         I9aEijGP/nELVuiw3pCsMCAz2Jjk3ygZxLKsxykU7EG+yyJRux1fq/0pPMpuuGHDJQBu
         62kx5h5uIIW8hfLls+1x0DQPt0hKJCXW9D3wAa7eXTfhv35IIdHyG1uWU88Sk/mHVGhG
         T0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVEDGkhJ2e50qwcPbGND6HytkX+UdP1wid4upNP+KjtmZWrGZshhalkOowmLOkbGq15U2rwEEWAP2Q9rgV3y1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHzZc2BmzskXmdQ+PIbduy2uJQpF3fd5rXUwYI+5ntvQFj3tN
	At02h2J6/KRef1DEsPIJZzXtBpZ+UiI44sux2UxMKPVG5HiHVpYs+uigJI6o1TO8G57LRWga5kn
	G2ZLOc7LsJV+kvnA/IoHKQX3unaLf6+cWlQXC6C2aIw==
X-Gm-Gg: ATEYQzxiranwMWYv4bT4D6T5xsPqonasbd8s5f42Ir3GWBUWX3UnHHJyOVplXt1eHq+
	sl5V4KwYuB+2M49ABizrI8OC0tlT6AhMxoBbSAytps5EMqh1geQHioCezlpUNHbsiBa2DHyfKrO
	lNtR7q+sHoiIxBYcL3E2US5W+OOu78q1cNyg8SkmUENGbZdpg4YOoOEYIt13DqHCZEEu52LCcoF
	gsVNqOyCtqoheKZ4mHSGXrAOuHMK2Ukk247S3dzFAhOP2+l84DuHN860CWzYHhBN9qyvrmYR7g3
	zA77QcRViDcas6QFogeBbi75D34yXuXX4Da6HlB1TL4STyJ+s1O+TwsY7xPV3ZplVQ==
X-Received: by 2002:a05:690e:2060:b0:64a:e1de:e830 with SMTP id
 956f58d0204a3-64cc2025a5cmr8768669d50.16.1772476265235; Mon, 02 Mar 2026
 10:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Mon, 2 Mar 2026 18:30:54 +0000
X-Gm-Features: AaiRm515e3WzwnsMys39sfPXCKSu89p0-qrgz1al4LhQ_1OobhhtPkQJhg_LdoM
Message-ID: <CANgGJDpjsyoCnuXuMMi1L3nWNJsM4aMs6C=NvBcTkWeC3NFadQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Sun, 1 Mar 2026 at 02:26, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

[...]

> ---
> Tudor Ambarus (7):
>       dt-bindings: thermal: Add Google GS101 TMU
>       firmware: samsung: acpm: Add TMU protocol support
>       firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper
>       thermal: samsung: Add support for GS101 TMU
>       MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
>       arm64: dts: exynos: gs101: Add thermal management unit
>       arm64: defconfig: enable Exynos ACPM thermal support
>
>  .../bindings/thermal/google,gs101-tmu-top.yaml     |  67 +++
>  MAINTAINERS                                        |   8 +
>  arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 209 +++++++
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/firmware/samsung/Makefile                  |   1 +
>  drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++
>  drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++
>  drivers/firmware/samsung/exynos-acpm.c             |  35 ++
>  drivers/thermal/samsung/Kconfig                    |  16 +
>  drivers/thermal/samsung/Makefile                   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c                 | 643 +++++++++++++++++++++
>  .../linux/firmware/samsung/exynos-acpm-protocol.h  |  30 +
>  13 files changed, 1275 insertions(+)
> ---
> base-commit: e2211f5d980086dd9fbdab3bcd86b715e12cae13
> change-id: 20260113-acpm-tmu-27e21f0e2c3b

JFYI, the series doesn't clearly apply on today's linux-next:

Grabbing thread from
lore.kernel.org/all/20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 18 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 20 code-review messages
Checking attestation on all messages, may take a moment...

Base: using specified base-commit e2211f5d980086dd9fbdab3bcd86b715e12cae13
Applying: dt-bindings: thermal: Add Google GS101 TMU
Applying: firmware: samsung: acpm: Add TMU protocol support
Patch failed at 0002 firmware: samsung: acpm: Add TMU protocol support
error: patch failed: include/linux/firmware/samsung/exynos-acpm-protocol.h:40
error: include/linux/firmware/samsung/exynos-acpm-protocol.h: patch
does not apply

Was it done against mainline?

Thanks,
Alexey
