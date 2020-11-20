Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362BC63777
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2735F2415A
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRL8r0R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgKTSgK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKTSgJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:36:09 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7181824178;
        Fri, 20 Nov 2020 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897369;
        bh=/KDY4J07mjjm5lcTX58j7+USUutizIZZ0ViN5Kxbmkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRL8r0R3Mdb47Vlf9I97aZMr5QO3SEebP18pjNtVd1HBd8nsl8CFBXiVYGkOXyDCf
         QWF23eaSG5b14+hgQXX+ZLhRkgoYmEHRK1mYTGOfJbwnLvENaNhv7OgBFSEjWPrHVa
         HWIqelj7mIqnlJqunk8qT5tlf9VaffVauMDbki/g=
Date:   Fri, 20 Nov 2020 12:36:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 088/141] i3c: master: cdns: Fix fall-through warnings for
 Clang
Message-ID: <84750a7bd4a70dbebd6662c5d5bf132b2a215d06.1605896060.git.gustavoars@kernel.org>
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
 drivers/i3c/master/i3c-master-cdns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 3f2226928fe0..5b37ffe5ad5b 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1379,6 +1379,8 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
 		case IBIR_TYPE_MR:
 			WARN_ON(IBIR_XFER_BYTES(ibir) || (ibir & IBIR_ERROR));
+			break;
+
 		default:
 			break;
 		}
-- 
2.27.0

