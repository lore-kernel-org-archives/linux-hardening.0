Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB82393DE2
	for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913418; cv=none; b=p14ZlOIASaCZzM870FDAnO6mHdwjJ5kLT3KMQ6gb+BWP0Jl6o52W0renw0RgOHMzoxkh9l5fJZD0EHGLzjLClLLFfwH1+YK+eesbzSA1VHDF5+LddoyEM+/3XhGG0ZuffE1+eXyQpPZWVk1mmJ2iYxVx0tTMN2HWSzmnI4cwiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913418; c=relaxed/simple;
	bh=BSWJULvoBmQ01varBYGhf90UhppUbekoIBkxkLvAH7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6my958zW36/sxT2vOuJdGQ5pqazKF4ip9iroolYEDUTCvfRXT0qthBYEplayokb7gYmvSWvE5b7uLQaDjUtypEHY5Y+B+p6R/socEKPZPzPbHrwOh2Yd2WUYDc6eZ4mVS/7aEkNKSnfRvgqSAQZ302nCriCK4Uva2jmkRQZWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No482oI8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No482oI8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8367df48711so5300466b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779913415; x=1780518215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn8TgOXEJPkKfmJoKgQlP84ES1byNpZd3Py/qzmBsUY=;
        b=No482oI898s9Z5JPjUgpl2nGRgXiOO88bE7K4NCkfLpS+HuTScs9ryGL+bOAe3meYX
         SGNaS2U03fwmrsQKNKUBfYCuKBY/2tMx1F1VF/hYAHlSFD+MiDBh7eHjunuM0jk75AIY
         PjYiIztNx1UAfSGdGgbkI20vDiVSSnf9p38VUjO7c/YfklxTlcq1V0uyI+JqGziMX4vu
         eZDhr905ks66pjBrhXtvokLl3SLiMYAdgO4Xwqn8OPHlSahAcuWkLrXewzH2lqZW+wnZ
         g0UtWtSKEf62Q7bk+EyuJsw8fKe3qkm4hKl5Px2uWNJBHgBNobGxBEpX3HW5hAlr8V2i
         HekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913415; x=1780518215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn8TgOXEJPkKfmJoKgQlP84ES1byNpZd3Py/qzmBsUY=;
        b=rSussPz3thH9EChsVUCtB/k8pt0rQ1s3oBAeXTzE1/4ovzQb/3biws8xxrxu3x9TgC
         86xPgtXn35V9Hm+5MfXD3xy72ESNL5Pb5+74tnEYhlYGpUtiZyDhJUjkB7IjWOfelVRz
         iSeOaY1Cgf0h9be+DkzEQvf9MJj1oWlyHlF8hUS0E6CqUTb1k5Mog6qBS2/6/5Kly3G9
         tekH+s1I5rfNSnWeI2+sca5c2gPAZ9QJvs/TfitTUMd6NAo14LIIYibgNMDmB9R309hj
         TTOshxNEp1suR0+8aWRIq5GYXu++km3McOdv1v9ULwjRajoala80iCjKTbRkBVN9di5u
         BIqw==
X-Forwarded-Encrypted: i=1; AFNElJ//Q/uJ0zk7OY8h2q3K7Kap7zSEpQUxB/k5AgX5SMUAovC/xpubknJqbzZiG5uVASbKVadviGt3rRxOkQVi0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAypqbVy09HroVaavwiT7gNtf5HHn+MGvOLgBIEtG0ytugs2ep
	DbtD4vySWzLAubxS3JhYIOAtuGh9e8KI8gehQSoc6OJLGOmQw1b9EmaI
X-Gm-Gg: Acq92OGjY/6F0z79yhunN0yJwqUW54MkpOp8uiRGVcEybjtIsdiTsc4wm/OZ2VNYdBQ
	0x4CVGqx1OnnzRmFLA1cun8vERQE/Do/40GlsFCJqirSXpSvYhRwgsqGWUa9nc2/QD01UzpKPWX
	TiZn9cFLDfgPpCFqOlFbubwZljjF02w39m+OELioQOGWrkM5b42yVx98CKFy2baBMl88G9n2dp2
	YruDP79OQebTxrN3RCem4V+tJcfVpwayUn9a9ijBfjyBgCLwTOkQYOZ0Och57RD8IMTlvDi42IE
	QOeaH5Wyhx6J0dDOHgwLBdkYeCdf8qfldXxV6Epza7KS+lR8AZF449UBJT5dE7qxRpbnlRV/xJX
	TGn3feMn60/oCYEyHEZdmOiB8NZKCgTvBSKrKLuO3Zo+fvv5aJUpAYjTQ24+X/QHQwkx9cOf/xv
	HzhIF5aiZW13oyV/6X1FDgzym03RbJPOFehyISQP12tXNWUKyRlvwWY7n28rQ9QQpvcYqrXbMT+
	9KHHmfy8zDQjYrbIXZPZ2cS+r4Sv2V04PaD0irf0CYWTbSkw15IBypD
X-Received: by 2002:a05:6a00:a92:b0:83b:b0c2:17ea with SMTP id d2e1a72fcca58-8415f544febmr23916071b3a.37.1779913415482;
        Wed, 27 May 2026 13:23:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e80269sm3330540b3a.4.2026.05.27.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:23:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-renesas-soc@vger.kernel.org (open list:PIN CONTROLLER - RENESAS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] pinctrl: rza2: embed pins in the priv struct
Date: Wed, 27 May 2026 13:23:17 -0700
Message-ID: <20260527202317.5347-1-rosenp@gmail.com>
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

Change npins to unsigned int to avoid potential overflow/underflow
errors.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use unsigned inr
 drivers/pinctrl/renesas/pinctrl-rza2.c | 28 ++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 8618f32ed26a..15ae5a88d705 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -44,12 +44,12 @@ struct rza2_pinctrl_priv {
 	struct device *dev;
 	void __iomem *base;

-	struct pinctrl_pin_desc *pins;
 	struct pinctrl_desc desc;
 	struct pinctrl_dev *pctl;
 	struct pinctrl_gpio_range gpio_range;
-	int npins;
+	unsigned int npins;
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
+	unsigned int npins;
 	int ret;

-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	npins = (uintptr_t)of_device_get_match_data(&pdev->dev) *
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

