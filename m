Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1298C4708E
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Dec 2022 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiL3OBo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Dec 2022 09:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiL3OBl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Dec 2022 09:01:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035615F27
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 06:01:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z26so31842986lfu.8
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDX/Y8c0nYn0wPwCiLoDu3AuVl7/wGYtB70TOA8uYSI=;
        b=WKyAo2sTx6s3jeRU61OK37hTOlCSJFPb3k7waUEB/6aa42OSrbWY6oJwfgWFgWMHv6
         qZCeF+IDTYbWT6S+bmyRWJy1XPIcKPvRE+H/vBQLcH6TyA2EuOsnZxPupgjGpbMmgwxi
         dbigbBiI2zfwMRIwz5D4pEMmDmQYzdfDGdVUWS19g6XIOT3LpoNm6DNSvg5M/LLOkutJ
         SDdQOMQmELlZTvNrBsywrt4MtPxBfCKiLaFYMqlIdczXpbKbiEGsSM2v/GwuXZoWC7KE
         AAWb2u45Knw7OwpaSHtP+oF77+ZGvBuuX1I/xM/r+/gZW7P3b6xl/OHa0Aqcrs7GwaMR
         +wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDX/Y8c0nYn0wPwCiLoDu3AuVl7/wGYtB70TOA8uYSI=;
        b=VyKA0jMEWHD2s37kASt4XzCHGklrORNwFh93iNlks5h7dRa6Cj3P4SGBvbjxX1cdzW
         kMCekPQl8MtvgUW1ie7NjzepV9tHGzI2Q83DaVvYjN1F5XjkLMJFLhDoyP+g3S8cVR49
         e2Jsn/IaILGELJvXtnK9ffYuf1oPCMUH0UbrfVddm+RB/oshtcunrSPGF7FwCs3s27mZ
         ddNcWFwAG55iR23RV+PdmB2wj/gTnp6KhuKtH3yA5RbHNZ1ehC4GheiMx44gpkQQ0yD0
         7aYRTLgQuPg0i3jSwNSukMeLlTGVmur2pOb4z9NA9/T1zLrDrStSYd4PC5A0o0G4P/L2
         Qykw==
X-Gm-Message-State: AFqh2kqG1TOX33GHLw3MFSzIHocI8QVyMAcscwzEyQX0F8V/Ttq8N62m
        C+OwCXoRtk4lnqzIT6fQVPY4fg==
X-Google-Smtp-Source: AMrXdXvscO8sKyrSdweuk17zlaWjMe2Igs5n6WM0jGB92uquoB9pHC8M2r+YrRdnU17P/O2kLhKVcw==
X-Received: by 2002:a05:6512:21c6:b0:4b5:83b8:2c49 with SMTP id d6-20020a05651221c600b004b583b82c49mr8489563lft.1.1672408898451;
        Fri, 30 Dec 2022 06:01:38 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b004b57db96aabsm3482667lfo.52.2022.12.30.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 06:01:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: add missing space before {
Date:   Fri, 30 Dec 2022 15:01:33 +0100
Message-Id: <20221230140133.57885-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230140133.57885-1-krzysztof.kozlowski@linaro.org>
References: <20221230140133.57885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add missingh whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Correct typo in commit msg (Konrad)
2. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi                        | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi        | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi                         | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d2b3fdf2df13..cbdf7c1f31b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3292,7 +3292,7 @@ blsp2_i2c6: i2c@75ba000 {
 			status = "disabled";
 		};
 
-		blsp2_spi6: spi@75ba000{
+		blsp2_spi6: spi@75ba000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x075ba000 0x600>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index c20e48da44f8..031320baec3d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3419,7 +3419,7 @@ watchdog@17c10000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		timer@17c20000{
+		timer@17c20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0 0 0x20000000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index 7fc0b6bfc0d6..552646c073e2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -70,7 +70,7 @@ &pcie1_phy {
 	status = "okay";
 };
 
-&pm8350c_pwm_backlight{
+&pm8350c_pwm_backlight {
 	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
 	pwms = <&pm8350c_pwm 3 200000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 0201c6776746..1a5a5764e6a1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -743,7 +743,7 @@ left_spkr: wsa8830-left@0,1 {
 		vdd-supply = <&vreg_s10b>;
 	};
 
-	right_spkr: wsa8830-right@0,2{
+	right_spkr: wsa8830-right@0,2 {
 		compatible = "sdw10217020200";
 		reg = <0 2>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index c3453f291286..64de4ed9b0c8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -541,7 +541,7 @@ &venus {
 	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 501232bdf9cf..d9581f4440b3 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -745,7 +745,7 @@ &venus {
 	status = "okay";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 9215066146ff..6730804f4e3e 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -654,7 +654,7 @@ &venus {
 	firmware-name = "qcom/sdm850/samsung/w737/qcvss850.mbn";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 90dec84055c3..5886710b3c65 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4124,7 +4124,7 @@ timer@17c20000 {
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
-			frame@17c21000{
+			frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index ab5a2851a314..6c7adce6c9b8 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2397,7 +2397,7 @@ aoncc: clock-controller@3380000 {
 			clock-names = "core", "audio", "bus";
 		};
 
-		lpass_tlmm: pinctrl@33c0000{
+		lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sm8250-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0x0 0x20000>,
 			      <0 0x03550000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1d5b52b13cc2..a7da48b7e788 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1598,7 +1598,7 @@ lpass_ag_noc: interconnect@3c40000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
-		compute_noc: interconnect@a0c0000{
+		compute_noc: interconnect@a0c0000 {
 			compatible = "qcom,sm8350-compute-noc";
 			reg = <0 0x0a0c0000 0 0xa180>;
 			#interconnect-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 73df5494d49c..33db6b6c4123 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3519,7 +3519,7 @@ qup_uart20_default: qup-uart20-default-state {
 
 		};
 
-		lpass_tlmm: pinctrl@3440000{
+		lpass_tlmm: pinctrl@3440000 {
 			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
 			reg = <0 0x3440000 0x0 0x20000>,
 			      <0 0x34d0000 0x0 0x10000>;
-- 
2.34.1

