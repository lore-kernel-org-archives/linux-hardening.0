Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A86BC2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DAB24124
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xqvDPXBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgKTSY6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgKTSY6 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:24:58 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D735C22D0A;
        Fri, 20 Nov 2020 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896697;
        bh=KBzDhAzZHGY8tkFQ5a+WRFRkYcWwaJ4kODIp3uel6Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xqvDPXBvQYv8ejRZqCA510QAiXcg3OlcI4LjOyp8zruUJjArLGpRbdVn+aSwN2kdz
         xm1npoLEoGQemeZjDpWKSvMsNvayCqvBWgo2NeJ018JmOFR8r5GcDJy3P1oKbQLbiS
         squHGYIvex/BP/Dp/+sJBYbOG+Vk/jMUfdapD3Ww=
Date:   Fri, 20 Nov 2020 12:25:03 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 006/141] gfs2: Fix fall-through warnings for Clang
Message-ID: <84d07c8510abf95c9e656454961c09b14485b856.1605896059.git.gustavoars@kernel.org>
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
warnings by explicitly adding multiple goto statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/gfs2/inode.c    | 2 ++
 fs/gfs2/recovery.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 077ccb1b3ccc..9a85214c2505 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -960,6 +960,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 		break;
 	case 0:
 		error = -EEXIST;
+		goto out_gunlock;
 	default:
 		goto out_gunlock;
 	}
@@ -1500,6 +1501,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 			break;
 		case 0:
 			error = -EEXIST;
+			goto out_gunlock;
 		default:
 			goto out_gunlock;
 		}
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index c26c68ebd29d..5b2a01d9c463 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -437,6 +437,7 @@ void gfs2_recover_func(struct work_struct *work)
 		case GLR_TRYFAILED:
 			fs_info(sdp, "jid=%u: Busy\n", jd->jd_jid);
 			error = 0;
+			goto fail;
 
 		default:
 			goto fail;
-- 
2.27.0

