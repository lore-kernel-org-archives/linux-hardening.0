Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB5C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 06:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AD864FE7
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 06:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhCJGHa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhCJGHE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 01:07:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B105264FE3;
        Wed, 10 Mar 2021 06:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615356424;
        bh=04oIBUR6a4KB5abNXd0OCvGeyJjnBjVKCrcbAvITkJ8=;
        h=Date:From:To:Cc:Subject:From;
        b=pSQDjq4FaDhjPAmsqNt0VLulc16iLx51DQmIfpqyhN0prG0Pd/fZ9KPBfEMEE+Ry5
         s39XV73OY73YtsuJl7pH66gmBceO294ivxXkdJyJC0n4D9EL18C1zTCRIsaeqzq//4
         75BhsL66aE/PAOY8SDtEtQigZRylnXpCyuOwFd2Lbs8sSiGt59s7t+tgsLdRXnkccH
         sWvE34h8k1zRL51D3QzVfKsHldjNRqo+V4y/4gxMG2I3nrdaljIbPjKsGgqTxkr1Bo
         bJI43ymidvAh9KvC7Z3GIS5ziyHIyLDI6lyPQGYWUE/JZOs2fvUxv5N23wV6UF9rNR
         edX7TxfE9YXzA==
Date:   Wed, 10 Mar 2021 00:07:01 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] qed: Fix fall-through warnings for Clang
Message-ID: <20210310060701.GA286866@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding a couple of break statements instead of
just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 Changes in RESEND:
 - None. Resending now that net-next is open.

 drivers/net/ethernet/qlogic/qed/qed_l2.c    | 1 +
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 07824bf9d68d..dfaf10edfabf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -396,6 +396,7 @@ int qed_sp_eth_vport_start(struct qed_hwfn *p_hwfn,
 		tpa_param->tpa_ipv6_en_flg = 1;
 		tpa_param->tpa_pkt_split_flg = 1;
 		tpa_param->tpa_gro_consistent_flg = 1;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index b8dc5c4591ef..ed2b6fe5a78d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -4734,6 +4734,7 @@ void qed_inform_vf_link_state(struct qed_hwfn *hwfn)
 			 */
 			link.speed = (hwfn->cdev->num_hwfns > 1) ?
 				     100000 : 40000;
+			break;
 		default:
 			/* In auto mode pass PF link image to VF */
 			break;
-- 
2.27.0

