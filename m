Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4DCA52
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162246; cv=none; b=WKtlIIOm9/L5X7RnhjAKrDyVMbKk2Ao8YxejCFHuFgBumugIGoPtO1zByTEfTvelcD5lRKH1/oj8gQAI4DqedlTXAysxoaRyeUc1UxQpJUl789wSx03zDjRY7rYc2PYi5kHh8/IiCKa7squd1jP7/yeHDfe5FLHqzx7W8PAZh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162246; c=relaxed/simple;
	bh=8vbyF0r7KBo2gx9OMsxuen36V3/WCj3YTuhFogK4cCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Brg4+A48sKQeZO8Axas4dA82/Rv1CdRFdV7YQazzyZB8WKcRzuvMlZ58z1cu3dKgzoCHQuArskrnAfWyPBo8mQTf2zM/JI9K6Uowhij54DEPAS/pg00mAItMIBfoF0Bjy03DCQTEVWdgURMos4N4xFT/VyKes7pP+zGPaKVPtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SPdASP6N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BZUvsaDl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPdASP6N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZUvsaDl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlmXc4035382
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUQPvYlGLcyWJN5orn7GeiG6xhnxWGyq1pRn2g22RaU=; b=SPdASP6NT6Si8Pt3
	g3I2VydKqD665QRpzKe0sn+Cl1BoDBaJU4I2oi8hRk4T8ypeRlv9qXdoaC5KnOBH
	TB1tZc76VxyfDiDGHRhLwWFfOZ96UpGj4w/zEEgaTjNhCpBlSL48sXSdQ0SNJ8wv
	8+yl6Qyf/Vtuz2ex5Nb8NUE1FmZEf/QHmGjh9ekPQx0Ru6cotaGK5h00SwXKH/wr
	mCKEqmBU+Gohil4aoqzfBG6FGIipgCV3sc82zF4jI+wR8MXypQggR6HSf1d0IzAf
	bAx9f38x/eMPZs0zVGZfzr3eKF/sjG6W00wC8EOPGcHK5CkHgGkmKahFN/jVift7
	a4hUXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g1n3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:24:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso76828765ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162242; x=1785767042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUQPvYlGLcyWJN5orn7GeiG6xhnxWGyq1pRn2g22RaU=;
        b=BZUvsaDlq3KjmSWxQVboM6V7scBtfo6c+FZdZuU0okwgG0zCW3xYDiyKdAwCrMSio5
         xhxxyjb7VGuYYhY0qKvO6mNz8/s0glHPRi1tO9PLBKhNiBCX7isDIDcykeXZKKT/Fa/k
         fDvcErAEGAPKn1E1LPNR+ul3dmWhbODdReGFIbTlzE88MdP+fortop2pabKRff73+eSQ
         TEuHEhEGsBVsoRZA1JW6NizT0SUe+KGgoXEbsZn+HWgXsmuFrxXJ8g5zktjdPFr5Kjqz
         L+XSik3N7Tg/b2sWiQe5QFYf4nKYSAl4InaQ+Rlh+x6MOMB3nDx5KVTxZ4i1kz2Xx0rM
         /3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162242; x=1785767042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUQPvYlGLcyWJN5orn7GeiG6xhnxWGyq1pRn2g22RaU=;
        b=IefpK71ox01r7wFYjGWaAEsu8NETjz1c5Tm0rZ9rj3YPLegNoC34HsRJuGzkPUAcs+
         LrXMp9xSLsicdSOpZKN5HgRDHrhP05cCSLz6LAZH+GeyjhKWH4EGFMICNzipCH19U1OM
         ekf4t20g24PIVOgSz33zHErayAMiqYt+1JzTzsZoUGd3+7Q8qU8d5wx/pGNtf2TSHQxe
         S63Zun0Mwm2mUiEUEvyUtPLXi4iXQlsC8ZPjSiDsFe3YzHlEK6frV0bkUblrfYUeoay7
         NvQGHuTgQySBKWR+UGSb2isk3FPiUhJyydsxKIXa+sUasSQ98gX8SB2C60GjEupkiX/Q
         V2Bg==
X-Forwarded-Encrypted: i=1; AHgh+RoPQDJbNyFUWi28fSdr5pHhuRlGfZ9W49L4IaJYr2uXhBrVIDJguK1AcdV/rAc4eLWG1u095V5Lq2XOk+u9MW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1szwmY1n36KtfiaJ+02qLim8CHGFduPm7PucDpkvC4S2MCESd
	TjRUgQfh1+BaL19utOKWqyJPw8rIHg8aYdtGMW/PEJ0JjBhFFc1UEIm+PGa27aE6/VIyaU75qtT
	UDkw/hezqsQifcbFuc0Eeyfn/Lbgv54da7Gl9QeaPIrt0TwW5RGqu1FSa8X1F4bBOGXwES8E=
X-Gm-Gg: AR+sD10Y2FEX6UVJOxfvoS/yPFoVr125DP4WtmGLu91ZUz1z2fqD5JFoCwIdk+f4zxl
	Sy3kb9tphuUOacAdX23DyWk76x9wgLD0XP9X6Lr3zX5Ag8GLA3UDld6ug8gaHyMiOxUH9hN5GDR
	Jeqovg6opj/efVORPaRNa4U5xYyazg7BauvE8winhSuHRMumJ2RZ0TYQhXVsPMCdLHyTZDs0Ieb
	5tDhZ0rFx+UKhy3L+yKASmx3g8zGL4NbzZS4Vl9nA6ixBlL8KoZjs6fFV4mrEqz66Ume8HSy8xY
	utLb9a9DyVfw023TTAPCKwqZqU75tcdx+V57IxjYInBn+C1EIMxfb+ZNCCnJLJdU2foQlFETMI7
	20gFY1c2dJVYkdykNItRhX0RwAu0tww==
X-Received: by 2002:a17:903:1acb:b0:2cc:77f3:a934 with SMTP id d9443c01a7336-2cfde89bea6mr74094365ad.46.1785162241732;
        Mon, 27 Jul 2026 07:24:01 -0700 (PDT)
X-Received: by 2002:a17:903:1acb:b0:2cc:77f3:a934 with SMTP id d9443c01a7336-2cfde89bea6mr74093995ad.46.1785162241287;
        Mon, 27 Jul 2026 07:24:01 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:24:00 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:25 +0530
Subject: [PATCH v6 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-b4-qmi-tmd-v6-8-973cd3a226af@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=4945;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8vbyF0r7KBo2gx9OMsxuen36V3/WCj3YTuhFogK4cCc=;
 b=FmZwKD8hmFpFZrioiPTaCE8/fxmpG19yUvJEvODGmNb0YYNoT2s6sqcAM+dxpYZIUZWLaUbb8
 XO6gxdw2gRJBi3XLlbJyD5s/VsleNrq4wwt9ANKeVjI1FDvu5vDkETS
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a676a02 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ND7YSEQ52W-Uskv0B9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX86/hDiYQX/7s
 1rm2hjuso1etFinYbz01K2yKxlCiCLL7JEpsDt1W7ui2qSjnFTYOurgWGsVx1v8Ou51h3NgUJ07
 4+CKjEsB5s06CyUqIy65sWZ2vjqxliU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX5zReErIoaNvb
 WSTLvR0PerLiV87mIETj6NnIZIsx5WdnOTG1BR2cDP6perPiaFlKnXOAhaedNatNi2T8z7GQ1Vt
 9crRzgL0BfxX57DM0NKTt/6bitZYBlXZcF0hX4T6Z+Ggn4xb/uJlt5PgdSayg8gFw2AtGD0WiRT
 /LQ0wYaXowmxn6QgjA0KH40Fow8QMmFc/LPI+Jt8PE4jY9ymxXofJU7tL71E/myNVVaTkDUaHfh
 nfNN2pMTwa4ACvpZviXBLungepuRXvadHdqPX3Uzd/feUZ1t32vUtYLQbdDcFl8wCp5wyXQqP5I
 AaeYCABW9oy1YH9Ew0FwCUjjl5V6VFMaVsZuyVUJmiO6fbZwtkTtnlUUxDCLwN38HarOVzvN8Yh
 zJ6U6p/w25aK5WvWGt0FHrCJemOg3LY9p1aq7EhoHwd21KRM9fWpc2iaszQiK1djnEQbGez6VCS
 eAUvbFKGbLWNELCWdaA==
X-Proofpoint-GUID: -6Ls5xGOPk2DhP1mpenRN5W_bRzqV9Iw
X-Proofpoint-ORIG-GUID: -6Ls5xGOPk2DhP1mpenRN5W_bRzqV9Iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in monaco.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 115°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

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

