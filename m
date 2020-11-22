Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1239CC56201
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25C320781
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgPCo+oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgKVQcU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgKVQcT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 11:32:19 -0500
Received: from coco.lan (ip5f5ad5ca.dynamic.kabel-deutschland.de [95.90.213.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A460620781;
        Sun, 22 Nov 2020 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606062739;
        bh=VMIYyEBtVHEpHEje5MUkkV48oHg0IEtqlbmMKKMnzwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kgPCo+oepy4tv4VFmRLbcIzrKF/OwPvTedgyndcNGVUN7oLmSlWrhJrPhcZo6Lixw
         /VpID1Vhqs/LRwYNkPgLirwGGavQib5HWjKApbHqYafoTw3hg2bbidUcZU5ss531HZ
         ICupmudALzaHcO7M8/eow5kyDvSJOcDOdmNdgJVA=
Date:   Sun, 22 Nov 2020 17:32:14 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 094/141] media: atomisp: Fix fall-through warnings for
 Clang
Message-ID: <20201122173214.2a052066@coco.lan>
In-Reply-To: <6a1c9b29a2d8e5accb48cd179cfe43b87fd83a00.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
        <6a1c9b29a2d8e5accb48cd179cfe43b87fd83a00.1605896060.git.gustavoars@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Em Fri, 20 Nov 2020 12:36:50 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> escreveu:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c b/drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c
> index b4813cd50daa..4a18da6bf0c1 100644
> --- a/drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c
> +++ b/drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c
> @@ -368,6 +368,7 @@ static mipi_predictor_t sh_css_csi2_compression_type_2_mipi_predictor(
>  		break;
>  	case IA_CSS_CSI2_COMPRESSION_TYPE_2:
>  		predictor = MIPI_PREDICTOR_TYPE2 - 1;
> +		break;
>  	default:
>  		break;
>  	}



Thanks,
Mauro
