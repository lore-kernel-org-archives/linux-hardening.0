Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3423C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBDE64EE8
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCEI7L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhCEI6t (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:58:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC9B60C3D;
        Fri,  5 Mar 2021 08:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614934728;
        bh=tnyEQxy0Y/KOIM6iOkT9Z8U4KODj9rAGSc5t67PmiNw=;
        h=Date:From:To:Cc:Subject:From;
        b=NxcMK/LIhqnIHIGDpk7a2D0VosKxGgcarl24qEzK/0FqZ8J/47tU31Qg9Tz5gGfsf
         E5jH75Dc/8PAeeKXTNKLh80kUYfPb+THm8stH6LPdlj8NSY80ukPr8+LBICIqf31oy
         tvdDZna8myVh43MQOQEz4snHXvmtijtnnqLV5thO5IBuB1wGYjvnTa42NjsYn74pEF
         JbhO20C0asNY9ARESDwFO02ZvI+WF5PGRfQnfFMyl5IEPqhU8ljUj8o6oZrEepgy3Q
         VfiA4iuo6Ztr/mQHUKGJeKae18c1YoIwcvZZ7Hbe0pAOK3yG0uQxwowz11EMC5I1bx
         pEtO1CeogKJ4w==
Date:   Fri, 5 Mar 2021 02:58:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] qed: Fix fall-through warnings for Clang
Message-ID: <20210305085845.GA138782@embeddedor>
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

