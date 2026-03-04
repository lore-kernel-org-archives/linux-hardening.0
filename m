Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7C2C028B
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598881; cv=none; b=g/za0r1IwgaIDv8oUMlwdtK30zrP+h0RzLycki0BMFtY4KCwU1A0pFMoBTbOZPx9/OO62fSaBnx+YiRCvdJ+x7pS/ugAyeY0WqgjJ8pVtvzXbLDCnpKPebe9xGTaEj+5IuGMhegFjvvQbUFfpUJ1keFMnsVeQYVfeCECEn/T/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598881; c=relaxed/simple;
	bh=X+WIB/W8YuPByuWc0i01EfTLZ1hpPln25a3bGKeHO6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuKT8HKuC617PicWtlNPArVWX5EbpVYuGcQJ8i2oyw5tzrMcnZUvNu5EmmfySksl+5yt7we7BUij6004j5gsExGDOE97TNqmw/HFbk5OJamd56L5IaXEmMYc9wS7DUDtUpvJqxhomj8ey7LWLEhOegIlO/4EblLpoef513wwpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3zYi7AT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3zYi7AT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae527552acso10541175ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Mar 2026 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772598879; x=1773203679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4+RxyEzVVfMeQjameS7WuxM58R+fJWfpg/21/ewVWI=;
        b=g3zYi7ATkp3IIiuF58Y+42B+FJOA0iA1APvRRnmsCiHZaA1i1SGt2BKPN0wcWPZLip
         CrUElSXVixsEoKqREgXg42+/ML73uXzy/5V5S3CvbJoFTFCDbPVOAnCNnN6HjAAH0aTQ
         kgSf/yDVKOYcxZbgL1pOu/uj8wAhiWW5paB+l8tm0bxZMtb6flGLpa/p0dE+jJoGszwy
         JSr61S8oT3vjKUKOPdU8Ehr6b5L1N7wUzvzXMazj78dRdRU+7U54JO6xFmMO1NXohw1d
         BFvncA8BRgI5ZA10evVro8lC/k7Uja3KUMnzbFTEr1LZS6FJ2+P/Vg/5TCqXYR9mLOIR
         OqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772598879; x=1773203679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4+RxyEzVVfMeQjameS7WuxM58R+fJWfpg/21/ewVWI=;
        b=IAxi+M8rnZ6gM6igFV2LXKQrVv4xHU/2fBBqI1EdNRQW0AaPAFjSaPjfa4497I0U8X
         saHdvTQC3bUfG42wEsc8RjwfQstlk85YYjYQQCfWBx0WTSGAykN+fW0EFhB/ExrMvkdW
         YiZHTilllnE1iHLKStVnMrNLKdo6OVHctqImWsVuxH8Jiu8v1BJSh/3TTvatKZSR0JIi
         Cxw+kOAQHfEhQaTIyLjgHO1APO9dNnvsx4yOTqb/SbxkF7wJ2yAylPmjUtCdZ5yIb4pm
         zLAe6386YLI3xmKTerpCaJnWtQ2un0uVCjoh8xhbrXW0ouBZn1FENWD6rAgMsJfcqPqT
         IP0w==
X-Forwarded-Encrypted: i=1; AJvYcCUClmLi1S64bjPpxFzzGALtD1OLSQUTxFnsw6WPZxDRTr29J1bZDvZ1Q0nleCJUdGWpUDSIoDoOOd7kcyZOzec=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8qFuqTvs5hee4x1XMGI29E29orCFYPN6eMEXdMG57LctT8zq
	2RpyhJ5lOpSAFTO9SuIZZgyuUNcTPZgyLN8JNEPuYBOcc+bDdvBmGRmT
X-Gm-Gg: ATEYQzx84l0+6AAdzeG1OGjrvySQL7qlvrKq1p0mLMI7GDLt+GkIZSPadL830E2H0GY
	7hA7RfJbllqqZ/B6fR95BqweLbG3PCy2XWYmJg96UbGBZBzyfntJwqkjO1eSMrgnv6i4Y9fhK8K
	ZE2348/2eVdq/3IJ681d+zMVm9NbLk3+2r1KesGmC0dndsawpe5S4o9K50I3z8QQbZWvnKZ7m3i
	2Y4fHNQsymZ2cA6EkKQE2ivhoE2lR/zlp4k7ZXwj+ex7n6VEDKg6Ak7xbO12+z+WyOynzbun4Ts
	8Xid6UzYmIT9mwvDkcjmd9Q0xF07smwktEmmG07s9m9CfDNlvkcjAuVnHD+jacKo0R32TheUrOl
	N6tacF6FIC/qsgavbQ7fJ9BwTduFsADSeuQ5r6nAiCKlXq034m/DLGLtcoWf7DbvS6rBeJhuk0W
	87yGa4jlqHmdy9AOBRwPDjcMMQpGhSXbHbmBVfGDwBQuzkP/0RYmsh8+5u+SURE8Qo
X-Received: by 2002:a17:903:1a67:b0:2ae:57cc:63d7 with SMTP id d9443c01a7336-2ae6a9de1a3mr7732125ad.7.1772598878948;
        Tue, 03 Mar 2026 20:34:38 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm115173435ad.44.2026.03.03.20.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:34:38 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek USB3 PHY DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek USB3 PHY DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] phy: mediatek: xsphy: reduce main allocation
Date: Tue,  3 Mar 2026 20:34:20 -0800
Message-ID: <20260304043420.14151-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of kzalloc and kcalloc, we can use a flex array to reduce to a
single allocation.

Also added __counted_by() for extra possible analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/phy/mediatek/phy-mtk-xsphy.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index c0ddb9273cc3..cc1d66954212 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -112,10 +112,10 @@ struct xsphy_instance {
 struct mtk_xsphy {
 	struct device *dev;
 	void __iomem *glb_base;	/* only shared u3 sif */
-	struct xsphy_instance **phys;
-	int nphys;
 	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
 	int src_coef;    /* coefficient for slew rate calibrate */
+	int nphys;
+	struct xsphy_instance *phys[] __counted_by(nphys);
 };
 
 static void u2_phy_slew_rate_calibrate(struct mtk_xsphy *xsphy,
@@ -515,18 +515,15 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
 	struct resource *glb_res;
 	struct mtk_xsphy *xsphy;
 	struct resource res;
+	size_t nphys;
 	int port;
 
-	xsphy = devm_kzalloc(dev, sizeof(*xsphy), GFP_KERNEL);
+	nphys = of_get_child_count(np);
+	xsphy = devm_kzalloc(dev, struct_size(xsphy, phys, nphys), GFP_KERNEL);
 	if (!xsphy)
 		return -ENOMEM;
 
-	xsphy->nphys = of_get_child_count(np);
-	xsphy->phys = devm_kcalloc(dev, xsphy->nphys,
-				       sizeof(*xsphy->phys), GFP_KERNEL);
-	if (!xsphy->phys)
-		return -ENOMEM;
-
+	xsphy->nphys = nphys;
 	xsphy->dev = dev;
 	platform_set_drvdata(pdev, xsphy);
 
-- 
2.53.0

