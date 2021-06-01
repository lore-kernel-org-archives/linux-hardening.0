Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B15C47080
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A36613AD
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhFAXUc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:20:32 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:43894 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235160AbhFAXUc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 19:20:32 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 25528400E0C92
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 17:43:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oDJal6wi6VBxyoDJalatqb; Tue, 01 Jun 2021 17:56:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R2HquvGjn56KztXhaP1kfmdCBWzUVbxxQVncCbBwj70=; b=tILX86ska22+Sj6DlfjIb2xVoD
        p14G1IEBdmkyOdX6JjBs+EjBqcf8OdrorvklYI2EqP8K6DDl1AepLzCgnCL0MeTXLfTMREaHVFO/t
        ObVT6//1XlCk9qxffbZdYJVE6cX2qNMBK6FJlLX/P2gkGwOpVJMBz5Mxs1qomt6Cc7iw6G3zXhWXv
        358G9ad/nBBuBqKPEeZmabADNwLqIDHKlGxADZSqJrfOE30Bx1WCMbraf7yW21JdQI7Pa2kIBWpnv
        m2WcXJBpZphiPYxb8GQb5NgiGoSuKHc/pQrbtASWY0Jh0I3X7hWlclMi9lfmUukAAGden9hpjcWJI
        Q+SGNkdg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53072 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1loDJX-000ur5-Ax; Tue, 01 Jun 2021 17:56:47 -0500
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
Message-ID: <2aaf5382-3907-ac2a-ebff-a33b308aaf7d@embeddedor.com>
Date:   Tue, 1 Jun 2021 17:57:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b42a6c20-e70d-c56a-795a-072ecc772bf2@embeddedor.com>
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
X-Exim-ID: 1loDJX-000ur5-Ax
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53072
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Friendly second ping: who can take this?

I can add this to my -next branch for 5.14 if you don't mind.

JFYI: We had thousands of these sorts of warnings and now we are down
to just 23 in linux-next. This is one of those last remaining warnings.

Thanks
--
Gustavo

On 4/20/21 15:13, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 3/5/21 03:56, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>> index 83067763c0ec..e1d31c62f9ec 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c
>> @@ -313,6 +313,7 @@ nv50_clk_read(struct nvkm_clk *base, enum nv_clk_src src)
>>  		default:
>>  			break;
>>  		}
>> +		break;
>>  	default:
>>  		break;
>>  	}
>>
