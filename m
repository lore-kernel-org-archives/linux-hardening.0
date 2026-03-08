Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E217993
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007668; cv=none; b=UH1eCbjKXBaEE8Wz19Sa3MnPicobS6j5rPTfeOblc0hGVwwx5cFDopqJXrpfJHeiC/jZnDlAInM+bv+wIpej4r+mFc/DuubYGhD+V1siypjORN24Hy4D7nRsk05vkzyb6RCy0gzbwRlAqaWwYaKNCUJQzgnOjj3+Y85ldtvef8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007668; c=relaxed/simple;
	bh=eil+iPpwgIw3LaL+spkCjgN0S+e4SPX8IkdqBz91dFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7DL8WyQtFDbTw8lJgx4ibonj2XyNjMufOQeobOda4LCwoMS3ONPhSQ8yMtGBkhRGUoX2yccX8456svZ/uRG58L4GNHvHuJBeRyvAtRqkzRhvBh4lmnuLW9Ua+gq4rmh8aJ6lh8RE8/5e39S/zJtwkhUhwKQL2iTvQghWTuqrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Ftu1/e; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Ftu1/e"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79800183233so148530637b3.1
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773007666; x=1773612466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftcpbjh6p3nPyd9FYgD5ANvcMgJCdJh9w2K7lp47ksM=;
        b=j0Ftu1/eSn4j0SDzo9lWLIcAmQXzSozDPFnMN1ZjVOfTGWJ+TTMTSQWnSUKNKChUWL
         tnn0NlJ8WfaYOgShzE+l20cYYAK3FUhbtjWME2Os9R9/1B+rZCZWJY9MxHNClD4Q1vpg
         ejrLKRphLlWRWdEbtUD+Va7AvsVYuPzKu2N9YXQm5k3RF6dp6/AP+OvBTlRbLvAzBHlR
         Jx+L36Z1AL6QZtd//Zszs8CGI4YI8JLGk/N03SLhnk7j16HgmHHTNknBnNPz7XDtu55a
         rsyjp0Hlno2SSQSoX1RMPkSbrlKaxshdjsGki76756/8uyJD59yHi+FQoAJjgW39kCyE
         dU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773007666; x=1773612466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftcpbjh6p3nPyd9FYgD5ANvcMgJCdJh9w2K7lp47ksM=;
        b=SwRxrzWw9TtBMAxBBTmR9hzLaD64Nccxmh3f5s27ls1EgE/U8ZhDIcd3/O+ZnydXBT
         fGB/gS6mey0PqGWwcGnXtfSTYd5N0KpdPBfJlVpDzUkE0rqitoNQB2M/my/Xt9Zln9nv
         MAxFMdXJ5fkPRSBkFTMfGJ9DrtgiXbcA/XzBBErpowZBdm0BEb0x40ptB2v52n+epM3b
         OeYWyUbbeeNpi+WU2IRUs0LP5aQjngezbSlejFoTRTOX01h/I9mHtsah8FhtdFMfiUhK
         3B/LwCPWtsDk8J/EKQdY/rDmkp9cgTUSBxEXWr7CTOqi2S3bXWNpRdrDf9njONfoYGAj
         +fLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbWqG+jQuCL/r17VvjggLrhO9lTE5Hq6+gVr3CKhDTKh3NeGAdihFoe4SnWbsglF22bu7MnaImxOZhOgwfBYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7G7ndFio9gr0sfpO99OK1xKNrD9nnJv5vQb0UCjYk4xPZYgsC
	SW7JdH0VExsbFy15ZAE/wzezMPmh9/kjL3K2DEWSGbCsi0KM+g29s9cV
X-Gm-Gg: ATEYQzyMkmc+U0xwOQbN5J0CrcWC3+or22tBkqpJjzE4nZFdgXOzRhruI7HdYOUxH4V
	SeJcoBV3SCLQERWkTpB+11nhg+eoFqb+TvUg998PM5ooaHb8G8VO23FrWaj5CAPlnMo57Y+hVXH
	V4lEL8O8w1xGY/inKeb/YifyX3x0TAXks3SO4axKlKsumGaMcGvc4SWPPJGqQIGpcWwS0Vmu2cf
	pCnqjjTsg1iLx8/n7RfZMzy3Mm7Jm0cPzPE3OWkCoT0DjS/l33d41ElC+qh3+BdJhM/Sh3dbNPf
	231XqkHV8/W9G+w60Q7h/cvMFyQav/FwXrvASw+VkMXpO+JPPipFsFG48DQoqw2lCgyhRgeP3fq
	a3qxOawslMd8OkI4q/aYq3Gp6CAZ/mxzQWobqDXsDD8FYewukqxn4bq4IrQZNBDii/3GoFRgyre
	+UmafAkcozM0OXML4MO/9pJ/JBecEirQJgIfxRYxYJNCBGnsY/T0re3w==
X-Received: by 2002:a05:690c:ed3:b0:796:3f8a:9607 with SMTP id 00721157ae682-798d1f07dbfmr126573077b3.30.1773007665815;
        Sun, 08 Mar 2026 15:07:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee8ac51sm36771577b3.49.2026.03.08.15.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:07:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] maengine: xilinx: use kzalloc_flex
Date: Sun,  8 Mar 2026 15:07:26 -0700
Message-ID: <20260308220726.45270-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing descs to a flexible array member allows one fewer allocation.

Aadded __counted_by for extra runtime analysis.

Changed error path to a simple kfree. descs in all paths are not
allocated. No reason to call xdma_free_desc. A single kfree is enough.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/xilinx/xdma.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index d02a4dac2291..14fbc7200a6d 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -80,7 +80,6 @@ struct xdma_chan {
  * @vdesc: Virtual DMA descriptor
  * @chan: DMA channel pointer
  * @dir: Transferring direction of the request
- * @desc_blocks: Hardware descriptor blocks
  * @dblk_num: Number of hardware descriptor blocks
  * @desc_num: Number of hardware descriptors
  * @completed_desc_num: Completed hardware descriptors
@@ -90,12 +89,12 @@ struct xdma_chan {
  * @period_size: Size of a period in bytes in cyclic transfers
  * @frames_left: Number of frames left in interleaved DMA transfer
  * @error: tx error flag
+ * @desc_blocks: Hardware descriptor blocks
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
 	struct xdma_chan		*chan;
 	enum dma_transfer_direction	dir;
-	struct xdma_desc_block		*desc_blocks;
 	u32				dblk_num;
 	u32				desc_num;
 	u32				completed_desc_num;
@@ -105,6 +104,7 @@ struct xdma_desc {
 	u32				period_size;
 	u32				frames_left;
 	bool				error;
+	struct xdma_desc_block		desc_blocks[] __counted_by(dblk_num);
 };
 
 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -254,7 +254,6 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
 			      sw_desc->desc_blocks[i].virt_addr,
 			      sw_desc->desc_blocks[i].dma_addr);
 	}
-	kfree(sw_desc->desc_blocks);
 	kfree(sw_desc);
 }
 
@@ -275,26 +274,22 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
 	void *addr;
 	int i, j;
 
-	sw_desc = kzalloc_obj(*sw_desc, GFP_NOWAIT);
+	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
+	sw_desc = kzalloc_flex(*sw_desc, desc_blocks, dblk_num, GFP_NOWAIT);
 	if (!sw_desc)
 		return NULL;
 
+	sw_desc->dblk_num = dblk_num;
 	sw_desc->chan = chan;
 	sw_desc->desc_num = desc_num;
 	sw_desc->cyclic = cyclic;
 	sw_desc->error = false;
-	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
-	sw_desc->desc_blocks = kzalloc_objs(*sw_desc->desc_blocks, dblk_num,
-					    GFP_NOWAIT);
-	if (!sw_desc->desc_blocks)
-		goto failed;
 
 	if (cyclic)
 		control = XDMA_DESC_CONTROL_CYCLIC;
 	else
 		control = XDMA_DESC_CONTROL(1, 0);
 
-	sw_desc->dblk_num = dblk_num;
 	for (i = 0; i < sw_desc->dblk_num; i++) {
 		addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
 		if (!addr)
@@ -314,7 +309,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
 	return sw_desc;
 
 failed:
-	xdma_free_desc(&sw_desc->vdesc);
+	kfree(desc);
 	return NULL;
 }
 
-- 
2.53.0

