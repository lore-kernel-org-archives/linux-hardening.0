Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4E1C3BE2;
	Mon,  7 Apr 2025 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068503; cv=none; b=Z9gClrOqr/FU6TgNMxrx02Rvn/hGea77diNTVj9N3i64tzCHSHq1NT3km2pA1WGSWNIz8Z6SzDbEjq9VWrig6aey0XvYJXvc/G+dIb7dDPsM11oOf54ic6xSs0gUun4PmjZuCfliKvYNb3u7ZEMaQ05OgDJulcs2S0f9sDKK0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068503; c=relaxed/simple;
	bh=CVByR+4DUcPMIUDLKFFCym0RNlJROf+tgLBlalzq684=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CKwNyDLgBkRm42hc11DV3JClmGdmEmPfbOJdTLAwsjVi1Tqb/eupkvqNT+pn2ta1TqI41HrY6aaSHcNnWjeVbdzJ4322x80cjM6dTROhjvgCc/92i9SS5b/EK366I8Mhp97NIoWPIoQUF17HBsvRuFHaJ5jkNSMMsO6R2hwC7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc/+YKaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc/+YKaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807C3C4CEDD;
	Mon,  7 Apr 2025 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744068503;
	bh=CVByR+4DUcPMIUDLKFFCym0RNlJROf+tgLBlalzq684=;
	h=Date:From:To:Cc:Subject:From;
	b=Dc/+YKaCZAPvYGK1OpQkKOxUDC4ZO/1otb1fw/TRkoT1ODBzj3oSSQds4z2ycU937
	 NLnNR77OWPHc2oP4nPrniVwMT2cAvw6tR8+zW170fZaOtJJPUro7I/wiMi/U0BdSwj
	 b/D7rl3VK3Ra8uk/x5q8es0WnvYaixS109NKHmjTcZHWUfRAISgW8sXXDFn6ax5PV0
	 yzPyiu02cfktINIdyhMlZGl+bMLO+o3irAziOdQk3+UgrGJJPRLcSY6onqa2kfqSZA
	 yRswvfcRXKdC4HKzNujhe6fReAOvHs5dfrftn4xCFS69NvOLKMw729826evop/5AKh
	 cJzRYWcTDvRqw==
Date: Mon, 7 Apr 2025 17:28:20 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] w1: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <Z_RflBe5iDGTMFjV@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

drivers/w1/w1_netlink.c:198:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/w1/w1_netlink.c:219:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Use direct object assignments instead of memcpy(), and gain type checking. (Kees)
 - Add RB tag.

Changes in v2:
 - Fix memcpy() instance - use new pointer `pkg_msg`, instead of `packet`. (Kees)
 - Link: https://lore.kernel.org/linux-hardening/Z_QpOlDTvyfRs4Su@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-WD2NP_1A0ratnI@kspp/

 drivers/w1/w1_netlink.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 691978cddab7..e6b59d921076 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -194,16 +194,16 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
 	int portid, int error)
 {
-	struct {
-		struct cn_msg cn;
-		struct w1_netlink_msg msg;
-	} packet;
-	memcpy(&packet.cn, cn, sizeof(packet.cn));
-	memcpy(&packet.msg, msg, sizeof(packet.msg));
-	packet.cn.len = sizeof(packet.msg);
-	packet.msg.len = 0;
-	packet.msg.status = (u8)-error;
-	cn_netlink_send(&packet.cn, portid, 0, GFP_KERNEL);
+	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
+			sizeof(struct w1_netlink_msg));
+	struct w1_netlink_msg *pkt_msg = (struct w1_netlink_msg *)packet->data;
+
+	*packet = *cn;
+	*pkt_msg = *msg;
+	packet->len = sizeof(*pkt_msg);
+	pkt_msg->len = 0;
+	pkt_msg->status = (u8)-error;
+	cn_netlink_send(packet, portid, 0, GFP_KERNEL);
 }
 
 /**
@@ -215,22 +215,20 @@ static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
  */
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
-	struct {
-		struct cn_msg cn;
-		struct w1_netlink_msg msg;
-	} packet;
-	memset(&packet, 0, sizeof(packet));
+	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
+			sizeof(struct w1_netlink_msg));
+	struct w1_netlink_msg *pkt_msg = (struct w1_netlink_msg *)packet->data;
 
-	packet.cn.id.idx = CN_W1_IDX;
-	packet.cn.id.val = CN_W1_VAL;
+	packet->id.idx = CN_W1_IDX;
+	packet->id.val = CN_W1_VAL;
 
-	packet.cn.seq = dev->seq++;
-	packet.cn.len = sizeof(*msg);
+	packet->seq = dev->seq++;
+	packet->len = sizeof(*msg);
 
-	memcpy(&packet.msg, msg, sizeof(*msg));
-	packet.msg.len = 0;
+	*pkt_msg = *msg;
+	pkt_msg->len = 0;
 
-	cn_netlink_send(&packet.cn, 0, 0, GFP_KERNEL);
+	cn_netlink_send(packet, 0, 0, GFP_KERNEL);
 }
 
 static void w1_send_slave(struct w1_master *dev, u64 rn)
-- 
2.43.0

