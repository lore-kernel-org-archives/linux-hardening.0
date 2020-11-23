Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7CC63798
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86978207FF
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 08:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgKWIdx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:33:53 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39627 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgKWIdw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 03:33:52 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 98158240006;
        Mon, 23 Nov 2020 08:33:48 +0000 (UTC)
Date:   Mon, 23 Nov 2020 09:33:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 104/141] mtd: rawnand: stm32_fmc2: Fix fall-through
 warnings for Clang
Message-ID: <20201123093347.719a77cf@xps13>
In-Reply-To: <299d044a69b59eff2c733543b927aa608282a9a8.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
        <299d044a69b59eff2c733543b927aa608282a9a8.1605896060.git.gustavoars@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote on Fri, 20 Nov 2020
12:37:48 -0600:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding a couple of fallthrough pseudo-keywords
> instead of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 550bda4d1415..002fa521036f 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -531,6 +531,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
>  		switch (b % 4) {
>  		case 2:
>  			bit_position += shifting;
> +			fallthrough;

In patch 100, 101, 102, 103 you 'break' in this case (when the
statement falls into the empty following statement which itself
breaks). Please make it consistent and use break here, below, and in
patch 132.

LGTM otherwise.

>  		case 1:
>  			break;
>  		default:
> @@ -546,6 +547,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
>  		switch (b % 4) {
>  		case 2:
>  			byte_addr += shifting;
> +			fallthrough;
>  		case 1:
>  			break;
>  		default:

Thanks,
Miquèl
