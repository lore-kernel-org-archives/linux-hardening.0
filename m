Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957C40629C
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554477; cv=none; b=PExKXky3s/03D2jd2P+2ZFCRwJJZHT41QTvSaHJNiNVHjP3O+nTG3GPl0K1pakuP7mrGcxZzO8DXAckhF4pjSGiiP8ugG/ET4JZYt9SoZTWOiYIIqlO1dKT8Ao252OL2UVQYhdkgdXFwD63X6aA4vuR0tRC/ZGm7Uf+CdcF4bRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554477; c=relaxed/simple;
	bh=KhRQj+iRqtW+9HWFZenOFSuPZ0WQQSN49Yl9CqgIP6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T69N4aizOOTrzY0zOAKHWMwlozoOBR9QZTPqrYACQPQKJ416JOLhQcqCdPl8MPZPqQ9EHQdNLmPfqzpa2QrJVQp4wHHR/ujrhhl8jjHfz2jkaEFnNKlYoPMxXr7Qy9ITuQQ7dYgYPzE6IeGOivImHu2mEBODpOTU/4H7zVkpESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ttx6BUAe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ttx6BUAe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso19993955e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777554475; x=1778159275; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvDuNaRN8hH9izY7kpqOKXTCHfnDxHlyvhuaEy6Gtkk=;
        b=Ttx6BUAekpqaGc16Ygjpw/uU2dRApAkiv3xEZObvHlcKWC5otMLkdORqENVRXZaJxz
         0pnBJd2FuVIZXxBe6Led+GIDxzYGoTlSaNE0NoaWdbAR/6KMvzfuyk8cHWRCBd1Rsi/A
         0XrTFrIlAoRVazq3ThcTRMFZL3SWuRdrKPmOvftVEexLSEYzEALy+Vx53YgRzAjVX27J
         FZj+iDDY1EvD6un8sRQ94LWTNG9Y8ZnFD4OCfD/BsXH9v33Yyf9t/TRX84c9LdLEwLwJ
         DauQlxuv4zVHq4ZwdxE995o0BvgMbE+cseFlc6S0XXQgXh6KRUyR7AUPjQjwoNj7jAwz
         m4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554475; x=1778159275;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvDuNaRN8hH9izY7kpqOKXTCHfnDxHlyvhuaEy6Gtkk=;
        b=QpXnm6wwDSFMFYOyzoaxLSIp8jtkdVnWn0J2wk6cpGbsfkcxZ8Ds88vOJUCpDrBKb/
         hwNGDWQmasX3ewV7rikfm07kV6p4MkO+GyOIg7mfNszTSTLQA+DcwID70HjUsLbr7L2A
         A1Va5VQowQy9CGef4LGlf+MSh8afGl4rbW0zxl5oYphSXQRJnQy6ygyr4ghA//HQ7Rso
         kBUmHWPIQUxEV+B2BbGIsA9TYsJ5kK1wrn9uNvBk67NtfPcmv5l/YSh5wUrVPHDmA3xt
         FX449E3ciLsfpiTDsntbFQXEDEURZu5PbQJCiac1AdquONjCUV8B72ZXiKMJFKThzQ38
         1s1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8NfVbI+xb6CZDIrkyx6wiJsbGP5Hw7e1t9gphYSMsz70ugMNjLQj7zvXSVIOIRZffBJB1iCEVZ4qxr3m13KqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZysAjnfAInvHifHZtLNGcoNyv8K+/0vNyfAXx2PRwDjQrJHG
	nq+tQwL2XiUtJzuYuU2UH4yJLpouHt/ZN5IpUaH6qhWtpGq/Lqdd5t7urhrz8VPc4Go=
X-Gm-Gg: AeBDieuFMooaftVHhEV4imNJNOy5qzPZsawyvkddWBsp/x6tYezoKBq8EAwV0bba5zj
	QoVspigTEk3whk3Wdu20k3NL9htwU7OIuS3x3MaeEx1OvsnlVIEygo8PYlO4bds8Q3f1uhbm3fZ
	9PMP9HE/BH3SRgwyPwNzXxxTNzCnePDDNFpQFY25jvifrO+VCsPP8GscANQfMrvJId5rioTv++t
	YN2JnRZ3t1pMN2IDDhD7I4TltAYpXUZ6aY1YTDsttoKFLIrF2DWF0sZyy7rpm1Ic0lXgVzs0bXq
	3eFf3jKs9nhHACgGZLiUJfVSsS9cjtuUgzWJ8gRt2JuJm3kmOqpfYkbuO7wFVD3lZTur9wkF8uP
	VhnW+v/ymMuTwyjnQhTZe0LaksSMHLMWQ8Hi4jzABQTiituJXqsFO/ZHZaQVus/GU8OjRpwHCZ6
	Mvh133+uz6WZhTQt+EyTq0do7oXQ0pfQp9FHOIyxh+qAiE1R5FN05rDoUr7Ij3of6lvxEPFef2n
	2DdLRlxqXPXUcezUTZIkbpZlA==
X-Received: by 2002:a05:600c:4b1a:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48a85dc37c2mr23717425e9.0.1777554474275;
        Thu, 30 Apr 2026 06:07:54 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:b0e1:a8:4337:b2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822d4a9asm71861585e9.14.2026.04.30.06.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 14:07:52 +0100
Message-Id: <DI6IGZIW2HZ8.OBLZIORMOH2F@linaro.org>
Cc: <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/11] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Lee Jones"
 <lee@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <20260423-acpm-tmu-v4-8-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-8-8b59f8548634@linaro.org>

On Thu Apr 23, 2026 at 4:22 PM BST, Tudor Ambarus wrote:
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
>  drivers/thermal/samsung/Kconfig    |  17 ++
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 547 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 566 insertions(+)

[...]

> +static struct platform_driver acpm_tmu_driver =3D {
> +	.driver =3D {
> +		.name   =3D "gs-tmu",

What "gs" stands for in the name?
Shouldn't it be called something more acpm-ish generic like acpm-tmu
at least?

Best regards,
Alexey
