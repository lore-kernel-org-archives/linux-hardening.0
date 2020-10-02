Return-Path: <SRS0=+MkC=DJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC4C35257
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C048206FA
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601680827;
	bh=PugfrUh5stDcKHHiPjfHqMGFq11lfD5qJ+/y5PhV37E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gwOx5mitUKzE7dfyvxPSueqsOuWAgVzMiHidDQEF0HB9G8lYFdvVSTIRZDy8MD+47
	 XRexNzmnAMbsYhgM8t9oFqJV/Jm1+zw15aewJIZwgjSFvvJLAbSjoX20vY8Egmi1Io
	 L13d4Yihw0TspohvozEoAcnexnFfN7SgahX448LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgJBXUX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXUW (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Oct 2020 19:20:22 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B3B206FA;
        Fri,  2 Oct 2020 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601680822;
        bh=PugfrUh5stDcKHHiPjfHqMGFq11lfD5qJ+/y5PhV37E=;
        h=Date:From:To:Cc:Subject:From;
        b=kql56anQh9eEBRywc8l6cotR9BtYFyPO7mCvDx6D4/QAe9PuYY0oWfXJS2WOjmgPg
         EOpbxK42xfnavsUOkc0KA4sGPZ4/lgFD6a0VMJ/e1sU8TJl9ob5sgbrVnn4IQaBAFT
         nGMFEzBNaONnJgWWdV9GwEDWEX84ZLJ76RdQ2k1E=
Date:   Fri, 2 Oct 2020 18:26:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] bnx2x: Use fallthrough pseudo-keyword
Message-ID: <20201002232611.GA8809@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replace /* no break */ comments with the new pseudo-keyword macro
fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 9e258fc50a7e..28069b290862 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -6313,11 +6313,11 @@ static void bnx2x_init_internal(struct bnx2x *bp, u32 load_code)
 	case FW_MSG_CODE_DRV_LOAD_COMMON:
 	case FW_MSG_CODE_DRV_LOAD_COMMON_CHIP:
 		bnx2x_init_internal_common(bp);
-		/* no break */
+		fallthrough;
 
 	case FW_MSG_CODE_DRV_LOAD_PORT:
 		/* nothing to do */
-		/* no break */
+		fallthrough;
 
 	case FW_MSG_CODE_DRV_LOAD_FUNCTION:
 		/* internal memory per function is
-- 
2.27.0

