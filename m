Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FF233701
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836628; cv=none; b=JRgT3ikP3vgjrzzXsl9q8fsUVu3LknbcG8dzil5s5fwjrGmDnYnITfqIBCCYVFRCN916vRlD95vsHG+bsftMYUk2+XAMXW/MgMS6/GGii9iA4cBPWbG9VrYLqzxcmBDohgPmfyj/H2bdZoZT09MaCnYN8t/y38yKeFB3/o5VEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836628; c=relaxed/simple;
	bh=jZzOia2XsslK/UVTV0RsWGKc7SbGTkfUbEhS+fMGkbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edPF7CO8GArG8F6k5iuc6gT82ozRbD+ygvo2ZMU6kWe1QzGWa57UtyrJ/ykejI/yhqpzwQ+E2FkGPSuW3rKwvaR5iEQe9FL19ryErywFKCu8dkssetbOYxLv04rCeYVQv0PQXeV4WobDN3g1Xq+jTA/8iM2HQlVWAfDP8/TW2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oN8RWN5l; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oN8RWN5l"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so1335968866b.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747836625; x=1748441425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v258ll9JbBLXOIea9jWrUjVqAB2GMAl7DarOvnstw10=;
        b=oN8RWN5lPYuSH3i7CXIuNBl9HUzv7DQdWnexJAF+ttFIGjsDwRTiCRTjHgAWVc+mb3
         XluGcj3ugvA+9nXxNfqNpQZxCL+nl5KAPXMZ5w3383ayU8aIBC7Gs3GftAGb/wI5Ls5N
         MvBA5dUjyNeah92fmkPy4MCeJ/SorqOgMoPTqUpN21fdFsXLVUvb0XfeuJpqrT9N8dzl
         i68G5X6gHLeQvgpzic+61v/EcdQclXsWkvAIxtc81qpUSxCOPQhaew9V4dPI76XwPq5U
         6rBT/HYpE5TmI7ErUcwqmHVtgNXzs/xEAGMv7+6KsxA2M2wdUVJQkAlB3RieS/c3UD9U
         zL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836625; x=1748441425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v258ll9JbBLXOIea9jWrUjVqAB2GMAl7DarOvnstw10=;
        b=pFG5nnJW9/JH6+lINrlnUZmWPk86nVA73/DsTiqvLpJHKZ+H4yatWpQrfybRZfggo6
         vkZJtOUtWhcytzBeDYrWJiTRqWV82Ms3itgufmjKC02TFa7AnPn/YVFAVfejqY/zNUE/
         5uxktFzmkzec5QJ1rMo8o11cONVM0Q/q7y78zAFP9o6eJLYa2eNR/H+dKmspu4YSnw/R
         fSe5IHz60SyDFhdJPEoxTNYCLOaTbp1YPWqbtal5Ps12U7w///tdtAfEUUwDyRuk3uRZ
         /gBBu7FHc8tgI2dfl/Tz7UhYmnuS5LuEr54DafZvogmM7nsHSew737mrU+Y+tz4MsoMN
         KViw==
X-Forwarded-Encrypted: i=1; AJvYcCXhg8b2FZHifas0iLkvUCAWsg1WP4P6DNNJtz8eh8aGTX65e4mVuwjpBhWkspE5PgsGfwnoWurpGLdUCydbcUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6J2o57utuaz3HWR7oluozMxbS2zjbFQIxdIF71kHgCc+DHV6
	uUaW5FFRr5PkoQg4yqBtf8iVd/kqzIqh2V3hdvLDMIJBNN4fxUw10aASKo3Dq3iOd2E=
X-Gm-Gg: ASbGncud23LLiXh8dPyXNPy+gbnxekwleIISfPjtIyWX+h76uAxB/12oJxqecOHauNe
	Z1cxsc8qcSKq/xN3W8ekpqWTgW/BCSLLDBXpvxYq3OS8NspAL9yxAV3Hpg3IWowfW9LVAf9eFNO
	7sR1+L9ydcVhXhI6oKtoxbdz9mi2l6zFRqnNNo7UyKoLlKeFTX8HAJ9Ei6wrm7eE5QlMAPyFndI
	AUPmZdslVVunA07MWHicb0sR1ILwdr7q4mbhOWeNLiMh0FnsRoqM+eBYJWcF11t9jVARxhy0M85
	Rft1TFEwgDt6BUDgAslvDPSKTpPaX8wWGUdKbsSKCkFWDZs7haU0XgMnWQPd4R/H+4jYTmEDb0t
	5rpIy
X-Google-Smtp-Source: AGHT+IExJE/BNkE5bINpRA4UDQooBTWGbExswmf0e5QQQgNXAyz1AiUe3bXi/hkJVkXYpmXzRVVPXw==
X-Received: by 2002:a17:907:2da2:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-ad578ca2302mr998041066b.59.1747836624607;
        Wed, 21 May 2025 07:10:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm914552866b.69.2025.05.21.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:10:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 10/12] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Wed, 21 May 2025 17:09:41 +0300
Message-ID: <20250521140943.3830195-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
signal from the system controller. Add support for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none; this patch is new

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 016aae883b2e..98d6323e9f56 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -97,6 +97,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
 	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
+	{
+		.compatible = "renesas,r9a08g045-usbphy-ctrl",
+		.data = (void *)RZG2L_USBPHY_CTRL_PWRRDY
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
-- 
2.43.0

