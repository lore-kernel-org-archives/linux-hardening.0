Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FBC433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 05:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EF964FE3
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 05:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCJFoG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 00:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhCJFns (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 00:43:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57C2864F6D;
        Wed, 10 Mar 2021 05:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615355027;
        bh=yAg8R9FSz2qmBTMCcjwkVEKAsIfn2g5B+rrRdFb2blg=;
        h=Date:From:To:Cc:Subject:From;
        b=d7z9DzWbSoLbs34tbH0j18sAEVTrIf7hyyQNvaPgW/zHDMVLMw2pthn/wbYY5WcQw
         iu8JputDtusRXem/7v2Q3bvACPhAeu8apoGcEZdqXShOfqG/FCARmRMVhG00hYstbM
         ybjOm9R2y+DbdunhJ/Usjsamu44uPSLeqKPAaYKjX1Pcu/T8GmQAD91g97rYhpbELO
         pXj2oN6YjpPRRYJCDPJyiEurRcNPvZKx/BywWxYGc4TRKgfgti36yOUGGTF4JqoJGg
         WGByqfHKFoQp91VVkpvrVmWL/PifteiQW8PKO7IoNUAIj3pgZ4pueVOEf/6+jsSXFE
         TwLNjyZdMcY3A==
Date:   Tue, 9 Mar 2021 23:43:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] net: rose: Fix fall-through warnings for Clang
Message-ID: <20210310054345.GA286021@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 Changes in RESEND:
 - None. Resending now that net-next is open.

 net/rose/rose_route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 6e35703ff353..c0e04c261a15 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -347,6 +347,7 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 				case 1:
 					rose_node->neighbour[1] =
 						rose_node->neighbour[2];
+					break;
 				case 2:
 					break;
 				}
@@ -508,6 +509,7 @@ void rose_rt_device_down(struct net_device *dev)
 					fallthrough;
 				case 1:
 					t->neighbour[1] = t->neighbour[2];
+					break;
 				case 2:
 					break;
 				}
-- 
2.27.0

