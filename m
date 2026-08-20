Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BF401A3F
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218979; cv=none; b=cNazcnIW/4nG7sWJcqBFeCX08lg1FQG4cmncJumFfDz975MOx8/2lf+tGZBb0Jm2pvYUEw2ecXdC2JoPnuFQcElKZTfgU3MjYYuqM61RfOtaQLrEtpOAgGyYsin637T1dDa1sGWatiDtsPei9jxoPfyhnumO79zgrI7CSdK717E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218979; c=relaxed/simple;
	bh=ZX+dfnRaTa0SrVsUkiWZ6+aPuxDH+p1jwa9fohD54mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvX3cvDYzcPvnqTN/Jeb7AULU0kN0a7BYJiRNbhB96osjJ0g4ogvXARs3No1ywVOBm3quSLmG9UTJtXzVg8lRJa2FpGoQSAPnlL+MrlGM00Kr0fR8rknj//PwVHcl/KKxx1DeIUMaZWUqUfTlPrPWIMvs2KG0FIKrKyzCBIpOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSX1h6TV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSX1h6TV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4956869750eso13039965e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218968; x=1787823768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GyHZV/zqteTssIuHCF3+x6Q16Y8rkjwlrrgkocSDTfw=;
        b=qSX1h6TVPSuqy7F3YaSK2rAUnSw2Tt7Z+4Le+ZwGDe8gIFftyA7SwuaJYY7ApXnbKo
         Rc1x31pKDHsUw8EROTdwLR//bZfLEkto74ofj1rC2QW2beqU7SKShPobvfVAN7J2K7Y0
         vPArTzWEyOxuVl84Mk+Koxuwx6Q2ikK79PNKFyNZ8dGqu04xk8UzI0wYKC6UBVfDwGRk
         cFOmVSIyBrr0/eA7uf6INaiI4UynQSAvLdcQ9ZZktEtPvm80/794W7PtWzUMFLkQMN3u
         o+RcDJkWpzaUgpCDIO1Km4MDhMibtJmhY+Pei7liUsVDY8a4df4Z+7JsaGacDovSbtPP
         Qz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218968; x=1787823768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyHZV/zqteTssIuHCF3+x6Q16Y8rkjwlrrgkocSDTfw=;
        b=D5CN5c5sWGf8P4fKUlEXAtm+rWcJI8Vw4j2ENruqMmrrw25+Z2CD7JZj1C636Bb2gU
         xQn2w/4pIREWo7flXoxofzzCqJAh16T6CeuXSePRWdFydv8LsBktLf7Wb6qJOJdrXOqA
         6Q9OlZbMFpxTlHGyfL5CVOItk4IgpIU5ivHAgNgnwXDAXfDMXj9SjoRh5fzD+D7o3HDu
         cgP8bm9aZrjt+yEAvBXiXCKLw20/C5ipHZrjLCl97/2xB4p8Smnu/kpZ6zhKxLOg0S31
         OWuivL06MnWzVP8QkTuRQgxQVeLIm+Cn4hc3PHIDNwlBBKdb0yP5DU1GV88ziMaJLGld
         z06Q==
X-Forwarded-Encrypted: i=1; AHgh+RriYaSqpM6OffrLKzytjeYsRZEgBU4MRBBrotSZfBIMV0p25yvi75Jtnwmbio8+hexMlUt0F4RYhwkclo3jgio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnIR5rHmcBjAKoaswZxoZo88SVnweDlknagGHDzFg+VyUDxls
	HGqaeUw/fkX7rX/oe6Y3BQyoFp1qrI/g/T5q3A49Ggad+y/RgmQgNOba
X-Gm-Gg: AR+sD109IDF3+qm+VU2hZXlUvozQbW/0ldeyGmm/lDvIQ45e+9Ms/VI38iWxbJnqWpb
	RkNkmhVNTAU9NHj5Xifi+vX8BWT2tOFsNIdNkH/l+w7/gt/IzZ/EgcO1Ul4P2eKRXQSz5rhASBf
	JcVQJiwRQDvYhfr7C/fzc6i1vTVxEOl4vNFD6RyUnlqdeE1ctE7LHZCNCWJ6kg5wCIAZXGQZtEp
	1mrKCrAmPoCBaxktVqtC1HJWZjALsGqw81O0LjrOs4Bn4AQVvN115Fp88K1BHn19fSVOyQLbp1x
	/I+emfUtKyVZhcOasCw6Md2Id3uDPcLYW0kZMht7hr08WZ7dDRvybl0CFzlr7dh7rQdCWpw98N2
	NhI5HXsMfXaBqhmqnFoR0f0nABmqVG2Z5i7A56X9bya13xpq6VSgsGshBnSaSjp2ae+efvQGKRC
	mLKjIdIj9yDEEkSxWXXvb/Zwm0eb3pqI+Iz7zzX23TrbG9b24B2vLTpXES+SXfYWg0MtyxqP7QI
	HZNs4hAwhEGSZo0cMzoVk+5
X-Received: by 2002:a05:600c:1908:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-499aa17d6d8mr181366725e9.1.1787218967864;
        Thu, 20 Aug 2026 02:42:47 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:47 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:30 +0200
Subject: [PATCH v2 7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-7-7130d68183d9@gmail.com>
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

Add a devicetree for the Xiaomi Redmi 9T smartphone, which is based
on the Bengal/SM6115 SoC.

Supported functionality as of this initial submission:

* Display via SimpleFB/SimpleDRM
* GPU
* I2C peripherals (Backlight)
* Power Button, Volume Keys
* Regulators
* Remoteprocs (ADSP, CDSP, MPSS)
* UFS/SDCARD
* USB

Device tree also contains supply maps to other subsystems like MDSS
but due to missing dependencies like panel those are disabled.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts | 497 +++++++++++++++++++++++
 2 files changed, 498 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1487f2beff3d..6dee0a99fdc6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -345,6 +345,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-xiaomi-lemon.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-ginkgo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts b/arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts
new file mode 100644
index 000000000000..99140971a38b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2026 Adam Skladowski <a39skl@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm6115.dtsi"
+#include "pm6125.dtsi"
+#include "pmi632.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/delete-node/ &pil_adsp_mem;
+/delete-node/ &pil_gpu_mem;
+/delete-node/ &pil_ipa_fw_mem;
+/delete-node/ &pil_ipa_gsi_mem;
+
+/ {
+	model = "Xiaomi Redmi 9T";
+	compatible = "xiaomi,lemon", "qcom,sm6115";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_2;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@5c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (2340 * 1080 * 4)>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+		};
+	};
+
+	backlight_dsi: backlight-dsi {
+		compatible = "led-backlight";
+		leds = <&led_backlight>;
+		brightness-levels = <255>;
+		default-brightness-level = <190>;
+		/* Backlight controllers can differ between panel variants */
+		status = "disabled";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&vol_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	reserved-memory {
+		pil_adsp_mem: memory@53400000 {
+			reg = <0x0 0x53400000 0x0 0x2600000>;
+			no-map;
+		};
+
+		pil_ipa_fw_mem: memory@55a00000 {
+			reg = <0x0 0x55a00000 0x0 0x10000>;
+			no-map;
+		};
+
+		pil_ipa_gsi_mem: memory@55a10000 {
+			reg = <0x0 0x55a10000 0x0 0x5000>;
+			no-map;
+		};
+
+		pil_gpu_mem: memory@fa400000 {
+			reg = <0x0 0xfa400000 0x0 0x2000>;
+			no-map;
+		};
+
+		ramoops: ramoops@64000000 {
+			compatible = "ramoops";
+			no-map;
+			reg = <0x0 0x64000000 0x0 0x400000>;
+			record-size = <0x100000>;
+			console-size = <0x100000>;
+			pmsg-size = <0x200000>;
+			ecc-size = <16>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&dispcc {
+	/* Prevent simplefb from dying until we wire panel driver */
+	status = "disabled";
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	lm36923_bl: led-controller@36 {
+		compatible = "ti,lm36923";
+		reg = <0x36>;
+
+		pinctrl-0 = <&lm3692x_bl_active>;
+		pinctrl-names = "default";
+
+		enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+		ti,ovp-microvolt = <29000000>;
+		/* Backlight controllers can differ between panel variants */
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led_backlight: led@0 {
+			reg = <0>;
+			function = LED_FUNCTION_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			label = ":backlight";
+			linux,default-trigger = "backlight";
+			led-max-microamp = <25000>;
+		};
+	};
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm6125_l18>;
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&pil_cdsp_mem {
+	reg = <0x0 0x51a00000 0x0 0xa00000>;
+};
+
+&pm6125_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pmi632_typec {
+	status = "okay";
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "dual";
+		data-role = "dual";
+		self-powered;
+
+		typec-power-opmode = "default";
+		pd-disable;
+
+		vbus-supply = <&pmi632_vbus>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				pmi632_hs_in: endpoint {
+					remote-endpoint = <&usb_dwc3_hs>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				pmi632_ss_in: endpoint {
+					remote-endpoint = <&usb_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
+
+&pmi632_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1000000>;
+
+	status = "okay";
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		pm6125_s7: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2080000>;
+		};
+
+		pm6125_s8: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l1: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+
+			regulator-always-on;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		pm6125_l7: l7 {
+			/* sdhci2 vdd-io-bias supply */
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
+
+			regulator-always-on;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1768000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l17: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1232000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+
+			regulator-always-on;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&sdc2_state_on>, <&sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_state_off>, <&sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+	/* No binding for vdd-io-bias on L7*/
+	no-sdio;
+	no-mmc;
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&spi2 {
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>; /* Fingerprint SPI */
+
+	lm3692x_bl_active: lm3692x-active-state {
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <0x02>;
+		bias-pull-up;
+	};
+
+	mdss_dsi_active: mdss-dsi-active-state {
+		pins = "gpio85";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sdc2_cd_on: sdc2-cd-on-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sdc2_cd_off: sdc2-cd-off-state	{
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	te_active: te-active-state {
+		pins = "gpio81";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&ufs_mem_hc {
+	vcc-max-microamp = <600000>;
+	vcc-supply = <&pm6125_l24>;
+	vccq2-max-microamp = <600000>;
+	vccq2-supply = <&pm6125_l11>;
+	vdd-hba-supply = <&pm6125_l18>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&pm6125_l4>;
+	vdda-pll-supply = <&pm6125_l12>;
+
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	maximum-speed = "high-speed";
+};
+
+&usb_dwc3_hs {
+	remote-endpoint = <&pmi632_hs_in>;
+};
+
+&usb_hsphy {
+	vdd-supply = <&pm6125_l4>;
+	vdda-pll-supply = <&pm6125_l12>;
+	vdda-phy-dpdm-supply = <&pm6125_l15>;
+
+	status = "okay";
+};
+
+&usb_qmpphy {
+	vdda-phy-supply = <&pm6125_l4>;
+	vdda-pll-supply = <&pm6125_l12>;
+
+	status = "okay";
+};
+
+&usb_qmpphy_out {
+	remote-endpoint = <&pmi632_ss_in>;
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};

-- 
2.55.0

