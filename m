Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5F341AD6
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116194; cv=none; b=u1MX0GvrQoltRCBkKlbYa4sQ/RS7+X6nN15mWnjqbNo+S3bnHRYooDaFO9keUvQCS8zLeN7qGAFlWA/0uWF+lDHc9VMicgRojeKVwXAgjkHbG20razFoBakQhSzAObgMvhjn2eN/i6v0peVEapILQu94b569BzgVPX6sNLs2TC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116194; c=relaxed/simple;
	bh=5VkVa/bfQQlD4FNDyJGe3VFIzh2ZdEhPVb+nD/ImeDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaKZMdUbmlcW150DUC+beZJgAoI7SkQNtHJMmdzsdw0n9Cc0Rh2dN7KWOhbbXLM+dN6sdK9hFIlfzgXs5Hwigx3deFiKw3tNzS1IKCAvLBJut4pSrvXjtEcIPIQTI8bJ8sSlz4U5QlSTYyciKWHJHn4oJlBPGugAFRxakJNJCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmTVknSK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmTVknSK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c82538b6b0so7308555ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783116191; x=1783720991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TiflaSmlDHD5QUweyOWTNN1cwlytjiZ+cyZbaPXtE4=;
        b=RmTVknSKKitbY5ap6hXuc3iM81A1D/wuqulP6whzjopM5dArDZxo1NGH+m7JJaXo0u
         z73Dv8OXTZaOwGAR/l3UPH7BBFBqJU0amQYUdF4QyzGwSXgDFmuJkjgbRV4wRhNrRVR/
         M660Ni3Ur4S3YXXk7DXerp212jz6HNl8p5WiAsGun6KQOQwYj824GovLrpzx5dYl5A2z
         byNbh8PHk6k7KaOHMcwItnXAG8LvML+UGr45TQPMnjwXEgqstXVKL5v8BXsgB/cl3q7n
         tZSMBgSkjUtTL3qhksio7c2MtrcyhQDMGvSUoiN4E5BZH2fuCs20TDZQFsllixjfTj7P
         CJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783116191; x=1783720991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TiflaSmlDHD5QUweyOWTNN1cwlytjiZ+cyZbaPXtE4=;
        b=eGICW8uqn/S/9v9eygWvl3Srzohw4kR8Fj7+oTPF1nmf6LVxzwYpyNWJaSaXp6QnJA
         /5+pYP5sCLoDgMJ20O/JkOVnYb6ESpYD7F8n6BgTB6nhGwk/O1K3lF35ER7vM/b01118
         ozpyjSDCMrsWyxRLCZ4bcY/4SBJrSs+NgzXS3OWhrW7fclvl6LTdmHfqaDjcm/buPEyk
         D/0UUme1y3KXugoDaqpDGAE9bctD9P9ghHttgLyUxTY9N0qfJPqnSJF37uJjc1tFIkk9
         IT6iEKheA0lAANSszfOS3+kMlw8QO6B5H7+pGsun0tcckbpu4ceXvPBSnM8Jt92Kecax
         a5PA==
X-Forwarded-Encrypted: i=1; AHgh+RrO+hxEzYZ4amGbltz39Cd6+hV3+fHkyWA6/6iSa8druPLG1DkKYdPG2kW1fOnfi9l7c1D8poHSuOEDkCA8gOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZrh+c+x1+/G+HkuZAVLRKOpLn2G7jS0E4WT7PwRSUb0eNNGv
	ufQqxyNhWd7KMsYF9xsvMkptq6xIBA6BUmrQzgevLHAx7OscnznRxGRLxMgr3w==
X-Gm-Gg: AfdE7cngOyasceartMBaHxiS3kDbN+CPCDakjzGG0ztjHVrGAAQHcRcNbLNsR8ApFae
	1isfQBKas5tNhb45DBp8vmoa1trpT9fuQVXdDf7HoOxyEy5in5xzbD7U25/K/Z9DoIdb8/HFNDH
	jM2i4LP+Oy7iCL+YEzYPKgUQaSJSByBLh0ilWNLnfoAj/hcQPtAjQZVp55UwH4oo1BfwDRL/HsK
	qQcsrEtayWsekjZCNHizmiu34fyRj9c14siYfRYNw84OGNrPtkAgamlrXzUNreHIigncVguaT+8
	Cr0m8s7mugSQ3oK+XlN63+KRfudJJD2TvoTFdiPeHL8vsiPyvTjlTZHUhudN3m+aR2b5N2008RQ
	xA8XoPJXhgXMBUgoRMWKv/KRQ4ESAlFTU0AOniN6Xyo4MQPgfIFXFOjWQJXdcrg3rlY68Xhljo0
	v2YOJ1m6ugaTtba1+brxcJm4E/0yUdcP2Zcu6/Kq+VjVY2GBZYi/kqpW84R5qDyzKyqsfOD8OCz
	RLF4oA+BA==
X-Received: by 2002:a17:903:3bcb:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cbb9ec70a6mr8823645ad.35.1783116190489;
        Fri, 03 Jul 2026 15:03:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad77657cbsm14598455ad.47.2026.07.03.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 15:03:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MEDIATEK USB3 DRD IP DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] usb: mtu3: allocate phys with ssusb
Date: Fri,  3 Jul 2026 15:03:08 -0700
Message-ID: <20260703220308.294247-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations. Slightly more
efficient to have a single allocation like this.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add max() call to prevent negative values.
 drivers/usb/mtu3/mtu3.h      |  2 +-
 drivers/usb/mtu3/mtu3_plat.c | 19 +++++++------------
 2 files changed, 8 insertions(+), 13 deletions(-)

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
index cc8a864dbd63..afb01b76e1d7 100644
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
@@ -330,12 +319,18 @@ static int mtu3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ssusb_mtk *ssusb;
 	int ret = -ENOMEM;
+	int num_phys;
 
+	num_phys = of_count_phandle_with_args(dev->of_node,
+			"phys", "#phy-cells");
+	num_phys = max(0, num_phys);
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
2.55.0

