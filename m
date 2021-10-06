Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E17C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A5161077
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhJFSHc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238900AbhJFSHb (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 14:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90F4561037;
        Wed,  6 Oct 2021 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633543539;
        bh=5YNmGloASLfZX1qBz/WxSnaeRHiHJ2EubVXj2iaSHM0=;
        h=Date:From:To:Cc:Subject:From;
        b=mTajuYWmuAbYfmmJ2yFqXn0e/aHYDF6JA+KY2WuaELoHe+xqZ841z+zau9aLkywaJ
         XhzkpSwLwfI7+rAjlhryLne8EOttKFipx8GKarwcNmyv9S+ohWYY9GClq/dfg41TcP
         PJ1/OqOnAluSfaxUKVcJePPWtk3o2xz54v0O8CUNN9OVIIqIwSLVq+zcmc5ws1VSeG
         ROHtLOqBA+ClJKOLDtV1+U7YMPu92NrUTDDouKGrruFfwNxWfstdsEoe3CDVk7JyXc
         Yzji/y9Ir2Q8tzAluOhVj+bkKpEdZ3nJVerdb1DZqIqsMwxalF5CoAY/25qa/Ui8oD
         GfVJpURW+sVsA==
Date:   Wed, 6 Oct 2021 13:09:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: stmmac: selftests: Use kcalloc() instead of
 kzalloc()
Message-ID: <20211006180944.GA913477@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 0462dcc93e53..e649a3e6a529 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1104,13 +1104,13 @@ static int stmmac_test_rxp(struct stmmac_priv *priv)
 		goto cleanup_sel;
 	}
 
-	actions = kzalloc(nk * sizeof(*actions), GFP_KERNEL);
+	actions = kcalloc(nk, sizeof(*actions), GFP_KERNEL);
 	if (!actions) {
 		ret = -ENOMEM;
 		goto cleanup_exts;
 	}
 
-	act = kzalloc(nk * sizeof(*act), GFP_KERNEL);
+	act = kcalloc(nk, sizeof(*act), GFP_KERNEL);
 	if (!act) {
 		ret = -ENOMEM;
 		goto cleanup_actions;
-- 
2.27.0

