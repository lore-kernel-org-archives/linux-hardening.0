Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C4489869
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494103; cv=none; b=mwfCrD09JpmZywaTvEffItz6WTZxfBagUuJjXtDjerrCP9IUJVMa30omefcF32nqZaCJsPP/0oSFLKR6vBl5bLybqzC1mNbRyKa8C/07i2ENyZDGvmq7+6hUVpz+6dJr3g8sTSCwHfJW8PMY26LWSpAnjO0i7AtHviP0R/0jysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494103; c=relaxed/simple;
	bh=Hd9Nn9n09AZNGTV46/QfXFtAJzN5htP275zS75BASFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IROgCkbKJHzq1a3YBrDGx1IZvQFcNcJX3VC+qofYmynZIzVaDuxKzLVrh3P8a0S5IB6/wxVK8eV+BQ9VOy/R59x2XmNsbTecDmY6gmSWxNCrqw5wcRpF7CfITs6liukeDkXYR5DRBgBdGbV+9IV5eK8yCg6nDv58sxC36uZrDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bn6YjrBM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCpmr+ma; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bn6YjrBM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCpmr+ma"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC5Bu3891603
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=; b=bn6YjrBMxDUWGq0n
	xun8eaAzs4nixfltJOU2OvkIv2j7y3xA+yDW/iJPPJGxlTJ/vziyHaFu4iSy1tZY
	Nazp1nIRJBJYM5As0pxv9j7twegCnUrLqbrpap746VhUhvHvWyepnMFxwgaVCKTD
	yG7nONOohFtT8uBkivKFoBnM+ClYzFjudjO6QE3tMiNDA2Qfa6bR9XGptydbktZL
	pP1FUMWucMVA9QgXTpR1OrOGpBp5UZSzE9RSk2omOt4qEVTTQJG+v7gLE/moK/7v
	/SFR5rhDI8yJIVYYgXchBrK9DnaPuVGl9xKJei1h7QPKJ3Zhxe7l3by+2dSsVIbb
	oVm8qg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsm383qu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso1252326a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494078; x=1786098878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=;
        b=NCpmr+maTUP6cf8poWrOVopSDrYYeAMa08kTDSW/+iUrrCMP4Z+JOzb5B/EXIzTRdg
         Du6XBGzwFyIKAgErtndSs8de/vnz1UgrfaNSnlv1xYppmLm+kHVwbctm/5o1SlYRTt5T
         V/hamWZqoYK3EuaaIrHWsSpVtT2ziVmj+X9rG5eDs/YQQNlhstnqfcpmiRiTUpZzadl5
         KOLQ9LPCGWQw9rfQzepmOgYUiAJR+DMqQQvF0um/yO7+SC/iyFedLjDdR3WLM0PpoWUU
         0b9fw7lCCfubmQXLjwp+hhNKuxGONPRPnc5E0mZs5gG2NdGBZitPnGt7jjE5cQETvhzt
         1ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494078; x=1786098878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=;
        b=XkvQ2Qi88yH659XGbcrVYa56oScIuLA6hIQjtiNRKVYSra4MwrDTg+gwmVdaBza7ke
         50s+teqgyaymNx9laelo4Q0ue3RjXdnYpMBDA6Zsf3UcbdNXEXmYScpgEHPvjJreinFg
         CU+KCKkONxC03HlcMWgwWq2UJFDR9lpmG1VJNqUahvB7X9Ma+mUDTSpPH5/IAq1BKABU
         SzVzmPdZXVamLr7SaljbJe8h3wesjJI9Uw70DYKCg7jsTw9d9CcxVWhFV502j7hLK/r0
         3GZ27gWo/JPsYYC5JABAVrpIfvAedR7sm/knuQTg3HRwm1Jnwwct05rL12RA4I1QkkbK
         FrTw==
X-Forwarded-Encrypted: i=1; AHgh+RrQn4K3KSOGw0/owKfMAV/H1J/lIwkxPRLR61mtcnDrrar4AEBaIP5oszJ9cByv6qxkaqkcqjqQSWqHd0bHIug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznz/3X2JqSee3E+oFqkH9jVPq/97F24AqtFqUxW0Odgrc47F00
	bJgZ7+Qjyy23QqgbGVM/h6SZmfaszQa8yau7jCNPgSvV0ZMh3a05DtNT3N06KHwO+d/x5OHcZPC
	DKFFwLK4duz94PYE0aVFDQLC/fDyAyWHSKNGYIXBiaLskNm53t5x47pPefqw6TNKE0fxCXZg=
X-Gm-Gg: AR+sD11koDdRtOC60S8hMdSE/q/gqsi1GLGF/HfiFHcEOHbQ9IZJEGA9fk/+CWCq2Mr
	2yyy9Tf32vgDuDncsiQ+P+Y5/mzUixIPUjhMAYW7dnuVBCwfo25aWR5hgwceFY0w+pZM5kjZI+g
	Zn0lgMVS5vFF6xyd0MDXhpak8pphi7oVsUnqdLyYjay6R632OJPI0mMM/OoK8taGGMGNP2NeX82
	wJS7RZQo2fFgyBwgZkacbLTlWi51ibTKdIHGYpANDgU+AEFfdfjq3Vcvv12LcjYiLxGXo+MmCgV
	F2gDRycI4f6Sj6lTkI/tS/4FoASNh5LMww1e1eUVyzNetYBJf8xY3rHaIHXC+ucnYKqVr/HmPH7
	TK5c+MpGMGvl7RIY23suAvcY6Br+tmQ==
X-Received: by 2002:a05:6a20:d49b:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3c91b178f9cmr1395941637.28.1785494078290;
        Fri, 31 Jul 2026 03:34:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49b:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3c91b178f9cmr1395911637.28.1785494077777;
        Fri, 31 Jul 2026 03:34:37 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:37 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:43 +0530
Subject: [PATCH v7 3/9] remoteproc: qcom: pas: add support for TMD thermal
 cooling devices
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-qmi-tmd-v7-3-3befd44403d5@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=5213;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=Hd9Nn9n09AZNGTV46/QfXFtAJzN5htP275zS75BASFg=;
 b=u4LVE8VlbhpIQsKunFC1H5L4T9IJPS59/MxfSnB4jWXl8opvygYQZdvvGGgw77afEXc5sT94v
 XG3JBZ3snhxD7+C92f0OAyCcAEt/VrC0WWcpIa0PU24eawJ4YOeBBr6
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfXzZFyr9/AGIIG
 axgNYmuuLuqXMWssgxrAqGCArTJLeo1couSe4VQXgUiYoVdDuLgWGMrkD/sTkaCJEM/AMAlbFly
 IC43JV8xGoB0S8KrV5/VyI6UW9jXAfY=
X-Authority-Analysis: v=2.4 cv=cpCrVV4i c=1 sm=1 tr=0 ts=6a6c7a3f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=p67dmK6jBiiEd9TVeScA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: kX1qxnTBGLF42cV1BA2_HT9lYDSULOKe
X-Proofpoint-GUID: kX1qxnTBGLF42cV1BA2_HT9lYDSULOKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX2Ih4Vge3r6qj
 IPO6x2Yz/Z16ftjNrz4wESGBZz1HfcoGTnTUNI8BcJSbU2eaEvuaE/vUqA4sNc50fuyjbUN7iSX
 GIFsoq21l5kkATw2p+4zRcsFO/BmAMOakXK7VqZaY5Clwlv/cQb0C/+SEw6gcGja6ayFlScPaO+
 19A862sxxs/sEFh5WIa0jVecwzMMeakGAc4AUZyYgpikIW4gXwFmYxfihnKP8flkPGoAuRqZ6cE
 4Q/uFq7ZgnSBy8l6t6Q36ploCQLW93/bBW9crtzBf8ww4yF2HAtmdkvT6FP0sZc4LnAdTOx89Ov
 C4vI6SGz/Viur1bZlrGafSGCDV06fjx05bHNN7atIvBPUh6PuDkUn3YcV+GgqRc+NrPjwUiv7jo
 UemdXUjf0TR2nOSF2Yp8j8wk++6l5qIdRUhOJUrNTvzFBoczlW1SNHvs3fqE+Gtj7s28ozp6fy7
 bhtCfX7/yDD6FlLH8vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
processors to enable thermal throttling through QMI.

This allows the thermal framework to request mitigation when remote
subsystems such as modem and CDSP contribute to thermal pressure.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
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
index 25599d728208..b9c01ce5024e 100644
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
@@ -962,6 +1047,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
 
 	rproc_del(pas->rproc);
 
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 	qcom_q6v5_deinit(&pas->q6v5);
 	qcom_pas_unassign_memory_region(pas);
 	qcom_remove_glink_subdev(pas->rproc, &pas->glink_subdev);

-- 
2.34.1

