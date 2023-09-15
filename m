Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D7CD37AC
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjIOUxj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjIOUxI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:53:08 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323293C1B
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:50:08 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id hFCiqdFlMez0ChFl3qBxuV; Fri, 15 Sep 2023 20:49:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFlPqZozGn5VDhFlPqR9oi; Fri, 15 Sep 2023 20:50:07 +0000
X-Authority-Analysis: v=2.4 cv=bOkFndyZ c=1 sm=1 tr=0 ts=6504c37f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=BS-Bl4eDAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=Mz5RY1mrK68yK6INR7tS:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hHBm32xy4jRkjVn0y/BB/KAWgaCViJxjs8zwN5fSv8o=; b=C9fEmdoUTe5k+Zz9HUgjJGddMx
        SU7qhuX3vJeueDidE42Lg7b8eejFk7eKtkTzzhgKm5reudpykUqA9NorQqwrpb9St3swwj6IfUbrK
        NpfY51iNUbip5VgK8gM5xTiHFWSlXpuIHW4oTq+3wsERqhuinyqVA28ir4UbgpWNFeH1kAS/IKqsj
        C51AEuxEp5xC1gb2jiZaU9mb32SZgikgOy1v1dRyyCrL94rWB+2FWGAz0F0QBoGZzNYehYQB8nlTH
        6VOZq3i38951kOypo7P3nh8oiJPgOshQoQfNk1aKg7TfogAk7VFNBxNBBHq8oq49qttqy2BWE3jeC
        wjdqDuzg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39846 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFlN-002fV5-1O;
        Fri, 15 Sep 2023 15:50:05 -0500
Message-ID: <57b92e94-b9a6-c56f-0812-aa54d15e0c7d@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:51:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] afs: Annotate struct afs_permits with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201456.never.529-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201456.never.529-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFlN-002fV5-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 454
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPrb/+KaLY+A+u4KtPIEKN2OuPAtHamBKgcjSBlX725qMpRo9ImiycQn9pENEtVh9pXWkM/czVEDetL8Xd75jZIs7xu38hk3N+FEmqb8JwuvksPu7bmm
 a4bysQ7m82M2Z99/VlGJocGz5KAYkc7m+zmzi3wcgzGhWt5m1cRTvbe5In/W/StVdS9w/fnPO4DaKJ7mywQswedCX8aUSuRRiwEcWpTLEq84N1TCW+fjp8js
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/15/23 14:14, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct afs_permits.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Marc Dionne <marc.dionne@auristor.com>
> Cc: linux-afs@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/afs/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 07433a5349ca..469a717467a4 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -705,7 +705,7 @@ struct afs_permits {
>   	refcount_t		usage;
>   	unsigned short		nr_permits;	/* Number of records */
>   	bool			invalidated;	/* Invalidated due to key change */
> -	struct afs_permit	permits[];	/* List of permits sorted by key pointer */
> +	struct afs_permit	permits[] __counted_by(nr_permits);	/* List of permits sorted by key pointer */
>   };
>   
>   /*
