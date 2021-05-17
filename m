Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC28C433ED
	for <linux-hardening@archiver.kernel.org>; Mon, 17 May 2021 23:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD48761285
	for <linux-hardening@archiver.kernel.org>; Mon, 17 May 2021 23:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbhEQXwr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 19:52:47 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:30553 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344636AbhEQXwr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 19:52:47 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id BE200400C52C3
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 18:51:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id in1El37AYvAWvin1ElD64B; Mon, 17 May 2021 18:51:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vsl5M1X4OoHN1YwMD8WyUFAAf2JhYogNHcX5t0D2Pdc=; b=oLEd031P02gZBA12kMB/mDaFfK
        Uj50JhPkBb7gwFoZBRmFg6PqtXbo2YcJGWGT8C6DG1a42VlgyiRvTVqDDiNvH6bzT0fO7gGjjKMEq
        q1DHp74/8hh1bwAMs1gk4g5KA5BTVF8oT3LrxTYHgFob7sSuURWS4KJSoEeBwKPEzItu32t3nsf2w
        zMTW+idRN5iAKtmDOaFrN6qEoTy7izaDS3ngtArbKhJJZPyzIUNxf3tP9I+kHSJeJzjiPbS/Xjpfi
        Riht8Gvpnu+lmr67B1DCFID6dyAvnnq9330DAK3WZM6XxAE4ax+fpuK9LBGGs5aQ2KOE1nZn775wk
        GbyNhfog==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53320 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lin1C-001o5H-BV; Mon, 17 May 2021 18:51:26 -0500
Subject: Re: [PATCH 070/141] atm: fore200e: Fix fall-through warnings for
 Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <613a064fad28ee2afbc14d9a81d4a67b3c1634f7.1605896059.git.gustavoars@kernel.org>
 <511007ca-b8d4-239e-b861-3b661035923a@embeddedor.com>
Message-ID: <4191592c-baa0-a642-d1ca-2d97d904bd79@embeddedor.com>
Date:   Mon, 17 May 2021 18:52:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <511007ca-b8d4-239e-b861-3b661035923a@embeddedor.com>
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
X-Exim-ID: 1lin1C-001o5H-BV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53320
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

I've added this to my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:17, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:34, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a fallthrough pseudo-keyword.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/atm/fore200e.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
>> index 9a70bee84125..ba3ed1b77bc5 100644
>> --- a/drivers/atm/fore200e.c
>> +++ b/drivers/atm/fore200e.c
>> @@ -423,6 +423,7 @@ fore200e_shutdown(struct fore200e* fore200e)
>>  	/* XXX shouldn't we *start* by deregistering the device? */
>>  	atm_dev_deregister(fore200e->atm_dev);
>>  
>> +	fallthrough;
>>      case FORE200E_STATE_BLANK:
>>  	/* nothing to do for that state */
>>  	break;
>>
