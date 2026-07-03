Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42F3546CC
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055042; cv=none; b=WkA011B/YALCyt/htjxQdU9pXIFnggSCHZJYmg0pNybFhi0zFsX7aXygctbgHXlBcxMrmO2Blc2/0065/Tc5hwa5gMIKuhUYF+8rdddG/P3BNDPWTpnTuSrL56lJ2AQeak/3Z0rhkd9nLWDIqkOXy2YL1mcRHK6b3SkaAJj9+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055042; c=relaxed/simple;
	bh=Z/WKNegsFatsDkLsxVMEZ3HsqNDu3wLrVIGJkYC/vDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYNx8V9mNXipua8q/oM2zeUzCG8m6Q2witaXEUjBtesg2I3C0cVbgmX759kqwl5Oolqht1OaeDW07bhT0mOxY8+qAcmreKOoBQPsnfkgN3Rh13WrwD9if76T8AldzhsJU+VC4lQdFib8GAO6KhpqAMyneKwbwlUQ7mSWm4h6uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tfu0MG8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LsROdTFK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tfu0MG8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LsROdTFK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342uKm2816801
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 05:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=; b=Tfu0MG8ETJE7D4iT
	uEJssPb+iZky/iJo7Quo0oveYgdgvaMU08mTQfgH8FmVX0OdTrKudsKIPK3OXMMr
	xHXP4kFO5O92LGX7YEQJAaLCVFGdpej2o7MWjmpvQXcxLTudZGh7omqo6HZb0RkQ
	ZpTscgnmX0NxD0Gi7lTYgJ5SdR1pbTNLBgwLqoyXvXE2ZiofeX1P8gONhrMVGH/O
	L3Qvv0rE6ERxjHF7V4OwZjDJ+4kfO0xdyhDHq4wrSDt1MhpFg7Q522RV+R9uq7Tc
	6ruzztQn0zOz/30W/fAjAxnqci4zuJ6D2orYD+Z0suEMNxUtfZC72J75Qf/e1xbk
	u3gt9w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpbjmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 05:03:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88da04b719so164014a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 22:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055029; x=1783659829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=;
        b=LsROdTFKp2alb6Zt5orjcg4a2SbRtYbHKKTQ2yc+f1ZzIkdaJ3ogfDrFfeeZLpZIRq
         m4kN2CJJC06elcwbg+BRj3rcNvA6BPMW/Kj+dxFzgLGIwdz8VsZA2wwwTdIMSJ3WZF8I
         w7+QtZkMgNzW4I52YCYdPr7ekonxL/MPiNW7mL+i/Rd8gCqDL7YC7etGk5Vm545L2Z+l
         kUItNuSju+snavAe4mOmH9oqSn90ue0ahOzDOl61aRLcsglfwjuWX5m1O0U6wAJZjxuG
         aOsMqduQ1wtwMO9lWZIc4P06j1lxrU7EO0qKlM4/ctusUXqE2dlXZQVe3DcqCefzVw3w
         A/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055029; x=1783659829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=;
        b=nlcoPgtIkNJGrKTvium16WViNUA4OtlUDzU7WRbbUIOf17MBR16x9EkVw+Ub6j39FL
         RK+PCSxbLJSBXJ7wd+fx9KH3u+0uZM9bTbOR/Uo7HUyndIZSdGK9PcQUl3u25Q0rEfd9
         DzwP/CXy+Y68nAlTvXSkTkE4eZCGtFBdo+obTPLMgvYvTTy7hrvmwKa1IC+4YrfAaRZf
         WeX9gNeIJQb9KscjSJ9ZMcDNyXnm1IQ9qXWcOGH1w6KAHD99cCBLE+TPgubBxRjiuPWx
         WKxkDLWAby5TXTZRxUvdcgVlLkB+Tc40LIlok47RfFGjsgKC7mEnfpM5o7nToPJrmp5a
         2rqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+x6d5SIcxh/3SlgJg00X9I4tk5FaMRAYTlrs/d2u2BSLenCSuy0cdJ23bnH3qrcEkYbxC8XmzL6IxcNjw4OBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjPpNBZhY8WwCULi6RkqaJfkDdpLPdzz7ShNIEPQqhHqPHx+c
	3orSif8WaQEzpf5AZa0Y56qqGatpmzv5fd3I0LBwTL5BoDHFt76wWCqGRPd85A411q6iZ3HUFww
	KjteoXh+XBj0oDXy875OuGafxxR/MvTk/nlH91FZMgM1Z060lWRJQOM7Q0NiMl2wN7E3VAmc=
X-Gm-Gg: AfdE7cnCaoX371v+b3rM0N7u1R/SLZ+G+vynmcgWpA5x9lUBgpv8fWnqVK9RveKGEOP
	k8c2ks7I/DmH1PxB/xrv/UMQeCmROjNgSPWjpQUSGtCyLK5WrMdIGuSz23u9yIWnMbXJS81Dcct
	yb3XcOfV2FZLx741yE20KJBFkszLS6vpflZrOJrmprr+RQ3Jh4LIAljhh8HZff/FDHCSm7yHqFQ
	0aiWNUc5ATidIpCrjm21BQldhGk/ar9ZepUeE7g35W0UU7il8mFQvJ4JPagNuz0tdoOxNds0B5R
	wjFIO6au/q39OVecJj4legA1VrMmauGckqHFPbWD2yQ4+xg9fHRfPZ2I182GVEGZjsHenxPeC4+
	gsTFhOgB2qRaokWMMOM7PSjGi8XsQf7H1DXP6MeKQ
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id adf61e73a8af0-3bff422d1d6mr9767408637.36.1783055029089;
        Thu, 02 Jul 2026 22:03:49 -0700 (PDT)
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id adf61e73a8af0-3bff422d1d6mr9767367637.36.1783055028571;
        Thu, 02 Jul 2026 22:03:48 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:48 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:04 +0530
Subject: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=2444;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=Z/WKNegsFatsDkLsxVMEZ3HsqNDu3wLrVIGJkYC/vDQ=;
 b=4rAKxVmboxTEsxT7HFUBnFpo6MQMdbnmWvyZUSL6xjXKCseXH82IXoJP7DNAKZwcClya1CWVA
 a/S+elRIqK6B9a3GaJd8IrCbMsNhTm75h0rXG2Xf0nt9X2cyTRbxdFd
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX+OqfW+3oHrIy
 yYfhNVocg/K6oTOCVGGeGyuZp7gFoL0lMFYXs8QI7kRzGfkP6Lfpjez7A5+nQ1XT5cndA9lpzK0
 B+OszMu6hDwsSJIYCRytbhdf3FZ7RzI=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a4742b6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aPnvGIK-T0NEGnooipsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX9FFG9yETX0J2
 A4uGYo/Ry+9yu2iSEGTYsGGtvN8OaicJFZ8eEL25uk+O89zIvFNTOeEE2TtgRFnvbrRqzI5S789
 PPTyAIFMW/IfPfdjZrjTXLsS4n3mKz8O7H5QX5E3/Gs4j39mNdDWVEta/j7Y5AZDsMMqXOMh+8r
 uSxmYnW//LA9JiDb9sIgVCjjbCVQYiVW+1jxj/2az2orc8kB+lEoMMn+giCnxEyh6xrusrrbdpa
 fK1bJyHngeim9tFDCpjUieDhJYEIZEBwz10IkiW392JoNk3pbUjSfwN0H50h+9lYrogFNf7JDeb
 HX7w8ue9s1sOikrJN+hAPf4hQFQnnNFQ9oX/FinwJuxgHqKqNaFLexbHF82kq1f+EyGkrdp7Xpv
 HQMEuki5owbPL8nomEVKsti8eGyYHo55dY6AkLncQMNjE2Es01VsV0ChGonQCs52KcN41iQEwyW
 IXZ+LtOV7xZ89T+fwWA==
X-Proofpoint-ORIG-GUID: vxtPpJCcIvK4LOrj_myuRtPPK7jt4M4o
X-Proofpoint-GUID: vxtPpJCcIvK4LOrj_myuRtPPK7jt4M4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030045

Add Device Tree binding constants for Qualcomm Thermal Mitigation
Device (TMD) types used by remoteproc-backed thermal cooling devices.

Qualcomm remote processors expose thermal mitigation endpoints
through QMI. These endpoints can be registered with the thermal
framework via the `#cooling-cells` property on the remoteproc node.

The QMI TMD protocol identifies devices using string names (for example,
"pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
`#cooling-cells = <3>` requires numeric device id in the form:

  <&phandle device_id min_state max_state>

Define common TMD device index constants shared across currently
supported platforms. If a future target requires a different mapping,
additional target-specific constants can be introduced while preserving
existing DT ABI.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 MAINTAINERS                                 |  1 +
 include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57656ec0e9d5..ffd85fd1dd80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
 F:	drivers/soc/qcom/
 F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
+F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
 F:	include/linux/firmware/qcom
diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
new file mode 100644
index 000000000000..73efecef0f3c
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_CDSP_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_MODEM_TMD_PA	0
+#define QCOM_MODEM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H */

-- 
2.34.1

