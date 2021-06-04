Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B7DC4708F
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 04:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246D7611ED
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 04:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFDE3q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:29:46 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:18064 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFDE3p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 00:29:45 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 17C2D2CA945
        for <linux-hardening@vger.kernel.org>; Thu,  3 Jun 2021 23:27:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p1R9lAzwJ1iQOp1R9lVK2D; Thu, 03 Jun 2021 23:27:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tmKbVxD5QRNxYgvET2f9iyU8zdJK3B5xkoywFvU0nbk=; b=hZL3R8CSFrFaOxPOz5slqALI+k
        roRKk+v9sPJQ9gnFQc9uOepXmRAWoulACY5m+961nuL24ylRa+zDiI3aV6Hpvz7W2qTmAWuoZ6c6w
        XwVgMuhufVFdLPr/FCjiMVUUDl79AYrZLli1NuXUM0HJstNLNGNh9zhaMUutfKij2R3ooRKgwSAYE
        yYpqaoTzBL2/lOTqJQScSplI927IYPVYpJr1cZYGINYW7l4GfK5t7hoPVQxv9itrNbnQF/NSIfjCO
        qIXDhBOP/yWNUlnbHLIc/QwnqJ6XY9zv0PzEI60ulZ8ymInArz/9XP9457v2SXq2sWFYCEeuy44Wq
        2/JgdJIg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34478 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lp1R5-00182o-6d; Thu, 03 Jun 2021 23:27:55 -0500
Subject: Re: [PATCH RESEND][next] drm/nouveau/clk: Fix fall-through warnings
 for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20210305095609.GA141907@embeddedor>
 <b42a6c20-e70d-c56a-795a-072ecc772bf2@embeddedor.com>
 <2aaf5382-3907-ac2a-ebff-a33b308aaf7d@embeddedor.com>
Message-ID: <f6834e09-c329-8546-19c1-d58adbf0f36a@embeddedor.com>
Date:   Thu, 3 Jun 2021 23:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2aaf5382-3907-ac2a-ebff-a33b308aaf7d@embeddedor.com>
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
X-Exim-ID: 1lp1R5-00182o-6d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:34478
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 6/1/21 17:57, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly second ping: who can take this?
> 
> I can add this to my -next branch for 5.14 if you don't mind.
> 
> JFYI: We had thousands of these sorts of warnings and now we are down
> to just 23 in linux-next. This is one of those last remaining warnings.
> 
> Thanks
> --
> Gustavo
> 
> On 4/20/21 15:13, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this, please?
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 3/5/21 03:56, Gustavo A. R. Silva wrote:
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>> by explicitly adding a break statement instead of letting the code fall
>>> through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>>> index 83067763c0ec..e1d31c62f9ec 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>>> @@ -313,6 +313,7 @@ nv50_clk_read(struct nvkm_clk *base, enum nv_clk_src src)
>>>  		default:
>>>  			break;
>>>  		}
>>> +		break;
>>>  	default:
>>>  		break;
>>>  	}
>>>
