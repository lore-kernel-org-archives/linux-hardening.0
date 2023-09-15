Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5567ACD37AD
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjIOUsU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbjIOUsM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:48:12 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0242735
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:47:45 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id hFDFqZIwUyYOwhFj7q0uv5; Fri, 15 Sep 2023 20:47:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFj6qfuRG7DhyhFj6qPF2G; Fri, 15 Sep 2023 20:47:44 +0000
X-Authority-Analysis: v=2.4 cv=fpfP2X0f c=1 sm=1 tr=0 ts=6504c2f0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=XYAwZIGsAAAA:8
 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=aeg5Gbbo78KNqacMgKqU:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LbVMVYvQi67lp6PSBgdTc/MiJ1dwykFXI+Yhs9US8hw=; b=k8TcjOOcWsgmPVu/yrQnOTixIX
        aYUEfTiZUp4wGD5rduid+L+xWdg0wg0PKzYwAt2Doe5/d6Rmij1YBOAU4a8ZS/KYZexzswSWI/DfU
        zQtOJ5MgAWO8F5vJCFAU6AwoDVQSTB0Icn2yLlx+5cmfPEFxMOOmfb9lbTDuwC1hr/YIcviWthxUk
        8CrEZ5Whwbi+k123CVUUdnkwTLb5Ow5dRi7HR+q2ty6iY/vB9oVI+sMXAwxagDDQh9UX1MibTZXd5
        R0u1KB4BjTNlAyAbBiLpk2yheJo4Fx8VbIugzABhbBLIBDc7zTb02EtZ5G3u1YaFhTbeqq9Sl523A
        QGawfcow==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57296 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFj4-002cc0-0V;
        Fri, 15 Sep 2023 15:47:42 -0500
Message-ID: <c298d6c3-2299-6361-e715-a121f3e3dec2@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:48:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: rawnand: atmel: Annotate struct atmel_nand with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201219.never.352-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201219.never.352-kees@kernel.org>
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
X-Exim-ID: 1qhFj4-002cc0-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:57296
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 309
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFoG7AYKTD/3faBjOWkNlbXUSFlNR1fJDW+lN4/D7ENPmPLE5TqoaZ8V1z81h9dRjy8VnPpLf2ivH9iQYxm6clkgRp77fvOdzo8K4wMnj7xL8cbD3SNi
 Fur/BvTOvGQqKrFksO0gszCmTqgf4KL2JoZytvELEtyCjEOQpu6a/WZCL7o66pryJhptyraVL1jPqjQZLlJlOhTIDt5JGl6yXdJUt9b8imQZ0F7wGBpJCFKq
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/15/23 14:12, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct atmel_nand.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index 3f494f7c7ecb..4cb478bbee4a 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -165,7 +165,7 @@ struct atmel_nand {
>   	struct atmel_pmecc_user *pmecc;
>   	struct gpio_desc *cdgpio;
>   	int numcs;
> -	struct atmel_nand_cs cs[];
> +	struct atmel_nand_cs cs[] __counted_by(numcs);
>   };
>   
>   static inline struct atmel_nand *to_atmel_nand(struct nand_chip *chip)
