Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD016C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Nov 2022 17:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiKPRTf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 12:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPRTZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 12:19:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C432F
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 09:19:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id be13so30626593lfb.4
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCpMqcRT8DeY5MXJCLiKIz5Im5PIOy+nnF0pses3NRo=;
        b=gPP/YC7RcqXib2XtCBKhb344QqRcr2tCekCF3H6g0DbHMXM4BhF+AYi7kbOqwzduc1
         3Nci/kOMGv5CP1o5EcR/uksu0p+DQ1m2pB/gPAPIJ41aKwBUyDOCxBpVgybBC/qaRQga
         T3RREKedJitX+tZgbKXiRYFLTT+UhTcWyWU/SmhiHj57cdAf7pxa5HNvQ4I2SYeFTVPe
         hwd9U5GXn3E2GS3Eakoa0GH8ZR3mS3C+DQkxZAzSXLcPeG/Pdzdn2nGBPyD2iT60PZDX
         NIB8D8lpfsyt/RpG+EaZvK2Nv0GLHktVnskYmOD64WMfMkltDs0AtnMchbWTlVb+L9sT
         fNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCpMqcRT8DeY5MXJCLiKIz5Im5PIOy+nnF0pses3NRo=;
        b=nQmW98mrvnc+Lu3bYlX5+fNL+2y8ZtblUwJXQmBtaoZxlEa9bGi8UgIIs5aShUhYty
         ekXTU+4DU0vaPvU6FNFxsdt7MHUrgAAMc2HSU/4k8s+Xw63ALDqHhyAaYZcONUIckjk+
         gt9+9S99WxeldKkLutVF+V9xM2dxOPQ1CXmZwBAC/8pTGw6OXumvhQSGF5YeNvL/zU4I
         XQ4wDzW+i7gB7gTOmQ5ZuIfBJd8YUU9q4teKAP/QdAKWK56YmPiX/rpFRxRLc3Nssgve
         9pRFHg+vwl1SRDWMEmTUaL6AFgU5QdSx0GdXLyMDfc3jQRhntNtNVZJUSXNAbsZTFZyl
         9Ltw==
X-Gm-Message-State: ANoB5plwKb7V0t0zJj6t3uXM4f9Rw2Nb3CCYn8B+VagAkq/aJfv6c69V
        eVUVkLEpa9Ed/TDI4QDjAjpuWg==
X-Google-Smtp-Source: AA0mqf61LBMQcDDOdERra618Gul2RXMcG5LraXEgHjg7sKKHhpXJP2KJpVLUcPqjo1eEivEm8tnoHw==
X-Received: by 2002:ac2:5093:0:b0:4b1:753b:e66f with SMTP id f19-20020ac25093000000b004b1753be66fmr8351806lfm.276.1668619160736;
        Wed, 16 Nov 2022 09:19:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 11-20020ac24d4b000000b004a62ff61b3dsm2676326lfp.252.2022.11.16.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:19:20 -0800 (PST)
Message-ID: <891e51f0-af46-6150-ba4e-807f00cc8e63@linaro.org>
Date:   Wed, 16 Nov 2022 18:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sdm450: Add device tree for
 Motorola Moto G6
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Braha <julianbraha@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-3-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116145616.17884-3-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 16/11/2022 15:56, Luca Weiss wrote:
> From: Julian Braha <julianbraha@gmail.com>
> 
> Add device tree for the Motorola Moto G6 (ali) smartphone. This device
> is based on Snapdragon 450 (sdm450) SoC which is a variant of MSM8953.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Missing SoB.

Please run scripts/checkpatch.pl and fix reported warnings.

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sdm450-motorola-ali.dts     | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7669a7cee9f..a0b537414593 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> new file mode 100644
> index 000000000000..62874306fc24
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/ {
> +	model = "Motorola Moto G6";
> +	compatible = "motorola,ali", "qcom,sdm450";
> +	chassis-type = "handset";
> +	qcom,msm-id = <338 0>;
> +	qcom,board-id = <0x41 0xb1a0>,
> +			<0x42 0xb1a0>,
> +			<0x43 0xc100>,
> +			<0x42 0xb1b0>,
> +			<0x43 0xc200>,
> +			<0x44 0xc200>,
> +			<0x42 0xb200>,
> +			<0x43 0xb200>;

Both properties are not allowed, unless exception list is extended.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


Best regards,
Krzysztof

