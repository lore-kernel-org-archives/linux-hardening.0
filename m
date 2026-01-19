Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391A2D23B9
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793458; cv=none; b=njwwWQeCz04dBmLsoukstTypsVUstFCtd8ir6Tl+fUTFU5lQNw64fhT8pThfwr7FW0XAU1PkcfOA3GlybPVc6hq6h/AlI5iJ3pvMCTASmKQ//Z2F38BjU7/A8u5sRjwcS/Kw1eUhTIYf5bu43oqKEY6eZkVSL/jVpLP55obLoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793458; c=relaxed/simple;
	bh=S2kYng34pyN/wX/EOplOpxbzEXHZ5N9BsJv+d0hNUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxNAbUWmxqGRhEPRTj4EmnO5fmnHDZ2oNsCLOtiIKji9W9eUthMGl+Ke8W0pGAMFHFP1e5f9gCeoEGG+tH6Df5hmVULPsvmTPK7f4pO332AC51fVDe9yLHu0KNdXyPqFmzn9noNBQgMBsS8hHDD0ExpNoVNUpJ0cC27vWBXQIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYLXv4AW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYLXv4AW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5384ee23fso427959285a.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793454; x=1769398254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=PYLXv4AWnxww6O3KEhieWpki85vDCR0blYxiX31eRJPcbQKOPxpOXTys74fKn5F3Ld
         gpNYmvzAD+WoCd6Yvv6m4uh+lr+qRgUBcWvUIERmUrNB3dJNgPn7wWnLFmE0DUpC52eg
         fTwE9xIseUX/8KZQGF9CbS7AXykC/ebnPxhohR5ZTWqeX4dyEkRo7o463KAkH4FNNCQ9
         SZEA/AVrmI9TQAgcId7oiQ1UVYIBuNwD4JVPb8GpOoTXvR/e/uOz3uXTyj1SbOQ7Zbtr
         Nfro9QUjWPCTLrKrvG54BA1dknM1hwKcb2OpqbL0ZMgsZ1D3EQWUezWxQzEHeSK+x0Ek
         /G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793454; x=1769398254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=fOqKYPNXTBq89tE/WbV5G9EiU00rc99boYXMfntE/rY868GJ9W1VUQrF9tO9khM1zp
         /rAaTFRqggIodhXa5zIVpMVwy67f1DGylcAYSZL8VmmNZm4s9FEKSgZYfB9wpgkz2Iip
         BkPOKf958dg+YZmJSdtPU3ANFDsxkMoTkKvdznKNtRa7AOpDa6vQxMvvTVxoNGl1ZZ2Y
         sSq+gGU4hiWKUhRZdHSFmBNtbJ7yi8cHjV6lfCUVWWa8r5GZG9B1T4A8TfMY62HxCBra
         PwfdE8YJrI8z1fsizHHkVsgZxnqz697unj6EknuAfA3Qr1/t1D/0k9PM3hLMEP+FajsR
         XsDg==
X-Forwarded-Encrypted: i=1; AJvYcCWWtFJgij293mF4hzZ3z4euMBOthfJck1Io3EFhlE0wJlvVUCgm5PmJ0F08iA2WDjW/9I7z8FvcDevXVfYz9GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNuCHl83MHfTGn7faDntsdusoN5A8BKnDUTuB3RZmDd0tWc3Z
	QW6L0m6RTXAggj/s0YWxTptLMW6WFE4iiOXBeKPAuc9MA3qc3WIJroZ6
X-Gm-Gg: AY/fxX4R2rwF+c0rTZxVP9MlrDp2otBTRlA8e2o52omZBPY9nW1TBBYjxxKZqx9hWv4
	Z/9fGMKJ4LBGv7dpxDlkbK5AZ01hWc3fNutEg9iN4Fh1PC8NEb2WXupbNpq5pqGfRUzfSa06dOh
	z/8TTRcFDKGNWY9e5wQAa2koyWhHRUeg2pZPYGXbomGTYu/TgPGhJeridV8RYzt/Sz1vIMJlbjA
	YynTTiVwY4HOIuM4hSHJpa9xOGZrdoIwSKxOGPruuINIEyd2jZ/9aaFNCxBYijVIGoSsLLKnqLQ
	mzkbE1RpN3Zon8m3Kg/BSLsDwl/QpoCgDuc/SfwNApJQn4ZrlhYVUy3F+yl2nt9/iKKACW2kVm2
	n9MznLTgWBVFLOQqPiNzgzkqywwgOcKAhieMVyWItib+VC8NfBmW54g22Fqz02fan0Jz7d6JmQn
	pCpbEaryrzJtbzPqRjzInGtQp/Ic1XJ9LLLnmst9rxToPr3WOWH4xzOQOQv95s7RKr0G0=
X-Received: by 2002:a05:620a:29d3:b0:8b2:e513:6419 with SMTP id af79cd13be357-8c6a693b0d2mr1393824685a.48.1768793454390;
        Sun, 18 Jan 2026 19:30:54 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:53 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	quic_jesszhan@quicinc.com,
	bavishimithil@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	thierry.reding@gmail.com
Cc: linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 08/10] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Sun, 18 Jan 2026 22:30:33 -0500
Message-ID: <20260119033035.57538-10-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119033035.57538-1-bavishimithil@gmail.com>
References: <20260119033035.57538-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a device tree for the 7 inch variants (P3100, P3110, P3113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |  1 +
 .../dts/ti/omap/omap4-samsung-espresso7.dts   | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 14e500846..d24f13efd 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-sdp-es23plus.dtb \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
+	omap4-samsung-espresso7.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
new file mode 100644
index 000000000..cae37ff06
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "omap4-samsung-espresso-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 2 (7 inch)";
+	compatible = "samsung,espresso7", "ti,omap4430", "ti,omap4";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		pwms = <&pwm10 0 1200 0>;
+		power-supply = <&reg_lcd>;
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <2>;
+	};
+
+	panel {
+		compatible = "samsung,ltn070nl01", "panel-lvds";
+		power-supply = <&reg_lcd>;
+		width-mm = <154>;
+		height-mm = <90>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <47255554>;
+
+			hback-porch = <210>;
+			hactive = <1024>;
+			hfront-porch = <186>;
+			hsync-len = <50>;
+
+			vback-porch = <11>;
+			vactive = <600>;
+			vfront-porch = <24>;
+			vsync-len = <10>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+			syncclk-active = <0>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	touchscreen@48 {
+		compatible = "melfas,mms136";
+		reg = <0x48>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+		avdd-supply = <&reg_touch_ldo_en>;
+		vdd-supply = <&ldo6>;
+	};
+};
-- 
2.43.0

