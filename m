Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CF388E60
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558743; cv=none; b=Dql2LbD5P1tvZDSPHCEDef4dxEkKgPFXysO7IonyrwnUVR2zmfIqFiLpVkb0wSP8MFatZYOZ+Yo0o0LViJ0dyiXW0Mrb/i/nQJXlH013sVc/Lbrf9YfXUmAXMmG9dz7WT+PM1ynV5N8pvjd4r0O8YStEwa+500/h7Zp8/xliTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558743; c=relaxed/simple;
	bh=rTLBDaSga+MQBJLhrQNgK67Sf/HknFOfOekcNXvWzNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbWluVWmBvooElAk4ZVLHwPZ0rvj+lZw6i+InMGG9iyF5XjWAT1Bj+z7+d2+HLubv7d4occkgPycfCICyu5P0Px74UDi50MIXdHNU03h+a6TLvJpK2A3AVE4ncgH2t+3oAx6LdCsPMw95mrN9iLDNuwiRyfMvfNhGpHuwZDAvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRm3bNsj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRm3bNsj"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1474449a34.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786558741; x=1787163541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0TVCaE8Q+34m7ChzAdVqyf9wcVW6q1366258ZKAIuQ=;
        b=XRm3bNsjW/RHLy4Il0NavMm5ANzSaLd7PrXKY/dYKV1VHmPOJpG0ZbeDOjWtlzwKxd
         9nZy1W8Qlzth0gJnTwKa20uSKzmxpIJud5CH1eVDBx1DEJVMfZhgzNxXeT2KJsq+XSVz
         japXVjMTLr4GTef+9P/c7AjBjVIJfwCUaLeHl1ZX0DFjAyLPiZOl7OxPo/AHxafbIj2a
         o5sOi/iO1Wjfwo8dD0oezEXWQ+haGf4GskLk3L6vULM40T0LwrlKbIAPxCj4dbZoxDJj
         vcUVc+7l29ZTfr580oMSnfcoHg7cd2C/bvGoDsNihIOCeTj2g+bm2Wx24+wKCX9S1VTw
         sZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558741; x=1787163541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0TVCaE8Q+34m7ChzAdVqyf9wcVW6q1366258ZKAIuQ=;
        b=sUgAufuGrNvLmMFD1Hs/ue+nNRh+wsAeRUB7qlzGSHNMNk72Z7cXT9Hjij03MdloQX
         CG7Y+PSI7nv2XPgIWLiPkcfQrZTsx3vcL568xZE+isPU0+cmUUz7OxuORloyf0/fAmY6
         gJTQGKoT2cnZe57aDbKOPjWA35UfiI7TLgFup51ieuvz2PPcCWW/bLR0MglSsYJICk6N
         ZSMQYc8Ob0IjlXu7RuWtdZbhK1UOo4RJ/rkE8yJg50PpZTrQH4/UeiJsAfYFc1V9wHI6
         GJKPK0eetnWFp12KPzG9aMsvo50q8fe+gVNCeY5k/4ndVy0S3JZWLwSIXWWT/MDf2epM
         k+QA==
X-Forwarded-Encrypted: i=1; AHgh+RpGrou0fIqgGJnQwS41zjgabtNRiuS38TVcYnRl1samQImB9xpSyT4tCKGqUTCxkm2Y3WYtMzeJAdF5eE6gVJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+gZITt/JfW1C04ixu8vndINxu4k4BKjkRq+QbDz8Z3ach2oE
	+HWWpzH6Cl/PeQUxy0t+NDubSMqJWP3CtVb/8A9x8v2Nia5gy0JLgeTG
X-Gm-Gg: AR+sD11Bg8+V9X83A8+DSTC1aV5/RP6gMnLEAgiBobr4jdwz2XE2diVmuAX0mxKMOH8
	znMoWl8z7JvnoKF/BKYjzfH4ctW/WUDfu7+kaoS5UoJehzxr1xyLZh62Rafi1bakYnRxbvHX+UB
	joEM4AnwnYDeD0KpWP/u/+CR7VCq0/oKR7puYCSNBm84TUeVUQPDPdQLtz0+S1eqX+AGMNsba60
	SXr3Thr7nMKCwDoeB+xUVZ92BPozdXhqrVAMLQ7o3Bi2Q6qCyNm9RmCFaLkLQaQH/KZiMSzIFRT
	bCpOtGoUW9uam+hBPQG9noBVCk7AgGzCHwMguNs4UkqljPjoT6NedmHfZKvOeEBMdSRlh6Mg4NN
	X01NAuQ7KELQnX/r2CTRzNB1luDrT8lCTq4+OmV6fEVEmMoQA/JixvOYwmDdjN6ur2pEc9C55uI
	m9fSUYKJA9xrUfpV9L/27kd2sSppqQAs6YsuCL9C6BYr308FzUEY9x0FLbkOcSPNSY+QAlEXoyp
	mK8mIFH6sWWBZFd925jqlTvgidlV7+VsI10Ho3oSiuf8fcPNqmzDQlKNNkLlaRwIs8BvnW1W8sn
	as2m+NZw/Ln/vFBueomUQCd2AaLtdkcZ4ajxUQ==
X-Received: by 2002:a05:6830:828d:b0:7e6:f582:955e with SMTP id 46e09a7af769-7f3b79a016dmr6963465a34.10.1786558740714;
        Wed, 12 Aug 2026 11:19:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3420373sm3589768a34.19.2026.08.12.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:19:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek USB3 PHY DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek USB3 PHY DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] phy: mediatek: tphy: simplify main allocation
Date: Wed, 12 Aug 2026 11:18:57 -0700
Message-ID: <20260812181857.64544-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to replace kzalloc + kcalloc with a single
kzalloc.

Shuffled some code around as __counted_by requires the counting variable
to be assigned first.

Removed NULL check from of_get_match_data as it's never NULL per the
device table.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add back NULL check
 drivers/phy/mediatek/phy-mtk-tphy.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index acf506529507..e9b9e667b319 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -340,10 +340,10 @@ struct mtk_tphy {
 	struct device *dev;
 	void __iomem *sif_base;	/* only shared sif */
 	const struct mtk_phy_pdata *pdata;
-	struct mtk_phy_instance **phys;
-	int nphys;
 	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
 	int src_coef; /* coefficient for slew rate calibrate */
+	int nphys;
+	struct mtk_phy_instance *phys[] __counted_by(nphys);
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -1572,22 +1572,19 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	struct mtk_tphy *tphy;
 	struct resource res;
 	int port, ret;
+	size_t nphys;
 
-	tphy = devm_kzalloc(dev, sizeof(*tphy), GFP_KERNEL);
+	nphys = of_get_child_count(np);
+	tphy = devm_kzalloc(dev, struct_size(tphy, phys, nphys), GFP_KERNEL);
 	if (!tphy)
 		return -ENOMEM;
 
+	tphy->nphys = nphys;
+	tphy->dev = dev;
 	tphy->pdata = of_device_get_match_data(dev);
 	if (!tphy->pdata)
 		return -EINVAL;
 
-	tphy->nphys = of_get_child_count(np);
-	tphy->phys = devm_kcalloc(dev, tphy->nphys,
-				       sizeof(*tphy->phys), GFP_KERNEL);
-	if (!tphy->phys)
-		return -ENOMEM;
-
-	tphy->dev = dev;
 	platform_set_drvdata(pdev, tphy);
 
 	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.55.0

