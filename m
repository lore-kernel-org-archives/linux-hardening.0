Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430BC433E0
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617E964DB2
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 16:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBLQc1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 12 Feb 2021 11:32:27 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:40180 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBLQbl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 12 Feb 2021 11:31:41 -0500
Date:   Fri, 12 Feb 2021 19:30:41 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] mtd: physmap: physmap-bt1-rom: Fix unintentional stack
 access
Message-ID: <20210212163041.a23drtvtcv5vjem6@mobilestation>
References: <20210212104022.GA242669@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210212104022.GA242669@embeddedor>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 12, 2021 at 04:40:22AM -0600, Gustavo A. R. Silva wrote:
> Cast &data to (char *) in order to avoid unintentionally accessing
> the stack.
> 
> Notice that data is of type u32, so any increment to &data
> will be in the order of 4-byte chunks, and this piece of code
> is actually intended to be a byte offset.

Thanks, one more time.)
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Fixes: b3e79e7682e0 ("mtd: physmap: Add Baikal-T1 physically mapped ROM support")
> Addresses-Coverity-ID: 1497765 ("Out-of-bounds access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/mtd/maps/physmap-bt1-rom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/physmap-bt1-rom.c b/drivers/mtd/maps/physmap-bt1-rom.c
> index a35450002284..58782cfaf71c 100644
> --- a/drivers/mtd/maps/physmap-bt1-rom.c
> +++ b/drivers/mtd/maps/physmap-bt1-rom.c
> @@ -79,7 +79,7 @@ static void __xipram bt1_rom_map_copy_from(struct map_info *map,
>  	if (shift) {
>  		chunk = min_t(ssize_t, 4 - shift, len);
>  		data = readl_relaxed(src - shift);
> -		memcpy(to, &data + shift, chunk);
> +		memcpy(to, (char *)&data + shift, chunk);
>  		src += chunk;
>  		to += chunk;
>  		len -= chunk;
> -- 
> 2.27.0
> 
