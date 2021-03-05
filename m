Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504BC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF564FE8
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCEJty (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhCEJtk (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:49:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF20B64FE8;
        Fri,  5 Mar 2021 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937780;
        bh=eY3rGMEBBqNXM9DWJ8q+8xbYaA0kUDZyDVNTJUPw/qc=;
        h=Date:From:To:Cc:Subject:From;
        b=IVgtfkzIrezYADW7aXr2tRba8wLlD1mNgfpNFkiWVuT94M99+bHYGi3lFZ/gM/cBO
         Lv7Jl0e9ZVRLqhitjGX8hyceDm5+5QVPgwohN1dO5KkA51aZYMQqifSkqVvRp+iCht
         BSzIUb5CnPt5Q46qZarf6B4oen0A+r+7R6pF778v44F4u9U3x5rP2JR7CMZ9bvtfVX
         BCz5g4ewUopt5zOjDp1RrovPoisR6s+JJGp9gHnLQN+JTfesBy5FxZCspi1ebeYjzs
         n2T1VHHF/xV4m9fyTW77277VNaVvQhU9jksRoFpTGU9xlHGDRzEVXP9fSOnf7ry3W6
         sjMgt03V0LeQA==
Date:   Fri, 5 Mar 2021 03:49:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] nfp: Fix fall-through warnings for Clang
Message-ID: <20210305094937.GA141307@embeddedor>
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
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index b3cabc274121..3b8e675087de 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -103,6 +103,7 @@ nfp_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 	case NFP_PORT_PF_PORT:
 	case NFP_PORT_VF_PORT:
 		nfp_repr_vnic_get_stats64(repr->port, stats);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

