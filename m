Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE62741C9
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096745; cv=none; b=RVzQr2odsROnV7qrYktAMLsyHza9LpPeQGBBbeiwOH32ARzOSZDekPKS0I7+XAyV7eDcMk4OBOijFH/PXsuOifuhCNwOCPu0kasKlFnJOmuXnoP7PSyvc33nuRGwrfuwj0NEUkUYZSR2Pg1xGBMap8q3tSnOSM89S1Pg10aejGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096745; c=relaxed/simple;
	bh=wunlnXvfKir7qarnlHXULFM+eClI1QtYhLLNER2o0LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMENdgMu+QJ8Kff5SZUAkD10Qat6tD7FHIGS65YIGAS0rTURlq4GwK6veGZ2OrieyhdC/AfzTw3pVT5W2t4Eg13AoH8677vVysE8vPaAMe46jJlpdZgWsSNxGcgxFd9bWeSPv7R8xQRA1JiJb21HA8QuQM6VhgbqRRQ3RpRWV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inccpL0n; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inccpL0n"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73bb6662d8so313580a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096743; x=1773701543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FJ2CJKqK7GJP8XEN8e6DlV2Ycki4IQq2ehkokeaIAs=;
        b=inccpL0nD79wSXFhhmR8RCnEbA4hjnp5Uv3KweA6IODBJus3i4h7OMLTv6xoK9+Mwy
         Hnp4aPq+ZuSR7ohASCLpJzeg+oyUqGwD5u9iR8SXaGs6i7NJh5Hg0pgySkwSJis4kx79
         jQPkOyFdJwctlbkXEdiyuXtdjWasyFhkC5KarI/V4pBZ9b1te2zJrqlQDE2QQg+BTO5v
         KtLp+7kj7itkHHmYAcUYJRNkjfGrlnFixnGGejE7gv9IVyGfq129Mg0kK6L8zHrPCPd2
         NQjJgwAzUeV4z1JkzCFxXyVUauECQTL4Wz3lsYspeRPjSKIC/8Z55GxczD2rmHW4WS1H
         KuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096743; x=1773701543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FJ2CJKqK7GJP8XEN8e6DlV2Ycki4IQq2ehkokeaIAs=;
        b=mROqpQVaEU3nkArldzsIpxHCNgrY156Q+hbni/MIvaSKw2s47hAvT30YTQqIsASll5
         Czbdq5Z6udCPBUGlXH1jaEdMqBcdq1w/fbGy02X5GaQ9UzPLeYTju+sW3HCUE9XcmLjC
         QVBKo0SJosvdn/nUEdmxe+XjM9h1Iq3pjV39xK5KtjVehQWv7KUVZO1tIDP2qJQ2p3JV
         /kjvhJiictTDsy4VlrvPXBx2W8IfXK2FfTvcmmprGVWavBFMMVekKaU73HLggAwWU735
         byRmVysKFTJQOJv4wwvtVwHjcWjJc96IuStFzAfEfUqUEQ6/BK26yybCT4JTGcMQdfSj
         jUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHVz2PsRpJ2fnpqrogmB7mEqExw5MUuict6JBs7x5WTrHxvZl74VVebgxnx24GWWs0b3s+jBDKafVx5eA5dpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPCmsMtVb65oaz1x6/IBOhLsWNEmghm2YfxjzljUNzUDz/kAA
	zUx6JwM/U/w4+maW8tS1bVtYE4T+mvj7YrYYmJTGipBDPuxotXDWdkgQ86DXHiB8f3s=
X-Gm-Gg: ATEYQzzsUN2h1w/y6/Nb904t8EnGIvOr/ZtGCFDtAc7fhKe3VHJN3/BMCxBwwkpspG1
	ueLGGMUnn/KScGnGIO3RunDU/BAHPGk3u4zQKO/MCGnEL6+UDH7qnhG+cEMayO9BKoJNv5d74JB
	fzlzS12OvtjwLb05aIJORhM2lyu1JCyEVQuXdSG4RRa12jCfzYjdYQfh8vwGKIr3DJ7PDt+DiTW
	BLisdP6Bk8ChDnhWHyugUNCunxTm0it5iKC9fAcnvaaFhof1hmLcEYMbpruXka0gySGz6Zh2trx
	H77ujZWLcMsFiw6MnLxKvYjdOX4AR2O880KG+sQqBCbrUNl51uXSwch2QncHVPqy3H1jGhF264U
	SFsgxs8Dgh8qlxNIsjET+dwZ7QlSq8Vv8g4fZ4iw1QRt+BVKhUtJ9Vg16rBiZnk2QBe/zFb2yDS
	dbNN1LY66HPDT7KYvxfuEkfPil+e5pIkuh5JFWTTeiMqzT581RIRIR3Q==
X-Received: by 2002:a17:902:cf08:b0:2ad:ad0f:bbc3 with SMTP id d9443c01a7336-2ae824dd271mr128790305ad.33.1773096743046;
        Mon, 09 Mar 2026 15:52:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9ad26sm163029705ad.28.2026.03.09.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:52:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpio: htc-egpio: allocate irq with the main struct
Date: Mon,  9 Mar 2026 15:52:04 -0700
Message-ID: <20260309225204.44789-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combinwe allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-htc-egpio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-htc-egpio.c b/drivers/gpio/gpio-htc-egpio.c
index 72935d6dbebf..d15423c718d0 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -46,8 +46,8 @@ struct egpio_info {
 	uint              chained_irq;
 
 	/* egpio info */
-	struct egpio_chip *chip;
 	int               nchips;
+	struct egpio_chip chip[] __counted_by(nchips);
 };
 
 static inline void egpio_writew(u16 value, struct egpio_info *ei, int reg)
@@ -270,10 +270,12 @@ static int __init egpio_probe(struct platform_device *pdev)
 	int               i;
 
 	/* Initialize ei data structure. */
-	ei = devm_kzalloc(&pdev->dev, sizeof(*ei), GFP_KERNEL);
+	ei = devm_kzalloc(&pdev->dev, struct_size(ei, chip, pdata->num_chips), GFP_KERNEL);
 	if (!ei)
 		return -ENOMEM;
 
+	ei->nchips = pdata->num_chips;
+
 	spin_lock_init(&ei->lock);
 
 	/* Find chained irq */
@@ -302,13 +304,6 @@ static int __init egpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ei);
 
-	ei->nchips = pdata->num_chips;
-	ei->chip = devm_kcalloc(&pdev->dev,
-				ei->nchips, sizeof(struct egpio_chip),
-				GFP_KERNEL);
-	if (!ei->chip)
-		return -ENOMEM;
-
 	for (i = 0; i < ei->nchips; i++) {
 		ei->chip[i].reg_start = pdata->chip[i].reg_start;
 		ei->chip[i].cached_values = pdata->chip[i].initial_values;
-- 
2.53.0

