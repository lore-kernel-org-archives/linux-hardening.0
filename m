Return-Path: <SRS0=+MkC=DJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F2C35257
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 22:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3527020796
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601679253;
	bh=5Ev7VhlEKaLk5p6zUg3FhFQxuOwEewy54WkhQmLTxV0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fRks9FDqT5Ic/3ALBB/fD3Wg18udGU3rbP63REmA/7SLPQ4y+3/rgmZBF+Y2FxmQ7
	 WTWVUvndN/m0Z1FSL7EKnOxweh+ZxTKry+5exr87B54iqsD4TqjaiVIetI5nTlipfT
	 bPJCpoBAT19dIHnADgbN6DhSdoWLXNOPm355k9qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJBWyN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWyM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Oct 2020 18:54:12 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 998F8206DD;
        Fri,  2 Oct 2020 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601679252;
        bh=5Ev7VhlEKaLk5p6zUg3FhFQxuOwEewy54WkhQmLTxV0=;
        h=Date:From:To:Cc:Subject:From;
        b=pM0JPuPHSZMYQCpcjj/Ija/lDH4iGrgndQTbD8NyNnQpLukEt30oFlPWzdn7CBUNx
         ZpIF0Oj2o7Lc19xA5dCh7JhQQ6UNlCt3VElRLWbgZ/8njYGGTUPoCmJ50n/S4GpDfi
         KidP28zfjzT376Y7T4fvVmn6nCgXJo6KgVdh/Tgk=
Date:   Fri, 2 Oct 2020 18:00:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: bna: Use fallthrough pseudo-keyword
Message-ID: <20201002230001.GA3320@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replace /* !!! fall through !!! */ comments with the new pseudo-keyword
macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index fd805c685d92..cd933817a0b8 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -269,7 +269,7 @@ bfa_ioc_sm_enabling(struct bfa_ioc *ioc, enum ioc_event event)
 		break;
 
 	case IOC_E_PFFAILED:
-		/* !!! fall through !!! */
+		fallthrough;
 	case IOC_E_HWERROR:
 		ioc->cbfn->enable_cbfn(ioc->bfa, BFA_STATUS_IOC_FAILURE);
 		bfa_fsm_set_state(ioc, bfa_ioc_sm_fail);
@@ -365,7 +365,8 @@ bfa_ioc_sm_op(struct bfa_ioc *ioc, enum ioc_event event)
 	case IOC_E_PFFAILED:
 	case IOC_E_HWERROR:
 		bfa_ioc_hb_stop(ioc);
-		/* !!! fall through !!! */
+		fallthrough;
+
 	case IOC_E_HBFAIL:
 		if (ioc->iocpf.auto_recover)
 			bfa_fsm_set_state(ioc, bfa_ioc_sm_fail_retry);
-- 
2.27.0

