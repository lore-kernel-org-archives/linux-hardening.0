Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C31F75A9;
	Thu, 13 Mar 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904902; cv=none; b=cqkMtphbKHe4AjcJV5ZGzcaxLnzfpWFCAZLnka4r3BlDz/fkOqXCB2xRAqRUGooyy7TpYM2H9vknzCpad4+WB175dP3CF2XyPFg2ciFo+1u4jQE2zgflDhb3NC6Z+RNKWb7eBf11+HvW7kOOUmQEnA7xVsHFuzmjXvcLszQtbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904902; c=relaxed/simple;
	bh=o7UMXnwXNFO3PGtSyVpZFrQrH7A6FtO8QMXwMvwlE70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KkFcuhoyImP0OptAFVvd6DXe3ktSPvjEJP4HGxDvfvMaAZa2t6UJ43ztRsti76DYXWomI46ZpfjbUab0soyqQRaEUSoYyZZYPWwFVmkeey8EZm1/9cOy8EyEzo2pk+BBT2YnqKUztH1JxIjBf8R+K377FsuzAuZ5sDwl9paChSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKjx50c9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKjx50c9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C55C4CEDD;
	Thu, 13 Mar 2025 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741904901;
	bh=o7UMXnwXNFO3PGtSyVpZFrQrH7A6FtO8QMXwMvwlE70=;
	h=Date:From:To:Cc:Subject:From;
	b=gKjx50c96+AOt7Od3k3N6tlxQyo+ZUO57Mi8Efqkkh+ymAK15/5mOOeErqblDkAdY
	 PIKEuixrcua3aCgwU+ygmjFR+xA2FNGZs1EzrDSZjWs5DQUI3H3iSzpwkyLjSb8ibk
	 dZOL437FCUYJkWWTcT/RTaPgdZi+A3IRSqD4SAxfMTTkYTdyTqSzv7osb/+nimHa+n
	 2OqOpEVMWH/pzPXDDxePeT8+EqU4VT+aCoIw/x6Sdwc3cL2tkDYDXgEyYHykUZtOkI
	 ysgijvjzwj4F0GQS/EyBU6O9VI72+CK6X/yjB/MfSdrf6JexlWOyOgJ/JCBJkhZPk0
	 dACcNyEhhZVBw==
Date: Fri, 14 Mar 2025 08:58:23 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] firewire: core: avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9NcB81yfPo-8o0h@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/firewire/core-cdev.c:1141:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Adjust COUNT argument for DEFINE_RAW_FLEX() to 64. (Takashi)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z9AA9tAbcIcz6BMO@kspp/

 drivers/firewire/core-cdev.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index b360dca2c69e..bd04980009a4 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1137,10 +1137,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 	unsigned long payload, buffer_end, transmit_header_bytes = 0;
 	u32 control;
 	int count;
-	struct {
-		struct fw_iso_packet packet;
-		u8 header[256];
-	} u;
+	DEFINE_RAW_FLEX(struct fw_iso_packet, u, header, 64);
 
 	if (ctx == NULL || a->handle != 0)
 		return -EINVAL;
@@ -1172,29 +1169,29 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 	while (p < end) {
 		if (get_user(control, &p->control))
 			return -EFAULT;
-		u.packet.payload_length = GET_PAYLOAD_LENGTH(control);
-		u.packet.interrupt = GET_INTERRUPT(control);
-		u.packet.skip = GET_SKIP(control);
-		u.packet.tag = GET_TAG(control);
-		u.packet.sy = GET_SY(control);
-		u.packet.header_length = GET_HEADER_LENGTH(control);
+		u->payload_length = GET_PAYLOAD_LENGTH(control);
+		u->interrupt = GET_INTERRUPT(control);
+		u->skip = GET_SKIP(control);
+		u->tag = GET_TAG(control);
+		u->sy = GET_SY(control);
+		u->header_length = GET_HEADER_LENGTH(control);
 
 		switch (ctx->type) {
 		case FW_ISO_CONTEXT_TRANSMIT:
-			if (u.packet.header_length & 3)
+			if (u->header_length & 3)
 				return -EINVAL;
-			transmit_header_bytes = u.packet.header_length;
+			transmit_header_bytes = u->header_length;
 			break;
 
 		case FW_ISO_CONTEXT_RECEIVE:
-			if (u.packet.header_length == 0 ||
-			    u.packet.header_length % ctx->header_size != 0)
+			if (u->header_length == 0 ||
+			    u->header_length % ctx->header_size != 0)
 				return -EINVAL;
 			break;
 
 		case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-			if (u.packet.payload_length == 0 ||
-			    u.packet.payload_length & 3)
+			if (u->payload_length == 0 ||
+			    u->payload_length & 3)
 				return -EINVAL;
 			break;
 		}
@@ -1204,20 +1201,19 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 		if (next > end)
 			return -EINVAL;
 		if (copy_from_user
-		    (u.packet.header, p->header, transmit_header_bytes))
+		    (u->header, p->header, transmit_header_bytes))
 			return -EFAULT;
-		if (u.packet.skip && ctx->type == FW_ISO_CONTEXT_TRANSMIT &&
-		    u.packet.header_length + u.packet.payload_length > 0)
+		if (u->skip && ctx->type == FW_ISO_CONTEXT_TRANSMIT &&
+		    u->header_length + u->payload_length > 0)
 			return -EINVAL;
-		if (payload + u.packet.payload_length > buffer_end)
+		if (payload + u->payload_length > buffer_end)
 			return -EINVAL;
 
-		if (fw_iso_context_queue(ctx, &u.packet,
-					 &client->buffer, payload))
+		if (fw_iso_context_queue(ctx, u, &client->buffer, payload))
 			break;
 
 		p = next;
-		payload += u.packet.payload_length;
+		payload += u->payload_length;
 		count++;
 	}
 	fw_iso_context_queue_flush(ctx);
-- 
2.43.0

