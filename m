Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83A2D978B
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271144; cv=none; b=cy3Xd9rEFwNbOUrYhBAHXXfZllWu3mYHQq7yEBV9BIcOzpY3NSvb9BrFh5UeNZq6s7IsDgOOHeBg2jFtqMhBvJv2k/ObBbJYYW3zcpbnHuAPUO+J2K70FaD6qNSB0bk0k0DrLHEVGb2jPms5kYHYZksiYgEE37KdN009qTAb7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271144; c=relaxed/simple;
	bh=O6jBhetHYK3YjI5od6XbzRv137I+sjU3j7bdXLcMVIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXUtmLTLWr+Ge27UuQNptGaCK7ZFX3G95b0zSR+6BIwvllfpO7RptpTIXpWJduSWwa/3lE2rcTE1TuwiuqF1L2tMB19Bv+jYxln6pUM1FJ8uAhmxXw0LOcRROZA+PQYN83cuufiBMV08KlU8VDJBrQBbSYGbjZGc+fIWS+g4E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnCxiJqX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnCxiJqX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad21f437eeso3791185ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271142; x=1773875942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGQa5TPg+fy6f75658KrdxaLTfVS/9M1At/7AR8OAo8=;
        b=KnCxiJqXXM1lmVUKn97NqqpXhZdLhCN9uXHz5DTW8sEfQGTmXykuLB6tBB/xnnjag/
         KnSYQA0Y5YPXwLLSp8qwQKN1QdI0nkbIHLAo82yUUO5HN0aDTKrjy1rGlVKhIXR/++38
         h6vvkA2FwNuqDFp1eMQm2dYzud4ttgv7diRWElfz9ikFEwf3Dfum4aNMuDNv36DPE7Py
         8hCfsx73HDkCA8hlhce1xJErqj86xlzWrBqasQqGNrUd0AsxtGgypHtoUYdqlvpQqDJC
         oSObC9B1lZXrLnFpOf0YtjhC5FXdsPoivT0iyNb4SmoPeXIJekxF7656Le43sQMW9s3T
         R1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271142; x=1773875942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGQa5TPg+fy6f75658KrdxaLTfVS/9M1At/7AR8OAo8=;
        b=OLfaNY8OVzVNUVr3JKM+GXydMiYkAf+5dihDjG+dcbKqdrL7DsViToNsMnp7w2DKVf
         clbBjNMIMto7fptvdo8EXwgs1b5otIc5XdgJfMa+z9EYLhqJWa8lcb3Q/kA9RfVAdxf0
         Xi1qg+se8zuQ/qTpMW6HnochkYhOHR49pXLPYlxcrvzjntJXmkxJGz5gxzYipVgV+/mU
         nWPpBoeQGUHNaLg2Nj4qPhg9OiJb0rBZrvIlE+PsQ/EYQY6kgK0bhN+LUR9mAdhHtRTj
         Brm5uZ0gKc0G8mHHH1oP45/FSNulWPJnnhLVxO+h+sVqpLpOO+u6SSDAcKQEF69iSRdr
         MB2g==
X-Forwarded-Encrypted: i=1; AJvYcCW69i0cRORDFZ3VqNdRdPSEHpB3Ku+fXlGRoz29PBB5aUhiYtQA+kSv1TRSBMeJjRvzf6ZoxhcXa1gIla4cQfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVDehZsW9o8vOXCwj6kmh7sslxhdApxIwRQ/NuPJ5Q2q7g/5C
	t/LfL0NyCK7RZqBY5OVb+/4nzXqp+ampuAxonTSloKGAJdt4wvWnP5xtcvi3wB7N
X-Gm-Gg: ATEYQzwJ+tz2uA+re31V9nFcih8YGpwpGWLyhQzmLGv5VzWTeBmNQA7HsP4YRkuUXII
	OaN9SbsXmhpGg12TVB4eaq4lB7GkJrG1zCjgOASr17s8oRw5BVnMF74n+cJ5O4wkv+7FW0YXVTt
	USKGafE6OIGOPzE/ARx/A1cZ/i9iRa1J0kNdMVltQICRqdWTMG9jk9w7ZButb2a6oR7vcTU1Pt4
	XTqCGnIsE7328NnW8J+RjUVKeQ6gu3vf5q0c7VNhj6Kh+SsM3RE9jFTe9Xu/ElyZRUv2kSoV4dZ
	omlxLArFpv4ocmp28qLUQ9QkVQpTIfcoED5N55LAILVTTQeCQJP7eEcVKC0frCZctxKEsF6aLy4
	bZEZWLa3MY6NMci2ckKNOHtsNYBzic7kHi5EzNF6gO9qKGN4avKbe7Y9qdbT2lba4vFSwvQ7dbP
	M5m1MKF4Y1Y7Rr0MK9wuD9gmF1l01VUpMEdGiEVVha6ENOmb7Dh4mxmw==
X-Received: by 2002:a17:903:32cc:b0:2ad:b213:feba with SMTP id d9443c01a7336-2aeba4416d2mr10894095ad.5.1773271142123;
        Wed, 11 Mar 2026 16:19:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222e3asm43921815ad.15.2026.03.11.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:19:01 -0700 (PDT)
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
Subject: [PATCHv3] gpio: ljca: reduce struct allocation
Date: Wed, 11 Mar 2026 16:18:44 -0700
Message-ID: <20260311231844.17891-1-rosenp@gmail.com>
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
 v3: make unsigned int to match original.
 v2: add counting variable
 drivers/gpio/gpio-ljca.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index f32d1d237795..93a0fd4ac507 100644
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
+	unsigned int num;
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

