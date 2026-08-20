Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629E3FDBEA
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218979; cv=none; b=KPbUHJJfPIiI6YODqV8DG7W0SuTdprPgNE3JD4FSLOmJiz4diFv5QqqgG/aipO9o8g3zw1RI27l+kldV5MEkuJ8K44+25OVQkp6c54UCffNYrMBDF+JQHUxF69ASjoQRVY7hQRjZilz0sxPv3oYe9tCmujNKlj2r6RhGyr7mKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218979; c=relaxed/simple;
	bh=p8GRB+lkIjw4pSNAEO08MU7+d9FS21qHxjD0llBgBnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwJlihIE2C5R7cdGJPCm/AqnK4Na2sH9GlCvNK0ChfDYyx9O9wRLKKCfboMtrmZugr1bI7z/Fq80SyI9mSh8f29K9p2bY0zz1OKKXfxBUZ8ifYnMYUyOcFpT8rSqyMbMeOb3p8FnC6oWfq+4hyTxSD+sseZTltUxtHpPVoRbdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TShphs86; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TShphs86"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-480001972b8so731207f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218966; x=1787823766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzGTKiGnkLs/gtMzA+9GsQcS3jJ/KsMyFZATtr8M8Bw=;
        b=TShphs86jiK/2tc1oBSLpS+5KrXFUDgp0wOnp10WnH77bQFrguC7hCrCCc1o3zLGNP
         8zAlU9SOMobOqy/SUzkH9LPcJy1+CDhiLtZNjXmo7SHmX3QLxyXg7mBaPdlSN5ilQPwl
         EOXt6pmR/Zon0VkVlNTWV882H8JhNphtNJ4FQ1DCsxCay0/xjClq/89MhUTOA/8fNljk
         F3+toqXSJgPrE1MEM6GgZbniSV/oD29vVvwjhsD3C5YI9KserSU4IkUrokMMAkbUM/uF
         mPNd31rQojTJTGWcb5qy6o5jhJUe/TgBbTB8SKpYC9MEO62xQKUwbzgKoMuwhkq0JB21
         gDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218966; x=1787823766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzGTKiGnkLs/gtMzA+9GsQcS3jJ/KsMyFZATtr8M8Bw=;
        b=MCjHfT2jgBhCCwTJcAjvx4Rtkt+oxLWG657N0/7n9dzXwUllpOseccl7BMc4oITEpb
         yq2Wz/ZxAJ5n3aFYG+GASisZB5dKOEtJdbwYiCEdGmB6N0XkbmT+BSUuj9h4IkckJ4fW
         bfUWAD3NeNifqU+4NsW2qxsjzateMO+zoHQvnIdWFWJ42PWA/AYPvynte2cUcPAMjPIh
         gR02veIkuVUwluPTZQyUdyH6wrC8qKf9RC8BZngcgup7XkfMMmuHVKeCOQ7v+gmq5BE4
         LZDOYXPs4rYqQRIVwCeYfQnY2fEKiuh8viHeOSfc0Clt2sgTxrtKbBEu5Ana+tJYNxqc
         qw4g==
X-Forwarded-Encrypted: i=1; AHgh+RpZtctatUl8uW9gKO6hzAl3dFA9uBJe48ewWFHsZg91uYA0PiAQpZeQt0W+5o+EW/4umrI8gSW9NE+Xg2vWEQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lc1QLDMx5EMpBRfw5E0Li4eH2cUBXVJ3DsepDgu6V0cnHQc6BS
	oIqyQvD03VWn8PcI0RUkx/OSQgypojaogLPL9t0zQh5fjnjzidWMTym+
X-Gm-Gg: AR+sD11Gft/0gglNWrVR5KYWQVSaDIoHxON/o1Hd4rGSJhEodR4aoqNvdEV9K9mP77B
	7X22u01GhYEulzHchbxO0pwX+ZBawUxJ0pBidvuayVyw3J6MixK2PjKOfgfzkx6bW//7EIPKz4h
	xSA73fbZ74319l9BitIoXxOvzJeokzN4ZMWCFJG6BnNEpz6lSlFqJU9o0Ix+FVseYS+FDw4CFU7
	c0QDYUuGmdQ3l57RiDEsXSPVpSOpovSof3BvMPVOA+X1Bl6SxJH5KRlVDAmVqsgmQFpnSuh3o3A
	RpaSbHVhElEjRG5uiC57aTapW6o6ea+mopHdfrrbNDa9ImeiH5I3naAnUMhCqPOlsrlg0JBZTPi
	Pr45O96RUba7UeRcQDGyqXwrlSCUUm2h8kSepckrFgbHjuqurJaZ7Lkk793DTajvSNhE85G85aN
	fuv8WCK5HGPpD17wIYsOw7k5uu4LeCiWSdC5eLtoHVTD5oB1EsClfL947SCUS2/PFDSpg62nJne
	CC8SdHjfGKPgQNEx44NSnC/
X-Received: by 2002:a5d:6f05:0:b0:47f:80ee:744f with SMTP id ffacd0b85a97d-482b1fec98emr11132149f8f.16.1787218965689;
        Thu, 20 Aug 2026 02:42:45 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:45 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:28 +0200
Subject: [PATCH v2 5/7] arm64: dts: qcom: Add LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-5-7130d68183d9@gmail.com>
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
In-Reply-To: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>
X-Mailer: b4 0.15.2

Add a devicetree for the LeEco Le2 smartphone, which is based
on the Eldarion/MSM8976 SoC.

Supported functionality as of this initial submission:
* I2C peripherals (Touchscreen,Audio amp, Haptics, Extcon, Led)
* Power Button, Volume Keys
* Regulators (PM8950)
* WLED (PMI8950)
* Remoteprocs (WCNSS)
* GPU

Device tree also contains supply maps to other subsystems like MDSS
but due to missing dependencies like panel those are disabled.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts | 435 ++++++++++++++++++++++++++
 2 files changed, 436 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 11e953657691..1487f2beff3d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-vince.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8976-leeco-s2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8976-longcheer-l9360.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts b/arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts
new file mode 100644
index 000000000000..acea087168af
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2026 Adam Skladowski <a39skl@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8976.dtsi"
+#include "pm8950.dtsi"
+#include "pm8004.dtsi"
+#include "pmi8950.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/input/ti-drv260x.h>
+
+/ {
+	model = "Leeco Le S2";
+	compatible = "leeco,s2", "qcom,msm8976";
+	chassis-type = "handset";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_key_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 113 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	reserved-memory {
+		/delete-node/ ext-region@85b00000;
+
+		 ext_region: memory@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x1900000>;
+			no-map;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&adreno_gpu {
+	status = "okay";
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	touchscreen@4b {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x4b>;
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&touch_default_state>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&pm8950_l17>;
+		vio-supply = <&pm8950_l6>;
+
+		syna,reset-delay-ms = <100>;
+		syna,startup-delay-ms = <500>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+			syna,clip-x-low = <0>;
+			syna,clip-x-high = <1080>;
+			syna,clip-y-low = <0>;
+			syna,clip-y-high = <1920>;
+		};
+	};
+};
+
+&blsp2_i2c2 {
+	status = "okay";
+
+	haptics: haptics@5a {
+		compatible = "ti,drv2604";
+		reg = <0x5a>;
+		enable-gpios = <&tlmm 109 GPIO_ACTIVE_HIGH>;
+		mode = <DRV260X_LRA_MODE>;
+		library-sel = <DRV260X_LIB_LRA>;
+	};
+
+	tiusb320: typec@47 {
+		compatible = "ti,tusb320";
+		reg = <0x47>;
+		interrupts-extended = <&tlmm 21 IRQ_TYPE_EDGE_RISING>;
+
+		pinctrl-0 = <&tusb320_int_active>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp2_i2c4 {
+	status = "okay";
+
+	led-controller@45 {
+		compatible = "awinic,aw2013";
+		reg = <0x45>;
+		vcc-supply = <&pm8950_l10>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@1 {
+			reg = <1>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@2 {
+			reg = <2>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+
+	speaker_codec: audio-codec@34 {
+		compatible = "nxp,tfa9890";
+		reg = <0x34>;
+		vddd-supply = <&pm8950_l5>;
+		sound-name-prefix = "Speaker";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&gcc {
+	vdd_gfx-supply = <&pm8004_s5>;
+};
+
+&mdss_dsi0 {
+	vdd-supply = <&pm8950_l17>;
+	vdda-supply = <&pm8950_l1>;
+	vddio-supply = <&pm8950_l6>;
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vddio-supply = <&pm8950_l6>;
+};
+
+&otg {
+	extcon = <&tiusb320>;
+};
+
+&pm8004_lsid5 {
+	status = "okay";
+};
+
+&pm8004_spmi_regulators {
+	vdd_s2-supply = <&vph_pwr>;
+	vdd_s5-supply = <&vph_pwr>;
+
+	status = "okay";
+
+	/* Cluster 1 supply */
+	pm8004_s2: s2 {
+		regulator-name = "VDD_APC1";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	pm8004_s5: s5 {
+		regulator-name = "VDD_GFX";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-enable-ramp-delay = <500>;
+		regulator-always-on;
+	};
+};
+
+&pm8950_spmi_regulators {
+	vdd_s5-supply = <&vph_pwr>;
+
+	/* Cluster 0 supply */
+	pm8950_spmi_s5: s5 {
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-name = "VDD_APC0";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&pmi8950_wled {
+	qcom,current-limit-microamp = <20000>;
+	qcom,enabled-strings = <0 1>;
+	qcom,ovp-millivolt = <29600>;
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8950-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_l1_l19-supply = <&pm8950_s3>;
+		vdd_l2_l23-supply = <&pm8950_s3>;
+		vdd_l3-supply = <&pm8950_s3>;
+		vdd_l5_l6_l7_l16-supply = <&pm8950_s4>;
+		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
+
+		pm8950_s3: s3 {
+			regulator-min-microvolt = <1325000>;
+			regulator-max-microvolt = <1325000>;
+		};
+
+		pm8950_s4: s4 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8950_l1: l1 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8950_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8950_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8950_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm8950_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l10: l10 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8950_l11: l11 {
+		/* TUSB320 power supply */
+			regulator-always-on;
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8950_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8950_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8950_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l17: l17 {
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8950_l22: l22 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8950_l23: l23 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8950_l8>;
+	vqmmc-supply = <&pm8950_l5>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, /* Unknown */
+			       <8 4>; /* Fingerprint SPI */
+
+	disp_reset_n_active: disp-reset-n-active-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp_reset_n_sleep: disp-reset-n-sleep-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	disp_te_default: disp-te-default-state {
+		pins = "gpio24";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	gpio_key_default: gpio-key-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	touch_default_state: touch-default-state {
+		irq-pins {
+			pins = "gpio65";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		reset-pins {
+			pins = "gpio64";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
+	tusb320_int_active: tusb320-int-active-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&wcnss {
+	vddpx-supply = <&pm8950_l5>;
+
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3680";
+
+	vddxo-supply = <&pm8950_l7>;
+	vddrfa-supply = <&pm8950_l19>;
+	vddpa-supply = <&pm8950_l9>;
+	vdddig-supply = <&pm8950_l5>;
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
+

-- 
2.55.0

