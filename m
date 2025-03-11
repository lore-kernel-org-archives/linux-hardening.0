Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686822ACF2;
	Tue, 11 Mar 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684981; cv=none; b=dQNEQnNaKY9y4eVJwh563rRD8dkJK8i4hTJVtQqMXxh+SBV4XcACIkss64KspCuXtGSmmXXhtVD7/agIX8mBYHOIG0W0NxEiHvZNlCgMqYfjjsjEy6Gzr2QZEOvGHQWuinjliqW0lS4iCj2sUOwlC6yXyPM0PPriCIylPyEsEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684981; c=relaxed/simple;
	bh=77QhMQsVpgP+AJqEOW7V4/LuIhOOKSTe/ddBhBIJ+EA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pf5wMROWKPtZPThhyDCOqRy8tYt0pYs7jmH4TywDc3XtDxaAsyG4vO/Tv0U68R4egLqob1JXGDyaF8rt1tG0VgjxtG7TQ2r6eB0u74RKtNoZhBdRRtA+n9Fy9pvsTMawHpXBmxYtpylQSySGQf1XlrSt2lw48hf0KsxWYDR/1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw8Pf6qJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw8Pf6qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BC3C4CEE9;
	Tue, 11 Mar 2025 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741684981;
	bh=77QhMQsVpgP+AJqEOW7V4/LuIhOOKSTe/ddBhBIJ+EA=;
	h=Date:From:To:Cc:Subject:From;
	b=Gw8Pf6qJzcM+ytgend2XHW1VdXnwwqdXL1LJ+SQ8PxM09hXH/jC1wt9O+TYmb0xmk
	 UzjcsjWbzk0k5Dan/HhpaIoBcK1XX1vQYYTaJHO7/yb4bv417Fxa7Lry8yyf8R9TIf
	 h8d8rpENIk85vCk3AFoijEKireAOy+cFx1EiAX/WpPCs7XX6wQGHfddLGAFBGuV9et
	 B9Ju8r+IDlvy8F6l7TA4ReGiW+A9uTbjbdG0/ntJbIVKCgUkLhlBqBr/Gur//7C0AZ
	 Bxsm2Lsn6Dw3n0zRBBBaPFEQCK+u+EvUkAkzKAbyOkBpL4kjOM+Y2nepSiAjbQJN7P
	 fB3zX1J6rSNpw==
Date: Tue, 11 Mar 2025 19:53:02 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] firewire: core: avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9AA9tAbcIcz6BMO@kspp>
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
 drivers/firewire/core-cdev.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index b360dca2c69e..706b9037faac 100644
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
+	DEFINE_RAW_FLEX(struct fw_iso_packet, u, header, 8);
 
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

