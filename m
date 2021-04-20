Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818FC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF66613F4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 21:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDTVQb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233882AbhDTVQ3 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 17:16:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F4D761076;
        Tue, 20 Apr 2021 21:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618953356;
        bh=An5dy6CsC1BMaoFOvaAgr9a1mexHuCaV5SCWxfkFBkQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Fgj5CNdXiZ3UzLmLoq7lTDRz0fQ3dE7NUQUNbuZGcRBBX/az/+2IHD4/rLKd26jUD
         /AhyV4w1lMRXXjTMDDgYvRBVWPNssm5usY09j559RiYUsngHNXJpQRKO92lw+AmECY
         4Oi5KiJJPCWX8LOf4tPAjYX8CsBXgU6V9O8N+bUMQQ47xl+77v3fA9PKN0e8ER9ybJ
         CRc4uYsHSW9d1Zmg0PmhTKfCSbicjiYMtDr1kISsnskZrFszvtalrYd3rz8qLfr7vl
         /CI2Od7Nc7HxeoUgSoqYf9FED5/CrA7qazr4B/rTG7pXVZ2ZdPMsESpEYFig7/6+uU
         5j5cTK9VPq7rg==
Date:   Tue, 20 Apr 2021 16:16:15 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] afs: Fix fall-through warnings for Clang
Message-ID: <20210420211615.GA51432@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Changes in v2:
 - Place blank line after the fallthrough markings, not before.
   Link: https://lore.kernel.org/linux-hardening/748935.1606147853@warthog.procyon.org.uk/

 fs/afs/cmservice.c | 5 +++++
 fs/afs/fsclient.c  | 4 ++++
 fs/afs/vlclient.c  | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index a4e9e6e07e93..d3c6bb22c5f4 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -322,6 +322,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			return ret;
 
 		call->unmarshall++;
+		fallthrough;
+
 	case 5:
 		break;
 	}
@@ -418,6 +420,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 			r->node[loop] = ntohl(b[loop + 5]);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 2:
 		break;
@@ -530,6 +533,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 			r->node[loop] = ntohl(b[loop + 5]);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 2:
 		break;
@@ -663,6 +667,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
+		fallthrough;
 
 	case 3:
 		break;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2f695a260442..dd3f45d906d2 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -388,6 +388,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		req->file_size = vp->scb.status.size;
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 5:
 		break;
@@ -1408,6 +1409,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		_debug("motd '%s'", p);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 8:
 		break;
@@ -1845,6 +1847,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 6:
 		break;
@@ -1979,6 +1982,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 4:
 		break;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index dc9327332f06..00fca3c66ba6 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -593,6 +593,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (ret < 0)
 			return ret;
 		call->unmarshall = 6;
+		fallthrough;
 
 	case 6:
 		break;
-- 
2.27.0

