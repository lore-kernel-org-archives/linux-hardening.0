Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D888EEEC01
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIOTYu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjIOTYr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:24:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EB199;
        Fri, 15 Sep 2023 12:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA574C433C8;
        Fri, 15 Sep 2023 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694805881;
        bh=MwqHe4JvGzG4fmXR069X5g/4C9oJN5CAAugIujwOjR0=;
        h=Date:From:To:Cc:Subject:From;
        b=Yzd/ccnw/jpnhpn+bE/Ms49Rl7aD6/8TKdway2v9+BbVA2BAJHLITBjaVZf9X77d1
         fU+KDmmLjj0MQ8T2Mjxo3bnrw4On0yYxWpN7lDPbcFBBg7OaZdmNbiEtNOEUXZw4VS
         r2eAOmzguYLY4oInOGggWoYmLIBLqkhGHmzQfeheLjJobKWnKuv7zablUqmUb7/+rG
         BkX7+nO5HB3LOTJOPxfK/wZpcti98WWvttp/qWrJ1sEWdA6UlumNi8MXGTS7zkM1Go
         KhrefT0si+o14upI4rsCpe5yY63ovVia8VBZge93yijsrHO7EA0iZcK4VT9vkCb983
         5WWKjHrnJeSkw==
Date:   Fri, 15 Sep 2023 13:25:36 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Geoff Levand <geoff@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
Message-ID: <ZQSvsLmJrDsKtLCa@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/toshiba/spider_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 50d7eacfec58..87e67121477c 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2332,7 +2332,7 @@ spider_net_alloc_card(void)
 	struct spider_net_card *card;
 
 	netdev = alloc_etherdev(struct_size(card, darray,
-					    tx_descriptors + rx_descriptors));
+					    size_add(tx_descriptors, rx_descriptors)));
 	if (!netdev)
 		return NULL;
 
-- 
2.34.1

