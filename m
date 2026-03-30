Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458C3A1A5B
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905544; cv=none; b=Ztu4deDAm4b4jftGKS8YKEMDlkCzozEQYx8NBdi3bgMT77slZfvjzaCppWZdS6PA1jPHl96XAm/6uIM4JIUSFDb8HFUiw+Vu9FoNV61j+ChbMoxdfXori6JpdNkUltwt5np/M/DI2Sup2PTBCUlEuO7ye7K3g9cqbfOWUZeGCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905544; c=relaxed/simple;
	bh=PhRTmmrveIbs1YS6D0M0TYAfJEj9eHYwILWhDTlfj4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6l3zhmwIgs1WSx9Qo296kk09gzbjxTDlmXYZqLhxiSr/wBtYsNbueudCvRKx20oEVkPH9WZhhhjgxTu2EjZ+yFGRnE+H/TvG0jsXXdx7aPTblCmks7jQj02n7URV9FAOpp/eLmfJavEqNB2z3FrZPc/YcEnZezLfZm28y+wRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuNn7ri2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuNn7ri2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cd70febc7so207954b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905542; x=1775510342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTj819lvZos1BeuAanfcJHdbt5aBcVuD9J9vyYH7J9A=;
        b=LuNn7ri2cZ5kw23wWq2irMVUbHPKCqQSaykFpE+tc3zxDhkrIuluAlNHMxUFR82UhP
         9iot3Q6RZUmv++msGupsnQUgvvbgWxpeymWEkb8OWKFQT0S/IcmaHXZzGhLU88zpeOp/
         CvgI40zL+c5iKZEV3iShuBlqliluDhgZXItwyMvMSx3yKazt4dXtKG17gH9VXK2qNXBh
         HFRX7gweGBDSe6W/Abp6C0vYHv++qO8+IIhV2TUP/OghvlD5nKjDtNcC/LAOpGfSB111
         HW2xPr/2SFpKoppefg2sCtsTVyiVFzAUEqOJqtoenxc8KrJ46Vtg9Jokv4hKeqy2FyPp
         XB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905542; x=1775510342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTj819lvZos1BeuAanfcJHdbt5aBcVuD9J9vyYH7J9A=;
        b=fa9/dBYqVh6jJ/ha8MKecez/mh+Sh4O6NdPUhOk7E4eim/xHnojH4tCikgZrWDgA/x
         JKEAz9mcwRA74bZEKti0RZSrFPCxIhTahizYWh4GqrrgYHpAZQOYXEY+XdiMMpCGPIv2
         u/Qsu21q+GNiQjyMKZDhBEtParoq6Az8mLKtRxbivO/kENlWy0/S4YeDq6q0BU+RE5sJ
         nVZHW5lArJaMYYUnwd6N4rq54VcDwQV8jEvsCfL61bpg85dMuPLhAWpuxwZOXkWQqdRy
         PU/lzHcxA2+aoMMIHKbLFb0z6/mrVSpp2zinB3HpOAIMMDy51up31Dd2x9qtALJvzbsh
         N90w==
X-Forwarded-Encrypted: i=1; AJvYcCXClcish3Isxv/+mI3JdzX/EpwytO24Sq95zaJQSdK6ZiIxMED6Wy6zs5C5AUoF9K+O7nbnMtdx7q9p/lgjM6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oxaGvCy5Stgvb0pOKfBtzGcI0Z9TB0BUfR6BCmtLt6B+3LxM
	H2Nd6PPNz0em9+hOA38kLMiZRVPwVOpWToaFjHZLYpIpEhojQJrmgeYC
X-Gm-Gg: ATEYQzwUaZGSaI5aKJC3G2pZGA7hY7OGcbyVaUWSCp0lXF3QEXjl0UpULOe5FASWneN
	tCtbnL+aQeDRUbVn8rhyYLHV83AjLHwKpR0l7jiLuLLs4ugNQJKnzfPpfOV834TN/8ilwXGV7nw
	7qQYXAcvl6N+OZ5WsVo/P6ODzdZxkueaOwyXBYYrsY5ehM+5Qc/veW3HHb8IK2XjWfuJlKqJyIP
	DwLQiRGD4HmeggdZckL5P+3PPAk2hdI9XBdSAT0WGqXdwPuS6ytYgIdzBjnAa8PlDEu6TRvS/T9
	Pf5HryRYu1RXKIu3fA/iW3zqu+Hx5k9CCSRA8y8QZqNHkPYnUzH3eyMSfNb9M6eltBj/Ddm8Tgw
	CwDxycGpRHLrJ6CDkT/3W7SPCHZQtG3J7PY+4cSdB1w3hTRtLPZO3dVNTYkJ01UklszK8e7AZ1e
	l1fLfn60B5oxiz1xbiuhr+PcW87YYPkCtkLCIXdr/4qVW83++zJ4QdrirD92rNOZ4r+A==
X-Received: by 2002:a05:6a00:430c:b0:82a:1044:3563 with SMTP id d2e1a72fcca58-82c95d32c02mr12534654b3a.23.1774905542485;
        Mon, 30 Mar 2026 14:19:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc756sm7575756b3a.47.2026.03.30.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:19:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-leds@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] leds: qcom-lpg: allocate channels with main struct
Date: Mon, 30 Mar 2026 14:18:44 -0700
Message-ID: <20260330211844.14796-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc. This
required moving the struct lpg_channel definition up as flexible array
members require a full definition.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 117 +++++++++++++++----------------
 1 file changed, 56 insertions(+), 61 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f6061c47f863..83cedf4a0cbf 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -80,58 +80,8 @@
 #define SDAM_PAUSE_HI_MULTIPLIER_OFFSET	0x8
 #define SDAM_PAUSE_LO_MULTIPLIER_OFFSET	0x9
 
-struct lpg_channel;
 struct lpg_data;
 
-/**
- * struct lpg - LPG device context
- * @dev:	pointer to LPG device
- * @map:	regmap for register access
- * @lock:	used to synchronize LED and pwm callback requests
- * @pwm:	PWM-chip object, if operating in PWM mode
- * @data:	reference to version specific data
- * @lut_base:	base address of the LUT block (optional)
- * @lut_size:	number of entries in the LUT block
- * @lut_bitmap:	allocation bitmap for LUT entries
- * @pbs_dev:	PBS device
- * @lpg_chan_sdam:	LPG SDAM peripheral device
- * @lut_sdam:	LUT SDAM peripheral device
- * @pbs_en_bitmap:	bitmap for tracking PBS triggers
- * @triled_base: base address of the TRILED block (optional)
- * @triled_src:	power-source for the TRILED
- * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
- * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
- * @channels:	list of PWM channels
- * @num_channels: number of @channels
- */
-struct lpg {
-	struct device *dev;
-	struct regmap *map;
-
-	struct mutex lock;
-
-	struct pwm_chip *pwm;
-
-	const struct lpg_data *data;
-
-	u32 lut_base;
-	u32 lut_size;
-	unsigned long *lut_bitmap;
-
-	struct pbs_dev *pbs_dev;
-	struct nvmem_device *lpg_chan_sdam;
-	struct nvmem_device *lut_sdam;
-	unsigned long pbs_en_bitmap;
-
-	u32 triled_base;
-	u32 triled_src;
-	bool triled_has_atc_ctl;
-	bool triled_has_src_sel;
-
-	struct lpg_channel *channels;
-	unsigned int num_channels;
-};
-
 /**
  * struct lpg_channel - per channel data
  * @lpg:	reference to parent lpg
@@ -216,6 +166,55 @@ struct lpg_led {
 	struct lpg_channel *channels[] __counted_by(num_channels);
 };
 
+/**
+ * struct lpg - LPG device context
+ * @dev:	pointer to LPG device
+ * @map:	regmap for register access
+ * @lock:	used to synchronize LED and pwm callback requests
+ * @pwm:	PWM-chip object, if operating in PWM mode
+ * @data:	reference to version specific data
+ * @lut_base:	base address of the LUT block (optional)
+ * @lut_size:	number of entries in the LUT block
+ * @lut_bitmap:	allocation bitmap for LUT entries
+ * @pbs_dev:	PBS device
+ * @lpg_chan_sdam:	LPG SDAM peripheral device
+ * @lut_sdam:	LUT SDAM peripheral device
+ * @pbs_en_bitmap:	bitmap for tracking PBS triggers
+ * @triled_base: base address of the TRILED block (optional)
+ * @triled_src:	power-source for the TRILED
+ * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
+ * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
+ * @channels:	list of PWM channels
+ * @num_channels: number of @channels
+ */
+struct lpg {
+	struct device *dev;
+	struct regmap *map;
+
+	struct mutex lock;
+
+	struct pwm_chip *pwm;
+
+	const struct lpg_data *data;
+
+	u32 lut_base;
+	u32 lut_size;
+	unsigned long *lut_bitmap;
+
+	struct pbs_dev *pbs_dev;
+	struct nvmem_device *lpg_chan_sdam;
+	struct nvmem_device *lut_sdam;
+	unsigned long pbs_en_bitmap;
+
+	u32 triled_base;
+	u32 triled_src;
+	bool triled_has_atc_ctl;
+	bool triled_has_src_sel;
+
+	unsigned int num_channels;
+	struct lpg_channel channels[] __counted_by(num_channels);
+};
+
 /**
  * struct lpg_channel_data - per channel initialization data
  * @sdam_offset:	Channel offset in LPG SDAM
@@ -1475,12 +1474,6 @@ static int lpg_init_channels(struct lpg *lpg)
 	struct lpg_channel *chan;
 	int i;
 
-	lpg->num_channels = data->num_channels;
-	lpg->channels = devm_kcalloc(lpg->dev, data->num_channels,
-				     sizeof(struct lpg_channel), GFP_KERNEL);
-	if (!lpg->channels)
-		return -ENOMEM;
-
 	for (i = 0; i < data->num_channels; i++) {
 		chan = &lpg->channels[i];
 
@@ -1603,18 +1596,20 @@ static int lpg_init_sdam(struct lpg *lpg)
 
 static int lpg_probe(struct platform_device *pdev)
 {
+	const struct lpg_data *data;
 	struct lpg *lpg;
 	int ret;
 	int i;
 
-	lpg = devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
+
+	lpg = devm_kzalloc(&pdev->dev, struct_size(lpg, channels, data->num_channels), GFP_KERNEL);
 	if (!lpg)
 		return -ENOMEM;
 
-	lpg->data = of_device_get_match_data(&pdev->dev);
-	if (!lpg->data)
-		return -EINVAL;
-
+	lpg->num_channels = data->num_channels;
 	lpg->dev = &pdev->dev;
 	mutex_init(&lpg->lock);
 
-- 
2.53.0

