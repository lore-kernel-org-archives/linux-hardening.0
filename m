Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4DC433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E89B613E5
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhDTUd2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:33:28 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:19847 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233983AbhDTUd1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:33:27 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id BB7724016FC16
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 14:59:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwhYlhT12b8LyYwhYljMhB; Tue, 20 Apr 2021 15:10:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d2VIUpwn1hQqRV9enPlvmhxFMkEn8Z5e2qZ2REUs6BE=; b=0HIg/f7i2Cttvil1ym3WOVmtx+
        DVblbr5VFMrRz8zsmX0xfY7L/HLaYRbgl75rnVuBDW4AB84Z0eYft589rUT5JhgOU6FjTC7O8r4KQ
        wqE3eDdfq509DDgiln207MbopmV4jkxji9HK1t4GHWbX/j/UyVcM5HB0ZY7lUZnGyuYovNoJJPxrA
        +vTooRLQ2FizFvjnnsd3xGe0s9JZH9s/oSfBAL3gMO0tGgCwqSwyGRv0U+y5wpMv2CxcxwCF0U2On
        KhBge0uiYPrVoKRfEVF5V70wgj4ulIUaDzkUKbzoSlCdUJhAEAi3Jq8+PWsxvA+ZgGgc3CKeNZ+Sz
        h14++ZzA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48948 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwhW-002gDF-3F; Tue, 20 Apr 2021 15:10:26 -0500
Subject: Re: [PATCH RESEND][next] net/packet: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210305094429.GA140795@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <895bef99-a483-1d20-8b4c-2eea3c0d341f@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:10:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305094429.GA140795@embeddedor>
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
X-Exim-ID: 1lYwhW-002gDF-3F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48948
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 60
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

On 3/5/21 03:44, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/packet/af_packet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e24b2841c643..880a1ab9a305 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1652,6 +1652,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  	case PACKET_FANOUT_ROLLOVER:
>  		if (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)
>  			return -EINVAL;
> +		break;
>  	case PACKET_FANOUT_HASH:
>  	case PACKET_FANOUT_LB:
>  	case PACKET_FANOUT_CPU:
> 
