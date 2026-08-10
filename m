Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70E430CE9
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380974; cv=none; b=kFNqYS54QENgU9u6MsEeyL02lNnBx5ZYSMAFPJ7LU5l2sdCEtnDdaLXStm0avy+c9p59VvIBV/0GufdUyDE1M/LVwlaWqrCMaMXlyIkE7ilaNxAyhu/YPFZEtemcIOaK8FtQ+H3pMvwk8Npt22M+VUdcfRGh1ybYnXYffvCAMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380974; c=relaxed/simple;
	bh=ryrFYceQWFo/unm/rgfW5Wl2fgVTCco/96eG0t4IQQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkwJh7v4Wn91q2inFVFcVAeTNw3s2jQT4o3WEv6t4qEcJ3DzOj0y3QHZE2Rf/88aty76E72iKxQWF0LbwFwKbCfD9gnfYhrfqvyk5uJJi+wV/LFQrdUaMfU+h/ZuwatKwAvQxJC9SJEdpXM80HyQ0ZYFTQRRZJP58G9Sslzm76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHYsCdfl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHYsCdfl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so26501345e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380970; x=1786985770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rilTmU9qxjFhaMwYpRjSmBeVlZHeVHyw3plQa/WRS78=;
        b=UHYsCdflmlCjCu1/j8HkqBa1IoEIktmwF9S408uLD5or/mw8pnuPdlPSc/AY1yP2Bs
         9QwsVZ8Vdb+uoNV0C0Qua6lsNQd/yQ95+jk0ckfEga2vn8ED0d76wotwYlNWB0ELAvsM
         QYWDzHoWyZf4Xf67VAW2EbPiiMSzVvm33F36/hykJg/a3gL5RR2SB/zeP+o9KaMTwsDm
         eXYDSWA41+F43VuQ/qsMjj801VOipLJVIH6GSzdeTr14UY7ij9qBEkpEH+i2/XU9uGRQ
         JdRg8pw384RYnPmsEWbTqlVLvgJ3FWpky6LfRn90uKs7WAM/qDLTgNmz3xtVZl5+oziY
         /Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380970; x=1786985770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rilTmU9qxjFhaMwYpRjSmBeVlZHeVHyw3plQa/WRS78=;
        b=tBDBfCEKq6bElTl3lrTt1Qx6SYEWA8m5tUNYFyNLTWz5j+atGmITh7lsxBm3M2ZU0N
         6MTVFRtkLSwJcnffzzO76gL0R+IK+NH+KjRgnasHEEM3ZI7i3UUoSWiRhrGhqn1Z8QL+
         hASfn2WpHS+VER6z2ZlztMbsCEQJwkWVK1mMip3LvIrGlY4GsIVh//2h9C8dZ8RUY3/e
         FgXhcPjClWOxZiCCNCd9XQaCr/ExuUYhohlmITQWujVXL6FnVFDtGd9QqdgiKHCNcpBI
         vas/KA+H5gag5eQ43i3ab9kD9N3RMFGW3aBep8cmMu+HUEBwogyfnZuEknsI0Jrsj1nc
         pAgA==
X-Forwarded-Encrypted: i=1; AHgh+RorZbstDoxssTynwnjbRjAQ6B9Po6d98lhZvuTD+gwpJGRMWzQ5Wi/oMASrFKCyXk6W1QhFkO3QFw+4evj9w6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPT076C+hnvW5BtQapQ2muaIm6RqR8zoFd297l7qlG3LvZRr0x
	74tUvxUx0TiBH4Sxw263PrDzHeaqmdpcAO86UfyA1lLEc7wwAaB6Y8ng
X-Gm-Gg: AR+sD12bw3D6KxflOv0DKSBCDBtCCPklGSoqplEFSPmc6ySV6/19BPipDrEQwdarr13
	4wgTFVTBdbnm6YeWWOcJMspSa3ELmiWlXee4MYDfQjxpeqr63VrmMA4LYhByZSgagwD7kKWGvaw
	n1fB5uFW6eLTaD2ABjtzMXOrF42mXzYbHUULK+iIY6Gdb5fMaX7sPHyzgccD0j96G0ml4E91raA
	ilzZsds+mfKA6XG6UItQz5hTJFw9h5rMnWa+PMnPEDbOb1dMFGXMOoO/UDQy4FfoAgX858IOsqB
	eE4ulzboNK4h0AJYoAkojQFa3kAVIriqPA6vHrZ1En2HEWiejs//alQA1cKmoWmuMLTUx5BBW7m
	qtG7bntUgU1U//qRuHtJc/n5YgdX3TwNxgCNtsENC9iiqCYTPYrXTsWoaNubGnpNvtH02iNgvkQ
	J3jq3IQYWwnx65A89Nc1vl4S6aB/aolvGG5VF8b9y4hSEEBuiI7tUwQfwAKRkuNRY9bbnub4jZD
	JJ3OqLGUkybJaqB4Tw0Gkt6
X-Received: by 2002:a05:600c:6c06:b0:499:7024:9d4a with SMTP id 5b1f17b1804b1-49970249e66mr62537075e9.8.1786380970045;
        Mon, 10 Aug 2026 09:56:10 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:09 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:38 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: Add LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-5-79a779d76173@gmail.com>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
In-Reply-To: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts | 444 ++++++++++++++++++++++++++
 2 files changed, 445 insertions(+)

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
index 000000000000..4a11ea66efde
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts
@@ -0,0 +1,444 @@
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
+
+		ramoops {
+			compatible = "ramoops";
+			no-map;
+			reg = <0 0x9ff00000 0 0x100000>;
+			record-size = <0x10000>;
+			console-size = <0x60000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+
+		/delete-node/ memory@83000000;
+
+		cont_splash_mem: memory@82000000 {
+			reg = <0x0 0x82000000 0x0 0x2800000>;
+		};
+
+		/delete-node/ ext-region@85b00000;
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
+	rmi4-i2c-dev@4b {
+		reg = <0x4b>;
+		compatible = "syna,rmi4-i2c";
+		interrupts-extended = <&tlmm 65 0x2008>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd-supply = <&pm8950_l17>;
+		vio-supply = <&pm8950_l6>;
+
+		syna,reset-delay-ms = <100>;
+		syna,startup-delay-ms = <500>;
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
+	tiusb320: tusb320@47 {
+		compatible = "ti,tusb320";
+		reg = <0x47>;
+		interrupts-extended = <&tlmm 21 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
+&blsp2_i2c4 {
+	status = "okay";
+	led-controller@45 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "awinic,aw2013";
+		reg = <0x45>;
+		vcc-supply = <&pm8950_l10>;
+
+		led@0 {
+			reg = <0>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+		};
+		led@1 {
+			reg = <1>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+		};
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
+	status = "okay";
+	extcon = <&tiusb320>,<0>;
+};
+
+&pm8004_lsid5 {
+	status = "okay";
+};
+
+&pm8004_spmi_regulators {
+	vdd_s2-supply = <&vph_pwr>;
+	vdd_s5-supply = <&vph_pwr>;
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
+
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
+	gpio-reserved-ranges = <0 4>, <8 4>;
+
+	disp_reset_n_active: disp-reset-n-active-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+		output-high;
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
+	ts_int_default: ts-int-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_int_sleep: ts-int-sleep-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_reset_active: ts-reset-active-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_reset_suspend: ts-reset-suspend-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
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

