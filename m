Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030024CE68A
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228388; cv=none; b=uwiCx3pU/hT2niOXLAMK9S0g9ZxJVhP11cC9M2YCN9/r2VrDnLgS06g0QueDM0CO9/neq6J1sxQS42QYdvi4VF+sS/ssQQay8qZ8nhOo8KCyfJSKDfxyoWygrt9+8oFI1CuqqWygrHgYjcBaG+vD4oP62whcMDBETzEe/SQCMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228388; c=relaxed/simple;
	bh=qLo0sLQGLGk/Qb1aLrPVxsDkLEujWQRRC1IGWA5JPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gc3zy7qDb2U1duKjeKsnA0+GfZQdOIzqGtVnQf6kBni5/OkH1qci5LE9SuT/Ef9rMHESarPjYZt8UJypuJYSC/WyBcTfPCv40+BtuNB++7MqJkEfBTlC2qbyG2zMUb0peyMg7jTCXgVdeaxupepwsgRN9G3ErFmMZdSyLpoY2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfJfX7sD; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfJfX7sD"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a7906f463dso1679379a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791228385; x=1791833185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vw763NV5BjSaZVhghdUwJpS8A2L5IAuXgkLi18vef04=;
        b=LfJfX7sDLcrlC2YFzXRa8lQDTQ1idEntfujB+Ef0r9KDtDq2aUc7VPGHL7tyegu8c/
         RJDEeUqCdG2Nf3vvV9iexCWuxX/RSzsnYQ9NUVXP+tpAuZOrDfA6s+vmt1miL5Yblf0s
         M+SJSHuKhwxJr0EOvcM15SF+MF732Xi8syZsUiEde6HZ1ve6BijFMxjcv6C1Oa/BJnp2
         rqAN4OAWduogL9dW6WfgSCeO2hDiLSc2Xdb5K6Ca3b0L72zlsgsMRHi0U8UFwA4zfnSx
         OzQCDaf3Q3OdcqaCf5wgyvt+sXNsJzsIcXWS8qrK4VzQM2e+LKPKzty1iz4uCZyg+Je7
         bO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228385; x=1791833185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vw763NV5BjSaZVhghdUwJpS8A2L5IAuXgkLi18vef04=;
        b=zzrUXjQsDQlODFe9BeJIvk628aCT1xn+H2+MuRK70OXJX7nMfCjcCT3AZUgTWyZI8A
         +JUT3DOq3831KQUMbqe9H+ubUwyZJeCcQXdfv+a13Z7bMOWBk2+ahqa/meAPjRKpmK2E
         tl661ayMvllGDi4PDlQt9Q/iy7gwxLUlOlUqP/NFga99gLwR0kOgV1bd9vnDsBq1onZ0
         r8zYXJgYj91AVsS0nA+osXIKc7SQIo/MOu3I5wb+CUGGJVHdMRcePABtoxpjzV7xcH85
         dVoE/k1mqBeyNcu/zRQryXYZBcdjAjLoI0nMt1gF+tYDgUKURcpF+t+9ZU49btFZrQlQ
         PFOg==
X-Forwarded-Encrypted: i=1; AKwUvBy5loik/yoVP7MT9Dz3E8rcvckP/QCmetlAtWb+UJdVxe5N4hm1B6hCu/n9bhs7SsGZ7To6FxGIInohN0Pan8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNWeBnPqku/No42e/iBrS1jG6g7xLM2llwO438Wwr8I71lJwjr
	FcmzcuDIN9KRNFz9pUG9wXKs8J0Qgs4P/y2gZueJuDFRNvB+tszUtfN2FNYCqb+f4R0=
X-Gm-Gg: AYBFou14XbkDxTSaAc38PCrkh033lhOnJ0Vws16uJ/gL7J+43JirCHEhcFamOii39Ul
	KG2tzII/yPTWs2EruM2PracnArN0pAkRHTjgikLW80WpbtUpWCP8GF9CoDNDiHHcxFeNmum/Bwd
	wUJ0o9IsmyDVys/9zjcqYakGH8hjVqVNsPfoVRsKSg6S0BHqhp6BcYAU2nuLJVoiyEF6gLv3cr9
	tg87pQ76p7x9lvQ1bmKiKP4YAqlSyc3upLQStbVk9J7NCAzVh0W05n0fcRWdJne9E6mXIuKgG1m
	BBDk072mSPNSGh7rGgz3NsXPviaHVzroUu7lTc0mHa0C3JziXAcE9y3Jm0OwYq9AzMEsJG0QUSM
	/yo4LhM76Q8QheZ5nULSvlF8kcuMvH2WusB06PaDUEalnJLXWU5MYwglJ2mZzOJPnEiA8jR3FLh
	gsEJ+n8UltM6OCnvjPp43tb/TSJN4vqL3MEyLLawBorG+wxaSkLC9UhYKqaOgObEhVFUcfs1Jvu
	YlL+2cTskydnuyt3DUUlhe1FQm2e1BbpZZcny5OM7Tu0IWX8WsY3MIOO+cHP1cX0WYf6YmM/2RH
	UiRYw5TOdVcP0mmdDBbClSf/7VHCNKfVWzVM5CtQQ5zX/BHh6RPafIQ9f80=
X-Received: by 2002:a17:90b:498e:b0:3a7:9ad9:68e1 with SMTP id 98e67ed59e1d1-3a79ad96bd7mr6814909a91.13.1791228385236;
        Mon, 05 Oct 2026 12:26:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853b92679sm850955a91.6.2026.10.05.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:26:24 -0700 (PDT)
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
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v2] dmaengine: xilinx: xdma: use kzalloc_flex()
Date: Mon,  5 Oct 2026 12:26:21 -0700
Message-ID: <20261005192621.99880-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change desc_blocks to a flexible array member so the descriptor and
its block array are allocated together, removing one allocation and
its error handling.

Add __counted_by for extra runtime analysis, and set dblk_num right
after allocation which is already done by kzalloc_flex() for GCC >= 15.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/xilinx/xdma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 8d4a5d14e8db..16d202722245 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -81,7 +81,6 @@ struct xdma_chan {
  * @vdesc: Virtual DMA descriptor
  * @chan: DMA channel pointer
  * @dir: Transferring direction of the request
- * @desc_blocks: Hardware descriptor blocks
  * @dblk_num: Number of hardware descriptor blocks
  * @desc_num: Number of hardware descriptors
  * @completed_desc_num: Completed hardware descriptors
@@ -91,12 +90,12 @@ struct xdma_chan {
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
@@ -106,6 +105,7 @@ struct xdma_desc {
 	u32				period_size;
 	u32				frames_left;
 	bool				error;
+	struct xdma_desc_block		desc_blocks[] __counted_by(dblk_num);
 };
 
 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -255,7 +255,6 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
 			      sw_desc->desc_blocks[i].virt_addr,
 			      sw_desc->desc_blocks[i].dma_addr);
 	}
-	kfree(sw_desc->desc_blocks);
 	kfree(sw_desc);
 }
 
@@ -276,26 +275,22 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
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
-- 
2.56.0

