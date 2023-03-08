Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD2AC6FD1F
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Mar 2023 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCHLQC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCHLP4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Mar 2023 06:15:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA12B4F68
        for <linux-hardening@vger.kernel.org>; Wed,  8 Mar 2023 03:15:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s20so20835907lfb.11
        for <linux-hardening@vger.kernel.org>; Wed, 08 Mar 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678274142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz0PeM+B0eQ33qul29Nk8o+XDr5rI2u92dlLH1wyCRw=;
        b=u9L/BW52fkJTFMv0G1nHSj0BToTicCSmoGAOHPCnd6BostvT19Pwy/uA5oLeJwlRdk
         4xyL8cU1W3QBgrMLyQBCagcRs4vvBpvq9NsYhpYTgXgENQMTQ3jnE222EP+JT+RW+2mQ
         X5xZFi9U0qExg3OwtiHkaipyb6gareDdrm23NpN4R93ni+Z5dDd+zlcdn10i2qEBbLfd
         siJudg5dLv0h5htnrAZ5Zzuc2iJTAvv34Cokrycbeq498yfjK2XCRymfJM9BpkR8wkXX
         0QFCgDvWq3zVAaPllpqpeahC/0e7LIEbqTuq2q/wHCaQmf0PXrT0xttnsD/K/fK4i9O4
         8n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678274142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0PeM+B0eQ33qul29Nk8o+XDr5rI2u92dlLH1wyCRw=;
        b=Qd9sdRksveIoZqE+oPaJb7RkjKmnyG0rkn3Lgpw/twyDjWJcob2tX14qvAxru9Vtm+
         m8j3JYfeorCnX4ZwVbZO1LhSNecSaufDZ9sZuXcsXiJGBW8S4cfr4qTrQriiMVIdbPC6
         WL2UKK/+H+eDe9JEkMK2FQZsGQErjOw0lgzQtOUx7Il9RbKv1JE5fKN4YlIoH/dlfC6q
         nOV/+99mHYV8doJ5WnHmmx5RfcAlFs7hAz7KEUyQdKebN33U6aurhGhVAQ13U60I9fjJ
         pdZnlDVEjbgWk0Ww2riLpUoRPsOARYUg/wNVdxV84SVmqRRmpMR0uvqP3ZBM+Lq2POLm
         3bYQ==
X-Gm-Message-State: AO0yUKW+Wa0g0A420ESJl3/IFEGZ96Ewx2a7rFppmzsN6siWf5mOqAFw
        ff9Y22NoxBTM3DDdrquUndCPPw==
X-Google-Smtp-Source: AK7set/dgjPcQT+ZnAEcKKpqEFtOfwkM51MutRzzCDQ8hJL5c1DYwiTXltCOcjox7fFpSfEqVYY1CA==
X-Received: by 2002:ac2:4432:0:b0:4cb:41ca:1841 with SMTP id w18-20020ac24432000000b004cb41ca1841mr4599858lfl.48.1678274142049;
        Wed, 08 Mar 2023 03:15:42 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25689000000b004dc4d984911sm2298796lfr.271.2023.03.08.03.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:15:41 -0800 (PST)
Message-ID: <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
Date:   Wed, 8 Mar 2023 12:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
 <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
 <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 8.03.2023 12:02, Johan Hovold wrote:
> On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
>>
>>
>> On 6.03.2023 18:08, Lux Aliaga wrote:
>>> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
>>> compatible for it and modify the config from SM6115 to make them
>>> compatible with the SC8280XP binding
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
>>> ---
>>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> index 318eea35b972..44c29fdfc551 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
>>>  	"vdda-phy", "vdda-pll",
>>>  };
>>>  
>>> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
>>> +	.serdes		= 0,
>>> +	.pcs		= 0xc00,
>>> +	.tx		= 0x400,
>>> +	.rx		= 0x600,
>>> +};
>>> +
>>>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
>>>  	.serdes		= 0,
>>>  	.pcs		= 0xc00,
>>> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>>  	.lanes			= 1,
>>>  
>>> +	.offsets		= &qmp_ufs_offsets_v3_660,
>> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
>> which specify the regions separately (old binding style)?
> 
> No, that should work fine.
So do you think the SM6115 binding could be updated too? Or should
we keep it as-is for ABI purposes?..

> 
> But looks like this series needs to be rebased on 6.3-rc1 as these
> offsets are now already set in mainline.
..Or did you do that already and I can't find it?

Konrad
> 
> Johan
