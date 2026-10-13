Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022122.outbound.protection.outlook.com [40.107.209.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46C3F9A1E;
	Tue, 13 Oct 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912450; cv=fail; b=i/ozfzRPLhklA2zWAvM8oQ5uiiFEV6jlRK5oht/8qmElFm04+VA4v2RohSWX41VwhWXMByTC5wcaBElZsNOeuRJKRhwAFrWn0Fo5F30niO+tjGj8QYzj0ZLQmJfKDAXnU4jPIvdOmQRNJJRiZEtRTTM11O+RM5kGAv+2Y3IbxWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912450; c=relaxed/simple;
	bh=EcMqjiDXuepHwevsLsIITpK8/BWJkXAUgXG84oM41+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gw6lS+Y5O20Q1BeIMSl7Z6n+TXq2Szq7obcf9y4CK9zM5WxR1rLnwyio4atX8h0QhtK394UnNqDza+n5UiSOX1p+4V3tbh1SzJ3rzK01uNJH3bRFMaUWSlMrkQ4Frrq9rhtvx73QzoUttD6O/Jnmvlxn8gjbqL/MZ0J45maPl+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=trailworks.io; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=JN2QMENM; arc=fail smtp.client-ip=40.107.209.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailworks.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="JN2QMENM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPJ10Lx12EWeeVqOK+q/YZUEF0p5qRZ2//RMzCeF+BTYGbOCyHtKZTmlc03TxZpQZZFlEL9Dwogc0GNMmAE+ln5DFTFwUvenubHUy5B6KkZqrbTF8iSXLXF2v8B88wErmDR7N1tjZzQxfxM8RFXgh0q0nTsu0d2pDFiZ8eQfT7TnvJy00UuWK3okWI7KVddEqDDhOESKso1xs39hhD+uz102YZBBZEtHQMdP0lvi5xTY0X1luCQbNM83peP5d4s1IsdHQ4UQUPH6QDMmS6iycnplIyJXH4mLrgA/zx5JDlu6Jzb7zoIbZKG1JhHJTiiUYD+dH8ArGjlUQQD4kPB7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRjERnOHKgAamE7qNfNqJoExZkebewTfQCuRF1V5B6A=;
 b=XwlqSjj/Wvdvcj3jPUBriK64yFK1g88iOAfN41vx8Aux1XskCUuNY/vJrpZDDvz+K9rCeNvpJGfqiePPIa+okYjlunaTZ2q34bhMqxXB8MNGXPtuclBFzlhe+0R78UNymexrLMyph7CV0m2QOl9GyXkosLddfBCVQpojsKWfs84AVh7a9F4uxH2JN2rrqHJwrr9GZbc5Ukl84Mryg0c9cjeubuNQBMd1q54Nl+oKnnqienS3p5zyJ3SZGzJq0qU16QUc6pzwB/g+D1ICCJE25qezAjWmo1M94oQoigc0Rei6df2uQ3MF7bYoylfmA1nMjRFr9uOA1w6qouQhteq/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRjERnOHKgAamE7qNfNqJoExZkebewTfQCuRF1V5B6A=;
 b=JN2QMENM9Ben3kWBQD7myZldnqzYo3Van+0Q6g4tp7Qu5uTGCmOXqFXrzWauiyo9x8F/31Yo1hu+fRCQQDzeroQSiR9t8V2bg4+yFeTLa/cVtHu0wxCqAvI3fnXLZC5Jq9gS5vzrT/dGwKCf27hd4zNE8fGU1PNFZrkCMkin3Ybkn7GbN5c/yvC8oHydDgEsbGiLWBUgkPVrltaeAJUGeFG6aNpCxXc7hn2Fgotb6bg7aV91IrHcr2cJlqqFOvXClQidVWpoKTwapsqb/9/APAT9BUhufh47WEqT7cHFWaUbLh0U/d0QqxiLg8i9ECKmMsG0CqENFE532MucLvmCJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from SA1PR01MB8112.prod.exchangelabs.com (2603:10b6:806:325::5) by
 FT1PR01MB450553.prod.exchangelabs.com (2603:10b6:170:b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 17:27:26 +0000
Received: from SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217]) by SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217%6]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 17:27:26 +0000
From: Michael Burch <me@michaelburch.net>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Liviu Nicoara <lnicoara@thinkoid.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Tobias Heider <tobias.heider@canonical.com>,
	Val Packett <val@packett.cool>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC
Date: Tue, 13 Oct 2026 12:27:16 -0500
Message-ID: <20261013172718.12355-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011-dell-xps-9345-ec-v6-3-2a66a364fe70@vinarskis.com>
References: <20261011-dell-xps-9345-ec-v6-0-2a66a364fe70@vinarskis.com> <20261011-dell-xps-9345-ec-v6-3-2a66a364fe70@vinarskis.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:806:d0::8) To SA1PR01MB8112.prod.exchangelabs.com
 (2603:10b6:806:325::5)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8112:EE_|FT1PR01MB450553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6574f9-535c-4254-1835-08df294f3fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|5023799004|4143699003|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wbXvN7bL7uVYS1IkZqaX0BlQKxhRVtXpduA0Vt9x2P3VcO4yjH0O1vr7zWusx6FQfJLlIK45PNcMz6gJV6ZEMYjW12x+5Jw8/t3uqM5nStGznsRatkLxirg2FzStZSLSdBIVTnkYsEAOFjya9EZOHjV9CCwCxcTmO4GktZ/wGlWasnZw49feSL5bxV5JHE0V318XA0ceigvRg7wpVrWc+n8HH7c2lL6/VykvxAWb1UhIKKiFmb1J7sruKTplGzE+jFnLnR+AsyPgVlcyGg4Pi2K5xxxcbC5oY7+Unpol3c2YAkBVTULiW9KkBmlMWHRzx4DzGr0pibxBYy06b1/Le/yTKe5YsqBJT3IYIUyA7jy6l4Q2J3CD1dL6DcAK0A3RiE3sPkpGoO75bR0XQJ/JkmQYk/TrAxdMswlDljKBMIyY9JlIjPklPw5q+C9kcdhXiKNNuhX4zYu+RAbMiVfPbEbweI0ZuLwwOOJhxviNCm7O+Erngw+48gPd6HhPUnQIe6HG7moZI2VqL8Pso+SqlP7ceDvHLqPm6DIVHzno8qCF4IKhBrkEFrWtVeQvGebezZwyxZUO4uSP5O3/cGv2lMxycuKjRqD2F1e42s1ivvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8112.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdES59VwDcsxnkkROSCfs6IwPpzhVKUEVV+EM0NNKS7KZQd5gjJsRIa9dLMk?=
 =?us-ascii?Q?Zp6z9fTBFiOT1xadBJMH4OVsu4nyxbBt1NEvR7l76kbgaWM3c5fLN2rYzxtK?=
 =?us-ascii?Q?gUaF8pymKn1u0o9L66iiSb/voQUxn3BgyfCNn0Oy66BaRsumljNCUcslHtTI?=
 =?us-ascii?Q?mkQKJN2TYe0GmsFZokq8qs8IOX+QWMup4uXkp1JZgRFeTMnvtTDLtqVjcIJH?=
 =?us-ascii?Q?CPVfzzpVfjKMLQTA65mPrQK7CXhhDHv287GjFHkT1xe97LC94FhNoVJzdWmc?=
 =?us-ascii?Q?MhwtlEpYfAfbyK+CtK5ZNm5++F8/dbGQ5OVIbtn1G+2NEDOnpOF1NTAdtTXh?=
 =?us-ascii?Q?uNNT9/7TOjvDFUgWoL2nPubQWfyQmmw4VWU/tYHsJaf/cpnXZUohGIMzw9jH?=
 =?us-ascii?Q?Ju5hh4W9RLxB/fkjHgbsWTZt5pQRIGI9rrQ8uaJeoK/wNetuOhRzg/Ev9yZU?=
 =?us-ascii?Q?5W30HpUL4pNJIQs6yyQqSK25KhRYTBAw+f/SNDW7m9XT4QaKX5Fb5vQQ34sH?=
 =?us-ascii?Q?1rsF+YtBz1YImaJXNO2AcGFdD+XXr0sc9bM6juRnMrTK/l+Hwk+6erhk4dJ6?=
 =?us-ascii?Q?S4mBgZgrbfmJ7pGIItvJ1B1lKPUv8CirmqqXEA8wHu4hBVzobWkA0GecTGq5?=
 =?us-ascii?Q?K79x6dyvCTJXyKaVagOnkjyIdWve9Ia9HTLCXcHNlfbFX+T2UMxrTPtAYte9?=
 =?us-ascii?Q?NcF2hTHRj6sYBNRlYPrG+PV4JaoeSzKr8MIWMBcJt/qA1UT0RaaPYZK7DL1e?=
 =?us-ascii?Q?LfKAG3mXnHYCzMKxJNmKp4msNYWqWMui0ow/FtVyYhCjbiRWOLB0OAboYosw?=
 =?us-ascii?Q?Ch1UybAZUDki8liwkwdnD7xlVOvaVJLQ9fi5IoU+avYtZxLNFQjcXP4zeMf7?=
 =?us-ascii?Q?ug5ig4Iiziqfcq+62CsC5fcGWFGXdIyX/mhMCsScZN2h6NF9hvCkzuuSz6My?=
 =?us-ascii?Q?uIO6XV/vZgeVc11rU13/Prjgb2Q0E9zc/G4sfUM+uF4mo1lzVoPEXSjNUj9j?=
 =?us-ascii?Q?Y82hSCYgrZ/yC27fVaIVZ9oq3b9h3j+YvCwbxfsweowM7ObHBA4P04M7irVQ?=
 =?us-ascii?Q?M1Igx6TZQee9L507sxlcXbtPNCDiuHDAz/+qLLpjSbCSyFYSbOJtcZErEDle?=
 =?us-ascii?Q?Y89OT2gokfAkYmjQR3+EDy69AiZlNxGC2qnXssjc6vKdyO2h2L7VbOf4hz1P?=
 =?us-ascii?Q?cnOQAJ84mq0F+E/d40/l1NSzFD53cQOf5irbNMZxlVBkHE0LuVJb3xUvYKfv?=
 =?us-ascii?Q?CxD5chjYa3g2n36NN9eOgj1ggOQBNtw/LRgD620Fb/Cc7LxiH0i+0b2HKY9n?=
 =?us-ascii?Q?MPdQG/Z9l/NY3eyTY6oeXT3Wm2jVUsamXtcBWOqC3AeHuF+ekotl2Ftm4GW4?=
 =?us-ascii?Q?kCZZTzjQ1ACfQY1eyRilps8Ywc0LPS9uaI6HVdQ9rimHCpmqNubcWR0E6Wq5?=
 =?us-ascii?Q?XIvTGSS3pRzAPO0vZ8uSxRPpM9OrryoPIpnqMsgQyqUeTmHz2lMX1HvVcXvf?=
 =?us-ascii?Q?g1lkR38EZXlphw9M2alboFOIpWAg+PEy8pmzVAyCT+jKhrLW2zx6csFe0cqi?=
 =?us-ascii?Q?sz/oEeKypTRa7qkCW58/4JNzjyRfe54ueWF96I7jG8peqkjsqpye0GCW1IKp?=
 =?us-ascii?Q?5Pl50a4szhgPo2E4IRdg42gv+nS++xw/raEscdb+JbCYvgUwFIeHui43Y7sT?=
 =?us-ascii?Q?T5XRcceqcvB2G/fFoCQ4eMtO2FF7mlg1qYaSouUrQvAiKbegrqE7RGl1yFLd?=
 =?us-ascii?Q?N2rJ7/jGfQ=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6574f9-535c-4254-1835-08df294f3fff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8112.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:27:26.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81EVqV+W+rG5TGoTOHZxtO1V2l11APe7z7UE6jr7gvIasNSbBXLJDhW7/AZ3KvoV84vJkdlG6YUTLTkFAcSLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR01MB450553

On Sun, Oct 11, 2026 at 07:50:10PM +0200, Aleksandrs Vinarskis wrote:
> +		io-channels = <&pmk8550_vadc ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>,
> +			      <&pmk8550_vadc ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>,

These two should be AMUX1_GPIO and AMUX2_GPIO. My unit (BIOS 2.14.0)
shows what Liviu reported [1]: 0x14c (lpddr5_therm) reads 130.048 C from
boot on, and that is the value the EC is sent.

The Windows ADC configuration answers Liviu's question, wrong channel or
missing pin configuration. In ADC1 from your qcom-aeob-dumps
(dell-xps-9345/ADC1.json), the channel table puts the seven board
thermistors on SID 1, all with the 100k pull-up:

  SYS_THERM1  0x4a  AMUX1_GPIO
  SYS_THERM2  0x4b  AMUX2_GPIO
  SYS_THERM3  0x44  AMUX1_THM
  SYS_THERM4  0x45  AMUX2_THM
  SYS_THERM5  0x46  AMUX3_THM
  SYS_THERM6  0x47  AMUX4_THM
  SYS_THERM7  0x48  AMUX5_THM

Its GPIO table sets up only two pins as ADC inputs: PM8550 GPIO3 on
channels 0x0a/0x4a and GPIO4 on 0x0b/0x4b. hamoa-pmics.dtsi already
puts those two pins in high impedance for the VADC and defines
channel@14a and channel@14b. Nothing in ADC1 uses AMUX3 or AMUX4 GPIO.

sys_therm2 to sys_therm6 here are SYS_THERM3 to SYS_THERM7, so
sys_thermN is SYS_THERM(N+1), and sys_therm0/1 are 0x14a/0x14b. The
labels fit too: Liviu found the left charger thermistor on AMUX2 GPIO
[2], and sys_therm1 is usb_charger_left_therm.

Readings on a 7.3-rc6 based kernel, idle:

  0x14a  40.6 C       0x14c  130.0 C (constant)
  0x14b  34.6 C       0x14d   37.0 C
  AMUX1-5 THM  34.6 to 40.5 C

> +	sys_therm0: channel@14c {
> +		reg = <ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>;
[...]
> +	sys_therm1: channel@14d {
> +		reg = <ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>;

With the change below on a v7.3-rc7 based kernel, sys_therm0 and
sys_therm1 read 45.4 C and 41.0 C, next to 38.2 to 46.8 C on the THM
channels:

--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -1133,8 +1133,8 @@ embedded-controller@3b {
 		pinctrl-0 = <&ec_int_n_default>;
 		pinctrl-names = "default";
 
-		io-channels = <&pmk8550_vadc ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>,
-			      <&pmk8550_vadc ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>,
+		io-channels = <&pmk8550_vadc ADC5_GEN3_AMUX1_GPIO_100K_PU(1)>,
+			      <&pmk8550_vadc ADC5_GEN3_AMUX2_GPIO_100K_PU(1)>,
 			      <&pmk8550_vadc ADC5_GEN3_AMUX1_THM_100K_PU(1)>,
 			      <&pmk8550_vadc ADC5_GEN3_AMUX2_THM_100K_PU(1)>,
 			      <&pmk8550_vadc ADC5_GEN3_AMUX3_THM_100K_PU(1)>,
@@ -1439,15 +1439,15 @@ rtmr0_1p8_reg_en: rtmr0-1p8-reg-en-state {
 };
 
 &pmk8550_vadc {
-	sys_therm0: channel@14c {
-		reg = <ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>;
+	sys_therm0: channel@14a {
+		reg = <ADC5_GEN3_AMUX1_GPIO_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "lpddr5_therm";
 	};
 
-	sys_therm1: channel@14d {
-		reg = <ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>;
+	sys_therm1: channel@14b {
+		reg = <ADC5_GEN3_AMUX2_GPIO_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "usb_charger_left_therm";

[1] https://lore.kernel.org/r/20261011213528.13207-1-lnicoara@thinkoid.org
[2] https://lore.kernel.org/r/20261006185557.23016-1-lnicoara@thinkoid.org

Michael
