Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E8C4708C
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 23:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112DB613D1
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 23:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhE1XFc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 19:05:32 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.231]:27744 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE1XFc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 19:05:32 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 98A043E262
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 18:03:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mlWFlMIDFMGeEmlWFlIQVc; Fri, 28 May 2021 18:03:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l0QiEp4fOc8S5QViRiss/YOyViBh54YK1qbk6itUu3Y=; b=hfHFdB2gtMTdm+yR9F0X8Y8+Q7
        WWt4ZoW+rct8us9Qm9jDnJ/hIWmWK1vXP/HixYtmhOmu2IRaNSqrVdkfY4WUfY91EwGDuPm7Am6ar
        sWuhSQ+AUbNrl0HlBVzjAudg3OYKRCRvTEZ+oXJhLAywfG7jkI0U76h8ToOpG/mXHY8N3LQRO1eXc
        n3MPtDG+iL6meF7nnhJPLzOJJ0M3HeEZaUMSvaiP3BeqtHUBonxZrNxCiUNAKZVEyM/nrFTIGmR2C
        /0vBA+O7+f2dOkhDJT9asucCecvfegs6WAaBKVeaD0/pM61wTZQyT9VGe0ZLpQQ5402htBSFbsxo7
        MD+905Vw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:39030 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lmlWD-002pRA-6Z; Fri, 28 May 2021 18:03:53 -0500
Subject: Re: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element
 array in struct virtchnl_vsi_queue_config_info
To:     "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Cc:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20210525231658.GA176466@embeddedor>
 <f3674339c0390ced22b365101f2d3e3a2bf26845.camel@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <85e62583-5db9-ac5c-fdf9-8e3f6a50f3fa@embeddedor.com>
Date:   Fri, 28 May 2021 18:04:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3674339c0390ced22b365101f2d3e3a2bf26845.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lmlWD-002pRA-6Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:39030
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 5/28/21 16:56, Nguyen, Anthony L wrote:
> On Tue, 2021-05-25 at 18:16 -0500, Gustavo A. R. Silva wrote:
>> There is a regular need in the kernel to provide a way to declare
>> having a
>> dynamically sized set of trailing elements in a structure. Kernel
>> code
>> should always use “flexible array members”[1] for these cases. The
>> older
>> style of one-element or zero-length arrays should no longer be
>> used[2].
>>
>> Refactor the code according to the use of a flexible-array member in
>> struct
>> virtchnl_vsi_queue_config_info instead of one-element array, and use
>> the
>> flex_array_size() helper.
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] 
>> https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  include/linux/avf/virtchnl.h | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/avf/virtchnl.h
>> b/include/linux/avf/virtchnl.h
>> index b554913804bd..ed9c4998f8ac 100644
>> --- a/include/linux/avf/virtchnl.h
>> +++ b/include/linux/avf/virtchnl.h
>> @@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
>>  	u16 vsi_id;
>>  	u16 num_queue_pairs;
>>  	u32 pad;
>> -	struct virtchnl_queue_pair_info qpair[1];
>> +	struct virtchnl_queue_pair_info qpair[];
>>  };
>>  
>> -VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
>> +VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
>>  
>>  /* VIRTCHNL_OP_REQUEST_QUEUES
>>   * VF sends this message to request the PF to allocate additional
>> queues to
>> @@ -997,9 +997,8 @@ virtchnl_vc_validate_vf_msg(struct
>> virtchnl_version_info *ver, u32 v_opcode,
>>  		if (msglen >= valid_len) {
>>  			struct virtchnl_vsi_queue_config_info *vqc =
>>  			    (struct virtchnl_vsi_queue_config_info
>> *)msg;
>> -			valid_len += (vqc->num_queue_pairs *
>> -				      sizeof(struct
>> -					     virtchnl_queue_pair_info))
>> ;
>> +			valid_len += flex_array_size(vqc, qpair,
>> +						     vqc-
>>> num_queue_pairs);
> 
> The virtchnl file acts as a binary interface between physical and
> virtual functions. There's no guaruntee that the PF and VF will both
> have the newest version. Thus changing this will break compatibility.
> Specifically, the way the size was validated for this op code
> incorrectly expects an extra queue pair structure. Some other
> structures have similar length calculation flaws. We agree that fixing
> this is important, but the fix needs to account that old drivers will
> send an off by 1 size. 
> 
> To properly handle compatibility we need to introduce a feature flag to
> indicate the new behavior. If the feature flag is not set, we acccept
> messages with the old format (with the extra size). If both the PF and
> VF support the feature flag, we'll use the correct size calculations.
> We're looking to add this and would like to do all the virtchnl
> structure fixes in one series.
> 

Oh OK, I see. In this case, I think something like this might work just
fine:

https://git.kernel.org/linus/c0a744dcaa29e9537e8607ae9c965ad936124a4d

What do you think?

Thanks
--
Gustavo
