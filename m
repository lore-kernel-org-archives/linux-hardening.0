Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45540927F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615383; cv=none; b=YM34iaP7SuxHiKeErZw1LeOl90G9tHNRBvHBE5cs4TOAZfb3b2EBDoOZNmS6WYZZld405Igr+rq1LsxxV4jDQeaEEuLVOqPY4kayE0TgmPN/frhLnLFBx+yTPwh2KVG/yq6xFH7OKdQOPTFtpVsaQ25FhbEgYA7M4snRLHrRf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615383; c=relaxed/simple;
	bh=h1RranJv2jI2LM6kKtghCftRiHqPNe2hX70tj3R37IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co5BXSUSp25Tzx67d8nIyQpdznldqFH8sKqNxNwH+J6WYGR8A1PlbEo4FMBtt6QuId9S7oD+wMlc/Qn5sWuX/oCQH+W/KLLAk7x+marmrAkEkoDFqi8GPTqnvoFXXlh6WFPhkVOYSAte23co2BQ1eaFV+L6KYwNn5zz2xU7K1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPRQF3Cg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WDFbBRKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPRQF3Cg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WDFbBRKc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KND4ow046591
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 06:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sUJU52E8gQzRrANsqemYRxfZIyv/3tHDVZxDRAiAzhc=; b=MPRQF3CgHgPfeTBK
	L3qVSTOV5TVpv2zu2jLnnrdgbwAHVI8DHSPe56gMvIjldRPtPp5refa6g2dhWUm5
	aC36FS5NK36VR/vyqsZvqiR6IrvW6AUHlCxeXB+y0TgfV/QspRlg90l3eaTVcdPr
	yNeTFyR/ath3X7elTzO9Q8oHmxiTeA1j4u6aLHmfeAhVdUQz3wtWGBuEaNFjQ/vH
	3odWsQLnVmFZhBdx5v4FVqtxUKa+aqvquynwTQCOD6XT3he9edrF3lzDhGY7t2+Z
	iuPQXkicPV2J5Jk0swItLiOR95druDoLvpOQGfNPXoYp7MWRT4mrs2LmFtnxViwc
	rrtbvQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5tpd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 06:29:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so214470825ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615380; x=1785220180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUJU52E8gQzRrANsqemYRxfZIyv/3tHDVZxDRAiAzhc=;
        b=WDFbBRKcptKo956nHBt9hnbhb1UkZ9hRqZmN7OqE5LCLS84aNV+ra4hd0bfaYaWJqZ
         JaEiZslGskSN/HFhsWovJ32cyOw8b38ksFWtDqf9nZhi8yF0h+84oNkHvZB58A/S0Wmy
         GzLGZg4QYPzOCNgTtWN1a6j0VSOBkNMu4dol21VlYHSzkzx2F3cL0x6lyu91LyiPEg1E
         K78BxhzYoSMwZLuQf4yXqaAuzZ2aCC3cR//6FrBwWRWwvJIjYnM12ta8PFWpdy0uZiQM
         7taN1QC5RdKMEXeYpU6nMpDn0VeCk56hxp3hR/l/Bt1I3Ylyk/7hnrfHzP8PyOGTa7p6
         aRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615380; x=1785220180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUJU52E8gQzRrANsqemYRxfZIyv/3tHDVZxDRAiAzhc=;
        b=BZEiquDT3PGzoUnlT70qoOnkI/LJe9i/sBeFVamsq/ozq7hvbwWFvWrtBEbIqnw/bP
         BX96E76R+Gq90i9iXzu+GXqmhV2avPrDlCl4uLS49KtnP8GHHqqceGNCoa/t8Gyi1YPt
         gKHi+ukVsW/HPmwda+25VSOBJ8JN1qYQkWLK/OAxUvOQrdWMGxsyt30URJE1KyYNVuQB
         ekeUjB1DvNFjgAqA3ZyQTNnAbXXakjv1muPjS4YHtCFSxam1TDX+bXsBjMkL4GZnk1zF
         Zmly6U3B6NjjEBVzrzB96PMoVx5+33K3GeOnK11SaUKNL2vslc9Wi+pBVku/2X7uqWyA
         c9Hw==
X-Forwarded-Encrypted: i=1; AHgh+RpkTR7NJqMbyhQIwwh15ntGDj6oOeEHM9R+/kLcU3XM3bUVZNlX9RcURPdTQz9GbATc7KA1UQ8Lt4jVPip/ySU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4eZ5ouMXqTC/Q7bU1hsFzGqkrJxDc6phviibr3ed6DvWlPti
	O0EWlbsX99mO9ThTz+s3rNFEQRhFKpRNGPf3xHZLmlkviXcMqT84AhBWuhf7mGOp6K/dIlpWbZ7
	S6qelff2Oux/gp0E4ua+A650E1a9rlFdazjQhwTRvlAk0fdbDtT231Vs/2joUsqKBkKy60lY=
X-Gm-Gg: AR+sD12mPxhFszL8qBkqu0VgpcQn3luX1HR1bSeVbhfxIEEEOSzJo4n9u+ge+RLQdOt
	5J0/By7oGFfO1BQvil/VvloaP6r8xCWAmlpZBonfzgTB1vxKZx52qWIUWOiRxjn8TCffW6MGl/9
	5+uHTPSBOglvyh6XizyGh6DATeABf4MP6YEpbPM9/hEwv0f4IMK6goFBNvgsY4wzvmVT70dK9da
	DKwk9Gtlr4jV4wwamQpJvLHUFQOP1ShRunYkgURdnpb8ZKGLxQICYHanlpWbfVqdBEgsjbYERsc
	45ib4776uF2y96zgnD2jMCDwb6m+0oxfPSv+Zbbf8mejktYk+8rKFT8Mt+jEMnJuL8FNlb4Q6eV
	7o7/RI8PH87ExYKGhCOOgHiovuX9KRQ==
X-Received: by 2002:a17:903:244b:b0:2cf:7c95:953 with SMTP id d9443c01a7336-2cf7c950a5dmr38620725ad.47.1784615380467;
        Mon, 20 Jul 2026 23:29:40 -0700 (PDT)
X-Received: by 2002:a17:903:244b:b0:2cf:7c95:953 with SMTP id d9443c01a7336-2cf7c950a5dmr38620345ad.47.1784615379989;
        Mon, 20 Jul 2026 23:29:39 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:29:39 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:59:00 +0530
Subject: [PATCH v5 3/9] remoteproc: qcom: pas: add support for TMD thermal
 cooling devices
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-b4-qmi-tmd-v5-3-99620e07f505@oss.qualcomm.com>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
In-Reply-To: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=5141;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=h1RranJv2jI2LM6kKtghCftRiHqPNe2hX70tj3R37IA=;
 b=X71gCf3J0yi/xq63/3gkPZz6xEby0/VxuJ4IHbaBHttSnwN/I4FGP12pkIRby2cN7j1jsMyO2
 Z8y8pHQ071SBO/DVL3G1i2YcQ+zYBMLtKKfsiIdCRM2cznTrSTz11xq
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfXw3xu1EIApiQL
 pAs/3IJKaTE/82cF70ssMhdik2MgMENBXoYGqFxzaDcZgt/Hon7bhWxgODa8hfoL7Ipe/ge8asi
 imvo+g5C1q+bDTDE41ZKIT1iDoOkEuK/+pVWK411HcJAX89FHjB12RhbVnnfWduOMVEhL58f7sU
 pHg6a5ig2KxigQXiYqUMW+ejBaAZTQQNkqKGY/0edY9w83xinpidjnp7xAoX7RIVw9kLjDe+CfU
 u+QCOHpmazYy5PegbIBQfK93CpcV8x79i3EgrsoP+fWsGM+8inR4Zf/qt+f4DgN3ndvuBTy6i7W
 sh20HxtQ1x+tYhLBSTDf17xa0VhuR/N7u1kTn5L4cBZyla8DKU7I3m4hvIxH/CRcUoCTReBdivp
 S4XgHdJv/3LBGMom4NvG29BiVfr8vIsZdBNWLiqcvrEzEKYTkaBrcgU4x8bhXlICZ/7GXKbpvIv
 PNnYyyPX2njKVwynigw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX21VVlzjI8SP/
 hhcMnO6Hd+NgI+JaiYiGuPHMFTTSgqOy+tc2VHNdXWdx1CDa7687ZWl44y490SgW4ZqaQO4Wqet
 2+yxBBICJS6Jd6BjukfO+4An8zF8S3g=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f11d5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JsyU97BMdJ6RvXteW0AA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: t7fcgUc8ho85vT9naJx16HJT1fJihXjt
X-Proofpoint-ORIG-GUID: t7fcgUc8ho85vT9naJx16HJT1fJihXjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210065

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
index 65befdbfa5f7..f7c02edf395f 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -229,6 +229,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
+	select QCOM_QMI_TMD
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	select QCOM_PAS
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 25599d728208..dc5be2c030cf 100644
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
+#include <dt-bindings/thermal/qcom,qmi-tmd.h>
 
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
+		if (tmd->id < 0 || tmd->id >= desc->num_tmd) {
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

