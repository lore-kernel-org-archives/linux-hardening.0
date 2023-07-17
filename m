Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B4C00528
	for <linux-hardening@archiver.kernel.org>; Mon, 17 Jul 2023 08:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjGQICX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Jul 2023 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGQICW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Jul 2023 04:02:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFD120
        for <linux-hardening@vger.kernel.org>; Mon, 17 Jul 2023 01:02:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fc8049fd8bso6332376e87.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Jul 2023 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689580938; x=1692172938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybDWeGYh7QkWqKSuqnHy7+o3sCCASBcWk0Zen0RPF2c=;
        b=oQS7I5usrfXc9q0gkIN9Y65z8MX729Uvxqkggz/yHgR5zI/SEHh5DYqV2rdAXHZz6S
         xrXBD9MLtRN+12vp9l0UM+LnEfi6o3Pi+51jaJoKcnUt8mckvAdye4NiO4QMUPytFTk8
         5VN9v1rLHdxhj1u1Gk82EsVI2IRVURW7KldC3dBbuOsVBCk8nBIV3qqIvLHSJIiH4eH+
         Y2lOsr+kTeyQdF6QUXGRFSz6/nkz3mBMy5Xn5+uLI8OG2beLLYHveAtf0TC5lx5fuctf
         mGhsHS38S22KiPxT4CmPMHzmrrVDQUc6snqRe0pDy8L8YgdXFDILzekGXsgw3MNM7uzn
         eSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580938; x=1692172938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybDWeGYh7QkWqKSuqnHy7+o3sCCASBcWk0Zen0RPF2c=;
        b=e1XoE4n+8PAdIVlzTmNKUva4+DWZJebZPlDGwz2BijweTsEXxu0GDI0oAjrf4iBsSz
         MPi4MM1tu3OnNypeIBl7OiLbz5OOvJojodqtMDmdTsfcPpI3G7KPqL75vxyivmhjD9nD
         EISIdIXfA8p2T6WSsJB5AL6uWrL5LponvusFii63sg1R7PbZWoq70kpoVP7s8G0+3bF9
         GKVQ/PwUU2+aWWkCQzH+9CeZfH+BaB+IslL50XQPHXHwyyJGt0jE1pcAmR0gV36Nvxhg
         KpuLO3NJ6S/k/dIbYClLt8R5JmfEmQyUGAA4TPu4kzzaUDJVooFfFUQrZT/sGDyZGYiB
         e9FA==
X-Gm-Message-State: ABy/qLZuaJwfCfw7ZzBokQ60UEDPQXkU/jaOX9mIV0OZ/e/JIKuahosZ
        Y+2hFtQoJzguJQpEjx24zJx1cQ==
X-Google-Smtp-Source: APBJJlGaWSnDlZyb6JY1n2wdxR3Lgs52I2miQt9O/go6p3/cQ8xCwjp0Gz89lXxwN9nZK8HZKTWn2w==
X-Received: by 2002:a05:6512:3c92:b0:4fa:5e76:7ad4 with SMTP id h18-20020a0565123c9200b004fa5e767ad4mr9100751lfv.10.1689580937881;
        Mon, 17 Jul 2023 01:02:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640206d000b0051e0bf5807bsm9518544edy.49.2023.07.17.01.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:02:17 -0700 (PDT)
Message-ID: <128bcf0e-9b74-0df1-6366-d553475fbad7@linaro.org>
Date:   Mon, 17 Jul 2023 10:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: (subset) [PATCH v3 00/18] Add basic Minidump kernel driver
 support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <168945921478.1805013.7211960599963339759.b4-ty@kernel.org>
 <ZLSWTaMtr9UGmrDy@p14s>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZLSWTaMtr9UGmrDy@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 17/07/2023 03:15, Mathieu Poirier wrote:
> On Sat, Jul 15, 2023 at 03:13:34PM -0700, Bjorn Andersson wrote:
>>
>> On Wed, 03 May 2023 22:32:14 +0530, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined data
>>> for first level of debugging on end user devices running on Qualcomm SoCs.
>>> It is built on the premise that System on Chip (SoC) or subsystem part of
>>> SoC crashes, due to a range of hardware and software bugs. Hence, the
>>> ability to collect accurate data is only a best-effort. The data collected
>>> could be invalid or corrupted, data collection itself could fail, and so on.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [01/18] remoteproc: qcom: Expand MD_* as MINIDUMP_*
>>         commit: 318da1371246fdc1806011a27138175cfb078687
>>
> 
> Krzysztof asked for modifications on this patch.

I guess it is fine, no big issue.

Best regards,
Krzysztof

