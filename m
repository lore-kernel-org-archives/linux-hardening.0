Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB05C43461
	for <linux-hardening@archiver.kernel.org>; Wed, 12 May 2021 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0048613DF
	for <linux-hardening@archiver.kernel.org>; Wed, 12 May 2021 11:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELLlI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 May 2021 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhELLlH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 May 2021 07:41:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B3C061760
        for <linux-hardening@vger.kernel.org>; Wed, 12 May 2021 04:39:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so34562553ejo.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 May 2021 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4hxdcbxEg+Gvm/uEtZiedODpWJAxy3rdveR0HoL0Nw=;
        b=w7NB/ViQ3y4V4xJCR4F4VoktRzv8QQfDbni4mqcpgpWmVJZ16G2VZmfAuKMCUgCO62
         zA5sF7C/DNM8IpImQj42qfKda8tSi6ihBky/SsbT/NgOqH7orLANlNXAqUTj+bD9cMtN
         tSD9RZQgY17b3Vrv3pcLDl8ojPHBIIcQiAstjkV2lQIUQoQo2w+DkUqDAnDKQDBUaMey
         23pe5ANPB1wB35GSl0vJx7EcH/7lDk+aZR0JzPBtl5akqoDhtJvS2QfaQ+1VEfDPMNBt
         qQPrLkr3CpumgvcH/1c1POpTV7pF2sHN5PU4MRH7bkf5hv++HE1J58jYepRcuV1dOCCa
         M2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4hxdcbxEg+Gvm/uEtZiedODpWJAxy3rdveR0HoL0Nw=;
        b=gpB+Im1UTGY1Ql/UJDAI9xozTavLJG53Obd5Cw6too1tJJsPbdymbyCz6/b5oSgiSg
         RCoqn/uFLJjRD1glC3AvDJcfQmf03ZGPhNRZmUBImODKF6t5Z8jo6HDjNsUtdtvlBzzH
         fk8jn1HhWy8VfN4hZEWFYGt0tk60KpYCMVXkNjqc+9eQF0/NIFrBf9fEBEVFLYJUiGrE
         EcOtfRLBPDcYT70EPnqm8HgR4/uIxah5GlPE04qg3ESC1wy3lEJGzQ0Hgww6/rndW74y
         hiz7kce6g5DxcxKkfTZfFnBMIePGh9Cw/1HIbznfgdDkpY5GhtzW0k6ICRKsCoRH+1/f
         9Srw==
X-Gm-Message-State: AOAM533ZKnK38SBmASIleNJzYTMpnGfBIfbtXq7ELFByo5iciaQUQCil
        gjJX7PlrDoeIi/JKRZPe5OLWhG9Vd1/hjw==
X-Google-Smtp-Source: ABdhPJwy96a8Lx3Fajpk0X8jPlkI807VDdUnjLLUnPIkZBlG0r4gS0vyJlmfImEX7Ce2ws6x1dGxeQ==
X-Received: by 2002:a17:906:9141:: with SMTP id y1mr38725036ejw.111.1620819597231;
        Wed, 12 May 2021 04:39:57 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id y2sm13775670ejg.123.2021.05.12.04.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 04:39:56 -0700 (PDT)
Subject: Re: [PATCH][next] media: venus: hfi_msgs.h: Replace one-element
 arrays with flexible-array members
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210211001044.GA69612@embeddedor>
 <bf31beab-dc36-23e9-757f-9729be59f7b2@embeddedor.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <de8538ad-48d8-7a3c-af4f-ab31ee2da761@linaro.org>
Date:   Wed, 12 May 2021 14:39:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bf31beab-dc36-23e9-757f-9729be59f7b2@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 5/11/21 6:46 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> We are about to be able to globally enable -Warray-bounds and, these are one of
> the last out-of-bounds warnings in linux-next.
> 
> Could someone take this, please?

This one introduces regressions, so I cannot take it. It needs some more
work.

> 
> Thanks
> --
> Gustavo
> 
> On 2/10/21 18:10, Gustavo A. R. Silva wrote:
>> There is a regular need in the kernel to provide a way to declare having
>> a dynamically sized set of trailing elements in a structure. Kernel code
>> should always use “flexible array members”[1] for these cases. The older
>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> Use flexible-array members in struct hfi_msg_sys_property_info_pkt and
>> hfi_msg_session_property_info_pkt instead of one-element arrays.
>>
>> Also, this helps with the ongoing efforts to enable -Warray-bounds by
>> fixing the following warnings:
>>
>>   CC [M]  drivers/media/platform/qcom/venus/hfi_msgs.o
>> drivers/media/platform/qcom/venus/hfi_msgs.c: In function ‘hfi_sys_property_info’:
>> drivers/media/platform/qcom/venus/hfi_msgs.c:246:35: warning: array subscript 1 is above array bounds of ‘u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>   246 |  if (req_bytes < 128 || !pkt->data[1] || pkt->num_properties > 1)
>>       |                          ~~~~~~~~~^~~
>> drivers/media/platform/qcom/venus/hfi_msgs.c: In function ‘hfi_session_prop_info’:
>> drivers/media/platform/qcom/venus/hfi_msgs.c:342:62: warning: array subscript 1 is above array bounds of ‘u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>   342 |  if (!req_bytes || req_bytes % sizeof(*buf_req) || !pkt->data[1])
>>       |                                                     ~~~~~~~~~^~~
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/109
>> Build-tested-by: <lkp@intel.com>
>> Link: https://lore.kernel.org/lkml/6023dd80.MmTeFf8SzwX0iK7%2F%25lkp@intel.com/
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/media/platform/qcom/venus/hfi_msgs.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h b/drivers/media/platform/qcom/venus/hfi_msgs.h
>> index 526d9f5b487b..e2d2ccfbdd24 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.h
>> @@ -113,7 +113,7 @@ struct hfi_msg_sys_ping_ack_pkt {
>>  struct hfi_msg_sys_property_info_pkt {
>>  	struct hfi_pkt_hdr hdr;
>>  	u32 num_properties;
>> -	u32 data[1];
>> +	u32 data[];
>>  };
>>  
>>  struct hfi_msg_session_load_resources_done_pkt {
>> @@ -233,7 +233,7 @@ struct hfi_msg_session_parse_sequence_header_done_pkt {
>>  struct hfi_msg_session_property_info_pkt {
>>  	struct hfi_session_hdr_pkt shdr;
>>  	u32 num_properties;
>> -	u32 data[1];
>> +	u32 data[];
>>  };
>>  
>>  struct hfi_msg_session_release_resources_done_pkt {
>>

-- 
regards,
Stan
