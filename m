Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302CC43217
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Nov 2022 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiKNJkC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiKNJjz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Nov 2022 04:39:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189AD1DF08
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:39:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so18322964lfv.2
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TL86IkJGfXR2W5yilJqkGWhXAZUDk1Sq62leqV0tyk=;
        b=ube9SxXoGEV55f59QaAYLHVfPnPArxvDUpL4mHNmPCvPRvOGJDVp+Ibu5cicH111u3
         arkuuC90pMhhmUqcPHQtD94SBXy7ApkUXv0cDun9TXq55jJM/Yit7A8sInp9GtMX35Ga
         ioLw9CBM6s3Vhrox2Pttq4DT+zsFtCUTJ5cnB1biXo5DJQZDk+m88uoLPQGMicPF4Khq
         noZH8r7O8yyjsFkcB2JgM4NQZQJO8ZAvaUlTY8wFA2sbzRoOW00HeuPWsrCSnBOmlwfq
         lyig/mYxH2UyupgnKt790fHjHFlkvpKx7F/XRHr7eDMm3pzcy0Y4wLs+tHEfu+nweZrX
         xuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+TL86IkJGfXR2W5yilJqkGWhXAZUDk1Sq62leqV0tyk=;
        b=LWVfF6We3NJyEJpX9dSW1IbS+7gH4H9sjkUhX1Xk4/Kz+OSix70N56jhXV0ZTSGdMc
         ExpsmPCvWDhFwPO8drZOp9hxC7YygQPSDGXTImxm/5VZyV4dT2AezwpbTShPf5Or0ZkX
         Id7BPTEl4AuJIm1NkeosJdycZSzMqYm8hZY+jULDzNcR3LI6kccHkzLO+OKP+FZmXGV7
         DxCiFCIbtOi679FhQxUjKiWdOO7f0gHZGe+GNVXwoi+brMJfQfue2Vxuex4srlKoGJsT
         dpwRQ2RttCRQZJgrwW0jyReGfBjo9uh0yGOeppfO1XPu3TnQohN0Uk+L0K+LA1yUwoLx
         FW4w==
X-Gm-Message-State: ANoB5pmsEf+UhOFyCLp5PfuIwH/pLe+1wTFz0xe1p9Bo04b3aYnJnPT5
        PYay3FeFj52lMSEk1irvOfvJ3w==
X-Google-Smtp-Source: AA0mqf5o3WF2RymMGPFzIZRUo/4Axy3tf5zinq7Bcmb1N+7mNktuDvNvQFpFVloIRJ0l1xLSHTSdeg==
X-Received: by 2002:a19:6719:0:b0:4a2:3955:e460 with SMTP id b25-20020a196719000000b004a23955e460mr4439383lfc.217.1668418788496;
        Mon, 14 Nov 2022 01:39:48 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b004979e1ff641sm1746299lfs.115.2022.11.14.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:39:47 -0800 (PST)
Message-ID: <1591878f-2fff-2571-a5f5-a2a712d87592@linaro.org>
Date:   Mon, 14 Nov 2022 10:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 07/11] soc: qcom: socinfo: Add MSM8956/76 SoC IDs to
 the soc_id table
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-8-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221111120156.48040-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Add SoC ID table entries for MSM8956 and MSM8976 chips.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   drivers/soc/qcom/socinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 545934aead43..b2f73e9cba9f 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -250,6 +250,8 @@ static const struct soc_id soc_id[] = {
>   	{ qcom_board_id(MSM8926) },
>   	{ qcom_board_id(MSM8326) },
>   	{ qcom_board_id(MSM8916) },
> +	{ qcom_board_id(MSM8956) },
> +	{ qcom_board_id(MSM8976) },
>   	{ qcom_board_id(MSM8994) },
>   	{ qcom_board_id_named(APQ8074PRO_AA, "APQ8074PRO-AA") },
>   	{ qcom_board_id_named(APQ8074PRO_AB, "APQ8074PRO-AB") },
