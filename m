Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E842324B33
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344257; cv=none; b=Go4DGzDlnGRAbFif+n821NLGbOxwsaMDCnP4ciq6Srf0SKu1bc1BEmCHbKZ/S0ttakiAPLtSzG9TyYc4X9CxcH9oCib71cPQnpO0LLAB4jz9ZCEauKx6f7TDwE39FBltQwMEYH/EzaaGRKE+HaA8vaaMixh0/4JCrDUibwjWrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344257; c=relaxed/simple;
	bh=gXp1sqo04e6LO5/4Vkl6NRi4x49bKddvQgyl58yMMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ER0htYwMYZilqoIROs/5aN8+JU8WioTT1yaecNitdqdsvyr7xE4k+TDth+RNAc2nMCtXdvG8qdRPK3EZt6cWEO2OEsdcUP5f5pRa8UCRozZ63uUx+ArUZQ1sBzivWPXGWSKrxlHYVO6RnF4t2Nve9SBCREB+22yDtFg8h+osI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE+Hpt1n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE+Hpt1n"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso11924075ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344255; x=1773949055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzzRjNz0vk0FkgwQahTz097bKivrpMU+EtTeSnfZdlM=;
        b=gE+Hpt1nBQIUFo/d1YUzifVzwjkYNVE+GBzTWBaHT6yTKGMBcus7rvUtkun0S793jd
         JB2boFIci6CelAMYrChF+L8MS/hvL857T0BKBcAwza7dTgOYO55Wr3nxp2ajNtP6QGkR
         vg2Jp1TI8kfuztoJALX7LzdWou/6Fmx6T9bpTwtibBukaqMsPEBW5GmHFZJiA5BkVgpj
         njv450OipbBbLxvScvG47yOjh9CPAuORNlWpkT2RbYD7jvCvq3n2Z1namP1R0M8BpxpV
         AQxl2D9xW6yrUB13o4kAIFWmvz9P75Nl8ugE/gYbeAOs3sWIJd/BtGrwOMi2zP40TrRe
         ACAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344255; x=1773949055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzzRjNz0vk0FkgwQahTz097bKivrpMU+EtTeSnfZdlM=;
        b=FeFfkOY+auQC4MXOIMCD6l/zlzvz07G/LBJ8bm5v5lgy6zynzdtQ5vxNU8WonltNf6
         53yGqY0KupfisrNJ10RC7MDDyfgyFghJFIP2RFhi8sFHjmkU7O4P+Py0/HYUGf8aJHaL
         n1g+qN1xZnQSbzVnjXb35lW6oWL6QpK4awp6UakU8OS/XgxrmCM3PHBpVxAChKS/RRzF
         ONKpdJH/GF1vEbm1XvwQoKRniPUYm3wogDRju8Tve+U62kRng16AJqySzHaOj+BKDQo/
         ftKfDvg2uGfxZ5cX+rX/Up+CwSicGLUdr4t94M72fyN5JqpTUFZfMTqEJvMTC/9IAh42
         lF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUM3/CGB0pymXW8N6fw1tHjZhlIiHJlICKh27Ge4dkVmCtBnoIvyFIUEkuPmlxfKN8zzw5fLsO4MsPMrlzPq+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0j/RekB0BDS4bPUDQsAKgNzdrfPEbQCpiFoL7XMXc6c39VqZS
	4oy4L6gB1m1Ip67cSWmEcYvWZnWd/AI3xmjp38AypEr0/GXbUolGZP2I
X-Gm-Gg: ATEYQzzq/YMDtR3UGREjziX9abvU7n00J6V3Nit8p0k68VOKtADsTwUdDn8rttAGuW9
	deIaWQK/NVsMf7d7s1WEw80Nd9GomKx0Jj49IMyfHw1KH5dAVYAPhCZ9DX0F8pfTa34O0s05T6g
	eNixlwzNX3XbSEJ+qDzgz3OPhjardETkb76eKsrwCejkRLR3kxBWJS0KPM1SDSeICYg/G44Xpat
	t8AnQdmgRDhsQu/vzHOIHBextm+Vsps2CHWnuNmMPV9KY2zKPy1rV5L/WQlmTfbMKy6WHws2rRB
	5tulXXWz9kszWtxf4FLdcQbDFGIX2/IFvubQERZ6zWVIEqtOXIGMa7cVbgb5WWfzdtBBxoXE2kI
	cUlX0HpAaF6VlBBCMujZkF4rMUo9YJlzk+7j704wrgaq+f5WbCCPB2zWJhdnPpQ57gQlqYphU7V
	LDaDd4VlbFWkfSXNvIA41xDb4hMVhuZoAQ3e3meGs6Cdh6WImFKSdcsA==
X-Received: by 2002:a17:902:ecc2:b0:2ae:3ae3:432c with SMTP id d9443c01a7336-2aeba46a7d0mr41568145ad.10.1773344255388;
        Thu, 12 Mar 2026 12:37:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de20sm62461975ad.60.2026.03.12.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:37:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO GPIO DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] gpio: virtio: remove one kcalloc
Date: Thu, 12 Mar 2026 12:37:17 -0700
Message-ID: <20260312193717.12221-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flexible array member can be used to combine allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 v3: add counting field for __counted_by.
 v2: add space in struct
 drivers/gpio/gpio-virtio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..57d0eb532c3c 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -52,7 +52,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;

 	/* irq support */
@@ -60,6 +59,9 @@ struct virtio_gpio {
 	struct mutex irq_lock; /* Protects irq operation */
 	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
 	struct vgpio_irq_line *irq_lines;
+
+	u16 ngpio;
+	struct virtio_gpio_line lines[] __counted_by(ngpio);
 };

 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -541,10 +543,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	u16 ngpio;
 	int ret, i;

-	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
-	if (!vgpio)
-		return -ENOMEM;
-
 	/* Read configuration */
 	gpio_names_size =
 		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
@@ -556,10 +554,12 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}

-	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
-	if (!vgpio->lines)
+	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
+	if (!vgpio)
 		return -ENOMEM;

+	vgpio->ngpio = ngpio;
+
 	for (i = 0; i < ngpio; i++) {
 		mutex_init(&vgpio->lines[i].lock);
 		init_completion(&vgpio->lines[i].completion);
--
2.53.0

