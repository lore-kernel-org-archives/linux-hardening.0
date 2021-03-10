Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2441C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 05:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4E64D90
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 05:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCJFdx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 00:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhCJFdX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 00:33:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3964264FE7;
        Wed, 10 Mar 2021 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615354399;
        bh=tPOLvHWlyO1O6LPs+6mBheK5snXKGRuNdiwmdhTzTzo=;
        h=Date:From:To:Cc:Subject:From;
        b=cNrMkyW8LEYy/LT/y+lO0d9wuK+DUDpdCeUI1tCNXigoY4K2/wgWR4oG/6iSwux+w
         JV5jcTm+Mi46vw+uEpBPzjvkKFBpcAIrMHjs6tN2RMPnJRmv0E1jzYp6cc5RZEwu90
         KlVyz5llhtzU8zaEGuPvm/L7AxSF6SLC0N7pJ7oji4hbCJ2I9HkxQ3aFTFMfqizZsF
         Qrw2GxhyAODZDspmJXgSeldksiQkMH/3A9eq/15+vXA3wqNUExTWwdeqavnyGSpOJk
         5RoQGghyPFrcWepNbPf6K9i2Bhlhga5TZrEFSFSByWgKirCwBfIcMjqvC5VJmdK2DF
         FahXi6ThqVEkw==
Date:   Tue, 9 Mar 2021 23:33:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] net: mscc: ocelot: Fix fall-through warnings
 for Clang
Message-ID: <20210310053316.GA285225@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://github.com/KSPP/linux/issues/115
---
 Changes in RESEND:
 - None. Resendig now that net-next is open.

 drivers/net/ethernet/mscc/ocelot_vcap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 37a232911395..7945393a0655 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -761,6 +761,7 @@ static void is1_entry_set(struct ocelot *ocelot, int ix,
 			vcap_key_bytes_set(vcap, &data, VCAP_IS1_HK_ETYPE,
 					   etype.value, etype.mask);
 		}
+		break;
 	}
 	default:
 		break;
-- 
2.27.0

