Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288B48D883
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312217; cv=none; b=KJYNU3hx6rv/Kd7p3u1X7ILSGkdpg3Qdbu6ZwJCXseJp00Z5UJaPUXS614hKp4ZFvkgNGuCy9S00ZmT4+82PP+yUPD6LLMwDZGk/U05V3MlYrF/OvaH2j/Z+G0A8ooIY8d0RK6KwRW945Yxasm6Hy6glbGxbJX99oZjnqYCu1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312217; c=relaxed/simple;
	bh=cmsTCZivTO56+MZNkXb89TsneKpl92HFqLHnZN2TuXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajF6l5qnGV/vAVbKwAwTVZZLSNrX+X1F1EHRi5wsHSiSyRk2goY1QMwbtALJrWj+b4hanm+4dUcPAbxOXKkd82ujPnEMyfxFM4XknpDskhPJzg52ln2bwGjH9x/Jt+7Gh6TXinv7DB9BuhawFKElVM3WfzFvDeJ7ev1PT9+ey+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFByRhHu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFByRhHu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so1823792a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312213; x=1787917013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsLpp05yBiLYK+LWJEq6WaHCGAG/OixMg6mfbGL/riE=;
        b=aFByRhHuIknZqQW+ynXnnQvaXmjcikwbrY7TFAcsskKR1zoQv9emRJ6bBiuLWAYEzM
         OqcQb/hQCq3c/uHYumsQF0P22jNi3DjDivRYvPjgyiilEq68wfTal9Kp6y3Sm+jFPiVI
         ikGrm9G5mH3BLY8WKGChktSESJoMyFGO3bEMLpceJGvgYqWe3kd09bN2OdOu0UlydBoU
         BVGb0JQc99jnPeHNk+yStCSEr7xk0dtpevSDVUoXkcFoa7rGmiUfOQLsQ3Mxhqc5K2qU
         kQX5VkaeffTEt/FiSb3YQAkaL4bJg0N9sQYER8DaU8Gh41BFixiojlhMqcOeoZNUX0ni
         nV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312213; x=1787917013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsLpp05yBiLYK+LWJEq6WaHCGAG/OixMg6mfbGL/riE=;
        b=q6G9abrXecXocgigWFnE6JiBeoIGcJgnzxS8M035XBKh/FgZgRdaM64fGzFWfjY8VH
         0DVBYhax9R3gmpOHDusvbGDqcqkyITx63Mq41Myzgz/QYkW3eloQwH9tUeRqvNo77mXC
         Bq+B9TsrXV61B7E1kZP/yQ7cmApzxEBcoSZaKZ/LYnkP3sRLliG56akn3u42EBzlpM+S
         XwzqsPjC6tlouLApT6JxRK4RXK4qSmtUZ6/pwZ4HRQmWXk7pKv97HwVJozCEwvAOREYd
         HCI8www4yfW5Q/dIxCKLPncJxAJJcdron3wtS7BJeQgPYRWJhBHJbvKO0L1WUK+YUvBB
         FhIw==
X-Forwarded-Encrypted: i=1; AHgh+RpDRy18mXAG0Ofas+o8y4RbszqNt6Q6TNQLuOYnhwRD9FWGtF7O1Q9e6iFgyK4yaCF3ayueBR1r6LLLRJwdBCM=@vger.kernel.org
X-Gm-Message-State: AFuF++mBJCgj6R814EBGER7zKFQ4DMXQLgFX7c0ukKBsoxjcPbkkPQ2m
	8wD9/RDpD9QeoaM7hoFFKhxmFu171iyY9JEHBACuuhfE37Yq4jYpGnJK
X-Gm-Gg: AR+sD12VjdkmZTr7aUVxKBmXYMUcthS7hnafBvXfLbZbO7ZD/2NhCvkWUPgdCOMj+pB
	Qeuipma7Myhw86MtVGE6pDi/SWkbXxQ47PPq2Q7Mo5ovd9HOgYVfs2BP6Ltsu8ClVUFeNT+HNqb
	tJsb1Roh7UatODafHCk+FbyeKwhgsA9RkMkDNr5tJiglI6c+7W+xV9QPCwnh4YnAV5fePxhw66B
	b0/yx2xE5kek9Ci5Z8fBrvf9pSvTmCMCmGmnKGU6tkwC+ctxeFm6oUCucZ21rF3yi4RQ7FnkBxB
	S2tqhKp5hjfzsNKWD+o0hCxlkZfHCp3wBw+csipa2uwTHADWiSVET+tQQg2z640N4u8TQkxa4c0
	daG2MnCy3IBx8eEF3tNzO2CeS3yddzEZbTLMeAkjnRi/tQ7vFBJhtfaECHdxs+g5yXC8ts8BXQV
	52pkGP4bY+YJNaB5icuvauWgPtLblSbh9YxyA4S7BMmWm4uEFBSECi+zCOMMPqUXTSj6otemYHG
	DXGIRAM/cTUifsXwzaBFr1K
X-Received: by 2002:a05:6402:44d4:b0:6a1:854:e75e with SMTP id 4fb4d7f45d1cf-6a42f26e30cmr5699414a12.15.1787312212506;
        Fri, 21 Aug 2026 04:36:52 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:52 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:34 +0200
Subject: [PATCH v3 7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-7-cd64bcef6e21@gmail.com>
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
 Adam Skladowski <a39.skl@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
index 000000000000..881e05b70116
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
+	sdc2_cd_off: sdc2-cd-off-state {
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

