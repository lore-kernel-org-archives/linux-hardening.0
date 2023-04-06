Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB5C77B6C
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDFRv0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjDFRvZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 13:51:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841F4C21
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 10:51:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h25so51862657lfv.6
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=844IQeqGqgxY4Tgvv2/QUZfgyMCjy+UzrXZ6klmnSQI=;
        b=vEcBWhE/ijFTaoraej8Q9L8cYFUcCJmNRyRjPEx/pZiAzNKiT7CbIUs5Tr10t9/jpO
         yWKBqyyGvwzL/GJW/sc6nCZH6zsBd/Wt/E9DWBkg8t2fKO3O5QEAoHqq8t8zmiY59BYf
         as6Dw/i/uVhemfXTYdwJJXYYc3St58RA6R52aMdvrMxw474qy+OkEIXu7U31N/Yxsedd
         AFLhUyxijYyKa5Ray0y7gz+949EWMy4XnnFHensJAMkd+WtBe94og1PCI83ve8OkS+Ks
         BqlcVkrZdY5CsAop0p1BbZ8Ozz6gBjyycxc6zQXUHSSufBoDl0x2NJOs4pcMJDmFM99j
         1/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=844IQeqGqgxY4Tgvv2/QUZfgyMCjy+UzrXZ6klmnSQI=;
        b=eCWYgCti3EPnQXIQlPCrVATdmxUCX3j9NiKIXDfvFwL7IH5ZiS2/1GnVZGuBlYRb72
         c63TdBZgosocmVUbDIyx4MhybkMUNQrZ/8OflEDux48QUHy5IOx+QaMTXYbo1Lw3kdAW
         kOEm5/dGUlyWyJVVBd/cPHO+NQGFRNpiaIBwbwCGcn94MHSPcuyVzDsfRslsxLDTihVH
         DyY5Y2476eAK2OkuEdLMzdPG0dR1gzhG1ixclOKn6v0Dl//p2dKEsfPVIrWAhO5wMDyV
         SJxnQT2Hfl0pzwjXPIdFquM6uRFnUdUHtdeRdGhd4gMdFdQ1wr0kmF5/inEBqjPy/yKk
         KR/g==
X-Gm-Message-State: AAQBX9dwD3i+0Z3q9vLU0WRrefpPVJ9twI/7OCPETSYuETl607KIQNEZ
        RYsM1eLenOV6m+Plwa9Xbe+1Og==
X-Google-Smtp-Source: AKy350bTfAWkRunU4OMi7vWzfciPPwM+geDMw1MB1rys+Kd0FuOlNl5vLPCKQxzgocSvF06wf0of1Q==
X-Received: by 2002:a05:6512:10ca:b0:4eb:1315:eaea with SMTP id k10-20020a05651210ca00b004eb1315eaeamr1846074lfg.3.1680803481477;
        Thu, 06 Apr 2023 10:51:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm355142lfq.229.2023.04.06.10.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:51:21 -0700 (PDT)
Message-ID: <7476b5ba-426c-3701-c4aa-d3e2db3de112@linaro.org>
Date:   Thu, 6 Apr 2023 20:51:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-4-c73a5180e48e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-4-c73a5180e48e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 06/04/2023 18:25, Konrad Dybcio wrote:
> Enable the onboard QCA Wi-Fi. HW identifiers for reference:
> qmi chip_id 0x320 chip_family 0x4001 board_id 0xff soc_id 0x400e0000
> 
> Firmware sources:
> /vendor/firmware_mnt/image/wlanmdsp.bin -> qcom/.../wlanmdsp.mbn
> /vendor/firmware_mnt/image/bdwlan.bXX [1] -> [2] -> ath10k/.../board-2.bin
> [3] -> ath10k/.../firmware-5.bin
> 
> Not sure where 3 comes from on the device itself, gotta investigate that..
> 
> According to [4], it's called WCN3990_STRAIT.
> 
> [1] XX = board_id printed when the file is missing or by your downstream
> kernel firmware loader in the dmesg; if XX=ff, use bdwlan.bin

Since the board_id is 0xff, please add qcom,ath10k-calibration-variant

Ideally, could you please send the bdwlan to ath10k for inclusion, see 
https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles .

> 
> [2] https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
> [3] https://github.com/kvalo/ath10k-firmware/blob/master/WCN3990/hw1.0/HL3.1/WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1/firmware-5.bin
> [4] https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn/-/blob/LA.VENDOR.1.0.r1-20700-WAIPIO.QSSI13.0/hif/src/hif_hw_version.h#L55
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 2aac25171dec..4ba8e59a27d8 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -315,6 +315,14 @@ &usb_hsphy {
>   	status = "okay";
>   };
>   
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm6125_l8>;
> +	vdd-1.8-xo-supply = <&pm6125_l16>;
> +	vdd-1.3-rfa-supply = <&pm6125_l17>;
> +	vdd-3.3-ch0-supply = <&pm6125_l23>;
> +	status = "okay";
> +};
> +
>   &xo_board {
>   	clock-frequency = <19200000>;
>   };
> 

-- 
With best wishes
Dmitry

