Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B148BC64E7D
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DCD2415A
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIFbt29A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgKTSfC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbgKTSfB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:01 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743E9246DE;
        Fri, 20 Nov 2020 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897301;
        bh=piqvs7rCMALtyDMI1LTahMJ4NDFADZmqK1CjDXF1jSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIFbt29AYyvWysVN5B8nHdox6QPsVab+jUkbpp4UqqteVpKcOexYWm5MxllNksu1/
         7SupxxGf8ULzDPVB7AEgBDvQa9So2YI3g5VCXgc/cLvrE0WenS6i99mjkUbfQXvW8D
         GZf/MIOm1H5qawBZyVJPB558t81myocYsr33efBk=
Date:   Fri, 20 Nov 2020 12:35:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 077/141] dm raid: Fix fall-through warnings for Clang
Message-ID: <d17978db8a2bae019d2c858a51e9f6abf8ea8947.1605896059.git.gustavoars@kernel.org>
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
 drivers/md/dm-raid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9c1f7c4de65b..e98af0b9d00c 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -1854,6 +1854,7 @@ static int rs_check_takeover(struct raid_set *rs)
 		    ((mddev->layout == ALGORITHM_PARITY_N && mddev->new_layout == ALGORITHM_PARITY_N) ||
 		     __within_range(mddev->new_layout, ALGORITHM_LEFT_ASYMMETRIC, ALGORITHM_RIGHT_SYMMETRIC)))
 			return 0;
+		break;
 
 	default:
 		break;
-- 
2.27.0

