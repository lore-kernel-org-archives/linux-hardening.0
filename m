Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B86EB64DA
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Jun 2023 08:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFSIMS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Jun 2023 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjFSIMF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Jun 2023 04:12:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3BE7D
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jun 2023 01:12:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f7deee339dso3552338e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jun 2023 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162321; x=1689754321;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MkhTrJ9T0aYR/ypFkdnmXuhMMz/1JRUzQsSC4Yvkus=;
        b=QqpRxf01ABUbLt9+xVQ3DYAogIXvxBukHbzT6IO53gGfL4sXz89QnCXsA4BQY6ATjo
         NXnaf5Q2nMHwWBBEnEbEmkGhZhz1Jv3hT7ruF7NMRH4a6Pog+dmN2F42LyFTOgeLgpYP
         a5h8C1UdGdURjlRfKyVGfqmPMWtCJuugRJkPuKWLpercaCab02f4au3k3lMCTdHuZPGb
         4W2PoL4PibmES9QwScb4v9zyQFv2Rgp+9A3AhZr6+ANPcupRTblgtrmrcSys+afehYE6
         wNCyGNgA6DTAOfv3vU1Lr1Q5GIvD6YPRJCA01yhTOg3CeV/RtBKSbr2f3XbfahWo9PSJ
         gY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162321; x=1689754321;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MkhTrJ9T0aYR/ypFkdnmXuhMMz/1JRUzQsSC4Yvkus=;
        b=inry9HN9YMabE740ZtaFAZiIbTI7kLuF0ESjUi7mMSuKcuF6JINbVX3i8p979Mf9s3
         oWw/E3C7+9ehcwLm4V+BDLVhZqkOxkeFy/Pck0qAcbpuEPNXKaLVlGJNCyF/T7ZgIW0c
         7/PFCIjN2wc3mjMy3ASTv6s+AAmLAmKF+SArYgEjiB8hnvzf8LmgGCxVgtCafCxy1B9t
         I2h5giimdEW1bjW6JOmISe5lwH2+6gmiQdAlQKXDMLSHqNTpT7MgiNfPZAmOCzpQjBp6
         ilhCTWTcaFz9S4/HS6wInyovwJI9DQKCZsHLkC8iqxTP/NP2pZhdYPmKs51sEMqP3BWH
         C+4g==
X-Gm-Message-State: AC+VfDwQ8ti0Em5JMprF74+Liznp1ZREr2ivzGI8ND9QL023fRnj6Vgw
        9aeQ9Nb78Lp4yB/2s7WAhL23xw==
X-Google-Smtp-Source: ACHHUZ5BIZqOUn6vxe0wdzVkKVSgdsXpn+O7ruN3luGwb786xYDYZQ8vIqdtm3NH41FBRZ9bhCjOGw==
X-Received: by 2002:a19:2d17:0:b0:4f8:55dd:e726 with SMTP id k23-20020a192d17000000b004f855dde726mr4514984lfj.12.1687162321068;
        Mon, 19 Jun 2023 01:12:01 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d4e04000000b003113943bb66sm3327084wrt.110.2023.06.19.01.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:12:00 -0700 (PDT)
Message-ID: <59a2a835-346d-22b1-ba5c-820b5b3b347e@linaro.org>
Date:   Mon, 19 Jun 2023 10:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sm8450-hdk: correct FSA4480 port
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
 <20230618114442.140185-2-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230618114442.140185-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18/06/2023 13:44, Krzysztof Kozlowski wrote:
> FSA4480 has only one port according to bindings:
> 
>    sm8450-hdk.dtb: typec-mux@42: 'port' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index d7975b3cf064..e5cbea92e07a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -518,16 +518,9 @@ typec-mux@42 {
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
