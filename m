Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1348C412
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312214; cv=none; b=sBzgFxDX4eII+9A0htDjaFtDFZxC8QsESOTEimECk8kjxwHcyT59ay1IO2eTzVL20apcuGpC3UR/XKpA1dolvkUsv4mMnOL3kmSnx+NbhTbeL0gFNVvt4zPm/DOSRW4WiCv/2zfNh8SrWKj/kMQbO1uQ8bopB4cTXTXst/Wz3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312214; c=relaxed/simple;
	bh=otJywGMq2Zm8UHvbeThm9/Ss3+gSc95PQnUFlzFIRuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gm5UYz0iVTQ9f8NOJnN7V8EZSWASsTQQHIniNPbR2QxP6aMtBqZU6RwklLMdIlr5q8BDJp7jVdaj+n65hrFiuN0gu2AtUkNhgH04Tl4H+/+OmaxiKm2mBdMARJ3/5ukF88A5FoNmZnhf5zwmbIs+9vp/7AghklVXYopRWn1misE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXMkLhl0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXMkLhl0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c214321dc32so175774766b.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312210; x=1787917010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pctlxGfVuYsoDkyJlb44I3B/YDSYrRxeO6J9tEOOSM=;
        b=SXMkLhl0YsBOCeDxr/Xdgx5t9PlIIQVCLaCZK46WSbdyxpnDjLnPjPQ3V4u2v6ekvu
         xETJURDE+llnboj0vHC4iPS1PTQhPBdUPC2qibQFA8Zhn7+uyQt5nV99MSfDYVi+N6Fe
         DUHxasAspj7eloJAwxMv9tp1SOBG9FBDcE98MSIoOgwPBErP6Bwtv5WL31LtpnR9FTbD
         vfig7eDn8HOKOKqzPS1InlO303v7uxt5QEO2sRFgUVR1XbHven3gybNr7WxA3GrShjvQ
         q9gogZyZVHvnwkmRpy6Itbh/3CjxvZldmWjmlJZYoQCJzhlsMMwinV463yYTG26XgOzw
         H1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312210; x=1787917010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8pctlxGfVuYsoDkyJlb44I3B/YDSYrRxeO6J9tEOOSM=;
        b=WNAa7ATsd9sQ+Dxh2Qb5o4fbutREIIcMPY9idiF493R1U7FLPPxt5Wm1qmv1p4act4
         c8AMXeUaBTZQ4PR+vE3qKS0NUIRQ0gn8FpkzM/KbVuJ0J+EFzSN6GBhATtJK1gxMHM0H
         5IIWZiqhHlRKWv1MlekTcUQCIDBT3TrRDbxu+Kwgv5Kr3MNmTCSBnUQOdBn7CuYA12/h
         xirSQt5GvaJk9Kovg7q5acfrKvgteo9WALimhMSqhBdKy1dqWdEidLD7+9qAcUHSQ3gt
         fYmfTvHGHe1f0elcrEmbP7p67kPYoCIyCZjYaQZ9oFHhorS/3vDXlJugatc+xjD6VjMg
         9new==
X-Forwarded-Encrypted: i=1; AHgh+RqN5DV+KGTYzNlndXsbHg1j3+CFdwO48cean4xnur2GjZhdg6BZjZxPD9o1j2RZ5EmXeMM7vh5GQRnf768HCW0=@vger.kernel.org
X-Gm-Message-State: AFuF++mcNoeS7+eHTI7qOdftYkJS045m0cgHeq//mkBlE2VyHMZ6/RRc
	FF3KSRrsPSZR04TIsTefu5OiC3dlIBjKM7hA+CuclWvpB+Z16a0yrMJY
X-Gm-Gg: AR+sD12NQw8nVT6ENX9YCnv20G/kFT+WCMLjD1e+Gqw5uSHOeQ//vGo0zlDqEsi79QI
	CndCLBr9CmUqg+o41X3IrfyIP7NeTx7BMDCtBEv57u/6Gz69jspw+UaenvlsH0P7NnTH7AXWPOm
	hRlftsVggUS6zssO9VPPCTUhIFak3Y46zN+3nv0KuLPbwhhhvpSf13zU1JFrkBwxYdOpbqs3q07
	meUfyzPqMhi9/YZVL5r4FS6m29EWJglP7LbY497PlqeTnndRU1N8Y9B0+3KKR+wtKs5/RlwMPqe
	AJEaExTBQYh0m2a8TsISl/nDw2llnURg2DjTkXdO2EmS46+5K9cDrienNbYpftzK8HT+SfoxPeI
	9COpTO8Qb+RGFS6dYsXhFhqx2fL9vTIuEtl4NQzEFy/CY8LVUO+O2cCoJaD2v5iUspuNMMNHJA5
	xeFgtl6X4GiIfcEYd4YzmSlbjXqzjbvakOnuSsvTUTHDCAeXnfZQv+T/HWChK/Tw1R9o7pKeVf3
	inY8+rY9pclEK2v6scieh9y
X-Received: by 2002:a17:907:9346:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c246a3ab4c2mr650671866b.7.1787312209971;
        Fri, 21 Aug 2026 04:36:49 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:49 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:32 +0200
Subject: [PATCH v3 5/7] arm64: dts: qcom: Add LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-5-cd64bcef6e21@gmail.com>
References: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
In-Reply-To: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts | 441 ++++++++++++++++++++++++++
 2 files changed, 442 insertions(+)

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
index 000000000000..086fab5ae6e7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts
@@ -0,0 +1,441 @@
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
+	gpio-keys {
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
+&pm8950_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&pmi8950_wled {
+	qcom,current-limit-microamp = <20000>;
+	qcom,enabled-strings = <0 1>;
+	qcom,ovp-millivolt = <29500>;
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

