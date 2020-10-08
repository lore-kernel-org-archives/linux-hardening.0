Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826CC4363A
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37BE21D46
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602166964;
	bh=KDEJPtg4GCj2nUViE9QbImj5+H801SK8UcvbqYFPt40=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WRFqocozWLY90og5oBHyXKLOuhhRME1dVdm9/gVfWs35Zotm33PGi/ZsVAAi3m8uu
	 UiZDis2hoFLxYOn3ifRXuNE4uQOKxXiTz6x5Bhzk2kj1+mh8hn7c6uLz9Jfa1hIB65
	 AJKL0BFCb2If1x7U5gHXihbFXYWFvBmesh3q2m54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgJHOWo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbgJHOWo (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 10:22:44 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE0421927;
        Thu,  8 Oct 2020 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602166963;
        bh=KDEJPtg4GCj2nUViE9QbImj5+H801SK8UcvbqYFPt40=;
        h=Date:From:To:Cc:Subject:From;
        b=dkw+U/5aTdErQuwkXw9TFCiWbgAD/NX5FqdoJsBFlEluC7gfjtVrIOjMq6mHIFPzf
         KtDX5n+udZeXL0qWJ5tK2YK/ywZxXXqPH/no09LonORk7a1XSEnkWD4xKAK5gWPv4l
         2bcL386ptRLMvNw0nvN+WOtplqVGCVoOQcF73RmQ=
Date:   Thu, 8 Oct 2020 09:28:06 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: thunderx: Use struct_size() helper in kmalloc()
Message-ID: <20201008142806.GA22162@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the new struct_size() helper instead of the offsetof() idiom.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 0a94c396173b..f3b7b443f964 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2065,8 +2065,8 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 			mode |= BGX_XCAST_MCAST_FILTER;
 			/* here we need to copy mc addrs */
 			if (netdev_mc_count(netdev)) {
-				mc_list = kmalloc(offsetof(typeof(*mc_list),
-							   mc[netdev_mc_count(netdev)]),
+				mc_list = kmalloc(struct_size(mc_list, mc,
+							      netdev_mc_count(netdev)),
 						  GFP_ATOMIC);
 				if (unlikely(!mc_list))
 					return;
-- 
2.27.0

