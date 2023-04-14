Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24776C77B72
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Apr 2023 12:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDNMWy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDNMWw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Apr 2023 08:22:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43AB472
        for <linux-hardening@vger.kernel.org>; Fri, 14 Apr 2023 05:22:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy21so2148832ejb.9
        for <linux-hardening@vger.kernel.org>; Fri, 14 Apr 2023 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681474966; x=1684066966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxeb1X5SVRdaG7MUiUMqfSFROSoeue7LGp8CJuQD1LE=;
        b=X/u9ElBnOey6SMlG77ZLji/brPJD2qCwKBPr/9/seZ84aUiZ6nN/pK6pMGvPciV27m
         hQGeHPOaN2tmDhyTp647EMRvNB2ZyzPPJxXl/H+CazoIGZ+cIST3JUW3X4ux+nxZPjD7
         0wdQMA+ziEcfhD8NTbwbZGniB7uHfIh3PoNrR3kWsh3VbPPsNIz5HZgJ0xcF8U4HYYMS
         AXBnQFYTXFAURzfVtMBeSiPnbecHW+fyYlb4Gwwl5WIOw/u5rWX3uCsodSxIPGEpAQ8X
         moTlfxZhoSGo9Gqq2WHd03jopuyFEjDcfcI97xcHn5dnjWt4aZHhil05NTe33WGL5mCx
         lcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474966; x=1684066966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxeb1X5SVRdaG7MUiUMqfSFROSoeue7LGp8CJuQD1LE=;
        b=eJCPqjBO4brCRsJIOAkuBLgnWAfREr002ovJG0UnMqV0P91az6bbB/gZGcqLgUXiRy
         LR+zcKqscRaxnY8ynL/b19hgaeDxuV5G+glcpxtnRPrL8PiQftV0jCbZLZgC2wKLM8Da
         hJaMDN6fAGiXO6qBshhWaesbH9av7w+/XJ3eukzWXYaw3yD4zAyZrjq7u1aRDnx/Ibbm
         SDGS9cwMvj6o1iSBRc36RdWfDxNPS7WtMgHFxp77U1BUiDMhbIEkQfOA42ZNVQsReG/H
         LIJH7y+vsqEzBFzMC1c6cYAeQkbytRX931UmXrSorU182b0fDCg/hV/p4YrkZR39GCcf
         TNew==
X-Gm-Message-State: AAQBX9fm9YI9+ucBg6flsPKNVeYqJdt3uBwAyVcCycyDO5GucFpoDjpZ
        d/IlPmvPd2GsvDo6O3UJLIl/Gg==
X-Google-Smtp-Source: AKy350aW6s+a/rDC4KqsK1yhplkUFIcB94yAkYidmjug8qI0IP+Xng0dA9Sxomr+mKMSyJCJ7/b+jg==
X-Received: by 2002:a17:906:3e86:b0:94a:8ead:c7f with SMTP id a6-20020a1709063e8600b0094a8ead0c7fmr6572378ejj.23.1681474966150;
        Fri, 14 Apr 2023 05:22:46 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k26-20020a17090666da00b0094a64196ed6sm2383275ejp.54.2023.04.14.05.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:22:45 -0700 (PDT)
Message-ID: <5048416b-ed93-30d3-05e3-5797a894dfd0@linaro.org>
Date:   Fri, 14 Apr 2023 13:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/6] remoterproc: qcom: refactor to leverage exported
 minidump symbol
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-7-git-send-email-quic_mojha@quicinc.com>
 <6c01d2fc-3155-0dcd-f473-9cbd75dd69ec@linaro.org>
 <af23d650-3dec-9a51-566c-1eec2fa4b84b@quicinc.com>
 <5a872001-dfcb-5c00-3b13-3c29e6be213b@linaro.org>
 <93f5dc05-a91b-0fe6-c7e2-d3457cba8a1f@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <93f5dc05-a91b-0fe6-c7e2-d3457cba8a1f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 14/04/2023 12:49, Mukesh Ojha wrote:
> 
> 
> On 4/14/2023 5:10 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 14/04/2023 12:14, Mukesh Ojha wrote:
>>>
>>>
>>> On 4/14/2023 4:14 PM, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>>>> qcom_minidump driver provides qcom_minidump_subsystem_desc()
>>>>> exported API which other driver can use it query subsystem
>>>>> descriptor. Refactor qcom_minidump() to use this symbol.
>>>>>
>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>> ---
>>>>>   drivers/remoteproc/qcom_common.c | 13 ++-----------
>>>>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>>>> b/drivers/remoteproc/qcom_common.c
>>>>> index 88fc984..240e9f7 100644
>>>>> --- a/drivers/remoteproc/qcom_common.c
>>>>> +++ b/drivers/remoteproc/qcom_common.c
>>>>> @@ -94,19 +94,10 @@ void qcom_minidump(struct rproc *rproc, 
>>>>> unsigned int minidump_id,
>>>>>   {
>>>>>       int ret;
>>>>>       struct minidump_subsystem *subsystem;
>>>>> -    struct minidump_global_toc *toc;
>>>>> -    /* Get Global minidump ToC*/
>>>>> -    toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, 
>>>>> NULL);
>>>>> -
>>>>> -    /* check if global table pointer exists and init is set */
>>>>> -    if (IS_ERR(toc) || !toc->status) {
>>>>> -        dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
>>>>> +    subsystem = qcom_minidump_subsystem_desc(minidump_id);
>>>>> +    if (IS_ERR(subsystem))
>>>>>           return;
>>>>
>>>> Sorry If I am missing something but I got lost looking at the below 
>>>> code snippet in drivers/remoteproc/qcom_common.c
>>>>
>>>>
>>>> -------------------->cut<-----------------------------
>>>>      subsystem = qcom_minidump_subsystem_desc(minidump_id);
>>>>      if (IS_ERR(subsystem))
>>>>          return;
>>>>
>>>>      /**
>>>>       * Collect minidump if SS ToC is valid and segment table
>>>>       * is initialized in memory and encryption status is set.
>>>>       */
>>>>      if (subsystem->regions_baseptr == 0 ||
>>>>          le32_to_cpu(subsystem->status) != 1 ||
>>>>          le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
>>>>          le32_to_cpu(subsystem->encryption_status) != 
>>>> MINIDUMP_SS_ENCR_DONE) {
>>>>          dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>>>>          return;
>>>>      }
>>>> -------------------->cut<-----------------------------
>>>>
>>>> where does "subsystem->regions_baseptr" for this ADSP minidump 
>>>> descriptor get set?
>>>
>>> Other co-processor such as adsp/cdsp/Mpss has their own way of 
>>> registering their region/segment (mostly they are static known
>>> regions) with minidump global infra and which could be happening
>>> from firmware side .
>> If its happening from firmware side, then that ram phys address range 
>> should be reserved from kernel usage I guess.
>>
>> Do you have more details on where exactly is this reserved from within 
>> linux kernel?
> 
> These regions are inside remoteproc memory carve-out.
> like.
> 
> adsp_mem: memory@85e00000 {
>      reg = <0x0 0x85e00000 0x0 0x2100000>;
>      no-map;
> };

thanks for explaining.

--srini
> 
> 
> 
> remoteproc_adsp: remoteproc@30000000 {
>      compatible = "qcom,sm8450-adsp-pas";
>      reg = <0 0x30000000 0 0x100>;
>             ...
>             ...
>      memory-region = <&adsp_mem>; <==
> 
> -Mukesh
> 
>>
>>
>> --srini
>>
>>>
>>>
>>> -Mukesh
>>>
>>>>
>>>>
>>>> --srini
>>>>
>>>>> -    }
>>>>> -
>>>>> -    /* Get subsystem table of contents using the minidump id */
>>>>> -    subsystem = &toc->subsystems[minidump_id];
>>>>>       /**
>>>>>        * Collect minidump if SS ToC is valid and segment table
