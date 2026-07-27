Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B93815DF
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162210; cv=none; b=fZfU2ljvDbAsY37ezR87MlZimLzKLpRqpHTvVxn3c2npKplrHoZpygSrD7xt0+wU/9w9hBjpnAFAAb7yFilYllN8qvAZ2gwA+vRKwxGNKNLCpjsV1KRc1RORzeDxH9VhR8A6YYl9eDYRY1mc9yPDpNSqJXnKiM+LGQEBCSb98N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162210; c=relaxed/simple;
	bh=b2APw6QMKkRhQDm4skrvz2fmpdUst56rE5+WErZDaLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9jAfZ5RCEWDTnmKI5x0f22uYY78nWRhZ9aKr/R7pjVimRP/hImE4ux38Z9E3ZSaAp+DWqRlCGNKp9l5u/twB2ChpApIg0GRzjneqyx/mTCbZ3IUYAYXq0cKqwkOUF2Ul2DYX9/8CbWvDtin8Hz0sg+da0JcZFR5WSiZx5oRM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pj/mf+fL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PPjIdS0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pj/mf+fL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPjIdS0u"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlSVV4065465
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOSx4enz7zetc1w/+P4mM5Jxf3PccCyPcjq9sbRYwh8=; b=pj/mf+fLOFcpaLyd
	b9SuBKUY1Z41D0OY6Gsa0e5X37K9p+g7YN8uaZzeca/mbxvoANI78Dvmi7kCYDgE
	VyvfhLNMYJCkyzBDXxrFCB4aZpD0PGglg9XNDloBbKtKCanrLLLEo3GaXIjFyBmS
	s4vstwkT/RiQ5Fwl9Sf8EA/GiqyysWRzyx8IUy8w30of/hh/7zAiO/EG+ZSkweFX
	8WlqslgKoHuKplKX9q7KbHUMpeZtaAXI+too32a6XrpD/PB5IeMrF+oH0PQDLxMx
	LVG/E3lP9Q0ccf3wth5iZrn8eeas2xtWqvkunUR8VSQNWIhmYNbml/bTGunkTBpV
	qm5qjg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngysuv1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca3673560so3415525ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162207; x=1785767007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WOSx4enz7zetc1w/+P4mM5Jxf3PccCyPcjq9sbRYwh8=;
        b=PPjIdS0uD6ZJktCJJcQ9gM56L3X7SSSoWehO+J0ye0/nqjKpwOWy2brSyRpxMHftxx
         e/d/gPFWUYLKYw/zvQATERGBo/3lYuICcnbPAyGY4ZTrFvbXa1oSWbnlukWJBiYw/qPK
         5SeZ29aptdxe1cmt9CAVoqKpw4Fy/ecQ2ZpSV6qFWKzwUVQf1k8fUbUdzG4MY7sI9wu5
         MfvMabw3+2SdW87SasUuT8T36kGUziQXaBCuuxbHKezCbV+yy+ft+wwL4th0wVMWOLHW
         whCP377Y/qTh//jmS+KxUYVGvaBPt7RD8Cqy52hVdXMUhzY493m3gSQvfgeUeFtBe8gq
         0SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162207; x=1785767007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOSx4enz7zetc1w/+P4mM5Jxf3PccCyPcjq9sbRYwh8=;
        b=YOdi03efJxH+LEq2RihYFohBjPOw+NBgkbqxBrYBb/lycfZHMVlBKEaLQ9zdUJSjXU
         LI4DPGjegzYH1M0tV5Cda+YkCa94Z7ZF969/pAx9AO3rn052IbyT46rLsgs7k74KTxJ1
         jJWcsAW5WKOYlI/+wsN/srXiiSnlxjJcEnkjIx5X9QQktuQtkTGJrm41tysXyofHmV2H
         FNO/ri949+mkxNIWCwtiDZDx2oB6fx06vdRQWTf9phm88zrpUv1b4hW0WiPnMlfTCQaC
         ECPjVy0myCuu7bJN0bDYnZcgtloHU3q9IyzF1H6CEKqV0iBZ10jTvVrVw0rw1A7gpS4C
         TuWw==
X-Forwarded-Encrypted: i=1; AHgh+RonFlTAaTYysehiu+o2/yL8woXrKu2PU4Lp3P1Be5UCNWAtesrFJbOvcfv4v0wbk5YNJpPDfgZrkQR5y0B/Bp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUw9icTAEFCj0jsTOIKpsS08PY0vJghB5arTC2JPa46GJ6a2Ui
	zz7UjygiQ4WMNvpzxZakDEZWt+zgQHnsKy/fMSEY1RAZt5TJgREcO2fDWtM0AMlrMiFGcGQbTHG
	xwyBBRnaAesLHCwYPeBnqof0Vw7elsKbwlI+5i7PcJP/La8gJraUZTIoAkUFNXGLtJBPdjbg=
X-Gm-Gg: AR+sD130FB2WTr8d3e64EC7u9xrOBvzyyZ6KypMUXiGVbUuKqwW6/0eXCKIJakuQvjv
	8ymin1qc8luxSh1gUQkHTnLB49vZmzr0wjxGkVQi/HdB1HW6Ecc/UpBeG5BvRhNKr4lBqLukvPM
	+F8jTF31s4rkTlxYPk94aNhtDjfrLj8Km/I0E9lWoBuvjsdRwhZHkkobgrTV1cR5dEo5uUCoIQj
	TwK6aTsy3sbcZCpbRExYrKnbu2PenXx2of1pAoBWGRFo/9UleLYzv6Tx+KMmdCtFGJhWM/+2okX
	4nEWcB0kW/QQSwm7kIqZ0UdPuMyBk45Zb3DLYvUO0lV3YgXOMUgt4sw8pBv8e/tPB7V8iLAIQ/y
	nOSekOqNECTvZCUlQaXoUWAC1BIsc7Q==
X-Received: by 2002:a17:903:948:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cfde79fc06mr80176845ad.17.1785162206521;
        Mon, 27 Jul 2026 07:23:26 -0700 (PDT)
X-Received: by 2002:a17:903:948:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cfde79fc06mr80176425ad.17.1785162206107;
        Mon, 27 Jul 2026 07:23:26 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:25 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:20 +0530
Subject: [PATCH v6 3/9] remoteproc: qcom: pas: add support for TMD thermal
 cooling devices
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-qmi-tmd-v6-3-973cd3a226af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=5129;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=b2APw6QMKkRhQDm4skrvz2fmpdUst56rE5+WErZDaLo=;
 b=0pwnrB6QIaiUmPu8luDEOMkcVQ2xIJ3uOwBAIw+D5+F3nWzeuCbhfM/xSe9x28CkVtONk9sfR
 KGMVUBUFlb1DG9qIxQx+kAAlh4xGjoF4NmsE8uqcCOEIQYxsQwpD+ym
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfXyphQjoaABGCx
 YdqrdYFBcgfv7RFmaJ7JRBT88Heu5Laty+6fUex6KWon6S4n5MQDhKSG4GqH13uSWf/PPb71Iy2
 mLQJVAUIV6lWNEruiec++kdyaT+gHdOvBKoaKRElw6IeVgBMKHKaJL3JWAs1b9DN3ALCyqflM12
 PybsNbyxzZ6Ukb5xJI1dRkZeUxdcAc9KTis3Jam4qJzTx6L9KG5wmLNSOiuw3P7ig46BnYbe719
 gFQthVs0+UQzgvZCzSHDF35Zhx25gLT49PxINADriZ3QE1aDnuID+9GRhMRSl/ujFmQ0CIlpiQw
 bykfaJjCicaY9SBwguLcRSMRgiTBdDxjDHa7ZioeWBIgs4pEMEG6N5Aplntjr9fFzRESSedGHNf
 kqb4///QtpA44KNO6ojJJxMhMpRCXnJySU54uZrYMWYfBm5+gagQ77UkyH/cul2zSCKtN36l28E
 DxBSigbZzChkywkcP1w==
X-Proofpoint-GUID: hCmuWs5WMuEBLZ1UkG1rqenut7ugE8d1
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a6769df cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JsyU97BMdJ6RvXteW0AA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX0au1ICp+r/Oc
 p6ce9vJOqCLwbTEhHQjd0jkpFVG7S71hTYLTfEftejwluW8j2WBWACd1w+pbH3je7p/49ivdPpc
 l2BAx5QDL2yMGMPmP/8veomQMhZ1dro=
X-Proofpoint-ORIG-GUID: hCmuWs5WMuEBLZ1UkG1rqenut7ugE8d1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
processors to enable thermal throttling through QMI.

This allows the thermal framework to request mitigation when remote
subsystems such as modem and CDSP contribute to thermal pressure.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c | 90 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 65befdbfa5f7..152d7a53aa09 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -229,6 +229,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
+	select QCOM_QMI_TMD if NET
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	select QCOM_PAS
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 25599d728208..07336a2d75f7 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Linaro Ltd
  * Copyright (C) 2014 Sony Mobile Communications AB
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/clk.h>
@@ -26,8 +27,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/qmi_tmd.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
@@ -38,6 +41,16 @@
 
 #define MAX_ASSIGN_COUNT 3
 
+/**
+ * struct tmd_name - TMD device name to cooling-device index mapping
+ * @name: TMD device name
+ * @id: Cooling-device index used as #cooling-cells cell 0 in DT
+ */
+struct tmd_name {
+	const char *name;
+	int id;
+};
+
 struct qcom_pas_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -58,6 +71,10 @@ struct qcom_pas_data {
 	int ssctl_id;
 	unsigned int smem_host_id;
 
+	unsigned int tmd_instance_id;
+	const struct tmd_name *tmd_name;
+	int num_tmd;
+
 	int region_assign_idx;
 	int region_assign_count;
 	bool region_assign_shared;
@@ -122,6 +139,8 @@ struct qcom_pas {
 
 	struct qcom_pas_context *pas_ctx;
 	struct qcom_pas_context *dtb_pas_ctx;
+
+	struct qmi_tmd_client *tmd_inst;
 };
 
 static void qcom_pas_segment_dump(struct rproc *rproc,
@@ -798,6 +817,64 @@ static void qcom_pas_unassign_memory_region(struct qcom_pas *pas)
 	}
 }
 
+static int qcom_pas_setup_tmd(struct qcom_pas *pas, const struct qcom_pas_data *desc)
+{
+	struct qmi_tmd_client *tmd_inst;
+	const struct tmd_name *tmd;
+	const char **tmd_names;
+	int i, ret;
+
+	if (!device_property_present(pas->dev, "#cooling-cells"))
+		return 0;
+
+	if (!desc->tmd_name || desc->num_tmd == 0)
+		return 0;
+
+	tmd_names = devm_kcalloc(pas->dev, desc->num_tmd,
+				 sizeof(*tmd_names), GFP_KERNEL);
+	if (!tmd_names)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_tmd; i++) {
+		tmd = &desc->tmd_name[i];
+
+		if (tmd->id >= desc->num_tmd) {
+			dev_err(pas->dev, "Invalid TMD id %d for '%s'\n",
+				tmd->id, tmd->name);
+			return -EINVAL;
+		}
+
+		if (tmd_names[tmd->id]) {
+			dev_err(pas->dev, "Duplicate TMD id %d for '%s'\n",
+				tmd->id, tmd->name);
+			return -EINVAL;
+		}
+
+		tmd_names[tmd->id] = tmd->name;
+	}
+
+	for (i = 0; i < desc->num_tmd; i++) {
+		if (!tmd_names[i]) {
+			dev_err(pas->dev, "Missing TMD mapping for id %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names,
+				desc->num_tmd);
+	if (IS_ERR(tmd_inst)) {
+		ret = PTR_ERR(tmd_inst);
+		if (ret == -ENODEV)
+			return 0;
+
+		return ret;
+	}
+
+	pas->tmd_inst = tmd_inst;
+
+	return 0;
+}
+
 static int qcom_pas_probe(struct platform_device *pdev)
 {
 	const struct qcom_pas_data *desc;
@@ -925,16 +1002,24 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	if (desc->early_boot)
 		pas->rproc->state = RPROC_DETACHED;
 
-	ret = rproc_add(rproc);
+	ret = qcom_pas_setup_tmd(pas, desc);
 	if (ret)
 		goto remove_ssr_sysmon;
 
+	ret = rproc_add(rproc);
+	if (ret)
+		goto remove_setup_tmd;
+
 	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
 	pas->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
 	of_node_put(node);
 
 	return 0;
 
+remove_setup_tmd:
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 remove_ssr_sysmon:
 	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
 	qcom_remove_sysmon_subdev(pas->sysmon);
@@ -960,6 +1045,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	if (pas->bam_dmux)
 		of_platform_device_destroy(&pas->bam_dmux->dev, NULL);
 
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 	rproc_del(pas->rproc);
 
 	qcom_q6v5_deinit(&pas->q6v5);

-- 
2.34.1

