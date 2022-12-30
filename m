Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463D5C4167B
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Dec 2022 13:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiL3Nma (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Dec 2022 08:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiL3NmI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Dec 2022 08:42:08 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E0193E7
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 05:42:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f20so22143198lja.4
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 05:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2pVyvBRe9UtYAx8u7XzYBaaywvqrbS7Yhpl9r5NENo=;
        b=G4K5CU5hr8/JczDFbEKuEBJO6xlwqP0w0MrNn3FkJJaavx3vt5Mha/bR/f3urlDm2i
         FfqUWF+n+IKtUgEM064ALRlsOS4j89QpqXxbbbLQ1L/uAybfT3JBnEnRNxS0h7F0FNCp
         1ilN+HMKBkRQbP3/n/7zLmFdZn8KhdRiINECEc22VTFKZ4AI++WyW5gtLZihEfCMTK4a
         KpgYhoTzHYl78qD0fp1pOfw7Jhyf6IS8O1mnx/r+Tqzu0TSBU5V5rS6ct83n8D2UdhFH
         jPEz5W9cz3FrQ/XjRkt3HkC71M0iCOcgUtiUM7t2M9ktYMenufmQNSKPhoBAmxjUkp08
         grog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2pVyvBRe9UtYAx8u7XzYBaaywvqrbS7Yhpl9r5NENo=;
        b=VH2VdwIzNKmojOsW7hhZFFB3Nnl9q7sx2r+9ailq+EQ4UPLVOWsE42qEvO3cyFv4Pj
         UUvwsofcpgg84wIte3UOHtHTIJGQblEWyY1Md1y5F6r9mUYXa5I0+Kfp3RboQemFUpmv
         mpWT+dd2MbG54WZoOy/KAWNzMy7wq8j09X2xdLCRVFaQHraLVftBjA8y6MV9tqNairdm
         S7Jpj6NJTJ0e9Rz5zOkfuBK/tMeLjMDbykCWMRrENipyo/cnH8Lcq1HklucmlPAHu1CY
         8qeD7kbY+PiEl0yukZSHCoJoRnM2l1IRqERIvUTolQpDpa+BguDH0d56iu18dUCLtD0c
         E/6Q==
X-Gm-Message-State: AFqh2koWn1dR2+IB9d4e++X3I9ZzANDBEunLYJ3pYa642EIWMuvtkvOn
        cd9/sJStmO9qM/GPTh7hmiIRfA==
X-Google-Smtp-Source: AMrXdXvs56V7XyEXSMVKcuexXJ95w3LQyI5rNEb1uvme3kjeI1j/8eYTJOnEciY+Zq2OEo2yo1pIEg==
X-Received: by 2002:a2e:80d9:0:b0:27f:e337:1ead with SMTP id r25-20020a2e80d9000000b0027fe3371eadmr383945ljg.43.1672407725242;
        Fri, 30 Dec 2022 05:42:05 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id r22-20020a2eb616000000b0027fbfaa26dbsm1657913ljn.14.2022.12.30.05.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 05:42:04 -0800 (PST)
Message-ID: <617ec8c1-26ce-18ca-bda3-a8c5b2569b43@linaro.org>
Date:   Fri, 30 Dec 2022 14:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: add missing space before {
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 30.12.2022 14:40, Krzysztof Kozlowski wrote:
> Add missingh whitespace between node name/label and opening {.
redundant 'h'

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
>  arch/arm/boot/dts/qcom-apq8064.dtsi                | 6 +++---
>  arch/arm/boot/dts/qcom-mdm9615.dtsi                | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> index bf2fb0f70fe4..c57c27cd8a20 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> @@ -22,7 +22,7 @@ reserved-memory {
>  		#size-cells = <1>;
>  		ranges;
>  
> -		ramoops@88d00000{
> +		ramoops@88d00000 {
>  			compatible = "ramoops";
>  			reg = <0x88d00000 0x100000>;
>  			record-size = <0x00020000>;
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 1f40a3dd5748..e045edeb5736 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -1101,7 +1101,7 @@ sdcc3: mmc@12180000 {
>  			dma-names = "tx", "rx";
>  		};
>  
> -		sdcc3bam: dma-controller@12182000{
> +		sdcc3bam: dma-controller@12182000 {
>  			compatible = "qcom,bam-v1.3.0";
>  			reg = <0x12182000 0x8000>;
>  			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1129,7 +1129,7 @@ sdcc4: mmc@121c0000 {
>  			pinctrl-0 = <&sdc4_gpios>;
>  		};
>  
> -		sdcc4bam: dma-controller@121c2000{
> +		sdcc4bam: dma-controller@121c2000 {
>  			compatible = "qcom,bam-v1.3.0";
>  			reg = <0x121c2000 0x8000>;
>  			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1158,7 +1158,7 @@ sdcc1: mmc@12400000 {
>  			dma-names = "tx", "rx";
>  		};
>  
> -		sdcc1bam: dma-controller@12402000{
> +		sdcc1bam: dma-controller@12402000 {
>  			compatible = "qcom,bam-v1.3.0";
>  			reg = <0x12402000 0x8000>;
>  			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> index 536bd7b50762..8e9ea61a1e48 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
> +++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> @@ -294,7 +294,7 @@ pmicgpio: gpio@150 {
>  			};
>  		};
>  
> -		sdcc1bam: dma-controller@12182000{
> +		sdcc1bam: dma-controller@12182000 {
>  			compatible = "qcom,bam-v1.3.0";
>  			reg = <0x12182000 0x8000>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> @@ -304,7 +304,7 @@ sdcc1bam: dma-controller@12182000{
>  			qcom,ee = <0>;
>  		};
>  
> -		sdcc2bam: dma-controller@12142000{
> +		sdcc2bam: dma-controller@12142000 {
>  			compatible = "qcom,bam-v1.3.0";
>  			reg = <0x12142000 0x8000>;
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
