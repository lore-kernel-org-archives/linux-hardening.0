Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C1419312
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494137; cv=none; b=ezkuSDUWoM7mxAIjUwgETSD2y7I205xIBNfxvHi6HCIUlKEUHe/9QVhgIrpI35lGkZGzvSOwJ1lMzJ7UUD9IszjtiqemDkuMbFHw6aUe3RUZNhAQjU0ztRnClEa8cTmXbO6prFh26taWENXL56qE2AZeiRJOJZZ8Ce2FlIRhK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494137; c=relaxed/simple;
	bh=A/ZlkhpKXOXspcZO+2h9v+w/LUVpdAPN+/yLddIsV6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoEOFT2uFmPV2ktyjVTStMFH1Zb9/xB910gBaHTm+7cJxFg0bmZuO3tW9c4j08Gv30QlG7zM5zdukl/DDqn4xR9NlCskHFMQhdjNUx7KLIviONJ/fVuUTbmi56lLPRurXyETpbFeDy+pYbNAL6xFHNxcOBnoI5YePogC0+FDhSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6VOScih; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZoF6vrnG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6VOScih";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoF6vrnG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC41o3992271
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	STAmXKRhhM1PNoYloH77abYDI2FiolvS4IlxwlZE50k=; b=Y6VOScih8JgGFT3U
	l1dM7GGDI8GX8US58P0lTVwALcjVnvbLZfSh0z60UAbV8XnQ3tK2zkjE4UXWifBL
	DnAKN5XW/JL/hcQkF9iw0PYxLmOTvEImEiKTNzqZ6WYzwWnWQLXayDDxNtDxelX5
	BnbaVgCXh6cppDnM2w+bJoqp35sj2OzZ47OG9Ul4q1vdaUZTOyDn9XXaqNeqdzfG
	HHjqIOVhJX+ZNw7W0c77NmEJL8fBfIWJkN7FKnpJ6OysNLLyRgbjWWBbs7PGpyS4
	L8wVBBfXVNakyYqSkMcneQrxkQwaXRQzAWRFDeItiHMHjHluIw+/CnppFY9CKcyE
	0B2QeQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsgv847x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso541314a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494115; x=1786098915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=STAmXKRhhM1PNoYloH77abYDI2FiolvS4IlxwlZE50k=;
        b=ZoF6vrnG2N9pBTTgn5e0ojn8mFbsQgBuqHT7l2OePHdWYH+zI7BL06XrFq7ZO18q4H
         xIFVOD/IC+ixd4xw7cVDdaQDqbYksPVfzeKOb4GCUlPVtk5xKSWvMRDjZk5Fcg6L0KT/
         1yHvwLj7YAJlc0nGUDjQfILhG+BOjDTZS2vJswbyQ+MEJ4ODgva6xrIfRmTZVGF4KR4U
         mQK3xZbD+nFcGvzLsX23HVsZvpSU5kn1QUk4tBhrdDexigX/Df6nkolNjHn3g3l5bnej
         0pV1m/Tyug63/THPY507fkdvy3IymLpuF3RFJ/qXr0fAiz+uhloaMkC+pOQz3Yy6PxOJ
         VsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494115; x=1786098915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STAmXKRhhM1PNoYloH77abYDI2FiolvS4IlxwlZE50k=;
        b=D+CaEXtQKVZi2uScpg+b+H3m4ottETgCNuVD8tJkV2T4CMghfOcAzgY2WBpVHClZXH
         64UNKqs1PKfu/bmV8X5/uOIYFngWPbtYY/OVROKADU+dJa1ANmUqrjQgCmN58YQ9xDZC
         f1zw8gXJUHaxk0Rcr29wmk7RXkWM23DbRu2tsU+kuEJjBrsINodskbuUyMCu7+r5yYCG
         6IpLgToxlKmPrJoWGO2HaoLrtqH5frKrnXIzxjE+J2Tg43f61VKoo64YND9bnCAIwM/2
         m6ntctIWy6C2OfnxPss6+NdW1JnHsvFTzOKPMrhHCqpcgZngNzvBpBGPSWk6mTfuo8xT
         eD8A==
X-Forwarded-Encrypted: i=1; AHgh+RpwZ4YkhqtEl25DFb63SeGxjae3WepOcRpto4uPYWSGg0PXGwnQcKtmddbFGGW8xcJkOrY8mFcorcjQHPzYvHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJ1XIX69q0MJbeBK8eItCbeSIKjFUc2kdsuq9NXOUG/Lh61r9
	C1OzSVae970Xty3Ipcf+bKuVR9XyveMGamQep1U2if24XV3wvUjjWoKVZKR0NThVjDn/rUa6X3N
	rR+GxQvoCfz6Ypz7yImuzza2gj6BU8d1+RQs6bLlnwr3feWI+DqJXiZDjwDS3+VOwYcQz1no=
X-Gm-Gg: AR+sD12i3jhkqrM27SItVSdjh5RX4zDvG43MZbJG2qMKnvYad2RAiMTXcciY/N2T4cf
	OaOGkXYdfqO5rrLgOheiekWfY7tpVceDjsqo8jgLs7bcBaCpfB11PC07o+f8VgPVfM97WDahrTO
	3eZxGxmMfyv3tv2fspg4thY8xyd16Rz71IetU8JNaFavgoxQRHt9KkM1lI8YN2+DKv3KVlkpbYF
	JFbMzLQ0c9E+RWcsA6gVAQ0GwnI8zMBD9L4rdmELhNl7kV0PZLuVB1iZCfy+27VbPMgv41i0NIv
	sAqD0ia5B5P5g/eWzDuNzZNi/Mujnp/JLcHXla6i6qVhSNV1Uc6mI5PLg8wJx1JHiLt42+2oXlj
	CIcNliYkKZoYV/TA2kykhucNPhCK7iw==
X-Received: by 2002:a05:6a21:398b:b0:3c4:147e:98f1 with SMTP id adf61e73a8af0-3c91b1b787amr1394361637.31.1785494114862;
        Fri, 31 Jul 2026 03:35:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:398b:b0:3c4:147e:98f1 with SMTP id adf61e73a8af0-3c91b1b787amr1394328637.31.1785494114451;
        Fri, 31 Jul 2026 03:35:14 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:35:14 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:48 +0530
Subject: [PATCH v7 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-8-3befd44403d5@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
In-Reply-To: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=4988;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=A/ZlkhpKXOXspcZO+2h9v+w/LUVpdAPN+/yLddIsV6A=;
 b=+5o2HRYkHVQPeDVqOC1L2PCMgamDI+SCXDu+VNafphfciyjIg1zWSRatSJTQF/2umIlVQNWrN
 DLdpDkFNhRaDjU17czVHOh+0byHIoQhmTVgsD2P3an4UsV2YmJYadjY
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: E0GV6WE8PRwGagId7W7FRNvOtKysf5o7
X-Proofpoint-ORIG-GUID: E0GV6WE8PRwGagId7W7FRNvOtKysf5o7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX8BEXobInR1ga
 uYhhA4S8qlUIFOkXF2qSHxdd6OQnTfAcsuXNxVI7nSvS8gfeMJNLLe/R3rCZvQXbafG8er8wBre
 9DC/7hxbN1ENxY+vbLQdYGcg8KXSBtM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX33rdMxwVQU3O
 WuywWZ3xxqX/zNNsLENAh9v6kh1ms0vQK3ZAbo1LJLn5L7QEkctMEVMTk5TomJ8FoTLVjWIoDta
 WxLV7QF0aH8Wyy+I2MNoeEqS01lHQBOlLLppjo7Yp8mJ3YHN4GwwhdSJjpgR1y3O8CEzA+VpTFv
 MXmeweX0bjsBlISFx3r3myEN03kbd9X9zxdOfSu6F9cj4wpl4JZnQw05qFRMU2YlMKDSW1bG0wp
 i3xzZhRCeyr5+wEJElpDHyLoUbfnQ3W+ww+/we4mauLRIuwmEUxdYas8GjSrMb0rutyoQapL60x
 fr50+UW+a2x5guaUCLS8sQZs1kulommE7vMS3C8hT0TP7uC6wDHyT4vRVh2KU3S9tI5/uiFGAqu
 K8fIbdjOeXaX40/SA6l9Jnh76If3ehohtpIb/E7sOhtc5bE0ewWHUt2KIm+rzz9maAjJpCRnGJi
 8/HNDw8DWAdNLhqoTUw==
X-Authority-Analysis: v=2.4 cv=ApfeGu9P c=1 sm=1 tr=0 ts=6a6c7a63 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ND7YSEQ52W-Uskv0B9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310079

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in monaco.

Set up CDSP cooling by throttling the cdsp, when it reaches 115°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 64fc0d592282..3f388c000fbb 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -22,6 +22,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -7738,6 +7739,8 @@ remoteproc_cdsp: remoteproc@26300000 {
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -8170,39 +8173,87 @@ cpu-critical {
 		};
 
 		nsp-0-0-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
+				nsp_0_0_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
+				nsp_0_1_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
+				nsp_0_2_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -8290,39 +8341,87 @@ cpu-critical {
 		};
 
 		nsp-0-0-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
+				nsp_0_0_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
+				nsp_0_1_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
+				nsp_0_2_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {

-- 
2.34.1

