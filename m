Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378F364025
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189291; cv=none; b=W4TwPdCyWy5mBz0+87D1LMn72/LPa/Kw1vOT3bkYkCPAtdMp/ds1YRDVxu3oORBC2XSb7JYcov4uEoj1MI998TS2Vt1QIFXQahpY0YVXgrHxNWdasH9eKHsBXJ6o0uFj87SeBJOt5RHM3FEizC1MGaLYKNH4lr0yupgIOwmDTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189291; c=relaxed/simple;
	bh=B/tqumodIgkuXLcIDjCvC+BGzbRSoaLzvllGIMZTIfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRnPs7izivCSbEa3AuaT8KTFLXmysa4Ed176CYYKpzJ/gHMqu+0welkGA0Xj6wtrSTP4pqQZ+xS9tnpSQG1l8JOFjI3S9Q4e+ypa+MFduCCw9L5w/jv+MqVWtlx46oDSW6nmfDNVetUgsqNEgYg/0TSvzUXuPxNwEwFj2/O2VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAItiUIW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAItiUIW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso7436609a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189290; x=1773794090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YSc98IcO6Pk8M+lzdgpoqKTHGos+KZeMXffp4drDJs=;
        b=iAItiUIWFQgw8znFg8qrBVT10D4LqM75DMGoXScjIeeYHsJFdjgKXP8tGLkOHj0PBW
         Mbry8oajIw8MV9/skM+YgvDf63yK8/7IL6UlMVld7aRXy3g5+CPX/oBspE33lRe+74hW
         UH6YsFeFvtTTJgnS1ria04b/tRMhd4Vws1zVN4ljLX/goDpo4wABwB9/dYRCY3ndoK/8
         cy/yWvi4TKqL87ETU5FYPivHN8+6Q2ydw0mdPok3g0WR6lKVydOXiFr3og+5D5mdVsWM
         GFNoddLDpkpMCO5A6e8Pk1Cwn3XbOwDHc6zzdo7+dniVm/9iEQ0jGt5DdUwqA+8zmEO6
         hMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189290; x=1773794090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YSc98IcO6Pk8M+lzdgpoqKTHGos+KZeMXffp4drDJs=;
        b=EoiK5YuUX2lbQ1eF82tKaxk5nIcPIs9Kio2J9jyKd2PUdPQ8IRwtOPZkoGo/QP9fmx
         R3r6/o1Mt4NJkrZD79DUlRCRxLLL3VoYX/cMv0rH+cqoA3Pf/lYistfENJ75r+9IkYqu
         gjMnv+5fTKXdynw3sDiAxU2L393xbTOOWfwJj8cXoSw698ldEJNZSYwIhWlHf3FDvgm5
         w/3CmamRnOdhS5RK38SCePMV27RY76GxTSg6NVn6tRvtKXXQjwJm/eDfuBivwXL8eCTk
         aBQUYx33mkeFhyiowosDGUshVGDnFX1OSdSHhGz9zuDU5FAft/y73mJMZ3r++9L7u2LC
         oF7g==
X-Forwarded-Encrypted: i=1; AJvYcCWpvBUHlgLXbxd7dNwQS/irMEW3tTQ+cEIS5ZFxVaGKPH7BPRsk5eUoOZy/TTgUxt/TmkC1td1w8XhVd+tMhuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzanneR3XETj5uLwspL+KA+IfQ23KeL3wKmJo5TLuVcrv1u5GCG
	8RKXGk/wRuUq7vm9AHaO3WxiMq9BDndR7GDCOjJONAWgSL2VKHQi26HG
X-Gm-Gg: ATEYQzzWQYtlLUsK0STtaWMKF9t/bzCtTMj7toFdrMKVMfOP+gdbIIlGnRNAKjQLw+h
	ELHl76lJQ0xrgdtuihUICDPE4sKfECEihn3gE7LJqZen2wpK+O81S9aYfxA9xBbQM3WRxYllyBn
	YHt+CHuj6sSHlTmu1so2J7fGdzo9Uqxfq/HM9SADaUyi29MdEFAGMWqgkU9knoLM99CG6guCwWo
	EUNh/erYdgKo+Kh6dvdSA23BQhIOs0+7/bdcAy/+fmT9UVpRSqjXMIXp0209fVhPHULN+C9dFl9
	p1STJfaOCKckbOfo1iLv7nrZYCRB0AydZ3lEX/Iqz0CkJ6bZQFk05ZUrbq0hyw9E5zLuUs3Jn/s
	TXZjGf+nFuvqvOdMCM3RZPGm18ij1qH+EBonO+j7HhlJSh0BNe6JfjSwJBpaoFV12DaUt+OeLuo
	L+lzHZxdV4bMBNELLWN9msvy2Fy81hsd9b0pThedp9GdpPOsuaqJTzig==
X-Received: by 2002:a17:90b:5111:b0:359:d54:846f with SMTP id 98e67ed59e1d1-35a011d0b9cmr793085a91.7.1773189289448;
        Tue, 10 Mar 2026 17:34:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf0e48dsm330349a12.1.2026.03.10.17.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:34:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] gpio: bcm-kona: remove kcalloc
Date: Tue, 10 Mar 2026 17:34:31 -0700
Message-ID: <20260311003431.31881-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member.

Use __counted_by for extra runtime analysis.

Shuffle some code as __counted_by requires the counting variable to be
set right after allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-bcm-kona.c | 37 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 208b71c59d58..b1d32d590cf8 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -58,15 +58,6 @@
 #define LOCK_CODE				0xffffffff
 #define UNLOCK_CODE				0x00000000
 
-struct bcm_kona_gpio {
-	void __iomem *reg_base;
-	int num_bank;
-	raw_spinlock_t lock;
-	struct gpio_chip gpio_chip;
-	struct irq_domain *irq_domain;
-	struct bcm_kona_gpio_bank *banks;
-};
-
 struct bcm_kona_gpio_bank {
 	int id;
 	int irq;
@@ -90,6 +81,15 @@ struct bcm_kona_gpio_bank {
 	struct bcm_kona_gpio *kona_gpio;
 };
 
+struct bcm_kona_gpio {
+	void __iomem *reg_base;
+	int num_bank;
+	raw_spinlock_t lock;
+	struct gpio_chip gpio_chip;
+	struct irq_domain *irq_domain;
+	struct bcm_kona_gpio_bank banks[] __counted_by(num_bank);
+};
+
 static inline void bcm_kona_gpio_write_lock_regs(void __iomem *reg_base,
 						int bank_id, u32 lockcode)
 {
@@ -584,12 +584,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
-	if (!kona_gpio)
-		return -ENOMEM;
-
-	kona_gpio->gpio_chip = template_chip;
-	chip = &kona_gpio->gpio_chip;
 	ret = platform_irq_count(pdev);
 	if (!ret) {
 		dev_err(dev, "Couldn't determine # GPIO banks\n");
@@ -597,6 +591,11 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 	} else if (ret < 0) {
 		return dev_err_probe(dev, ret, "Couldn't determine GPIO banks\n");
 	}
+
+	kona_gpio = devm_kzalloc(dev, struct_size(kona_gpio, banks, ret), GFP_KERNEL);
+	if (!kona_gpio)
+		return -ENOMEM;
+
 	kona_gpio->num_bank = ret;
 
 	if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {
@@ -604,13 +603,9 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 			GPIO_MAX_BANK_NUM);
 		return -ENXIO;
 	}
-	kona_gpio->banks = devm_kcalloc(dev,
-					kona_gpio->num_bank,
-					sizeof(*kona_gpio->banks),
-					GFP_KERNEL);
-	if (!kona_gpio->banks)
-		return -ENOMEM;
 
+	kona_gpio->gpio_chip = template_chip;
+	chip = &kona_gpio->gpio_chip;
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-- 
2.53.0

