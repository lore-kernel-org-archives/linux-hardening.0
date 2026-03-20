Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E624E4C4
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968038; cv=none; b=Um7CyqDoZFhnOZk2OyBRAld9EWMSVLqjPpcehcpEwsi/iS5b1LsGdfpw+cm+41pgJNXe5wZ4a86KbgRq+UEKQ9WetBAqg/IARSmWBDNOCvT0s59UlDEqaPxSNicDl16+JtsMv0s+UlfyetamFi5F1tvReFpC5WTv/uihZoex5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968038; c=relaxed/simple;
	bh=RPdS4yZ4aMDBpjdVYOmpeBtEsGxqKGyrHqi3ViirQf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnS2wTMAF9ygHk9XufMvi2vrJt+RvLMeUhvX/qEIuXyjXYCLEDKV37y35XGR3YrcRaxdcwh/lliSNqE4yoL5rZuxS+V26Cp5KfY6ptCEnbvOZo/3yq0I2bN4bxE1ix2UEHiMzkAe9hTq3dJYLm5/4gnyZmqSa4fUc5oOotvAd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MltemJ5g; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MltemJ5g"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c742882d2a4so37752a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773968037; x=1774572837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAZdaOpK8Tpotf92jIjh2hYipqpzhjyOHEd27w2pfAc=;
        b=MltemJ5gbKKHa0HoB43cnvFFPdGv/1GdmSki69ImFdn3JHvqkH3D54TekvpniIAtZD
         8UWa2MKVk3xwErCmNQgReb7uKR9z8h5DIiE0o8sedgoZ3bibU8k9uB4DkDroVglcYvqp
         qO4JjSEfTi21NmJA0po7+OEH8RDidtD79tLQuM3M3VhJiUXhHLNQI2fmZW8Y2E0e54VK
         U0G0jvQwqGzNu/pfPHW77HOQfqhZBe2CnTUEwP4DW1qaJJZ8G2Yj3YNar6GAkNHnLbCo
         o5/m79LiA2M5sZX+QZ7sXIxoBHXulrhqkXviz5dBZD+TKGGDRqbr1V329xbZyNJOix/Q
         JqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773968037; x=1774572837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAZdaOpK8Tpotf92jIjh2hYipqpzhjyOHEd27w2pfAc=;
        b=c6EJ0loHLK1F9z3h+n2RdEEIHNGnUiajTQrFsSzdypoAXiljNtycCFmnMq5SEm+MiA
         xHpEl8PIjQ2iX9Myz01SBeI9pt6SMNkMiPTIOgxLTPoaVa5xy9TB9s3K8nCrgMBukMJP
         9Fw/CGdeZvTcZrUaGlO8RpVcDk+ix0oSUtbiE/kpuUH1VP+HVlbE5whJ5CAX63g/cLf+
         jdVKwxhE/QuBp9tuBz8aDV/d9SXDrsQu0iXCdWnyr8v34hirnpLIpzmeWDEMCuaMKrxM
         mT/JyY77N5tBtB4gHAiizaU/JBzcfw3gi9ApXFeFfF9XRX0E5tr2M7cmIH4KO5WJ9oU0
         783g==
X-Forwarded-Encrypted: i=1; AJvYcCWGOKJ92bJDnY+54xq6RiM/hwBbrivdY1mAUysnIpC03kp8qEg3R03ZNgXt1X3nUcYZwRG1qU/85UV5D2cBvUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwiTx1e6ZfkXSaOgDGLQneEnE9vsZfXSwIxuDygLjYpPL1KDR
	ih4zOjqEaTVaUM3OLxgtM/1/w1u2oyBdF7gMQGVFpJ27cKBn5OML+k22
X-Gm-Gg: ATEYQzwNDPl5OrtvA6OQRuoRBDBsFiBJ1wDEhxsMDTUbegWVVYc48FBBXAc5snscdtH
	d+RJ9SZQc8HFPKtisNVCuhOTdX4Gjd0vP9BCBldP2WDe1DXHLsKLj4PMgcCbz0xmwBrLmMveTxF
	FgoSuwWclW/xROLqpfXiYyq/OmN5TjJRJyR4n4hJks6prR5uqaJnmSCmVuQZaa5BYW4geVy25s4
	t2DklOV4FQp1swEcyLJsF/sA54xYVJCgH0znWPbtriXoDxEa5GvPEIVaFgoCiaxld8yu6acz8E2
	Ciq44CZTpBgbvgQJDBKQHZXkRRIOHh3ERnYlDgKrkkrXp5alVE6MZ3aS3Wxo1h54JUp6CpCUVJJ
	rDEo+is7IKBGMtsYylmPpO3ttZbvD/XDWRTAiN+hNjXOhtz5KYoQbjz5+JpKfKrM7+pl8C1cD2I
	+XznF3qcIlRm+E7Cc6OUuXF14gNeS90pKad0s91U4VxR1eGBYQGIy6sW4=
X-Received: by 2002:a05:6a20:7d9e:b0:39b:bee4:2954 with SMTP id adf61e73a8af0-39bcec29e21mr1068513637.63.1773968036651;
        Thu, 19 Mar 2026 17:53:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74665ca1f8sm435525a12.20.2026.03.19.17.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:53:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] gpio: dwapb: reduce allocation to single kzalloc
Date: Thu, 19 Mar 2026 17:53:38 -0700
Message-ID: <20260320005338.30355-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of kzalloc + kcalloc, Combine the two using a flexible array
member.

Allows using __counted_by for extra runtime analysis. Move counting
variable to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-dwapb.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 4986c465c9a8..15cebc8b5d66 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -75,8 +75,8 @@ struct dwapb_port_property {
 };
 
 struct dwapb_platform_data {
-	struct dwapb_port_property *properties;
 	unsigned int nports;
+	struct dwapb_port_property properties[] __counted_by(nports);
 };
 
 /* Store GPIO context across system-wide suspend/resume transitions */
@@ -114,11 +114,11 @@ static inline struct dwapb_gpio *to_dwapb_gpio(struct gpio_chip *gc)
 struct dwapb_gpio {
 	struct	device		*dev;
 	void __iomem		*regs;
-	struct dwapb_gpio_port	*ports;
 	unsigned int		nr_ports;
 	unsigned int		flags;
 	struct reset_control	*rst;
 	struct clk_bulk_data	clks[DWAPB_NR_CLOCKS];
+	struct dwapb_gpio_port	ports[] __counted_by(nr_ports);
 };
 
 static inline u32 gpio_reg_v2_convert(unsigned int offset)
@@ -585,14 +585,10 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
 	if (nports == 0)
 		return ERR_PTR(-ENODEV);
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, struct_size(pdata, properties, nports), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->properties = devm_kcalloc(dev, nports, sizeof(*pp), GFP_KERNEL);
-	if (!pdata->properties)
-		return ERR_PTR(-ENOMEM);
-
 	pdata->nports = nports;
 
 	i = 0;
@@ -714,22 +710,17 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	gpio = devm_kzalloc(&pdev->dev, struct_size(gpio, ports, pdata->nports), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	gpio->dev = &pdev->dev;
 	gpio->nr_ports = pdata->nports;
+	gpio->dev = &pdev->dev;
 
 	err = dwapb_get_reset(gpio);
 	if (err)
 		return err;
 
-	gpio->ports = devm_kcalloc(&pdev->dev, gpio->nr_ports,
-				   sizeof(*gpio->ports), GFP_KERNEL);
-	if (!gpio->ports)
-		return -ENOMEM;
-
 	gpio->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->regs))
 		return PTR_ERR(gpio->regs);
-- 
2.53.0

