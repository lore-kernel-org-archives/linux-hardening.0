Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CE43030B
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380971; cv=none; b=PtEJ7C8eEcyZ2OSeJehmJVR0CpMUkOaYvQf/Qa2Sq31KBCzaMXSc9QrAqsZKYoZ7jjOy/sO84lWTNBf23i8LlqRa18lRBOoWOzz2EtcC71iPHssGw6tofPNenK80E4YEbTk5Dko+xDUDUGbzHSCw1+UAsp/KOhtYAt6rtQgR7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380971; c=relaxed/simple;
	bh=7PsGevQve4qMwi7IbXb68zDiIJqnhBeLxzgbvqI74gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7epVQ0kYv5nhcECwihYV+5s2l7iLzuf2H//Dcc02ENSgqh6cyGYxITfFTZleKvKpS/qqyC+pfRaNpGqMENW7TJDy71OqfZ5uRFttl51RKFnoOiD/yWO5tJIJlHostTAIVOyLXMKMiAZUzRKx7yxejit7rDEk7xHCif3e99VxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAQVxJ0Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAQVxJ0Z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso14543765e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380968; x=1786985768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfz4Ri2i5Qof2TSYXxgkmlofR5UVdlrgNBtdIvsZDwo=;
        b=SAQVxJ0ZzEeX9LUz47LS8z84aHV+AMAvIy4yeyzjua9iFGY1F3tXTLov7gLRgNaNVb
         64Id0BFKmjloU8usBSqQES0TYw5Ep4qWDUXHxKN+2P6cwpjSZg1WuWufDbvFhprulpn9
         i0y0En6CwaL58yGZ70EGSbgD5ejF9Qa039ByxO6Pm8vJNksXFlTCT9lQFttrNzlUf10D
         a2c4W41ZQ0zMJC/cvqe0NyKvMZGGxtQ9GBcmka36PVeWJ5xXXCUOLV5gxHyFlyiQ5DTA
         jmI/eme/KrIS7hjZsmS0YLHkjIa9rKQVGmrjlrwkJGeZFHJl8b1pNnvex2cCYml5ithm
         7pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380968; x=1786985768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfz4Ri2i5Qof2TSYXxgkmlofR5UVdlrgNBtdIvsZDwo=;
        b=r/k59WEhTKWYp+QPJVATFw7SY3myJc3gfOm/45jI3k2liW4Lv40Fk/YKNtVgjQEotO
         TtzhsDBomnGwvaG0DwGdniSPPjrFQyfydEHNyrbDBDZtb3NPhEuOJrjVGNtMwEiOuNew
         civGwFslcO/lQW3aXzk5aPVzM6wtVX+Hd6ZFkHZE6D3fsgClRDtoAUejdBECl7MhlAua
         LTgl0iWlIV0lVeS6qG1WP8WP/WeJBi16VpN390eDhStaq/FZ1KKq8jqC4IL+scBfQDTl
         359955LY30q4MsIR/SpS+wcSdP/6lepk631KgK7Rg1mcDbYKXV6P8qpTCVIRKVUuYaLG
         5/NA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/wXPGM2nsKfco4T/alAZlGyGf8FyJYnuoBLlMeIvLVz1HeYrdULg/bWz+sENix5sJKWvM/e+mLjstJGWvcTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcFteLcl7isyuPe/vK7UR/knP0m+NWoKuls6fcOwjRgaCKPMf
	Y/Acsj328o3ewF2Gb1gOP8GKvqstvV6U8li1xtWU3fjfFxYRoP5/+Aaw
X-Gm-Gg: AR+sD10oSxEw1LSM+P0T5UNChZW8R2Uxv5/gM83CNTxvDpLjfbX9TZMlbr33K7AYQA9
	zU6j/3xx6Q2h2p6fX4cDWdsMOAWP99UF7eyANKvYd/TWofkuh/wYlSlFATMZaSxYU/GiCqys22z
	YLgbeLJKlLcBPJaQpO+KjjEX7Ser49zVW0qNPNbLamg9Tn9HpLK9qRjY8fNr2POMySCxt6k79eJ
	HjYrAihzM0/yEaTu7ftAUxq4/M2JCrryDyo+BXYqQPoMReNyhq8AAAy30io5IAayYbP6Q9uQBrO
	tgvY92HuOnDAenVv/dBSTPqwb9CjLsBiHRNJ6hqynTTDzAAxJhjv+WAJb8Dmm1RoL2LAh0EA0We
	bRqhZhKlStVBe1gYXgQLVSAbsBrPbpwCyvZRxvz9WbuUb55ib8ZyFSYRWirlCJvtKusDj6fnvYq
	mx3wSrJvN7DhiWoFz8MtWxq8bjII1eTXJwtZ2XpoJ5T1L4q/Ov2zySpRbx/E8HS8Xq4nk3i6vrd
	qzeiNJmeDTdPtEajth4SUoV
X-Received: by 2002:a05:600c:4454:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-499727c003dmr39198665e9.19.1786380967865;
        Mon, 10 Aug 2026 09:56:07 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:06 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:36 +0200
Subject: [PATCH 3/7] arm64: dts: qcom: Add Motorola One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-3-79a779d76173@gmail.com>
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

Add a devicetree for the Motorola One smartphone, which is based
on the Jacala/MSM8953 SoC.

Supported functionality as of this initial submission:
* I2C peripherals (Touchscreen,NFC)
* Power Button, Volume Keys
* Regulators (PM8953)
* Remoteprocs (ADSP, MPSS, WCNSS)
* USB

Device tree also contains supply maps to other subsystems like MDSS
but due to missing dependencies like panel those are disabled.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts | 443 +++++++++++++++++++++
 2 files changed, 444 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1c86e7e98f55..11e953657691 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -120,6 +120,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918hd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-flipkart-rimob.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-deen.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts b/arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts
new file mode 100644
index 000000000000..d03b314cd1e8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2026 Adam Skladowski <a39skl@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/delete-node/ &cont_splash_mem;
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Motorola One";
+	compatible = "motorola,deen", "qcom,msm8953";
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
+			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	reserved-memory {
+		qseecom_mem: qseecom@84300000 {
+			reg = <0x0 0x84300000 0x0 0x2000000>;
+			no-map;
+		};
+
+		cont_splash_mem: cont-splash@90001000 {
+			reg = <0x0 0x90001000 0x0 (720 * 1520 * 3)>;
+			no-map;
+		};
+
+		reserved@aefd2000 {
+			reg = <0x0 0xaefd2000 0x0 0x2e000>;
+			no-map;
+		};
+
+		reserved@eefe4000 {
+			reg = <0x0 0xeefe4000 0x0 0x1c000>;
+			no-map;
+		};
+
+		ramoops@ef000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xef000000 0x0 0x80000>;
+			console-size = <0x40000>;
+			ftrace-size = <0>;
+			record-size = <0x3f800>;
+			pmsg-size = <0x800>;
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
+&hsusb_phy {
+	vdd-supply = <&pm8953_l3>;
+	vdda-pll-supply = <&pm8953_l7>;
+	vdda-phy-dpdm-supply = <&pm8953_l13>;
+
+	status = "okay";
+};
+
+&i2c_1 {
+	status = "disabled";
+
+	typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupts-extended = <&tlmm 9 IRQ_TYPE_EDGE_RISING>;
+
+		status = "disabled";
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+		};
+	};
+};
+
+&i2c_2 {
+	status = "okay";
+};
+
+&i2c_3 {
+	status = "okay";
+
+	touchscreen@62 {
+		compatible = "novatek,nt36672a-ts";
+		reg = <0x62>;
+
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_RISING>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+
+		iovcc-supply = <&pm8953_l6>;
+
+		pinctrl-0 = <&ts_reset_default &ts_int_default>;
+		pinctrl-1 = <&ts_reset_sleep &ts_int_sleep>;
+		pinctrl-names = "default", "sleep";
+
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1520>;
+	};
+};
+
+&i2c_5 {
+	status = "okay";
+
+	npc100: pn533@28 {
+		compatible = "nxp,nxp-nci-i2c";
+
+		reg = <0x28>;
+
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_LEVEL_HIGH>;
+
+		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&nfc_firm_default &nfc_irq_default &nfc_pwr_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&ibb {
+	qcom,discharge-resistor-kohms = <32>;
+};
+
+&lpass {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm8953_s3>;
+	vddio-supply = <&pm8953_l6>;
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vcca-supply = <&pm8953_l3>;
+};
+
+&mpss {
+	pll-supply = <&pm8953_l7>;
+
+	status = "okay";
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pmi8950_wled {
+	qcom,current-limit-microamp = <25000>;
+	qcom,num-strings = <2>;
+	qcom,cabc;
+	qcom,external-pfet;
+};
+
+&q6afedai {
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+
+	dai@127 {
+		reg = <QUINARY_MI2S_RX>;
+		qcom,sd-lines = <1>;
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_l1-supply = <&pm8953_s3>;
+		vdd_l2_l3-supply = <&pm8953_s3>;
+		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+		pm8953_s1: s1 {
+			regulator-min-microvolt = <863000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1224000>;
+		};
+
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1896000>;
+			regulator-max-microvolt = <2048000>;
+		};
+
+		pm8953_l1: l1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8953_l2: l2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm8953_l3: l3 {
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+
+		pm8953_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8953_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm8953_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8953_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8953_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l11: l11 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3125000>;
+		};
+
+		pm8953_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l17: l17 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8953_l22: l22 {
+			regulator-always-on;
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8953_l23: l23 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1225000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8953_l8>;
+	vqmmc-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
+
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <96 4>, <111 1>, <126 1>;
+
+	disp_reset_n_active: disp-reset-n-active-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+		output-high;
+	};
+
+	disp_reset_n_sleep: disp-reset-n-sleep-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mi2s_sec_act: mi2s-quat-active-state {
+		pins = "gpio135", "gpio136", "gpio137", "gpio138";
+		function = "sec_mi2s";
+		drive-strength = <8>;
+	};
+
+	mi2s_sec_sus: mi2s-quat-sleep-state {
+		pins = "gpio135", "gpio136", "gpio137", "gpio138";
+		function = "sec_mi2s";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	nfc_irq_default: nfc-irq-state {
+		pins = "gpio17";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	nfc_pwr_default: nfc-pwr-state {
+		pins = "gpio16";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+		drive-strength = <2>;
+	};
+
+	nfc_firm_default: nfc-firm-state {
+		pins = "gpio62";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+		drive-strength = <2>;
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
+	ts_reset_default: ts-reset-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_reset_sleep: ts-reset-sleep-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&wcnss {
+	vddpx-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+
+	vddxo-supply = <&pm8953_l7>;
+	vddrfa-supply = <&pm8953_l19>;
+	vddpa-supply = <&pm8953_l9>;
+	vdddig-supply = <&pm8953_l5>;
+
+	status = "okay";
+};

-- 
2.55.0

