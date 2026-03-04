Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B937AA70
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665614; cv=none; b=aJXyMsq1dFaee/MPT/C3j5FMLEv3Fo+XsHZjEu9pzJCiv3HCYHpNoyc/uU+rzvSdqeUZ4r5PB0bGQRC+eOD8r2G8za0YqYDAzgLF2VaFigR2fOFQbc52zomySB+td7wgeJL8G1tPXYRHpV5ypMY2NJScZd8Wksq98RfVLwWNLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665614; c=relaxed/simple;
	bh=3mXMuLOxk8zLGokqx2S/V/n1q9jDGACUh/JO53uci0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jtfi7bNrvvB4QpKyNSXclpaLwK4x6wFE6XEsWCTMEFnhCXT07zy40FToBl26e9rhy5T3mB2PyJp9xx91cfdfxXFvzroGexr9l/5wEs07pqgyzQsj7h059YQz7XsvjPraeQI6lf9h2duSDwZVrEKKpQzx81QqJrM4x7fGmFPRom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJRyUQDc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJRyUQDc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82985f42664so34767b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772665613; x=1773270413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nuwkc66SGtvVybuj3enJtzvT05yj+40BgPg9Oazhc0c=;
        b=bJRyUQDcBdGxL7RSsjLNAesCp28oZ/y18Gd4lwjtPe4naNgZ2hiDmdUEKxXIBFZznb
         yP4rki6uuEdCz+QlzgAvs/Hy7wCKooQDb8S+Ogyrb3D3HgOcYlJb9tW+nhbei9jGkJRu
         o3ZkD6mgUdiPlhciwdpttLSUGr1+b9r9s4IwlJp4Sd9IRUoIRi884r/CaM4XASm2mlpm
         R//mg0/TmpHHYqXq7kZ92qpCPfoFRXVsZUYe1ZWqRU4j5dpwC2F0cFKWymfw03rdl4SQ
         dhTeAZ65yaB3AnUwGQleJe4ljS+RfFTD7pOHFNmTYC9czFYZwfc+wVzgn2Xy9miEjXvs
         OuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665613; x=1773270413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nuwkc66SGtvVybuj3enJtzvT05yj+40BgPg9Oazhc0c=;
        b=R6L1G52YNRhFkzV44gqQJAzJXVOaOyK4SDJk3vgpA043v1DNDukeBiKtWy2jxpCQjZ
         EDMG8N7woFrUPWXVZg5dMQlgwofw5iyUnuyfoZTkmlUBh1Ib4llY19Bl3UemDRaX6O8H
         aDRshsQm5jsIZurcE6A+UFUfVI0CKFeRHRMYhk3EOCvtc7EUAFXJaJtzxkQ/IX+kB9S1
         YbqGzKYnnNDV1ydP3Y9T2Lr/dyARRiQnB9xHw109hsqgg52cfE0cnCGlyHYpbQpPZZLw
         kn3CNqYWTsQE4mQJwPn9tte2Sv4QIwcDt48yfpAHSGyJnF9VJojIX2h9E+mgUQMZIdvA
         zxbw==
X-Forwarded-Encrypted: i=1; AJvYcCVfAAlZrqFgzbthZlra3Q/7KriFODrgVTy1nWFoDXfU21i3UAjNDiibNZWbhx9PJqxm8fTEVHPDiJ15wBGAvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Si34YtgRnGJBBK7iUrZVXUtX191n6bYlJSTjlh1IAaDN2jwI
	fUmVOCkpYdaMoDMPZi3HLG0rjVAG4sYXjwVz/Fcmi7SmBjy2boJS+/zhsp+LqXA4Fd8=
X-Gm-Gg: ATEYQzyNYbHxaF7xdOFHVS5FsIcIOkwMX7VWM8rJONNneqN+sO/APpksJeRiYpSR+8D
	eAeZWW0/XawengjmyZPveIn8aU/nywn9ViqA8Ab7sP5ZUhDgGU8Er95X1GZpn0k6VAXEIfpREDp
	XU7FRxVEJ/Yn9E876QBxFTHUfWoVKoLZZB1tFyyOGgijZWK2VgezFO2kcFn5jOt5Szx039FTMpb
	xPQa+JrdqU+1zPt7JylVxWlnFjMkzD9hsHk4ey0LYq8ZBB4q3qZwyr/206VquMfHjFIgxLPVY1Y
	Vw6WgJZhxCbwFp6IhaW1topwWs80cKG+UvyChaLvomfJXx4j4RmlmGKwFMuJY55LQI6UQMIGmkc
	P/PECoBf2zMV9aFnPAhFAYDZwGvsymhMoCQPIwk2gbzofWLRUwNuYkY96iKUtl3nZj2o/XQBiC+
	KozQSI+Rdi41/JSnU8Gz06Q/SWo6hRGnwq0dMgSKv9hW/3hLzv5FFt+Q==
X-Received: by 2002:a05:6a00:94c5:b0:81f:3c77:a24c with SMTP id d2e1a72fcca58-82972d5395amr2252997b3a.66.1772665613175;
        Wed, 04 Mar 2026 15:06:53 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8805esm20511087b3a.16.2026.03.04.15.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:06:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] phy: qualcomm: usb-hs-28nm: use flex array
Date: Wed,  4 Mar 2026 15:06:36 -0800
Message-ID: <20260304230636.27808-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying allocation to a single kzalloc call.

Also allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
index a52a9bf13b75..b2ea038a8f25 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
@@ -56,13 +56,13 @@ struct hsphy_data {
 
 struct hsphy_priv {
 	void __iomem *base;
-	struct clk_bulk_data *clks;
 	int num_clks;
 	struct reset_control *phy_reset;
 	struct reset_control *por_reset;
 	struct regulator_bulk_data vregs[VREG_NUM];
 	const struct hsphy_data *data;
 	enum phy_mode mode;
+	struct clk_bulk_data clks[] __counted_by(num_clks);
 };
 
 static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
@@ -309,23 +309,21 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct hsphy_priv *priv;
 	struct phy *phy;
+	size_t size;
 	int ret;
 	int i;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	size = ARRAY_SIZE(qcom_snps_hsphy_clks);
+	priv = devm_kzalloc(dev, struct_size(priv, clks, size), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_clks = size;
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->num_clks = ARRAY_SIZE(qcom_snps_hsphy_clks);
-	priv->clks = devm_kcalloc(dev, priv->num_clks, sizeof(*priv->clks),
-				  GFP_KERNEL);
-	if (!priv->clks)
-		return -ENOMEM;
-
 	for (i = 0; i < priv->num_clks; i++)
 		priv->clks[i].id = qcom_snps_hsphy_clks[i];
 
-- 
2.53.0

