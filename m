Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F654C6379D
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C78020781
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8AgLgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgKVQc7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgKVQc7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 11:32:59 -0500
Received: from coco.lan (ip5f5ad5ca.dynamic.kabel-deutschland.de [95.90.213.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71CF20781;
        Sun, 22 Nov 2020 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606062778;
        bh=e8sIaSe5jQWBKPA9KDU/BRqi38yhPyex9LtXhWzkhXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+8AgLgCyUsbvOZ3HGTwaiJR/1/Ae6O+SRERECOuL2j0Wsz42mkUgl8muW1kSbrRv
         JOlGpvhNewZBgC6bsYRj86NfVso16zM0gYfhqSmEjjGVWhP1U0GZXMJ1aa5R1o/jo/
         xJ+liUDaChbLr/PmNonxJ6rdRNvDFjEHbLFM+NiA=
Date:   Sun, 22 Nov 2020 17:32:55 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 097/141] media: saa7134: Fix fall-through warnings for
 Clang
Message-ID: <20201122173255.19766109@coco.lan>
In-Reply-To: <cc5053e144f9ff5901e9cf894c72aa933cf480f3.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
        <cc5053e144f9ff5901e9cf894c72aa933cf480f3.1605896060.git.gustavoars@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Em Fri, 20 Nov 2020 12:37:08 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> escreveu:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/media/pci/saa7134/saa7134-tvaudio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/saa7134/saa7134-tvaudio.c b/drivers/media/pci/saa7134/saa7134-tvaudio.c
> index 5cc4ef21f9d3..5dc97990fa0e 100644
> --- a/drivers/media/pci/saa7134/saa7134-tvaudio.c
> +++ b/drivers/media/pci/saa7134/saa7134-tvaudio.c
> @@ -885,6 +885,7 @@ void saa7134_enable_i2s(struct saa7134_dev *dev)
>  	    saa_writeb(SAA7134_I2S_OUTPUT_FORMAT, i2s_format);
>  	    saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,  0x0F);
>  	    saa_writeb(SAA7134_I2S_AUDIO_OUTPUT,  0x01);
> +	    break;
>  
>  	default:
>  	    break;



Thanks,
Mauro
