Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598C19CC28
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772936155; cv=none; b=ta7pCHJZYo9Pzto4Jrc5PBfatYDnx7sPRtIBo3/Ck42o7DkmnJ3cKkf9bHboXf8zBmtFjIzp+yijfsMn6h5aSKYXonKUkOQbAFCr9/+A+I/ElrB6ajGz+KEz+z3VC/cf7qi5tRYDqLMc0o9mhLKfTl62o6sGO22maXMP/zqrccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772936155; c=relaxed/simple;
	bh=RFTtLtXTJSCNlN81p7jhHeIaM5OglLMy9XlFjb1EpGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpZopzczXVSQjC2FtTrH9HR+gRyjbDvfortrGr8j9ZSfzrTQ5R9b/gBk4M6s4bdRqMid5Rvhk7CgbMFxH8xFQKJ3BCC1s4udeAqo1KI6DXVCtU5LtOmNpHI/b31T2+aUHT35hIhv0cvHWhqo7pbaYhlztEuFcWMxrmgPyRDk5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IklvxTCn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IklvxTCn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-359894e17b8so4921100a91.1
        for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 18:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772936153; x=1773540953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIcO5BEsmaavjxp3pWNdUOixbx6V+gvKfNkKSDPbOxY=;
        b=IklvxTCnhXSR0WNDZcm8uy3KcOlqpXrdjhm+9XD9Xrs3xtfr8cpK5Q9rxKQtfI19Ne
         vu1qOig4TKysAQKEnXxOfh7SXl6go6ayQKsDpX+xAKPJD3WG8kB+xa1fGgqvfeDzHSZ7
         rvGCaHHHU9EHX2EtX8XT6EeBboE2k+qbm/PA9vHFIeRoHlF7J4xMIxGM9m4RCI4NXrDB
         WZ2F5lUAaWnqmXc1lbKdr+fIDm+WP7VBff2qKu1ReFRi89N5gJH2ClSEJ9BzBUabYM3c
         M11CJqwfXvhh7V0uK3T5/+J6O3Jch5UOa8VxgMSmSd8TZqGLWYb9LQjZp03TDaGlivZ3
         QzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772936153; x=1773540953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIcO5BEsmaavjxp3pWNdUOixbx6V+gvKfNkKSDPbOxY=;
        b=LxKdthjtw/M4H9z4joP86AGhIJpubiaJoX2T+VZFTjhUS55vQqdumQBf8QedNg6xMo
         0MChLBinGupbgggpuViRQwnbClBY/iAmkZ5n1nXgOzUdrc7a4tJPaTlcwjCAZNMo+Aw+
         graPzHnIHCegZ+DtQfcWkIy4LzhrgAYmI9lchR5lV3c0kNeFmzLT4F34OvfC2UhKs/+V
         caf7gmsN6YcuIe9taHRQuWJYCyZFU11QDYxD28QBUD4Tlap2+iSCOhj/qTCla/mE/dHw
         2mLoXakdRUeELN9i7J8gL+NFJtv6EAYGA3XxBd9mq4zP47L5vAfIUJvCVVYgyYlBUmhx
         Vt2g==
X-Forwarded-Encrypted: i=1; AJvYcCUbOZJkvUO1WXFGetbHDEMmPLYNzUEG5Bm5bXc9QVPVtD7wsrxsHufPTnh0RgMlYjKrdM2AbD5eSzPhSlWGvhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/I/AhB1RHjLePOCrR+JQwVb7HZNQdzbfjVF5ioLRqK/TU6G3G
	22PXjPE1QA3kml+sL7lUw6ChnAeuqpvX4vZiV9Sn8ZaiB2P567BjPgrW
X-Gm-Gg: ATEYQzxq7czbqaL3NZmHyMxOZGgxG4wdGJs0petQ78UiTOJdUR64Rb4EsewUOSbHKXq
	2lczdzoJYQ2MkU6Z+dtNOniiiXh5ysPgvvbm+DMOwJVWZkzm+x2hv8hXq9RTUgDY6aJRZUzd3Gt
	pZHG+Tcfq4+QGV3aRRTvIsiDcp8tkQ1KiNUyPjRSVwLM/G1V0wY5Uf1K7sa7O357HqBun0zJr5X
	BbJwXKHA8ggc6kVpnlI0yqm+4sn3lgSAD8udGzc7X91b9tnH9dMrVa6wJ6jYopFXTMHTnw7mpfd
	dQCLTIQk/r2RDny7+pq0ro1GEiqH4sA7mxYhHtoYjBP37I24Xirnay/weldxr2sGMyvLVGi4vw7
	NATH/Kg6CYuXjFL2CZutfcHr89I7B4EI4H+NBAP/ofcndGypHCmT432cE2TwKauHQFKsUAdMexn
	AzCUStFBsHXfVzPTf2waZsqJkOsxJdbSnqnpOgsq/pMmD7Q+AEtRipxw==
X-Received: by 2002:a17:902:ce8e:b0:2ad:ca3a:ecb0 with SMTP id d9443c01a7336-2ae823ac6ebmr70405345ad.25.1772936153317;
        Sat, 07 Mar 2026 18:15:53 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840adb42sm85962385ad.81.2026.03.07.18.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 18:15:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Daniel Palmer <daniel@thingy.jp>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Romain Perier <romain.perier@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/MStar/Sigmastar Armv7 SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpio: msc313: remove kcalloc
Date: Sat,  7 Mar 2026 18:15:35 -0800
Message-ID: <20260308021535.48098-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-msc313.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index 7345afdc78de..de3e6da2a089 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -483,7 +483,7 @@ MSC313_GPIO_CHIPDATA(ssd20xd);
 struct msc313_gpio {
 	void __iomem *base;
 	const struct msc313_gpio_data *gpio_data;
-	u8 *saved;
+	u8 saved[];
 };
 
 static int msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
@@ -631,16 +631,12 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	if (!parent_domain)
 		return -ENODEV;
 
-	gpio = devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
+	gpio = devm_kzalloc(dev, struct_size(gpio, saved, match_data->num), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
 	gpio->gpio_data = match_data;
 
-	gpio->saved = devm_kcalloc(dev, gpio->gpio_data->num, sizeof(*gpio->saved), GFP_KERNEL);
-	if (!gpio->saved)
-		return -ENOMEM;
-
 	gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
-- 
2.53.0

