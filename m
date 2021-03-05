Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B0C433E6
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EAF65000
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 10:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEKBq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhCEKB0 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 05:01:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 913BE64F45;
        Fri,  5 Mar 2021 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938486;
        bh=/KDY4J07mjjm5lcTX58j7+USUutizIZZ0ViN5Kxbmkk=;
        h=Date:From:To:Cc:Subject:From;
        b=Wba0wyn23FVcRoRG+6PWHx/1pKQ+xOMbXdSPfMQozz2ZN6Ybn7J9AVOAwIzSxT/nR
         KcjIAFeoqDs40SRiX14JUZKP50pErfkSzJynvaG/+1hE4S86h1M0p/GE9Ph6oNvN23
         i3X+hM6fcNj2i7NPpr/bMmEOGdEszw3J9M5cst/qese7YyEC73+grywUljKG4qXuPM
         /pGk1gl0xptwcxhdXsVa+fWaDAvpNCRkkg+50c63PoTTyURd2Qvk551nxXJ3D4lhyr
         bIlzbf+OaVF3ZHpFGQhZqn4nrRFavdm3T05Z4foQw2v4JCsQTA6fCY/PKZUdF6DxCM
         hEkdDsioq1wCg==
Date:   Fri, 5 Mar 2021 04:01:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] i3c: master: cdns: Fix fall-through warnings
 for Clang
Message-ID: <20210305100123.GA142484@embeddedor>
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

