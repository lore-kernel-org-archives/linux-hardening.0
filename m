Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F03E1738
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456104; cv=none; b=gI8R9I6GhSSSnFcXmYsaljr0sWlSQS7zjLYyNzNAVlEbsH0NM7vBGDuMB3Yl+6DuoAW6x8LS2JEpwlLLiszIZ+maWvzf/YBatdff7FRRpb68blCdk2DRkZ/wGsGv4DmTnarZ27RElBeAQC1D1yKiM1/sBFztFGea0v0QpILL2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456104; c=relaxed/simple;
	bh=O9qpMQO4gyEQEH9XMabcCwD7cgwVapAp8DL4oHFYuDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CstaV/MOzrVHfk1Ot5Wxdd4DUOYLXanHpRND73nErJKOho1i5Jv7kRVhjVfKqcOA9/dqFG0LeKbW2cxA6zYzySdukyduKQfvU2OPGyuxKla1DSAjOBUmCmnoBDrfjjy6jmJS78x1iPV4Ig2Wl0WnaJ222aXxEEbRQSQXX778bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYxgE5xU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYxgE5xU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso6056542a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456102; x=1781060902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZKzG1cjjYqCrg5ftXH0wOdwx3jBheILV4yoP9XwymI=;
        b=QYxgE5xUl5mcE9jXDuNnMYL4wZ3rXTFkuo4GRdwcOQvqT9HTIZMMXQ06k4D/6MZRPX
         Xz/+2hax99ZxH9LW4HeVc7Wb7kB699RcaYyfuHFch/dchz9iPG2c1TXOaZi5hx1WNCYg
         PuMvtdWRvDYtgVkMWAxkPengl73UHBqm9gt7rzMjJ6XTfeHPjRpth2JHDd9S8WmnzoqX
         CQ26Q6PDKRdNIT2KGJhFzm9yJD/YGrQkanKvAQGcDbbFAx1d/FmXlKfkPq8VcrfyKjRa
         NO4snquXlmL6zYdRvXWzTuy/a2GAMrS00xJ7v5LGCvpn73tEl4Slffc9+uK20KLnVL+i
         sZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456102; x=1781060902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZKzG1cjjYqCrg5ftXH0wOdwx3jBheILV4yoP9XwymI=;
        b=rJPSmKJEMSGxWIcZMMpYTtJs6Iy/QpaF+PmsVuQFPaFVV0CTyOtrOE/u1oR5tmATmq
         z64VHAaRta26oCKX9/dsznkh/p6TI27tOPaEf5Pr1fXAHrL5dcn8nOGvmwjK+XIGQSGH
         dNO7Adfcf0XeFnU4RHgg6S6hSDf7JnZMic0CiMMGx+fmnlMQaj5QNa/SOWIMnd1rfg2+
         hGFh86tNs+uoH7E8SJ6/2PTTIOD8594KrJ1U6gX9jZwBxVMvKiBSB1W/MD+AiBmqCBJp
         zgG5cHLPQEzHdwfwM2C0pGfhx3gjt2wyzc1EFNGxd5/GTofFhkKRvacIYpuq/TuSWhkQ
         ln5g==
X-Forwarded-Encrypted: i=1; AFNElJ/Zvpt+KRaBgbv/xDX3qEXZfgGZfc8ZnGhaKv+0ADboABtIhH+T/KpEyUcR7OgtYzioMAYBmHBe5bdjlqgfJfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb14aDI/ABUPnNVV0U+lWrnpH6ZUTy+uWtGj89+359hpvddc19
	h1LwA9Hv55kQGmCa53ELnRmEPBYoydEx6pMWSI8vHWQLXomMUJ3EDSOs
X-Gm-Gg: Acq92OGn1KuFo6guw3Cl4fewJ3RtfheNQOQbJ6m80hCxic652xY8YmkdNtgmmFEFz7S
	PLNC5Y+7gU3Tfy8ZiYkGuv27fMZGqKECky589Bdnb4L3kAKRQR7kxlR26cPPZaIqebminz4c2p/
	L995Nj5XIXgMsfDeWXFcwQHk1tROTQ3DiH4aGQBLCfhJeNSRsBkj44Bl5qjzg+DnI/d5L3fsDaC
	WusKxstZJ5ixyLAgpr/6iIMih39wzzxuiN98D36U4lMHqAz04GlQuK8IAl5OTxr6/6jkDiIABo7
	ZmO0/fSU12t+1cCDxwYTzsDcrM+yvWayX2lEXhRMXRcEf+yur7fR4ZQcO8PFMYu7/6Aqd+hPmF2
	dcBWofWV6snWBoANtU4zlntgsrY8fQ52pJX/Lj8zQatORs0GBz20x4NFVuPjwmBf5b1AUiqIhyN
	tyFLgJ5aIvp28btI97b8v8e/JWsphAxJGmfCG3mR2s4msUwUw6biU4CWsPqnXb6LgYnjl59sLwo
	wJQtI9LzaZ7Ss8hTFHH87OXRMLm7pwRZt1NwhpVvHEHpQ==
X-Received: by 2002:a17:90b:38ce:b0:36c:e254:4d5 with SMTP id 98e67ed59e1d1-36e306482e3mr1303320a91.4.1780456101691;
        Tue, 02 Jun 2026 20:08:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:20 -0700 (PDT)
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
Subject: [PATCHv3 5/8] dmaengine: ti: omap-dma: disable IRQs on probe failure
Date: Tue,  2 Jun 2026 20:07:51 -0700
Message-ID: <20260603030754.288757-6-rosenp@gmail.com>
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

The probe failure paths after IRQ setup free channel state while
hardware interrupts can still be enabled. A concurrent interrupt can
then walk lch_map[] and access channel memory that teardown is
releasing.

Disable IRQENABLE_L1 and clear irq_enable_mask under irq_lock before
teardown, then read IRQENABLE_L1 back to flush the posted write. Guard
the L1 accesses for legacy platforms where that register is not
mapped.

Fixes: 7bedaa553760 ("dmaengine: add OMAP DMA engine driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index cef4e3a38b04..61a935660341 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1811,6 +1811,13 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
+		if (!omap_dma_legacy(od)) {
+			spin_lock_irq(&od->irq_lock);
+			od->irq_enable_mask = 0;
+			omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+			spin_unlock_irq(&od->irq_lock);
+			omap_dma_glbl_read(od, IRQENABLE_L1);
+		}
 		if (od->ll123_supported)
 			dma_pool_destroy(od->desc_pool);
 		omap_dma_free(od);
@@ -1828,6 +1835,13 @@ static int omap_dma_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
 			dma_async_device_unregister(&od->ddev);
+			if (!omap_dma_legacy(od)) {
+				spin_lock_irq(&od->irq_lock);
+				od->irq_enable_mask = 0;
+				omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+				spin_unlock_irq(&od->irq_lock);
+				omap_dma_glbl_read(od, IRQENABLE_L1);
+			}
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
-- 
2.54.0

