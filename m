Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE84C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA764FE2
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEJpe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCEJpd (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:45:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEB3F64FE2;
        Fri,  5 Mar 2021 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937532;
        bh=ivFJLmI4A7fdop5ItsWS2wAflvG/F4vJlncUIBuPGu0=;
        h=Date:From:To:Cc:Subject:From;
        b=mC/C1pu30D+hKnJ/Y0p+7GnRKxx6nSsIGqPlBTQd9mV1y9n19eyTgYQZo1laocQt0
         8yHNC/Tgg0ZIBlWX+jwqlB7z225h6ws40o9e/o/XwT2NYx5q7doH5DAWznlbr8JmuA
         6o3/n3fUYgoyL1Yuuqag87VnPlD1ES13bVaLp4PwFK9WfJU5FiQiSIfb5v69XmZLTh
         B1h7pXMGh8ymxT/O9aTSTooY6YfJt95xb2PyDHefEH4tOZX3ltIfK/g7mht8zU/cbg
         FmDIzk9F6MB1F02l40nWq7jChOJjcB8J7s8O7XUFvEhpYF0Yi9nNLhQNaeRXj3/XiA
         omwMtw5TgnTQg==
Date:   Fri, 5 Mar 2021 03:45:29 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Manish Chopra <manishc@marvell.com>,
        Rahul Verma <rahulv@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] netxen_nic: Fix fall-through warnings for Clang
Message-ID: <20210305094529.GA140903@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a goto statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 08f9477d2ee8..35ec9aab3dc7 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1685,6 +1685,7 @@ netxen_process_rcv_ring(struct nx_host_sds_ring *sds_ring, int max)
 			break;
 		case NETXEN_NIC_RESPONSE_DESC:
 			netxen_handle_fw_message(desc_cnt, consumer, sds_ring);
+			goto skip;
 		default:
 			goto skip;
 		}
-- 
2.27.0

