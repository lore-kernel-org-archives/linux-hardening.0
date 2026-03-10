Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71532FA21
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108079; cv=none; b=q54rTq0ycMOzBRVuExKDErleIo8Kj1C3TC68DCy1oI4OvQ8CUmNw2tcs0WTyQCry3dQWpdmBuf6zUOPw6C97xfC6QDxDCwo+LwmtV01obqqPrib7WRN6wdVhOvLdE6ft2/MoTjVx5qDBapSyb13eW62OM8p7nzLoI2Ee7dTbkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108079; c=relaxed/simple;
	bh=r74vXhE8Sb4aeEjXyTRfyESwDzvu/qDaicDAjMleUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErqsHqsotkH/MoNhOV2x3fc5dNHc/B0qkJ19N8MvjOIYk/RksPuQkTpjeNQezYMuhGoRWimRYBFx7ZD51Twg5uAmuewvrYasiBUWZftdjgiwk9p8friQBEqHgiYXJFo3sYATSfszOzDuI6x+o/FQD1m2pfCxR7cYYBjsuZ6znpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJNOb5Jj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJNOb5Jj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73bd024a0dso433259a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773108076; x=1773712876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lALqj4AFCCf04PXMDS8nK7oxi7K5MFhENXcy3JAs/Dw=;
        b=dJNOb5Jjoc+jmdYmgiu8+0knsmzfzdQvaoaUBRVv6lCtAtSXO0FEN+ZJpoVjxUs8B0
         Y2GiMIilV/ishEkDr3qPEo80DL15wyeVomYUQabdTOibrSVvsdaY56drAgsaSfjsF8ZH
         nvLtM4LvatzOFauc8/UDfhdSCX+5AQocJEb0dbV+fPO8giuwvwIsveckgFNigs4wq4Ir
         lNNLnN5mmMeH5imwjvTUgtmPK53wAIJfX/mszGqY+PDvRZ/+VWwOH4RUd/c8Sklvsc2M
         /4maCJwiAfdlHoglKfCj0qn/jJCg/BuhBoG4aD5+Kw84lkS10Dvxlcxr/MBP58cZ7d5n
         XjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108076; x=1773712876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lALqj4AFCCf04PXMDS8nK7oxi7K5MFhENXcy3JAs/Dw=;
        b=gkHlPt4cipHQd6ICxTyT47iwxD3kBA+jqlHpI6ZhWgT+0rhD6Cc1cnPn13W3aSi5lv
         o9eeh10Y3pmtiOctJxyeX80Jgpu250PutO6xBCbCK+InoXIjd/B3b1I0SexIO5VE+285
         xYr8UOs2btNXxjxigOSuYo5jSLuZNFWN/87VlLSeeI+CAPCbBzXzGVTW6Yks6qA0CJcu
         izbMF0eDmNYBCKPuCl08l6xYvPQO157GiJjr/VKLCzhJOl6VLQTZdQWeu0aJB3oeTCm/
         CJJ3ZUTozbBwTPi6YlWP5wSCsPajJKlveIWjTbGmFaAF31ffhvvZn7y7C25kOggsg1CS
         uukg==
X-Forwarded-Encrypted: i=1; AJvYcCVOyz78SNf9ZZRknizHh7Sh1Tw12ApaLn8K64KsCL/J2fdPcHLuhLdy9Toafokg1hgAnAjyWs0Nv8mOGY2fMm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4N4ZVvGbPopd57R/urWTO7S24oZ2uZeQPfaDzSVTRIoXoRME2
	q/n9Q0y94VHQBN1xpMwjRk2PKiU0QA9JXJtWfYGyk9TEG8ekvMzYL4+c
X-Gm-Gg: ATEYQzxoTo3/ulSjVr1ELE+X3/UKV1Xu7Uxr5Jmwj8y7kgRBri+WnmRhhncadWxCYKA
	+BSHnPRPHaHJvHRSPapunMWnembtRjboMUggncBs57BqPGPeQW5PA1704UfcNDBP7AOxR2ybhff
	tcAh5+c4cNuTHNuMu26IIZu8xOdzM2ksQrwlkmvSCZw0NJpXy/pMefOHTPSjgOEZGEzwNpZUfJH
	B1BL4wFIVFZOZ6DjWpWjD/sZTAwVW0iFJfJbaH4+IW/H+fxya+RV+DLnu/IMa9sbb2sSG4qzLiE
	N9P8ozODwZvyuaTpQMn/1McBLAEb42a/dY60D+P8fNakHdTKviimzk/9dTauBMOrI3NKBpKV9AF
	YG/W2hQGAcH9PjDy9lNXhL0OvzJGuSpClEKritigFtyeYmXbGv8ZuJYNdKZXOhS4BLXrM6kbXBx
	BuZQCBVg4YuBRADvL8h7NZxzgD6EKjwjEFmt/IiGDn7TrnfNUVEWvhnQ==
X-Received: by 2002:a17:903:2c50:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2ae82362d1cmr136082195ad.3.1773108075517;
        Mon, 09 Mar 2026 19:01:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f78370sm135102865ad.43.2026.03.09.19.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:01:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO GPIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpio: virtio: remove one kcalloc
Date: Mon,  9 Mar 2026 19:00:57 -0700
Message-ID: <20260310020057.340550-1-rosenp@gmail.com>
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
---
 drivers/gpio/gpio-virtio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..876a34ed739d 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -52,7 +52,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;
 
 	/* irq support */
@@ -60,6 +59,7 @@ struct virtio_gpio {
 	struct mutex irq_lock; /* Protects irq operation */
 	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
 	struct vgpio_irq_line *irq_lines;
+	struct virtio_gpio_line lines[];
 };
 
 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -541,10 +541,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	u16 ngpio;
 	int ret, i;
 
-	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
-	if (!vgpio)
-		return -ENOMEM;
-
 	/* Read configuration */
 	gpio_names_size =
 		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
@@ -556,8 +552,8 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
-	if (!vgpio->lines)
+	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
+	if (!vgpio)
 		return -ENOMEM;
 
 	for (i = 0; i < ngpio; i++) {
-- 
2.53.0

