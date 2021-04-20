Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5FC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A47F613C0
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhDTURj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:17:39 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.130]:29337 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhDTURh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:17:37 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C26D317F47B
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:17:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwnxlE9PCw11MYwnxli7vj; Tue, 20 Apr 2021 15:17:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F5p4y3pPoJpbflq7AGI1HGvEHHOc3V0/dn0FtRdvyVM=; b=uKF3fvHRTs/RZaqnTRchNI/UnV
        +Xvq8dLa82Hu+Br0wFIxmWbnbPw21YQo64g5nNZ6vohiEN/+4e0ErqWQl+XWcisq3+sEz8U6qQ/iD
        lcEgMUYt1gDI7I5twle7QrNcdmE3UHCO5QsPlD3pz7vJOEwYAV8ZdZt1zbmOyMVXpc6l8XzP15vmQ
        +S26ytgri7Rd/HaMdaI8EZXGVLlbj1hU5j65z/mz+rZx4kn/fTDgDen4t0xfF63oDPRbZyxh3ljZ1
        RsKv1TC4UC0fncNG/SX7xFwQqs4ntpJ8E1U0W+1YMUsg0JXi0cTkvsFhOCtuj57Gu/N+hi2ncAGQS
        LRdFydJQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49000 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwnv-002qjo-A9; Tue, 20 Apr 2021 15:17:03 -0500
Subject: Re: [PATCH 070/141] atm: fore200e: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <613a064fad28ee2afbc14d9a81d4a67b3c1634f7.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <511007ca-b8d4-239e-b861-3b661035923a@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:17:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <613a064fad28ee2afbc14d9a81d4a67b3c1634f7.1605896059.git.gustavoars@kernel.org>
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
X-Exim-ID: 1lYwnv-002qjo-A9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49000
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 123
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:34, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough pseudo-keyword.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/atm/fore200e.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
> index 9a70bee84125..ba3ed1b77bc5 100644
> --- a/drivers/atm/fore200e.c
> +++ b/drivers/atm/fore200e.c
> @@ -423,6 +423,7 @@ fore200e_shutdown(struct fore200e* fore200e)
>  	/* XXX shouldn't we *start* by deregistering the device? */
>  	atm_dev_deregister(fore200e->atm_dev);
>  
> +	fallthrough;
>      case FORE200E_STATE_BLANK:
>  	/* nothing to do for that state */
>  	break;
> 
