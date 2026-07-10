Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578B3D9DBA
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674302; cv=none; b=hOf9O9e+HyaOibpjoa70RlkwZX06FKbC5HJg+dvKp24KmtlwmBERVxkws9IKe1N7ccUjO7GwEJokolHl8RUySmy6NPoC3SQdj5n4cwPj30YaZghC7+kYfItCICjRC3pQZnEsyAz/NiTi5kVma9la2MsaY9cbk0lmA5sjt2AfDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674302; c=relaxed/simple;
	bh=QBbw+M6NM/7xN/mb/n4EhswLHY92P8G06BHphqlIqXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZAt4Bqi2WisJR5s4PppAb6YqGvHK8VR5LBRIPdwzvf2oTkTGlovy75mLDJtMreHYQAgA+p9uRqE1kSuroXfVbaski+kA6lmibT9p14Kd1N46bmRRszs2b6jevwX2UESJo6lorp1fNXq1PKK+LWwZVfBFY1Y0jZ9SZkBuvczubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irvF8Mfa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVBgYIOG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irvF8Mfa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVBgYIOG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dVAN235286
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9beixJbeJJsoRWLUTkdRDRxoNyd2rNMiM72fJceYNRM=; b=irvF8MfaPyLrVmL6
	M+CIBFXO5yeirklARUCZDXTEV6g6ouCgEvsMrvecDmv2fuHYF87HhvhWG354WAcE
	ggjegVmBklfvX/KO1Dw80cTdXKCy3ITk1+COfVBsNv49dI8UnA5HvIaRMOayOat9
	9zXpJ9Ngj/aQVo/oUdU3Jy3mCsEMwxOIntmq//yI/qGYhN2d7MQ95PVxMa72caYH
	k8uC4wsfUOEtTsrvHf7WpNN4m+aRvTOVh26MXbdiRnuoIVkg2xjN34Sqj/jZOzSS
	gN88zk48iHQchDsngOTdLgn54H8Wy+CAaBLgdC7I9xKXKdApXeFcL+kJnvhkYDYS
	7ljBqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3kq4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bfe3fa93bso7836081cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674298; x=1784279098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9beixJbeJJsoRWLUTkdRDRxoNyd2rNMiM72fJceYNRM=;
        b=bVBgYIOG321ZEjaVPvSyq62iCy7sc4GLVP6A1/3zUq7k8gVEFn01mKPVdpx2bwv5u3
         7wkuujmxc4hdarqnBm33lRI2U3YiIpqjPNbPhFOLL8mRO16kQ7QrpkensCsJcoYVU6Z7
         5Q/b6fauXiRgvs21bxKf0n+0l+QsXDOQk/dFJqlo2PDr0RQNIZt5o5nv+Bl/0PbgawmJ
         OkEQfnQ2vMNfgiHaI5DV2EaqV1qAZ8RQqcuDvFd4RDPP3oGjc3LnwArS9s4KImkZWr6S
         b/eGg6YCRAAFDGINdlqXzEtyOcURDk3C92dIqigVgUwqLHEP09ltqAvkd0zJ3KYFRWuZ
         9z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674298; x=1784279098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9beixJbeJJsoRWLUTkdRDRxoNyd2rNMiM72fJceYNRM=;
        b=JYYFdsI6MVj2eO4O4kB6HQVe1yFlU+PWjGEB6o9wzu1xDn9zY9WDKfljDdGHjhJZK0
         /0zf5BxhaN8SHCrodnSSuo3RCXR4DdgpuMI8UCRyzle7AyIikhkZnK1jfhGXS76P75KR
         Ij79Sw7IxP8nDR0+ktr4HpbKPunyFeLtTb3IG0hOBu5Bx1ud6fbboh7C/t5TJ96FcVgv
         zUQje0OPzypT0C4SN3cKWIlYf5+Y/xuOGLcJQ/+0z0W2u/RfdOkJjxbFEPLAcKgrxu/d
         J9ZDA7FBusbC6tvtFdq4mMZIG4HZDeUZJiis1nk8aANv5XIizMkzgXNxmcEFaJSN2aOK
         sntA==
X-Forwarded-Encrypted: i=1; AHgh+RrXjpP8umHtB8E2PObRUyNVr0/iS9fpYDHwN2H5Y3AcuhhhJkaZVURddqfVN5TPCiPiPxOpMiWACJLkGp6fsAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFX/IjMdck3DjcvmJ5CI2VEdyHWnkAQDukLgCTc7LWiK7+eWV
	qgDzTAwPnrHMYnD8zNZH4xoYJkJY43FdXV6M1u0uYvgwldgzgmNJjuSp5SCt5NtdGR9q08Z+cP9
	2LArfdM/BRd4OHN7/YoKNKNCo0/4knM61A/RnXM9qlIENotgrzyGjFSUu9G3LtCSYwseX2G8=
X-Gm-Gg: AfdE7ckOE2LEubGTAyIir9CGr8JFHSt7BOpx/giBVAUiewldMcTIsKP4d8BWA/0pOjM
	iwPpCWdjmCznzvUHQiv+U/P+L820nQCII79OuftMKIQZiQaB637HWIPKLAkpWYUKSgj5IZxA4b2
	D8ZzeowTm3967+IuqfqOja0r/wiG+XSKV3jiTIprnth6XGmIV9CihYx1nXLs9NqM0Zgm/tsZiMq
	M3+o6FU+o/0DNv14MMzZO1n7ajrqMk2hz6Nt8TJiFK/k1jWgBBFf0qbTSyyi1CwOESxHyXx66aq
	QywpELcbtZrsxjXdElKZKnH7gQmuoPg4ztvXvBwAcFUfRKYFysIoy8TNti/Ub87tQ5q6wKaDKLK
	1AE2iIYz1CWEICW/woQMdNC04A18i8kQgjVdIkH5tVEbNeHChyeaaiVhN3ciuTTUYE4KUXZ24Oh
	rtr9ExG/HFselAmhe+VNZtHhzY8iTg3XiBqWwfSAno7t1W6+Xocg6CIGE851MYng==
X-Received: by 2002:ac8:7d85:0:b0:51c:7b13:62f8 with SMTP id d75a77b69052e-51c8b438a5cmr111756901cf.78.1783674298047;
        Fri, 10 Jul 2026 02:04:58 -0700 (PDT)
X-Received: by 2002:ac8:7d85:0:b0:51c:7b13:62f8 with SMTP id d75a77b69052e-51c8b438a5cmr111756501cf.78.1783674297528;
        Fri, 10 Jul 2026 02:04:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:04:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:48 +0200
Subject: [PATCH v4 2/7] media: qcom: camss: Add camss-params helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-camss-isp-ope-v4-2-51207a0319d8@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
In-Reply-To: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX+zTOCp6rCHfV
 xjx60/pU1QtykLtJEhQhNCEOQHDvPDIMOoLW+V4YxenYCFPTGw/JSVp0A3v3p8U6PE/9NFf38M3
 Yabnnc3IkYRkaQNCMg2jiHo22pAVEJxT4cjWBWc8rM1QPg1CxhdHZ2DJ8eOfquJrleMpKUyvBIK
 G8QPV+URaH0XavTqUjUAsLDW5KQr9fFYep2zrEZWmJOxPXnsVbLmkUE+3+PKohCH5l1gioNd/Bc
 fyhD7M+Si4eYWJOFaUkTeulskwV1juFi3V/ABEzh2h4g4tjRaVOUmDWLltoi8sreUh6rkso+KbU
 WFoH5xHFMlid67tuQOdoRwrvndz0cXmkXssH0zEE6yM2vr94jDJITDWhpeZ53sYpO+oheBGssOD
 9XlsQ3d+O78kq5SNQmg9T7uw+xacMuA3z534kcERIkaILgfOMWCCacbIFQ4/wO07BxE0uLa/6Zm
 QYL6Cu6TiLBqby+gQmg==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50b5bb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ELVW7ba-Z2avb-AJsJIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX1dOtrGYicIZ4
 WGTI6l7nKnVY5jSqpeiTTFAIfFqoL6K967Yg5r1VdIl/v86/UWL+iFnrYIDURayiJRxw39lHvE+
 8T8QpS4bx6DlpJqgly/ZCMDTEjLMxpM=
X-Proofpoint-GUID: qLBjZl-SRkO3sstxUObhEp62PDeS5-Nd
X-Proofpoint-ORIG-GUID: qLBjZl-SRkO3sstxUObhEp62PDeS5-Nd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100088

Add V4L2 ISP parameter buffer validation helpers for CAMSS ISP drivers.
Provides buffer size validation and per-block type validation for the
extensible V4L2 ISP parameters buffer format.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile       |  1 +
 drivers/media/platform/qcom/camss/camss-params.c | 67 ++++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-params.h | 62 ++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 0d133ddc08be088678994820c0ac64e761884611..5678621efb6780b67a043ec8a2e914cce02d9b98 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -28,5 +28,6 @@ qcom-camss-objs += \
 		camss-video.o \
 		camss-format.o \
 		camss-pipeline.o \
+		camss-params.o \
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
diff --git a/drivers/media/platform/qcom/camss/camss-params.c b/drivers/media/platform/qcom/camss/camss-params.c
new file mode 100644
index 0000000000000000000000000000000000000000..ebb75a191d37551b4616a048ed39408f219d7daa
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-params.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-params.c
+ *
+ * CAMSS ISP parameter buffer parser.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <media/videobuf2-core.h>
+#include <media/v4l2-isp.h>
+
+#include "camss-params.h"
+
+int camss_isp_params_apply(struct device *dev,
+			   struct vb2_buffer *vb,
+			   const struct v4l2_isp_params_block_type_info *type_info,
+			   const camss_isp_params_handler_fn *handlers,
+			   unsigned int num_handlers,
+			   void *priv)
+{
+	const struct v4l2_isp_params_buffer *buf;
+	unsigned int remaining;
+	unsigned int offset = 0;
+	int ret;
+
+	ret = v4l2_isp_params_validate_buffer_size(dev, vb,
+					v4l2_isp_params_buffer_size(CAMSS_PARAMS_MAX_PAYLOAD));
+	if (ret)
+		return ret;
+
+	buf = vb2_plane_vaddr(vb, 0);
+
+	ret = v4l2_isp_params_validate_buffer(dev, vb, buf, type_info, num_handlers);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "params: version=%u data_size=%u\n", buf->version, buf->data_size);
+
+	remaining = buf->data_size;
+
+	while (remaining >= sizeof(struct v4l2_isp_params_block_header)) {
+		const union camss_isp_params_block *block =
+			(const union camss_isp_params_block *)&buf->data[offset];
+		u16 type  = block->header.type;
+		u32 bsize = block->header.size;
+
+		if (type < num_handlers && handlers[type])
+			handlers[type](priv, block);
+		else
+			dev_dbg(dev, "params: no handler for block type %u\n", type);
+
+		offset += bsize;
+		remaining -= bsize;
+	}
+
+	dev_dbg(dev, "params: buffer parsed successfully\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(camss_isp_params_apply);
+
+MODULE_DESCRIPTION("CAMSS ISP parameter buffer parser");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/qcom/camss/camss-params.h b/drivers/media/platform/qcom/camss/camss-params.h
new file mode 100644
index 0000000000000000000000000000000000000000..058e3f158b42d39512301d412a983fb2f34dab21
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-params.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * camss-params.h
+ *
+ * CAMSS ISP parameter buffer parser.
+ *
+ * Wraps the upstream v4l2_isp_params_validate_buffer() validation and adds
+ * a dispatch layer: after validation each block is forwarded to a
+ * driver-supplied handler.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef CAMSS_PARAMS_H
+#define CAMSS_PARAMS_H
+
+#include <linux/types.h>
+#include <media/v4l2-isp.h>
+#include <uapi/linux/camss-config.h>
+
+#define CAMSS_ISP_PARAMS_FMT_INIT \
+	{ .fourcc = V4L2_META_FMT_QCOM_ISP_PARAMS, .depth = 8, .align = 0, .num_planes = 1 }
+
+#define CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY   (1U << V4L2_ISP_PARAMS_FL_DRIVER_FLAGS(0))
+
+struct device;
+struct vb2_buffer;
+struct camss_isp_fmt;
+
+union camss_isp_params_block {
+	struct v4l2_isp_params_block_header header;
+	struct camss_params_wb_gain         wb_gain;
+	struct camss_params_chroma_enhan   chroma_enhan;
+	struct camss_params_color_correct  color_correct;
+};
+
+typedef void (*camss_isp_params_handler_fn)(void *priv, const union camss_isp_params_block *block);
+
+/**
+ * camss_isp_params_apply - validate and dispatch a params buffer
+ *
+ * @dev:          device for error logging
+ * @vb:           the vb2 buffer (used for size validation)
+ * @type_info:    per-block-type validation info, indexed by block type
+ * @handlers:     per-block-type handlers, indexed by block type
+ * @num_handlers: number of entries in @type_info and @handlers
+ * @priv:         opaque pointer forwarded to each handler
+ *
+ * Calls v4l2_isp_params_validate_buffer_size(), then
+ * v4l2_isp_params_validate_buffer(), then walks the validated block stream
+ * dispatching each block to its handler.
+ *
+ * Returns 0 on success, negative errno on validation failure.
+ */
+int camss_isp_params_apply(struct device *dev,
+			   struct vb2_buffer *vb,
+			   const struct v4l2_isp_params_block_type_info *type_info,
+			   const camss_isp_params_handler_fn *handlers,
+			   unsigned int num_handlers,
+			   void *priv);
+
+#endif /* CAMSS_PARAMS_H */

-- 
2.34.1

