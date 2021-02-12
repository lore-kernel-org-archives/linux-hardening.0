Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3EC433DB
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5666023B
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 14:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBLONI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 12 Feb 2021 09:13:08 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57331 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhBLONC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 12 Feb 2021 09:13:02 -0500
X-Originating-IP: 90.89.99.36
Received: from xps13 (lfbn-tou-1-1536-36.w90-89.abo.wanadoo.fr [90.89.99.36])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0E61420011;
        Fri, 12 Feb 2021 14:12:17 +0000 (UTC)
Date:   Fri, 12 Feb 2021 15:12:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: physmap: physmap-bt1-rom: Fix unintentional stack
 access
Message-ID: <20210212151216.31a09ad1@xps13>
In-Reply-To: <20210212104022.GA242669@embeddedor>
References: <20210212104022.GA242669@embeddedor>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote on Fri, 12 Feb 2021
04:40:22 -0600:

> Cast &data to (char *) in order to avoid unintentionally accessing
> the stack.
> 
> Notice that data is of type u32, so any increment to &data
> will be in the order of 4-byte chunks, and this piece of code
> is actually intended to be a byte offset.

I don't have the same reading. I don't say that Coverity report is
wrong, but let's discuss this a bit further.

Given that &data is of type u32 *, you say that "&data + shift"
produces increments of 4-bytes, ie. we would access "&data + 4 *
shift"? Because I don't think this is the case (again, I may be wrong).

I'm sure this would be the case if we dereferenced data like
data[shift] though, but in this case I don't see what this cast is
fixing. Can you enlighten me?

Could the out-of-bounds warning come from the fact that shift
might be bigger than the data array spread?

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

Thanks,
Miquèl
