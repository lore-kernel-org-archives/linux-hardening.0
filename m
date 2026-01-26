Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD85342CA1;
	Mon, 26 Jan 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445311; cv=none; b=QSE05TNdNnCOE3im+clnXIYVdYeSMrnxp74s7olUsnlLzxP8YoxBCjPOgqurEkk1l401rjaHyJEuk2ms8cQdpQ9HtM+YYq6g6Rx6IaexuGS7oWWX8pVsScBISDOoynSrGwNE3kAp2TJPuLnynZ78HUYXYYVRz0O/CRHX/vXu5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445311; c=relaxed/simple;
	bh=5D2ZvG/XAcueF08kiycNFuK6ZfCE6sNffiMEi4jHNys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Le+gYXCvhGEOITmxv8GcrF71UFzhyKlWgg4PJivvrfgJ+79zihIvDfAFrnGiooejTFOAF985DktPoriogJZZzbpyB/DzMTtZXMB1vxw/1gpsQSNAapOTTA0wcwfCIWotzIHbrwY2dN14kzjiCanlWrh1mYRTGU7LVb4ZJtzg/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=czvrQfXV; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CPyEQQrH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="czvrQfXV";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CPyEQQrH"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1769445299; bh=8QqdSUiCwyhmN+Yz7YdFQ28
	nss7zms5RvjaCFogF108=; b=czvrQfXVZgol0V5mUMdmc+2BAYBs89ordhkEWdtQDkZxJaE6G0
	ft/eEB9lJdra3id5op5YVqAEYYc7PVlCsvdeyCyKc/e/C7ZWaqPGD4RsDP8h/6blaZlZxIG2Jrh
	jN1MsV8c6yc3QpdmA6a0VtrbQsTciDSarzxbp9f8wmkTP8+l5+ViIt8f5Zw5nnKJKeJjOUFEXBS
	9kGklgAQCfx1DrqODmKFfmKTtoWKuEwk2TLO8Qtg8R8ZCNaBPZ4x5UchSAGP/OAh61jTOpap5n0
	G8hi4tA/Dt6TfGy6WhdrNs3UUYjOKXhyBuu/7N4VRCUPsPf58BtSzhaGQbZ/xsHbVSA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1769445299; bh=8QqdSUiCwyhmN+Yz7YdFQ28
	nss7zms5RvjaCFogF108=; b=CPyEQQrHmCdzON6Iu6UAqbzvvL+X77kY2J/5dQRuiamV9DkwOj
	lCkvuxeJe2jcqz5vF57G0S7xdr3Hs8/9jLBg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 26 Jan 2026 17:34:57 +0100
Subject: [PATCH v3 7/7] arm64: dts: qcom: Add Redmi Note 8T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260126-xiaomi-willow-v3-7-aad7b106c311@mainlining.org>
References: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
In-Reply-To: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Gabriel Gonzales <semfault@disroot.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769445293; l=15462;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=5D2ZvG/XAcueF08kiycNFuK6ZfCE6sNffiMEi4jHNys=;
 b=LJq7IWSJWC/xWtBSUJGqIHj87/Rz0UWs+HXSSnxWMLkC/skwS2BkXEiiPxWGCatMMhCIJJFxs
 vYTusYRGEBVCmZVNPngz0H4XINryct8ntT3s76N7uraiwlb//7Dlaa7
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Redmi Note 8T (willow) is very similar to Redmi Note 8 (ginkgo)
the only difference is willow have NFC.
Make a common base from ginkgo devicetree for both device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   3 +-
 .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 301 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts  | 291 +-------------------
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts  |  15 +
 4 files changed, 319 insertions(+), 291 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 0ccd6ec16dfb..9290e74651a8 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -279,8 +279,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
-dtb-$(CONFIG_ARCH_QCOM) += sm6125-xiaomi-ginkgo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-ginkgo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-willow.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
new file mode 100644
index 000000000000..c5616a083f71
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include "sm6125.dtsi"
+#include "pm6125.dtsi"
+
+/delete-node/ &adsp_pil_mem;
+/delete-node/ &cont_splash_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+
+/ {
+	model = "Xiaomi Redmi Note 8";
+	compatible = "xiaomi,ginkgo", "qcom,sm6125";
+	chassis-type = "handset";
+
+	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer {
+			compatible = "simple-framebuffer";
+			memory-region = <&framebuffer_mem>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	reserved-memory {
+		adsp_pil_mem: adsp_pil_mem@55300000 {
+			reg = <0x0 0x55300000 0x0 0x2200000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa_fw_mem@57500000 {
+			reg = <0x0 0x57500000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa_gsi_mem@57510000 {
+			reg = <0x0 0x57510000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: gpu_mem@57515000 {
+			reg = <0x0 0x57515000 0x0 0x2000>;
+			no-map;
+		};
+
+		framebuffer_mem: framebuffer@5c000000 {
+			reg = <0x0 0x5c000000 0x0 (2340 * 1080 * 4)>;
+			no-map;
+		};
+
+		/* Matching with recovery values to be able to get the results. */
+		ramoops@61600000 {
+			compatible = "ramoops";
+			reg = <0x0 0x61600000 0x0 0x400000>;
+			record-size = <0x80000>;
+			pmsg-size = <0x200000>;
+			console-size = <0x100000>;
+		};
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
+			gpios = <&pm6125_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+};
+
+&pm6125_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&hsusb_phy1 {
+	vdd-supply = <&vreg_l7a>;
+	vdda-pll-supply = <&vreg_l10a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt = <936000>;
+			regulator-max-microvolt = <1422000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1256000>;
+		};
+
+		vreg_l2a: l2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1056000>;
+		};
+
+		vreg_l3a: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1064000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt = <872000>;
+			regulator-max-microvolt = <976000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt = <872000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1896000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1896000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1952000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1996000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1832000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt = <1248000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1264000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt = <2600000>;
+			regulator-max-microvolt = <2856000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+
+	};
+};
+
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&vreg_l24a>;
+	vqmmc-supply = <&vreg_l11a>;
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&vreg_l22a>;
+	vqmmc-supply = <&vreg_l5a>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <30 4>;
+};
+
+&usb3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
index c5616a083f71..496f33e9d73c 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
@@ -2,300 +2,11 @@
 /*
  * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
  */
-
 /dts-v1/;
 
-#include <dt-bindings/arm/qcom,ids.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/input/gpio-keys.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include "sm6125.dtsi"
-#include "pm6125.dtsi"
-
-/delete-node/ &adsp_pil_mem;
-/delete-node/ &cont_splash_mem;
-/delete-node/ &gpu_mem;
-/delete-node/ &ipa_fw_mem;
-/delete-node/ &ipa_gsi_mem;
+#include "sm6125-xiaomi-ginkgo-common.dtsi"
 
 / {
 	model = "Xiaomi Redmi Note 8";
 	compatible = "xiaomi,ginkgo", "qcom,sm6125";
-	chassis-type = "handset";
-
-	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
-
-	chosen {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		framebuffer {
-			compatible = "simple-framebuffer";
-			memory-region = <&framebuffer_mem>;
-			width = <1080>;
-			height = <2340>;
-			stride = <(1080 * 4)>;
-			format = "a8r8g8b8";
-		};
-	};
-
-	reserved-memory {
-		adsp_pil_mem: adsp_pil_mem@55300000 {
-			reg = <0x0 0x55300000 0x0 0x2200000>;
-			no-map;
-		};
-
-		ipa_fw_mem: ipa_fw_mem@57500000 {
-			reg = <0x0 0x57500000 0x0 0x10000>;
-			no-map;
-		};
-
-		ipa_gsi_mem: ipa_gsi_mem@57510000 {
-			reg = <0x0 0x57510000 0x0 0x5000>;
-			no-map;
-		};
-
-		gpu_mem: gpu_mem@57515000 {
-			reg = <0x0 0x57515000 0x0 0x2000>;
-			no-map;
-		};
-
-		framebuffer_mem: framebuffer@5c000000 {
-			reg = <0x0 0x5c000000 0x0 (2340 * 1080 * 4)>;
-			no-map;
-		};
-
-		/* Matching with recovery values to be able to get the results. */
-		ramoops@61600000 {
-			compatible = "ramoops";
-			reg = <0x0 0x61600000 0x0 0x400000>;
-			record-size = <0x80000>;
-			pmsg-size = <0x200000>;
-			console-size = <0x100000>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-0 = <&vol_up_n>;
-		pinctrl-names = "default";
-
-		key-volume-up {
-			label = "Volume Up";
-			gpios = <&pm6125_gpios 6 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-			linux,can-disable;
-			wakeup-source;
-		};
-	};
-};
-
-&pm6125_gpios {
-	vol_up_n: vol-up-n-state {
-		pins = "gpio6";
-		function = "normal";
-		power-source = <1>;
-		bias-pull-up;
-		input-enable;
-	};
-};
-
-&hsusb_phy1 {
-	vdd-supply = <&vreg_l7a>;
-	vdda-pll-supply = <&vreg_l10a>;
-	vdda-phy-dpdm-supply = <&vreg_l15a>;
-	status = "okay";
-};
-
-&pon_pwrkey {
-	status = "okay";
-};
-
-&pon_resin {
-	linux,code = <KEY_VOLUMEDOWN>;
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators-0 {
-		compatible = "qcom,rpm-pm6125-regulators";
-
-		vreg_s6a: s6 {
-			regulator-min-microvolt = <936000>;
-			regulator-max-microvolt = <1422000>;
-		};
-
-		vreg_l1a: l1 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1256000>;
-		};
-
-		vreg_l2a: l2 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1056000>;
-		};
-
-		vreg_l3a: l3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1064000>;
-		};
-
-		vreg_l4a: l4 {
-			regulator-min-microvolt = <872000>;
-			regulator-max-microvolt = <976000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l5a: l5 {
-			regulator-min-microvolt = <1648000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l6a: l6 {
-			regulator-min-microvolt = <576000>;
-			regulator-max-microvolt = <656000>;
-		};
-
-		vreg_l7a: l7 {
-			regulator-min-microvolt = <872000>;
-			regulator-max-microvolt = <976000>;
-		};
-
-		vreg_l8a: l8 {
-			regulator-min-microvolt = <400000>;
-			regulator-max-microvolt = <728000>;
-		};
-
-		vreg_l9a: l9 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1896000>;
-		};
-
-		vreg_l10a: l10 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1896000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l11a: l11 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1952000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l12a: l12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1996000>;
-		};
-
-		vreg_l13a: l13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1832000>;
-		};
-
-		vreg_l14a: l14 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1904000>;
-		};
-
-		vreg_l15a: l15 {
-			regulator-min-microvolt = <3104000>;
-			regulator-max-microvolt = <3232000>;
-		};
-
-		vreg_l16a: l16 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1904000>;
-		};
-
-		vreg_l17a: l17 {
-			regulator-min-microvolt = <1248000>;
-			regulator-max-microvolt = <1304000>;
-		};
-
-		vreg_l18a: l18 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1264000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l19a: l19 {
-			regulator-min-microvolt = <1648000>;
-			regulator-max-microvolt = <2952000>;
-		};
-
-		vreg_l20a: l20 {
-			regulator-min-microvolt = <1648000>;
-			regulator-max-microvolt = <2952000>;
-		};
-
-		vreg_l21a: l21 {
-			regulator-min-microvolt = <2600000>;
-			regulator-max-microvolt = <2856000>;
-		};
-
-		vreg_l22a: l22 {
-			regulator-min-microvolt = <2944000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l23a: l23 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3400000>;
-		};
-
-		vreg_l24a: l24 {
-			regulator-min-microvolt = <2944000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-allow-set-load;
-		};
-
-	};
-};
-
-&sdc2_off_state {
-	sd-cd-pins {
-		pins = "gpio98";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&sdc2_on_state {
-	sd-cd-pins {
-		pins = "gpio98";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
-};
-
-&sdhc_1 {
-	vmmc-supply = <&vreg_l24a>;
-	vqmmc-supply = <&vreg_l11a>;
-	status = "okay";
-};
-
-&sdhc_2 {
-	cd-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&vreg_l22a>;
-	vqmmc-supply = <&vreg_l5a>;
-	no-sdio;
-	no-mmc;
-	status = "okay";
-};
-
-&tlmm {
-	gpio-reserved-ranges = <0 4>, <30 4>;
-};
-
-&usb3 {
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
new file mode 100644
index 000000000000..1231e440ba2c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026, Barnabas Czeman
+ */
+/dts-v1/;
+
+#include "sm6125-xiaomi-ginkgo-common.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 8T";
+	compatible = "xiaomi,willow", "qcom,sm6125";
+
+};
+
+/* Difference from Redmi Note 8 it have NFC */

-- 
2.52.0

