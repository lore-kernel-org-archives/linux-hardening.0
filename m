Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FE1C84A0
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979722; cv=none; b=Bdovte5Z52z3lXFP3ox9I9B6vzSPKOQTFfPWgLKz66qcp0T3o5E9F7vZ9TbAohvd0mfkI2hwZK+pHEx6DhrCaeOu4XbpjjMeDYtZ2f0e3Z6FBdnJy1cV13mZIaLEri7+7CiBVtGl9RaGh6IOA283K41bi6gbi+lkTHAEdx47/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979722; c=relaxed/simple;
	bh=Hs5JCVi/mDCoUp8T9yD6sHiPNpI9OAcvAkx6z54p0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7FfRVq1Q9VLFh9TEXE5yvWy8t05QmcvIYoMI7Vxxt/NZW50dbhpce4lLDJQdUSzWBhHTIwAuHlpPb+9jz67jzuAeSPCG8oFVw0AOMaqOdS8MAVVHf16Bp2cuEwygK/lWDvTztMAo07HpoR+GkfKvomQehxSTpSoRbAulzncc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoIh34cn; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoIh34cn"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c31ca77b4so202677d50.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773979720; x=1774584520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qXYjAYEG/7TdZTZTuXrafJ6evX5BXEzOr2dZP97xrw=;
        b=FoIh34cn5A4QYrPFj6riiJSMAqmdTsurN9HdQ3GjBIBzp0VG6BUAFckjIPSiahe9Eq
         zKnRVFlC0a7B88M7wdXqELpWk96HgenxFHxlCOQLf7082qllyyyxrTiAGQXFgk0fKZMi
         A2rKbZW/5DbGM7Cf24naDkquQajB0yjf202sKUilHm+whhp5JDPvvkY/GHmagleAOa9c
         HnBFKiMhCE5oUsrGBkHux0OqFKvp5WLGkci/Yk1VKCeeDswTTJPCKTW5VXglz8/FMAwI
         86yuTMJBWnmpdroQftitfZM6XNpMbORGLDeMBQU+aTVHvvZNEvsNk4yCSJYKKSW8eO/k
         iubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773979720; x=1774584520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qXYjAYEG/7TdZTZTuXrafJ6evX5BXEzOr2dZP97xrw=;
        b=U98pjqGRARCQxZad/wNxVQDAvcNWrOswGy2uV2BZAhc0KKBaLOw362HTaJzFg0OfHS
         dGdT1bRoJo1iXOgz4TL+UGCst0C6yxn+MLVnmSlPc6b2xlTGAhOMBpKW+4IZShr3CSy5
         PKP32cdddjf1HEFcdtnC3mYF3sI5rL3Nn2Jdq+uAfxomcghVWe/rWR4Kpkb9L54oLZrb
         3LaUKNJfHoUhAukj2siTvvJRk1ZAE12Z9jGDVmEpq+AKGdSI63lT/VZUGcnO5ErjtpWe
         WRQm1cebU1MKsrQ/K1Ooe/lq/dP5BQ452fmGz3LjvRihXU55tsMgYm+L4tMVVQ2aVKLf
         Ugkg==
X-Forwarded-Encrypted: i=1; AJvYcCXf6rnEVXaHs1DK9AOj8P7oePaEs6xEoNUbZGTPztyC9+jSbCO9NkUkbBGgtkfBU/mRKkN7NxgCnu70Jlv37vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZ6Yze40PH77tHGSSeFfTDLAMtCSucxEFmx1SwTTib+BNslFn
	BB+/gZgB0aRFBkBFEPKSwYgRpMvkvMH7m08X9XiNaxU44+G9r10qjb/2
X-Gm-Gg: ATEYQzyYSx80tw80WVpk3r85svxtJbTI+/DnweMEfhipAWOArTpTxOr31BYkUnSu+Hv
	UixttqKujI6k2jTjNJauFAP/WlMaIvnBqTHeCyE1QHpxsBKmUOqplJUp2W2r60YC9OxsNW/vxnS
	wxY9386c2fMX+pxKul1f/c1QjSVwzktp8WvKnPM11NKsr1UoakhWubbc9PdpbGwN0nfwE1KFA4e
	nvNfYigh5CBboSc8irdOeFJc+RNe5RB3KLvT64dUzv5KvBuOKYy1+ANG5z2AddfIbafnNcVJtmr
	qVJ7HtBYJ5LbrOJ/MaUmxczaldxO3J7x2w+CfxI3Yn6gaNycByCU47qt6M9x2y/6sjiY2kprxuy
	ducHCOUkTkCAedATalvljo7Vn0MUh1Qp19AtsED30PxzRasLiuMovDJ6N5tOzbggc/LfBTbTyi1
	sNBoDemK8mauYwIz67zK1TiTYEFAJEc9xZzDruL+CtNUACLTSklMdvpSDB8q92I1ZcZw==
X-Received: by 2002:a05:690e:e25:b0:649:c512:1422 with SMTP id 956f58d0204a3-64eaa77e9d1mr1564985d50.42.1773979720476;
        Thu, 19 Mar 2026 21:08:40 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabecdbd3sm717558d50.18.2026.03.19.21.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 21:08:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-leds@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] leds: pca955x: kzalloc + kcalloc to single kzalloc
Date: Thu, 19 Mar 2026 21:08:21 -0700
Message-ID: <20260320040821.46540-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fewer allocations as a result.

Required placing some structs before others as flexible array members
require a complete definition. Declaration is not enough.

Added __counted_by support for one of the structs for extra runtime
analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/leds/leds-pca955x.c | 45 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 2007fe6217ec..ee5f02eaa3c9 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -112,19 +112,6 @@ static const struct pca955x_chipdef pca955x_chipdefs[] = {
 	},
 };
 
-struct pca955x {
-	struct mutex lock;
-	struct pca955x_led *leds;
-	const struct pca955x_chipdef	*chipdef;
-	struct i2c_client	*client;
-	unsigned long active_blink;
-	unsigned long active_pins;
-	unsigned long blink_period;
-#ifdef CONFIG_LEDS_PCA955X_GPIO
-	struct gpio_chip gpio;
-#endif
-};
-
 struct pca955x_led {
 	struct pca955x	*pca955x;
 	struct led_classdev	led_cdev;
@@ -137,8 +124,21 @@ struct pca955x_led {
 #define led_to_pca955x(l)	container_of(l, struct pca955x_led, led_cdev)
 
 struct pca955x_platform_data {
-	struct pca955x_led	*leds;
 	int			num_leds;
+	struct pca955x_led	leds[] __counted_by(num_leds);
+};
+
+struct pca955x {
+	struct mutex lock;
+	const struct pca955x_chipdef	*chipdef;
+	struct i2c_client	*client;
+	unsigned long active_blink;
+	unsigned long active_pins;
+	unsigned long blink_period;
+#ifdef CONFIG_LEDS_PCA955X_GPIO
+	struct gpio_chip gpio;
+#endif
+	struct pca955x_led leds[];
 };
 
 /* 8 bits per input register */
@@ -542,15 +542,11 @@ pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 	if (count > chip->bits)
 		return ERR_PTR(-ENODEV);
 
-	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(&client->dev, struct_size(pdata, leds, chip->bits), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->leds = devm_kcalloc(&client->dev,
-				   chip->bits, sizeof(struct pca955x_led),
-				   GFP_KERNEL);
-	if (!pdata->leds)
-		return ERR_PTR(-ENOMEM);
+	pdata->num_leds = chip->bits;
 
 	device_for_each_child_node(&client->dev, child) {
 		u32 reg;
@@ -568,8 +564,6 @@ pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 		fwnode_property_read_u32(child, "type", &led->type);
 	}
 
-	pdata->num_leds = chip->bits;
-
 	return pdata;
 }
 
@@ -623,15 +617,10 @@ static int pca955x_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	pca955x = devm_kzalloc(&client->dev, sizeof(*pca955x), GFP_KERNEL);
+	pca955x = devm_kzalloc(&client->dev, struct_size(pca955x, leds, chip->bits), GFP_KERNEL);
 	if (!pca955x)
 		return -ENOMEM;
 
-	pca955x->leds = devm_kcalloc(&client->dev, chip->bits,
-				     sizeof(*pca955x_led), GFP_KERNEL);
-	if (!pca955x->leds)
-		return -ENOMEM;
-
 	i2c_set_clientdata(client, pca955x);
 
 	mutex_init(&pca955x->lock);
-- 
2.53.0

