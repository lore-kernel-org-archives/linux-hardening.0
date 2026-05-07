Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58493D47A2
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194220; cv=none; b=m5HVEVuPlWNitM8m9IsdmRUAhrYkkzixn1NZFPPzkFvfQRSBIEBE0qjdpAAfW6jxiCHE3GL/U2XmmrQx4sWaVl1Eijac/3+jXPsGLbbSosQmlSlZD+9JgLeLXQxQfSli1b9A1gByMWeo1ELlPf9pgvAjbydztirUTxWhSpxa6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194220; c=relaxed/simple;
	bh=7Krz7pN0WV1WEwE+SM/17Byvte7UfrNb2WulyP8M938=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KL2t4vweDo/aOsNxR4glQE8iILSWoUnqRDKGWPmY5p4CLgCZ3wUq0c3vVQ0K1pSYCBOKQYCCssVIewR5BRHkWt8zGp13Oitut34N5h8nFyz1sw4S8ej/h8nNA5cKndPAOglkF+PHOO06S7vonMCceDeWhDYsttQnlE4FYdk1aDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEqAB1J2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RX84c+y5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEqAB1J2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RX84c+y5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IBlCh2771502
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9MkPXhNFKpgj51RT3nXElFSkq09L7clUycFsPNU23WU=; b=aEqAB1J2DNsPcjx9
	jt6JhCscOwesf++9Opc/65eYqOp9+o9pH0P1OK0YX/DoQqFuGZkL6bKiMGyaGhBi
	PYIOBMk0+NKRy4Tc07QkEyMlUq3vNYLvjqJlmqHqwyLedYLUVGDy+dQOmVNMKj8m
	mHIa4qdfP9dcDxyrE0L0g8y0WhLJqpqMsJXW0Qa6W0Xw9uljkJ70x37gxigrp2ft
	MWo7nnRtFniQQMFnz7b2w6pA/+EYUq6F3cOvgdwXrb/ykr7CJPqHJdgbVw3MtgEu
	f4MPSYU8hA8KqaF7+CZV4meeTP7ow9Lss4NxwzHZVs3JtFCKDBC67E7ukK5cG97Y
	1N8SRQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5gumn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:17 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95cc77982c5so4277154241.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194217; x=1778799017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MkPXhNFKpgj51RT3nXElFSkq09L7clUycFsPNU23WU=;
        b=RX84c+y5180DBXRSkor5q/VBH98Zc5SnwB7x3xKVbxIEayRsx2JSYC434xN7OfTAIw
         8LQfeJ4544XSoh7IjBObFTtokzYachdLfh0OWVhN9JY9GjTh/4xTO/WtchVoe7aYY7u/
         WnZDkuDD/IrgMlikceSRDEBlwYfk6Ds+qWoBPvfTca6VtFlw73m1d8i3H4rfiyEaEcqD
         Kr7750m/nM3SNPwBvlPzhQRBeb0ipLHI9ftOcLYCkrGZihec5OpvYCTGUK7eUHPV9KyX
         4L3KV/VZJOXbowAZYvi0whJeHfltGeRqj+ya4Texw35MYLJyroyeBJ6AhF7qg8ydOifF
         Q4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194217; x=1778799017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9MkPXhNFKpgj51RT3nXElFSkq09L7clUycFsPNU23WU=;
        b=pBl6mvY6jae/gAIwj0W4SSmvYb4GDmg37kgr/LRA7B9yELpC7yjpDGrIPGtpvmFVRO
         7+MmGQLgkbw34B4xTaOC7EzfqJWjIvNEGe+X/dEmCvwiLVX++fAW1IzjEcWOZiTAQC29
         MrWOw/leY27tdkRjvlkjSmt35nFb1+9WW2JfxRGUpToZ3XEkjmX3qSNZrXUci+l3l1VH
         tYkjFOOphY1gP5wZoOfim5j+yXsngc4GHBRB63NsEd3fxFiZg1DaVn38m3/jdokUp0D5
         quCtLD1aIPlYB2Njxfs7bI+tmrrK28BwEmGKIGU7NOAX/zCGfa0M1tXWnOJoYOi3ICqN
         KGSg==
X-Forwarded-Encrypted: i=1; AFNElJ+E5LIF+yrnaIL6c0b4ItVvVFVdbUGLZfo5IsEUFQkjTVRELoOUyDj3Ua3v6Dd6jQJWhohTIlYe2fG0wV+NaCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sWnKbxWsrH91A8xATJN7uh0GyT4CNizikuDDWZ/C4KLfHjh8
	jsiGNnAyUJ2QoCTOUpB0oMcNcHANyfYmv6ADRD9PxvQim5G6wsBX60yCEvq5CP8naz2rrZTmXrE
	AXnlilYJCUTvx5Gf14HPsySCl7t0EH3FyO2fHt7vHELZNYQoT/+3hVvoKgRAiiXmA78i27UE=
X-Gm-Gg: AeBDiev+hEVBZ7t8Xh3yDozd89awyAAF3y2lHibXFhyB2I1gEhjbZZJiSfbQoN4/G6e
	0kONX+XhP/50tpZkvoBJD5BbMqbZEjMOg5vtCcsGJtqhVoqBHygHHDHvqSBUAHNocjFMk6R6TWq
	5xMnvCdO++7ithSisEGs22jSYpfaFlBP6GfENWHdsMa7K0aRXdSNK2sVrjFh/dYubKKGClGX6Yt
	uyIe9MpCrhEhWOZiDzuQWO3c0gHVZJlX+ojxFXBB6SRrTXHvnQUs3N3QK24ItLxW8eej00yUWDj
	CUkV1Ptc653DCxW9MoMwupmNlPeNwR42C8JOMtFPjopi7U7gQW8z7nd8FW/A4cJ28PI6AFdcrx0
	RZGiOgQm3fgphFFublzrzGL+jIQqp1p5FA3h1AHOBqyI4KaePJ2XUqkjjYQUgKiioj5baCXkZYd
	U29QY8rDj/pnoQcn7mQh3x1V5lIxs=
X-Received: by 2002:a05:6102:1497:b0:62f:4854:8c53 with SMTP id ada2fe7eead31-63115f8712cmr2441542137.12.1778194217108;
        Thu, 07 May 2026 15:50:17 -0700 (PDT)
X-Received: by 2002:a05:6102:1497:b0:62f:4854:8c53 with SMTP id ada2fe7eead31-63115f8712cmr2441524137.12.1778194216623;
        Thu, 07 May 2026 15:50:16 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:15 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:19 +0200
Subject: [PATCH v3 04/15] media: qcom: camss: Add camss-isp-bufq helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-camss-isp-ope-v3-4-bb1055274603@oss.qualcomm.com>
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
In-Reply-To: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
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
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fd1729 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Rj2g1MzNgR17_EpZbusA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: aVS-Ba5DXDlx5_NFUOQwkJGWPtUUuivV
X-Proofpoint-ORIG-GUID: aVS-Ba5DXDlx5_NFUOQwkJGWPtUUuivV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMSBTYWx0ZWRfXzoA6rfYBi4Ej
 TgBdMsDtAfRiFcnRflVSH35bTbYcAwnJBsq8FgmOH6vIFUiTbUT+F3IVBZdKMhve/wL3Ennc1C9
 Wq8lYK2q02pYH/Opty1MrfX1sGxXfKIiZijAYIzOmC5Y3lW8iymf/smoLGJnRFeeO3dazrrf6RO
 7fx/g51oMCpBEIx9Aq+cvLmg7LB44NhiQ2ksHKaM6AW5rC2TdSuWcNGKLcQc6Eot30NXVTPtTCB
 bExxxu3tii/lfRDztAO4fF68WXoQM2g7KDrxBwfR3fUIsfKjK29DNYmM1SUh+2X7nEBdaQ/7qxI
 g+/hmV9YQJbCHmcQF99SNcJCSS7K1cra4DtQ1XvYq25OLXlUk2hWGUjDIm/ADbkawGO4vxRCcND
 /+PBof0eQpm6+Rx8uNb8SyJ45s2U4cd7CVxoyXonCw6aZb6cKrPcmnl+Ih1CLxxoiDoWq5vk3co
 Lc3UamiW45erFVjE+BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070231

Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
buffers, one per queue index. This can help multi-queues management
and synchronization in ISP context.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Kconfig          |  14 +++
 drivers/media/platform/qcom/camss/Makefile         |   5 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 +++++++++++++++++
 drivers/media/platform/qcom/camss/camss-isp-bufq.h | 122 +++++++++++++++++++++
 4 files changed, 242 insertions(+)

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
index 0000000000000000000000000000000000000000..1a8bc7b112a1b039233cfc7be573f1f40fcda7c9
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
@@ -0,0 +1,122 @@
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
+/**
+ * camss_isp_bufq_init() - allocate a multi-queue ready-buffer state
+ * @num_queues: number of per-queue FIFO lists to create
+ *
+ * Returns a pointer to the new bufq or ERR_PTR on allocation failure.
+ */
+struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues);
+
+/**
+ * camss_isp_bufq_release() - free a bufq allocated with camss_isp_bufq_init()
+ * @bufq: bufq to free
+ */
+void camss_isp_bufq_release(struct camss_isp_bufq *bufq);
+
+/**
+ * camss_isp_bufq_queue() - append a buffer to the ready list for @queue_idx
+ * @bufq:      target bufq
+ * @queue_idx: queue index (must be < bufq->num_queues)
+ * @vbuf:      buffer to enqueue; must be embedded in a &struct camss_isp_buf
+ */
+void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int queue_idx,
+			   struct vb2_v4l2_buffer *vbuf);
+
+/**
+ * camss_isp_bufq_next() - peek at the head of the ready list without removing
+ * @bufq:      target bufq
+ * @queue_idx: queue index
+ *
+ * Returns the head buffer or NULL if the list is empty.
+ */
+struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *bufq,
+					     unsigned int queue_idx);
+
+/**
+ * camss_isp_bufq_remove() - dequeue and return the head of the ready list
+ * @bufq:      target bufq
+ * @queue_idx: queue index
+ *
+ * Returns the dequeued buffer or NULL if the list is empty.
+ */
+struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *bufq,
+					       unsigned int queue_idx);
+
+/**
+ * camss_isp_bufq_drain() - return all ready buffers with the given state
+ * @bufq:      target bufq
+ * @queue_idx: queue index
+ * @state:     vb2 state to pass to vb2_buffer_done() for each buffer
+ */
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

