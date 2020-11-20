Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21144C2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EF02224C
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6hbfNm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKTSXf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgKTSXe (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:23:34 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E672245F;
        Fri, 20 Nov 2020 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896614;
        bh=4il2CEZoCKcJXQQ0vpXfQ07KoUbxtz38uBIgtlCe3s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6hbfNm7FP2bGCTl4IcA1ubwo+aXmFZt1uQ5hynZrH+hP1VpipsShSuFoaMn8J9yF
         cf1h4UP1Xb6b03f2wKxZvDmC7ExMNBhAg0p62IPKN57sjoWe6I9AVLDfbEIq+L1JiY
         Rom3aCniYB7lrMrrPGCJyBHaKb6Oo+Zu/OsU91Cs=
Date:   Fri, 20 Nov 2020 12:23:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 001/141] afs: Fix fall-through warnings for Clang
Message-ID: <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
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
warnings by explicitly adding multiple fallthrough pseudo-keywords
in places where the code is intended to fall through to the next
case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/afs/cmservice.c | 5 +++++
 fs/afs/fsclient.c  | 4 ++++
 fs/afs/vlclient.c  | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index a4e9e6e07e93..d17b31dfe63f 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -322,6 +322,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			return ret;
 
 		call->unmarshall++;
+
+		fallthrough;
 	case 5:
 		break;
 	}
@@ -419,6 +421,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 
 		call->unmarshall++;
 
+		fallthrough;
 	case 2:
 		break;
 	}
@@ -531,6 +534,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 		call->unmarshall++;
 
+		fallthrough;
 	case 2:
 		break;
 	}
@@ -664,6 +668,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
+		fallthrough;
 	case 3:
 		break;
 	}
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1d95ed9dd86e..a00eaa155012 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -405,6 +405,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		req->file_size = vp->scb.status.size;
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 5:
 		break;
@@ -1444,6 +1445,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		_debug("motd '%s'", p);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 8:
 		break;
@@ -1881,6 +1883,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 6:
 		break;
@@ -2015,6 +2018,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 4:
 		break;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index dc9327332f06..29930ea16652 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -594,6 +594,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return ret;
 		call->unmarshall = 6;
 
+		fallthrough;
 	case 6:
 		break;
 	}
-- 
2.27.0

