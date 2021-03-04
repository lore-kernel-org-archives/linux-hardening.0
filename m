Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A66C433E0
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36B364ECF
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCDXA0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhCDXA0 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 18:00:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FF1464ECF;
        Thu,  4 Mar 2021 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614898825;
        bh=9joNX258qxFojy1dlP2P5Uw8dcqwSvhV+xdgO1c0XKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVgcXjPfGvIvcxAB5NmdBgYDh1JCb2ajQW73DAYVGMGzhwfOwUsIBvDvrKdvuD2Qd
         AZcRfvZId5QUFGwta8kqIEWg3gIwrZPCptatuUjPgHGz7BlZBxw9aYh9xmEVJT8DTv
         ki1X54aqwp6PlxjgpQCcPtST0k7HdW/ti5oQvOfnBooOU8rE08qgwmCviV9LUj004m
         3KAhC68CY9Vf1lXt9M+gpkfTvZLHxCKpgfXQcTi5rEfvhI/+xKQTwnntEMx4+STCZP
         oGDOp9XPznBfKVNcoo89fGM1OBHxNSktIKKL9Ney5rZ6sqeIwa/PtRUdGLrK4cF2tj
         ZWT0dcMjheaeQ==
Date:   Thu, 4 Mar 2021 17:00:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 111/141] net: plip: Fix fall-through warnings for Clang
Message-ID: <20210304230023.GA106177@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44c10df4dbe85f2c8e14d760b6e83acecd22ebe2.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c10df4dbe85f2c8e14d760b6e83acecd22ebe2.1605896060.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

It's been more than 3 months; who can take this, please? :)

Thanks
--
Gustavo

On Fri, Nov 20, 2020 at 12:38:25PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/plip/plip.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
> index 4406b353123e..e26cf91bdec2 100644
> --- a/drivers/net/plip/plip.c
> +++ b/drivers/net/plip/plip.c
> @@ -516,6 +516,7 @@ plip_receive(unsigned short nibble_timeout, struct net_device *dev,
>  		*data_p |= (c0 << 1) & 0xf0;
>  		write_data (dev, 0x00); /* send ACK */
>  		*ns_p = PLIP_NB_BEGIN;
> +		break;
>  	case PLIP_NB_2:
>  		break;
>  	}
> @@ -808,6 +809,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
>  				return HS_TIMEOUT;
>  			}
>  		}
> +		break;
>  
>  	case PLIP_PK_LENGTH_LSB:
>  		if (plip_send(nibble_timeout, dev,
> -- 
> 2.27.0
> 
