Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10834E774
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502948; cv=none; b=o9s3Q43wBv0Z1T69hn6qdgIbOkbGkUuw8sw6Q1bUxIjOh5D7GhOOFB6cbWoq3R2OPNxwFOhYYLkCkVFdrfY7qlEFFcw1fpOCJnjmJgQ30vMoqiK5JPqEHFiBYN6OGss9PmaZnSMDk/TOhujB/hMbrVGsvfD4qbzE58Hy+pjYixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502948; c=relaxed/simple;
	bh=secipyXIFe5nKwWxQDiFSflV2qpjNZ5UEC68A4oj4Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InApoQ4udFXEv+PTBCu83tBWR0TNzthWSLw9wZExP2sXVRv9wm5MqmdgifR9LCQbcsWO2Q5i6xeF739gMTh8dvDnh2VRQjg9qKJcqUX0NWsi2MoXM7qjcOK9lILQYXRAJSHvQesDT/NbeGPmelCPl4zdDVp7OwwhHtG7gotdU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6bZ2JnX; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6bZ2JnX"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so763014c88.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502945; x=1775107745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vj6+CrB7XzZSSoo0WZkVvcXGudvkrxFD+q5udVvUfM=;
        b=p6bZ2JnXNd4sm6qbImZEFNPmdgt66hyqPEyJeXFTyU4Co453P3A6RG4DJPqbpeQhll
         erdbi5Bjz9cKF7xCs549PhIMuugTPZ2zWAEFrH/NyoFXGbeQkhawfsRBAG8Gqd7WJ7ty
         0QS8L4pK9MTUBBSW2zvBQMtt6sxSdiQKkhZHrMCK8fA9gzcu6NG75SdPKPgU3eeAD4kG
         E9Kfhn9WRiIuuy1gOv4RUtMN22R+yn1wKa8Lh7qKNb79v1HR8RmV1xiOC+6JUA6W8m5V
         LeSZbehPnMDa/HtyASPf89d+o+3snYH319+ODoxKiMxzjNQtbIVzlRj7w3OfPKCvKgxs
         TfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502945; x=1775107745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vj6+CrB7XzZSSoo0WZkVvcXGudvkrxFD+q5udVvUfM=;
        b=M/kV4yC3c485OBCh0f3ux5qSl96Z9HuPjlFoanfr957ACNW5EA2ZaID1SnPfccP7RH
         a7r2RyuVHIq9SvUpYeob0oDRJaY63Cm15pkiQD1c2mqj55CMwbc1NVj1HvLRqxaeGvZ5
         v2En1NZqYxSzIFmQVfj5iSxseojGRApKxJRLS9o+6+5zCND6EBbOxfDJLf7OWzWkjc2d
         Mqes0hDSPuUD6iDAnZRp0y5p6fJUgAR8aAcJQb+DEhE6PlwZZ8q0+6LZylWnuYQk04YG
         Tso55HGSm6t9LTeI21wLVnDc3ppwMDuNmZUHHyjSf7kuDTgiuAxMg0awQPmpF1+PgtNE
         dg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4jBp65exzlCmzdVfOQVhrCq6Q5fjx40ruLokmv56p8lVdNMhYHYqrwSQjF4nvtB0RbMekt6MvWg8zfhdIEdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmq4l1hMrrlQlV+OGKfdY4Q+FDhLseanKJHx/NsUZxLa5nV8B5
	lnpC+NVhKO+PXpnDAH8lIGM0ZiubE5mDzM/zqF4XQApYD5DOX/zfym5T
X-Gm-Gg: ATEYQzwznab/HOwIIgCdzKb3ghI+0tm/Yk+DTf16g+g4KkFxaA60OG0w5N8sEKq7ZBf
	WXowGoNiwNRwOIcJy8kyuLvcyljYb+oZr9yZZ5B1o7WgFgnCBw+qNn+M/E9OBrVK1gD9h3tndS1
	eSwEWwGcydTQQdUpXrsoObvFPYeoit95jffF0MWBT3dl8PPtcJJTBJGCNPON7ZnjBU8kAjgNGxd
	JeQcw0ux+AUdGdoC7f0HnzLtbTbYSnLclPRCxqj+qznYiCXKkqFm76vGiug7ryHC+ezsbYVbpnn
	2W5ZRRfTaq7RS6J19QThvqtncmEvgEZcHelngTQsyjL06CHhecO5X40/a0AlwFIfNzymKvV3BCY
	4/HUqn1YPwke0Z0ZWIlweZqc1SoDM6eD8BohTzndsJxVSK/DnHXCKgrwSVnser00kUYlXvWsZJz
	uFpN3hLjnLT/8HPHNa4Me9wNSWDGBv2Huv9rQDx2yItlZjvPME4922vmA=
X-Received: by 2002:a05:7022:ec86:b0:128:bae0:e044 with SMTP id a92af1059eb24-12a96ee7565mr3175255c88.30.1774502945123;
        Wed, 25 Mar 2026 22:29:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa78462fesm3013681c88.15.2026.03.25.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:29:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BO...),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: clk-max77686: kzalloc + kcalloc to kzalloc
Date: Wed, 25 Mar 2026 22:28:47 -0700
Message-ID: <20260326052847.335089-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member to combine
allocations. Use struct_size to calculate size properly.

Use __counted_by to get extra runtime analysis. Assign counting variable
right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/clk-max77686.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 3727d5472450..9149ce4f702d 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -47,8 +47,8 @@ struct max77686_clk_init_data {
 
 struct max77686_clk_driver_data {
 	enum max77686_chip_name chip;
-	struct max77686_clk_init_data *max_clk_data;
 	size_t num_clks;
+	struct max77686_clk_init_data max_clk_data[] __counted_by(num_clks);
 };
 
 static const struct
@@ -168,19 +168,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int i, ret, num_clks;
 
-	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
-	if (!drv_data)
-		return -ENOMEM;
-
-	regmap = dev_get_regmap(parent, NULL);
-	if (!regmap) {
-		dev_err(dev, "Failed to get rtc regmap\n");
-		return -ENODEV;
-	}
-
-	drv_data->chip = id->driver_data;
-
-	switch (drv_data->chip) {
+	switch (id->driver_data) {
 	case CHIP_MAX77686:
 		num_clks = MAX77686_CLKS_NUM;
 		hw_clks = max77686_hw_clks_info;
@@ -201,13 +189,19 @@ static int max77686_clk_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	drv_data->num_clks = num_clks;
-	drv_data->max_clk_data = devm_kcalloc(dev, num_clks,
-					      sizeof(*drv_data->max_clk_data),
-					      GFP_KERNEL);
-	if (!drv_data->max_clk_data)
+	drv_data = devm_kzalloc(dev, struct_size(drv_data, max_clk_data, num_clks), GFP_KERNEL);
+	if (!drv_data)
 		return -ENOMEM;
 
+	drv_data->num_clks = num_clks;
+	drv_data->chip = id->driver_data;
+
+	regmap = dev_get_regmap(parent, NULL);
+	if (!regmap) {
+		dev_err(dev, "Failed to get rtc regmap\n");
+		return -ENODEV;
+	}
+
 	for (i = 0; i < num_clks; i++) {
 		struct max77686_clk_init_data *max_clk_data;
 		const char *clk_name;
-- 
2.53.0

