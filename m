Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB43E5EF2
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456106; cv=none; b=YEAJ+9uBM5+nPsZ6uovtJo1vrAb33MfckQGB4eW3BX/dpatF0+aGS2NvZNjNiZJ2JITESQlcsnyxKtOz/3D4Y1HdEsZKyFljQhx02o8NZiOWlL+RWJN11OdKoLsqWOv6aJz7JUw+HMm95+dejWM43tkhsk/0t9pfRcV9tgqSA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456106; c=relaxed/simple;
	bh=UU+KzLESSp0kk4B2q1HC+6X1v604zjgC2rTFZxQX9f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioPrYlqijfPPE7nmhjXeI0YEWRk6nIia9l8d8APNTY5BDwSV/wfPRccmMIaIEd3ivJyv+wUNLq6xRJQUkeT9fNF3WTnxPYO1aJqFmUWk1Arln2+v9jXmcxfH/u+H5p7ak+TuB7vGexpkiEDW/38Vf3U+oyZmkKS23QtwpULFitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGl8ceDC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGl8ceDC"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so2334231a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456104; x=1781060904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJVVrtusx/XpEEVdlLkuxUdKg7eDHMaqI+aWjwG9HdM=;
        b=OGl8ceDCBtlLCERK3ugdlfbuHCwGRae3xVXkKdyuFXLkvcn0Vd0SNbtZwmWAE5ylFY
         lqGExur9LRChbI8mXwnSFP2iLTYDNEUYYU5FrkeboLA6MsF/ztBilcgvGKdexwfY/TIN
         YWDQ4Pt7X8pLbkB6qQTv4hfosQleVTDgBjov0XU8OV+UULuENg9NDDQkPzKbaIyalUHL
         CsSQCYzqkrlt2E6p8tXD6tXB5Ks3bvH5c2uKlhWGNEiwafInq2SgSNrIJpYynUAFbzdU
         5oL1MSfDqIaStX11z/r3gNrYlzka8LsMOuif0XvgMXoHcgTrteYsBNnhpZ3mwpqmKTjq
         o5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456104; x=1781060904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJVVrtusx/XpEEVdlLkuxUdKg7eDHMaqI+aWjwG9HdM=;
        b=oGc9AVj9FrY2Of30jEu0pOcrP20tNZyQ2+AahLymrptQaBnXbm4/f6Nt3Hq8Le79t1
         F3T3dS4QKXQjGv8QKTe2BqNAHlW9jA7rZQ7e1y3yb5nvFV4GwqCAhiMeFFl2CMoGaese
         Zx3DVQ7Ob6Q3pXGgPkKNGo05m8x4OlpsWsq+9OUECwCnDtaTdU9H3KKnX64f27HNJdED
         +mJCk8Ygh+z45wkZaGIOWwm3PXnwD2lfJ+l37upe6tXWPm0mdGMMMmLJZjNi9mhPkqc4
         HVvEMmzrCtK3Mn9slTt/k7pFbA0LH1SXVCb8/p0GMiqB8DkHKwaj7AEfalmYOs1BV1aN
         gQhw==
X-Forwarded-Encrypted: i=1; AFNElJ/61dUfYFpHa2bQzDZOSKwVAJuvtsp7hHCaAfTerQQclE+pyDQFwLEA9cKLUwQgSFeLcZw45rXkWtIC7JUQSvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQI7EKAXbI16G6kQoF3a8Yr82zQKZJW76KRLEKD34qsfJCTIR
	2Iyi7htzTvcEuhL+cYLFAClZoP4sV4H3bpq+5M04lePoN307bdsJzRgH
X-Gm-Gg: Acq92OG/kzwT2Rq9guhtV2CKPbyVEkKrtAXqdSxViG9PuDCBxrmb8ZE0Ba1LQTZXIkr
	sFtpKgAOg6H+tzo1Ro6fjZ2mq61uQ5Pnmp6HtOtSZhnds94RmH3reJbGVmL3uMTxA2bQ43CVHEC
	zhCUOfQZ37FJdgJybAVWxzlE1pHSN6LpZLKXFk9IVKHDlfeY83H2I6z7KN4ppSvSh4zTQzcuCV2
	38z7NHlI1i6DTOwYUlsQmnIJjoQDmIxgfvfn9UYCLVtu2IFyuQSdq8A+Q4lg/UJ3jrL+6kR92BN
	ScIDksdG+9p9ErC+0vEfFxNyvG7f+qR0C2A3d0h9x9ozUMDQiNHA6TDf08FmB7uBYrzDSmJ0VPl
	Rscv5BX/KUHdYJFEcWRpfVY0JBLDj7XkcwaEcqj7zUkAuW6EqSifqPDIvHQ+zN3tc+LTZxxH9FL
	VVto2mVdAFy0d+DZjCS00dGCRCYVk/nX4C7P8wcXf3UjRwyiloGsHW/NotHlIsdhrWGgqf1CYg8
	NdT8WYmspnIOZrz+VOORd2T0pbIW4LT7Yz1LhqfbxlwWg==
X-Received: by 2002:a17:90a:c887:b0:36b:293:68d1 with SMTP id 98e67ed59e1d1-36e30a29736mr1332510a91.16.1780456103709;
        Tue, 02 Jun 2026 20:08:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:22 -0700 (PDT)
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
Subject: [PATCHv3 6/8] dmaengine: ti: omap-dma: destroy descriptor pool last
Date: Tue,  2 Jun 2026 20:07:52 -0700
Message-ID: <20260603030754.288757-7-rosenp@gmail.com>
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

Linked-list descriptors are allocated from desc_pool and can be
released from omap_dma_free() through the channel descriptor cleanup
path. Destroying desc_pool before freeing channels leaves descriptor
cleanup with a dangling pool pointer.

Free the channels before destroying desc_pool in probe failure paths
and in remove.

Fixes: 1c2e8e6b6429 ("dmaengine: omap-dma: Support for LinkedList transfer of slave_sg")
Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 61a935660341..c0890d8c43ba 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1818,9 +1818,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 			spin_unlock_irq(&od->irq_lock);
 			omap_dma_glbl_read(od, IRQENABLE_L1);
 		}
+		omap_dma_free(od);
 		if (od->ll123_supported)
 			dma_pool_destroy(od->desc_pool);
-		omap_dma_free(od);
 		return rc;
 	}
 
@@ -1842,9 +1842,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 				spin_unlock_irq(&od->irq_lock);
 				omap_dma_glbl_read(od, IRQENABLE_L1);
 			}
+			omap_dma_free(od);
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
-			omap_dma_free(od);
 			return rc;
 		}
 	}
@@ -1888,10 +1888,10 @@ static void omap_dma_remove(struct platform_device *pdev)
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
 	}
 
+	omap_dma_free(od);
+
 	if (od->ll123_supported)
 		dma_pool_destroy(od->desc_pool);
-
-	omap_dma_free(od);
 }
 
 static const struct omap_dma_config omap2420_data = {
-- 
2.54.0

