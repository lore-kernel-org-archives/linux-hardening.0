Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80829C7EE21
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 07:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEDHOI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjEDHOH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 03:14:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0F1270C
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 00:14:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac733b813fso1641081fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683184443; x=1685776443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC32ZRL6kv8V/7o8EGUr1mtZobBUgWUVglha3gwf8ss=;
        b=SKg0wIfLaLDnuauS+QNo+ttQkKMyX0p/sZ1KfMllPb9bPgx0sMEFrOosJEwQJqFBdY
         wdWWmFf8C/l/3uLBTHhG+/iyxOn6Do7W+6sFqQt5qDl2E+RCyKhHnZzHacoNRdbVqQ5m
         lQ5ZIcWhbbQL0CTZkKKpjThRy97Kgz/haVJTKFCnvPQ2oEW2IF/OBH94ki02CmcTy9Z9
         k6IoUswj4PAWNobK0Tkc1ASV4hmdtkx5J5nqYreU5HvczJEJYjXSZgAumAI5p92cPpoi
         +nk+3CKDzkgfEXLkcjCpFbFW5VhLYVOpLCMdsxWsaMA2AANRUtrvcHHkQr6gzFjt3X5X
         Jr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683184443; x=1685776443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC32ZRL6kv8V/7o8EGUr1mtZobBUgWUVglha3gwf8ss=;
        b=bh4TGE0pGMIcel46j+SlUIXV0oX7ayRaKUYA59qpfcfTjtF+GaLkQE8TlCxkst4bsi
         dj23rs9KnnU/d+bxSZlHWAeyEfUnVzSwDYqRfjDOBa0ouDY3lsCxGRZgYoJyY5yro5Ew
         E1FEFvM/08m83tvay+T2V77TA7PiTefa0qd5RNDLKtLTBPkS6sVng/I3J2M6t3rbLEhJ
         AUZDQTYMN8RwEnTBCbXExM4PJYzvSvN9jumJjMq5E7NEjIdJheCe0cWw6l6vC7hyWwbn
         kMNxZyvnnCRBPJUI4JO2h9dYzkYZsjlzyxyKSjawbfnVxvB9Fejie/ZvPKVnPP/trvcZ
         SsDg==
X-Gm-Message-State: AC+VfDxTg5qE23FqhOZ+MzvcXQgXQPIgILjbBdl3ccuYJBblfONKNRln
        9dNwbiOiylTtta2GaKUOuj5IBw==
X-Google-Smtp-Source: ACHHUZ68E5CT+tz5TBMWB/yNgy/q68QX2qmngSSqztLupWyrwNdOkkrkNo9hgynnEpklbx+XHjkw6g==
X-Received: by 2002:a2e:9785:0:b0:2ab:d1b:dcb2 with SMTP id y5-20020a2e9785000000b002ab0d1bdcb2mr635844lji.38.1683184443371;
        Thu, 04 May 2023 00:14:03 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25082000000b004eed63bc08csm6402214lfm.131.2023.05.04.00.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:14:02 -0700 (PDT)
Message-ID: <21b500a5-2c4a-e156-61b3-aa0a2f4f5183@linaro.org>
Date:   Thu, 4 May 2023 09:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 11/18] arm64: dts: qcom: sm8450: Add Qualcomm ramoops
 minidump node
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, corbet@lwn.net, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, catalin.marinas@arm.com,
        will@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-12-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1683133352-10046-12-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 3.05.2023 19:02, Mukesh Ojha wrote:
> This enable dynamic reserve memory for Qualcomm ramoops device,
> Which will used to save ramoops frontend data and this region
> gets dumped on crash via Qualcomm's minidump infrastructure.
> qcom_pstore_minidump is the associated driver for this node.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 595533a..92d023f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -614,6 +614,17 @@
>  			reg = <0x0 0xed900000 0x0 0x3b00000>;
>  			no-map;
>  		};
> +
> +		qcom_ramoops_md_region:qcom_ramoops_md {
Missing space after ':'

node names should not contain underscores

minidump {

or

ramoops {

would probably be better names for this node
> +			alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
> +			size = <0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
> +	qcom_ramoops_md {
Node names should be generic (e.g. ramdump or something) and should
not contain underscores.

Konrad
> +		compatible = "qcom,sm8450-ramoops-minidump", "qcom,ramoops-minidump";
> +		memory-region = <&qcom_ramoops_md_region>;
>  	};
>  
>  	smp2p-adsp {
