Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07863F54B6
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000640; cv=none; b=J7BokZjNLoJ6X5qErtc2eeFKFZgBQ1u74yz7eLSUQfBUhmJIPLsoAcO30JVYXcNeMEsVaw9FbMw37Q+VxoeiESof24noDL1GAWpp+DzbLP56yRFvn4QogkgSxCVR1VUiGS9ArdZgdJq0XsqeCxaBFtxmrBFaiIKlzTQHldh/KNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000640; c=relaxed/simple;
	bh=pC1mGgaIlteKYS/xrkrD3YHJcHRMN75E2Vyo+SLpff0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDNqcm4BPa1GbuRD6+81z94Nm7Z3juhON59SwaXoUTR6RfOIW42N+QSLz9cPoY7Bj3/LjMLSvQq9E4w9ngO9DEOnj1ZU79lE0QKwgXVkieEfw89V6cy/fPqjZ3pAvVDnjB/SwAZmh1ZJKHT0MmJSxhJnUXwDPwUicVWwYXI/VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKoBHoI0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrG9Tgtv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKoBHoI0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrG9Tgtv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vK5u1869336
	for <linux-hardening@vger.kernel.org>; Tue, 9 Jun 2026 10:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZKgYDYPBlOhtmPoSiz45+kStOgmnZmmTba53sxzPQDQ=; b=CKoBHoI0Zr33eVJV
	VIAvU74DBbEfiBwqZqLPgitceVeJjPfLOk7ehdlakS/pVSDdN1C17B7BhFF2DMrZ
	/F//argb2Ug9PAP+3ZX+hTNxsHIrW5E8gIswxuQIk9/w4K6/4fRR+NBAtR3FrnkP
	GRACSakB1LpYn5y5tSr8LXvuXP4ud7aT0UbYzPqZJpXMw+7+jO+mfHYp9hNa552d
	zdHA5lObDl6DNpM451rlAvwOALvSpnOBuiGg5R6NRRAn280FTwVpJoJyf6aYvs9m
	t5pHpToTV89ahMxHbb2rBpAZXt2MoZ4Sj2vxZXT0BwlwcQsPvN9PZ8sezGmkPFVV
	pyNVzQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqggn4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 10:23:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c32faa62so98861605ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781000638; x=1781605438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKgYDYPBlOhtmPoSiz45+kStOgmnZmmTba53sxzPQDQ=;
        b=GrG9Tgtv5hMvs56A0Jdo27zV88Cx17LNzG5DapGKb4DPi0jVVmixK+5E7uBWkVBkkc
         CpeZtYyNvKm7rczNIaurhN96tzoTRt7JK8wmCumX8n9I6kOeh0wDTbO90OA01dUS9hpU
         vHNH89sUzeuIysoXuJCZFAHGVDGLsl9gLGntkjIm6ZEQuIJfiyVCKY8ZsJNT6jCc5Qgh
         Ho35ZGOjbVwEQZu3qDvvUp2ajTXc8/cKxvzWCDoXOFOrYxkUUIp32gFsMLR/6LJRQcwX
         M6x97jemPg1l4/Swz79Jbb3IsCmZbAaI6GsT9llMjoUZjtZIS0oz9FtByd5E5MptcjQn
         zf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000638; x=1781605438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKgYDYPBlOhtmPoSiz45+kStOgmnZmmTba53sxzPQDQ=;
        b=eGCcYuQfa3Ht2yCvObdw2W/uz7jJo9BWU3CPAX4Icl85gZwbX22JEoSw83XGw9cjkW
         WtTTjJ0DBpMF+he3Ud/UeBVZwTZSMw3TcnApliKsYVpwdy3ffY+loK+C/lh94apkQQbP
         1R7HY/9taaG2/QaOial+43e3d45tWPKGpt4PehbFXGK4n8JikVw4HSIaV01zYMtCMLQ+
         Mj1mBFqWWbgsoY7c3wPtQkinfnbeJL6EIATvOXITpgTWxgfJHBanScF5YfsR2a+gjzQR
         IgkF1uVn/Y+zKl1HvsaNqsHhtommvJCf9BNYX9xE/52hSFqdCcDKqDJQncWhtWbaPCwc
         S0kw==
X-Forwarded-Encrypted: i=1; AFNElJ9BAcNOJBpZMivnQRafLc5KJ70I4RIHBAnEGU8uMlyU0dRisYoOHk4M7M/+b7TJIyvhbnLUvWaYgIwvNCJWoYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx015zaZJqnd3kxoCfJ+B1oQkdusyfa/opnJlxniBr44yiFe8mo
	iiFd106PFzGxpeO4FZiEuJTXEXKD68ddLWLOVYC5qYSry/onX+G2oqALxVhbyqcKK6iK643w9Jj
	JIiLkoz5WtaRyixTYOFFzGWWA4L0eZWk00mkSjYH6vM1RCqJmTG6aFZFLGZ+R/Gg9bQcUGRY=
X-Gm-Gg: Acq92OErzc1XdlSVAJhNDMV7KMGe5rHRO8IhDNq/1zaBEt/CCpGBampCiBxwMg+zOsi
	0jhQkRMc5WU2sUyNxeJbWFvQ+EesE6bP6p87eyKiWQCxSK36Ryj9z57HlN4fajp4y6QLyfWJQ/U
	Za5L5WuekYAkdWo10A8GnmaMb0gJDioEQjg04TvKxMOBHvNPTmGa4wQTpumnKnqWMAP7ALfZyGo
	+3qUIwpGduOEFfu4vtZeuKlRLR+cW20MFq13pTVUkAdfwHe8uWmU8BGSQGAKLxQvnGDJLsWkxR7
	lTif0O8tIzo/GEL22n9cIi8XEP5FmLqWs9wu2JMrbRwLBpXbi8Z5h93HOzFM5Vt7q8naB7KzyaG
	3e5ulrw7ucAnKu/Vb/JujaPPcmr9X48ckhL+7tw8W20M9owt+HaTDz0Dtx5eYew==
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id d9443c01a7336-2c1e85e04bbmr218292495ad.37.1781000638373;
        Tue, 09 Jun 2026 03:23:58 -0700 (PDT)
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id d9443c01a7336-2c1e85e04bbmr218292105ad.37.1781000637883;
        Tue, 09 Jun 2026 03:23:57 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2a4a64e22sm14738915ad.61.2026.06.09.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:23:57 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 15:53:02 +0530
Subject: [PATCH v3 7/8] arm64: dts: qcom: monaco: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-qmi-tmd-v3-7-291a2ff4c634@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
In-Reply-To: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781000588; l=4369;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=pC1mGgaIlteKYS/xrkrD3YHJcHRMN75E2Vyo+SLpff0=;
 b=FteM7M7xdWvEjlgMVDKv2WluSpXor3Gl6BiLBfPtzDudw48Uh4d0TulEbw9tnYSANrmiWqbbT
 OcXipIfH6GHDahy1oGfSWDMSLQVEE4RMfjz4W4zuyGpg7YgYd3uTcnf
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NyBTYWx0ZWRfX+pdFzx67vkWu
 nslzxRtVx06boGb702tWiR24R1LO8D5SI444sybOljMfkXl4/vIaHhuHOk/DhY61DjyvUKBEjCv
 NtMoyz3T+w9LhQt9fzJFSSnhD75ja6Jr4REsYWUAOX4+0twbUKd/rDgwjw3/hIoeoLobgXbcou+
 uR1r3EkTReSR9Fs6QhLpNA2AYe1z5qAGzf+gFshv1HZPSlqeyk6/rsGOF6ge1iyvqdmmA0819Az
 NJHf5OuDvPacjqC6IxSl/aBuMthqkHP5oEtL8mRWCAXlC5RnUs7yeDW0EJ42COubmrahj8El8fK
 GiEVBKMJfrsDXgc6VYBrukwQlZ2iVMLEM62PQsRqPvrWm+yTOzyRm9hknuzB4nvYE9BuvUC69+r
 bGiB/u03vzYwHkjeG2gKwU/k9FsPBx/DAba1e4pb91gU2zy4dutRfasaA6e/1FGAMtYTsAN2hvw
 3cXcmT7HMSObIsBlVMw==
X-Proofpoint-ORIG-GUID: LXMJeAUoKXGY06e26ONvjG_YFz-2Ydi9
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27e9bf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=WTijfvStGCArOK70lPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: LXMJeAUoKXGY06e26ONvjG_YFz-2Ydi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090097

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in monaco.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index e4c8466f941b..1756e8423a25 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -7728,6 +7728,9 @@ remoteproc_cdsp: remoteproc@26300000 {
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <2>;
+			tmd-names = "cdsp_sw";
+
 			status = "disabled";
 
 			glink-edge {
@@ -8160,39 +8163,87 @@ cpu-critical {
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
+					cooling-device = <&remoteproc_cdsp
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
+					cooling-device = <&remoteproc_cdsp
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
+					cooling-device = <&remoteproc_cdsp
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -8280,39 +8331,87 @@ cpu-critical {
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
+					cooling-device = <&remoteproc_cdsp
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
+					cooling-device = <&remoteproc_cdsp
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
+					cooling-device = <&remoteproc_cdsp
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {

-- 
2.34.1

