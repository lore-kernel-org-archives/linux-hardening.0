Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64847CD37AC
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjIOUqL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjIOUpo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:45:44 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB6199
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:45:39 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id hALzq8dmKOzKlhFh5qIG8s; Fri, 15 Sep 2023 20:45:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFh4qzj5ktHuqhFh5qc9AF; Fri, 15 Sep 2023 20:45:39 +0000
X-Authority-Analysis: v=2.4 cv=OcCLszfY c=1 sm=1 tr=0 ts=6504c273
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=THcbAJFdx33gBO1MOq6Px2lR54qlr2l+Ip9xfdyyl3E=; b=tYRc1rc6gSEdsGWkdPGjQcdL+u
        4GBJQuUoziMuoygvT/hYgpkE64TlGr5i5iepg9F2+gHo3kkGZGqeD/bjcEYxD644JcLXUJ/hZBPh2
        jLv+QB/6nPeMM0pPvbE6iXZ1PLN+3GwMOJUTKCUtm6filW+HXlO19mpwyRH0SqvUyOtR1XzBISg8h
        f4u4UkpbgFkQcw+toJhP9X0YWb+8DBGn23xVvvVLZd9iOz3lS2oXQoTZXO26ECr8JRvuigv/RFElD
        1sRKzARtP2uNl/ZJRKgnrgTPkQpST24I/NsU7XdDUQYD9c+dg5pJt+0enAx+zrKrUKxaQNCxe2PIj
        dcW/1dsg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60304 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFh3-002a1b-2a;
        Fri, 15 Sep 2023 15:45:37 -0500
Message-ID: <59945a80-0d50-1df0-43cb-eda68b07f93d@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:46:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] leds: cr0014114: Annotate struct cr0014114 with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200948.never.728-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200948.never.728-kees@kernel.org>
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
X-Exim-ID: 1qhFh3-002a1b-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 193
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE6ADU6luLjBbk25cCmKgm7Q+MxE8gGClaMuFWcmElGVUhP6BILPSQfV6MzwOYOk5ZLFXhqdpftcTw7sqjuvQMpFoSXjVNtYEsNPlRWmrHhqKTtUU2wR
 O/2iYTzrLxd1Dh+HCyt9fD42WreOy+ah0nk6m2wVafMuPPNtwz8VlZO5g+L1kowKtOEB7EwjOJ7PBW//+LE5XSj0eFeg2eq41fU0fw0Y93w9lBW8z/7gEGuq
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/15/23 14:09, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cr0014114.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/leds/leds-cr0014114.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
> index b33bca397ea6..c9914fc51f20 100644
> --- a/drivers/leds/leds-cr0014114.c
> +++ b/drivers/leds/leds-cr0014114.c
> @@ -56,7 +56,7 @@ struct cr0014114 {
>   	struct spi_device	*spi;
>   	u8			*buf;
>   	unsigned long		delay;
> -	struct cr0014114_led	leds[];
> +	struct cr0014114_led	leds[] __counted_by(count);
>   };
>   
>   static void cr0014114_calc_crc(u8 *buf, const size_t len)
