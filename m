Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC6CD37AE
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbjIOUsw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbjIOUsg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:48:36 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3AE50
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:48:15 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id hFDAqZIubyYOwhFjbq0vAN; Fri, 15 Sep 2023 20:48:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFjaqJ9NqHoqXhFjbqe7mP; Fri, 15 Sep 2023 20:48:15 +0000
X-Authority-Analysis: v=2.4 cv=VP7OIvDX c=1 sm=1 tr=0 ts=6504c30f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=ER_8r6IbAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v65a4RFp+sMcmemfAmTnmiDwoMy+rn1eiNS9UY+L9Jc=; b=xhTcHRzMNlYF2SpjieV2likVC3
        6nLuBjvO2+ksA3n+z7tt+LWXWrhItk8ETbIgkAlAJoYwsBFqUVxF4PlLyofAn+NtakNjVL61KAxQo
        Ny3F9ooJDBNF+5cg7v2QqFDUqyMCwix7SQ4oh3MkN9q3mwi3Mh8g65ztPvgih10VwnOyIketl3Rtv
        MVNPyAAO2jSKcFeTT/IpEbsw1IQUtHGY20ZIzXdtgxawGGM855sRHZ8qh9rBjC8zhbyXMpSq0EK2I
        tl7kdDebEXuAZv4X2+sW+Io1jM7D/pB2jZYCYZ7nl5ARp/vRiGQYzQJZGu5QuOcmegEAHlcW3g20g
        tt2GlAvQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60426 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFjY-002dEH-1u;
        Fri, 15 Sep 2023 15:48:12 -0500
Message-ID: <c2e2f28e-64b6-9e8d-6d60-1a78bd3b5147@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:49:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: rawnand: ingenic: Annotate struct ingenic_nfc with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201234.never.868-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201234.never.868-kees@kernel.org>
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
X-Exim-ID: 1qhFjY-002dEH-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60426
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 336
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIm/5OYcd++ZulhRZFNHAeDVswqwsoq5VcRukfEyqf7gtjBJBbwMFLU1HjqDju5Ck+Ew2FoNqqO6nv0zuvD1QlT6ZLehIIn236/KoO/kBNy5uoF+ewkL
 WQzh05SY2fgR/NV0mWHArsT5jDr9JkfCkK26TIs8iMQ/AiufMEPGWoDZjo/opp6fUTBNAwTHrUuGmlqX2KEagAhDlpB0Ic3AKHmu/lbofpW2ZicpkHBI2G9d
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
> As found with Coccinelle[1], add __counted_by for struct ingenic_nfc.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> index 6748226b8bd1..ce9ef4e65597 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> @@ -46,7 +46,7 @@ struct ingenic_nfc {
>   	struct nand_controller controller;
>   	unsigned int num_banks;
>   	struct list_head chips;
> -	struct ingenic_nand_cs cs[];
> +	struct ingenic_nand_cs cs[] __counted_by(num_banks);
>   };
>   
>   struct ingenic_nand {
