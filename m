Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75604C64E7D
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271DC21D91
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwL9eI/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgKTSkF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbgKTSkD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:03 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5212415A;
        Fri, 20 Nov 2020 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897602;
        bh=kvNu1AecsB3qb/9gvKDWdvnXY/lZR0Q75MQ4NElqdiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwL9eI/C9QAKLeFLezdCLBTkkS8bTbKgCJiGMcD8MWJM3JjGb2wa32Pd5Hza0iVn4
         ZI9iQNkjLvkTZHOWxdwpmirLZsYhDKt+3x6D+0rcV92c4zKbIYHmntxCe16bffSjlm
         JTjeA8mzcyVgXGqu65NqYDkOmc+12g4NHdmrm+so=
Date:   Fri, 20 Nov 2020 12:40:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 130/141] tipc: Fix fall-through warnings for Clang
Message-ID: <73d7bf7a4aea53ddce817ac08c043203b48df50f.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
index 06b880da2a8e..839082cf259e 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -615,6 +615,7 @@ int tipc_link_fsm_evt(struct tipc_link *l, int evt)
 			break;
 		case LINK_FAILOVER_BEGIN_EVT:
 			l->state = LINK_FAILINGOVER;
+			break;
 		case LINK_FAILURE_EVT:
 		case LINK_RESET_EVT:
 		case LINK_ESTABLISH_EVT:
-- 
2.27.0

