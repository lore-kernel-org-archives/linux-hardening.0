Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F5392C4A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181260; cv=none; b=uz+uDTSVgyw938s7oz8OdGdAF6poK2+r4FShmYiUruJleG9gMFG8h/J3BLhYA+u0YGLCAt0iK3c/3CQvqkIr9TU0QB9KiQBd8Qbai4nzSJyVWMszMHyiyEnAIOe7LN54WBBTaGUoCaq3p4SqEP3wE59oTEgeP0bB5BnpDLtXLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181260; c=relaxed/simple;
	bh=AoCKtx/PUi7xUnmBv9zsoXN1mNbIXI5U5Hql2pRn6sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsICq4ZJKeP6qPmOvs3ZjJZS9s98zOLZ7ff4X8rqhB+ISAzPlC85/AG15vn4n/L5LLXosw8CZSAzdmbjroKADc4XlcHWLVJhmjZ75yi1FvO8pUyz9O8tRuWGwMczXl8JkgBf8qRLdOh31SW4MczL9JT1fngyBmV5rZ6Yy6qieTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT59+NCx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT59+NCx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae3a2f6007so77849625ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773181258; x=1773786058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PmiKrgbRCdENnoUgQXrKp+F9EjF1+JrjBV/WyUOuw0=;
        b=RT59+NCxAdb/G4PWJnUgKYoKcp0Y8lA5qSs+5Mi0thQK1qsdkierfTBf5y/XnspRzn
         Xi0+UTPL0QLZ8gcb+xHTLWzXJ/fkDBqIFwLPLGUT2dMV23FiVBLu6O43I2zcjMEBAk/5
         ytDTlNK5Wf2GNf36dwwvspIzziKzy/rer9e182HzVaXEi58g/vt6U0EzCtlto8IlY8BL
         Q5lPMj8Jso5Z+V1HJHef5hHKsPi/IWMfQmFWlN9xQo26VDvaBuD9jiwVLP5Ty/71bfS6
         zSWE9MN1kG50UJlMYvDBfJRaS7/CYJjYOIpO8C0VyDPixAdn+D6kdxqN2wE5z+sQHtjI
         kY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773181258; x=1773786058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PmiKrgbRCdENnoUgQXrKp+F9EjF1+JrjBV/WyUOuw0=;
        b=FlAwNmzdRyVlMnuoTaHJKM/ku+/GPKMW70DtuF/Pocx2vFghkoVmvnNotHNmi9fFjp
         u4cOalJDX0PnBluu7xm+MTSkzQhrU+vJabVtvWtAgcB/AULe8YGydG1PeGoNEQ9j113Q
         TAK7Pi3pg5QbWa4KIC8b3zEcLpCC6YfXsg0UOjFhOxIQeB0gx1jiJpfea8A8gUDHVN2W
         SrWD5eebN6Mo0xVStWc2UVYmeHjM94iI8OzuKXUropqUDdehwuv9djdHjV17A2FAOwL3
         WB6GbkMfSyqgYBgoV4BAYssk6uHm+vPKRVOYs/NjN0FwnTamgZG8xefpnZNQLd7RYcdu
         0Ihg==
X-Forwarded-Encrypted: i=1; AJvYcCWoNZixWpvxwrf6ghg1Plb/8qwFzM0SQppWWtiDm2z6eMds6LDn/6nSIM03Y68xCEQL/iuNZieXl8B8vvaKVPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VaK2WPTzuTexsuOnwbKhiNwmleSIVvwLxjE8eQizKrA8S5vM
	pXnHWa7mKpUeyhH+M8haeD690Z4kGyDWcyIX2t6c1GMGXZOkqkkN3z3z
X-Gm-Gg: ATEYQzwamVJizcyIa9aTvVAqEq0cebi+usWP7Zt2s0BWnfXwEVwYvTITouEDublvorc
	oaRwsXpgB2bsVYV7anZWuUN6FvfcP6DSCEpVHNr1ExoDpOXNG0GF42zKcPuoP0wj6Ct9N/qcNOQ
	HpoJpKrennYGREZ+0m5XU6BKjaO3RvxEjTwA3dBu8nt0RHlqWKwAi2qvtPWnjc3gXJdP5RdBzpc
	MMu891CzKa0PF3DeWLxYpKFCuCPET5XFFUtvS6NktdeHxORwvF9igMnyRZVTBih3B1yaEkzVUw3
	qB4hHaAu8CsCTVP+Qj7dsGHuPxbjE8VfYUKUd0PEIFf1gFYWArRZGj9ReWOHaiWVlW1RM+KJA+p
	cEzczBJxj+/Cy3K6lABIT9EIog0+WhWFdxbnTajrhgHmbrV4k10B/OQL6jJGMmLHjvbIjb3WYap
	enkbS8xDqskaLO6wUQR8LEYRWMtbOSEWzIxjX5wMiOBqyOWNGwG6RLdWNMC+lzjfwr
X-Received: by 2002:a17:903:37c4:b0:2ae:6d9e:ed57 with SMTP id d9443c01a7336-2aeae7cee56mr3730555ad.21.1773181258114;
        Tue, 10 Mar 2026 15:20:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246ac7sm3219435ad.25.2026.03.10.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:20:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] gpio: ljca: reduce struct allocation
Date: Tue, 10 Mar 2026 15:20:40 -0700
Message-ID: <20260310222040.10324-1-rosenp@gmail.com>
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

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add counting variable
 drivers/gpio/gpio-ljca.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index f32d1d237795..61252e0eb444 100644
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
@@ -72,6 +71,9 @@ struct ljca_gpio_dev {

 	u8 obuf[LJCA_GPIO_BUF_SIZE];
 	u8 ibuf[LJCA_GPIO_BUF_SIZE];
+
+	size_t num;
+	u8 connect_mode[] __counted_by(num);
 };

 static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
@@ -400,22 +402,20 @@ static int ljca_gpio_probe(struct auxiliary_device *auxdev,
 			   const struct auxiliary_device_id *aux_dev_id)
 {
 	struct ljca_client *ljca = auxiliary_dev_to_ljca_client(auxdev);
+	struct ljca_gpio_info *gpio_info = dev_get_platdata(&auxdev->dev);
 	struct ljca_gpio_dev *ljca_gpio;
 	struct gpio_irq_chip *girq;
 	int ret;

-	ljca_gpio = devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GFP_KERNEL);
+	ljca_gpio = devm_kzalloc(&auxdev->dev,
+				 struct_size(ljca_gpio, connect_mode, gpio_info->num),
+				 GFP_KERNEL);
 	if (!ljca_gpio)
 		return -ENOMEM;

+	ljca_gpio->num = gpio_info->num;
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

