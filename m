Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB41459FA
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772358; cv=none; b=EOQR2AtwnXiXQnjv0LX3WqyfKyMHWGF28ZptzmcXRR/9feMBOeFMExCLVdzAaWW1mNc4zlK6FYQewbsXVyHPoTT4aMM2e3YUEeizQNPAF2TTUQf6j1WGhROCoSyEYIH69lT0hojTrMi6x+vVS3wIpLUQGf0EHCpC6c12P5VjNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772358; c=relaxed/simple;
	bh=xA8aQuqO9+A2QlChUKxhqBmLi0Md/XKikSYMta2cMfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq8Rteej75CVnuvmfAo9FhU09icnxldIkNr4tNyKJUL7bmfV4xRWSIcfR3yXb99bvay+xHLLwmJwWeKWzYxiqZ+sQnO5LhrIWcJnZhNxRy4Wss89tQM6pRQw7U3mvINQVINxtKO5A8jzEsLBr06Gmndik+2UrOn6+yRrIYivcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGXNTXEE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGXNTXEE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae56f8776dso35129135ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 20:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772772356; x=1773377156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qG3UCHbICIKoqorE0OwQsqzoYP9iJFn4dnjoO73bdjs=;
        b=QGXNTXEEp+6TbSuG2mJQ0eARDtM9y7nHSJ1EpXOtE7S85N8LjBCOmxQ6XIW7bl6Z8T
         tvBm4MTXnoPmTTDOdblvhzRVs9Q/7Zf8HZ//E/DyIIonLT51fV4DCNXTN2tVgVIQWpRk
         LkfanMDlHDtFt7DYo35EuNemHn7vQcHBkR4pjRQMCdJVl7SaM5+/Wq0PoSOfcZgE9NZF
         M2rC2YvQji5FhJt1oscFAucBKZhrNyJDnHH9LCUSovqfxXn9h8wX5xpJj8V7/D3jEN4p
         6sXnXFKfy+mo5cx1iI23OGXmjBj/XWmGW0ibvjY3FsB8w9JZQLqUYNNCRyu42WQkgv2B
         CyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772772356; x=1773377156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG3UCHbICIKoqorE0OwQsqzoYP9iJFn4dnjoO73bdjs=;
        b=JdjSHtduY6szR5rlfvA2P1zHP3GFD0HQ3qVLFOpASypxcB/zmtahiH+vqm8aGdQ+us
         UY1Ru3oq6iOcT4DhMxIAQmgMaSFVR1ceNQYAWboPU+VkodoBfGLH/6p0NnAAv70qqfE8
         m+QT0rG6m+0jtuuBPjUKQrHf0pepR9uIiUe7T9qADu4OL72TfAN80yB5L8M+uU05jir5
         v0ITmekW9MsS50onHsYUJeJBrxXfw5vkAjEfrOWMqqCUiSsefiE5HSZZWEo749NTBsby
         ghQbPjCVGg5kN5MBdibbViluKa+Sam+L0nkmGYWwMyDGVcf38KLQbaCoaLCLHMvx9ChB
         pSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Utffh9vSFm5OIvyr5+N7HMI3+D+OkeHR8y4sM/dybPpcQzimh93IPp5ZDftcTo5C4rnXs9aYHVOO5VtjzWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrYUbnCncYlHAKSx82MtkexflLPp+2Rh5d8Wr40xW2xzliZBd
	06fhbQIP2gCITKoOa5rl0TX6zg+LqBQcmyg8uFOgvwbe6sr379OAw3zH
X-Gm-Gg: ATEYQzzUeQqpRm5vQe0vyQG45KRF8/kbu7F3atPrxGoThMrGf+jmZ/UsmA79NY8vJeo
	5e/UIlkqT9HILpHCoU50PpbGa30s9ITqFl3U5JWFcKPBMhUPQDIYv+Uc5JcUvZZ5GMUZS8bxntP
	j7MjEsT8ydTz1RS4rjGiTybFLbMRji1fyY6O1ea/ZQk5Q6xBweS/14kJqOdwEgGTEZdzhiQymL6
	iTgYymgKmN734rIr/TcR8ImQacQHB3CiIBlNYol8EYgR8bI/jgEaV82PZA+p2woj8zWQmf6tVea
	z+0wVEcDZFQuFEfa06eeC0ldjNoHb6nr1A3aGw1ShjbntwWfBYlxaHi9C10v3Ljshawc8IVoVVF
	BjBDZUx5Tj3KrqY3D6/poL3wM2KiGaNdV6ExCcHBdHDKpb1OXJ+X7dsKccdAYcztprDjWa8hpvR
	hwoCZ/f1FANDy/vXvvi27gviKhij/S5ALAYuoQ2hjID1DQclwx2YPilrg=
X-Received: by 2002:a17:903:2986:b0:2ae:8092:e212 with SMTP id d9443c01a7336-2ae823ffc26mr10568555ad.8.1772772356318;
        Thu, 05 Mar 2026 20:45:56 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57cb1sm3927375ad.9.2026.03.05.20.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 20:45:55 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-media@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
Date: Thu,  5 Mar 2026 20:45:36 -0800
Message-ID: <20260306044536.149204-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible arraay member to combine allocations.

It looks like pipes never gets freed anywhere. Meaning this effectively
fixes a memory leak.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 11 ++++-------
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  3 ++-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 16392420903a..657ffecc4d7e 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -459,25 +459,21 @@ static const struct dev_pm_ops mxc_isi_pm_ops = {
 
 static int mxc_isi_probe(struct platform_device *pdev)
 {
+	const struct mxc_isi_plat_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct mxc_isi_dev *isi;
 	unsigned int dma_size;
 	unsigned int i;
 	int ret = 0;
 
-	isi = devm_kzalloc(dev, sizeof(*isi), GFP_KERNEL);
+	pdata = of_device_get_match_data(dev);
+	isi = devm_kzalloc(dev, struct_size(isi, pipes, pdata->num_channels), GFP_KERNEL);
 	if (!isi)
 		return -ENOMEM;
 
 	isi->dev = dev;
 	platform_set_drvdata(pdev, isi);
 
-	isi->pdata = of_device_get_match_data(dev);
-
-	isi->pipes = kzalloc_objs(isi->pipes[0], isi->pdata->num_channels);
-	if (!isi->pipes)
-		return -ENOMEM;
-
 	isi->num_clks = devm_clk_bulk_get_all(dev, &isi->clks);
 	if (isi->num_clks < 0)
 		return dev_err_probe(dev, isi->num_clks, "Failed to get clocks\n");
@@ -487,6 +483,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(isi->regs),
 				     "Failed to get ISI register map\n");
 
+	isi->pdata = pdata;
 	if (isi->pdata->gasket_ops) {
 		isi->gasket = syscon_regmap_lookup_by_phandle(dev->of_node,
 							      "fsl,blk-ctrl");
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 3cbd35305af0..99532efa4e41 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -286,7 +286,6 @@ struct mxc_isi_dev {
 	struct regmap			*gasket;
 
 	struct mxc_isi_crossbar		crossbar;
-	struct mxc_isi_pipe		*pipes;
 	struct mxc_isi_m2m		m2m;
 
 	struct media_device		media_dev;
@@ -294,6 +293,8 @@ struct mxc_isi_dev {
 	struct v4l2_async_notifier	notifier;
 
 	struct dentry			*debugfs_root;
+
+	struct mxc_isi_pipe		pipes[];
 };
 
 extern const struct mxc_gasket_ops mxc_imx8_gasket_ops;
-- 
2.53.0

