Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F13C2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915922224C
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTHpbrAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgKTSZw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgKTSZw (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:25:52 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6032408E;
        Fri, 20 Nov 2020 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896751;
        bh=uZWmxgfdOdFabCbBvzKOKhMyyNHWXjLVdgLFGOjqNzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTHpbrAYm40qVEhS7bOxhqSfxV5D+O9MrDpJZYge2WHFJJ2P17vU16dF3LHrn8bVg
         AD2vXnsRCxbJR0audAyptm3maXfo9TzPZOctXEEBEFS9sZXFlIu0NmUmFVSg6e5otW
         QOPESblO+gnEHUF2+SepENZ7DsIFdjI9s4d/AHcw=
Date:   Fri, 20 Nov 2020 12:25:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 011/141] ipv4: Fix fall-through warnings for Clang
Message-ID: <198dc0032c5454fed7ebc9e8d05cb6463a6df563.1605896059.git.gustavoars@kernel.org>
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
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/ipv4/ah4.c           | 1 +
 net/ipv4/esp4.c          | 1 +
 net/ipv4/fib_semantics.c | 1 +
 net/ipv4/ip_vti.c        | 1 +
 net/ipv4/ipcomp.c        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index d99e1be94019..18d451414601 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -450,6 +450,7 @@ static int ah4_err(struct sk_buff *skb, u32 info)
 	case ICMP_DEST_UNREACH:
 		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
 			return 0;
+		break;
 	case ICMP_REDIRECT:
 		break;
 	default:
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 8b07f3a4f2db..a12ef89e8520 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -987,6 +987,7 @@ static int esp4_err(struct sk_buff *skb, u32 info)
 	case ICMP_DEST_UNREACH:
 		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
 			return 0;
+		break;
 	case ICMP_REDIRECT:
 		break;
 	default:
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1f75dc686b6b..647a67516b80 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1872,6 +1872,7 @@ static int call_fib_nh_notifiers(struct fib_nh *nh,
 		    (nh->fib_nh_flags & RTNH_F_DEAD))
 			return call_fib4_notifiers(dev_net(nh->fib_nh_dev),
 						   event_type, &info.info);
+		break;
 	default:
 		break;
 	}
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index b957cbee2cf7..60e0311ec51f 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -349,6 +349,7 @@ static int vti4_err(struct sk_buff *skb, u32 info)
 	case ICMP_DEST_UNREACH:
 		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
 			return 0;
+		break;
 	case ICMP_REDIRECT:
 		break;
 	default:
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index b42683212c65..bbb56f5e06dd 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -31,6 +31,7 @@ static int ipcomp4_err(struct sk_buff *skb, u32 info)
 	case ICMP_DEST_UNREACH:
 		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
 			return 0;
+		break;
 	case ICMP_REDIRECT:
 		break;
 	default:
-- 
2.27.0

