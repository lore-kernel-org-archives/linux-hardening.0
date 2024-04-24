Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BF16F0F0
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002454; cv=none; b=SNlBiIgkF01sgqriYOUeqwoWyUyQdg12N29jFWeuO/AkWqEQPIg58Ou7413+T53sU4Zwrbf92dLT/9HKtZ37dpbUqBPD/MI+Xe5yodyvzrEQLS9D0xk7P6zSIIM65m15IdNtg5weWORS7kA3IvaGIeQuvyf6OoSztkYo15JnHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002454; c=relaxed/simple;
	bh=OMKvIJ7aZmnQ9wSxcW/ZI5sON1e/NHXRACIEAc/ndPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMbMYjHzA3tYewJXDFh7yTpFssjSBECga4SQH9Y2mwoAxB1kbp1ukm815h88WBp73AH6F8QCSJE4kgdDJEQH/QgNYjsMtHCqGzru3XFqFE0Grk7Sb/hiQ/Az+RJEftOsGJGGUvmsfpAyxbttY+8VVJcKMRKPUGbGyQJNfAlbeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sj5JSfzK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sj5JSfzK"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc236729a2bso475257276.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714002452; x=1714607252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1tN60EyOoTTpXwgrDNf6TzRWNHHafqzCbKwzrT6DXE=;
        b=sj5JSfzKTVevknleMSOnHiamY9JV8h6cuDNwAp7wOalckZRZNiJGfHYAGf+FHR0yt0
         U4nujAI8HbJOv/AoSnfw/cFspn7WzRIqw6gEDh6vZbTS/0if4ShZqpe3DO2LyOqeBeGK
         1l+bhnQ4hNRWwvm3mtpUde3pJ/+81vyROCucPs8UmlxU4VW30gMJ76W1jCTjDB50Su+8
         UEHt24ja4Nzp0WhnHzlNoLleijs3s9bgdaskdTMyei/x9G/7ZBp2CBbC7dWXzqANsnqr
         dBmedBNaodhmD2ShdYFPI99GU7XEjjEnK2rTkF/hqF41fqTF3V2w2C/RXj7sUdMa6XFp
         J+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002452; x=1714607252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1tN60EyOoTTpXwgrDNf6TzRWNHHafqzCbKwzrT6DXE=;
        b=KJInMmqZ6lX6ZJfWKu1wWq9TEZ5DXyFJeYme1VrmCQ3guCPhfq1/VgObxC9856O3OW
         uLM+uccw8g8MT+dYgS98/29kuxPYuoxN3xI8BGPlnkMlfX1itLPYcGi5FM7BJx8EBsN4
         5n2PBF5hjfqnAvmmbv6wpriBUmDUunHcGzxm2Jte1uvro6DU6PhMuDviTzLHMdCUodLa
         QZ+H/Dzi4/5PAdJ4NXJUa1izKO1Nsa33VqRBbrGqF54hKhNFApbBfVRTnk+kyCOJlt8Y
         X2e4AQQh4Kh+dNWL4IcwwBh3E+TvDI/MThmjlh0WogSrF/XUo2Ipm3Dp2hvhUUVceG9i
         J/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWCuPC2Pf5FPj5BtGF+4qooaekbeG4kKenNjUHrmFs26DTXMu58Htg1HR4XgUvVniUJXkosjls+/ih08j8iApc5MroQjBA4YjDykus8DTRI
X-Gm-Message-State: AOJu0YwKlTIOAJ5KsQAKS8Xs9mKC98iM4mg36PNVGRrl6EbZ+lKHQrPs
	2D4TzFjtglmZhrmYB+wJYGfHjvOY+6gx4hGB+WBECzcTIo7G+A6UNTCVXi82olA7NHDg4DnbRVB
	RBROFhQToz3Jvrzyu0USfRGCHzPkAGjv694fB+w==
X-Google-Smtp-Source: AGHT+IH0ZhfG0Ni5n3NvfJ4JxKJary36xcWzUlVDAwrOHVIi0Ry6H9C6abzNJBTJEw8IWgmGC7WDcLOnbeiLdcitnGQ=
X-Received: by 2002:a25:664a:0:b0:de0:d3af:f52f with SMTP id
 z10-20020a25664a000000b00de0d3aff52fmr4141531ybm.49.1714002451985; Wed, 24
 Apr 2024 16:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024508.3857602-1-quic_tengfan@quicinc.com> <20240424024508.3857602-4-quic_tengfan@quicinc.com>
In-Reply-To: <20240424024508.3857602-4-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 02:47:21 +0300
Message-ID: <CAA8EJprceDUBtcrT0XLc7V9e0Joyw21YZD9=DONjTTfNM9chBw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: add base AIM300 dtsi
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, keescook@chromium.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@quicinc.com, 
	Fenglin Wu <quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 05:46, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
> chip etc.
> Here is a diagram of AIM300 SoM:
>           +----------------------------------------+
>           |AIM300 SoM                              |
>           |                                        |
>           |                           +-----+      |
>           |                      |--->| UFS |      |
>           |                      |    +-----+      |
>           |                      |                 |
>           |                      |                 |
>      3.7v |  +-----------------+ |    +---------+  |
>   ---------->|       PMIC      |----->| QCS8550 |  |
>           |  +-----------------+      +---------+  |
>           |                      |                 |
>           |                      |                 |
>           |                      |    +-----+      |
>           |                      |--->| ... |      |
>           |                           +-----+      |
>           |                                        |
>           +----------------------------------------+
>
> Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 403 +++++++++++++++++++
>  1 file changed, 403 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi


> +
> +&pcie_1_phy_aux_clk {
> +       clock-frequency = <1000>;
> +};

Please rebase on top of
https://lore.kernel.org/linux-arm-msm/20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org/

> +
> +&pcie1 {
> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;

Please add pinctrl configurations for pcie0 and pcie1

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +};
> +
>

--
With best wishes
Dmitry
