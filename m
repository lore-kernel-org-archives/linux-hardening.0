Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D0344DAE
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033461; cv=none; b=NWtR6OdUUWFp5CIEzviuipaoZdETHTL+DLg/wt9bpjQd+oR0dhmyb5k237Jt32xVgkgjs2wsFWj5oRiTDyyLZOarIE2X0zTQo8GGwGsJWAcIOzseLXCBBDvVQXzCWeFJPyStSaGkm7o2IiTzM5cZLycvH5fp2vZ6U2Aw3ZoUYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033461; c=relaxed/simple;
	bh=YMk4eEZzQfMEEjnXMg4ElEtC/CscaEPHqozNlwYI0AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCaxfp5TEh9f4Pe9VqTOGqsPebSQuZif2k5E/u6yy3/2aCAiLF4YSAWcW+dR9GVPcPO5w638rRs07R7R+WaZt1L/iw4fz0DAJfb/DNBZgPpuKYi7DPuuRpIIOcDHPCWRSRglBHKDM47rJY3AbcQHMVzuKFXwriOioSg/OGkHcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkabDSnA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkabDSnA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e2fc11088dso54139377b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033459; x=1781638259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ah8w3Udia5Uf8f7IAKPt49JbdNJKDfUC4gBLeS1QUbg=;
        b=BkabDSnAHHyUk5mprBjsZr+2834BMQCtTxr2PvjNYUVIFZFvo1pFQ82hXNwpq+gYer
         Elhxt7dMZ2P9kLxhwheH1yXXykdaamKVdnt0oA7VTqZ5/+dIP0frTKavd4w+/LJuPYhT
         bfgn7eAkfhrCGnDEllTe60Dyej0o4jCZtcRjbG6rMtqRZDg7oM/p5h5Jmbb03I6vSvIc
         WWw0M/HMVir6I9RfMUJxuoMhXU099WgPOb82jPQRVM72JHd4MvhCxL3mvp+PO8TRKFr6
         sDRcTGOVJf+HrkHgLPvhNWPnN3qwqKbu+Ctv2qzB5U9htQAre//Txz/C/BYkA1KPn9Z8
         QOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033459; x=1781638259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah8w3Udia5Uf8f7IAKPt49JbdNJKDfUC4gBLeS1QUbg=;
        b=SyU8NKvYltU13W7PZNd2jccfuZ+ctOMckaQJT0RwukbZszCSgnNxQab+6yq0HsdR9c
         h+YfWsm4EeTxYh9PqkV1XiB05BCCObnop4drIAXmDgtW+iBO2ssRiE+j7opYdD92trdt
         T3XdL/3EOx0PyXPhUsRt2UiAKPKL9BTDYQ1RToMyGQ9yKLVxyjdPjMQ+7Ziirg4EygdR
         Xlz3RTcA1W/ExrUKWVx7wS+ys8sI3nQ7QScTpGDHcsAqHpbgCUD5FDKswjRMTcum3HBo
         mR/hcvd14fZqzXNon2Ka56CkPUlDbNztUG5RfnZyxl9noNNtqsifZtvSGGl+A5skLRKm
         f8YA==
X-Forwarded-Encrypted: i=1; AFNElJ/CwlKfUst8Iuasy6o4QmnW24BMoYYKbRsBBZPxKwx2BOQfekEYDHZEiQSoC6vWxe78Sla6Uam9zIeTlWYFQLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkuyHjHvthbKOskaAeVPVjf08zwxbWUfcwdwV4Bq6wUPdr/28
	TE/9zRFhQsmpxAXVITNbkAqL4qwZU3EUcj7vISNpX8Nrne7W+4Zp9YVA
X-Gm-Gg: Acq92OExMXZUK+rGLutEFXPzNTq9fxjSlncPMG5Y3x03SwanmWRt0+/Z1iqIgaYfSlE
	hX69lWaYzsjPti/mZmUfc+5/5EUvnNHp4nVQwgrhSzQF+Qhw2Nncs5G+0ORbKWfp2Grk2psihV9
	ZIdNOqldcropNwV9nY7oEYoVtBn3rcS/p3VuST3OvNvQUAfW+hmOtO/dD7AthwCeze4ceLbx9+h
	1VomPNNAnvvJ7IFEsuapezp62zHwFY0LD/nneWBgze0FE3pUj1iZKqwouWufimz2a5xeDg+Luuf
	g4/i0MbBBmRunE5p4cpC22afu1ZzMwpPx+J6IiRdwLjEuimN6sezvTJbJ1aJJgg2wxpr1+iUukG
	hX7U8t12F+/+9/jP0AOGp3o74zrYzEQzhrUdoZ/6CNjmR2VoTPwsIjGOx7fOb88vmxOnKMep7Ie
	hs393MtEaoybMqfaMep8PCeSRONPrWy1GlciWjcJYzGkVHO1pYrDn36eslWYjD1r0KRR5hLtP51
	ypPX0EugkJTi1qDzFw7E3oiAOloeCY7AcErS2uXuExqMIrapUiKklaH
X-Received: by 2002:a05:690c:c508:b0:7d1:c256:b5a8 with SMTP id 00721157ae682-7ed0cee7e6fmr196251467b3.40.1781033459087;
        Tue, 09 Jun 2026 12:30:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a97729sm102970987b3.36.2026.06.09.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:30:58 -0700 (PDT)
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
Subject: [PATCHv2] dmaengine: st_fdma: simplify allocation by using flexible array
Date: Tue,  9 Jun 2026 12:30:40 -0700
Message-ID: <20260609193040.4504-1-rosenp@gmail.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 v2: Update subject
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

