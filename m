Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D281C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 00:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6AA611ED
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 00:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhIUAbv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:31:51 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.130]:16609 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhIUA3u (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Sep 2021 20:29:50 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 20:29:50 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 3A99611F6F
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 19:05:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id STIFmQ0GTMGeESTIFmXONr; Mon, 20 Sep 2021 19:05:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dIZWTLeUsAcg6awfj+mJ/VeStP2PiXGKlLzxmy7BCEg=; b=qpP925gQr2CunCsqGZ8nBoNddT
        hr+cP5UbxRC/JdtHMH18vJFzQPaDHnc1j6KxxAZx9VdRj/JJSUjAt+qkohtGh5+zvKZXqkYvERaB+
        sTI/RQMyUXv2x2Lc5X6WdXMggxnU7QXGzBdXHuhztlY2lkYiMr3pN0oFJ3HgruRuSkxpjreftedGn
        yx93FeU7vWW6WhBGiaHGPCsj1m/ehyiyVZIaCJItH8dPpvc6cQjhQEquiXCnxJunJ1deZ4/I+/UH2
        gXwrqPuWtIUz3JKZJHkMievNK4+NcezwXqsiLZmYj/GfA2KrJhzCY+T1rDUpOwRlukQ7z3HaL/t4S
        KdGsoAqg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33874 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mSTIE-000eHV-PB; Mon, 20 Sep 2021 19:05:50 -0500
Subject: Re: [PATCH] afs: Prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-afs@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210919094432.30510-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8664159c-b986-64b0-13d1-b2739deb159d@embeddedor.com>
Date:   Mon, 20 Sep 2021 19:09:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919094432.30510-1-len.baker@gmx.com>
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
X-Exim-ID: 1mSTIE-000eHV-PB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:33874
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/19/21 04:44, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + size * count" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  fs/afs/security.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/afs/security.c b/fs/afs/security.c
> index 3c7a8fc4f93f..7c6a63a30394 100644
> --- a/fs/afs/security.c
> +++ b/fs/afs/security.c
> @@ -219,8 +219,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
>  	 * yet.
>  	 */
>  	size++;
> -	new = kzalloc(sizeof(struct afs_permits) +
> -		      sizeof(struct afs_permit) * size, GFP_NOFS);
> +	new = kzalloc(struct_size(new, permits, size), GFP_NOFS);
>  	if (!new)
>  		goto out_put;
> 
> --
> 2.25.1
> 
