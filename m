Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112CCC83025
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE3E22464
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf0kj7uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgKTSjw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbgKTSjv (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:39:51 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900232242B;
        Fri, 20 Nov 2020 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897591;
        bh=NSiVkHuwCQOGIqiUhJTbQNG/xlYA2hjEuMHcHZMtryY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf0kj7uBEwJeWgtiAS+MM9Ku9rgGv4HAm4a8OHNbLs8YFxbvlP+eSqXqDXvYwTp+e
         uPwiT7oJesHIwJCGCI1MsXTf/4mtLGhs0SDce1lpjcb62n3uMxvXM9K8TjRbz3W3Cj
         thNaR5lt+EJGtCCIz9NzZVCsxnqWk8VxYkr2smTM=
Date:   Fri, 20 Nov 2020 12:39:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 128/141] staging: vt6656: Fix fall-through warnings for Clang
Message-ID: <5a5a8f2489fbf61f65f0241c349737f7c9ad59ca.1605896060.git.gustavoars@kernel.org>
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
 drivers/staging/vt6656/main_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 8bf851c53f4e..b90d3dab28b1 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -914,6 +914,7 @@ static int vnt_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 			vnt_mac_disable_keyentry(priv, key->hw_key_idx);
 		}
+		break;
 
 	default:
 		break;
-- 
2.27.0

