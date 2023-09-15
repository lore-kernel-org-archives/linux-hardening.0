Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08871CD37AA
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjIOUu1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjIOUuM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:50:12 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C930186
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:49:31 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id hCWzq9Ja1OzKlhFkoqIHsj; Fri, 15 Sep 2023 20:49:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFknqiGcQWcTnhFkoqgKZU; Fri, 15 Sep 2023 20:49:30 +0000
X-Authority-Analysis: v=2.4 cv=PqmA0iA3 c=1 sm=1 tr=0 ts=6504c35a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=37rDS-QxAAAA:8 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=k1Nq6YrhK2t884LQW06G:22
 a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dbvnwKJQfGsgQH7tlRR/jd5p7nHOn0NX5cYdBxx3AwM=; b=KmckCKfhNPNWKTdU/U2RVIyYPB
        xExI9mPYCjcuCOZhzrKa18b35yBJj1J92lH4mBNy+h5WcLsVj4D0zifQrWGCC5XRBRITAQNc6Pp6V
        OxJcCmDe1AIsvGONJEJRKHwJYEsfm+Q7OKJRWgh7ZA3XDtl5+SpDKmqg1+SQqWqntt+Ey+1mZQOxA
        Up7v+NCAQtGjfCGeZGC4YnGvLDKALmSGT8zz6vOFpg8WkJCdLkNwKQoIJLVYGERSbaaWunv2G8adv
        T1kitsK1Pcc7UoMVPYgCmUHvEo7vfoEU+DuAL7vqOCEINvaYJkTXkVt7hXOEC8m71LtLjZkIKwcTb
        g42p5LUQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56838 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFkm-002ek3-0U;
        Fri, 15 Sep 2023 15:49:28 -0500
Message-ID: <b81647db-097e-cbf1-e4d6-53a4a96b85ea@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:50:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] aio: Annotate struct kioctx_table with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201413.never.881-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201413.never.881-kees@kernel.org>
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
X-Exim-ID: 1qhFkm-002ek3-0U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56838
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 422
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFSiee3nl60IldibMjD1+DADa2TOWvxx24D5s0vUFZhaV0MEApCROgI1BsdDoThD11TX/W+fNg5I37sB4S8K5I0Ly2ABmpNGFg6KFLjlnh/N/f9L+FKF
 vP5TSybe7AZJrzt0rcYMlMGuM94iK3YLKaVXP/gBSZ7MWFoX/Forzf5mIOUkahiPlSKJ6dlFaSXcPVJpU+PdQd2i/SUOywqvvoXTHzinQISASsRcmPN1gPaY
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
> As found with Coccinelle[1], add __counted_by for struct kioctx_table.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/aio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index a4c2a6bac72c..f8589caef9c1 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -80,7 +80,7 @@ struct aio_ring {
>   struct kioctx_table {
>   	struct rcu_head		rcu;
>   	unsigned		nr;
> -	struct kioctx __rcu	*table[];
> +	struct kioctx __rcu	*table[] __counted_by(nr);
>   };
>   
>   struct kioctx_cpu {
