Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4837BE8E
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162196; cv=none; b=N/Ih3Z2Vfz3vnZ69LPr9cUiodQtAXX5XSoqr1jIK71HGSV6kkj7YO4NP4f8OgCsnjaQWWl5JrjBByOTqCrVsBlJ4kZ5ZPJVp3dNLUeAc+DCk1cwnyMUtyX9SQbkc00kySTxpIF3+SDoLMHuGEmDVidlELqRAI6TN3MV8Yh6np9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162196; c=relaxed/simple;
	bh=PXSF6vkFlEhCfK0LyvLgZoPU7bFhvKJwsRbKyMRblis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjkX/11QUubxe89pZ9fbKIYkXEr9hm5pjfPTb5iO6pLqhVmXj5kSbMjDVpUuvjvopFLu3tl6M3XdPZDfuh+gILdpqWKMaCeW0kBdjzF2HbPEoWXUtQXc2zVR1p0FPHlqPrB0LbSraJvjpGTKs31yAyHRsR7nJM3KgwGKxWPNW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+knv/TR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsCBktfH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+knv/TR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsCBktfH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlfFw033181
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=; b=E+knv/TRE2HCqRtl
	dh81QxPKVOv09Guu68Pk/OHUTHjndfmC5DeemV7nAnNlKXeoFSA2GSNzWKWTtAEM
	MFSUbYr9el5st3V8gHO3EI9JOKugL3J5g53fR6FCi4VI5dNz6s0Bo/BnWuSwnZY6
	+nA+9L18pITQ7jjyUp/nKtpIUqxuNuIQO8bOmmcDFDogxPOreu1srQlJND1lw/au
	n6kpu+FYoD+sS9iaQQRb9P1DfgVv5wcigo0iCjctZA3LON4J2tLEtrfkYHmmgudu
	OC8g6oSeS6j9WQ9QKZTswt8W2EeIQ2ECWxCsKG5zq/d5bRoKkrqHh0BgBpyQDJl3
	/qCfbw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c6174p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce14a21faso39702105ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162193; x=1785766993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=;
        b=BsCBktfH92qWvgRcmtRI4UBaRiiJ3voygZHoZIc3nOm1nUla++j2y7xI7QZXaF16Eq
         OQx/bW+atWP96kbbPnyDTX1K/lZsjpul8tHWNHt4tNv2i3GWek9L6oeZmmE4slpWhStI
         P5xaIkQpYu/9HHq3kOPW0Kh3JHSmnIyKtnuii3afIMkliv7KejsXQeTB1NpUA8WExxmL
         aEOLZ1IqA5cY0zvQh0j7JJZstXmDJcRFL6i7XtF1OOnsrmY21eehcnoTACMByQfZg4v8
         8F/ldwRvVQ/vR92m9h6Ow8NkmkAo4pgVYcSHLx4a2SL6HILSs+0gkjJJ3u1L+YFntpLU
         JoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162193; x=1785766993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=;
        b=Wh6aGRoVpTqYQfV5LGS9KNTtFVAQJodDUtnQXfwagQ/Oh6t9al3XQzkyAd8dMj/ZaJ
         1P+MqeAeq9AdDSM8bhSJRjxsDJTLjkhFX4aQE+sxNJThxeTRXLbHc2nbJ0sn/0q1S6CR
         lyiXoxPwo084sTEm3nrJKJ5NYeSPCgtvfmwsBm6f5/PGxPYkR1wUbSxnsYqpLDkTV3KR
         jY9OixWR2HlmR5avNdXWz3qy6M+5tcUQ1FUxNIhjrjgP3yTXhT99AtkMw5IFIKvEbkGM
         gQOj2i0DWQYDKUT4kSFQxFt/zA5sf8OtfY4nK+mBVIwR/AGqfnCoALcmoTdOZi4vdcgD
         O4uA==
X-Forwarded-Encrypted: i=1; AHgh+RooatAjvmRn2SyigcoGydfJUjeGHuPAxPTlbp9490ZpYsf65BFEbVlkj71+1dNR38mfFdcl3FJCoFPdBiD14WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2Y3x5W5IDbJtLXbFIm2HYX4E3wCD/PxEHusL4bYTfO4aIF4e
	3+oTPL2O2PBQenYs7xTglbE9Nzws5SmdkXbrIHJamXHerkdlIUCNV3sTT5WMedfeYKiiZ9Z0Yd1
	fhyMjUH6msKLRKjMKQKlfuthd64VzqxJcUrNcd1D/Q1kKYIjIwHUuJ/4Aib5hJPQWWBSl8uQ=
X-Gm-Gg: AR+sD12z3xkuZqfGoZ2E9rp+qrXxZebrLluUgRkIA/AviDfXlNIkRf9X9d8O8LhgKuw
	cJeyT7JEwHWszYapdrL/ADv4lVrjYY86BQpukpZ0bNJi4sTzt32S/UX3uaPvyV5dze2k+EM2q72
	PxnorIfwmFwU42NIGmj7vT5bqT4jCuO8pGkuMRvXFwWK1hL4Po5F/TZ6Oke77aCvnVxejVNLepd
	tTdlGa+g7fcyZ6oz7AMQA/OcSYJtn/dyV0R1IHD2rIklx836E90Mr5ZuC4cPcZyLvmTX+0cdJql
	c1rQabHtrQHgDYz9SzvSXquCeu5Vv7kT5lUNpjHQAqzfq8zUHCvm6ZqX30/aDRUOnugLm5QpE4g
	gXniMSzEF3m9aE7fgRtxY+K9+F7NqEQ==
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr76064335ad.22.1785162192744;
        Mon, 27 Jul 2026 07:23:12 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr76063745ad.22.1785162192180;
        Mon, 27 Jul 2026 07:23:12 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:11 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:18 +0530
Subject: [PATCH v6 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-qmi-tmd-v6-1-973cd3a226af@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=3278;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=PXSF6vkFlEhCfK0LyvLgZoPU7bFhvKJwsRbKyMRblis=;
 b=SEtokr6pFfBIcdHQa10reU2F19U7op13kUhoziapXmY3pFG5ZHMmqU/Rucu/LAaiLYvG07Zm2
 n4rzrXBnk2bD57BQPnG/4T8kIFSfhLRq15hapH9WH4b8ysle83UI5ff
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a6769d1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=T6nhelsJTOTiISQcNXMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfXxyRSJShVMZcU
 NHztG7AZJyzDsJPBASKjskFdV9WnrLrOQGpLw8zdE9mXDso8mR+TBS2B19YoYpL3TqsyNccK1xO
 FPVx+nQb3Iz1eB/1YUOVyDatR/SgU8A=
X-Proofpoint-ORIG-GUID: wjP1H3B2vWCepckkUHOaCfhkydbw4cgG
X-Proofpoint-GUID: wjP1H3B2vWCepckkUHOaCfhkydbw4cgG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX5T0Nm3ifyQlm
 gZQcwg9aex+P7148WMKydnvvPE+5OiLbRXdsU0Pwgo9RjYLgQUxpbtEJfgfjX5xWywwl7MIpzmL
 JtuB4v9BO3UZOjWhpoBfHJi5NUnu6+d3X4huywMoOB3Vk0KIDxVjY6hZZz2SyDft4MQI2Hl31YB
 5++vzwWXhapbPTINXvbPJq1yzXTEZu9v2eF8B+HSLdxiKjEhoEv97yRByTcc+Cea29HcREPZx9f
 I3eLedq319wRhNlEhUOHBy+IfgZSiXi6bNt828ZMithQC+UModqamnBWcNIIHftBGqOkL91rr9W
 cxEfZMKzZdlE4r4P3ALGtayAvOOLdZpeOcvr4uh8o9XKCfTORHEVVwaah2Uzxt55a5w/cLPGlLi
 I2mFRJSTq5Uk1f8Lup9DnBWPAH62BT7i6JJsTQ2vA9XZGry6e0xQyS0lwDUMG7W44b2Mu/Gb1Ku
 RlZMtrkEFrP/KYY8NQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Document the optional #cooling-cells property for Qualcomm PAS
remoteproc nodes so they can be used as thermal cooling devices via
the QMI Thermal Mitigation Device (TMD) interface.

Qualcomm remote processors expose TMD endpoints that support thermal
throttling through firmware. The cooling-device specifier uses 3 cells:

  <&phandle device_id min_state max_state>

where device_id selects the TMD endpoint (for example PA, modem, or
CDSP software mitigation), with constants defined in:
include/dt-bindings/thermal/qcom,pas.h

Example usage in a thermal zone:

  cooling-maps {
      map0 {
          trip = <&cpu_alert>;
          cooling-device = <&remoteproc_cdsp
                           QCOM_TMD_CDSP_SW
                           0 THERMAL_NO_LIMIT>;
      };
  };

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
 MAINTAINERS                                          |  1 +
 include/dt-bindings/thermal/qcom,pas.h               | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 11faf655f530..f75cab6b4ed9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -77,6 +77,15 @@ properties:
       channels and devices related to the ADSP.
     unevaluatedProperties: false
 
+  '#cooling-cells':
+    description: |
+      Cooling device with three cells:
+        Cell 0: Cooling device id as defined in
+                include/dt-bindings/thermal/qcom,pas.h
+        Cell 1: Minimum cooling state
+        Cell 2: Maximum cooling state
+    const: 3
+
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
diff --git a/MAINTAINERS b/MAINTAINERS
index dcffe9fc54f6..3f1e2bbf7099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
+F:	include/dt-bindings/thermal/qcom,pas.h
 F:	include/linux/firmware/qcom
 F:	include/linux/soc/qcom/
 F:	include/soc/qcom/
diff --git a/include/dt-bindings/thermal/qcom,pas.h b/include/dt-bindings/thermal/qcom,pas.h
new file mode 100644
index 000000000000..f603bddef9a8
--- /dev/null
+++ b/include/dt-bindings/thermal/qcom,pas.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm PAS remoteproc cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by PAS-managed remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_THERMAL_QCOM_PAS_H
+#define _DT_BINDINGS_THERMAL_QCOM_PAS_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_TMD_PA	0
+#define QCOM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_THERMAL_QCOM_PAS_H */

-- 
2.34.1

