Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336EC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FC864FE1
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEJZf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEJZH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:25:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11CF964FCF;
        Fri,  5 Mar 2021 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614936306;
        bh=6vV6T20UPqGW4+XtmqeHrshu/Vv3GHspJmUqpSLTC1U=;
        h=Date:From:To:Cc:Subject:From;
        b=SKdnK52VeE68l+tvp/7qjXvMEOvgV6ZdC8u1yt23P7d91ArMA3pO9oMxLFdxS7iH9
         nXKcZ9WCVF0xfycTCnqg0/Lqc6wnlnpmFnlXnfHqRKb5H8eZaMhtflB1co3QFANTsX
         k/PNJnv/k9TaMe0dShRA4VlMMNWzpGUssFioRf4P6QbIwr3Htn/4Cs2Q0IWCwAt92v
         Aw70nzpu+NTN/gYKYTi5+8DnMCgujnNBCCrA8mGBPtwCJiSpYociGMZIApqrAVjia6
         4d9QLLXSQjSOP90USy0YfSKwSTVF8X45CAL0YoDIhsGr8Zjb6pjpUauarmOpmwLGlf
         2qoASeRXGxPpQ==
Date:   Fri, 5 Mar 2021 03:25:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] tipc: Fix fall-through warnings for Clang
Message-ID: <20210305092504.GA140204@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/tipc/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 115109259430..bcc426e16725 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -649,6 +649,7 @@ int tipc_link_fsm_evt(struct tipc_link *l, int evt)
 			break;
 		case LINK_FAILOVER_BEGIN_EVT:
 			l->state = LINK_FAILINGOVER;
+			break;
 		case LINK_FAILURE_EVT:
 		case LINK_RESET_EVT:
 		case LINK_ESTABLISH_EVT:
-- 
2.27.0

