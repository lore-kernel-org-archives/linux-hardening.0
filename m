Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F65352FBD
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597661; cv=none; b=G9cCDQb1qHxKJMzMeMABSwoneMtD0uuaJm5x/GpSsk9NkJwMZpQmt7IOz3QAWskjzL8+IWHDXIOAwk3+YKq/6HNPpmCNQq5JC40eyPuJeMIEdKUsWxcQM0yRfWQEFYtAc7jVHt0LNVtohWdmv33ygaYxDRhldFHr78+wtJKrLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597661; c=relaxed/simple;
	bh=uoSf/yWTQAEcMzTLff+c+Dblvpst/fEZl2MGCo7pz4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZnXUw+nqANt7ng/T7Nks5ohf3Vrw22BAcJmVkm71pB6jwF7D+ImP0GCYjjENh/5JZqXDAMdGHkuxdWm3GoR7QvcgQFmUS+U9lJswhJ/jGpBKh6HXLGFIQ5SpAH9puWizL/sGxKj/q1p53Uq+iXVcIQXEqSEwmuRAd0nDzfuN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjgchP0G; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjgchP0G"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70f5d6a6a4so3709010a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Mar 2026 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772597658; x=1773202458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNQEOfz/uaj72zFc2OfYhyedqZgPJsuVowB3OOH5Yjk=;
        b=PjgchP0G6loX3a8YCvDLYAV0eQXZIg7EYp2gf7JMP3qUXRJPDZ5DOhJOgofGm7gPJO
         9qgUsOlsMFfCL22K6ct/xqLqfHpZdsaRqAKoyDOyplBiJ7AGIhJiz2pSaT/QgCWBANxH
         6hC1QscnDyp9C8bELQuXE/hXtbdEziKQNOusXBqbt4g3kNzwgxUSb6jHv3k5tIr/E6UD
         J7V4lDdgcNr/nT9FvRpxUfOTTWiM22soq+WRaEE4UGMTVng2Z2FWPUwd9Nl8viwlZIQA
         n3r1fje+npA4P0Cf5g3H7x1/pXRjQBLkuFgiwrjcmFEXelJJQDOv7cE0czLqk8Yzpr++
         jIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597658; x=1773202458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNQEOfz/uaj72zFc2OfYhyedqZgPJsuVowB3OOH5Yjk=;
        b=Ba3ognj3mgvoQkXG7HdYTR94xu0TekwbseUN2up2RPi1El1/FM2GoFQg06LH4rp+oc
         OpJigpTB3m1mfg8g2tXCKCj7tkIGgSU95Ma+LEkcIgzVkTt83MObGhTLV9EY0Zq6j7nw
         wkbTc6Ts121nAsgVdUEi294os3RLlhE2W2pezb3tWCuciHRJfyoV6Hokxvu1rdGeXTtS
         uw4M7enoi7WmiXPU10ERp1eJ/XNUUM48WUgo17uGfzdN3i2476qd6/s41LERMh7JA60i
         0SSynkzPHumknoXIkOyModWYOFVXL0usHpkyiIsw0bvFY15r6c3rNUABKG96BZFR1o+n
         xf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUVtjBsL8E0TNtB22fcbngYWpqcA6n/BX9DuV1mY1wiEeHQ7f6DBsBkAkEjOy4cAaCdcQfV4tpHkjFLYu/bdVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFmz1RHuxSjSbyh49sqsnsak3SUwra5m+5Xz2KP3bZpvqWXgp
	rjH6YxeTHmaOLPJhWCxrkM10o7YZLSbgkGWWulGjMlC052rFKcAyBheJ
X-Gm-Gg: ATEYQzxrbBpmBeVg4owP3TRHOaM0Mw79vjeBLnCexuLS+3AihOzjsbD7mP6Aj+x6L2h
	qHUZVXf3d16J11J4GRSVitOHB5mxGXqYDro/mxeCoYO3hZ0xEaiN3FYFAgmZ6YS75YtXE1Bjct3
	S9YWb0fzN40c3dIwLUBCz73FOKIiZcCyNefKaWw2evdEtmGs56JMb0trQcMQ4mM11ydzO1zYJOF
	X20RPKHIriUTBu5hkZeqTr56Ga1xgrhwWIQgegzEZTD6RR9UcNIaTPolYA78v9pJDdRPORe8HsW
	8gmDUzPlYlprOkVG449E438kbIh5ACrB66nNmFW2doG4Ost7mc17xas4skcWayfAViScQkvYQfW
	F6mRXAnkf4QmxsQrWsBOAjbgvAORqHIDU6jMdhKedsFuwxBmApy6H3tHalZ3fyig5wvfsr5gN7Q
	cII6lqD+631fHgHV2fQqwG5SLZc69m8sCedkjDpXHDrz09KHIXJfO/9A==
X-Received: by 2002:a17:902:d50e:b0:2ae:673b:6a3 with SMTP id d9443c01a7336-2ae6ab8e78emr8091365ad.49.1772597658095;
        Tue, 03 Mar 2026 20:14:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm188270585ad.24.2026.03.03.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:14:17 -0800 (PST)
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
Subject: [PATCH] phy: mediatek: tphy: simplify main allocation
Date: Tue,  3 Mar 2026 20:14:00 -0800
Message-ID: <20260304041400.7236-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/phy/mediatek/phy-mtk-tphy.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index acf506529507..3a6d61cf1cd0 100644
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
+	struct mtk_phy_instance *phys[]  __counted_by(nphys);
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -1572,22 +1572,17 @@ static int mtk_tphy_probe(struct platform_device *pdev)
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
-	if (!tphy->pdata)
-		return -EINVAL;
 
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
2.53.0

