Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61237EB64DA
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Jun 2023 08:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFSIMM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Jun 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjFSIL7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Jun 2023 04:11:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03FE78
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jun 2023 01:11:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3094910b150so3125591f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jun 2023 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162315; x=1689754315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8frC8TiuVHslB+HMCCqRpnTLqgdKNXY2aJgyGX1zVk=;
        b=bMqN2L1aL8D4ZfIVJxK0UshevhfvNFhkRKnQmvKNAi52N1XZZZ888TdINIokDRKv8U
         I39nGDicTc4Comxls1cGG35gjt5YJEqIyf9D9cChiXiOUE7Y/CnUqV2skgKLPZush1s4
         I7lGoJrhSK5QnxzSTcUNHogT5v0ZRvqzBMGj3Yjp+2LoSLzsbGf89bPOfvl/bvPf2zY/
         NIcC4M9VaSiugdfhP8ybQ0qKrPSensCOK8G0JDo23f/B953EtkRxYN/L8eFCuUAA4wXV
         WzL0jAkYx8Hlx+LaZFRaD+zetzUk+61nqxrXLIq8S2ljf96SMSH8DLGQzP5ZmureZI8s
         z9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162315; x=1689754315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8frC8TiuVHslB+HMCCqRpnTLqgdKNXY2aJgyGX1zVk=;
        b=I2zZBk7KFn4eWduLnuI3BvC5c6IJJqrPv5w2zr97G5YOfFsbiVcZ3u14UnzAL3ifsS
         dV1SVzR7HAgCk68mb6qDdv3E2pSMF3Le8pODaRfOYoykpLbv/aU8Pb9Y2QQFYNUCU8JS
         ZWqsl+WPYvkS5Edf/s3PEIQ+BT56Bye+znb30qSNfFEHzPiMagiAXkuJBoPKx7Nm43Qz
         N1zYRwb8fiewS6gu1kicbNUYqxQ4pQIbOY7FHsOsa9a/w4l2mPJIuUSGX571fXa/QCJc
         77UQheI5CNXzgq5hnmVvlpRvYk34PI0HjEDYTgaMS9hXRnv6hPNbplqVUnt7mNnZ1CHm
         6UdQ==
X-Gm-Message-State: AC+VfDysCze/LEVGxzOwXefLPFxRGr+/zJKBsCUFS6b1lVsOOrjWLxhO
        drUW/tx5bCRytOeqLd+HMf9zVA==
X-Google-Smtp-Source: ACHHUZ6ea0iq6kWnXU9vNHgMl340RUm5Kl2MGrZvoW63f5AfuxU2rnXX9ObQ9/EtrCoWvGB9UbBBwQ==
X-Received: by 2002:adf:fe8b:0:b0:30e:5729:b5a5 with SMTP id l11-20020adffe8b000000b0030e5729b5a5mr7272540wrr.38.1687162314737;
        Mon, 19 Jun 2023 01:11:54 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm30736164wrr.18.2023.06.19.01.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:11:54 -0700 (PDT)
Message-ID: <3c6a772d-07e3-2338-406f-d8e5b5001dc4@linaro.org>
Date:   Mon, 19 Jun 2023 10:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18/06/2023 13:44, Krzysztof Kozlowski wrote:
> FSA4480 has only one port according to bindings:
> 
>    sm8350-hdk.dtb: typec-mux@42: 'port' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index b182f4cf06cc..95a2a42ccb9e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -349,16 +349,9 @@ typec-mux@42 {
>   		mode-switch;
>   		orientation-switch;
>   
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -
> -				fsa4480_sbu_mux: endpoint {
> -					remote-endpoint = <&pmic_glink_sbu>;
> -				};
> +		port {
> +			fsa4480_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_sbu>;
>   			};
>   		};
>   	};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
