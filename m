Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50925C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F1764FFD
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCEHkm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHkm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 02:40:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D15764FFD;
        Fri,  5 Mar 2021 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614930041;
        bh=TMB+VspMfpQaDgELNuFuzkz3wGytJH9MpU0ojKUhGRA=;
        h=Date:From:To:Cc:Subject:From;
        b=FX7kxcoCvRHixXWJCJ1unVen3UYt+5Ruvv+O4A6SbEbJVfo2f8eaSlKGjpUnzldtF
         /4NDv9HiMNdDwY1zfUfUfGqJeXsk0l9wK5aaV64IM2eAV5pTjLXXNkBj3/6m3D6rM0
         R0X1sNGSwS0pvHRVk/jxTv4XxGBkMZesB+O5aFazEbC9xG7h5lLJFcMk+y48pug4kH
         utTF86JxH6WK/N1/60TsXJra+OAHPb+QP4yZIWDlP9Fv7qhalkXpB5CIJgvTV0sr/D
         AVoacwLB136wKYqkyno53ZLntkReXxgzGysn8mwIcYsUBcU4rHmDJr9Sg7w5LH5hP5
         c1zOXEA/rHV/Q==
Date:   Fri, 5 Mar 2021 01:40:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: bridge: Fix fall-through warnings for Clang
Message-ID: <20210305074038.GA122888@embeddedor>
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
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bridge/br_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 222285d9dae2..8875e953ac53 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -144,6 +144,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		break;
 	case BR_PKT_UNICAST:
 		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

