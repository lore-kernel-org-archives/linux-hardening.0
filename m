Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB538D6B5;
	Thu,  2 Jul 2026 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974808; cv=none; b=kQR5CG1XbrIuXXpUPNWVNbx99ZQZBaW+jAgguo8pkyEIxY5mkC+zKKcFgW6caqaHL6+5K9OwsFNaL2bu8905Xg4O6JcKXQPOJ8flwLhJQmT10W7XeXq6eCKXWdCdLgZWsG/jNsS7noP3nux/Ko1w3IEY08+wBAtrHsPlbNFRqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974808; c=relaxed/simple;
	bh=qutA2gpG2Q88xXaWW2dAOvgNiAuZ9ytsljQYpQjnObw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QsIfsnad+78dyvtNRLXL/2M+6t3saqawIwA+A9xgtSw3dr8Jd5qEKAw2G6nY6IHBcXSDX5L0qXpPdYIya6id1U3wAIkjZIzcTxSpzh4A/fdfLG0UN3rxxDJw6BGjZaNsvMP6cC17c1MoccMGPDN+VUG2jMZHISvW6oV7EYAhAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=DgsIS8Zq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBEZK92N; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="DgsIS8Zq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBEZK92N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 27D691380C35;
	Thu,  2 Jul 2026 02:46:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 02:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782974805; x=1782978405; bh=e6puqzkhh4UHrua2JiowqyTCfZjHc1o3
	cqXqHN1mpbw=; b=DgsIS8Zqx4GCasSi9h15jcxL8q0OYHm4zo/E8Sdy6mweAfSP
	BXZJwL2ewGqRjMt6UcdKEIghQm3QpW8vACdxthzGFE1PIY8kpBCm78+rzyX9pddW
	+VKlnKnRjwfFKiGarPHkNh0xWO/1OZ3gz5iBrKKkBSw1MB7UrEwR5SM/JE37Q3mc
	bLlI+TfAT/66Tkdw/UJ/e9SzJ1j7wwdjKFi9A59jvCo7KnbWds5j+MqHNh1tQeAf
	blSHpWHOxgYRCLRN2pKfvoT7bxv77rVny0MmAHDl9heVbN4YmkOzAAd5h3eP3n7P
	o/V+y+1HRZSS5ofUFys6dUk6ShoRIcrUOlBL1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782974805; x=
	1782978405; bh=e6puqzkhh4UHrua2JiowqyTCfZjHc1o3cqXqHN1mpbw=; b=a
	BEZK92NHr4jAk/e4WX/NxkZOx21Td5ZYBO8YJNXJcglo6P8TK/NW9kgQs3U427Pg
	SmWnwXbyut7x3rENbpSR+ZRNVdNZPS0TPPoNuzOX+RbvfB6F0GnkrDlcCLqvc9m0
	LaSpuT3kokSkLPq8lFellu99NbH3Ga1Ox7gRKEAdWhx1nd7nUXnoh7FJpuWG+YxY
	OT/xpB87Ci4fFv4u7S/9T1uhhArjhVXPP3zpdvyZT5BYYdgcZhGNTcFuezj89hUc
	Tr46Y2XUduS8ZDtM4227hW/1ohkf8l78A53K3G6ASyb6c2fITLU7sqw3eB1LqGgg
	WtT8i0MadK6XyIjSrSVkQ==
X-ME-Sender: <xms:VAlGaiGDHClaLojNDudGJNDSHUqlFYBi7m7z6qveh0QBQhGrol7I9Q>
    <xme:VAlGauSZjy5cPRDET6zSYJs4V29w8JBEXQp0FPaqRKBVq4VwZCng8TxeOQC9Oh-5a
    qrHFTH4mlPTcKSpKOn9gbael99TVCSYZt4SgUmwGzRWA5aBGGqYZsw>
X-ME-Received: <xmr:VAlGarLUn3vDA9csTdHV8KcW13PXDgaCCMOGpOLLT3LG_k1L09NQ2yl0uNk>
X-ME-Proxy-Cause: dmFkZTEKTlz7kTFoH8vFwNSnQ41W7TxtjbMF9wZnhKWPemK4FzaQikZmI7lPy3PFWXYnma
    ZtACWyNMFiSUi8Pexf4oOBzN10whMKA+MtzO52GFsy1XpZZQvSoZs8Yfd3lAZdeZ6r1n/0
    h6RX3xgDbyjn73kS0ELjZgIPjG8vgxTY8H3v+zopcL63erl0dGEP3eKMOTxrrayjgYIaFg
    /SXsNot/L17tllyMpEfeZFdjNQiZrPZ3H053TUaD2f5mvRGWpc/HjMRtUa+OqhZJLP9yNT
    AM/LHTP83Ri+MsN7v3NtKAzbhHqPzqZXEBlgrqj4rJ47eAONIYkFKEQXwXyW+NKakDGHhG
    OhpMv73w8qx93fD/zO5SkPseBOOZ/n94Ufj0CnPP3FauRl25LLmMvbN/mKguSZAHwQhXCt
    r2clsFKOqyVZz/yWh9wFMD1VM6n/B4BM8KVEkUr+9kG3ga31AqGohkpIxA2Nonl6hde0/u
    MNZbXM9w5yUlv/SgObSppcoc+lNEEu7+TU+T7Z/zLmVO3ZMAlbUkthScH9xy0pD9B+30DP
    GxlcMWywQ0Wq8VtmJwu5M535vdJ5pbM+9drfCO/3nRdL/uODihA5hOQWUMyJvrIo2ScOeh
    CRKFsO5WVvTKJueHKB0yY/rDiEbU5MTjL+nRkcenLbUJaC1aXfbNU38YTSnA
X-ME-Proxy: <xmx:VAlGahaAC6vYdrDTGyg8nL04WQDWqmdKyzG82ofizn2O-QPBu8__lA>
    <xmx:VAlGal8phTxiQkwW2hX4oeBPOUoE0gC-yNN7sn7TR6fFclgZ85o5Vw>
    <xmx:VAlGaqZlIXzU1sjBZNLCgaYdAv3MTIqEskEukwQ2Aw27U7jG7y5DVg>
    <xmx:VAlGahNASMypAX1Y4ue0DUCtqC9SSAQRM81RVWTcVHPq4JwBo9VCKA>
    <xmx:VQlGajhp9pz2uRfCUess9eiou04IYaJ3aPvk7AQjFFd8fTd9O2wIfWAm>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 02:46:44 -0400 (EDT)
Date: Thu, 2 Jul 2026 01:46:41 -0500
From: Ian Bridges <icb@fastmail.org>
To: Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and seq_buf
Message-ID: <akYJUdY1hVABUQH6@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
the error message construction of the ThunderX OCX and L2C threaded
IRQ handlers.

The OCX link and L2C handlers append a single decoded-register string,
so the whole message can be produced with one snprintf(). The OCX com
handler accumulates a variable number of fragments in a per-lane loop,
so use a struct seq_buf, which tracks the current write position and
remaining space internally. seq_buf_str() keeps the message
NUL-terminated for edac_device_handle_ce().

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The seq_buf conversion introduces one behavioral difference on
overflow. strlcat() copied as much of a fragment as would fit, but
seq_buf_puts() is all-or-nothing. A message longer than
OCX_MESSAGE_SIZE therefore truncates at a fragment boundary instead of
mid-fragment. The message was truncated either way.

I don't have ThunderX hardware, so I tested the patch with:
 - arm64 cross-build at W=1 with no warnings. Applies cleanly on
   v7.2-rc1.
 - Module load/unload in an arm64 QEMU guest.
 - A userspace harness comparing old and new message construction;
   outputs matched across ~500k register patterns.

 drivers/edac/thunderx_edac.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 75c04dfc3962..5210ca18473d 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/seq_buf.h>
 
 #include <asm/page.h>
 
@@ -1108,6 +1109,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 	int lane;
 	char *msg;
 	char *other;
+	struct seq_buf sb;
 
 	msg = kmalloc(OCX_MESSAGE_SIZE, GFP_KERNEL);
 	other = kmalloc(OCX_OTHER_SIZE, GFP_KERNEL);
@@ -1121,13 +1123,14 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 				ARRAY_SIZE(ocx->com_err_ctx));
 		ctx = &ocx->com_err_ctx[tail];
 
-		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
-			ocx->edac_dev->ctl_name, ctx->reg_com_int);
+		seq_buf_init(&sb, msg, OCX_MESSAGE_SIZE);
+		seq_buf_printf(&sb, "%s: OCX_COM_INT: %016llx",
+			       ocx->edac_dev->ctl_name, ctx->reg_com_int);
 
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strlcat(msg, other, OCX_MESSAGE_SIZE);
+		seq_buf_puts(&sb, other);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
@@ -1136,16 +1139,17 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 					 lane, ctx->reg_lane_int[lane],
 					 lane, ctx->reg_lane_stat11[lane]);
 
-				strlcat(msg, other, OCX_MESSAGE_SIZE);
+				seq_buf_puts(&sb, other);
 
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strlcat(msg, other, OCX_MESSAGE_SIZE);
+				seq_buf_puts(&sb, other);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
-			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(ocx->edac_dev, 0, 0,
+					      seq_buf_str(&sb));
 
 		ocx->com_ring_tail++;
 	}
@@ -1203,15 +1207,13 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 
 		ctx = &ocx->link_err_ctx[tail];
 
-		snprintf(msg, OCX_MESSAGE_SIZE,
-			 "%s: OCX_COM_LINK_INT[%d]: %016llx",
-			 ocx->edac_dev->ctl_name,
-			 ctx->link, ctx->reg_com_link_int);
-
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
 
-		strlcat(msg, other, OCX_MESSAGE_SIZE);
+		snprintf(msg, OCX_MESSAGE_SIZE,
+			 "%s: OCX_COM_LINK_INT[%d]: %016llx%s",
+			 ocx->edac_dev->ctl_name,
+			 ctx->link, ctx->reg_com_link_int, other);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
 			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
@@ -1882,14 +1884,12 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 	while (CIRC_CNT(l2c->ring_head, l2c->ring_tail,
 			ARRAY_SIZE(l2c->err_ctx))) {
-		snprintf(msg, L2C_MESSAGE_SIZE,
-			 "%s: %s: %016llx, %s: %016llx",
-			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
-			 ctx->reg_ext_name, ctx->reg_ext);
-
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
 
-		strlcat(msg, other, L2C_MESSAGE_SIZE);
+		snprintf(msg, L2C_MESSAGE_SIZE,
+			 "%s: %s: %016llx, %s: %016llx%s",
+			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
+			 ctx->reg_ext_name, ctx->reg_ext, other);
 
 		if (ctx->reg_int & mask_ue)
 			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
-- 
2.47.3

