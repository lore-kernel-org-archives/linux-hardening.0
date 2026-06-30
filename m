Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88954366DA4
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783565; cv=none; b=YpMxTv4sKqmoLvr8F+xLFSnEObubwuXMd7mIcDUGkvyYn9LvlBCVdJM0ShtEQWqcmm6ImKSZRodwiInWV7A0NgwWETZORXZNhg5vH0kt2xcmKbFzmfd3Sa3yy1W0zvSN1eH5s2FFYw6AXKtrmoeaxhJ+7sw/ck0FhdZo/AdDFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783565; c=relaxed/simple;
	bh=n1ocKp3wDDgFEi6ZFM/0FTutO054S0G9BPU1N1K4+wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GU8jsBe1VJwzT/Ux2eyc9s3703t4S9cTcpF86RIDrVmmh525WX38sVW51JYS3URauWr49F/6kfjOaS70Kk9GbV7lWS74/YoUW0D9E3UJAyS5ookSdXEriDg6MBaZBTrRTti1Pip2eNe6eyEfdhbhe5/aysUrz/21tMfCJ0U1iyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXCj7ujq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXCj7ujq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so2001418b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782783559; x=1783388359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+chNJkaxkb+6yp2ClCCdQny6Z296FnDe7g4ZtG0EO+E=;
        b=lXCj7ujqSsLDImhfzY06NIgYzTgaKP4O5KNA4FgInclgsjDDiYmHVf9V0FHAcAn8F0
         ML7c0EHaMyZ/l5v6CVRxEzbTgxweodUoi6d+NCpwJBA2vAnqwo5FhDnJr8mdI4r/iqpu
         p7oMIvkQqVqt6/SkXCLGSAA782Ii3lAYSpxGyMTqVbhohtKlxISGEAqh5DebsQEjB+s/
         UNoxFzMpPu6aKGbbr/xuTWCYg1YEwlV/VIE2fBjgmdPw1dzEMDAiOL85j/MLH4UbO9BJ
         wYRDNGOZEW+KYJyr+jcxLnN6+SrWZZIKOvKJDSxwU4VHmErwX3yapkKrmLILE4Nc37Hn
         bgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782783559; x=1783388359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+chNJkaxkb+6yp2ClCCdQny6Z296FnDe7g4ZtG0EO+E=;
        b=kcy7XuA6ROdDU/XJpI1H6hMGSR887dfEUuP8q3iJjxhkhUzz5RaxuhblxCWuLepjGK
         fcALccJPZRDdr3oPgt1ocsiqc2ozhYfCnKPNFL0e/b03eIYXY3dxkBbO9vEjF0HCN2CE
         NvKPUn7KUUupswYGg/58CZixGExz88flcbP2tBN5D2b2ErCrSO1C5SsUql0HosWnxPon
         OKN827+k4x1gkWVaM+6Xozz8F+k1+EfIBxXVY/7dxM9rbhTQ3ReESox0gIJwfi/YcwKI
         2Nw+npVuJ7xZB0NN2cowgrYwqT8S0VqVYWZ7EqiAYdgZEJLA6n7/gkmjYTtHkqvBBYaM
         cPCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXoSQXbRU1UVw3JVCpUODf6OGubDprEShE02rAcxaPWEW+stj/P9GzquUSfIxN4m8R6Pkg3hrNdqo5Sid9nu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAmIquLJ2xiVnt5FZIocqlTgCfuJUWFYUVSAgAGGe4Mc9lrY0
	FR8fefihJu9TUI/sDCciVfQvMwiSxiPTb/HR74ljZvFXJzaHBKdvf/pQ
X-Gm-Gg: AfdE7cmyM0VNxCTX1FR96C3GApIkmFV+ScrOMkBj1VhmwZmXovE7FbUxs6i8stgAWhj
	Lqej8NjMyfBBnJzz66/AOAMeuG+ubnwC5ro8jghQjbTkJRL4yQ+EY9cD3/TcCNX2y5Qf/J0jJt8
	cmdZtkkdLYpIwzkYl22+8qAL+D1u1CaRApvY5r/JtP4Azzb+s069OC1U5CfvkUiPfpTZMZOyrs8
	3nzg1IPor/VODv5KQacnnT+/P01zvgg963+9/tvUuf1wzyayBoCQCADee8Ub6EJbiFzklGQFiTb
	hO1brS7364GyHYgjn37kWKxiNUXGt56kEHnT8MtEFO2H3XoDuZFj+zowlcqLExRn7JHXOsSaCVf
	29IavcdXlF3xb9lpF6dAbI9Guw1Kg2UEWHHlMffQoFg04Hl9vVdvMDMuHmkTtBpK0g62uFwLk8K
	SJzZwLKFr7YzmVy5Y80hdEcEnqD0qwmE4yDMZ7mNngRIaZ7G2JZsDQE50G6OqJ+2XWTO9SE2sOS
	pDv71DOvg==
X-Received: by 2002:a05:6a00:44ca:b0:847:77ae:8845 with SMTP id d2e1a72fcca58-8479f2701b7mr1301770b3a.44.1782783559292;
        Mon, 29 Jun 2026 18:39:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff89fe5sm692853b3a.5.2026.06.29.18.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:39:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TI...),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dmaengine: k3-udma: simplify resource allocation
Date: Mon, 29 Jun 2026 18:39:17 -0700
Message-ID: <20260630013917.1537819-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Fixup ti_sci as that also breaks with the header change.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 v2: rename to k3-udma and add reviewed by for the ti_sci portion.
 drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
 drivers/firmware/ti_sci.c              |   7 +-
 include/linux/soc/ti/ti_sci_protocol.h |   2 +-
 3 files changed, 98 insertions(+), 91 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1cf158eb7bdb..2480d22466f5 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4584,9 +4584,10 @@ static int udma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	u32 cap3;
+	u16 sets;
 
 	/* Set up the throughput level start indexes */
 	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
@@ -4664,64 +4665,67 @@ static int udma_setup_resources(struct udma_dev *ud)
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
-		irq_res.sets = 1;
+		sets = 1;
 	} else {
 		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tchan_map,
 						  &rm_res->desc[i], "tchan");
-		irq_res.sets = rm_res->sets;
+		sets = rm_res->sets;
 	}
 
 	/* rchan and matching default flow ranges */
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
-		irq_res.sets++;
+		sets++;
 	} else {
 		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rchan_map,
 						  &rm_res->desc[i], "rchan");
-		irq_res.sets += rm_res->sets;
+		sets += rm_res->sets;
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[0].start = 0;
-		irq_res.desc[0].num = ud->tchan_cnt;
+		irq_res->desc[0].start = 0;
+		irq_res->desc[0].num = ud->tchan_cnt;
 		i = 1;
 	} else {
 		for (i = 0; i < rm_res->sets; i++) {
-			irq_res.desc[i].start = rm_res->desc[i].start;
-			irq_res.desc[i].num = rm_res->desc[i].num;
-			irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
-			irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+			irq_res->desc[i].start = rm_res->desc[i].start;
+			irq_res->desc[i].num = rm_res->desc[i].num;
+			irq_res->desc[i].start_sec = rm_res->desc[i].start_sec;
+			irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[i].start = 0;
-		irq_res.desc[i].num = ud->rchan_cnt;
+		irq_res->desc[i].start = 0;
+		irq_res->desc[i].num = ud->rchan_cnt;
 	} else {
 		for (j = 0; j < rm_res->sets; j++, i++) {
 			if (rm_res->desc[j].num) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 						ud->soc_data->oes.udma_rchan;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 			}
 			if (rm_res->desc[j].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 						ud->soc_data->oes.udma_rchan;
-				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
 			}
 		}
 	}
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
@@ -4746,9 +4750,10 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u16 sets;
 	u32 cap;
 
 	/* Set up the throughput level start indexes */
@@ -4828,21 +4833,21 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 						    (char *)range_names[i]);
 	}
 
-	irq_res.sets = 0;
+	sets = 0;
 
 	/* bchan ranges */
 	if (ud->bchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->bchan_map, ud->bchan_cnt);
-			irq_res.sets++;
+			sets++;
 		} else {
 			bitmap_fill(ud->bchan_map, ud->bchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->bchan_map,
 							  &rm_res->desc[i],
 							  "bchan");
-			irq_res.sets += rm_res->sets;
+			sets += rm_res->sets;
 		}
 	}
 
@@ -4851,14 +4856,14 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->tchan_map, ud->tchan_cnt);
-			irq_res.sets += 2;
+			sets += 2;
 		} else {
 			bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->tchan_map,
 							  &rm_res->desc[i],
 							  "tchan");
-			irq_res.sets += rm_res->sets * 2;
+			sets += rm_res->sets * 2;
 		}
 	}
 
@@ -4867,36 +4872,39 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->rchan_map, ud->rchan_cnt);
-			irq_res.sets += 2;
+			sets += 2;
 		} else {
 			bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->rchan_map,
 							  &rm_res->desc[i],
 							  "rchan");
-			irq_res.sets += rm_res->sets * 2;
+			sets += rm_res->sets * 2;
 		}
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	if (ud->bchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[0].start = oes->bcdma_bchan_ring;
-			irq_res.desc[0].num = ud->bchan_cnt;
+			irq_res->desc[0].start = oes->bcdma_bchan_ring;
+			irq_res->desc[0].num = ud->bchan_cnt;
 			i = 1;
 		} else {
 			for (i = 0; i < rm_res->sets; i++) {
-				irq_res.desc[i].start = rm_res->desc[i].start +
+				irq_res->desc[i].start = rm_res->desc[i].start +
 							oes->bcdma_bchan_ring;
-				irq_res.desc[i].num = rm_res->desc[i].num;
+				irq_res->desc[i].num = rm_res->desc[i].num;
 
 				if (rm_res->desc[i].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[i].start_sec +
 									oes->bcdma_bchan_ring;
-					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+					irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 				}
 			}
 		}
@@ -4907,28 +4915,28 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[i].start = oes->bcdma_tchan_data;
-			irq_res.desc[i].num = ud->tchan_cnt;
-			irq_res.desc[i + 1].start = oes->bcdma_tchan_ring;
-			irq_res.desc[i + 1].num = ud->tchan_cnt;
+			irq_res->desc[i].start = oes->bcdma_tchan_data;
+			irq_res->desc[i].num = ud->tchan_cnt;
+			irq_res->desc[i + 1].start = oes->bcdma_tchan_ring;
+			irq_res->desc[i + 1].num = ud->tchan_cnt;
 			i += 2;
 		} else {
 			for (j = 0; j < rm_res->sets; j++, i += 2) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_data;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 
-				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+				irq_res->desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_ring;
-				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+				irq_res->desc[i + 1].num = rm_res->desc[j].num;
 
 				if (rm_res->desc[j].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_tchan_data;
-					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
-					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_tchan_ring;
-					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].num_sec = rm_res->desc[j].num_sec;
 				}
 			}
 		}
@@ -4936,35 +4944,35 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	if (ud->rchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[i].start = oes->bcdma_rchan_data;
-			irq_res.desc[i].num = ud->rchan_cnt;
-			irq_res.desc[i + 1].start = oes->bcdma_rchan_ring;
-			irq_res.desc[i + 1].num = ud->rchan_cnt;
+			irq_res->desc[i].start = oes->bcdma_rchan_data;
+			irq_res->desc[i].num = ud->rchan_cnt;
+			irq_res->desc[i + 1].start = oes->bcdma_rchan_ring;
+			irq_res->desc[i + 1].num = ud->rchan_cnt;
 			i += 2;
 		} else {
 			for (j = 0; j < rm_res->sets; j++, i += 2) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_data;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 
-				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+				irq_res->desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_ring;
-				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+				irq_res->desc[i + 1].num = rm_res->desc[j].num;
 
 				if (rm_res->desc[j].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_rchan_data;
-					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
-					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_rchan_ring;
-					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].num_sec = rm_res->desc[j].num_sec;
 				}
 			}
 		}
 	}
 
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
@@ -4977,10 +4985,11 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 	u32 cap3;
+	u16 sets;
 
 	/* Set up the throughput level start indexes */
 	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
@@ -5057,13 +5066,13 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	if (IS_ERR(rm_res)) {
 		/* all rflows are assigned exclusively to Linux */
 		bitmap_zero(ud->rflow_in_use, ud->rflow_cnt);
-		irq_res.sets = 1;
+		sets = 1;
 	} else {
 		bitmap_fill(ud->rflow_in_use, ud->rflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rflow_in_use,
 						  &rm_res->desc[i], "rflow");
-		irq_res.sets = rm_res->sets;
+		sets = rm_res->sets;
 	}
 
 	/* tflow ranges */
@@ -5071,55 +5080,58 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	if (IS_ERR(rm_res)) {
 		/* all tflows are assigned exclusively to Linux */
 		bitmap_zero(ud->tflow_map, ud->tflow_cnt);
-		irq_res.sets++;
+		sets++;
 	} else {
 		bitmap_fill(ud->tflow_map, ud->tflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tflow_map,
 						  &rm_res->desc[i], "tflow");
-		irq_res.sets += rm_res->sets;
+		sets += rm_res->sets;
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[0].start = oes->pktdma_tchan_flow;
-		irq_res.desc[0].num = ud->tflow_cnt;
+		irq_res->desc[0].start = oes->pktdma_tchan_flow;
+		irq_res->desc[0].num = ud->tflow_cnt;
 		i = 1;
 	} else {
 		for (i = 0; i < rm_res->sets; i++) {
-			irq_res.desc[i].start = rm_res->desc[i].start +
+			irq_res->desc[i].start = rm_res->desc[i].start +
 						oes->pktdma_tchan_flow;
-			irq_res.desc[i].num = rm_res->desc[i].num;
+			irq_res->desc[i].num = rm_res->desc[i].num;
 
 			if (rm_res->desc[i].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[i].start_sec +
 								oes->pktdma_tchan_flow;
-				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 			}
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[i].start = oes->pktdma_rchan_flow;
-		irq_res.desc[i].num = ud->rflow_cnt;
+		irq_res->desc[i].start = oes->pktdma_rchan_flow;
+		irq_res->desc[i].num = ud->rflow_cnt;
 	} else {
 		for (j = 0; j < rm_res->sets; j++, i++) {
-			irq_res.desc[i].start = rm_res->desc[j].start +
+			irq_res->desc[i].start = rm_res->desc[j].start +
 						oes->pktdma_rchan_flow;
-			irq_res.desc[i].num = rm_res->desc[j].num;
+			irq_res->desc[i].num = rm_res->desc[j].num;
 
 			if (rm_res->desc[j].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 								oes->pktdma_rchan_flow;
-				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
 			}
 		}
 	}
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 590a464403c5..ef23d732e083 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3693,16 +3693,11 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 	bool valid_set = false;
 	int i, ret, res_count;
 
-	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	res = devm_kzalloc(dev, struct_size(res, desc, sets), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
 	res->sets = sets;
-	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
-				 GFP_KERNEL);
-	if (!res->desc)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < res->sets; i++) {
 		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
 							sub_types[i],
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index fd104b666836..7632bb11c862 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -599,7 +599,7 @@ struct ti_sci_handle {
 struct ti_sci_resource {
 	u16 sets;
 	raw_spinlock_t lock;
-	struct ti_sci_resource_desc *desc;
+	struct ti_sci_resource_desc desc[] __counted_by(sets);
 };
 
 #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
-- 
2.54.0

