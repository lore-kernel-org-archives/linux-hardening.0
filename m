Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF921A444
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772935942; cv=none; b=UfhzMTq1Z/MLwyMlR02LmKqfrTKfdjWNrHxSQ10UVPryxlABOtXkmCBmI7kVp89MDqb6QFPuZRtNMpBn/oRivvX8pXgPi2qU757sVM2dDDSGzqxXz5eE/CLz+2STqILE+VRKdYjlb6Y3I0aUF9xgi8OvOLQYmvfa9FcqTYnys/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772935942; c=relaxed/simple;
	bh=U+UrXdwcOfkYlJBQF9thJVz7vlBKSvjiHEDWnXodD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/X1jFO9UKU5cJ50vYswHQ0JBAZ024Iku961mm85DnreoiD1sWMRs1glVJTKFRCBeA1U2LKuwbjMfqEKYV94Z+dp0dVtRyJNs3Rhk7BhXUTchMOg0yKT2iBcxTmJtjOTXY8v8qMTQ6tTs1Brdn222yedFRibBN0q0semfHqDNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChxAJxHc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChxAJxHc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-359832fc558so5603775a91.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 18:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772935940; x=1773540740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r0YKx3cc+gQeQOXY6J4sG6IoXgBr7Vg9n7U1F+VLNI=;
        b=ChxAJxHc2dT1htSXx1+52WT69RiXem53IpfyukLyTtl739RFGIUWlL/DziosbK7ewG
         1jwViYvYUDURMLJXMcJTfdBG87vsTPZu/Un4sBKve5zNPa2iGSQbdK+HwOtLQQ9p4OUF
         mr5HWqkr/OBHNMStFBO3LyuxDUOv5FMMxM02kI7VzYYJHtdqyb3p0iLeMrsVFsdXnSRo
         wyQ8AM9SlOBGE6vmN23MbXHBR+UpOXpH9QWxthVow/G3lrHHULMnJ54vgURHz3AS05Sn
         G5+DfWFR9LX6snu8vrnDaSLwZyc/EV5v9vJykixvuAa+eyElZCbwJ+zfnelwSAHLl4YQ
         8m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772935940; x=1773540740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r0YKx3cc+gQeQOXY6J4sG6IoXgBr7Vg9n7U1F+VLNI=;
        b=gkwF79+od27Xj7M7nY/ItH3ueMiTw+c4mAmuqgogqMEhfSgUT+7CuF9oGDuWJrfM1Q
         8SHej2JoCA+yo5FTDGTw1xRcAM9gYjv2TTshg9UBsat0KwxKcOGkhubrxOA79QKFtVit
         /h0itrPaRjpCzy2Odn5G9qzWCSuagh5uTKFBWyGAuTUHe6dRWxToe1Va2iY6X3h6/iiw
         vhbhI+DdLR/s9EslazySM+0bhp/0C2dYL49/dvM7PG5woFEW87RNRAhD1gspaCm5MpfV
         CZF36gDkhNBfQcrYp35i0MJbNhm1nNmqdbFVWGqSpAfyW/Y3nGd8orSFJn1AsTUTQMR1
         F5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlU7PmsGU6ljhQjS7kvJ90JPNqEhj5GJQLYVGXk1rnTzOT5eIxJQ68Pr46k1uFFhILA2jRd3oG9TiA/ml1VIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsX50Da782nVDGYPrLBNWtpCSSbbVfaxVkFwqtwyFVxltTjF9
	GnChn25DyA8KUaNhYb75JGUrT3LofFt4fZdQ7lBx0w3MCqx20OP7z5kr
X-Gm-Gg: ATEYQzxnCMW/zxojRTtKSxbXykUGc8oGHuOXCIi2PHNpsbD580Mv4nYhxcD9AEWdaZj
	31foEAPOqp3NGSX6D2zwbviUuaqSbe5Liv35t7LM5dFSVtVMZlahD9c8Uu2vJiQmi5WcWYxVE51
	3gS2x6IzWyEjRevqsDKNuC5ntOr4Qq8ABkw1vQnMaZJm65tcm8tbW1YHwn/t2/5Nb5c3RGX4rjN
	oVVNpiuVJD0W4MKKAtP3Ft5oaIfOElGaDvL+vcfVMrTibqlvrVkgiJ5wK7LwM4+7DrAjNAlDrQg
	X6n5f0wAcv0M4URroO96UpioeT1Zi08jP+cjcntw9022wDng53HibNtS7cdavlN8mn4vIchbR6w
	CON+TMQ0Gh0EUAq05O+RyixYRj/RqOWsFwLa14EZKu0blTAPKBW0nZj1rLNnydHGrTFQryWwGu2
	TxMt2buG68WskFyXZChHVt7CSMutqMD8c7kUEruzhmSR7WeoBY1KMRpw==
X-Received: by 2002:a17:90b:3e4d:b0:359:88c5:3add with SMTP id 98e67ed59e1d1-359be307609mr6760544a91.19.1772935939709;
        Sat, 07 Mar 2026 18:12:19 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bcc28f0fsm2632739a91.13.2026.03.07.18.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 18:12:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpio: ljca: reduce struct allocation
Date: Sat,  7 Mar 2026 18:12:01 -0800
Message-ID: <20260308021201.47820-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert connect_mode to a flexible array member to avoid calling
kcalloc and to combine the allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ljca.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index f32d1d237795..a531aaa0425f 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -63,7 +63,6 @@ struct ljca_gpio_dev {
 	DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
 	DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
 	DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
-	u8 *connect_mode;
 	/* protect irq bus */
 	struct mutex irq_lock;
 	struct work_struct work;
@@ -72,6 +71,8 @@ struct ljca_gpio_dev {
 
 	u8 obuf[LJCA_GPIO_BUF_SIZE];
 	u8 ibuf[LJCA_GPIO_BUF_SIZE];
+
+	u8 connect_mode[];
 };
 
 static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
@@ -400,22 +401,19 @@ static int ljca_gpio_probe(struct auxiliary_device *auxdev,
 			   const struct auxiliary_device_id *aux_dev_id)
 {
 	struct ljca_client *ljca = auxiliary_dev_to_ljca_client(auxdev);
+	struct ljca_gpio_info *gpio_info;
 	struct ljca_gpio_dev *ljca_gpio;
 	struct gpio_irq_chip *girq;
 	int ret;
 
-	ljca_gpio = devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GFP_KERNEL);
+	gpio_info = dev_get_platdata(&auxdev->dev);
+	ljca_gpio = devm_kzalloc(&auxdev->dev, struct_size(ljca_gpio, connect_mode, gpio_info->num),
+				 GFP_KERNEL);
 	if (!ljca_gpio)
 		return -ENOMEM;
 
 	ljca_gpio->ljca = ljca;
-	ljca_gpio->gpio_info = dev_get_platdata(&auxdev->dev);
-	ljca_gpio->connect_mode = devm_kcalloc(&auxdev->dev,
-					       ljca_gpio->gpio_info->num,
-					       sizeof(*ljca_gpio->connect_mode),
-					       GFP_KERNEL);
-	if (!ljca_gpio->connect_mode)
-		return -ENOMEM;
+	ljca_gpio->gpio_info = gpio_info;
 
 	ret = devm_mutex_init(&auxdev->dev, &ljca_gpio->irq_lock);
 	if (ret)
-- 
2.53.0

