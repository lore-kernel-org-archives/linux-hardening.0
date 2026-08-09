Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CA313272;
	Sun,  9 Aug 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786282414; cv=none; b=k5I6qUvR6jKpR4BN73naBcr/4F13SeiWnTS+2zr9VXA+33MFh/OAXzbpx0vKMK+vYo+pVlvDgk9URwb7/nLnycDVTBQhJIC0FTJ2gzgaSvnnYGixkLqPa6LTXmdrqLvz6wKM6VKcTLjNwxZturPjHJryH2hlMYF3uyCtylqY/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786282414; c=relaxed/simple;
	bh=Y9AvX9yikqRN/qgfTL2lbNvoKd8oLsF5PnkkT/3IP00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgKqwAFLTtu0a6jInj6/ziNVUXHt98Y+iorQakscWEmYxdKluJiSm9SJNMpCHuLuaTaQLblHTTg4tjPgT608rbOfeu5lEaRZDJo+3GvrGXaC7zfMpYPODnU0JeT5XkAZEJpT+PhKZGjl3GUFiyG+J/B4HkVvady8KhA7iubXFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=upgBC4jA; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="upgBC4jA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail2; t=1786282404; x=1786541604;
	bh=BeNWGgmOxJDA7tolAvWDO2euanhk9mf3KxB+Xwn5oUs=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=upgBC4jA62gvInMnq/EoGthEqL3/TAv6bWHzLoe3IlpRkL9bGRU2WUW3MJUieh2ij
	 qhTdBLqzTZ6Uq77j4JZnDoglIlHTYgPwIDNjm9GS40S77sc+63uA4tVGJ0ZUIjWSva
	 ITgxrp6MU7pSn8vkU/Tw7evB1UOlNQTuhU64H0dMSSB/0dNaazdUDwa8zVwsIqdUoX
	 K8gwe4IpzS+ES/R7y6O+kBpFGwwXNS25qKB9YsOVRULgBX1WDb0Z5R7zWSiVlH7WRP
	 C2tYZpr7Qsq1wijseOUAwXYHGEo0/oFTjlgiWJxEgaBHoYiFm5b2BzdWesGEZO/Hpf
	 S9t9w3WlpPJXw==
X-Pm-Submission-Id: 4hHzNg4LfWz1DFFK
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sun, 09 Aug 2026 15:32:48 +0200
Subject: [PATCH v4 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345:
 introduce EC
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-dell-xps-9345-ec-v4-3-88306dbbc7aa@vinarskis.com>
References: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
In-Reply-To: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=Y9AvX9yikqRN/qgfTL2lbNvoKd8oLsF5PnkkT/3IP00=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFkVjfNKp93RXX6q0/Tndo3HMjbGSnOP2QouOvvlwG9R/
 w17KnIZO0pZGMS4GGTFFFm6/3xN61o0dy3DdY1vMHNYmUCGMHBxCsBEeOwY/vvKfI0riv82WeT0
 moMdx2cEsLy+pLpB8aHHq4dH2djztG4yMpydrnFk+hnrJdOFP1ipfyj/3/Kv+Ofia95vlK1sRI+
 xVrICAA==
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

Describe embedded controller, its interrupt and required thermal zones.
Add EC's reset GPIO to reserved range, as triggering it during device
operation leads to unrecoverable and unusable state.

Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 86 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 2be5a37c00cc..2b5b9061c56f 100644
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
@@ -1071,6 +1146,7 @@ &smb2360_1_eusb2_repeater {
 
 &tlmm {
 	gpio-reserved-ranges = <44 4>,  /* SPI11 (TPM) */
+			       <65 1>,  /* EC Reset, accessible but yields system unusable */
 			       <76 4>,  /* SPI19 (TZ Protected) */
 			       <238 1>; /* UFS Reset */
 
@@ -1081,6 +1157,12 @@ cam_indicator_en: cam-indicator-en-state {
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

