Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013FDC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 01:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51E061354
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhERBJt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 21:09:49 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.107]:48628 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345371AbhERBJs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 21:09:48 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6A7F59891
        for <linux-hardening@vger.kernel.org>; Mon, 17 May 2021 20:08:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ioDjlpy2mDedfioDjl3Pxg; Mon, 17 May 2021 20:08:27 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9W4PZScGBnM9PEHtZk3wkq4HEcWAcp1d4Av336J8J/o=; b=GrxwLzwbJaGYsZn+DODYhFGXL9
        oCXyyaZxQRRAV29AJwx0SR03wTlu20HF7BywFY9hgQx09Xq99fL8IIm85f9DL96vVjIehVO/ZGe4f
        iLyEGJxbyY9oL65EbrhYQdWkw543BYZBH2P6We5aNUgPnnUv9guSe6f7rd619/GbOwt0liE0u5elS
        40fqY8SY+orZsdonQg1+BnpV3HGgiVFaoiNqRh/95abd0OFtkBMMIA0zpeMaKgEV9vTtdelScd76V
        wPSbC6tJ0BdQQtUx15uBTTHdYAVDxREP2xHZxc6myk80YT4Joi0VeZKsSJDhUh38npUC993cgulyD
        6WlYD69w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53620 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lioDg-003AZd-EZ; Mon, 17 May 2021 20:08:24 -0500
Subject: Re: [PATCH RESEND][next] tipc: Fix fall-through warnings for Clang
To:     "Xue, Ying" <Ying.Xue@windriver.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20210305092504.GA140204@embeddedor>
 <DM6PR11MB3964D94D53B98CBA9A25892484479@DM6PR11MB3964.namprd11.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <f56b0e54-35e9-dc42-88ac-878ee3c04a9d@embeddedor.com>
Date:   Mon, 17 May 2021 20:09:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3964D94D53B98CBA9A25892484479@DM6PR11MB3964.namprd11.prod.outlook.com>
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
X-Exim-ID: 1lioDg-003AZd-EZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53620
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
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

On 4/21/21 09:51, Xue, Ying wrote:
> This patch looks good to me.
> 
> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org> 
> Sent: Friday, March 5, 2021 5:25 PM
> To: Jon Maloy <jmaloy@redhat.com>; Xue, Ying <Ying.Xue@windriver.com>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; tipc-discussion@lists.sourceforge.net; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
> Subject: [PATCH RESEND][next] tipc: Fix fall-through warnings for Clang
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning by explicitly adding a break statement instead of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/tipc/link.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/tipc/link.c b/net/tipc/link.c index 115109259430..bcc426e16725 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -649,6 +649,7 @@ int tipc_link_fsm_evt(struct tipc_link *l, int evt)
>  			break;
>  		case LINK_FAILOVER_BEGIN_EVT:
>  			l->state = LINK_FAILINGOVER;
> +			break;
>  		case LINK_FAILURE_EVT:
>  		case LINK_RESET_EVT:
>  		case LINK_ESTABLISH_EVT:
> --
> 2.27.0
> 
