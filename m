Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41878C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 20 Sep 2021 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2518D61107
	for <linux-hardening@archiver.kernel.org>; Mon, 20 Sep 2021 23:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhIUAAk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:00:40 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.219]:49742 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239611AbhITX6k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Sep 2021 19:58:40 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A23BB10F41A
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 18:57:11 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ST9rmVzAxcEL1ST9rm9s8f; Mon, 20 Sep 2021 18:57:11 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l54vatPzJc7ae4VPK1rE18+/33qlQpWc3ikOysttu7Y=; b=r+m6rkmYLSXCfkF4UqkZA7ymV8
        Is0TecEuYONlyespTdbJhCpfajKXK7QQuLOdHeQ6uWhF7pJcdfogq96aBZB7aaTB8NE9SiKhfBspC
        7fOt/dgfa0hHxnXBOA0dTFPDza0RxsSZ0RvjTdktY8K6fia4SWJ2rs6l50aDDgNn9ZmZOKas/5xEj
        yEqDCBgPva8kNe8CAR2GR+aJgqao35OjNMRENM8fAd6tQaq1wz5ek75nj0k4fsUTiikpFeRCcE57U
        IbNjrAqN3KrvSAfj6gLFtgM32cZmuJx0i+xJ24q/0gmqQNJkX1O2+VuHWcBviREl+em1EuaCRNMIx
        gJDRFO1g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33692 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mST9r-000R7p-3a; Mon, 20 Sep 2021 18:57:11 -0500
Subject: Re: [PATCH] dmaengine: pxa_dma: Prefer struct_size over open coded
 arithmetic
To:     Len Baker <len.baker@gmx.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210918104055.8444-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e7e103f3-74eb-9cf4-a150-e2333d4f2ace@embeddedor.com>
Date:   Mon, 20 Sep 2021 19:00:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210918104055.8444-1-len.baker@gmx.com>
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
X-Exim-ID: 1mST9r-000R7p-3a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:33692
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/18/21 05:40, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

> ---
>  drivers/dma/pxa_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 4a2a796e348c..52d04641e361 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -742,8 +742,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  	dma_addr_t dma;
>  	int i;
> 
> -	sw_desc = kzalloc(sizeof(*sw_desc) +
> -			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
> +	sw_desc = kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc),
>  			  GFP_NOWAIT);
>  	if (!sw_desc)
>  		return NULL;
> --
> 2.25.1
> 
