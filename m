Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A129AAF3
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793461; cv=none; b=cZtnu5//UY3RejtCpJluK31WPyRzhr2x5oTCNfmqLX42SLeYHTwalDoP8UM/rFVSbO24UoCgZbFVTG0y93z3RXcEpEuJ+mQTaJtciFBvKHICmdA/Jj00s/N/kXWuxG2fgTNQMC1LukiYZacLJ2wY0vhn4GtlZXKUyhZrR9NuTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793461; c=relaxed/simple;
	bh=AUhhKwGaM9grtdftiWmb9K3MniiTndfrY7S51xLJzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO8fvy915jOZwwQ828GmoB0AT8y5SRIbTwM0iDejaL9T8ktKGCxtRQAUS3M8FLVEhASHel7v0mYNt4Mcf5eBeOSl8dJ1dPEH+6RIHiFSxGJoh3KpAdd63gGQZw/FXlKX26F1HBuhaN7p36/vFXbLUcZaCRv9vt10oF5D0+PbsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZlfJ7sO; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZlfJ7sO"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c531473fdcso533448185a.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 19:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793457; x=1769398257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=ZZlfJ7sOSEFqGSF1Kyr3ijh9eb0GCktn9NRL1CSlN2Zp5Drc5Y/g8VhPFGtnpNvHpo
         rbURYOb0cFkleCiG1KfSQDzZoolj94yBxqjEwjoVWTNsiPKhVFYBi+NbTwNdaNF8Fu4Q
         +Zs40B6MW7NgzIgn1/N5CLcsrGvS9sUFP0YqGmxf3MYEV3htw7c9WmEZYZFKb8aASDYZ
         rZHBZFOOldZ6LVcmlIQ1eOdlV+sYl5u9XKSNx/1lCXl4VH5XU84Qb2I8t7f0zsEulTTv
         +LuP7D5zpk0dxAbwkPl87rXPqkVg5yzfqKEhEQXueZD9Qtwptli4datdvXabDMa/xlxU
         +MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793457; x=1769398257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=R7zCHUxVKPsoYSxRzHIbyosbf3QOHTXc6SUrCgH0mAMoDfVTACilTCDMyoSRLBOu4u
         MsWzEn++Egn8ItQDgNxzSzI8PgPd+oUPukxjAYF+6PoeKZHLbxbrq1MCMMledsNL/KG7
         8VwHRrjovkw8FB0twxcvn2hyXgdqUdifVbxKyGthBXtFqQzdJ3pkyXOHjKZlZpKS0Ml+
         5FUliAgjCUwwmaGDwr3bLbUrYZeDadvTyCSu43kmeDcUBgTlWQasaC1YND3n8IGWgCcU
         Ccf3Lm8r2SsVEPL++dZGLhFycB7shhbqfiNORlJYHYarbDeJAs1kwhgBorygEAmg6h1q
         Jf7g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Jo2vgWKcaSKHb+S1egBzvifAgZfti+ObtoyAEoZqTChpFEuA0qnBDqG2F9STPa/hD9kyrZHi5ZNrFiFzm/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqmlDlYiQIdN1efGZ4wSBgpRiYbTTSGVDyGUuMdeVGQfpwfm3
	CNmt5rrJ6aSVJ766zpMYMwdkGtJhzb/HS4/98pbSIbtpzaH3HNeuIluL
X-Gm-Gg: AY/fxX55wrv46QPjrnbgW78/E5KrpbsMceKNArdetDFmOzCufZeib9XHv+AVo4djtxq
	bT3f9o+GfwakLCF9h4I9IEoSVEhNIRly5g6eCgvQaPfMzrNWu4xRtasVxDhHg1ene+Ncj2+OU8c
	ud4ESl/nkZrc3f2hNFa456S85/PVVrW0UTcu1+AkjXDAoQp2DXqeD7A+Q1+V9BJFMTTymytQGGf
	ypAAftgm593Q3nKCsKWfDxTI68xnJH5OJ5j0zgoShMBd2DS/q+ha+Z8d9wUEau3ENC458o0sEOs
	xBp4oJMV3n4VMqpiUXdyYHvneep3JLbn57RH1hJaj81E1PhSh1y4ThiXU9jE5XdO5euR+ITNsA1
	oQD3KAXxB2KCsBg9Dwcu8ti4s2ugItr0PNU5/GS4o3gpN9Apo9iGk1sP/P4C+QaDBoVl8XTnvcf
	b9/XuaclV5fWKG02GIl0vW+lW71nGg8OGsw0mh7FglMAf1n2gt8cWpWxnEg2inQhEtE7w=
X-Received: by 2002:a05:620a:6910:b0:8b2:ea5a:4146 with SMTP id af79cd13be357-8c6a6979f69mr1231120785a.89.1768793456999;
        Sun, 18 Jan 2026 19:30:56 -0800 (PST)
Received: from mighty.localdomain (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm724706885a.5.2026.01.18.19.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:30:56 -0800 (PST)
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
Subject: [PATCH v4 10/10] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Sun, 18 Jan 2026 22:30:35 -0500
Message-ID: <20260119033035.57538-12-bavishimithil@gmail.com>
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

Create a device tree for the 10 inch variants (P5100, P5110, P5113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |   1 +
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index d24f13efd..140ac39b3 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
 	omap4-samsung-espresso7.dtb \
+	omap4-samsung-espresso10.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
new file mode 100644
index 000000000..5c00d67ac
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "omap4-samsung-espresso-common.dtsi"
+#include <dt-bindings/power/summit,smb347-charger.h>
+/ {
+	model = "Samsung Galaxy Tab 2 (10 inch)";
+	compatible = "samsung,espresso10", "ti,omap4430", "ti,omap4";
+
+	i2c-gpio5 {
+		smb347: charger@6 {
+			compatible = "summit,smb347";
+			reg = <0x6>; // 0x0C >> 1
+			interrupt-parent = <&gpio2>;
+			interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
+
+			summit,enable-usb-charging;
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+			summit,chip-temperature-threshold-celsius = <120>;
+			summit,usb-current-limit-microamp = <1800000>;
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		pwms = <&pwm10 0 1600 0>;
+		power-supply = <&reg_lcd>;
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	panel {
+		compatible = "samsung,ltn101al03", "panel-lvds";
+		power-supply = <&reg_lcd>;
+		width-mm = <223>;
+		height-mm = <125>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <69818000>;
+
+			hback-porch = <64>;
+			hactive = <1280>;
+			hfront-porch = <16>;
+			hsync-len = <48>;
+
+			vback-porch = <11>;
+			vactive = <800>;
+			vfront-porch = <16>;
+			vsync-len = <3>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
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
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+
+		//avdd-supply = <&reg_touch_ldo_en>;
+		vdd-supply = <&ldo6>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <200>;
+
+		touchscreen-size-x = <1280>;
+		touchscreen-size-y = <800>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			touchscreen-size-x = <1280>;
+			touchscreen-size-y = <800>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
-- 
2.43.0

