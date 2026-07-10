Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC83DA7EC
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674301; cv=none; b=l1ROa66lkR1XoKGuB2uZ7+xDEYgPyFVwikrBpBGcJo+GO1ECukw2ezeZ4S3nrG7vsOYCA4xJps6D09KpwilNU2l60IjEX1jnYk4+RJ8j2W2lbqcGy4BPOduv128R2SMiZJAo4OnP5U2bjTCa/Z0WWcNRPwqhS+C9dGeRDnjy9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674301; c=relaxed/simple;
	bh=4EixHxIwIvTdS6db1jIzl2G1P8b1qVfh0RRT47S+Ffo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKO3I955zdJTYm3DDqePBVoDxJUgeDYR9VTZF+/0T0OFbY7zRAp3Hio+bSTW9VqpadEdkWGZzh7G7tRN4b2glSwbf1qQ97xkapm/CAMnMTonaQLog1zH23IXmj7VHVqiAhCTjutaOb23hSkIo40PV3hcHX2daSU2PvX7zm0Fog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSsYgEqo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vg+cli97; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSsYgEqo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vg+cli97"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dcJX040917
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gk7F2deuwS5Hpkt4gopFDx6kPDKlbTgeIq7RxuJd1Ac=; b=MSsYgEqoAmMIswjA
	zoDcbJUECXBTEnynPhlebOjs0vII5ilyvPd37IMJIr67ScqGjY31mUoGWU+xXUC6
	M3uvX2pOtuE9r0Uc2qV4VTg2uLHU14wtDIHtuWy/JWVxVVY/e+wNHfn3nGS+A2Ox
	TCljq0yClp4gF1cmhczWf4NDC8B1ISU6EdrDV9sbA1QMRYtoqlCTSj1MOVekql9W
	+fTBRaI3TTsXOsS78ZCwPDPO0WPMdKifHBJP9d4IovSzKfJgY0byELPCgUfb3UpG
	MKJiYFBkHntOnZ6h3wnxh43F1JJM5HVU1q8MvmhGozXiVvfsNCI3GtPOsrT0LBKN
	Z0skLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5kpu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:04:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso7835901cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674297; x=1784279097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gk7F2deuwS5Hpkt4gopFDx6kPDKlbTgeIq7RxuJd1Ac=;
        b=Vg+cli9729OVnct8Nr9TePS+dLJ66CM4pnmt3HpWzGJKcFx/NNxNtnDfam1TB3tehc
         7v0dOD9iKek5lNLTuaiFQYQ4udx+ROVntYYIEps9oPEwrVzUHCj2W7lnZXvTgNj07+ct
         TbDbJgzHxjPICY8Xozaq5W6Pb4RslYBW66Y67K0Q9EdJ/LBgyS2eO5WE1UeAMCfXK+mf
         t2EvynrBY5WqmZK79/z3/yNRic+jwgTGI6D0MtTkwsL9P5NPSpP025GSFrQLhXOoMxfX
         F3r3NWc6mHnzElHqousH1WX8QjPrx/cGEaKmP6LojmO0R4B7kThsyyVolWx7qKePXvst
         6Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674297; x=1784279097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gk7F2deuwS5Hpkt4gopFDx6kPDKlbTgeIq7RxuJd1Ac=;
        b=C5vpn/u60IU/CXBZt1Ev6TN/u/MpWEmo/nmFOuR4RpqTlpIZZz0H9kPnCgFccgKMwh
         CoknZ1yNUL8MQCu9uaeBS8cXJNya/4nSei9SaiG6/drL0ZI8iFdC6hs2ROlyZ8vgATCo
         IIU+7q+58XVGxkv1f6guSWfZ7KEjor4FvJrxmx4K1cbjx8hBsrgW8y8hagOco6Y1F4wt
         ERbZuGLmeV/Xb06RHhzRUsg9uCxqpvWHZFr9OSuhL8IgbIO8VItK1z4/+4nieAyKLWld
         KEjre1GQE/Os9n6HGrX1Ws2264Zi5KQEXLuQ/weMFaMBt9X8ySrXFiCbv1H44bQimShR
         Omog==
X-Forwarded-Encrypted: i=1; AHgh+Rr3V/6FnZlUOFTrEsQbvMYLNsTPKymw4VPGVSdrMzMVMKDyzZro1LclPOtIJxWIH4AK+nvW+S1bEQAvMQ1oW7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02tbazoYXmTjYSaAEEuWosGftkMnep538kfzcv7q8Lxi0W/F4
	sR25Dg0ouEUYN7+loK8jm8lZtPp2qwi7EKCcyuaXIQRUHXcYd+MRCgZM2yzlVjmZNUyvQB/VWZV
	h9YyKyTqNizw+ePp50GFNgUzY+iXRvV1JAzvzfochnR9m4QSaIz844U7V6W/Cmwn7MhfZnCk=
X-Gm-Gg: AfdE7cneMjxr7DnO3DmEvkTv5lcqIm0hwxvk1Lh0TjbM0m4kTbdIvCbLMg8EdrP93iC
	UNwje24ZdBNne28DPPPkzGNf+B5/OrO/UFJCNCkyl2UmutC10ww+xPgv9rdxzunr98NW8a0FFEG
	GV10h6Tkx/xkEh1Qryp/3R2qYL00ExtZfB5S4LICWXWlstpeJWKy45NJ2Z+76N8t14IEOMsFhqz
	OZ3t55slYpLPgVaiIGx2h267Y647LTPaCfvrzvRHIoWhKfD0mj8IY2H3cb11iFr8up/wcpGlx3L
	0WNH9XGXjUX7rgZFCaH5loeQqFn18QRVFcILsCv9nxF28ePDIidlMCAb2h9KyC1GQH91ZIdyFBG
	P91PP5xMCxMOVKr2bKzbbhiJvIUtteIHdggJ3yZV7gIaZaaPaaL+Pmez5YaLvzihy+fJ/R7bb0E
	yCZEo+GBHGqbucsxBWeOt8M1IfBlp3XtIgEE3rTGLb41OH21QV6PDxY8u40Ni+Mw==
X-Received: by 2002:a05:622a:a0b:b0:51c:ebd:fb40 with SMTP id d75a77b69052e-51c8b2e3a0fmr110685271cf.31.1783674296452;
        Fri, 10 Jul 2026 02:04:56 -0700 (PDT)
X-Received: by 2002:a05:622a:a0b:b0:51c:ebd:fb40 with SMTP id d75a77b69052e-51c8b2e3a0fmr110684991cf.31.1783674295724;
        Fri, 10 Jul 2026 02:04:55 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:04:54 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:47 +0200
Subject: [PATCH v4 1/7] media: qcom: camss: Add camss-pipeline helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-camss-isp-ope-v4-1-51207a0319d8@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a50b5b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nv4yEDu1kATSZ9vQL9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX3DjL5MNCs6Xo
 Q5GJM8cl9lgRW+tJDhUJMHZtGtHXsq+QXwr81kZwVDyeL3ljDlHdk6q5nt6Zxh2hUkN0F6nD7kq
 MF34hJAYfkyo2MWEnj+JnMqJZ/N21jU=
X-Proofpoint-ORIG-GUID: fJ6R0Fb1fUlBmmXJzY8E4NfvWrTBRTeB
X-Proofpoint-GUID: fJ6R0Fb1fUlBmmXJzY8E4NfvWrTBRTeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfXw/sSzbx795UD
 0GVtQrJXYbxMCvLAhr2c/advW4GzXsmYTn+VgX4JFw7pE6mNIiuoo46AeUBztVlrKivcyHPUn0/
 3o0KVjygD6ZA9VUZsH2d4uu8AdsyhGkuKzrvLpHq4ewHm+U9/+wJWZyZKAoez7FyUGAY525wYOz
 9pqA1IIbEY2yWjhhT+JRxsMxnl9T7IKI0Bv1ELuXmF8HuMNStDwW1g7jIZ4wp2j2LmtVrpFomB3
 uepAwpXbyaF24abvK11MgaVw0fgglC6aiVQros0AJtCWeuv4OADp+btDid13z3/uKumHsGos8/o
 8ZLZhCUaAMPdAgWEZ+zwY+l7mJ+Y/mXbXnfK4sd4islZ85SAh8jOucrF5cOYK/znjDM0CegRONK
 DshkoOcE38P83y0yCTFWqKsYyUo54vaupQshsozqSXFnnY4pLHYuFm6JnIJk5xlPirNE6ddIK4U
 fyfHqhj6yYpOZzQz82A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100088

Add a declarative MC topology builder for CAMSS offline ISP drivers.
Drivers describe their entire media graph, entities (video devices,
subdevs, or base entities), their pads, and the links between them
in a static descriptor table. The builder validates the table,
allocates and registers all entities, and creates all MC pad links.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile         |   1 +
 drivers/media/platform/qcom/camss/camss-pipeline.c | 386 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-pipeline.h | 232 +++++++++++++
 3 files changed, 619 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 5e349b4915130c71dbff90e73102e46dfede1520..0d133ddc08be088678994820c0ac64e761884611 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -27,5 +27,6 @@ qcom-camss-objs += \
 		camss-vfe.o \
 		camss-video.o \
 		camss-format.o \
+		camss-pipeline.o \
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
diff --git a/drivers/media/platform/qcom/camss/camss-pipeline.c b/drivers/media/platform/qcom/camss/camss-pipeline.c
new file mode 100644
index 0000000000000000000000000000000000000000..3cdc0df7123d718efc0ad0c6d01a25fb13cf6ca9
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-pipeline.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CAMSS ISP pipeline helper — declarative MC topology builder
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/slab.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include "camss-pipeline.h"
+
+#if !IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
+static inline int media_entity_pads_init(struct media_entity *e, u16 n,
+					 struct media_pad *p) { return 0; }
+static inline void media_entity_remove_links(struct media_entity *e) {}
+static inline int media_create_pad_link(struct media_entity *src, u16 sp,
+					struct media_entity *sink, u16 dp,
+					u32 flags) { return 0; }
+#endif
+
+/* -------- Internal elpers -------- */
+
+static enum vfl_devnode_direction isp_caps_to_vfl_dir(u32 caps)
+{
+	if (caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
+		return VFL_DIR_M2M;
+	if (caps & (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+		    V4L2_CAP_META_OUTPUT | V4L2_CAP_VBI_OUTPUT | V4L2_CAP_SDR_OUTPUT))
+		return VFL_DIR_TX;
+	return VFL_DIR_RX;
+}
+
+static unsigned int isp_count_pads(const struct camss_isp_pad_desc *pads)
+{
+	unsigned int n = 0;
+
+	if (!pads)
+		return 0;
+	while (pads[n].flags)
+		n++;
+	return n;
+}
+
+static struct media_entity *isp_pipeline_media_entity(struct camss_isp_pipeline *pipeline,
+						      unsigned int idx)
+{
+	struct camss_isp_pipeline_entity *slot = &pipeline->entities[idx];
+
+	switch (slot->obj_type) {
+	case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+		return &slot->vdev.entity;
+	case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+		return &slot->subdev.entity;
+	default:
+		return &slot->entity;
+	}
+}
+
+/* -------- Validation -------- */
+
+static int isp_pipeline_validate(struct device *dev,
+				 const struct camss_isp_entity_desc *descs,
+				 unsigned int num_entities)
+{
+	unsigned int i, pi;
+
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_pad_desc *pads = descs[i].pads;
+		unsigned int num_pads = isp_count_pads(pads);
+
+		for (pi = 0; pi < num_pads; pi++) {
+			const struct camss_isp_pad_desc *pad = &pads[pi];
+			const struct camss_isp_pad_desc *peer_pad;
+			unsigned int peer_num_pads;
+			int peer_ent = pad->peer_entity;
+
+			if (peer_ent < 0)
+				continue;
+
+			if ((unsigned int)peer_ent >= num_entities) {
+				dev_err(dev, "entity[%u].p%u: peer_entity %d out of range\n",
+					i, pi, peer_ent);
+				return -EINVAL;
+			}
+
+			peer_num_pads = isp_count_pads(descs[peer_ent].pads);
+			if (pad->peer_pad >= peer_num_pads) {
+				dev_err(dev, "entity[%u].p%u: peer_pad %u out of range\n",
+					i, pi, pad->peer_pad);
+				return -EINVAL;
+			}
+
+			peer_pad = &descs[peer_ent].pads[pad->peer_pad];
+
+			/* Links are SOURCE->SINK; reject SOURCE->SOURCE or SINK->SINK */
+			if (((pad->flags & MEDIA_PAD_FL_SOURCE) &&
+			     (peer_pad->flags & MEDIA_PAD_FL_SOURCE)) ||
+			    ((pad->flags & MEDIA_PAD_FL_SINK) &&
+			     (peer_pad->flags & MEDIA_PAD_FL_SINK))) {
+				dev_err(dev, "entity[%u].p%u -> entity[%d].p%u: invalid\n",
+					i, pi, peer_ent, pad->peer_pad);
+				return -EINVAL;
+			}
+
+			/* Verify back-reference consistency */
+			if (peer_pad->peer_entity >= 0 &&
+			    ((unsigned int)peer_pad->peer_entity != i ||
+			     peer_pad->peer_pad != pi)) {
+				dev_err(dev, "entity[%u].p%u <-> entity[%d].p%u: mismatch\n",
+					i, pi, peer_ent, pad->peer_pad);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* -------- Allocation / Release -------- */
+
+struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_entities)
+{
+	struct camss_isp_pipeline *pipeline;
+
+	pipeline = kzalloc(struct_size(pipeline, entities, num_entities),
+			   GFP_KERNEL);
+	if (!pipeline)
+		return ERR_PTR(-ENOMEM);
+
+	pipeline->num_entities = num_entities;
+	return pipeline;
+}
+EXPORT_SYMBOL_GPL(camss_isp_pipeline_alloc);
+
+void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline)
+{
+	kfree(pipeline);
+}
+EXPORT_SYMBOL_GPL(camss_isp_pipeline_free);
+
+/* -------- Registration -------- */
+
+void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline)
+{
+	int i;
+
+	/* Unregister entities in reverse order */
+	for (i = (int)pipeline->num_entities - 1; i >= 0; i--) {
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		switch (slot->obj_type) {
+		case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+			if (slot->vdev.name[0])
+				video_unregister_device(&slot->vdev);
+			break;
+		case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+			if (slot->subdev.name[0]) {
+				v4l2_subdev_cleanup(&slot->subdev);
+				v4l2_device_unregister_subdev(&slot->subdev);
+			}
+			break;
+		case MEDIA_ENTITY_TYPE_BASE:
+			if (slot->entity.name) {
+				media_entity_remove_links(&slot->entity);
+				media_device_unregister_entity(&slot->entity);
+			}
+			break;
+		}
+
+		kfree(slot->pads);
+		slot->pads = NULL;
+	}
+
+	pipeline->v4l2_dev = NULL;
+}
+EXPORT_SYMBOL_GPL(camss_isp_pipeline_unregister);
+
+static int isp_register_vdev(struct camss_isp_pipeline_entity *slot,
+			     const struct camss_isp_entity_desc *desc,
+			     struct v4l2_device *v4l2_dev)
+{
+	struct video_device *vdev = &slot->vdev;
+	int ret;
+
+	strscpy(vdev->name, desc->name, sizeof(vdev->name));
+	vdev->vfl_dir     = isp_caps_to_vfl_dir(desc->vdev.caps);
+	vdev->v4l2_dev    = v4l2_dev;
+	vdev->device_caps = desc->vdev.caps | V4L2_CAP_IO_MC;
+	vdev->release     = video_device_release_empty;
+	if (desc->vdev.fops)
+		vdev->fops = desc->vdev.fops;
+	if (desc->vdev.ioctl_ops)
+		vdev->ioctl_ops = desc->vdev.ioctl_ops;
+	if (desc->vdev.entity_ops)
+		vdev->entity.ops = desc->vdev.entity_ops;
+
+	vdev->entity.obj_type = MEDIA_ENTITY_TYPE_VIDEO_DEVICE;
+	vdev->entity.function = desc->function ? desc->function : MEDIA_ENT_F_IO_V4L;
+
+	ret = media_entity_pads_init(&vdev->entity, slot->num_pads, slot->pads);
+	if (ret)
+		return ret;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret)
+		return ret;
+
+	video_set_drvdata(vdev, desc->vdev.drvdata);
+
+	return 0;
+}
+
+static int isp_register_subdev(struct camss_isp_pipeline_entity *slot,
+			       const struct camss_isp_entity_desc *desc,
+			       struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &slot->subdev;
+	int ret;
+
+	v4l2_subdev_init(sd, desc->subdev.ops);
+	strscpy(sd->name, desc->name, sizeof(sd->name));
+	sd->entity.function = desc->function ?
+			      desc->function : MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
+	/* Create a /dev/v4l-subdevN node so userspace can query pad formats */
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	if (desc->subdev.internal_ops)
+		sd->internal_ops = desc->subdev.internal_ops;
+	if (desc->subdev.entity_ops)
+		sd->entity.ops = desc->subdev.entity_ops;
+
+	ret = media_entity_pads_init(&sd->entity, slot->num_pads, slot->pads);
+	if (ret)
+		return ret;
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret) {
+		v4l2_device_unregister_subdev(sd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int isp_register_base_entity(struct camss_isp_pipeline_entity *slot,
+				    const struct camss_isp_entity_desc *desc,
+				    struct v4l2_device *v4l2_dev)
+{
+	struct media_entity *entity = &slot->entity;
+	int ret;
+
+	entity->obj_type = MEDIA_ENTITY_TYPE_BASE;
+	entity->name     = desc->name;
+	entity->function = desc->function;
+
+	ret = media_entity_pads_init(entity, slot->num_pads, slot->pads);
+	if (ret)
+		return ret;
+
+	return media_device_register_entity(v4l2_dev->mdev, entity);
+}
+
+static int isp_alloc_pads(struct camss_isp_pipeline_entity *slot,
+			  const struct camss_isp_entity_desc *desc)
+{
+	unsigned int num_pads = isp_count_pads(desc->pads);
+	unsigned int i;
+
+	if (!num_pads)
+		goto done;
+
+	slot->pads = kcalloc(num_pads, sizeof(*slot->pads), GFP_KERNEL);
+	if (!slot->pads)
+		return -ENOMEM;
+
+	for (i = 0; i < num_pads; i++)
+		slot->pads[i].flags = desc->pads[i].flags;
+done:
+	slot->num_pads = num_pads;
+	return 0;
+}
+
+int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
+				struct v4l2_device *v4l2_dev,
+				const struct camss_isp_entity_desc *descs,
+				unsigned int num_entities)
+{
+	unsigned int i, pi;
+	int ret;
+
+	if (WARN_ON(num_entities != pipeline->num_entities))
+		return -EINVAL;
+
+	if (WARN_ON(!v4l2_dev || !v4l2_dev->mdev))
+		return -EINVAL;
+
+	ret = isp_pipeline_validate(v4l2_dev->dev, descs, num_entities);
+	if (ret)
+		return ret;
+
+	pipeline->v4l2_dev = v4l2_dev;
+
+	/* Register each entity */
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_entity_desc *desc = &descs[i];
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		slot->obj_type = desc->obj_type;
+
+		ret = isp_alloc_pads(slot, desc);
+		if (ret)
+			goto err_unregister;
+
+		switch (desc->obj_type) {
+		case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+			ret = isp_register_vdev(slot, desc, v4l2_dev);
+			break;
+		case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+			ret = isp_register_subdev(slot, desc, v4l2_dev);
+			break;
+		case MEDIA_ENTITY_TYPE_BASE:
+		default:
+			ret = isp_register_base_entity(slot, desc, v4l2_dev);
+			break;
+		}
+		if (ret)
+			goto err_unregister;
+	}
+
+	/* Create links — only from SOURCE side to avoid duplicates */
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_entity_desc *desc = &descs[i];
+		unsigned int num_pads = isp_count_pads(desc->pads);
+
+		for (pi = 0; pi < num_pads; pi++) {
+			const struct camss_isp_pad_desc *pad = &desc->pads[pi];
+			struct media_entity *src_entity, *sink_entity;
+			unsigned int src_pad_idx, sink_pad_idx;
+			u32 lflags;
+
+			if (!(pad->flags & MEDIA_PAD_FL_SOURCE))
+				continue;
+			if (pad->peer_entity < 0)
+				continue;
+
+			src_entity   = isp_pipeline_media_entity(pipeline, i);
+			sink_entity  = isp_pipeline_media_entity(pipeline,
+								 (unsigned int)pad->peer_entity);
+			src_pad_idx  = pi;
+			sink_pad_idx = pad->peer_pad;
+
+			lflags = pad->link_flags ?
+				 pad->link_flags :
+				 (MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+
+			ret = media_create_pad_link(src_entity,  src_pad_idx,
+						    sink_entity, sink_pad_idx,
+						    lflags);
+			if (ret)
+				goto err_unregister;
+		}
+	}
+
+	/* Create /dev/v4l-subdevN nodes for all registered subdevs */
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	camss_isp_pipeline_unregister(pipeline);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(camss_isp_pipeline_register);
+
+MODULE_DESCRIPTION("CAMSS ISP pipeline topology builder");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/qcom/camss/camss-pipeline.h b/drivers/media/platform/qcom/camss/camss-pipeline.h
new file mode 100644
index 0000000000000000000000000000000000000000..e3082fb138a141f0955c6c74200143c4550419ae
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-pipeline.h
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CAMSS ISP pipeline helper — declarative MC topology builder
+ *
+ * Drivers describe their entire media graph — entities (video devices,
+ * subdevs, or base entities), their pads, and the links between them —
+ * in a single static descriptor table.  The builder validates the table,
+ * allocates and registers all entities, and creates all MC links.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _CAMSS_PIPELINE_H
+#define _CAMSS_PIPELINE_H
+
+#include <linux/mutex.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+/**
+ * struct camss_isp_pad_desc - descriptor for one pad and its optional link
+ *
+ * @flags:       Pad flags: MEDIA_PAD_FL_SINK, MEDIA_PAD_FL_SOURCE,
+ *               MEDIA_PAD_FL_MUST_CONNECT.  A zero @flags value acts as
+ *               the sentinel that terminates the pad list.
+ * @peer_entity: Index of the peer entity in the descriptor array, or -1
+ *               if this pad has no link.
+ * @peer_pad:    Pad index on the peer entity to link to.
+ * @link_flags:  MC link flags (MEDIA_LNK_FL_*).  Defaults to
+ *               MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED when zero.
+ *
+ * Links are described from both sides (each endpoint references the other),
+ * but the builder only creates each link once — from the SOURCE side.
+ */
+struct camss_isp_pad_desc {
+	u32          flags;
+	int          peer_entity;
+	unsigned int peer_pad;
+	u32          link_flags;
+};
+
+/**
+ * struct camss_isp_entity_desc - descriptor for one entity in the pipeline
+ *
+ * @name:      Human-readable entity name (also used as video device name
+ *             suffix when @obj_type is MEDIA_ENTITY_TYPE_VIDEO_DEVICE).
+ * @obj_type:  MEDIA_ENTITY_TYPE_VIDEO_DEVICE, MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
+ *             or MEDIA_ENTITY_TYPE_BASE.
+ * @function:  MEDIA_ENT_F_* function identifier.
+ * @pads:      Sentinel-terminated (flags == 0) array of pad descriptors.
+ *
+ * Fields used only for MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+ * @vdev.caps: V4L2_CAP_* device capabilities.
+ *             The video device direction (VFL_DIR_RX/TX/M2M) is derived
+ *             automatically from @caps by the builder.
+ * @vdev.drvdata: Opaque pointer set via video_set_drvdata() after registration.
+ * @vdev.fops:      File operations (may be NULL to use kernel defaults).
+ * @vdev.ioctl_ops: ioctl operations (may be NULL).
+ *
+ * Fields used only for MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+ * @subdev.ops: Subdev operations (may be NULL).
+ * @subdev.internal_ops: Internal subdev operations (may be NULL).
+ */
+struct camss_isp_entity_desc {
+	const char				*name;
+	u32					obj_type;
+	u32					function;
+	const struct camss_isp_pad_desc		*pads;
+
+	union {
+		/* MEDIA_ENTITY_TYPE_VIDEO_DEVICE */
+		struct {
+			u32					caps;
+			void					*drvdata;
+			const struct v4l2_file_operations	*fops;
+			const struct v4l2_ioctl_ops		*ioctl_ops;
+			const struct media_entity_operations	*entity_ops;
+		} vdev;
+		/* MEDIA_ENTITY_TYPE_V4L2_SUBDEV */
+		struct {
+			const struct v4l2_subdev_ops		*ops;
+			const struct v4l2_subdev_internal_ops	*internal_ops;
+			const struct media_entity_operations	*entity_ops;
+		} subdev;
+	};
+};
+
+/**
+ * struct camss_isp_pipeline_entity - one registered entity slot
+ *
+ * Internal to the pipeline; drivers access entities via the accessor helpers.
+ *
+ * @obj_type: mirrors the descriptor's @obj_type.
+ * @pads:     allocated pad array for this entity.
+ * @num_pads: number of entries in @pads.
+ * @vdev:     valid when @obj_type == MEDIA_ENTITY_TYPE_VIDEO_DEVICE.
+ * @subdev:   valid when @obj_type == MEDIA_ENTITY_TYPE_V4L2_SUBDEV.
+ * @entity:   valid when @obj_type == MEDIA_ENTITY_TYPE_BASE.
+ */
+struct camss_isp_pipeline_entity {
+	u32			 obj_type;
+	struct media_pad	*pads;
+	unsigned int		 num_pads;
+	union {
+		struct video_device  vdev;
+		struct v4l2_subdev   subdev;
+		struct media_entity  entity;
+	};
+};
+
+/**
+ * struct camss_isp_pipeline - registered ISP pipeline topology
+ *
+ * Allocate with camss_isp_pipeline_alloc(), register with
+ * camss_isp_pipeline_register(), tear down with
+ * camss_isp_pipeline_unregister(), free with camss_isp_pipeline_free().
+ *
+ * @v4l2_dev:     Pointer to the caller-provided V4L2 device.
+ * @drv_priv:     Driver-private pointer; not touched by the framework.
+ * @num_entities: Number of entries in @entities.
+ * @entities:     Per-entity state; flexible array.
+ */
+struct camss_isp_pipeline {
+	struct v4l2_device	*v4l2_dev;
+	void			*drv_priv;
+
+	unsigned int		 num_entities;
+	struct camss_isp_pipeline_entity entities[] __counted_by(num_entities);
+};
+
+/**
+ * camss_isp_pipeline_alloc() - allocate a pipeline for @num_entities entities
+ *
+ * Returns a pointer to the new pipeline or ERR_PTR on failure.
+ * Free with camss_isp_pipeline_free() if never registered, or call
+ * camss_isp_pipeline_unregister() followed by camss_isp_pipeline_free().
+ */
+struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_entities);
+
+/**
+ * camss_isp_pipeline_free() - free an unregistered pipeline
+ * @pipeline: pipeline to free (may be NULL)
+ */
+void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline);
+
+/**
+ * camss_isp_pipeline_register() - validate descriptors and register the graph
+ * @pipeline:    pipeline (allocated with camss_isp_pipeline_alloc())
+ * @v4l2_dev:    caller-owned and already-registered V4L2 device; its
+ *               associated media_device (v4l2_dev->mdev) must also be
+ *               initialised and registered before this call.
+ * @descs:       array of @num_entities entity descriptors
+ * @num_entities: number of entities; must equal pipeline->num_entities
+ *
+ * Validates the descriptor table (link direction consistency, index bounds),
+ * then registers all entities into the provided v4l2_device / media_device
+ * and creates all MC pad links.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
+				struct v4l2_device *v4l2_dev,
+				const struct camss_isp_entity_desc *descs,
+				unsigned int num_entities);
+
+/**
+ * camss_isp_pipeline_unregister() - tear down a registered pipeline
+ * @pipeline: pipeline to unregister
+ */
+void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline);
+
+/**
+ * camss_isp_pipeline_get_vdev() - return the video_device for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_VIDEO_DEVICE)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a video device.
+ */
+static inline struct video_device *
+camss_isp_pipeline_get_vdev(struct camss_isp_pipeline *pipeline,
+			    unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_VIDEO_DEVICE))
+		return NULL;
+	return &pipeline->entities[idx].vdev;
+}
+
+/**
+ * camss_isp_pipeline_get_subdev() - return the v4l2_subdev for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_V4L2_SUBDEV)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a subdev.
+ */
+static inline struct v4l2_subdev *
+camss_isp_pipeline_get_subdev(struct camss_isp_pipeline *pipeline,
+			      unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_V4L2_SUBDEV))
+		return NULL;
+	return &pipeline->entities[idx].subdev;
+}
+
+/**
+ * camss_isp_pipeline_get_entity() - return the media_entity for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_BASE)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a base entity.
+ */
+static inline struct media_entity *
+camss_isp_pipeline_get_entity(struct camss_isp_pipeline *pipeline,
+			      unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_BASE))
+		return NULL;
+	return &pipeline->entities[idx].entity;
+}
+
+#endif /* _CAMSS_PIPELINE_H */

-- 
2.34.1

