Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF4CC433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0F265016
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEHjo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHjo (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 02:39:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD95364F44;
        Fri,  5 Mar 2021 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614929984;
        bh=oHCWpgfauurcAwVAR+BNJveAfh0IeEwBSn1ChD9wm2k=;
        h=Date:From:To:Cc:Subject:From;
        b=dDbc4Tjw6qHfF32EiUMWKcdAqqpKKN9yxFwNhNTUffyNhLUFe4Fgtf5tF2d7Q/1dL
         oae9F5bD8Fxv/wQwkj/sSir0bzd355/D3d207SE6r6IqHQ7ZECIYiuTvlkvwKjCuKT
         o74uEiKZPHXueprc8MXVLx0yIuBPfxQjJL1pvC1DPSSuKP9C5CzYKHszNTb8X6yqAx
         jJC/RSzn3HQ3u8yxOqPEqeOfQh2ggqtTfaUhE0inkS2IE4cbxQYtCdKsRNWdCdelFQ
         ZOYBACSn6j4c4JorVvkPHUDqqRyX/iw6wRQJWlQvIU04RBXOMwL450/PO4qDh7CAy8
         +jtqUUh/1mSKA==
Date:   Fri, 5 Mar 2021 01:39:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: ax25: Fix fall-through warnings for Clang
Message-ID: <20210305073940.GA122747@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/ax25/af_ax25.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 269ee89d2c2b..2631efc6e359 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -850,6 +850,7 @@ static int ax25_create(struct net *net, struct socket *sock, int protocol,
 		case AX25_P_ROSE:
 			if (ax25_protocol_is_registered(AX25_P_ROSE))
 				return -ESOCKTNOSUPPORT;
+			break;
 #endif
 		default:
 			break;
-- 
2.27.0

