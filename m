Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0353E6DE7
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456108; cv=none; b=cCctCWJcYlBhTkJLD6rfwqGzyqfv2jyee654sgauSCnnedLaWfe+ZhezwZIc1wX4eloy/YYZGdq5OWw+tLlHetkwt/aHVzggrAoa95RwIviKazkAniTMUYgqaWNsFFs/VWUkc6zYCEikG9sS8yy5f9Ab4XcAgqJCgggYC18pRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456108; c=relaxed/simple;
	bh=GJjxv6I4KbyYJcLAYZXL2OfmKR11Tsw/rO82A+IHuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVrilHQ1ozyGt3ubKjKzsnjL5y3QwOBKMV2mTmU0qEGt/7F+JWlJHCuDIc/JNceIJNQ+JS5YP/B+f7E9AuJIEI1xtqt/3MU9S/fzX7Z4AkK0rcr5PMaTalZEOhNq4z3nlSUhF14WUzgHgmq4VztCKtyxiwDiznC/mnqFkZGKLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw0pT8eu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw0pT8eu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so178931a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456106; x=1781060906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/7UILlPUwdg4xP+wSM0nxIBSMKN8rKynfm10QKhZoA=;
        b=jw0pT8euhBc20d7qfmke4VEEebkcmILnxUNU9n52c65UWZD8ob2Se8y6DP9LLkXWIs
         F/3+yJqDI41I0CfHXVQJQ0rIWU2itiZOZe7OlDE+hFO7Y5+ai15w6GzTTKMCeZY4xG25
         ZMK74Mn4nomYfUU+3I7AEuLdUHKnzrfDWmDeFl/PpdwRkMo/5jmxGC6HZbufQ+1KWQZF
         JkO9kZS93mQVX/etLE1mgdrMTRzqgDARG30amxZQxJqUPcNMgXC6Jgt5tVi+B3NWP5qU
         O2IXzxcULxO0brAVkBSkNw+gwQ2jp4BlpfENIo1PpiRFQ79BSBR+llV5SDX6311E7TeE
         LI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456106; x=1781060906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/7UILlPUwdg4xP+wSM0nxIBSMKN8rKynfm10QKhZoA=;
        b=OtBLjDllY/ah1kaHg39MhE4ZQGUVvh/V2PIzCrHnO4qTPYP53IHlNX83Ky/tTYGIpo
         znRer4Z1A/qHs5LwxT7nIbXuWx7Uy/h15ZaOxSpJpvU5JWseeT7oiaLULBkpI25KHrh8
         BEStxoptczzqu9/+VCygvZ/enpPzY5PlGo4d3MvvWRmjxYsl7s6ZC/IS1kU7Z6Ezj3h9
         IApHpb3P5rMxrpVCf2+Ai661s5RwQbsifFzesZKcNYm44SIrZoTDISh5jZraMWU/2F2A
         pt00Zzxzru09dkj5DvGnpX9n0CQC43tf/YWpKY5xJcs7GRxp6j3+Ahkhq8BQCCr2X7VU
         mMFw==
X-Forwarded-Encrypted: i=1; AFNElJ9A83qV9j6FTX1CkyYK/FJIMdSI2YAbJVth3oHYhRfBrgHnikBk5r3JQQtG6g/3/Y/Lg6SS6ZXPyrt4H97c0VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeg1zSbpF6G8mM0tJyAJ0mUxz4bC5EnXez2y9O5XBR9IV5FMGi
	sjj5zCyOTq17/BUi4lYhk9DYAi/6dG/juwLiaPqR60LJMVHPC2caBILI
X-Gm-Gg: Acq92OFV+WBPqpcI5JnTrZpoo+w5LiEXoInXLCN0CUJXe/4KyHuoPLCvdoZ30OjxNJm
	jqy6eSZKzkXybjDHUI5o69OMZYSnmsgvGqFK5Uumu0QysFHAucLeHB0/3As8ti5T198KKChMmtS
	pt1L0MXTWKdhJD2gnnRklINryBkNKy52mAc0ts2J6AKaLPof86fkXsdm+GHMxS+qokugHxHRBjO
	OTP0OhtevqB4H7LD9U2bF9dpQ6YORA64DdPNjZLZWw1GIVZ//7IPTaInAu9Vca5DALNkBJvNyg4
	FTNtT/y0Pqwif5OH7ht93mxD3O/Ae1tOUEqbINiIPJDGY11n+XfhhnQBM4ASuB1TGBkMYN82IfX
	Lc4eiljTBqftKf9ho8te376qDd6kCFdQRAYx1/E71XjXYpLJ4ys4Ehn7QFIpOBNtwcumngWqK+J
	p2IjoDNHlFdPE2vCUMNIZwGxzkSLI6ktX82sNjB5+ddInAWTrM7cGWl5ey5ccLnVQ6L8LIpiJzQ
	MPYsvSAkCrDh4RN0GEncHxrTboRz9/b4M6J1bh1CgWf2rp/T3AorxTh
X-Received: by 2002:a17:90b:4c4a:b0:36b:8e97:fb06 with SMTP id 98e67ed59e1d1-36e3a0f4ebdmr1048567a91.8.1780456106063;
        Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 7/8] dmaengine: ti: omap-dma: fix interrupt handling in remove
Date: Tue,  2 Jun 2026 20:07:53 -0700
Message-ID: <20260603030754.288757-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remove path had several pre-existing bugs:

1. Interrupts are enabled via IRQENABLE_L1 in probe and
   alloc_chan_resources, but the remove path writes to IRQENABLE_L0,
   which has no effect on the L1 interrupt line. The DMA engine can
   continue asserting its IRQ during removal. Write to IRQENABLE_L1
   instead.

2. devm_free_irq() was called before disabling hardware interrupts.
   With IRQF_SHARED, the hardware may still assert the IRQ line after
   the handler is freed, causing unhandled interrupts that can lead to
   the kernel permanently disabling the shared IRQ line. Disable
   interrupts first.

3. platform_get_irq() return value was not checked before
   devm_free_irq(). If it returns an error code (<= 0), passing it to
   devm_free_irq() is incorrect. Add a guard.

4. Clearing od->irq_enable_mask and writing to IRQENABLE_L1 raced with
   the interrupt handler, which reads irq_enable_mask under the
   spinlock. Hold irq_lock around the disable.

5. The posted write to IRQENABLE_L1 used _relaxed accessors with no
   readback to drain the write buffer. Add a readback flush before
   devm_free_irq() to ensure the hardware has actually disabled the
   interrupt line.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index c0890d8c43ba..7343325ce2b1 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1517,9 +1517,11 @@ static int omap_dma_chan_init(struct omap_dmadev *od)
 
 static void omap_dma_free(struct omap_dmadev *od)
 {
+	struct omap_chan *c;
+
 	while (!list_empty(&od->ddev.channels)) {
-		struct omap_chan *c = list_first_entry(&od->ddev.channels,
-			struct omap_chan, vc.chan.device_node);
+		c = list_first_entry(&od->ddev.channels,
+				     struct omap_chan, vc.chan.device_node);
 
 		omap_dma_terminate_all(&c->vc.chan);
 		list_del(&c->vc.chan.device_node);
@@ -1878,16 +1880,20 @@ static void omap_dma_remove(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	irq = platform_get_irq(pdev, 1);
-	devm_free_irq(&pdev->dev, irq, od);
-
 	dma_async_device_unregister(&od->ddev);
 
 	if (!omap_dma_legacy(od)) {
-		/* Disable all interrupts */
-		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
+		spin_lock_irq(&od->irq_lock);
+		od->irq_enable_mask = 0;
+		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+		spin_unlock_irq(&od->irq_lock);
+		omap_dma_glbl_read(od, IRQENABLE_L1);
 	}
 
+	irq = platform_get_irq(pdev, 1);
+	if (irq > 0)
+		devm_free_irq(&pdev->dev, irq, od);
+
 	omap_dma_free(od);
 
 	if (od->ll123_supported)
-- 
2.54.0

