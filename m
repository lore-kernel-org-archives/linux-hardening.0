Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042983BCD0B
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666928; cv=none; b=GA85Uq1eW5YlQAzMu7w+89dc3i2mfoPeiLPeE5W1KVuYv3oJz09JLdMwg6cyR2lc4zCS3EtjzogQdyn5ui9BGVE+2Ds3XhDuoNf0P2Gxe9m9Vrdmp1/1xbenlsNcDTMBVVmEDX+YP6own5Bx2scCVQmGfWKI82kH0iRVwxT3728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666928; c=relaxed/simple;
	bh=Sa+ZMM5dTNjCDBOF2MATzUebRnFH0dCZpZVATJCDrms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTWZ7xkXyKLzQuhz7419ggcPQLCyC4EX0cZNFzDBSeI1iyp6FJEEOD7LW9uymbI+hAYS3zVoBqj7rDIfK/e3W0XBm8Sj82Wr3Mg6CX4OnOo3uR+NtZeUtOW2G0ZfwB/w1p49pNRX89YDAhDlN6elJd4sF9O2LPt55ieGpT4JTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c52/M0At; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c52/M0At"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso3176465e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783666914; x=1784271714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiDkE10v4AFJNJVFDsx15gyYeOOnHnd5nJ5DdCHOga8=;
        b=c52/M0AtYHCt4A4mpXCzRxUMWSrQTiBMZvwthstSEIB0CgkZWvQzVdqLLEpMxjYeFB
         RdVou8ykYChLgBI8lBeP47hPme5JjwijCumbldghHwpJ8imGxCLiNaXC1o8EJGmBXSMy
         C4JTIpGQM7USho9FMz0LRec3Dj8WvibME8IvmPBJVCUFwInb39oH1U+BtqgZ1VFs6ifn
         0NgLQKcnpMwDCjJzUzwDs6FRfgwDlRLayIkUt6VSgGNz0U4DGq8GJm6E+ah03IdmstWP
         cl1oyT+9s0vWAKBnHjcCzVGLKUjRp37e96jLNv1Vc7Ap2sm9ph+DoB2kMAtu7UKzjYWu
         MHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783666914; x=1784271714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiDkE10v4AFJNJVFDsx15gyYeOOnHnd5nJ5DdCHOga8=;
        b=l/9i+fHWYxkZGg3dm16UT12AnvlMbaEMrjBvWP0jQfB9QghjGNWeZ0c+HLHt/4ftx4
         ZemW9QfVnHSxqB1+68PQwkRhaLvXN8d1YlZCrPCIiDuwwDWiZMhlpdPX/Yu4xuNosV8M
         NnTLouK6foSTM3jlHhp77sqWOEIepZaVRZ4vlRwpmYwxeXLX0KQEzi1e9nJSqao4M2dy
         evt2JzLp2vTIwEm+tDnfEXitizamzjbOuClz5mq0f4M6LtCYHT3xbhotYgBRjbi19A7e
         L8l0Ae8eTO3P7YwLBH35Y56Fe4xEi2kgUw71K0/wdsGL5q/HA0G9Nu7t61LPmpScGz9C
         R1hA==
X-Forwarded-Encrypted: i=1; AHgh+RqrW7Cvt2WCTbxZ90QJlHvKkX4B6kBmbzapGSkZQJVhSx1CECxLYXKn5XdDxc6bkiNOIZwgiy1tOD5BK/80cec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4K4Nbtd6xjWKDynzJW4FI3zbJdQbZ7qFelTCkqyFqJxJ5r2aw
	y/fi9oZlqcrsLf3uaIdpqrSxR4o+KKrEJ0lJBunOELDsNCYL8VgJ1MdpYDE2REgT
X-Gm-Gg: AfdE7ckracz4isTs7ZynGI/1MwElMRH5mm4nM3k0eB4OmQxJOSXFBN+JU5q0wt7rn/T
	G646dkbITZPE7+zy89DruyQAIjk9BxEjnJsjqmmZEYpF03EtYyEr4SsQwHwy+Fhr5E63ZpuyoDD
	MB1YxZWTjZ75IE5XZlhvUU7N2Kmz8d2LHd0sOGAQhW1NdT431dHDFu8s/pHCjsAiE04eOjMI34X
	yG7f7a8j9musYeBccjiwFKTWPVt9CL8L5+KJMdlUaBS9ggVUJMlxogN8fajc+nccOgPXroi7hBm
	J9M2GAciBMIk6VfvM2wqAWiRicZhECiu+bAnj7fvdihjdxBmZ/eIUy/oQvNV5rk2Zvu11wz145I
	iPxGKkwwoUskN95VZEhSAKhJkAzdJODy8TI9AMuIXs+HK3ohFJwSrxKOjBsh+jmyYOCc9bgYN7K
	oX1cdAMIzoqvPtpxTTrtdU9FNiP3+fa8ep7VhpEuli55sURQM1ZwMIPowf4Y7ItQedsJ5LLpMoC
	xq5QnlMGec/REuSou0=
X-Received: by 2002:a05:600c:3e11:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-493e6904b5dmr108220295e9.16.1783666913698;
        Fri, 10 Jul 2026 00:01:53 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d5070afe7db3148fa84ed2ac78.dip0.t-ipconnect.de. [2003:d5:70a:fe7d:b314:8fa8:4ed2:ac78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742d0esm114245665e9.13.2026.07.10.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:01:53 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>
Subject: [PATCH v3] leds: pwm: Annotate leds[] with __counted_by()
Date: Fri, 10 Jul 2026 09:01:41 +0200
Message-ID: <20260710070141.37214-1-mertsftl@gmail.com>
X-Mailer: git-send-email 2.55.0
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

For the annotation to be correct, num_leds must equal the number of
allocated elements before leds[] is accessed. Even taking the address
&priv->leds[i] is bounds-checked against num_leds under UBSAN_BOUNDS. The
driver allocates device_get_child_node_count() elements up front, so set
num_leds to that count right after allocation.

While here, pass the led_pwm_data element into led_pwm_add() instead of
the whole led_pwm_priv, so the helper no longer needs to index the array;
the caller walks a led_pwm_data pointer over priv->leds.

No functional change intended.

Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
Changes in v3:
- v2 followed the review suggestion to pass the element and increment
  num_leds in the caller. That is exactly what Sashiko caught: with
  __counted_by(num_leds), &priv->leds[num_leds] is bounds-checked, so
  incrementing num_leds from 0 as the loop runs trips UBSAN_BOUNDS on
  probe. num_leds is now set to the full count up front and the caller
  walks a led_pwm_data pointer, which keeps the element-passing and the
  dropped index variable, just without the running counter.

Changes in v2 (per Lee Jones review):
- Pass the led_pwm_data element into led_pwm_add() so it drops the priv and
  index arguments.

Build-tested only (no PWM-LED hardware). The __counted_by bounds behaviour
that motivated v3 was verified with a standalone UBSAN reproducer on gcc and
clang.

 drivers/leds/leds-pwm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c1f2f50ff85..d1116a5cb2b2 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -36,7 +36,7 @@ struct led_pwm_data {
 
 struct led_pwm_priv {
 	int num_leds;
-	struct led_pwm_data leds[];
+	struct led_pwm_data leds[] __counted_by(num_leds);
 };
 
 static int led_pwm_set(struct led_classdev *led_cdev,
@@ -81,10 +81,9 @@ static int led_pwm_default_brightness_get(struct fwnode_handle *fwnode,
 }
 
 __attribute__((nonnull))
-static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
+static int led_pwm_add(struct device *dev, struct led_pwm_data *led_data,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
-	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
 	struct led_init_data init_data = { .fwnode = fwnode };
 	int ret;
 
@@ -167,12 +166,12 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		}
 	}
 
-	priv->num_leds++;
 	return 0;
 }
 
 static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 {
+	struct led_pwm_data *led_data = priv->leds;
 	struct led_pwm led;
 	int ret;
 
@@ -193,7 +192,7 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 
 		led.default_state = led_init_default_state_get(fwnode);
 
-		ret = led_pwm_add(dev, priv, &led, fwnode);
+		ret = led_pwm_add(dev, led_data++, &led, fwnode);
 		if (ret)
 			return ret;
 	}
@@ -217,6 +216,8 @@ static int led_pwm_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_leds = count;
+
 	ret = led_pwm_create_fwnode(&pdev->dev, priv);
 
 	if (ret)
-- 
2.55.0

