Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B4C8F0
	for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878777; cv=none; b=RV5SYUc+QSgl1VKueHZjBbMUycoDptJTqN61WCjnwUOGCA6H86xFI7q30CbzQPoeTztbIiFeXp8Otr1tY2a/kRNPlVJoTZUe5YZfqEFA5ChBTIHHkdlybfCTwba+4WeN39REkoytedyixk0PooKzSvXA09XzXv7DMR0gIkDBG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878777; c=relaxed/simple;
	bh=FzNH19rgnTQby5fAPdsDwWUSiHP1o3ls1AowYzfPyg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMrzcIQTylxZwFgxo7DD8EhnlgSjxF/nqL4DpqrZNMBxl+0ve8RjoS6YgwftR54iwfrgerk9SBzczO8uzw5ab5OIYGrYiolxn050QW5v/DKDYsXVvNbUH1zqFPKJQvhFKD7c+oRwsWDN2Qw5U3E3FxPBKVxNgjUO+Q9jvr5jlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKs9I72Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKs9I72Y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so1586855ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773878776; x=1774483576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRm3k9nSwdEcyKRHATcZEGW4qHweuoW5rJO6irAqBPs=;
        b=EKs9I72YKo1AFwo5u1YJpW5ayVVkW4fxZSe3oHvA7EfkSUbVo8yW2xyCZhQAZ7EfPy
         RUzUj0Wx7yDWuzMEAWePvwovWTmqSe0RekEYTceb4llaIRCloDlK9ezFnmKqeXaqZhFF
         r8wl506HQDgMNMuAZnqlcROlL645h3rJYFK2F3rEmCPM8504JcbG1/33u/4PU1QMlhH9
         EUurRx1iZEsFUK6myQuaGhH3vBK4u6KEtuuqzU0Wkaxzx6NWVku/KemPYwrLosbH0W/N
         4uMKfrRNyEKhYxLyvN5PJ1nE3P4UW58CgR92l5inVXaXTqzn6Qa8GIGmZJMa+K/lXuXC
         7Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878776; x=1774483576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRm3k9nSwdEcyKRHATcZEGW4qHweuoW5rJO6irAqBPs=;
        b=PJHPFowS9+4l1PAk3WJ/2vIgjzEBXNT5S8N6ybTXsX2tbOJZD95OAYLzjf113t8V8o
         UXmdEU+UjC9bIqOQQJ3b8LC1kOQsNdc3wDgZxmS6hPQCEnpVtPJSEGYfMlFz9h4QrWxs
         dczZZxoa0Bcn9qbVAILo/lqb4X317mmnGxiBaal3dMJr7w6RVVt8oWJN8HH7ONQk9VNz
         p8w+CfWtxCEBpca8Ltlw3f/Bi1gTMLXEdoidFCGh0Qwun+s/xA4dDuUaEIdPX0flzUPP
         o1OKGaWYZ/A6khCAPkj2xOV5vyuroOZoCq5xDjGeTNkXeA20l8x3jsRueLq/HlglPnzc
         dMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmvhOBzZhclkTgTowA4ziO9Gidy2BowrZ1S9O8n2tZSOdPlvglw3Kvv00oQNtmkjV3Elq5V0pWj1nV90OD+VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzfCuE8Sn4jOP/bHMWJ3ALhBo8hJDbIS7HMkq3xb6D6XePCXh
	gZzCPC2WITNVs16EmZTJDrZmW1VRgPSuyQI0QMgPzFf1Ku2ADbE3Sz1Z
X-Gm-Gg: ATEYQzyTybVQX2HT860E/8QwBJ4wcQsI9tY/ahe+niwPzCs4PQllOIqxgoY3cFkTGdQ
	uYWYVi8m2rJMwvaVcN0Gifro9DCU6VGiBo5NHTDquDE+rAWius9WjKycWNbH3i+LH5NYd4/N8ns
	mEKnom3o7Giv3iCVnDAlG50vDwfMr8Zens177Fxrree7+yIOY4dBrpGRQ3A+cDvA3KJHUGnROKg
	JFeUpAFc0rqR5PvUwtbtmDQvhH5E9ELGIPtj1nnbQIZ/9bZqFQ61Z0sNdFPJfkzhlCPMIRyr6fX
	3jvb2FtTjpGViB5VCKZKP44A/MVljlnUphuQaiIKzzAJ2RHapzYPEc0Bp9jlyRMN021MoE32+uZ
	/ScCttJhRJHSzZZLyhZOSt/mBwOrHybetjdnMcsExH+m0oZjlz2W4FxEkxPHCaXfbWub/di4jEW
	U91dGHp4TGRfPFkgCuZ4d8VIAcK9sUcDSK5SEVk/xLkKbJ+7AojYJf79EJfUZbC7DeWw==
X-Received: by 2002:a17:903:2f87:b0:2ae:ba41:60 with SMTP id d9443c01a7336-2b06e3248d5mr49150455ad.1.1773878775805;
        Wed, 18 Mar 2026 17:06:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e4199easm51952735ad.5.2026.03.18.17.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:06:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Bamvor Jian Zhang <bamv2005@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] gpio: mockup: allocate lines with main struct
Date: Wed, 18 Mar 2026 17:05:58 -0700
Message-ID: <20260319000558.22108-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove no longer needed kcalloc to simplify allocation.

Added __counted_by along with a counting variable to get extra runtime
analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-mockup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index a7d69f3835c1..a907ce28cbbb 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -52,10 +52,11 @@ struct gpio_mockup_line_status {
 
 struct gpio_mockup_chip {
 	struct gpio_chip gc;
-	struct gpio_mockup_line_status *lines;
 	struct irq_domain *irq_sim_domain;
 	struct dentry *dbg_dir;
 	struct mutex lock;
+	int nr_lines;
+	struct gpio_mockup_line_status lines[] __counted_by(nr_lines);
 };
 
 struct gpio_mockup_dbgfs_private {
@@ -436,15 +437,18 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (rv)
 		name = dev_name(dev);
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, struct_size(chip, lines, ngpio), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	mutex_init(&chip->lock);
+	chip->nr_lines = ngpio;
 
 	gc = &chip->gc;
-	gc->base = base;
 	gc->ngpio = ngpio;
+	gc->base = base;
+
+	mutex_init(&chip->lock);
+
 	gc->label = name;
 	gc->owner = THIS_MODULE;
 	gc->parent = dev;
@@ -460,11 +464,6 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->request = gpio_mockup_request;
 	gc->free = gpio_mockup_free;
 
-	chip->lines = devm_kcalloc(dev, gc->ngpio,
-				   sizeof(*chip->lines), GFP_KERNEL);
-	if (!chip->lines)
-		return -ENOMEM;
-
 	for (i = 0; i < gc->ngpio; i++)
 		chip->lines[i].dir = GPIO_LINE_DIRECTION_IN;
 
-- 
2.53.0

