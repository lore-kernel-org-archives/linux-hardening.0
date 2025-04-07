Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358922068F;
	Mon,  7 Apr 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054589; cv=none; b=AAE69tLYQaGdPNrcu0WaWScJajWkmCWnU5gWayYh/Uc0GRaT+coiUnTJtU9ABZzq+jB9lWmIvaPuxX2fVxvW/ox09v3fx9XOmU7nV2UlqfzPDwU8KC8+d+3guIrjE0fmk4ZCyTDhXwNGg+u9rg4Hsp4qBj5nbdVmpHcXzqZc14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054589; c=relaxed/simple;
	bh=C2w2lOcwPcrCvotdyulR6kXCscgjaiIOaat+VIngv+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dHMNYeVr8FrsNSHl1qGaTPaVeJO4daUM69OQCVp5svcS/Lv8GV2eCEIglbq15jDP8lbSiay+FpvCOg36Lvf9cjdaVTBomc0YhnlQcB2RxC/UqfHTk8AhKpKfuQ27/GGK9B6BPi6JcHELYMFY8zDyc7J7lwsuAj3u7ZW3b+savWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUsva2T2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUsva2T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E10C4CEEC;
	Mon,  7 Apr 2025 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744054588;
	bh=C2w2lOcwPcrCvotdyulR6kXCscgjaiIOaat+VIngv+A=;
	h=Date:From:To:Cc:Subject:From;
	b=NUsva2T2lhgFXF9sxYwI7KwExu4fozsIVeM7QGt4A2j7gcuHp0RdxRj3ITCA2K32E
	 aYuKkjIR9Iv6vgdkNF5Fg+QtrNxlDtuEtbEw5HdBaSmHgvbdyCpINsmqIiqIbnLHVS
	 qLBeETi+e2DSUOABw8OU7hAnABYcxtJ8SobFig56O+y/BmHCov6oC7KlXZDUR7Du0i
	 zg7ld7bNK/usVq7lNTzWYs83JdS1DMfHZu3WuKEgVap8bLXdfko9Ys8LZJx68hP2Ur
	 W1WIiCfrvoFF6UW3ck4OdiOEZtiDjf4y5WLHXWZtvSythLHREa2uQMakoypvqCMSjw
	 1nKTyf9yEoOMg==
Date: Mon, 7 Apr 2025 13:36:26 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] w1: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <Z_QpOlDTvyfRs4Su@kspp>
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
Changes in v2:
 - Fix memcpy() instance - use new pointer `pkg_msg`, instead of `packet`. (Kees)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-WD2NP_1A0ratnI@kspp/

 drivers/w1/w1_netlink.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 691978cddab7..724a008cf342 100644
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
+	struct w1_netlink_msg *pkg_msg = (struct w1_netlink_msg *)packet->data;
 
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
+	memcpy(pkg_msg, msg, sizeof(*msg));
+	pkg_msg->len = 0;
 
-	cn_netlink_send(&packet.cn, 0, 0, GFP_KERNEL);
+	cn_netlink_send(packet, 0, 0, GFP_KERNEL);
 }
 
 static void w1_send_slave(struct w1_master *dev, u64 rn)
-- 
2.43.0

