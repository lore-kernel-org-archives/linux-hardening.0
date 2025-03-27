Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AC213E7C;
	Thu, 27 Mar 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094747; cv=none; b=RC0RMe94BIkg3KRl/Nr6PADK90O9yP0hlDhimSwQlblyKnzk76q202NnPGAmhSfbqKVTp9BssW0/5GmoMLMTxABb++X7eLvoTjVE1LRBdmKwselo25PxewWdAwM6a67wWyPIinjAtS9KhJJOz+bIxuQ5ev22lJwbwCqUrvS1bIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094747; c=relaxed/simple;
	bh=5NtcoshgRtxufku9YJABlgnqk6ZvaIJtmkUl5omRUG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GRmuPrfvZ6/8e+Z2sGIYSBhFWu5OItuwX3SncwzarmmW7EMOSjG5gr+eIKsRYZA7qu0yNu578NWhyxxs4HxEVKD4vIQvCNxPmMAC0lLgA1X2QdHzg358dE6ZYBhCCGz/PS7tkBv2yVCXaMoX6MYwbNWSRWHSVblGCkpT9ewBJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRM3L2l0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRM3L2l0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C50BC4CEE5;
	Thu, 27 Mar 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743094747;
	bh=5NtcoshgRtxufku9YJABlgnqk6ZvaIJtmkUl5omRUG4=;
	h=Date:From:To:Cc:Subject:From;
	b=YRM3L2l02bFFw1py9egSBn+Jm0qJwTV0H2WQ1tLff3t5DcUcMZ6jCVVTzGitgCDZd
	 ujS5ooaI672EasL0l69zwN1JFj2lsa+B/ffK3/B/R+18f/SH0fFMJwvws5HOKxubTH
	 i3Ol5ut3kmxgV99/OM0jcmpmQhLm6PsAwpJUckzQO0Zohfy1S2Aw4dIvL7dMZF35xH
	 k6C3C2FlBGsLrMp8H/FTC0aFZExURNYVbd2//G2tMOp09RO1/Sd6+rRlNcitSeNY+A
	 VGcgu21pr/zTVsrcjQh0emUHB8tkw0hDSzzMAL7K/FVn0Vz28mU8PLBblFdYQAF0Ba
	 mHzmvStstVtQg==
Date: Thu, 27 Mar 2025 10:59:04 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] w1: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <Z-WD2NP_1A0ratnI@kspp>
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

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/w1/w1_netlink.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 691978cddab7..845d66ab7e89 100644
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
+	memcpy(packet, cn, sizeof(*packet));
+	memcpy(pkt_msg, msg, sizeof(*pkt_msg));
+	packet->len = sizeof(*pkt_msg);
+	pkt_msg->len = 0;
+	pkt_msg->status = (u8)-error;
+	cn_netlink_send(packet, portid, 0, GFP_KERNEL);
 }
 
 /**
@@ -215,22 +215,19 @@ static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
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
+	memcpy(packet, msg, sizeof(*msg));
+	((struct w1_netlink_msg *)packet->data)->len = 0;
 
-	cn_netlink_send(&packet.cn, 0, 0, GFP_KERNEL);
+	cn_netlink_send(packet, 0, 0, GFP_KERNEL);
 }
 
 static void w1_send_slave(struct w1_master *dev, u64 rn)
-- 
2.43.0

