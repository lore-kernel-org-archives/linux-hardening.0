Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B437473A
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533914; cv=none; b=VUKjvrZJhGN9RP5R7WvH5reYEAywSs08G/bBvB37u1qouhKOIJVckktPCYEHrF1cCxmr/DBBRSS14TOljcpuHQb8Yyl7PzcBPmJTMnfSfSno6esBoG0YQs3DXCCthBtXfBRQisCCV8nTFGJ4Lp1vn4EJWUnBn5RokRTYtdZUbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533914; c=relaxed/simple;
	bh=ZGc+Lx7Q3ImjQIU2MsaptvUr2OjdQPH11+1aygZf1BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTkEMuHEJ2bhaiiSqvkNVZuUG82EzbPSensFKJ8j9+02yAIyCNrahvIt8OHXxcJzqmYI1j1eujswXJVD2ApUMjLTaEFzQ1YRNGJvk5cM4MY+wHrrGe8vzZ05V1Nz32zWJmami7ulXfR1AiLClRRN7mrJchQ/++xuNQHDdFsWxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsFa1Rns; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsFa1Rns"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b392f1846so66482151cf.3
        for <linux-hardening@vger.kernel.org>; Mon, 06 Apr 2026 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533912; x=1776138712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/TQHykLdF85VtC6CTJ2wonciXUmXtr/iGFz2p1d+iM=;
        b=qsFa1RnsmqIpoiWveTXijEroCfY6YDbyuRPmq/j8gurUFF5XxOJxSbR1N7RGlYfIaO
         DpGxIT4WTWgDfVRGHTJPimjw3DMyu8s7rXdK3jfGA2bvl2mMv0NlnsR1fYiO/A8rrKbm
         ghYcVrv2sYteen6K4Cin73OGtBcuL3JI90fjf3Oyvs0UbWkgYky8a0lyzwVJ4cgZ/7PU
         WiS2vOaxD2k06Bsbh/eMdx3EJoKEHRMMG80lq0jFodWnuysiAZkew3lXj/ryMDgjDwwH
         153d67gnK29wOno2xZueGHfUKdQ7KKL6H6BlqASEtybnG4B7dys38XZr88tGWa3eieN5
         K2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533912; x=1776138712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/TQHykLdF85VtC6CTJ2wonciXUmXtr/iGFz2p1d+iM=;
        b=Y7OwrT4yqIm0/ygNdT4l+U0iDrR0zriPN25idZTAjPouni8HInTKkMtq3O4xaChFOt
         4pOtrSchKuZQegp36i88OOZLIQC8zYdcYne0jI/RWpKobyfUQlVdnzxeR3whfzhG1abw
         uaQcoTUQYDBpO7XcftXv8Hos4SwLsZB/wBHWItEHaW1B0bvtpc0Xgb1MCTmoZybbR6R1
         EERUJdEzEKngI3gnieaIb7DxRhda/H5MyIg1gyomMtJACfkIxSG67r/XbsHuJe1Up/No
         Bawiw7LPazIrJIpoEDUgolpDQOb7RtYSZ7Ah+ugM8+zuqJHM+kDVN/OZnIGQVyALmSLi
         iPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs8lpvHaJoIoFNsSE+GCdguD6hTk9fPvgRoGiz/wY6ispsRmKHeARURvVkCF3/QQ7z2LRqYEsD/+81NMQQ4WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZ7SBm0qM7AzOhlWi9cQxn8YSXa93uzaaDKImT4cZEX4yXlLz
	x0+/K9O3qTqGBlXLG2hVqrf94hJ3xLqj6vQjPoTdRQsqw+XbfXfNevlp
X-Gm-Gg: AeBDietcbNcBixmHnJaic5LBFPRe5UmnNfSDTWfoYqkbjpxvFJDPT93uWphHbn1Het5
	npLMgcdlcUM34+wy2Xgo3+wYuRSJDi0TSuJ8n2HnXAMCjKn/x0i3L2IeY/8yytpuqaX8+JGZot3
	Y/zufiZoZjgf1aSe/75tauwzN/G8wJ/CDsrzh9fIioj9Y1+2exHGsbsKCGtgfE+ZKp4uufKTG1m
	+4r7u6PgaMmCQO1QRubRWz7BqXAPZ7MWen4Fef/PhRp6fZxX669XdqhowZtvH+ysd8agkgLyG4+
	p4+wMoAmyMVucsVuXl0P+eC80VPhQAMuWXO17g9nSbxx6C909jDuiFHw0vtnQQwDCEXKKNJrNj0
	W9L3Z5B/QlgDsZjNVzElZwPcXPAwZcJ8+YpfrlCTDyEl+I1AItHGOYCTgzm5URa+eFvvcUiVnHH
	iM3FDwnQ/vircWUxc2QF2thb4KTJaGeyscOtvBRqXLrsqWsw5gQhb2XTY=
X-Received: by 2002:a05:622a:1247:b0:50d:8389:c3f3 with SMTP id d75a77b69052e-50d8389c6c4mr146678471cf.54.1775533912203;
        Mon, 06 Apr 2026 20:51:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d82afc7d5sm77280341cf.30.2026.04.06.20.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:51:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC18XX ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: lpc18xx-dmamux: simplify allocation
Date: Mon,  6 Apr 2026 20:51:32 -0700
Message-ID: <20260407035132.99037-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations. Requires
preparation, aka reshuffling before the actual allocation to get the
proper size.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/lpc18xx-dmamux.c | 42 +++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index d3ff521951b8..5dfefbc496da 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -32,11 +32,11 @@ struct lpc18xx_dmamux {
 
 struct lpc18xx_dmamux_data {
 	struct dma_router dmarouter;
-	struct lpc18xx_dmamux *muxes;
 	u32 dma_master_requests;
 	u32 dma_mux_requests;
 	struct regmap *reg;
 	spinlock_t lock;
+	struct lpc18xx_dmamux muxes[] __counted_by(dma_master_requests);
 };
 
 static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
@@ -122,12 +122,30 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
 {
 	struct device_node *dma_np, *np = pdev->dev.of_node;
 	struct lpc18xx_dmamux_data *dmamux;
+	u32 dma_master_requests;
 	int ret;
 
-	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	dma_np = of_parse_phandle(np, "dma-masters", 0);
+	if (!dma_np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(dma_np, "dma-requests",
+				   &dma_master_requests);
+	of_node_put(dma_np);
+	if (ret) {
+		dev_err(&pdev->dev, "missing master dma-requests property\n");
+		return ret;
+	}
+
+	dmamux = devm_kzalloc(&pdev->dev, struct_size(dmamux, muxes, dma_master_requests),
+			GFP_KERNEL);
 	if (!dmamux)
 		return -ENOMEM;
 
+	dmamux->dma_master_requests = dma_master_requests;
+
 	dmamux->reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
 	if (IS_ERR(dmamux->reg)) {
 		dev_err(&pdev->dev, "syscon lookup failed\n");
@@ -141,26 +159,6 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dma_np = of_parse_phandle(np, "dma-masters", 0);
-	if (!dma_np) {
-		dev_err(&pdev->dev, "can't get dma master\n");
-		return -ENODEV;
-	}
-
-	ret = of_property_read_u32(dma_np, "dma-requests",
-				   &dmamux->dma_master_requests);
-	of_node_put(dma_np);
-	if (ret) {
-		dev_err(&pdev->dev, "missing master dma-requests property\n");
-		return ret;
-	}
-
-	dmamux->muxes = devm_kcalloc(&pdev->dev, dmamux->dma_master_requests,
-				     sizeof(struct lpc18xx_dmamux),
-				     GFP_KERNEL);
-	if (!dmamux->muxes)
-		return -ENOMEM;
-
 	spin_lock_init(&dmamux->lock);
 	platform_set_drvdata(pdev, dmamux);
 	dmamux->dmarouter.dev = &pdev->dev;
-- 
2.53.0

