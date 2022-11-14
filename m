Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF14C43219
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Nov 2022 09:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiKNJj2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiKNJj1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Nov 2022 04:39:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE41A80D
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:39:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a29so18305988lfj.9
        for <linux-hardening@vger.kernel.org>; Mon, 14 Nov 2022 01:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9XCkUeelflv0OvZlPTdiVOkOo+oSDAdHLbSak8ToQo=;
        b=mCY53LUKaJZ5o4feNXdaLfJEoFH+MlvQ9YtHKi3BBSBaY1U7P8fnx/yl5U0F0mFS2D
         LMdhxt9HYMFtwmbxbMfdElHaXEw8+6sdgCeO9N/gXbccLW1/wbAOzXX1YzR+8E8snThn
         lLP7HF32qRYZe/eC2BigWPU+RBKf9rQXvlELML585STcgmcFS6DPP2rMz6AhUW9tl8B4
         B2j6f4banrRSrHIm2sf8SyVkpwqFoO9reAaf/44+EKl2dp9ZX/8XCtDUjYz1OJXu6m/B
         C4ALWI0KC9g3gGEKCn2k/h6v8jRNWDScxGpyr9kJccrTh4qmEiNoCd5hwndogsqwFVT3
         4ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9XCkUeelflv0OvZlPTdiVOkOo+oSDAdHLbSak8ToQo=;
        b=oonw0D/Mm27zTHNF6G+u7yP33dEqxH+Y0nU11UunBSp1+uXo2FtnVHARXeWgojZYOi
         DeVCly1KP67+I4qEDRZnpVpzQ1abswjAbvQbfyl0Gp3/ZhizKBuxiz4hCnktygR91hDY
         zcnDlq6P9xIq/lhkCEqK5BzTabx2QFBlDw+sXqCBFSOFtqI128Vfr2l8shzS7vGg8H9m
         htgJ0SdPw3HcbSiVTXArwvepif/79e8i0Tc24hkucFSdpSc8mJb3P14UF/2xFKP0h17P
         mo4kGoBTd7EtGy0GV1BOQdv7xs6TYp9eapNmwBvbx/zJT00lfEC3e8Yl2XK5FQXgw/KD
         6YPw==
X-Gm-Message-State: ANoB5plr8AtXKF169zmdaf+erCwPdFeqOuWTyzu8irCOCu3OU8U4r8ay
        leWgcip9EuYtZFSob+Fc3OoPhA==
X-Google-Smtp-Source: AA0mqf6BjkXQmHn8zZLevpw4U3qXzZF296n/9D4aB48QjECYDiMKnX7ASO/YTJr4Odu2XE+Ni5hr4Q==
X-Received: by 2002:a05:6512:3baa:b0:4b1:2aab:7cc4 with SMTP id g42-20020a0565123baa00b004b12aab7cc4mr3564609lfv.241.1668418764651;
        Mon, 14 Nov 2022 01:39:24 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b004a91df49508sm1767001lfb.177.2022.11.14.01.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:39:24 -0800 (PST)
Message-ID: <b69afa6a-119a-41cc-a1d8-da900d452941@linaro.org>
Date:   Mon, 14 Nov 2022 10:39:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/11] dt-bindings: arm: qcom,ids: Add SoC IDs for
 MSM8956 and MSM8976
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
 <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Document the identifier of MSM8956/76.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   include/dt-bindings/arm/qcom,ids.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index 8b1a0f43bd93..91633da5fcf6 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -78,6 +78,8 @@
>   #define QCOM_ID_MSM8616			250
>   #define QCOM_ID_MSM8992			251
>   #define QCOM_ID_APQ8094			253
> +#define QCOM_ID_MSM8956			266
> +#define QCOM_ID_MSM8976			278
>   #define QCOM_ID_MDM9607			290
>   #define QCOM_ID_APQ8096			291
>   #define QCOM_ID_MSM8998			292
