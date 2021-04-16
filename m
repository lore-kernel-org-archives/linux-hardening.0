Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72BC433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5296137D
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 19:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhDPTcF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhDPTcE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 15:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 123CE611AB;
        Fri, 16 Apr 2021 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618601499;
        bh=8LNu5JOmFuLKWCjhg6+ayA0INbjk1fmtkW1OrPWr+Os=;
        h=Date:From:To:Cc:Subject:From;
        b=vIgrnyPgyyP3Dnnu1GZGQWUmQ3qTzbLx+61BK6VWmsBilTmeF6jbPUrq4UC85nAL9
         kTYW/2xQzfnnf3dP5iw/r8oaxsFNPmV1eowFR53qnELNza9h6548PMCpTCSS2BM5pS
         ImM2wrKFBC+07nATJOUFURB8cdcsoavq+gMGHJBnWisb1V7YDvcR/T/S8Fbpxeosvo
         gv5HAW1KJomao7bPzxZBqaTmLxphzMgO3MiGG/a2Uir4WzQnnnS7smG+tq4FBKMyUz
         48D1gRIr2gnCOBLKJi/bqHhjmsZI514jYNc7bRb40nuTIf699NUp1ppYX3aoZBE5vo
         CDDqefV2OD2zA==
Date:   Fri, 16 Apr 2021 14:31:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] flow_dissector: Fix out-of-bounds warning in
 __skb_flow_bpf_to_target()
Message-ID: <20210416193151.GA591935@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix the following out-of-bounds warning:

net/core/flow_dissector.c:835:3: warning: 'memcpy' offset [33, 48] from the object at 'flow_keys' is out of the bounds of referenced subobject 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy().  So, the compiler legitimately complains about it. As these
are just a couple of members, fix this by copying each one of them in
separate calls to memcpy(). 

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/core/flow_dissector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5985029e43d4..3ed7c98a98e1 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -832,8 +832,10 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_addrs = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
 						      target_container);
-		memcpy(&key_addrs->v6addrs, &flow_keys->ipv6_src,
-		       sizeof(key_addrs->v6addrs));
+		memcpy(&key_addrs->v6addrs.src, &flow_keys->ipv6_src,
+		       sizeof(key_addrs->v6addrs.src));
+		memcpy(&key_addrs->v6addrs.dst, &flow_keys->ipv6_dst,
+		       sizeof(key_addrs->v6addrs.dst));
 		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
-- 
2.27.0

