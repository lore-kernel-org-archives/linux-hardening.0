Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B7C47083
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A1160FEE
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFBU4y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:56:54 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.80]:15271 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229881AbhFBU4F (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 16:56:05 -0400
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 16:56:05 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0A963EA275
        for <linux-hardening@vger.kernel.org>; Wed,  2 Jun 2021 15:33:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oXY1lhUyIx8DpoXY1lRCfc; Wed, 02 Jun 2021 15:33:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+MhsQd5tiNlUqXw8oT14rjbKzGf8+RSzY0HUwHrz/28=; b=lWaAGL4hOhZnX/8WEY+pBwlfZu
        silUDulrgxJkD4EN9ozzXyLMBN7oiBGTdWlanUSfeJUX0fJsSWPQF3r90THiDhWSn+Mq5KIUJvXcc
        3Sdx1CLFU+/UIseyDTPiZ5G2HMMzC6EIrN2YDV9KqNhc2/cB+J7oWAemXQlrU6bX4T95D5esrC77+
        rN0Hg/OwBRB42vUhQ34Os5Z7fzv2tbvDOnxBE9AyBPiV1P2Fea7Gp8KomRbuBbkDd0ghF9uun6SQ1
        6wpG816qVUrZ2wsWUqd15rxSRQSdJEAGw8WOlYo9NEqkkoAeF+wl+gevBv9bAILf9LkJ1mpW13XEI
        nqpoapmQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:52430 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1loXXw-002fpS-Uf; Wed, 02 Jun 2021 15:33:00 -0500
Subject: Re: [PATCH][venus-for-next-v5.14] media: venus: hfi_cmds: Fix packet
 size calculation
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210601184616.GA23488@embeddedor>
 <202106021254.39A1561075@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e40f4067-82e2-31ff-0694-375a59f949de@embeddedor.com>
Date:   Wed, 2 Jun 2021 15:34:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202106021254.39A1561075@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1loXXw-002fpS-Uf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:52430
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/2/21 14:55, Kees Cook wrote:
> On Tue, Jun 01, 2021 at 01:46:16PM -0500, Gustavo A. R. Silva wrote:
>> Now that a one-element array was replaced with a flexible-array member
>> in struct hfi_sys_set_property_pkt, use the struct_size() helper to
>> correctly calculate the packet size.
>>
>> Fixes: 701e10b3fd9f ("media: venus: hfi_cmds.h: Replace one-element array with flexible-array member")
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> BTW... it seems that a similar problem is present in
>> https://lore.kernel.org/linux-hardening/20210211001044.GA69612@embeddedor/ 
>> and that is what is causing the regression. I will send v2 of that
>> patch, shortly. Thanks.
>>
>>  drivers/media/platform/qcom/venus/hfi_cmds.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index 11a8347e5f5c..c86279e5d6e8 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -27,7 +27,7 @@ void pkt_sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>>  {
>>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>>  
>> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
>> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);
> 
> I think this should be "1" not "2".
> 
> (i.e. there is a single "data" item, followed by an entire *hfi (which
> starts immediate after data[0]).

Yeah; I see your point. Here I just wanted to preserve the exact same size
as the original code, which turns out has a "benign" off-by-one issue.

I'll fix it up and respin.

Thanks!
--
Gustavo

> 
>>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>>  	pkt->num_properties = 1;
>>  	pkt->data[0] = HFI_PROPERTY_SYS_IDLE_INDICATOR;
>> @@ -39,7 +39,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>>  {
>>  	struct hfi_debug_config *hfi;
>>  
>> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
>> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);
> 
> Same here.
> 
>>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>>  	pkt->num_properties = 1;
>>  	pkt->data[0] = HFI_PROPERTY_SYS_DEBUG_CONFIG;
>> @@ -50,7 +50,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>>  
>>  void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode)
>>  {
>> -	pkt->hdr.size = sizeof(*pkt) + sizeof(u32);
>> +	pkt->hdr.size = struct_size(pkt, data, 2);
> 
> This looks correct.
> 
>>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>>  	pkt->num_properties = 1;
>>  	pkt->data[0] = HFI_PROPERTY_SYS_CONFIG_COVERAGE;
>> @@ -116,7 +116,7 @@ void pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>>  {
>>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>>  
>> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
>> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);
> 
> Also 1.
> 
>>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>>  	pkt->num_properties = 1;
>>  	pkt->data[0] = HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL;
>> -- 
>> 2.27.0
>>
> 
