Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAF3BA246
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294011; cv=none; b=HL9Wh8A2QFiTH9jreYtNCwJbUrEg2mjur/O4ZogGTwcV0Np3EnPRLX6snAJ1/Q9Qs4hC8cMmxnemnHMkneOfBAMmBK/xywqZujHLM/VClH60qwDIL3fSGYyfluI3bqgkxEADmCgjzVgpv1SK1nca47fI+aLRK4hbU2pESk2BJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294011; c=relaxed/simple;
	bh=WcsQ1A2YxNcqZOtl9cSQ1R0tPKuBbn7v12WXFUOf7gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rK5B9CtRldTXLwYW4T+lZW4Fyo5MRMgn9+VzUI/RZRqzNaj0Wpn/vjnGFoLXvWsGp8m7990l8AEzsasWjQDxcMI8nR2GJdplNrIjNZo5lxF8nGO4jrhu4xbmiWolflGE/1RmlVpwM2BfSU52xT8OIp12+IZB0gkn9fabPJfEtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onozB9Fk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AlmHr04M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onozB9Fk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AlmHr04M"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T9iq1762094
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51hUPVD+vSajWa56BxpGzwnPphsgTAXfhVqxxWUWJ2A=; b=onozB9Fk2So+31yc
	6n8zto0WVmWOWM7tC3ZnIxzQGo0enUF+9w9nizPp6/tIgDiw1YfKZExvV1VxAvIH
	VwUaxVxQiaMtf2Lx77RBQAEhfjpi1WnuL9zz4YEWcN7aH605q5wu8kcNaKKx+DrP
	WsllUYQHuvEWsZsMz5qoUlLhb2ghlAPu0kW+f0riXoDZWRDvLalwk9B89GxLftl/
	lkBTzSqhp66uwbDUjHc9izohJxouSL4pKrF0soAl8VD2kJapUvmnS97GZ0EuJBHC
	nF9l98pA4r6eQWDaxWC12GgOhVL3MmZjQihDDwodxg7Sx42frZFtvk3OBnim5/bd
	CbyFfQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9e3d9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fb007bc36so176575131cf.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294005; x=1777898805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51hUPVD+vSajWa56BxpGzwnPphsgTAXfhVqxxWUWJ2A=;
        b=AlmHr04M38iTcj87LzwsNtybHGwHYg9Uqf4Po6ZlgVzof83CyGpRzj0X8tQaLMBMkU
         pJK+u3KlruQXRdguVWww3eGlS8Ne0dGWdLbNqiBj2gSOZ3dj1g1RtApLu5JOt9IKrVJz
         Qrr9ePePQ2TY0KexStWgSwhu0LHwpRH0IRpIDZMRomnblYB/k7cFG3rW1otQ9xvbkI20
         2evT8gU9pS2Bu8eelEskXo4ZQoHMhfsjK6dZE0gby/qjRNInK0IwOOV/42tw26rGr9pN
         jkvTksdo5684KVeXz+vmmzOM/6S/xXAvoU8C9+vsTHCwj54UOtsxWa3oeip1MGFwbW71
         IGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294005; x=1777898805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51hUPVD+vSajWa56BxpGzwnPphsgTAXfhVqxxWUWJ2A=;
        b=bD0uzyhbshTfTStdelHUJgo6BzdYFw9cgiKaVDAwYZRFC+xd43FKMyVQfovU0y/K6Q
         Cs2Z/vUoweUxoSRxZTOW0YnHZae/Sv3nM8lo+dH3qfJyzmX4PYUXhltZVFAY5YddGs+J
         6Mje/0Q7eA+WLzmBaXKzJEBrGtrPZWlmxEtdB6CMrhFd49P8Ri+KIWSlSJn8rhdZxLxM
         0Du0hzz7EloInDoMW1jjZVn5jVPW5B4inbpaTjFbf6LJd0JZZg5/ZLKl/1eMGD90VDfN
         +q7oIazSGrwYbHgtRlYj3rCRC0/voSrS6A5dXrMn4yFS7kr0CzoXgzWYjZUwHm5Mq3Pd
         Xdxw==
X-Forwarded-Encrypted: i=1; AFNElJ8AUl0oEkZisTgM/4Qitu/eZkRGmgSeJ0zDiWlOIkvHPA9qXzZaBJfivGU9TAtg8uB+ghWDcbkkD47Qb5BT0ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxagvw3b51l2ciFUm1vjevDdITT6MaLpHGHwSE5xkH1AZ6iPSoT
	heC6UIE0PiAMLFrwa+ANQGCVbbk5ZRK9fevH1QMBMyOj0XFH3sz50FTNK6qyjaItWUTzIIuJeDi
	mTnj8bgWXAFcUVLeeZpx0GvFEiuFUoRrXDMbD5ICmZ76CyNJbyLoFFY/Etn+T8w9T3Ax1uzI=
X-Gm-Gg: AeBDieszXhf0Li/ykyZ5L1LnVgg1Pv7Yz2LjPVh3rBhza+DcsFo2SsI6sA1AbHLX/X4
	BfxiIv6bcWTz+S9NPFLd0XZBzSrkwkiOC11bvTFufce+ztKDPt9yWOVb/f0YzmF0AUYu2kEwWHj
	PPGgezhGERULDm164khIa7BPrmSPqin6pl+OR1Qq2cQDsq2tjPkYKbtHje5vnTVjmixAoZImUiO
	KpPdnJPkYi25DJOUIDH8YvCuftlnKkSmZJBLtK9CepWCp6z2QxD5+aQKi9kuG8sB4GpV/plRF7k
	jqoc7sjLeyR+iG7H2ZzYh17gD/qFV0qqyfaWEDEp8BhuqL7c1NTI2FXtlm8A1SY8DYjcGj7Wd7Z
	9SADHUUmghBJFoul3g1Q4X0CcVAl9D6A90uCQ1sAtBRld1v5+zETjYv0OimJ+Ino7PLjhbYg5TJ
	EDCIkHun1d6CpJ5GJGr4ixAaiv6qE=
X-Received: by 2002:a05:622a:8404:10b0:50e:57de:40d7 with SMTP id d75a77b69052e-50e57de4894mr368757661cf.19.1777294004564;
        Mon, 27 Apr 2026 05:46:44 -0700 (PDT)
X-Received: by 2002:a05:622a:8404:10b0:50e:57de:40d7 with SMTP id d75a77b69052e-50e57de4894mr368757181cf.19.1777294004003;
        Mon, 27 Apr 2026 05:46:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:32 +0200
Subject: [PATCH v2 05/14] media: qcom: camss: Add camss-isp-bufq helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-camss-isp-ope-v2-5-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: CRG-_eE8142bL1V_w3ehvlORVSZQfRbl
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef5ab8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jGd-OSDL_v5yqi5i-noA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX1D4egfoLXl30
 xOctBG5CQirB/73V6gRQd7Gl0KIxpOeTBl8rK40tDAz0SddSYkehOhVQx/5if5IL3m1V+29zWlH
 OHT5+G6UCDCYdEFjY2Jy2EsBkblAARtwyU2Hc++PX0U1hqanCCc6gi6ChNwtqtT+lBG+4HnwZLT
 f97kKgEt8PbyeIwYRIwDkmmnHWs1fUTqsuL+uXBHLqRzYJFGLYyj6ftFj2k+k3um0rimhls1Rc+
 KfcwfRfijaRmatNv1CI+O2D+3+dxuCKX7NBHXPysmyqzxrk5E1YCZGQ9znYxCsG4GEC0WlTYc6s
 DK2C89VAkn+qZi81z6UVyQTAy/qSS18EFeamoYDO16g7Rzx5MAIyxE73jdIpXIXgqtDlSdGsvuL
 8wozJxfUT4YcDNHsq4KmYWPRcAF5StcP6pcuKAugnGs42I1QP/msCTRya49b9BISuhMOCdYpTnJ
 S1mDDUT9yRxInLAhD5A==
X-Proofpoint-ORIG-GUID: CRG-_eE8142bL1V_w3ehvlORVSZQfRbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135

Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
buffers, one per queue index. This can help multi-queues management
and synchronization in ISP context.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Kconfig          |  14 +++
 drivers/media/platform/qcom/camss/Makefile         |   5 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-isp-bufq.h |  85 +++++++++++++++++
 4 files changed, 205 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/platform/qcom/camss/Kconfig
index 4eda48cb1adf049a7fb6cb59b9da3c0870fe57f4..d77482f3f5eadc65856806b9b237d65ea484f267 100644
--- a/drivers/media/platform/qcom/camss/Kconfig
+++ b/drivers/media/platform/qcom/camss/Kconfig
@@ -7,3 +7,17 @@ config VIDEO_QCOM_CAMSS
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_SG
 	select V4L2_FWNODE
+
+config VIDEO_QCOM_CAMSS_ISP
+	tristate "Qualcomm CAMSS ISP common helpers"
+	depends on VIDEO_DEV
+	depends on MEDIA_CONTROLLER
+	select V4L2_ISP
+	select VIDEOBUF2_CORE
+	help
+	  Common helper library for Qualcomm CAMSS offline ISP drivers.
+	  Provides buffer queue management, job scheduling, MC pipeline
+	  topology builder, and ISP parameter buffer parsing.
+
+	  This module is selected automatically by drivers that need it.
+
diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 5e349b4915130c71dbff90e73102e46dfede1520..bfc05db0eada1d801839ceb8a3b157baae613053 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -29,3 +29,8 @@ qcom-camss-objs += \
 		camss-format.o \
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
+
+qcom-camss-isp-objs := camss-isp-bufq.o
+
+obj-$(CONFIG_VIDEO_QCOM_CAMSS_ISP) += qcom-camss-isp.o
+
diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.c b/drivers/media/platform/qcom/camss/camss-isp-bufq.c
new file mode 100644
index 0000000000000000000000000000000000000000..b1dcf60afcc63d112eee7bd143f08a7b4aac9a18
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-isp-bufq.c
+ *
+ * CAMSS ISP per-queue ready-buffer FIFO.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "camss-isp-bufq.h"
+
+struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues)
+{
+	struct camss_isp_bufq *bufq;
+	unsigned int i;
+
+	bufq = kzalloc(struct_size(bufq, entries, num_queues), GFP_KERNEL);
+	if (!bufq)
+		return ERR_PTR(-ENOMEM);
+
+	bufq->num_queues = num_queues;
+
+	for (i = 0; i < num_queues; i++) {
+		INIT_LIST_HEAD(&bufq->entries[i].rdy_queue);
+		spin_lock_init(&bufq->entries[i].rdy_spinlock);
+	}
+
+	return bufq;
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_init);
+
+void camss_isp_bufq_release(struct camss_isp_bufq *bufq)
+{
+	kfree(bufq);
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_release);
+
+void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int queue_idx,
+			  struct vb2_v4l2_buffer *vbuf)
+{
+	struct camss_isp_buf *buf =
+		container_of(vbuf, struct camss_isp_buf, vb);
+	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
+	unsigned long flags;
+
+	spin_lock_irqsave(&entry->rdy_spinlock, flags);
+	list_add_tail(&buf->list, &entry->rdy_queue);
+	entry->num_rdy++;
+	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_queue);
+
+struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *bufq, unsigned int queue_idx)
+{
+	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
+	struct camss_isp_buf *buf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&entry->rdy_spinlock, flags);
+	buf = list_first_entry_or_null(&entry->rdy_queue,
+				       struct camss_isp_buf, list);
+	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
+
+	return buf ? &buf->vb : NULL;
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_next);
+
+struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *bufq, unsigned int queue_idx)
+{
+	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
+	struct camss_isp_buf *buf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&entry->rdy_spinlock, flags);
+	buf = list_first_entry_or_null(&entry->rdy_queue,
+				       struct camss_isp_buf, list);
+	if (buf) {
+		list_del(&buf->list);
+		entry->num_rdy--;
+	}
+	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
+
+	return buf ? &buf->vb : NULL;
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_remove);
+
+void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int queue_idx,
+			  enum vb2_buffer_state state)
+{
+	struct vb2_v4l2_buffer *vbuf;
+
+	while ((vbuf = camss_isp_bufq_remove(bufq, queue_idx)))
+		camss_isp_buf_done(vbuf, state);
+}
+EXPORT_SYMBOL_GPL(camss_isp_bufq_drain);
+
+MODULE_DESCRIPTION("CAMSS ISP per-queue ready-buffer FIFO");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.h b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
new file mode 100644
index 0000000000000000000000000000000000000000..2f04e38cb1cd198f180d744b0b9869b6f2b8ef46
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * camss-isp-bufq.h
+ *
+ * CAMSS ISP per-queue ready-buffer FIFO.
+ *
+ * Provides N spinlock-protected FIFO lists of ready vb2 buffers, one per
+ * queue index.  Drivers call these helpers from their vb2 ops and job
+ * completion paths.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef CAMSS_ISP_BUFQ_H
+#define CAMSS_ISP_BUFQ_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <media/videobuf2-v4l2.h>
+
+/**
+ * struct camss_isp_buf - vb2 buffer wrapper
+ *
+ * Use as vb2_queue.buf_struct_size so buffers can be placed on the
+ * ready lists managed by camss_isp_bufq.
+ *
+ * @vb:   The vb2 V4L2 buffer — must be first.
+ * @list: Entry in the per-queue ready list.
+ */
+struct camss_isp_buf {
+	struct vb2_v4l2_buffer	vb;	/* must be first */
+	struct list_head	list;
+};
+
+/**
+ * struct camss_isp_bufq_entry - per-queue ready-buffer state (opaque)
+ */
+struct camss_isp_bufq_entry {
+	struct list_head	rdy_queue;
+	spinlock_t		rdy_spinlock;
+	u32			num_rdy;
+};
+
+/**
+ * struct camss_isp_bufq - multi-queue ready-buffer state
+ *
+ * Allocate with camss_isp_bufq_init(), free with camss_isp_bufq_release().
+ *
+ * @num_queues: Number of entries in @entries.
+ * @entries:    Per-queue state; flexible array.
+ */
+struct camss_isp_bufq {
+	unsigned int			num_queues;
+	struct camss_isp_bufq_entry	entries[] __counted_by(num_queues);
+};
+
+struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues);
+void camss_isp_bufq_release(struct camss_isp_bufq *bufq);
+
+void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int queue_idx,
+			   struct vb2_v4l2_buffer *vbuf);
+
+struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *bufq,
+					     unsigned int queue_idx);
+
+struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *bufq,
+					       unsigned int queue_idx);
+
+void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int queue_idx,
+			   enum vb2_buffer_state state);
+
+static inline u32 camss_isp_bufq_num_ready(struct camss_isp_bufq *bufq,
+					    unsigned int queue_idx)
+{
+	return bufq->entries[queue_idx].num_rdy;
+}
+
+static inline void camss_isp_buf_done(struct vb2_v4l2_buffer *vbuf,
+				       enum vb2_buffer_state state)
+{
+	vb2_buffer_done(&vbuf->vb2_buf, state);
+}
+
+#endif /* CAMSS_ISP_BUFQ_H */

-- 
2.34.1

