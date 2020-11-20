Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60789C56201
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144B22415B
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFQ/8xs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKTS0z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbgKTS0z (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:26:55 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65B22224C;
        Fri, 20 Nov 2020 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896814;
        bh=1NwcLzTCzMR/RVGmK1Xfe8+ZCIDDD2CiKdkIFNgmFCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFQ/8xs/+NBEHmdxQFnU4qFhPs/6XQFwq3MDdx1bp/y2+PKmBgTC7pd5VbTLQ4HAz
         p3gJVVGgmXHJ8TG+d5MXZIbBjUhpWq5bnfaaI3Gg7TWi1Rr4YTLRNmX48KjZ2fHgc+
         rAYSh6+lZasvYPeUGlMvBXDKDMkvAo9qQhwkLPw0=
Date:   Fri, 20 Nov 2020 12:27:00 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Shahed Shaikh <shshaikh@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 019/141] qlcnic: Fix fall-through warnings for Clang
Message-ID: <eefc71abc4b51187598ed5f407a6d79cb24125c9.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding a break and a goto statements instead of
just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c   | 1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index bdf15d2a6431..af4c516a9e7c 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -1390,6 +1390,7 @@ static int qlcnic_process_rcv_ring(struct qlcnic_host_sds_ring *sds_ring, int ma
 			break;
 		case QLCNIC_RESPONSE_DESC:
 			qlcnic_handle_fw_message(desc_cnt, consumer, sds_ring);
+			goto skip;
 		default:
 			goto skip;
 		}
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 5a7e240fd469..3abbd22e2ed3 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -3456,6 +3456,7 @@ qlcnic_fwinit_work(struct work_struct *work)
 			adapter->fw_wait_cnt = 0;
 			return;
 		}
+		break;
 	case QLCNIC_DEV_FAILED:
 		break;
 	default:
-- 
2.27.0

