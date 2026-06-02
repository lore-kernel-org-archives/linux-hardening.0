Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD272C3255
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429774; cv=none; b=HPuaF9wP9WfaF3CTA99pbNyhr45dTvcnjqHJSis8yqNyLOxaMQ2D9e2mKcvk23rZAmcl2dcVSJmg6bDJyttZar8sAOkmM2d08JwWgrHP6ToMWd/T0KXbbGqlhzkyxQ1Y2ffZFhB79/UpnD3Y0TIMnRmt0OHzjrEZnfODhkrI410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429774; c=relaxed/simple;
	bh=oBaTI4c79O6vpTgtjlM41+/n4xq+WnG2e+IzVNiDbJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Pxs/PDZLAsElB+tAz7J1Q/Ew1UumM7coYUkaWBwbEU2mv+Rrwiiq/TRC3oj2W41xLPaLa19qmNlXC6nJ5ew1wj9/5rVbIZK9jc+ha8DVfBbmQhPNnfnqEDKxVDRJymXh+xDIDm8kSyURS4PJkNlkvDY+zipPY9l6vMqsx0XaVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIZL/+P2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIZL/+P2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b613a17bso549175e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780429771; x=1781034571; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uspwVvtiltCsqTff8wL3whaP7rrxXxnCkwg5ui4E/K8=;
        b=UIZL/+P2j+ObC1TFknmKvWW+pvVGOvQ65357KvL2WrRK7JuPiejBSgMapE/rDxmsf9
         vQILcjVvuz9mcx6E1ICApAYYjMFzlGOOWQbqcmi76iNBm42WCJHP90Gker3mFVCZO2Nn
         V659XeY3viIK9N55O9XUVVUFkj4O5rNzkGG9cI26Uf9LsxZtNJJf+uMWQNJw8YEsRTXw
         HywqDmVGAihaT2UNIbCuZlxrwfuw7wyA0Zb1HNSORb0bzPaP7Y9uOLd1KIf0xhlpe2GR
         1b+vT2YJZXOtMmWE3fLkOIX0ZmJUW6NV+7Cz9ANpq3NDWCSDl034azL3vulPAmexINHS
         5jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429771; x=1781034571;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uspwVvtiltCsqTff8wL3whaP7rrxXxnCkwg5ui4E/K8=;
        b=KM5wcmh0t9NQD8nDlgi7TtqlW88B5eoZm5rinLTiGer/vMcKrzLIg1gF3XBXn/rviE
         EC/CBzxZozsWrBj/fX3EvhK3urxKjAOPHqbPoDHTBF7Oa3wFpalZakX4r9so2uYmx+f2
         yq0UokwpiQpu8K7QDBKVHYSnUTbaBmQ1h1Emp4gpl8OoiXAIH8SFoHQltNjRIDUaOO+q
         CADmybHM64f0lcGKFHM7Y2hx/t5kckfVIqi9zL6m/Tz90IyROz9VkhtMpDfubu8sbMnt
         cDi0xGjhqVcegKAqHqZD06Hktx606GRGsx2fsV619gmplcM8/d+iCjcWjH0OFe8v374A
         ZQSg==
X-Forwarded-Encrypted: i=1; AFNElJ/BpwzBroC26fw3zjKCy3n+rerRCieUQiVZemlerYy+Z3JABoAFRMj/wZ/svOjJn68+okJvvJn513q4FhDfW8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBXv8/hlBya/TNyEXudxb7UdZ69WZsUwGNtM0/JppqkRYCUkA
	KDb7gFq4AW66Q0yC2ghH5yn/XQoLSRK8WGBpe1cOQy9qB6eAbR6Nar6dUQnJTMjkGKw=
X-Gm-Gg: Acq92OGKlGBWKb6CVAMJrwbo10eQTdnmKjOi8MT37/35xmXHB4qSFjdSYGfXM9W4G4T
	sTT8RDDVwhCeQ66P2TV0Tl21UD5HC9gnF5ramjtBaMHgxwgJLhG9IkevUlr1CS09cC5EtM3wx8O
	wdYBj8WKjp1O2tilpidMBfEwj8p3VeH75SmMzJRL/2qYDeDRD2WkOUXsXq3q1rUcYFkFSIKYsAI
	r1IBDYiXptoYj6HXFYkTmD5QEOOsLtBOuAG/i1Ledaltfj1aFy0AnU0vKQ/a3iFc46DirV+ZEGu
	r/EAYsV9cE4Jub7q5Fu2sa12AyF54LDWWux+w6ygSfy3e0ulVyZ1q1+NVll5yUgrWb8Vt11tkEp
	Ks103tT5O6wvBUF1uGOSQtomXh5reKODmljLdK4+aXU4vU5iZpuhhsUMtY/vvmBltlmLmHcg43l
	VXu7bdo1YOCxEdqAHiQTQxrbkBkvQ5HJxEd6Bytk9EH0J0yZ3yfv33AXN77vb9/DcK6/CaojSOM
	KB21JBSvuQpQYmqZs3GKw8ln2iqyBlfZ2Y=
X-Received: by 2002:a05:600c:8b61:b0:490:b1b4:d437 with SMTP id 5b1f17b1804b1-490b5d3e1d5mr4934545e9.0.1780429771536;
        Tue, 02 Jun 2026 12:49:31 -0700 (PDT)
Received: from localhost ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm3064455e9.0.2026.06.02.12.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 12:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 20:49:29 +0100
Message-Id: <DIYTOGU8I2DV.1GKZ59F7AJWTE@linaro.org>
Cc: <jyescas@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/5] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
X-Mailer: aerc 0.21.0
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
 <20260602-acpm-tmu-v7-2-8047dd54b0e9@linaro.org>
In-Reply-To: <20260602-acpm-tmu-v7-2-8047dd54b0e9@linaro.org>

On Tue Jun 2, 2026 at 6:00 PM BST, Tudor Ambarus wrote:
> Add driver for the Thermal Management Unit (TMU) managed via the Alive
> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
> Google GS101 (and Exynos850, autov920, etc.).
>
> The TMU on utilizes a hybrid management model shared between the
> Application Processor (AP) and the ACPM firmware. The driver maintains
> direct memory-mapped access to the TMU interrupt pending registers to
> identify thermal events, while delegating functional tasks - such as
> sensor initialization, threshold configuration, and temperature
> acquisition - to the ACPM firmware via the ACPM IPC protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/thermal/samsung/Kconfig    |  19 ++
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 618 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 639 insertions(+)
>
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kc=
onfig
> index f4eff5a41a84..383ae3f56cbb 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -9,3 +9,22 @@ config EXYNOS_THERMAL
>  	  the TMU, reports temperature and handles cooling action if defined.
>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>  	  data from the supported SoCs.
> +
> +config EXYNOS_ACPM_THERMAL
> +	tristate "Exynos ACPM thermal management unit driver"
> +	depends on THERMAL_OF
> +	depends on HAS_IOMEM
> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOC=
OL)
> +	default ARCH_EXYNOS
> +	help
> +	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs
> +	  (such as Google GS101 and Exynos850).

This driver doesn't support Exynos850. There is no initialisation sequence
and etc, moreover the next section is also not entirely correct for Exynos8=
50.
Not sure why it is mentioned here in such way.
(Not even mentioning that ACPM TMU part is not aligned for Exynos850)

> +	  The TMU on these platforms is managed through a hybrid architecture.
> +	  This driver handles direct register access for thermal interrupt stat=
us
> +	  monitoring and communicates with the Alive Clock and Power Manager
> +	  (ACPM) firmware via the ACPM IPC protocol for functional sensor contr=
ol
> +	  and configuration.

> +	  Select this if you want to monitor device temperature and enable
> +	  thermal mitigation on Samsung Exynos ACPM based devices.

[..]

BR,
Alexey
