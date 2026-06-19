Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230F3BBFDF
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886098; cv=none; b=F6YPPxDEdEA2VHIv91SVrVDc6XYsFVRrgCFTqvKvWp27HGDLjtxOvClNL1Jd14RRMLQPULIuesU6EvBpNEtCFzzmweUgiMsevzqHmDuUXrJUqIQ4ZbNxDtwLqRf4m4ux3aGkGyg6A+OW9em7nbkdj+M1BmJ0A+dNYb2KQtBglR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886098; c=relaxed/simple;
	bh=U2WAIKvThUojolYwSCVcMGa5Kcqxc1gTXqpQ6Egod3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxGuYQqgLYiZODNo6aay2w1PJ6MrK0XDXyf9Cyi0xIKKxSuFWVd394MIC/zMCAJ9hBvpt2geXQAX5nhaZSxcYIUJJdYoY9b+9ZGe3Y+S4mbhUwZet7o4dZWO0punzh5ROah4QUg7PLuQSbJW7pFJoDehSPmyIVL2H5Kr1IsP5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXFEPkAg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXFEPkAg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so25631645e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886091; x=1782490891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JLehku4Fkdexd+dqxNctEZTCkpHEg/7niz9TvmxWYQ=;
        b=SXFEPkAgL+w6QXLFYJRXSAfTLpiwJl/fXVYe72cyILXgVM+J9fZGCwHvQbaML5yyl9
         whqAc/znKi4dh5fAWVwHQOXFNjKjYrwYZptK5+gqQgPWdpYRwP/GQ/HIcb+ZMPiKjBsk
         FFkNMcNgVosSKMRYHbWEHUsU0QyITGM9wEZgTQZm484zjEyAC8dyJGw5agOFQcOz3mf6
         GrPEMlkvp/VRxHPaC50ZMnKC04Le/NpAgA1hPhT5+rvLyFBt325fmGyBPDN7Y4sl3+Jv
         rpbVKWdnwaqhpUwkWqLni8qXItmPps1IZC4pPGNpUAJWI3f//e+vYKgjyRD67HQ3aEWu
         OxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886091; x=1782490891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JLehku4Fkdexd+dqxNctEZTCkpHEg/7niz9TvmxWYQ=;
        b=bwE8SAl9HdYWhey5I1tDC5Y8WLY1l1PF8QcqsN5lIp84Iq/bQTYpZot0vLSKq6ASvr
         p0uiIJeJ2NYSYSMPSQkIaYGR7sP0OXeqz8ACUWoNPAELXHNcvRpdPJRvauDKDeWXYT3X
         g76bSzV0sOL6TOQu2BGGiwJXnqehUfX4e9ml310RYJf33IgxS+t9qv4XevsvLn6s0esS
         t/RN6Ex+g2G3Ctlur5UdlMUiWG9npnf4MCJ4/tBZJ0i4QV1O7Ud+RegUgmFyjlY4rB7t
         pfPuUjTmjtV+fNpnUC4XoCkifBjyT/1xm5NsDvrRgT3LCiks9LXd4ToWZgqzS1UryLWi
         xUjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dJWvBB5fbBMuTh4tfTL2Z3PCpQBbouXENvrblVLh6uaxm6mZEQMxhHtPMJeLZrTak2Xly+y2cQ2YW8FsUJSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrgkmmjCCX5RRLpzTRP0nMC3ySzUoX7iMC3ZzA5JpFEcvSd3l
	PV1RfiWoOI7UYRHj1IxhibPkjRpQkHgnZh9qs7cSetkSc7LjhzC8P+QZ
X-Gm-Gg: AfdE7cmbNXtwNNGNO079MzjYKnwDAZlhgMG2NChbsPFazcFp2d/GbGr1/xXkvZpIl0T
	lKpbUhD9un4xY2UaKSmIJ+IYs2Jr0W7S4ylwbOvZoN5wbPHM5/+7SbArLR1SSykBJH3SOr4V5nk
	ySt11TI7FkiIh30Nm+0z6wNd9BmGdwwCmBwKXVvgbcCMdnKiIcwuVcHnlyp3OKSEpZYVCTf2Oh4
	LToRZXdKKuh1LOvj2mdzYYSwNPuM8c7IdxG49sydIY9Y2OimpeI6H/pVedOvjK34LlmrcCFdLMI
	/LeOGYCclfA8Wq+OlW3fPtcgJuycelgqzQhDq3fFkeNT+bNh8vY0kM0jjM1W7WBQI5lt8Yx6fhr
	CeRoibO2SxhZ4MvcYPT0O0W85lQ9TASd6/iiWZQrDLC012so2vjq5JANB7aeFZSlap4QZuMsqa4
	/VyvW7ZLG7O5GtqxL44qbl8wj6LvX9gmcTvFXMSZuFwxvWLghiSnQpDNcCCA7XjP78k5rBHCrJV
	sdSQ9CpD/OV3UWAmg==
X-Received: by 2002:a05:600c:5010:b0:490:e19b:9632 with SMTP id 5b1f17b1804b1-49240a59ademr57329915e9.17.1781886090506;
        Fri, 19 Jun 2026 09:21:30 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d507395ed9440fa268944f0f11.dip0.t-ipconnect.de. [2003:d5:739:5ed9:440f:a268:944f:f11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm80399585e9.7.2026.06.19.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:21:30 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>
Subject: [PATCH] leds: pwm: Annotate leds[] with __counted_by()
Date: Fri, 19 Jun 2026 18:21:13 +0200
Message-ID: <20260619162113.416864-1-mertsftl@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by() attribute to the flexible array member leds[] in
struct led_pwm_priv so the compiler and runtime (e.g. FORTIFY_SOURCE,
UBSAN_BOUNDS) can bounds-check accesses against num_leds.

For the annotation to be correct, num_leds must reflect the number of
allocated elements before leds[] is accessed. The driver already
allocates space for device_get_child_node_count() elements up front, so
set num_leds to that count right after allocation and fill the array by
explicit index, instead of incrementing num_leds as each LED is added.

No functional change intended.

Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
Build-tested only (also with FORTIFY_SOURCE and UBSAN_BOUNDS enabled).

 drivers/leds/leds-pwm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c1f2f50ff85..4c99a07da576 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -36,7 +36,7 @@ struct led_pwm_data {
 
 struct led_pwm_priv {
 	int num_leds;
-	struct led_pwm_data leds[];
+	struct led_pwm_data leds[] __counted_by(num_leds);
 };
 
 static int led_pwm_set(struct led_classdev *led_cdev,
@@ -82,9 +82,10 @@ static int led_pwm_default_brightness_get(struct fwnode_handle *fwnode,
 
 __attribute__((nonnull))
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
-		       struct led_pwm *led, struct fwnode_handle *fwnode)
+		       int idx, struct led_pwm *led,
+		       struct fwnode_handle *fwnode)
 {
-	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
+	struct led_pwm_data *led_data = &priv->leds[idx];
 	struct led_init_data init_data = { .fwnode = fwnode };
 	int ret;
 
@@ -167,14 +168,13 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		}
 	}
 
-	priv->num_leds++;
 	return 0;
 }
 
 static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 {
 	struct led_pwm led;
-	int ret;
+	int ret, i = 0;
 
 	device_for_each_child_node_scoped(dev, fwnode) {
 		memset(&led, 0, sizeof(led));
@@ -193,7 +193,7 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 
 		led.default_state = led_init_default_state_get(fwnode);
 
-		ret = led_pwm_add(dev, priv, &led, fwnode);
+		ret = led_pwm_add(dev, priv, i++, &led, fwnode);
 		if (ret)
 			return ret;
 	}
@@ -217,6 +217,8 @@ static int led_pwm_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_leds = count;
+
 	ret = led_pwm_create_fwnode(&pdev->dev, priv);
 
 	if (ret)
-- 
2.54.0

