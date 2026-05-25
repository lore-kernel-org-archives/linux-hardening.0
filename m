Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1B3191BB
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746505; cv=none; b=bpO9Afy5oPLDqfQbRNZLW2wCVYsT5yJVelb03cy0YIa0iHDlYrR7zhLmy1VYFbnJutYuDdqqWOKbHjYr60+gBwfi/VzSoYRRLVujaLTt/09BoJBNoNOiicsSyaL9nn1aP5yRBglf3SCd4KF2VDu1BQXPdLZqHSNMX1wYMx4YXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746505; c=relaxed/simple;
	bh=6uBZcvpHVG9ghMmyfS/bczxD/gV3gurTm4gN5EMIuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJVotG8bsWJaRQvitebEmkfxzofwoKXYZDxX4VU1NCKHPi3M7PbjuWtTtUnxVkkHC94D7BZGGTEcXSp31rOz1zbMSqR7YpXjamC8tRe4x988SJh3LKUxQuEcJzGFgKYK6qePnxwJ6EJHQBAjsAvBYeVno/8BYaSi4g8N6TNaWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV3BwLVn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV3BwLVn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c827313dac0so4865807a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746504; x=1780351304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7NKAW/ulkmG6NXCszZo+vmmRfLFaqedn1kwzn4OXVM=;
        b=kV3BwLVnXBHkc5dV9v8ZhShidwKIw4trhK21aU+r8aMcWxJfhVaPuykG1dTU8WdSNy
         c+ChPnUbdm1Px8fq76YiD8pnaDaiD+cegr9bDrkjFD0gPmBPJhlU/xDhRw+e7qyocUXT
         kI5btX1p5kv4c5CC8jEgvlt9FhTLA+9gqwAW1x6sHojzBFSJwnvr7NCDY3AQEYvW3XqW
         9OBQUqAIoMu7QtO4iKWyKT3eZTnWcECeYMMlGrjkgkDGF/xDrOtQl9QE9Clo2zfk6c11
         GNXKO8OZ/K9tybQTxDmW6zY+FNiJn6yBi5hCslwR/whwd36sPhkD0mAn2ghxCvNRo7Uy
         IvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746504; x=1780351304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7NKAW/ulkmG6NXCszZo+vmmRfLFaqedn1kwzn4OXVM=;
        b=bk6cNWK5sTSJ9i1SS32JsbHqXE0Sydc9jIA3wm6fB1lOJWpt2k7apoUTRNiqGWgMG9
         HpSlal3+pa88If7WgXuEDutAU2q5rqAqdEwiy5EbdiiYIjMEJM29Krv1nM5chhnB8PI+
         1Xs60eQqjxumzu2LRU3fsu0WvfKVxitcf3+JFnu/o8FsO3zN2/WBhAHjxjVkscnQewdv
         lXy3r7emyAcNVskwzcDTTT+xRzwYpwCRzw83xMFYDB+DHmN6miE63N1aKd+yfFBHJtBy
         M6eS6wy5twygzMfAchtxU2eBbPuimJ5CV3XgWEmRPncineNKxoUWU7FhaHo9408zQ1DP
         Sx1w==
X-Forwarded-Encrypted: i=1; AFNElJ+Jwh4SXeR6HROdHaNAjT/CQt1z3hOuR9febrjwOlM+OfqWgMm3VmMrEK/Naoc2FA8i5DC6Di23zuZUfNTS+dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLMZi6nS3/eve8cOyw6AHSOgj9/kkNGhdcI9Pxrdoo0JJv/kn
	Z5qKt4+9T4XwZ8jmDjOAPfR6ziuUdOSIPIFYQ7HPY/8famr5WAcVR3JY
X-Gm-Gg: Acq92OHVT1Ai8ICSUm3rQ891XTGA1Mm7oORcZjbpA4BNCydZr6oKu7XcdR7606hz6rA
	4T3QcDmUu4GGeDlUtRzkrmIiSpIcgLwJck3TcuDMBf813wLdruNUplVhOn4hCHB0zubgcbp8HU9
	W4VnxPl0h8V2Uqmdp8sPxn/Fv5kFu9lkGMC7vmrUK/5YCgKygHU+a8c0Eg00ri05X4Eb425fbtZ
	FI2grbh7xe0VNnoC7d7fCNGM/F1RCnKkJFkAogOpLd1HE+NJekZfnKKwQ2ImEB6VrTig/ELqZeQ
	2mkpfMWdvOn2qenYAv9d/HdcITkh6ArKwA/g+reeoNt6NiYkCImix1QxG53zfrqCHrBVVBmtAww
	nfiGEZyCcY0k57A73hrboilL8k8uvadQ1SAl+dRMzv9GDcXErRfT0sfC0VQxoRLG3ex8rrF00ee
	lxAa+cHbnCutFVK06dW0AF1rpf4H8sftBSNZfpIuCcE0r5PSzYsg/jPLK8KymQqrvnzCYD6/XCI
	qHPEkmzdtApB59yzkpVULHHdi8qQWSJxL8=
X-Received: by 2002:a05:6a20:d80f:b0:3a3:128f:1c77 with SMTP id adf61e73a8af0-3b329541ab3mr12825168637.12.1779746503829;
        Mon, 25 May 2026 15:01:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fe0bb8sm9526514b3a.51.2026.05.25.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:01:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linusw@kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-renesas-soc@vger.kernel.org (open list:PIN CONTROLLER - RENESAS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] pinctrl: rza2: embed pins in the priv struct
Date: Mon, 25 May 2026 15:01:26 -0700
Message-ID: <20260525220126.93990-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn the separately allocated pinctrl_pin_desc array into a flexible
array member of struct rza2_pinctrl_priv, annotated with
__counted_by(npins). The pin count is now computed before allocation so
struct_size() can size the combined object, collapsing two allocations
into one.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pinctrl/renesas/pinctrl-rza2.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 8618f32ed26a..42c228b860a4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -44,12 +44,12 @@ struct rza2_pinctrl_priv {
 	struct device *dev;
 	void __iomem *base;
 
-	struct pinctrl_pin_desc *pins;
 	struct pinctrl_desc desc;
 	struct pinctrl_dev *pctl;
 	struct pinctrl_gpio_range gpio_range;
 	int npins;
 	struct mutex mutex; /* serialize adding groups and functions */
+	struct pinctrl_pin_desc pins[] __counted_by(npins);
 };
 
 #define RZA2_PDR(port)		(0x0000 + (port) * 2)	/* Direction 16-bit */
@@ -289,21 +289,17 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 
 static int rza2_pinctrl_register(struct rza2_pinctrl_priv *priv)
 {
-	struct pinctrl_pin_desc *pins;
+	struct pinctrl_pin_desc *pin;
 	unsigned int i;
 	int ret;
 
-	pins = devm_kcalloc(priv->dev, priv->npins, sizeof(*pins), GFP_KERNEL);
-	if (!pins)
-		return -ENOMEM;
-
-	priv->pins = pins;
-	priv->desc.pins = pins;
+	priv->desc.pins = priv->pins;
 	priv->desc.npins = priv->npins;
 
 	for (i = 0; i < priv->npins; i++) {
-		pins[i].number = i;
-		pins[i].name = rza2_gpio_names[i];
+		pin = &priv->pins[i];
+		pin->number = i;
+		pin->name = rza2_gpio_names[i];
 	}
 
 	ret = devm_pinctrl_register_and_init(priv->dev, &priv->desc, priv,
@@ -482,12 +478,17 @@ static const struct pinmux_ops rza2_pinmux_ops = {
 static int rza2_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rza2_pinctrl_priv *priv;
+	int npins;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	npins = (int)(uintptr_t)of_device_get_match_data(&pdev->dev) *
+		      RZA2_PINS_PER_PORT;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, pins, npins), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->npins = npins;
 	priv->dev = &pdev->dev;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
@@ -498,9 +499,6 @@ static int rza2_pinctrl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->npins = (int)(uintptr_t)of_device_get_match_data(&pdev->dev) *
-		      RZA2_PINS_PER_PORT;
-
 	priv->desc.name		= DRIVER_NAME;
 	priv->desc.pctlops	= &rza2_pinctrl_ops;
 	priv->desc.pmxops	= &rza2_pinmux_ops;
-- 
2.54.0

