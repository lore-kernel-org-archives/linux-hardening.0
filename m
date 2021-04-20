Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9CAC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DD2613C2
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhDTUWY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:22:24 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:25790 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhDTUWX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:22:23 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 1B5CE4010B66F
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:12:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwjhlOGcIMGeEYwjilkxjQ; Tue, 20 Apr 2021 15:12:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/R9UkJuQ7YZGJkQ6UXFLC3+p4h+sEMyvizG4Bj6L9D8=; b=LlurlvvrXyOUM81IDErArZVs6L
        jkyS0Wgk5C0o55yNenmsNkTXksQt1RKo1WiAlRUBZTAu+hDrJx4ikyVkYyiAKFOf1uEsdwH/kOtYN
        IruJL51clkIk3sOk5jbmONXlchRrgf6eHYFlrEKx4u/HjiEs2FOJ3/oH4Gjt3YIJ0VC7TnVYjmFXe
        LRPNQdFFKsA/6ok866hSBAiKimomVjdMY1aF86bS8SZrotp+02o47Ab6YL6Jadr4zCgNfZtC4S7/Q
        EPknCKDA77cHV11SRkTIs/WNKz/VuG33RieF2ZHOHFqKsgqy5DiEqQOkD+bOR15ib46Myy0vrIZ1t
        uFBmI58w==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48968 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwjf-002k6w-HY; Tue, 20 Apr 2021 15:12:39 -0500
Subject: Re: [PATCH][next] firewire: core: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305074223.GA123031@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <69b103b8-1955-ce79-57ec-0e9eca48ba6c@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305074223.GA123031@embeddedor>
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
X-Exim-ID: 1lYwjf-002k6w-HY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 83
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

On 3/5/21 01:42, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough pseudo-keyword.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/firewire/core-topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index ec68ed27b0a5..b63d55f5ebd3 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -58,6 +58,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
>  		case SELFID_PORT_PARENT:
>  		case SELFID_PORT_NCONN:
>  			(*total_port_count)++;
> +			fallthrough;
>  		case SELFID_PORT_NONE:
>  			break;
>  		}
> 
