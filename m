Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF253446AF
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055062; cv=none; b=hWHxcGegN+pCF71hTN8fCE2+TgJscGsHoFUJMhJEM6DeCS1reXOgAwofux6Bz6Zxn3WqbhoyyieYnTNjldSL3DOSf8qfN9UqHOxLFn/r3744VPcdIll/PuIen8gNqA+4Fv010Sem0lX6VPyrn5ssZZ+u2cnck16FAgTw93/VtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055062; c=relaxed/simple;
	bh=YLzzOqexgI2OLB1izWL/2pvG5P3Bot9UTn4BCsjmqe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxM+UctnI9UHj5OgQIKzNcsO9DnSoUXumuBO8d6yJBJARKnHYEatoPD3mqxMEsXGL0y6SfLqfRSDZ9FCvqIj9ChMJc+FhJLFBZdngaNnQkPuiDbIwe+t7XDBv+m5MgJSY5/YlcojNk3SUoi8i1nikXywP4ZAIJLzh1Oo3JwY8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MrHm0D5r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NHlON5Tm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrHm0D5r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NHlON5Tm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342b6C2687040
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 05:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	styMC/RSg/rxk9wJAUjveP0CR5WBpn1D9q8Ul1nzvgM=; b=MrHm0D5rkrAQOwq7
	X+pVipxIDs1YlnK2Izv4dRp8rrmrYE4P4y3zl4Ve4CH+ojxleU0VY+kBLiXHiID3
	jeaDQGPpUI4c6s7n8USc6L8UV7H2KotLP2cAZSHwBHzhnIgtTKwlyTYMS8wJOukI
	+kLp8A+ewYX9a7hOF3LdMPl87IAtbK6yRKkN2JdMx0UtLrFe7QcvVlXhkXeWYh++
	nR5h6HgexWM5sWQJsC/d7aOaE0Y9lKwIpTK6ee6PAQJBMk7YDkgTigxWQaj5x8tB
	eeym2e0QnuThidzlnj8tFihf9Y4XPUQoY8DBem93n6Wghy9raiW7iNgfR9TaiFqf
	DYQL1Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n0hsx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 05:04:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso341398a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055048; x=1783659848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=styMC/RSg/rxk9wJAUjveP0CR5WBpn1D9q8Ul1nzvgM=;
        b=NHlON5TmpAjzz3eVbCMqvOj+BSsEHdu1O3rFZJwuOJ7uiOOdgVfobWXD8SxaKQwvbV
         6RV1WWaFOn93DLeWbmriY4PQQEQXGsj9RaHDQTmCIOk2y9EPlFLNSwR5jRNfQZ88dvVk
         mPB5huv12TljrovnrKWK3V9G+ih5N8/aeWPSf/Uv8MGZRQ9Cy6xVbkEqmMlPWFdasEBV
         odkV976LqneBQ4dbMU8oP6FUHC81K7gDEsc1wvthsY7F4ryIVPK1y5q7q2QgVoShO4yt
         aDmvzBisKg9cG2PGSdWgWNLHz+YwaU2nEhScCs2p5x/0QAFgDlAshi+BMyhwnaNrTqaw
         DkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055048; x=1783659848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=styMC/RSg/rxk9wJAUjveP0CR5WBpn1D9q8Ul1nzvgM=;
        b=KBrQOJgj3mCpgGTn/rK03pgBk2El4dWQX1xtM8qAu6nOJbt5fnWDm4KHYfhZQpNElx
         m8szEFgJrtJfxcJ7hbFMvg/3Abz0iBFjgJ7Vtm+78JyVpO2nhgzrBZn7+5Dd9IR4gRhK
         nik/WgHSaXJG0sa6k8aMgaNlT8/vItWSProCGJV81eJGlkfReB0FeNxoY3YsaN9mTfQP
         hdBgvBWVQup3Saj9g5zCISgKN2rmaedXKFYFleC7bPU65y7JaIA2DgPY9qgL3t7k0lud
         0iBNfnhvTUb2inTDL2o/CCShyaWArZGhpuecPzZmunBhxMltiDdXqrqHUtoq5LygtZw9
         NTaA==
X-Forwarded-Encrypted: i=1; AFNElJ8X4kJxT5QxQ+k14M2vw7Pi7DMVehX2UOcvUcH3mduI8MIBWUkNOdyNz1uRyI9bbwdbH/I+8o1mHOblcvvAydM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2M+IYti0Iqi/Opb77jyM/BWa1QY2ZDLbDiT6X2R83tu2tO3y
	0CTSydDBM7Ppi07t/l71a9pdpoI4pHH4zfH4uW0WfjfrrU/GbhqLaSFb+Eiz5Vv5HpXhAbVktPt
	rEqnYX0Rl7tpZLq6Ox3v6+kcXNFz883gZ11ET0xQgX+kguizJc6Lv96p9LBZ2uY5O+T40hpI=
X-Gm-Gg: AfdE7clRpKOFWuvAAZyit2sgUIsBHRJ5izACg6Ig3mU1tQf0WhfZcqCFecDQ53YaYea
	ghuRT3tsDedx5xtjGQnoEXr958VYuILytClOq8GurBdACTRkR5kIpd/as8FESCiWq0ERlpC3QXM
	PDvD11WqEh3yapxCuB9FceFvHrkdm1RiTpYJkBrVbVLsv0NAeGQ6941Dh92m4OuhmX7xS9A135w
	cFfpD7Y+7JcMgV4sDsLR9j8U+djLKf9oRwnFzSCb+1r0F26lu+6SkbGVJvSYP0qbet6wV72wMFt
	tJxv7KfsyaKpwJyxPsAJFHsiQfaOzLoE6XDa8XlNX3XegeT1rHX8tumZ+23L1BzfLB5HKf/1PpJ
	cEuWIfxi9PpoSmu4bRWuoRK5xXFRu0xVSqIk8094C
X-Received: by 2002:a05:6a21:1b84:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3bfed3b19b0mr11022062637.39.1783055048147;
        Thu, 02 Jul 2026 22:04:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:1b84:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3bfed3b19b0mr11022032637.39.1783055047655;
        Thu, 02 Jul 2026 22:04:07 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:04:07 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:07 +0530
Subject: [PATCH v4 04/10] remoteproc: qcom: pas: add support for TMD
 thermal cooling devices
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qmi-tmd-v4-4-3882189c1f83@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=5135;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=YLzzOqexgI2OLB1izWL/2pvG5P3Bot9UTn4BCsjmqe4=;
 b=YvqhK7JA8HM8KLaZwwbl8HmRXjMNiXwabJxM3FFxhuxfhoFMyNsz8aacsGcqMcwmDPZdYfbxo
 Yhi/6zZ6v6JBFaxFyyFu/mXMB2GnNHvMVK5VQXVdzCmxMg4sF++uyGO
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX/nhxcSDnu83P
 z6bnM8DQJ+miDMsicaI2cm1LdxNzBuDVWk3HeaekW7Bo8vHhUVlsW0P5bLOFv+gA4k/LQ7njzH2
 qPju0NjORbin/6d4ja7a/LIk+xd5XYc=
X-Proofpoint-ORIG-GUID: G9-cWL-4fN2QPDOp6jETNvWD2WwIhLXE
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a4742c9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JsyU97BMdJ6RvXteW0AA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: G9-cWL-4fN2QPDOp6jETNvWD2WwIhLXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX4ygVNQaqxjCX
 NnwsAPVrGp7+aWhQvIjugYkhaZ+MmbM+fd9pfjAoPDexlZpnPpENgMlgKkVEbCUC0zZuAnyqcHA
 ro/KsQKeNfp5oCPrlRDE8vwer8PRXvYY6PLfA1wRkCyUCXx5DsfELZpC2HCfQEKAP5PFi9Lfd1f
 LW+a4sdlcmGtOOt1fHYebWrqEuI3GD/GYhuj3WR3oi+fPCp7mU6Zusf89ovVUjsWeten3Sf1K3N
 BnhcOks1w3nFoTLAOUFYGmG7/6W8MmguacxMzu04oFc1pLbAEJL7lEGOBNHF1Xv6Jxf8tdzgQUP
 0+rVGJ3wXbQ+bc2uXxVn+O1R6kAlVB2tJ5STLKp9b6Ygdtx1rk6JHAC/hMuzcc1uDxoUqIcDimv
 uggQ0xoK2bE5JjWfAv8Sn9pVawmWwp6YanDqYc/X4Zdk+RaNIlMsuJaUFYf134TRn3sAxaxEKFL
 kGm1TWkFaGShxn/vphQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030045

Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
processors to enable thermal throttling through QMI.

This allows the thermal framework to request mitigation when remote
subsystems such as modem and CDSP contribute to thermal pressure.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c | 93 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c78e431b7b2d..cd8cc911e1be 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -228,6 +228,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
+	select QCOM_QMI_TMD
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index da27d1d3c9da..ab5bcccc91a6 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Linaro Ltd
  * Copyright (C) 2014 Sony Mobile Communications AB
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/clk.h>
@@ -24,8 +25,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/qmi_tmd.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <dt-bindings/firmware/qcom,qmi-tmd.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
@@ -36,6 +39,16 @@
 
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
@@ -56,6 +69,10 @@ struct qcom_pas_data {
 	int ssctl_id;
 	unsigned int smem_host_id;
 
+	unsigned int tmd_instance_id;
+	const struct tmd_name *tmd_name;
+	int num_tmd;
+
 	int region_assign_idx;
 	int region_assign_count;
 	bool region_assign_shared;
@@ -120,6 +137,8 @@ struct qcom_pas {
 
 	struct qcom_scm_pas_context *pas_ctx;
 	struct qcom_scm_pas_context *dtb_pas_ctx;
+
+	struct qmi_tmd_client *tmd_inst;
 };
 
 static void qcom_pas_segment_dump(struct rproc *rproc,
@@ -733,6 +752,66 @@ static void qcom_pas_unassign_memory_region(struct qcom_pas *pas)
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
+	/* Check if TMD mappings are defined */
+	if (!desc->tmd_name || desc->num_tmd == 0)
+		return 0;
+
+	tmd_names = devm_kcalloc(pas->dev, desc->num_tmd,
+				 sizeof(*tmd_names), GFP_KERNEL);
+	if (!tmd_names)
+		return -ENOMEM;
+
+	/* Build the name array from the TMD mappings */
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
+	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names, desc->num_tmd);
+	if (IS_ERR(tmd_inst)) {
+		ret = PTR_ERR(tmd_inst);
+		if (ret == -ENODEV)
+			return 0;
+
+		dev_err(pas->dev, "Failed to initialize TMD: %d\n", ret);
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
@@ -855,12 +934,21 @@ static int qcom_pas_probe(struct platform_device *pdev)
 
 	pas->pas_ctx->use_tzmem = rproc->has_iommu;
 	pas->dtb_pas_ctx->use_tzmem = rproc->has_iommu;
-	ret = rproc_add(rproc);
+
+	ret = qcom_pas_setup_tmd(pas, desc);
 	if (ret)
 		goto remove_ssr_sysmon;
 
+	ret = rproc_add(rproc);
+	if (ret)
+		goto remove_setup_tmd;
+
 	return 0;
 
+remove_setup_tmd:
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 remove_ssr_sysmon:
 	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
 	qcom_remove_sysmon_subdev(pas->sysmon);
@@ -883,6 +971,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
 {
 	struct qcom_pas *pas = platform_get_drvdata(pdev);
 
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 	rproc_del(pas->rproc);
 
 	qcom_q6v5_deinit(&pas->q6v5);

-- 
2.34.1

