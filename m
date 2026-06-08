Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7A36F8EF
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895930; cv=none; b=Ka019ccXgaVPdW48nZlQANwnYGBOZTynUL+AYdmDPGj9wMjGvB+AiP/tzpCfTEHcxe+mmv6vnYn7Hg9nDIyl52Z/bqhFyUD9PHuUQC0yPNdV4oSXsT3Vaf0spi1eaG1eWHKtD9EOb4xgfclLK1dabbs6ujnDVMv0NJqnRzivGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895930; c=relaxed/simple;
	bh=2vhkmPNIW4/KCYWvHjq2mGkNcmFCQZQd8d0hnhmyVHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laT5+kqy0fsrHThtyzB/emuZtzKvKa2sp5wH/IuYiwmSpTkTwnz0mt5b2+x1ExaMwp98J84f0Se2rQ7ITAOZi34QmU5gvutevhDJX6T012ZFkOHXVAbCA8Y6GuMvK2yXbzIo9yRyDZt8oFJkSVuqUPm39aj6+KX6O3y9ebdX4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGUrH9nz; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGUrH9nz"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-48673dc56a8so3361650b6e.3
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895928; x=1781500728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41O9k0y5eFiUd6+1CLxq2KiJxjSqZ/KgLg6URVebdXU=;
        b=PGUrH9nzBx9vqyC6InwLRB1zkzZTjl3yzVioz4gQ3ZNIUWJrHvGPT7ZWsTDa+6hzMt
         tdnqxYenUai4ozzW7RNhKzZeOKTzsyFoRw7pBKv5UDaQDe31p0ZXw7UxJEZmCiCGxKcM
         6Ki9sg0vBfsp+AEVxURdXz9z42UrOt1aS9FDp8tJ0nEp03oz1PsQ+FHf6JMrSiJMVX8s
         zSymjQ1FXiH2QY73l3W2sJD5cU3eNk9Yf5OoS6DKohbCWAJsFFnMvD+3xD35YHv66QPk
         yEHpyxw+JJ9SqE/agmWtAjaUQYeI3dkNO+2IjY0E+8SZg/gVkKpG0EGHoSn0WMz6H/4X
         urTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895928; x=1781500728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41O9k0y5eFiUd6+1CLxq2KiJxjSqZ/KgLg6URVebdXU=;
        b=IWFIElQk8X73DsEagaVb534SJw95QGB4lz0ofG91R6has3ZXHxRYRuI9EiRB6PEF/0
         S8syAvcDXM5oESxS43QC+vQLuvmLMBdmW2MtIob2Vzt8tcb/z6Jav/6fbeaaV6YFfWZg
         pgM5ULDyHGGWzcLCCST84UQfL76zedxd48wkqGQKT0o2E52qGFWCjLqLrHL3Y7q6Q/rJ
         yIJ719Z1Uj5m1ZDRpfN3dsYaxj+yqjkfoqmBRKCPalDIFDQBeFN5fNX53geIdVeDDObs
         G1+bIydi8LJU5LBj1IamHxnfUpRtrBLTV/FXZ61oppgsXyWDJU1HN+xBJe2wsVlpvOBh
         hFIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GJEWmWdSIoRvPYPXth2WwjpwCRZ3NpOJFI54Ee8jXahv8CvpFlvDGKvyjk7H5mxKe+6WnZu+SaKnx8jdCP+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypu/stDPMfGhpVypvg6aXRcjGQUKlhda0mfEebOj2wGeFMvR3h
	KWEy8Xw61gvkjPuCAadz2qHwFrmDcn0qAAmRSF+1Ar0F7iGpIJiaWIwK
X-Gm-Gg: Acq92OGqHgFJqVmKRvA2FHNv5yHJs6xmx3AAkRsB6dtj92gL9ikt+Go8LL/+ZzFZc2h
	ZIQ3myus12OJ8RGYWj5RdUm1cIdyC18f0SM38JpKnRzSsxIgnEw2xZh9WY6zWif3YLz97HgpxGE
	mkPFFfFrExXuDNWbcHXzhbDRL+Q5v3/5hiTQ+FhGXmY9CflBKweSfw3MU4Nb3Of47Q17zmfcYT4
	nshYkcl72dWzZmUG44wqOnAh3JUTJMBvjq7h/4HWtmKb9W3eiaxYmJdQExxbL7NA4dzpEoYJnwl
	yLjv/rfVxrhtkTuWG5fCw3bVyncJFOTELd50gy9BQrFRV6sAAeKO1MkLgn1OsZIsMBL6WDlWb1O
	tPQNQdvkcNeRpCIpOnM1ptoYy9z8a1gJoSmCVkXFPEl9eu99dD2ptYqvQKimz2awl3DHH/msBUf
	0MuT5erqOPDwJeZyQYNmghiCAntK/S7hIRHzasuIIT2t6drEFDs+zrkew7wf6UlQ5gbDvRoLKat
	Ax8KSFcAsrrMPAaN+XXl+PTHvO3lvz82jlHQzatORxbcw==
X-Received: by 2002:a05:6808:148c:b0:486:39db:ebf4 with SMTP id 5614622812f47-4868dc042fbmr8070721b6e.8.1780895928388;
        Sun, 07 Jun 2026 22:18:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e75b2017sm10838024a34.8.2026.06.07.22.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:18:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dmaengine: st_fdma: simplify allocation
Date: Sun,  7 Jun 2026 22:18:29 -0700
Message-ID: <20260608051829.7390-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc to a single
allocation.

Add __counted_by for extra runtime analysis. Assign counting variable
after allocation before any array accesses.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: update description.
 drivers/dma/st_fdma.c | 27 ++++++++-------------------
 drivers/dma/st_fdma.h |  4 ++--
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d9547017f3bd..3ec0d6731b8d 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -710,16 +710,6 @@ static const struct of_device_id st_fdma_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_fdma_match);

-static int st_fdma_parse_dt(struct platform_device *pdev,
-			const struct st_fdma_driverdata *drvdata,
-			struct st_fdma_dev *fdev)
-{
-	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf",
-		drvdata->name, drvdata->id);
-
-	return of_property_read_u32(pdev->dev.of_node, "dma-channels",
-				    &fdev->nr_channels);
-}
 #define FDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -742,27 +732,26 @@ static int st_fdma_probe(struct platform_device *pdev)
 	struct st_fdma_dev *fdev;
 	struct device_node *np = pdev->dev.of_node;
 	const struct st_fdma_driverdata *drvdata;
+	u32 nr_channels;
 	int ret, i;

 	drvdata = device_get_match_data(&pdev->dev);

-	fdev = devm_kzalloc(&pdev->dev, sizeof(*fdev), GFP_KERNEL);
-	if (!fdev)
-		return -ENOMEM;
-
-	ret = st_fdma_parse_dt(pdev, drvdata, fdev);
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", &nr_channels);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to find platform data\n");
-		goto err;
+		return ret;
 	}

-	fdev->chans = devm_kcalloc(&pdev->dev, fdev->nr_channels,
-				   sizeof(struct st_fdma_chan), GFP_KERNEL);
-	if (!fdev->chans)
+	fdev = devm_kzalloc(&pdev->dev, struct_size(fdev, chans, nr_channels), GFP_KERNEL);
+	if (!fdev)
 		return -ENOMEM;

+	fdev->nr_channels = nr_channels;
 	fdev->dev = &pdev->dev;
 	fdev->drvdata = drvdata;
+	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf", drvdata->name, drvdata->id);
+
 	platform_set_drvdata(pdev, fdev);

 	fdev->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index f1e746f7bc7d..27ded555879f 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -136,13 +136,13 @@ struct st_fdma_dev {

 	int irq;

-	struct st_fdma_chan *chans;
-
 	spinlock_t dreq_lock;
 	unsigned long dreq_mask;

 	u32 nr_channels;
 	char fw_name[FW_NAME_SIZE];
+
+	struct st_fdma_chan chans[] __counted_by(nr_channels);
 };

 /* Peripheral Registers*/
--
2.54.0

