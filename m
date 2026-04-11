Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C826C39E
	for <linux-hardening@vger.kernel.org>; Sat, 11 Apr 2026 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879871; cv=none; b=MiwznmTFNJTJyE4eKlyB1Li69gilzem+2xmAq/sThhTofu+0sD/VE6l0k/Mkm4O/W3WBgJzg+SriULtqIHaVzbNXDKgXmbS6rqXc7Up+ulPNXbkX5FIhdd9rY/h43crTmr/QXOU+oBCPNpQlgtOOZsYoLBgz/aL71zTERrYf2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879871; c=relaxed/simple;
	bh=Uu58r8/wIiXvJnAqLv2l6SozLHrd5sRl1mot2FjDAEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+aop2gIqRvR0RFjTDBGvqvoZAzxWtaWCR1MDEUqAILC5TTYHpMhay40f1/lj2L29nQ9y28Z42EXaOmpLYcfM7CF34353e8sKcwI6pPvN1X05lGHVeLxY8PfcqfLLA1xRFFzJpd6yDQCwAWcBQrzOod56nqhj7gz0CRHv1PzgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsu1go2A; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsu1go2A"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1239397a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 20:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775879870; x=1776484670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwxR3TEzggrqwnYhCtbksF3x2HjY5X8G0vLpnWNk5pY=;
        b=Jsu1go2A2PT8KmRl13UO/C4grpWQ8pAfaAVROhSOsIi1Rd1hajzXq04RtHWXIN6y98
         iqfYf6Phs8bWGpX+m/q482fCTlAo3jU7t7hZfbjSs6QufaWqmoVbJz7eWuhF9yYK00by
         n5DvUOI2fCxyozQlae5pjZAQXmHrrl8dbg+tItHBZvKVZ5Ib/9VCuPZICp164aXcUEj1
         Vy+FD7ZJAIPqZyeea4vM3X24JRf8qhqPDeZfhd8UK/loVWp51PgHRf2htPcvad/1f7nm
         RenZ7l2eFBANUqjfTzEAeWVydX7xen/od4pjxi4EVMGhEy8ctctDw7heKatNx2p7UiKI
         4bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775879870; x=1776484670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwxR3TEzggrqwnYhCtbksF3x2HjY5X8G0vLpnWNk5pY=;
        b=KTLNHjdC1zbXkWDv3eT7HuqWlyiT1wglejWeGJEa3wKPz5mphyf2Z4YZZ4wp285JZo
         fPhCKKyrtpYLPoCb+OeiO4xsSh8PlmEOwdV04EptgmUwuF2Wp+pI4BcVIN0ttYU5j2N0
         x5jyIb90V/bWlmrW6Eptlqmv5PRkXCn64eQlOyM/vaningUtX8uxTZRGoRU224Thol/D
         DCv4nI236hCn1TJH1P8UoAUsxLPYui7tdRX3WIwlYVm1C+W1DBy+L2bSTnRmE/iYjcIo
         FXhkDEHzmXoYA0oyT1haOUzqVci+j4zsVbybgpaDbKeRoaQXOi51u0KztFTlm6dlfVBL
         VbDw==
X-Forwarded-Encrypted: i=1; AJvYcCUuKnQZd8pa6BHf6U8YvAX0gzyGTU+pSG77i9ab+Bky6r03HRj1UMdXRgi/yLB7vNe2JdQ1DvHr+hqjfEM2E9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FQ/Dj7AwPGv4I/LUfEGh9j80SM2lhz9fHZjtaGuvaZxzDs6X
	WIWrTKgfba9lclvAnJSNVShmTO98TYzgJJvUeg4OYFn7O1LGQ7Uaw2Z7
X-Gm-Gg: AeBDietf7caRxKpITAWNc21/hWooPrWB7Q0MMsXG5Fd0B7/PXLh/Daz5ODSi8424ztT
	BCN3vz7NR+kkJ+krOfp5ULezAiskdNTkWV2ZlTWBWSAajP+88sOdc+stLvuYqpFaX/BWKDI4wPl
	BCD6TTcfpOfFgdKzE6LA2qrJjcawEefwnjXMfqXhwdORH0D4yEZef80XXeeKdtdaoT6qEMezD97
	ZYbhiGtjoVt0gE65WsBGVvyI2s30Vbf/fMGS8ZeJl/ibwaOnz9tYDgAZqvi+SfAlX1+SnsKF1Ny
	9VOC1dmsCkKQ3NY8GlhpzzdqqomMN3amB1CXYUBdjoDKySq+gmB9tWnhRjR1m73tNST7Idh7xYe
	oETaI61Pa4Uzm/5X1rXcK7700AbGC+6yfI/KzlbgQJkyXzThDyMfrI/grlygwYdh4RWyi9gyR79
	TSB5MHLcAcf/E/InO49MFjlaQx4Y08dbtp3aZ3zr/zzdGtOYMunOWGbDc=
X-Received: by 2002:a05:6a20:3d12:b0:39c:bf48:11db with SMTP id adf61e73a8af0-39fe3f3d83cmr6340981637.38.1775879869733;
        Fri, 10 Apr 2026 20:57:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fff97sm3986596a12.7.2026.04.10.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 20:57:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MEDIATEK USB3 DRD IP DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: mtu3: allocate phys with ssusb
Date: Fri, 10 Apr 2026 20:57:31 -0700
Message-ID: <20260411035731.163580-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations. Allows removal of a
pointless branch. A size of 0 means phys are not allocated.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/mtu3/mtu3.h      |  2 +-
 drivers/usb/mtu3/mtu3_plat.c | 18 ++++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index ba5a63669e5f..d71849388602 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -252,7 +252,6 @@ struct ssusb_mtk {
 	struct mtu3 *u3d;
 	void __iomem *mac_base;
 	void __iomem *ippc_base;
-	struct phy **phys;
 	int num_phys;
 	int wakeup_irq;
 	/* common power & clock */
@@ -272,6 +271,7 @@ struct ssusb_mtk {
 	struct regmap *uwk;
 	u32 uwk_reg_base;
 	u32 uwk_vers;
+	struct phy *phys[] __counted_by(num_phys);
 };
 
 /**
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index cc8a864dbd63..11a919fc3d47 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -240,17 +240,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	if (ret)
 		return ret;
 
-	ssusb->num_phys = of_count_phandle_with_args(node,
-			"phys", "#phy-cells");
-	if (ssusb->num_phys > 0) {
-		ssusb->phys = devm_kcalloc(dev, ssusb->num_phys,
-					sizeof(*ssusb->phys), GFP_KERNEL);
-		if (!ssusb->phys)
-			return -ENOMEM;
-	} else {
-		ssusb->num_phys = 0;
-	}
-
 	for (i = 0; i < ssusb->num_phys; i++) {
 		ssusb->phys[i] = devm_of_phy_get_by_index(dev, node, i);
 		if (IS_ERR(ssusb->phys[i])) {
@@ -330,12 +319,17 @@ static int mtu3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ssusb_mtk *ssusb;
 	int ret = -ENOMEM;
+	int num_phys;
 
+	num_phys = of_count_phandle_with_args(dev->of_node,
+			"phys", "#phy-cells");
 	/* all elements are set to ZERO as default value */
-	ssusb = devm_kzalloc(dev, sizeof(*ssusb), GFP_KERNEL);
+	ssusb = devm_kzalloc(dev, struct_size(ssusb, phys, num_phys), GFP_KERNEL);
 	if (!ssusb)
 		return -ENOMEM;
 
+	ssusb->num_phys = num_phys;
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(dev, "No suitable DMA config available\n");
-- 
2.53.0

