Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331B36D9E3
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666948; cv=none; b=SKTCJrcePX2T0REphPjTXwU2VVIPYoKsuv2WSNj5JLVwCI0W/9Ik/quaF6InUCYREum6gSNmfkcE7YhxJ06OQy3XAYarIQMJKV9XMOLcjlfG418OOAx9Qx6ydM5iWSajTBCKD6sYa28yBhRQ0e8p3xZpUU8AKmdrAisvlGn8LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666948; c=relaxed/simple;
	bh=dWpS6Jj/cYoVx+fc55wUQn9g7pSqK+l8aRzH9hsx0YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rc281xq+5tj+UWQaHtf1HgU9hkA5X50aZBrqjIoXPtjGNkvveM4Q4/abqMp8OL5qm1b3bqwyv872/mbNyGqAsq/LzumQx6Nj9Uv8dzpZF29teoJEvfxxa/UAFXeoLwZQl59OzKfSEn3FwqUZIHvdY9hckwpeiFG2fFIEQC3FiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDBiKi86; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDBiKi86"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so7467910b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772666946; x=1773271746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Yf+D04UD++q2u6SPTjJOtp/z2TTx4w7P+/iR0x8sU=;
        b=DDBiKi86lNQ2JaTtjexEcOHyOXJEeaZvwS0rpMs2eWi1VTd2O7V8r+csqpcEY0rT1q
         xmlwlSKnGQS5ohTgKG44WSSB78hEczEh5j9kOxQJF/LmBrHl4IY/n/RwuvRBE54jER0X
         e9LFU/ndGP6TilytjBHYnxhO20fQSFy68U48fanwzUyEdb/VnjZ2qLalOCz9jLvw6uSP
         uFfaHZC2ZybeFkJlOjNmKeFyYPcNEBfOCVwebHUOo8OqG4vfAb9bF9Tzkd6meh18pt4b
         LfzFL+/cjAJOOJ1YKM7v/JdAW9T7SK7gYle8z35HQoAtJXIe7DGqeRkQU9tcMV4AjTXh
         WgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666946; x=1773271746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Yf+D04UD++q2u6SPTjJOtp/z2TTx4w7P+/iR0x8sU=;
        b=K+NuanKT15VmKQaLHpal5hmWINvAO2llSpOEMcRn7cmyKchhtzK72vTU31yiByQSzh
         5jmKxTM/oZBUuNUpmPnKimEOGsEJ8gndd5DDI192xvumac0vvPKLe1L4E9F04Gk+b0Kn
         R6UTasHjmeHadY9TWIyl+GaMKpEGCIWxDOnhdHaaZsIn1HcbjNr9i53P+ZLkAmZPPeHz
         +nl5i4CingwP7QoRzLcZoL1AcVe+fLU03Iukcp9gnjAWRSKCPvGhSV/UVvNfMmzs7IHv
         uqCNzRW5YST0s4WSs5/+QASIbmazxsmojcNkDKv+Yjo9Hxq5Zev8/qYCppPjgZnuouhu
         V8yw==
X-Forwarded-Encrypted: i=1; AJvYcCXUgDlnL3bM/QZsUKJtFD4dkztS5pr4HvUjbnqtw7MWqh7DfrD+YT5gVV8LUZHKQPspwa70Fhv6KUey/rNdPeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweG1yWH020OePi375h2EU5bjLCX58GIibvY7864+KOBxohzuQi
	4Gwfn9ZOBxPQnTFQIjPuIGiHsagsTJBRBhU4TeklStXy1tRqFU/XHfYV
X-Gm-Gg: ATEYQzxerO/h6YAGF/eoM4z0Zdj39F4cczfFqYjkCIsBW3mx0bLzPZWFynzzUBwSdWt
	cpIfubn8JuWBpUpwcUC+SpttKxIzer3UEt78ajXQFMPAavjja5veaTakXfHWw67xi74rW5kJibA
	IwJYP1lWprlFJwTJEkRYPBEFLu/Q/Np5mVcHx1CM3DDVntQ0MdV11HEV5FO8IxP0W+1d63SUbhK
	9I866eGTekRh06KblXOqAl+Un7BFwKU6sSxdN0dWz9TvHPyvbh0EI5s/lzDpSSKZOJ//2KOUgS6
	bkPrV9P4f+kVGIn3GweNHuVat2vNn0+rBYth2ruY/5afDVUw90eSF+C43lj8lpTHjAVTb6jmZHb
	0JqQ9KL7OciliIYPyhZKVby08ZnXBfwATCdoVgyhk5+7LNC572vnTS4R7y4aHgkwbbgjpht+/xc
	1K1TwSTsnKT0ATgdbNHCkS/HnvXiBvOBgtk9SzIspcbf5qLn/lThLXbQ==
X-Received: by 2002:a05:6a00:91e2:b0:829:7553:afbe with SMTP id d2e1a72fcca58-8297553bf5emr2861233b3a.57.1772666946447;
        Wed, 04 Mar 2026 15:29:06 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8296c9f83f3sm2904789b3a.0.2026.03.04.15.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:29:05 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] phy: miphy28lp: kzalloc + kcalloc to single kzalloc
Date: Wed,  4 Mar 2026 15:28:48 -0800
Message-ID: <20260304232848.469446-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use flex array to simplify allocation.

Allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/phy/st/phy-miphy28lp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 43cef89af55e..fd931ede7162 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -224,8 +224,8 @@ struct miphy28lp_dev {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex miphy_mutex;
-	struct miphy28lp_phy **phys;
 	int nphys;
+	struct miphy28lp_phy *phys[] __counted_by(nphys);
 };
 
 enum miphy_sata_gen { SATA_GEN1, SATA_GEN2, SATA_GEN3 };
@@ -1168,16 +1168,14 @@ static int miphy28lp_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct phy *phy;
 	int ret, port = 0;
+	size_t nphys;
 
-	miphy_dev = devm_kzalloc(&pdev->dev, sizeof(*miphy_dev), GFP_KERNEL);
+	nphys = of_get_child_count(np);
+	miphy_dev = devm_kzalloc(&pdev->dev, struct_size(wiphy_dev, phys, nphys) ,GFP_KERNEL);
 	if (!miphy_dev)
 		return -ENOMEM;
 
-	miphy_dev->nphys = of_get_child_count(np);
-	miphy_dev->phys = devm_kcalloc(&pdev->dev, miphy_dev->nphys,
-				       sizeof(*miphy_dev->phys), GFP_KERNEL);
-	if (!miphy_dev->phys)
-		return -ENOMEM;
+	miphy_dev->nphys = nphys;
 
 	miphy_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(miphy_dev->regmap)) {
-- 
2.53.0

