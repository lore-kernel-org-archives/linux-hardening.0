Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487C36A03F;
	Sun, 11 Oct 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739810; cv=none; b=WDN8qIf8D7j2z3LlLEV1VwfOuNGHB229kRkUbbcY0lhjJ2qhatEmQbX3SToBdAW54u1n0sYMzHWm/2R/kuQvhqjw5YkZbX/2p/p+7H7uz7jCaTemP2/pTmxmHakQliwyMWfM4UgVVEQuZ/r63f9PAddUYbhy5j/dXV3rQS4dwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739810; c=relaxed/simple;
	bh=fBkCJHjuCaikQxTDY/gYrM1WpcgBFmsruQ542x7hqeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=at3excVPY8rkQ9mob1hJj7wuwxlaQEH0Xz885hnpKO+vHIUR47CkuuLRsgqX+6BE+CXjRbFNzwGJ0izfebQOLKPRxHvXyy2tkHL0ykZFCuQ6FCCVWBgS+GWMBUO8IYDojXV5QsvkumlRYg459pITPgSZzcT7YXjMfZUJI0nrPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=EQGaq6Sj; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="EQGaq6Sj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1791739801; x=1791999001;
	bh=lR9lb9DSxQO3KqEfxw+Y1Y+hJ57hQIgBjo6heGSxEzU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EQGaq6Sj1nnB6TqMEDccQrEaKLRU2UBbvGGPUbpQH2y3gzng87/vqkJ1UVwcEJis9
	 5Dy7306o6+wZbQ1AP2cr6HEEHLxow13AEX0GC0a7G1HfyXocJVd97VtAMfrYS+8dyp
	 eWK4LOaIhhEbbEPFqIlOvNkw0JdyrsxK6m0rchS6MMIt/3/jQjAlDw0k7DXN4MH/QE
	 jyMy2Bq0sF3Cejv8FaSRcjhs88CRBXgzCAwsjLuW4M4LavzR2wikXPb+46uoUmgDpv
	 ridMVInXiXimKMjXMrSnMn6nyUGpy6u2kouQ0p7EeQjrww3AHZKTLhe6ABAFvDFd8L
	 i/aC1FhC++3/g==
X-Pm-Submission-Id: 4j2nfb1308z1DF4p
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sun, 11 Oct 2026 19:29:30 +0200
Subject: [PATCH v5 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345:
 introduce EC
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-dell-xps-9345-ec-v5-3-2ab1258b84c1@vinarskis.com>
References: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
In-Reply-To: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3728; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=fBkCJHjuCaikQxTDY/gYrM1WpcgBFmsruQ542x7hqeA=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFmnj/cFi167azhL8dL99TIyV+YwczjOejT//f+FwvufT
 VltIBGyuqOUhUGMi0FWTJGl+8/XtK5Fc9cyXNf4BjOHlQlkCAMXpwBMZN4hhv/V74pV+kN2TT6y
 puuM8s6lv0ym9dVe6zm55u2rSPvZnUoZDP9D7SNynvO5pB/YxuqzUP3sLHUGdbZ93vandTn0rlZ
 PC2IEAA==
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

Describe embedded controller, its interrupt and required thermal zones.
Add EC's reset GPIO to reserved range, as triggering it during device
operation leads to unrecoverable and unusable state.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 86 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index f48e6bc35006..6d99dc47eb16 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -759,8 +759,32 @@ retimer_ss0_con_sbu_out: endpoint {
 
 &i2c5 {
 	clock-frequency = <100000>;
-	status = "disabled";
-	/* EC @0x3b */
+	status = "okay";
+
+	embedded-controller@3b {
+		compatible = "dell,xps13-9345-ec";
+		reg = <0x3b>;
+
+		interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_n_default>;
+		pinctrl-names = "default";
+
+		io-channels = <&pmk8550_vadc ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX1_THM_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX2_THM_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX3_THM_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX4_THM_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX5_THM_100K_PU(1)>;
+		io-channel-names = "sys_therm0",
+				   "sys_therm1",
+				   "sys_therm2",
+				   "sys_therm3",
+				   "sys_therm4",
+				   "sys_therm5",
+				   "sys_therm6";
+	};
 };
 
 &i2c7 {
@@ -1025,6 +1049,57 @@ rtmr0_1p8_reg_en: rtmr0-1p8-reg-en-state {
 	};
 };
 
+&pmk8550_vadc {
+	sys_therm0: channel@14c {
+		reg = <ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "lpddr5_therm";
+	};
+
+	sys_therm1: channel@14d {
+		reg = <ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "usb_charger_left_therm";
+	};
+
+	sys_therm2: channel@144 {
+		reg = <ADC5_GEN3_AMUX1_THM_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "vph_pwr_therm";
+	};
+
+	sys_therm3: channel@145 {
+		reg = <ADC5_GEN3_AMUX2_THM_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "usb_charger_right_therm";
+	};
+
+	sys_therm4: channel@146 {
+		reg = <ADC5_GEN3_AMUX3_THM_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "ssd_conn_therm";
+	};
+
+	sys_therm5: channel@147 {
+		reg = <ADC5_GEN3_AMUX4_THM_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "sys_therm5";
+	};
+
+	sys_therm6: channel@148 {
+		reg = <ADC5_GEN3_AMUX5_THM_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "keyboard_therm";
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
@@ -1092,6 +1167,7 @@ &tcsr {
 
 &tlmm {
 	gpio-reserved-ranges = <44 4>,  /* SPI11 (TPM) */
+			       <65 1>,  /* EC Reset, accessible but yields system unusable */
 			       <76 4>,  /* SPI19 (TZ Protected) */
 			       <65 1>, /* EC reset */
 			       <238 1>; /* UFS Reset */
@@ -1103,6 +1179,12 @@ cam_indicator_en: cam-indicator-en-state {
 		bias-disable;
 	};
 
+	ec_int_n_default: ec-int-n-state {
+		pins = "gpio66";
+		function = "gpio";
+		bias-disable;
+	};
+
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio74";
 		function = "gpio";

-- 
2.54.0

