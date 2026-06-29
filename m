Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBD8472
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703921; cv=none; b=nZm7VueEQJNvutqbCQKWx1tMpXAWTwGSsAmOj5Bxe0iehmoJItsafoxWD75m9W9PAcMLNUJ0rrrk5l8XCYCiXmL00YcsPOcx77/8whEWKpcly89vvUrn7vAAL7NdLwyDiCt6sVtPNhE+dkK1lpBbvGNr+uugY0PdLmgEnTG5180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703921; c=relaxed/simple;
	bh=9k4RkclFritAkzoZy07kM+pXgxaZlSZ9BAtKis/9+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxyBYTDg2vSE/Ii1CT4tH1YN6qfgFAHMnmpD2Gjzg1drmo5Tc3BS002KzqKAv47jD/t+aeHrPqK9k3Uqj1AaaEhqjBvba4Mq32lUQMjZOv70kbWIaMBlPQkrZKoM0OfMrN72X6hcZezvbs1NaWKB3EjzDxbNUl7dJnicZ7/8+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMZTp+7M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMZTp+7M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca11143dbbso810755ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 28 Jun 2026 20:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703919; x=1783308719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LC6ibcb4fBz4HS0hDrSYuTYh0saDn6KPejFghovjxq8=;
        b=KMZTp+7MG7TX7tTqiBTPE+AW4l5P5u6N+bluLZDOAArruBYpX43uNX+AaColVVlJL6
         MMoHxCAxQYp7oKE4YPFTxF8kq6E6Xeed6v2S1UApWOTkG4666ZgRN/uuf0UfMeWTzIGx
         x8beo8FBdz/v8OStB/TUrA0XFzoEHp4eAqNRtudyjBgRMTMdWK3yKeTxLzGUrgJAItiF
         Dnt9+7ueILxLM5lPafAQU6g9LMVy1UQbStFp0rp3uOAo0uE5/v/9TeG2NmCnkw+oPvYB
         iWb/f+8jsMoetRciuE3tujlTb0Gqw3L5FHn6q+t6MSxVEWYOTpwvNCQM0pe+IKDKHcF9
         xiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703919; x=1783308719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC6ibcb4fBz4HS0hDrSYuTYh0saDn6KPejFghovjxq8=;
        b=G9sjvieVcjw2oliaFQC+xWgKdSe5mxy/VCuWNK/zm+wzi2a7eKTgd1Omu1SkfHYGTg
         2I+j2AJJSDRUxgrj1VSwpc14zXLvaWfBaYcI0EoQTQ3Rp+5XUOjfFMmeik6Whwz7Vj8X
         yu1Z63hGdAO+3iYsd6HVPo8am7lonAiDeb9f+Y5Iw3Fgh9MVXv31F7apmdmtR3BQe0o4
         X3nP/quudqrNpLpnsFvajLalfKW7GMIcaQln3SoyRSvDWPhA2++EIrnxS/eiRrILoVU8
         dSOKsdZ06Ufbal/4IcS9oQqYhjquqSKmmKMrpAXgdsqOM9cmNdRAeS6B9Mle0lrvg+Lw
         m7OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMvg2jdUi7VLs28ezLy/u2zFLQZq9dM44KU9kJJ/VrJ5bQNAVu9JgQYG9Vi8538oL1+0sBPF4miJNcSvTQz7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwA9xasss+/T1Tt/3YypLoAWcB/AtddlJu1xm6S81OWrg2KMC6
	iX/+MMO7VaxIWXQCNLxm7SQdOLkLxJ8/spHWfpiYQiV+VBWPkYlzFBybAjcqCKZI
X-Gm-Gg: AfdE7cmaxNPBibNlgPuAxDe8CLjYdfzz6gsdT2zNcz+446MVIUZTZZej0jxMihu3pFe
	9R6r1Cp/QDE5MU0xJNasscknZwr4Ad4o03zsWb7W8TnnGvhC3nNunYCLKCEVXVFugVJtF34W1VU
	/7NwI7JkR7PWLZu+9uCdxnYdyVwrsj/G2Wbni+bxtt0M+quetOvVxYUKy/gWLzNEqPbZQyfjp+a
	2jxoxvkBCa9iP6mTf7Gxkj/40u4ineCTZaq+Oqdba470LFyk7/LkkGk/YBVzbOAe0I2RlEfYjG9
	ZIcaMXtwktGta+fKKx5kv7zoMSEGQEnyvQOlreUA6mTBScTPxXuFfDLVhmWvkbz6jz+eXVXlEO5
	7XpQ4r5E9vxnYTLopbwvmbu0x4hFm0fvKa07+J9SKUIcypy45LvLr9u0hTsG4ES+L/J72aO+elN
	wXnQkZm12VYmbw4BJIiKMBlNPtyLfBii5HHvodzKwffP9dgNpc4NkyWapxAfoPwkgGRQ0hgbZtk
	G47DPKluA==
X-Received: by 2002:a17:902:d58d:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2c7fc742693mr149837835ad.28.1782703918499;
        Sun, 28 Jun 2026 20:31:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c99f2905e76sm975994a12.10.2026.06.28.20.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:31:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: rt2x00: Use flexible array for hw_mode_spec channels
Date: Sun, 28 Jun 2026 20:31:56 -0700
Message-ID: <20260629033156.2363850-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct hw_mode_spec stores channel information that is allocated by the
individual rt2x00 drivers during hardware probing.  The channel info
array has the same lifetime as the hardware mode specification, but it
is currently allocated separately and then freed through a separate
pointer.

Make struct rt2x00_dev hold a pointer to the hardware mode
specification, store the channel info as a flexible array member, and
allocate both pieces together with kzalloc_flex().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2400pci.c    | 24 +++---
 .../net/wireless/ralink/rt2x00/rt2500pci.c    | 55 ++++++++------
 .../net/wireless/ralink/rt2x00/rt2500usb.c    | 55 ++++++++------
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 74 ++++++++++---------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  4 +-
 .../net/wireless/ralink/rt2x00/rt2x00config.c | 12 +--
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  4 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  | 42 ++++++-----
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  | 50 +++++++------
 9 files changed, 177 insertions(+), 143 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index cac191304bf5..3fb74dcbee63 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1559,7 +1559,7 @@ static const struct rf_channel rf_vals_b[] = {
 
 static int rt2400pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1580,27 +1580,25 @@ static int rt2400pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK;
+	spec = kzalloc_flex(*spec, channels_info, ARRAY_SIZE(rf_vals_b));
+	if (!spec)
+		return -ENOMEM;
 
 	spec->num_channels = ARRAY_SIZE(rf_vals_b);
 	spec->channels = rf_vals_b;
 
-	/*
-	 * Create channel information array
-	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
-		return -ENOMEM;
-
-	spec->channels_info = info;
+	spec->supported_bands = SUPPORT_BAND_2GHZ;
+	spec->supported_rates = SUPPORT_RATE_CCK;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = TXPOWER_FROM_DEV(MAX_TXPOWER);
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = TXPOWER_FROM_DEV(MAX_TXPOWER);
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index fc35b60e422c..4c85f401c091 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -1854,7 +1854,10 @@ static const struct rf_channel rf_vals_5222[] = {
 
 static int rt2500pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1880,52 +1883,58 @@ static int rt2500pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2522)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2522);
-		spec->channels = rf_vals_bg_2522;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2522);
+		channels = rf_vals_bg_2522;
 	} else if (rt2x00_rf(rt2x00dev, RF2523)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2523);
-		spec->channels = rf_vals_bg_2523;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2523);
+		channels = rf_vals_bg_2523;
 	} else if (rt2x00_rf(rt2x00dev, RF2524)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2524);
-		spec->channels = rf_vals_bg_2524;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2524);
+		channels = rf_vals_bg_2524;
 	} else if (rt2x00_rf(rt2x00dev, RF2525)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525);
-		spec->channels = rf_vals_bg_2525;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525);
+		channels = rf_vals_bg_2525;
 	} else if (rt2x00_rf(rt2x00dev, RF2525E)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
-		spec->channels = rf_vals_bg_2525e;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
+		channels = rf_vals_bg_2525e;
 	} else if (rt2x00_rf(rt2x00dev, RF5222)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5222);
-		spec->channels = rf_vals_5222;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5222);
+		channels = rf_vals_5222;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 = DEFAULT_TXPOWER;
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = DEFAULT_TXPOWER;
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index 58728df6666c..cbc1c1399cc6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -1661,7 +1661,10 @@ static const struct rf_channel rf_vals_5222[] = {
 
 static int rt2500usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -1693,52 +1696,58 @@ static int rt2500usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2522)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2522);
-		spec->channels = rf_vals_bg_2522;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2522);
+		channels = rf_vals_bg_2522;
 	} else if (rt2x00_rf(rt2x00dev, RF2523)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2523);
-		spec->channels = rf_vals_bg_2523;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2523);
+		channels = rf_vals_bg_2523;
 	} else if (rt2x00_rf(rt2x00dev, RF2524)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2524);
-		spec->channels = rf_vals_bg_2524;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2524);
+		channels = rf_vals_bg_2524;
 	} else if (rt2x00_rf(rt2x00dev, RF2525)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525);
-		spec->channels = rf_vals_bg_2525;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525);
+		channels = rf_vals_bg_2525;
 	} else if (rt2x00_rf(rt2x00dev, RF2525E)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
-		spec->channels = rf_vals_bg_2525e;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2525e);
+		channels = rf_vals_bg_2525e;
 	} else if (rt2x00_rf(rt2x00dev, RF5222)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5222);
-		spec->channels = rf_vals_5222;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5222);
+		channels = rf_vals_5222;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 = DEFAULT_TXPOWER;
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = DEFAULT_TXPOWER;
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 97290899674e..7b7f6dcc9247 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -11778,7 +11778,9 @@ static const struct rf_channel rf_vals_7620[] = {
 
 static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	s8 *default_power1;
 	s8 *default_power2;
@@ -11840,19 +11842,17 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
-
 	switch (rt2x00dev->chip.rf) {
 	case RF2720:
 	case RF2820:
-		spec->num_channels = 14;
-		spec->channels = rf_vals;
+		num_channels = 14;
+		channels = rf_vals;
 		break;
 
 	case RF2750:
 	case RF2850:
-		spec->num_channels = ARRAY_SIZE(rf_vals);
-		spec->channels = rf_vals;
+		num_channels = ARRAY_SIZE(rf_vals);
+		channels = rf_vals;
 		break;
 
 	case RF2020:
@@ -11870,44 +11870,52 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	case RF5372:
 	case RF5390:
 	case RF5392:
-		spec->num_channels = 14;
+		num_channels = 14;
 		if (rt2800_clk_is_20mhz(rt2x00dev))
-			spec->channels = rf_vals_3x_xtal20;
+			channels = rf_vals_3x_xtal20;
 		else
-			spec->channels = rf_vals_3x;
+			channels = rf_vals_3x;
 		break;
 
 	case RF7620:
-		spec->num_channels = ARRAY_SIZE(rf_vals_7620);
-		spec->channels = rf_vals_7620;
+		num_channels = ARRAY_SIZE(rf_vals_7620);
+		channels = rf_vals_7620;
 		break;
 
 	case RF3052:
 	case RF3053:
-		spec->num_channels = ARRAY_SIZE(rf_vals_3x);
-		spec->channels = rf_vals_3x;
+		num_channels = ARRAY_SIZE(rf_vals_3x);
+		channels = rf_vals_3x;
 		break;
 
 	case RF3853:
-		spec->num_channels = ARRAY_SIZE(rf_vals_3853);
-		spec->channels = rf_vals_3853;
+		num_channels = ARRAY_SIZE(rf_vals_3853);
+		channels = rf_vals_3853;
 		break;
 
 	case RF5592:
 		reg = rt2800_register_read(rt2x00dev, MAC_DEBUG_INDEX);
 		if (rt2x00_get_field32(reg, MAC_DEBUG_INDEX_XTAL)) {
-			spec->num_channels = ARRAY_SIZE(rf_vals_5592_xtal40);
-			spec->channels = rf_vals_5592_xtal40;
+			num_channels = ARRAY_SIZE(rf_vals_5592_xtal40);
+			channels = rf_vals_5592_xtal40;
 		} else {
-			spec->num_channels = ARRAY_SIZE(rf_vals_5592_xtal20);
-			spec->channels = rf_vals_5592_xtal20;
+			num_channels = ARRAY_SIZE(rf_vals_5592_xtal20);
+			channels = rf_vals_5592_xtal20;
 		}
 		break;
 	}
 
-	if (WARN_ON_ONCE(!spec->channels))
+	if (WARN_ON_ONCE(!channels))
 		return -ENODEV;
 
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
+		return -ENOMEM;
+
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+
 	spec->supported_bands = SUPPORT_BAND_2GHZ;
 	if (spec->num_channels > 14)
 		spec->supported_bands |= SUPPORT_BAND_5GHZ;
@@ -11959,19 +11967,13 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Create channel information and survey arrays
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
-		return -ENOMEM;
-
 	rt2x00dev->chan_survey =
 		kzalloc_objs(struct rt2x00_chan_survey, spec->num_channels);
 	if (!rt2x00dev->chan_survey) {
-		kfree(info);
+		kfree(spec);
 		return -ENOMEM;
 	}
 
-	spec->channels_info = info;
-
 	default_power1 = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
 	default_power2 = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
 
@@ -11982,10 +11984,11 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 		default_power3 = NULL;
 
 	for (i = 0; i < 14; i++) {
-		info[i].default_power1 = default_power1[i];
-		info[i].default_power2 = default_power2[i];
+		info = &spec->channels_info[i];
+		info->default_power1 = default_power1[i];
+		info->default_power2 = default_power2[i];
 		if (default_power3)
-			info[i].default_power3 = default_power3[i];
+			info->default_power3 = default_power3[i];
 	}
 
 	if (spec->num_channels > 14) {
@@ -12002,10 +12005,11 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 			default_power3 = NULL;
 
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].default_power1 = default_power1[i - 14];
-			info[i].default_power2 = default_power2[i - 14];
+			info = &spec->channels_info[i];
+			info->default_power1 = default_power1[i - 14];
+			info->default_power2 = default_power2[i - 14];
 			if (default_power3)
-				info[i].default_power3 = default_power3[i - 14];
+				info->default_power3 = default_power3[i - 14];
 		}
 	}
 
@@ -12033,6 +12037,8 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 		break;
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 7d313e86d3f2..babc04210a65 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -404,9 +404,9 @@ struct hw_mode_spec {
 
 	unsigned int num_channels;
 	const struct rf_channel *channels;
-	const struct channel_info *channels_info;
 
 	struct ieee80211_sta_ht_cap ht;
+	struct channel_info channels_info[] __counted_by(num_channels);
 };
 
 /*
@@ -802,7 +802,7 @@ struct rt2x00_dev {
 	/*
 	 * hw capability specifications.
 	 */
-	struct hw_mode_spec spec;
+	struct hw_mode_spec *spec;
 
 	/*
 	 * This is the default TX/RX antenna setup as indicated
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
index f895f560a185..b97cb67c4361 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
@@ -165,7 +165,7 @@ void rt2x00lib_config_antenna(struct rt2x00_dev *rt2x00dev,
 static u16 rt2x00ht_center_channel(struct rt2x00_dev *rt2x00dev,
 				   struct ieee80211_conf *conf)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	int center_channel;
 	u16 i;
 
@@ -194,6 +194,7 @@ void rt2x00lib_config(struct rt2x00_dev *rt2x00dev,
 		      struct ieee80211_conf *conf,
 		      unsigned int ieee80211_flags)
 {
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	struct rt2x00lib_conf libconf;
 	u16 hw_value;
 	u16 autowake_timeout;
@@ -218,13 +219,8 @@ void rt2x00lib_config(struct rt2x00_dev *rt2x00dev,
 			hw_value = conf->chandef.chan->hw_value;
 		}
 
-		memcpy(&libconf.rf,
-		       &rt2x00dev->spec.channels[hw_value],
-		       sizeof(libconf.rf));
-
-		memcpy(&libconf.channel,
-		       &rt2x00dev->spec.channels_info[hw_value],
-		       sizeof(libconf.channel));
+		memcpy(&libconf.rf, &spec->channels[hw_value], sizeof(libconf.rf));
+		memcpy(&libconf.channel, &spec->channels_info[hw_value], sizeof(libconf.channel));
 
 		/* Used for VCO periodic calibration */
 		rt2x00dev->rf_channel = libconf.rf.channel;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index edc1f8eac747..3ffbc8aabbae 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1097,7 +1097,7 @@ static void rt2x00lib_remove_hw(struct rt2x00_dev *rt2x00dev)
 		rt2x00dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
 	}
 
-	kfree(rt2x00dev->spec.channels_info);
+	kfree(rt2x00dev->spec);
 	kfree(rt2x00dev->chan_survey);
 }
 
@@ -1116,7 +1116,7 @@ static const struct ieee80211_tpt_blink rt2x00_tpt_blink[] = {
 
 static int rt2x00lib_probe_hw(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	struct hw_mode_spec *spec = rt2x00dev->spec;
 	int status;
 
 	if (test_bit(DEVICE_STATE_REGISTERED_HW, &rt2x00dev->flags))
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 79e1fd0a1fbd..479825f8bba9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2654,7 +2654,10 @@ static const struct rf_channel rf_vals_seq[] = {
 
 static int rt61pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -2693,46 +2696,51 @@ static int rt61pci_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (!rt2x00_has_cap_rf_sequence(rt2x00dev)) {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_noseq;
+		num_channels = 14;
+		channels = rf_vals_noseq;
 	} else {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_seq;
+		num_channels = 14;
+		channels = rf_vals_seq;
 	}
 
 	if (rt2x00_rf(rt2x00dev, RF5225) || rt2x00_rf(rt2x00dev, RF5325)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_seq);
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_seq);
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_G_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_A_START);
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 =
-					TXPOWER_FROM_DEV(tx_power[i - 14]);
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = TXPOWER_FROM_DEV(tx_power[i - 14]);
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index d6b7174d087a..17338378329b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2088,7 +2088,10 @@ static const struct rf_channel rf_vals_5225_2527[] = {
 
 static int rt73usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 {
-	struct hw_mode_spec *spec = &rt2x00dev->spec;
+	const struct rf_channel *channels;
+	unsigned int num_channels = 0;
+	unsigned int supported_bands;
+	struct hw_mode_spec *spec;
 	struct channel_info *info;
 	u8 *tx_power;
 	unsigned int i;
@@ -2114,49 +2117,54 @@ static int rt73usb_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Initialize hw_mode information.
 	 */
-	spec->supported_bands = SUPPORT_BAND_2GHZ;
-	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
+	supported_bands = SUPPORT_BAND_2GHZ;
 
 	if (rt2x00_rf(rt2x00dev, RF2528)) {
-		spec->num_channels = ARRAY_SIZE(rf_vals_bg_2528);
-		spec->channels = rf_vals_bg_2528;
+		num_channels = ARRAY_SIZE(rf_vals_bg_2528);
+		channels = rf_vals_bg_2528;
 	} else if (rt2x00_rf(rt2x00dev, RF5226)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5226);
-		spec->channels = rf_vals_5226;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5226);
+		channels = rf_vals_5226;
 	} else if (rt2x00_rf(rt2x00dev, RF2527)) {
-		spec->num_channels = 14;
-		spec->channels = rf_vals_5225_2527;
+		num_channels = 14;
+		channels = rf_vals_5225_2527;
 	} else if (rt2x00_rf(rt2x00dev, RF5225)) {
-		spec->supported_bands |= SUPPORT_BAND_5GHZ;
-		spec->num_channels = ARRAY_SIZE(rf_vals_5225_2527);
-		spec->channels = rf_vals_5225_2527;
+		supported_bands |= SUPPORT_BAND_5GHZ;
+		num_channels = ARRAY_SIZE(rf_vals_5225_2527);
+		channels = rf_vals_5225_2527;
 	}
 
 	/*
 	 * Create channel information array
 	 */
-	info = kzalloc_objs(*info, spec->num_channels);
-	if (!info)
+	spec = kzalloc_flex(*spec, channels_info, num_channels);
+	if (!spec)
 		return -ENOMEM;
 
-	spec->channels_info = info;
+	spec->num_channels = num_channels;
+	spec->channels = channels;
+	spec->supported_bands = supported_bands;
+	spec->supported_rates = SUPPORT_RATE_CCK | SUPPORT_RATE_OFDM;
 
 	tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_G_START);
 	for (i = 0; i < 14; i++) {
-		info[i].max_power = MAX_TXPOWER;
-		info[i].default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
+		info = &spec->channels_info[i];
+		info->max_power = MAX_TXPOWER;
+		info->default_power1 = TXPOWER_FROM_DEV(tx_power[i]);
 	}
 
 	if (spec->num_channels > 14) {
 		tx_power = rt2x00_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_A_START);
 		for (i = 14; i < spec->num_channels; i++) {
-			info[i].max_power = MAX_TXPOWER;
-			info[i].default_power1 =
-					TXPOWER_FROM_DEV(tx_power[i - 14]);
+			info = &spec->channels_info[i];
+			info->max_power = MAX_TXPOWER;
+			info->default_power1 = TXPOWER_FROM_DEV(tx_power[i - 14]);
 		}
 	}
 
+	rt2x00dev->spec = spec;
+
 	return 0;
 }
 
-- 
2.54.0

