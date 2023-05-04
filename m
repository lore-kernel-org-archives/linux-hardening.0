Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A0C77B7C
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 16:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEDQeu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEDQeq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 12:34:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911C30C3
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 09:34:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a34a14a54so139592366b.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683218075; x=1685810075;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nszTvAg6fphYuzaPSYnd3w5WMHZrZJJaEUI5zTnvsx4=;
        b=dhxD37R48wLSmMqoo+yOvb619nXn47MDnAlUoME6jFo/UJ4C+dA44spBJdEsQXo/BB
         ZJATJlWpYr1F5QCJ6s4RbliW9MHK/oFSkY0nYFR4f0yiNMmYfywayOEQedzYAybRAfgf
         l926ylMz4mrzTXBojvCkJGyiiK4Nt/Z5vnxxDPKwxpzhN8BnWyhI/3Z3fqL0sARvjGL3
         nEqAjz6mwz7o5kO33wL8e4wrte01H86lLz7FmFbBcYDnJfOE+HEmf+MVoK+XrfQByDpC
         YLwdqYNtyB4F+0X8T4psmNmW2EkRXtWJoHu47vmhJk6a1mzVnGPmJcViYA00Qi45MKpn
         NCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218075; x=1685810075;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nszTvAg6fphYuzaPSYnd3w5WMHZrZJJaEUI5zTnvsx4=;
        b=gk6m8OnQ06g7A6kNwew49aEJXcR32Sbp8yjryDQiB49QvLI+BFWIRmdkPHWVu3R+zg
         UCt4c4BJUmBfHoGmi1UcZYUfyi9gfrGrDxJGnScKYhASkKBnQcifZGWM9zz3ULKkTO0n
         HSEFq8+/he1wGKazY0BN9L9rb6LYTNJOGj10hZBMKZVpLZfm8gJ4h0sR+Uq9/9c6VUoH
         xWrq05Wj1GLCDloSuqTyfyc3U9ACutHB/FpOCiVUBSNG04/h7P4P4jCCVml5zkjf3LiQ
         NRmVtXOqoSMJ/ZXThELOfTpgwM9TIxii64du2F9QQ6FHp6on04kp4zWyPoxcYNqGWoeI
         eriw==
X-Gm-Message-State: AC+VfDzw9Mw93P2pglqJ0Xp6fWOIDnAhXuSbWgeWqALgd0U+55X6ZqM2
        kfXiZEJ701iM4pyZ5go/M4HsCg==
X-Google-Smtp-Source: ACHHUZ7UTw09BUZkzS6zw6s3B83bTJ2iIzEWu8O3/gcd5QbYIqL3Pcttt0DLEfeqNgf6m6beVNV0ow==
X-Received: by 2002:a17:907:a412:b0:961:be96:b0e0 with SMTP id sg18-20020a170907a41200b00961be96b0e0mr6847612ejc.73.1683218075231;
        Thu, 04 May 2023 09:34:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bdb9:99c4:33a5:6114? ([2a02:810d:15c0:828:bdb9:99c4:33a5:6114])
        by smtp.gmail.com with ESMTPSA id n20-20020a1709065db400b00965b439027csm802967ejv.195.2023.05.04.09.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:34:34 -0700 (PDT)
Message-ID: <500e5abc-fb71-8468-a6b0-3ced2676b57c@linaro.org>
Date:   Thu, 4 May 2023 18:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
 <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
In-Reply-To: <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 04/05/2023 17:21, Krzysztof Kozlowski wrote:
>>>
>>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	__md = md;
>>>
>>> No. This is a platform device, so it can have multiple instances.
>>
>> It can have only one instance that is created from SMEM driver probe.
> 
> Anyone can instantiate more of them.... how did you solve it?

To clarify - sprinkling more of singletons makes everything tightly
coupled, difficult to debug and non-portable. You cannot have two
instances, you have to control concurrent initialization by yourself in
each of such singletons.

I understand sometimes they are unavoidable, for example when this does
not map to hardware property. However here you have the parent - smem -
which can return you valid instance. Thus you avoid entire problem of
file-scope variables.

Best regards,
Krzysztof

