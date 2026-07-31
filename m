Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A2428461
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494130; cv=none; b=sEgZxAOwN58iJ2jLH6ne+dMPpo7TjlDZNWYDdyW3ICyZ9Jmf35uTe9AwD56JwOnlsd2jd3NqR74sMKCe0DK6/PihKuT1B6TOqhei5hc/QVM47yRmfMotJWWLW+YBdnn9sglwvV39sSDC61/Gw1jSe+UhSvVYxRSibO2wbbSyrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494130; c=relaxed/simple;
	bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsA40PsGhqV+7g1bm0Cj3hXfXV4/afxmkjckUt5Bbnjck1vvHFHEmC093GbsGiTz9rKjdXdlEac8mZN/Fa/+QZx+sZxd6vyImchkbY/8Uboq0TtgPeeXjGLXsdR4x8AwhvEcSjGFd7isoyHOxCnKdB9fmDo9hYgfPJxPRh+RWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCf5tq4Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJtrGoRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCf5tq4Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJtrGoRQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VACVdo3992780
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=; b=UCf5tq4YVIpM/623
	6V0sPxSZuiceUJhyQTbrMmSWE0V6VC03wx1cCSMjw1l2YYy+9z2H4nfGXTMSuDnB
	O2H2RGVZ3VT7StgSyMbSJqaUxmGxTxAFAZLy2dx05JbqAiO1bS9/JuPA9UrwjnFR
	v50CH6/wQKHcIz/ccPqw2cPrO3khhTzopI5LDabMDpH9c24LxSYMx8l2an477odj
	tdF97BqzgDdo9OFQP6UfJw63qxXYysoEz4JAF6FT3e2C6pkDpfCtqYb4IXIeuwW6
	lfJB8fvzLuQIfnN3VErK1hIIp9jNoYh9khFKmZkrB2ZOAcKFV43wOERcIhZcc3sS
	idPNuQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsgv847g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:35:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc88e22f92so16834055ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494107; x=1786098907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=RJtrGoRQJLGoEmgPvck02QZk6QPdeVzNYWFUEyN/XpZx2axULtVOlo+m2/8/lcdUg7
         LAO7cYWaMN6q+NDV2+sfm/Sl6gif7WOhQi7NYlHdKIaCzNclEYSt9rdDERq4VHHCDfJZ
         LgIpk3mi6d/AYFzARC8alCBPjovRbFofYeWi0w8xaNa8CtS1V1Ob5ARZHyoApBWFgcpQ
         97wdzxibhJ/j61VJTYVbjktFXNNRB1FAMmpAX2/g6HcXzws8Jm8KBILWiC+h66FReVE0
         SKAXW6z3rOW7RYulME+ERkz7HZv2vqmKsu8uu4iJs9gm1pjkQ1VS9YOqrkZarZqojq9l
         Pnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494107; x=1786098907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=Q3pjs0jtpGjI9jAHXOIL4RsrIgeg932MXPXBZz2l1GhJJV80ukKiZi79B4ojG43qOp
         7Hs6xUBK6CadQiMTl5xS7d3oIu6SOoR6RFnFmb0bjOoI4qpYn2PSgN/OAUxAKNlbiRj0
         c/3VwE0ez2xUNhKPbW7hB7fEmtWU5rSUgAST60js5O/24O2YhcJtgzSt4+jAltGxd1+L
         tU2I8Dn9kPJKdqMwBUQRUjVKAvMyGQxRMYAId9Y2xSniJ36ZSZJ1GzuwAYmsewZsZjeQ
         VkYYYU+4Th4LV0N3PnjiA2GDpPBexRVcop98aUBmmIQL1Tnyw8nI2iCbs1mr3++BQ45Q
         khkw==
X-Forwarded-Encrypted: i=1; AHgh+RpVMh1RSVIlBTUnl1YW47gExb8RAmBD5zDCfg0jigFwnZzOne1n6wRx1LuZk1/aPwUpSWMiSlrRmoR1OxvqY9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q51/7r2FYkko/I1U4VkwLgu1nYisr/OAZKpFDd27vqY9irK+
	ZKyZ6eXTR8O8Em589QTtpLBXSrJxooH4bMdOo9A97JcE70pCAUuNA76l9fWMz9rVnJmHT+8CZ4i
	j/CNjjIeWHYzUpOZRimStdTFWFfuAejKzHsbw7r2iQBYx8JMY4pzC2j7EmYwx2tgVjVmxZG4=
X-Gm-Gg: AR+sD13dEk99uQ77TGaJptRrW9EbyRg4I7iFu/7M6DSlaNSF3HqN4c2/J/JTtqNXZmQ
	VPSv1QKPgs+CfJ6FSvCfYl+vnN1TlU5AvDXjIHiSF90DSOqE5cTI22PG+7XUiioj3x/yMjaVQq4
	kQKOukj4eCdvnq0MZQyc1Whu4Hnv/vVOi5oA2hhjEoI9uzPgas5Fi5V2i9uYQxd/y+QEYeXqKkP
	Rh3dpEJJTQUMMV/pF4Sq64ytrHIvdwAgPTcSaom0J2+v+L0s+Jfy3Hxou/wNvHxT6RqvjZl0ct6
	kinDZ0z1WT5iGqWHFGptIbbyO7JJtsVdmTuvDAjUzC55z3+v7SzUv+SFm5brym4Wd5Rw5MjtSX4
	LPTbz7zX0NuZ4S+ztKkaZPvZy8dmqJg==
X-Received: by 2002:a17:903:4683:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d046d70b30mr15627905ad.3.1785494107450;
        Fri, 31 Jul 2026 03:35:07 -0700 (PDT)
X-Received: by 2002:a17:903:4683:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d046d70b30mr15627615ad.3.1785494107074;
        Fri, 31 Jul 2026 03:35:07 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:35:06 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:47 +0530
Subject: [PATCH v7 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-7-3befd44403d5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=1994;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
 b=95ug3fuOSgVxrn5ZroqFPVPz8oce5m8u2Db2rhrpdC/rTCUQuE+HE6RrAO/i6tSsH9u36kgiE
 UCzR3CMjg3+BJ6ptUwwbgY02X9A9rc4A4eRU3uk0DIlOd0DDFi1cdTL
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: RRKYsnQriuRCFI9oSQx1L6BaSziirdIh
X-Proofpoint-ORIG-GUID: RRKYsnQriuRCFI9oSQx1L6BaSziirdIh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX1CAkZRaoRJBO
 286342Ar5tVOkGPhsnl5x82SFI7S56YMZERaCDEbrEktkMSFAEWsOzEgdfQGRjCuH9aOfV+uyfD
 lDEhE5Hf2kEp3b3Vav1k6aACTccko/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX1mUh2To1ewxc
 SHeK2/Bnzmzs7qtQuZjX3PKU9EjRQs8sMoJkUIo63apX7I+XgVz3QoiZyP60xQ4d0uSyVg927C+
 qScL+liqbaM8VD8lfPkmyk7gQdRT45Q7tf9IhY+MBMbx8x5xMY6mMrZAtiVZt12aJzHH5UPo05V
 mJMgpWZ2pU0V0l4fJdmIiBnwGBIdJjDy50KSpGrM9YOLcdeC7JRfUxac3gEBkWBxH8RrVrPOrHo
 C15y56q4Ly1PE+bFCKvX0TGSeal+G0kAycKpSBuwrbLQgCH1wRIum09jAgRutWuWLKQUdB1KcEp
 4ub0A817nSIbDHW+lZuuKcd5mJR6Uj9O5x8G8YuysTNRdJ53pBNv0i1J0SoRWazVAaVQz7RsKPP
 XuzOoq2AmOdvn4iJLp6K+w0BhjJ8NSxfgrmaQ5y+yVqRVvDxlZmOgwDOF+joX+170poj+Dng2N8
 yfJt6x0ClvGpUb6gA3A==
X-Authority-Analysis: v=2.4 cv=ApfeGu9P c=1 sm=1 tr=0 ts=6a6c7a5c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ptpooaJMTZRctn2qr1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
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
when it reaches high temperatures in talos.

Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index bdfb70ca9740..0fb7cb8e9f64 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3840,6 +3841,8 @@ remoteproc_cdsp: remoteproc@8300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -5497,15 +5500,31 @@ map0 {
 		};
 
 		q6-hvx-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				q6-hvx-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&q6_hvx_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdm-core-thermal {

-- 
2.34.1

