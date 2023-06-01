Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9CC77B7A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFARDs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFARDr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 13:03:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E22D1
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 10:03:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97458c97333so29077266b.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685639024; x=1688231024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcZQvaUeP8ZliN22XvourXFhBfMMyu6zMeulrUEm0zk=;
        b=aX4MefYccb/iozf3MwpC42dH5j3LsU1KvHrxvDwrG3rGOz5hI+Es1cV+sf5NaOiex8
         H/5RfambBmNAW5nU7cE9nHd3DtVfzhDUZUSNvAkDo1p0lELhjEdxOPSm8gG7r0zd9ODj
         pBy1tCRGEPV9JcjSVlYb6Bz4ZTqX4YBJ14gxLT99dEgpp5Fgw7+AHBfCaGyCn1MH+loV
         VrHWlrS/LdQKeUBzMyDAxdreWWHunH3DzyD9/57WyzlS1bPsu46lO8jkm8sRclt6SYcn
         Id9cLfkrxWbNCdvoRVcO5E47x0i1ZwOCsTG15Nke5sGtKej1xYlhD8IXQ4k5cE+OsI0A
         6TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639024; x=1688231024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcZQvaUeP8ZliN22XvourXFhBfMMyu6zMeulrUEm0zk=;
        b=ldcuNRqIw41ND5wowlz0SePP8tLz9AFuoadUVxfiuLPFm3xxoBVJ0cuz5IxExV7scn
         0zwhuOoVqvmL1cSIhYav4dMLJ+0L5jo9F0ZgTWoCXLSYs976HZzi3w35kt9ls5iuRqNd
         6XRx072W+3nlNSGxBcJuCxXzbIeeQokQRKXbMv76MJlrgPxjv+fNvJ43nTQsS2nqubWw
         +UDYQltPB8oVoyCrv8O5yoLPLI4T1s0cft6oWFTMdnOz7HFdwJWE3VOu9hSIYTJ3c4UZ
         LdPime6KkJjYFoSqBEeM3aS5eVomCSoQy2AjaIL242gI2c/0FO/UoVJf3X84jbFx584L
         czlg==
X-Gm-Message-State: AC+VfDwHgeAKnaxJlw4W9J8oM0v4Cxb1NPTwAX+QwnVDtEc22wuxJLC4
        fGPJGJoGNaHS/Sgbtur9Znxs9w==
X-Google-Smtp-Source: ACHHUZ7fOpjuGGqpiCVDmXgek3ciM6877wAMwgJFajxAb4WP11OHWVfqpecCjSlmlvG8ixE2CB7zCQ==
X-Received: by 2002:a17:907:1c86:b0:96f:2b40:4503 with SMTP id nb6-20020a1709071c8600b0096f2b404503mr8219311ejc.74.1685639024521;
        Thu, 01 Jun 2023 10:03:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906688d00b0096f641c6167sm10683441ejr.181.2023.06.01.10.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:03:43 -0700 (PDT)
Message-ID: <5d9cf207-7984-6dd0-731f-e301aa7b25c2@linaro.org>
Date:   Thu, 1 Jun 2023 19:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, azeemshaikh38@gmail.com
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
 <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 31/05/2023 01:06, Kees Cook wrote:
> On Tue, 23 May 2023 02:20:23 +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>> No return values were used, so direct replacement is safe.
>>
>> [...]
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
>       https://git.kernel.org/kees/c/4e4424b20cc4

Please drop. This was already fixed and is in linux-next since almost a
month:

https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/commit/?h=for-next&id=5dfd3c73ff81618fee0ef682b6fd7779863f41e4

> 

Best regards,
Krzysztof

