Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75647C76196
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjDFSaC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbjDFSaB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 14:30:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4B6196
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 11:29:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so51964362lfe.10
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Neijv2zq96R0GfdQjQwNKcSFKV86CYJRcfc1aaFu1qk=;
        b=XlOX4iBsYDzB8wgJK6e2EygD58sqmxulgjX5qqPLTfJEt8z15r/HdkriynKKcYX2Bq
         Msof2eYI5neCNb+upoBnjZHBmUVqRYQHHGYJctHDxezQ4Cb9QfWZzNAq/MetS9UXCAgd
         AdnCCJmHS/gE6xkAUmP7rR5yETIcYFo5XIMXKbK+khXUj12Jqx5BVIqCi0XL/f+/Wwv6
         lAbd/OFVk9+4dNyuccCRWlfk48MwAQMQga7khS4+oI1Gq1pvaRyvlMYYRM5Uw+Wr8wa5
         4FsvJziidvPZmQeAMtyo6xWUS1iLQaI5TSLJ/dGUfel7N/MHZrd95B0d5YoeFnrHlrJk
         r3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Neijv2zq96R0GfdQjQwNKcSFKV86CYJRcfc1aaFu1qk=;
        b=45JUHN7fjoU9TdFTz5bRsLcKVkltLqK6xbDfEDzrzDcehakoizj+IE0oQX+R7GXSVs
         Yq52iGT8TX4+zhaxf7MAerkdmiBjVgyKgBA+ELAjaCmhdt906tGrD+pi/4i5ALl2/7sc
         rf316BGT56hN1wwMwrmwUpLOzUTdRKOS8VUKn/2u/kpLZj8cylrI6Ep1NDZWSDveZ417
         Eq232vG7N4T0Qc0kFAAf4fokuT+6yz6u7FCHY9iyXSv9ZNlUYa5TSMOUtupnETgP5qWf
         M/pVdfPQof8P1ojoELes6cW1ox6vMRpb7XtdWMC66MvqlCWNd3VAYHpIyVED+AdErLzR
         FzFA==
X-Gm-Message-State: AAQBX9eq06kkxjZVjr3Ozi7Q/7XQcoVHVft2qDwifnj3iEDV7HEZPxHt
        bRImkpC3NtdaG9n55XWwcRQ+9Q==
X-Google-Smtp-Source: AKy350ZEODeEm9sOvgyuO0IIzT81OsrB7gbD3ClS6luG0xT13OBKwnwD8262UKlr8jcIal295NttLw==
X-Received: by 2002:a19:f508:0:b0:4db:3a70:e9f3 with SMTP id j8-20020a19f508000000b004db3a70e9f3mr35061lfb.69.1680805797945;
        Thu, 06 Apr 2023 11:29:57 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id r15-20020ac25a4f000000b004e848782e2esm371641lfn.57.2023.04.06.11.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:29:57 -0700 (PDT)
Message-ID: <eacc380a-aa33-5b1d-0a11-124b584cd1aa@linaro.org>
Date:   Thu, 6 Apr 2023 20:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm6115-j606f: Add ramoops node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <20230406-topic-lenovo_features-v1-1-c73a5180e48e@linaro.org>
 <9554be2b-c80d-8c5b-48e3-2508a7b4ecd1@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9554be2b-c80d-8c5b-48e3-2508a7b4ecd1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6.04.2023 19:54, Dmitry Baryshkov wrote:
> On 06/04/2023 18:25, Konrad Dybcio wrote:
>> Add a ramoops node to enable retrieving crash logs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> index 10c9d338446c..fd064899791c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> @@ -52,6 +52,17 @@ key-volume-up {
>>               wakeup-source;
>>           };
>>       };
>> +
>> +    reserved-memory {
>> +        ramoops@ffc00000 {
>> +            compatible = "ramoops";
>> +            reg = <0x0 0xffc00000 0x0 0x100000>;
>> +            record-size = <0x1000>;
>> +            console-size = <0x40000>;
> 
> no ftrace-size?
It could use some!

> 
>> +            ecc-size = <16>;
>> +            no-map;
> 
> I see that other ramoops defines are not marked with no-map. Is there any reason for that?
Hm, not really. I can get rid of it for v2.

Konrad
> 
>> +        };
>> +    };
>>   };
>>     &dispcc {
>>
> 
