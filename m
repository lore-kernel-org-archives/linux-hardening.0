Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F03E1204
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754975; cv=none; b=hKY9CBqo6OKEFq0xI//K+Tfd9tRMqkjHXia7SlrB3CWbLTx1m95ATCHI/iUwwi5UpSPjLacEQ5yJAvVLugeUV+VOiQaGgd5mWeyj9j5PqnM1wNs8n27hMah0SsYpM/ZYTFcIBd4PIrJNFZ77k+4WLTZ4butRmxbuc46bvDAvU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754975; c=relaxed/simple;
	bh=tMd/ZF1dqBUHYrTgfnm1wy21WqtdOBZaIx9oJy3Ul70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoRwmCI6qF1GxHD57M1bchLkcMF7l8wpV9HNq/RLXDQRSyOAKlFsfKTq6LP47kvGgg8B2UopQsW7XaMEGdJfrJYHV8JeBi3AXSP6nkJbjhpgEH8FjoAXrkvv00oCSiEKJOb0/n7+PnbmvzJtFFMNOo3PIwBTVIVmD4q1Eu9fVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0P8rV7j; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0P8rV7j"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so1116125a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754973; x=1776359773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSBVMuGXL0WQqebbrx7WWDDOhjtkic5Xp9QAINsntBY=;
        b=R0P8rV7jweycqwILWZbNLVTNjkFD1jObK9S8qWUXJnRbCRon0yGZ3oaoDDCqsqCzo+
         SUNTFD+52L803eV1rri7YDq9sPnGgbIHkMsUHgKYjFgFk89r2Xja0pIjelBbxFp/FeGX
         KE5z9eslz4bogyyR5xU6BZlM2sPwfqOf6lJWgogj/aUNExxpL5sdIgrSVOz9B6ra8oX0
         fPbGYUKQtbQpocTolULmNGqz8JUGhDak9zEoRHmFpSv5KvH0VnyWLevVmpJjbLZaV8aH
         9cK1W1dUEbVIM7Ejy/DBPc0CspGoWTNBLIM3ZyoSmm2BI9h+Vb4fg2SmnPAA2T3lCm4N
         f5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754973; x=1776359773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSBVMuGXL0WQqebbrx7WWDDOhjtkic5Xp9QAINsntBY=;
        b=S41UBBrNRFwgdqH8uRKexB7aP04/d0QcDCVcg8UXWOjIVQov6YtfCMfF9uxRX3A3di
         BpBo0XttaZLpCDY3p7cXO1SB0NffsS6QRYscO4GeZJN10zNXuQl1yoKiHh4Oh1FOowFh
         Ev67yUAC4ofRRLzKrNjNjdTUPYR3Sd7dP6MGaxvBE6cfSPr2lnR+tnLP8qfsgqjTHL6h
         v9L168KWiHhOCab90TQs+y+MNbBDK0I7hwW8k3iLzW6WgtlNBv42rOPMpAAcCoP9KIgz
         mlFtf3We1bWwvx1UK+9QfB3zVTMQ3xyHKACDL4rYnBYgCHs/58j71SzBfXArg7ClpFPk
         AL/A==
X-Forwarded-Encrypted: i=1; AJvYcCUmbaSlDSdS5N0r+MJBSKAf7MKl5wQmjoid5Nv2d1E1IHb07CF9gxNu1KZ/kY9wfAUPozUGFuU70mtwDXuE0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhidX1phCoQ5w3Ahdd3geR9qy9SIjAOocvRdPz6zhKE0cczvX
	Ce547fikSDrVQrTRPeead7aibItQ++brgarTsxe1ClAdFN0HxqN5twTA
X-Gm-Gg: AeBDietsmlDuQT6Nd5gqTmf9l+Zucv4Xk4KFeB5vI3fNGvmk5QEBP8sMEi3na/j88jx
	hkAcB81Q919RYbRD3scCeB1kqR43cREeW6+wZcPFBMu0d7C0KxTuJz/hdqkLtZpRdKlBN+c2w/6
	iAYsvGyBb0j7brgBEQklAEPQ9S/PJZSXJNeadBduBHpzB9tr+qT9lZ+hOBZkySRSPDTaY6cscFY
	0Q5fVxV5ypK4GpnWNnO+zwOYMh7lziBuXHg6Q16QzJ/3A9nOU1Ai7zFrQTngwO6QVNwh9ppheVH
	G/cpO7fMLr0p3jrcrmHNsqItX4czc2qMKFpVafK5TBjzTS0AyiRYjPRwLhLh6HjSGkQ8RtffbCj
	aRmUqaYPGrNlr0JxjIGM8hQPIq2bMqlbnE+J2npXLr5CXKH8kiCMUw1Scn4mWRFxfub36CgB+4y
	imZN2mja3UYrVtqNqFcNu+d2dFXjeMTfxSaIqsGG77kwNsTWZBkxViCrE=
X-Received: by 2002:a17:90a:d605:b0:35b:93d8:6aaa with SMTP id 98e67ed59e1d1-35de68ce83emr26197435a91.19.1775754973076;
        Thu, 09 Apr 2026 10:16:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34e959bcsm3591474a91.0.2026.04.09.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:16:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-leds@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] leds: qcom-lpg: allocate channels with main struct
Date: Thu,  9 Apr 2026 10:15:55 -0700
Message-ID: <20260409171555.14580-1-rosenp@gmail.com>
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
 v2: fix kernel-doc and missing data assignment
 drivers/leds/rgb/leds-qcom-lpg.c | 120 +++++++++++++++----------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f6061c47f863..d7d6518de30f 100644
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
@@ -203,8 +153,8 @@ struct lpg_channel {
  * @lpg:		lpg context reference
  * @cdev:		LED class device
  * @mcdev:		Multicolor LED class device
- * @num_channels:	number of @channels
  * @channels:		list of channels associated with the LED
+ * @num_channels:	number of @channels
  */
 struct lpg_led {
 	struct lpg *lpg;
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
+ * @num_channels: number of @channels
+ * @channels:	list of PWM channels
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
 
@@ -1603,18 +1596,21 @@ static int lpg_init_sdam(struct lpg *lpg)
 
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
+	lpg->data = data;
 	lpg->dev = &pdev->dev;
 	mutex_init(&lpg->lock);
 
-- 
2.53.0

