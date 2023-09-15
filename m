Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEEEED61A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 18:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjIOSR0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjIOSRA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 14:17:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79071FCC;
        Fri, 15 Sep 2023 11:16:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC75C433C7;
        Fri, 15 Sep 2023 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694801815;
        bh=QQqUp4XKgQyXwHPRMB+70AKUDzS82qjfk8gBWWVgGI4=;
        h=Date:From:To:Cc:Subject:From;
        b=Yq79jB3G8IBEwWWnWZobdn6Dv325x+kOyUwQrhwpzktHSyJ6HHrnRXQHYvmOYWOPh
         gT0e2oKdogaJYnAlSYqFv5zYbSKiPsiSftkYHjSjGR+pjxGaNk7hZKn56zH3bOCSFx
         JSEh05iC5fyiG4U1VIs7g7UMiazvSKY+Vyf4Ax2XMU5/IZPk03/phNT7y+qEvMjTmH
         yT8AEElu4D1porsU9LKGu82QC3nQEL/EYaqMnvQPmRoqBhWKP/293HMA/nYqQqRnaV
         Lq6hPhMYaIGNt04csavSvpsgSl505s4DlcNVdiVeR1n7j6s2fIwFuOB9CpyRMFpWKI
         XtKv0BUO7E/xQ==
Date:   Fri, 15 Sep 2023 12:17:49 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <ZQSfze9HgfLDkFPV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
protection that struct_size() adds against potential integer overflows
is defeated. Fix this by hardening call to struct_size() with size_add().

Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5704b5f57cd0..83b09dcfafc4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -190,7 +190,7 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
 		       priv->rx_cfg.num_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
-					     tx_stats_num + rx_stats_num);
+					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
 		dma_alloc_coherent(&priv->pdev->dev, priv->stats_report_len,
 				   &priv->stats_report_bus, GFP_KERNEL);
-- 
2.34.1

