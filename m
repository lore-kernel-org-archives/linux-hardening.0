Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19F2D238F
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971627; cv=none; b=bdROGIw0v873Mwy5b+gUQQUIcALViRbxBx05YHVTd7Ybh4n3Y+9CYFkNVMmobpngwg7ErCjnMIlUjpA5h7zU5nXerzMbsR6CEkIDRy9w9hS+r2LfJRHCVX06wXC6U70//0QQR/XeE/XkCle+VVry/RmnqshtZPt0hSRZbpSn+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971627; c=relaxed/simple;
	bh=4fWULOXJ2FCFWhJy9fLghj7NWISrjfvLRkcXm4+1KYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aunvPBLFhO3xv0C0TePBKDiEm7/p59Aplym7GT4RTswxmmQf7MhsIicpzqk1c7iUu6gXdik4sMuM11XSlYwpioYz05xLqtfZ2xwyzAsqmUjMKkGIcBPhCDfPXsg/rOPrrKAnqp+/ZKOzzmLo2m691WAWWSbzyBFGNgCOfzRK1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+BPSY59; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+BPSY59"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64e87a81639so1890714d50.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773971622; x=1774576422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzPny3OBUeeBpt9cG0P/e54tGjxk7eLdlTFpb0o1yU8=;
        b=P+BPSY59yYPSyPq7sqg90l8NH6u/mYi/BUS0qGLxWLMeAbjlwhTOrXowdqNHREDt3y
         HSbEfG0zzinbWAsIVBQe1+tIPSznIGKGM9Ou7QzB7BhG4ujw9bH/83so+aJvBIzkAKrh
         wBrFPTwWd15g/QRCQWFlMjqAB/gU313rE1GbTLtV4p7xseKFkfrm88USvGnJ0PI5w1M0
         moQ1zKMmUDOEHJYAN1n1Oyy8BB1qxQtiGbAl9GV2Nl89knAy5l4li6xO6hzBu3RYJ7Vc
         7oAG8SCFgcaVeOpUkePhtnjJz1ILPVyhOOg7CxPGNzE/6JXP3g6BbarurjN5tDjuWaFM
         DifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773971622; x=1774576422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzPny3OBUeeBpt9cG0P/e54tGjxk7eLdlTFpb0o1yU8=;
        b=I56FHfVMwC1L6qJr7FYMDYdi7Md1xosciXzm9ZUFvvnACDu95jB6XtagC/4WPYG6yp
         +LHgL0R9iorAMszeuz0UdgOcPsaFgfuA3vtkNS6h6L18odXsstQV9gdD3s6xldBp4/Lr
         O/Kk1ZmLR+RQn+vCY2P1FAkfNennL2UWgFSwjPkhAHWRZMkPAoU0O7l+uyrrcvlp4Bgw
         rpKQN18/LzVOYLw++zJueNfU4VfUYTECDzABJ0sGxiQkqAHBtJpUO8PUwJuqOYHrgXts
         E0qS0li7BvmOaypc+nvFebz/qWOTVTf+uzkbzoGfAEJ0Pf2QYsiH49QJjOeJPa9OCA8h
         NIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWic3d0O0K3HefZb3dczTAnaP5M+ymLgwlJJwgdHJ5uJfNyv5blGFw2lFto5GShpSPJEGEkw8bT1zAWR2qwKsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr79Qej9SzlCWbXnrx0dogOlccrVW5QklQp3jJkSyabKG5LtOW
	mNwQMAftzHrqxZY7/JgND72yIfIzxbRa+kusOOexiPlLL62GAx8gGPIk
X-Gm-Gg: ATEYQzyhm4eCK3laI/nZ4bIdRGVmxKTgejq8v2/BRMiEZoR+83IwkonkPqT7ryTLyxS
	3VU0x4fWxS2rQVOHONqWhssNqiUje8ZziT5U8z4rYSQhcOPYPV4kt7Z5jjpT1ajJo1VSNuzyHCc
	PecqUp3YynGAUeT/+3dDRFpFGfn0ElHBS+Ml/LBbil20H0F+YKFpZ75tkgUm3Q8X4o+p71yE+eF
	qZ/MxVhfrsKENXK4t76rwFnHhnfnZgAZ5EFedDLZTy+xgL5fP1S1FpXI+TmX0dt5W6y34lRQBZA
	dtJ+gUYUyBM2rF7va47AmYWKtsHPXli41JF47lGvfcVmYpoIKbgg/TeGrITGrirte90PKzTRpzB
	LThnH9AbYvpYyzun9J9gw2C+d3ygRJlgJWuIFkNQNblYdRBDJUkOM8k6y2p0TOCNsbwFRLKWBYd
	2pfjl+zY10ecpxnWDyMHZS9Ga2uEWE/zMsX8bgKo782wpvvYtP9W+HzGs=
X-Received: by 2002:a05:690c:d83:b0:79a:38a2:d8cf with SMTP id 00721157ae682-79a90aea249mr15668467b3.17.1773971622283;
        Thu, 19 Mar 2026 18:53:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90214024sm8378917b3.0.2026.03.19.18.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:53:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/MStar/Sigmastar Armv7 SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] gpio: msc313: remove kcalloc
Date: Thu, 19 Mar 2026 18:53:23 -0700
Message-ID: <20260320015323.36383-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc.

Add an extra counting member to support __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add __counted_by.
 drivers/gpio/gpio-msc313.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index 7345afdc78de..2accf3446cd9 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -483,7 +483,8 @@ MSC313_GPIO_CHIPDATA(ssd20xd);
 struct msc313_gpio {
 	void __iomem *base;
 	const struct msc313_gpio_data *gpio_data;
-	u8 *saved;
+	int nr_saved;
+	u8 saved[] __counted_by(nr_saved);
 };

 static int msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
@@ -631,16 +632,13 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	if (!parent_domain)
 		return -ENODEV;

-	gpio = devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
+	gpio = devm_kzalloc(dev, struct_size(gpio, saved, match_data->num), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;

+	gpio->nr_saved = match_data->num;
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

