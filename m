Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725E367F39
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957790; cv=none; b=FsNRWjZvL+v7KFpgOz/jIqdJmcPI/Cvdp4jB0Ie9ra1pL/Ro+oKaw0bZ6Ano0DRCVGHRZGlF0QKPepfWLjftXvxUZTm8Vvv6rR87z29rM4r0dOUUphCFPJcJ38x3eAOZvXV3hIV69z4Mpl2jICmO/iww8ivgWvmuhO30W7A78kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957790; c=relaxed/simple;
	bh=YbKU8bNkuqniUi6opUD1cEX17xfpbeAqZSEM023mUjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+Bka7BoqOOq03Kkct5fMFNpGPYKphh/GflItqJQFBA+egEtZkM/ygjlvV7ouMAY5xCDBOzZUN+26hh0IbtGI85aeOBkQasiDr8EYr7QXcW2wkflDY2A59TS7PorfQt5HXGUdfd8Bp+NG7ValyAmGLGgV5AgWZBX7+xXhAJx8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HCBv9gYr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCBv9gYr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso48862235e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957784; x=1777562584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFRx8vQlRrTBYadIbF6D8n4BAlzLtgQdTMGBUepLq/s=;
        b=HCBv9gYrqGwlmqcdlTp6ImFIYSGlEpnKto6UDlX6eUw4taAucfMlJQbadwxhid/LcN
         ANJxk5h9TChMAr4qlMzBUHtvneKDCF4exl5eARDnucA3qUqYbs2vohm/JsRMUTlwLelj
         z2NS/0neXn68+yJFvEaMv7eZhLSQ+l1+poo/HyAkFHM87lAuz8uJjAaRPb56F5ovrhwx
         0ONTf6nc2flvNeykyswJht5xHBlGAvP4ND5OipxOSjFpOhZyqt8gX7nwGXiKzVbqPkrU
         xxyaH9KJ8jua99OIteIpA6rmA2Br6aUctExZVSzqRJho+GaNBMCzIkodqWb1zyu+WlqA
         PXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957784; x=1777562584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFRx8vQlRrTBYadIbF6D8n4BAlzLtgQdTMGBUepLq/s=;
        b=IIhw/cahHcQEkziTRqMs/ThxW09InJSWYPngu6ZdrDjC9YkUvwGcASATm0kx/KV1pP
         lqOhl3ZmZfIoL9L/KWW5/czldrPMhUKGkiqzX9VX1YVriiUGBwRBbSFm0k0BxDNMSb42
         oHBOfO7HTWD9i8htpbBWTwKtsca6xnCJaowSCm6Lrg5JkAGdvLegZoqS+SyjUmhGsJ1G
         nl8oV8LkTgjPphQGdTwtqNnaRiIJTbv+zp5LJWHHGn+qGqX4OdvG/8cqvWfWu532cbtZ
         ibi4QuJuO+JsIlpbYbtfZ4SF4/OkeSRkNYOPqVqsXrH6loWo79gVE+PL3ZaQ7ZWMQBnu
         aucg==
X-Forwarded-Encrypted: i=1; AFNElJ89mPjTU+ScfMpmqiI0NJ2/qLKRevvkl8kQBQZwuKB4h3PzY/2/uJ+Q+zx33GiI8zlPTCxY/xHZKU2KIh47G6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/GsWUJkDOVs/6sZ7Gy2G6KllzfgWbv/xIYlokcYjIuz4OSGc
	cUOS5kPoeDKqRAmc73B2vjgbwUy/hb/wcWpolhrCc8nT/6zzTNfF3hx0Htk3YTe7m3I=
X-Gm-Gg: AeBDietNeWHBo9qmj8A18KpkSA78tbO26+5c3e3ShyB+r+4Jp20LRTlw51FI1UqnXv1
	qOM5IgpQNPagvMrTHX2qNZca0NEkVrMsSk7oQeJhI/U04q3jjtLFKzmGypwCv7jUe7dE2BpoBLl
	hWQvh2aZxvXUYqrCs3295lYq0n5rg9H8XuBSy8KiYB4BJMywiPlWgARbKqRr4htgU8RzzcrKu8h
	r0L8XceSu/l2SbpJMAVw+rNJuJ/WvhEsIK3sNEQBu0WxbHcdgk/k0gh0l15jGAJdu3WWIyOl3Oi
	fcbh9OZLOL5cFT5HejTQFGLNmYXdgkgNzwOVdPzJYEld6a3TXbboif0sv925g52hSIjc6flNUOG
	o1uIZ7gIToozQ2FtyWQDM00pbdTLrrfqGVzNlkQ9oWWQqKF3dVB3K8aYG5o0dhWuZsANnFu+kpt
	Oke98q22MwpHUn23l78amkXrPgLjaU1bWIwLBQDu31id4gwa/1+nkHSfHx0mZ8ARx1KZ3FLIF8H
	AuWR2kxqja1u7tE+g==
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id 5b1f17b1804b1-48a52d95604mr227748485e9.30.1776957783700;
        Thu, 23 Apr 2026 08:23:03 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:55 +0000
Subject: [PATCH v4 07/11] firmware: samsung: acpm: Add
 devm_acpm_get_by_phandle helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-7-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=3024;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=YbKU8bNkuqniUi6opUD1cEX17xfpbeAqZSEM023mUjQ=;
 b=gWU8Thuqdu+garSPEjoTkbNiCDA9yevszfEqnNqdri4bAmJgHoIk33bjFw1V63C+yxyWRNccp
 1IZUWsWg+OQBSrbw4xbsja5qvOYRQjVDFPrpXNZYNlcZfXVGIx37b57
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Introduce devm_acpm_get_by_phandle() to standardize how consumer
drivers acquire a handle to the ACPM IPC interface. Enforce the
use of the "samsung,acpm-ipc" property name across the SoC and
simplify the boilerplate code in client drivers.

The first consumer of this helper is the Exynos ACPM Thermal Management
Unit (TMU) driver. The TMU utilizes a hybrid management approach: direct
register access from the Application Processor (AP) is restricted to the
interrupt pending (INTPEND) registers for event identification.
High-level functional tasks, such as sensor initialization, threshold
programming, and temperature reads, are delegated to the ACPM firmware
via this IPC interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c             | 23 ++++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 655b80fc635f..6dee461f5827 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -812,6 +812,29 @@ struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
+/**
+ * devm_acpm_get_by_phandle - Resource managed lookup of the standardized
+ * "samsung,acpm-ipc" handle.
+ * @dev: consumer device
+ *
+ * Returns a pointer to the acpm_handle on success, or an ERR_PTR on failure.
+ */
+struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	struct acpm_handle *handle;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "samsung,acpm-ipc", 0);
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	handle = devm_acpm_get_by_node(dev, np);
+	of_node_put(np);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(devm_acpm_get_by_phandle);
+
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
 	.acpm_clk_dev_name = "gs101-acpm-clk",
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 08d9f5c95701..83cbd425b652 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -71,6 +71,7 @@ struct device;
 #if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
 struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 					  struct device_node *np);
+struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev);
 #else
 
 static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
@@ -78,6 +79,11 @@ static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 #endif /* __EXYNOS_ACPM_PROTOCOL_H */

-- 
2.54.0.545.g6539524ca2-goog

