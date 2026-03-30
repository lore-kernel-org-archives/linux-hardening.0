Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45636EAA7
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905376; cv=none; b=aKqjJcQpWIae1/m/rrcl5wbcLpm7sNvL9oHG4g8xlJGCH/e0vboIi3YMAGvi64IVjAE/fW9Na4iGUkjlGi/Ch84qwUzat7+DEllGhJv2rfuGA2Rm0F1waiqerUi0XFYLPTrfcVPr629QfPTb4IgKxhHji69/Gr047jdTp/PhMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905376; c=relaxed/simple;
	bh=0r/vyHKpOF0SAyTRzVOWBuBNrSAHVSAnFjY+aUU7feE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDFXqJzOgFkG8p19ZvCLF9UrCnSxjPtiKmAD2QJiC94qt7/LiFb1Fuh+fl/6jt6laB72CWWwKfaNs6aOMyEaWmSx7AN0V7k7FYDxn1jYgl/17gkVnu/QK6jdHaTAbQkLEqT1tVmNFDdEDT6jWX+LD7li+atZGGco8Px1ICIUNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVqPXLA3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVqPXLA3"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82985f42664so2775073b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905373; x=1775510173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UW7odxZPYSWuCgnGtpRjdMtnRpvYwb8B9YLZ+r/hXWM=;
        b=qVqPXLA3yxBBmZ0hI8z3W/QxuMqN8LeHfE6Crf9oHi9Xn3ahHHV2UMvQy0VavnNX0P
         MqTJcYh/LXNPRGnfaj59nmw1eWa1GpIEgb6IVsB8bsswTU+3Rm/qgTYiOqj+WyTPf+AG
         b5D78XlPUh2mM9WMbB9pk8PqKmIuZ7/istJsU5413Z1atVULQIAmhL8xJfbStEH+kjlo
         Ba0RciEVCngd/rdrf/CKAS6AhExjqnQ/grncE9NfllHarOZJdhVSCoayUzv7mA7sLtt5
         tHGbLnn/4NgDIe3Y5yq+0qgKi2TaeOlmHdUGGkvjOXDsO/ZXxjNoL3wogmfkhK3GEbUM
         1hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905373; x=1775510173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW7odxZPYSWuCgnGtpRjdMtnRpvYwb8B9YLZ+r/hXWM=;
        b=g6O+48236Usx6ce18uyT4UVY5z2ft3UW0E65gx8BVR4KxPwPNQHF3ZxlCY9lQkOq/F
         8VuOrHMmE7iTbwMCmEFo0Pyc/Jdq+lph7n9Eo0U4HIKFcYf4Ao/A5s8MgPUeyrkXDY+t
         jziRze3tfTSKwvKR84ufXULxGouhIaU1iTZsXnFcePhNFbjCXhzR9IGxb59zx8S2RVNd
         1yvfD82UW53z3ph5NfUQcAzeXAQqmkmbOkH3j3QL9zLh9B53nlW22Z2l8whfY8ZCChg6
         9GG6TTLSco9rgr1DjIAXQV96oCwQzgRMNPw9EquJbRCyoYuB1FH08PyGHDAlkIHblJ2P
         3WcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ugR65La/Hmlxq7CfD3Rrxx54inzGaKZzm7NiHSSZCSiP3X8JVvxlcV1mt07bUvQlBaCqgS4/Yw1NQ9vbUpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaGzYiumBo+7eFfQcehptYP03IbsDFWdjOSLmD383m8w2xVk6
	519ACP29Mswqvp6gtSD/eQd18Vsc7S5UkbD75o/bCB4NWnvdLRhs3Dx9
X-Gm-Gg: ATEYQzy1hWvmHCtZH5U0hxfeoxsgHANOKUNV6pKXnWtePNNT4d3mWN4Z54Uv+mXhLW8
	K8ADyFndaDFDrlQuoNs9v4c/TiBEtEQZjqb1Oga1UJa8bWEPr0skYkkFEnr7f7sHe/RLbmY/D14
	4wxZeT+IIUQMYoBmNr4tofNt8etVC2lik4wXRhaDh8rFKYzIwncf0dIt3NTrOG78m+ZtETvBuB8
	N5lmRCcNyA1LMNO81kNs70EqixuwOPL+6Lb+7kFMnGbC/wU0JUgEWivEkduKfElgrc7gR4W1pPn
	UTdNdUcUBusb7W2wRMpvNOmdOecsSs42r2OqaopgWfg0FRqkFUfZ8GAsQUPz9XsiC2i4J4oYjh1
	VwDREHAZT24PkdldNhB3rbqviYihIx0x8zgmMS35sr07XE5L6zaUf1ucX/2PyIHVerhPYqmdhot
	gTVuKelKLRPAc9kR8NhIpmxZV/bjb9TLgj1PWJD45hjyMPcfaws/TO3Qw=
X-Received: by 2002:a05:6a00:4146:b0:82c:9126:31f1 with SMTP id d2e1a72fcca58-82c95c2188bmr14066508b3a.14.1774905373173;
        Mon, 30 Mar 2026 14:16:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466d89sm8661610b3a.22.2026.03.30.14.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:16:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: st_fdma: simplify allocation
Date: Mon, 30 Mar 2026 14:15:55 -0700
Message-ID: <20260330211555.13974-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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
2.53.0

