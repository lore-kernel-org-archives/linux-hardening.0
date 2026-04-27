Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F83C060E
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294015; cv=none; b=KgX+yqKcYo/mn+HaI9KKlhWop8CECapQ82VOhzdPHXeM7eJEuZDOkJd/p1VHP+9zvEOBcLwwMyiZbm5/azq43DCJJDn0Seph6Ks8msEl6PSGGIV1/1oJWSvX3ICZ6vDQT354I0YA7QZWKld+qSjxA7+0veKlZDA2ReaqrIGefFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294015; c=relaxed/simple;
	bh=KTYQxoDHRK+AaxLzVW7P0uYiEE/yFjt5Rigb2R9yyTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCRnzliHfPvAz+jZLyld/AUxxCBbcWwwNVbb9QqW6k4MyA1n1AmxhCztRZl1tR/2yX/c4ZqZI9UYyGMerB5h69VFHVnJhYNfvmzjPsnkO1aTk0EM4G0Qmq8nOsX466+EBabRdTHT9ir4Oxg0iP06m3hEXX/EHVy7Pd3j1Aokn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxzE5sKU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eiagujgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxzE5sKU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eiagujgi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9Oc2n3825223
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gnBfolT3jX6CNISr4JxMcRA7ySnkS3THYsCQYykqpxA=; b=WxzE5sKUJY2CJxiK
	nESqJSdcWh/FJc+J3JBtN8HnTz1fuuzS2hrg2UBweobcL19MDT/Ouoo/xFeQd3ef
	brOpMDIlzKWfnwMzo0vpi96xZNEYl3/6sFYyfM3JpDQwuo17LIbvTzSYExoOtuOx
	w/UGwb+fLTsRArABEHW8tBnA9/yv7t73qemSza51qf4KcM5QKRNW0BkWiCAHw/XR
	rbmYp7hgCbOvaLbsjXY6PLz/OsVyAH78giWn9zdIk59Kw0W0glVd/Dbmxu7KposP
	48DeUl1MXSf+mwNN8sNf6FZBBX3F4//h/6Ub13Z2qk9IobI5uozO2qGEsLUMfbqc
	ieehiQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5550r2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d9a6a853bso143495421cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294012; x=1777898812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnBfolT3jX6CNISr4JxMcRA7ySnkS3THYsCQYykqpxA=;
        b=Eiagujgi36awTPYrqmRdkgP6OU+ORKOONattM93eKzMuWQOYUkncHbu2czqXE0FikC
         1nzb/NaoPYD9OuRu6Fi6sUA9IIcsbvZz2+jYtTf0iQnP5rfBBqpzuESUl4knkuLUpbkk
         oo1t4YinT12rgK9ig+igwq8TslHxiO2CrbAJLNPQRjEhdOeIKofSTXGyXOPvA2WskqYi
         XSulytnKA/Q2u9KxiZKENzeaHlpNZRHdumLZENklZxNExhO1aI6zUkyUn5lbqeCj6UAV
         4c8bq4shcRPJhHHcu5ykPpdRRuG6UI60NzCyXwKfqt3g7bs8kkaseDI+wZW+YUqL7pon
         DxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294012; x=1777898812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnBfolT3jX6CNISr4JxMcRA7ySnkS3THYsCQYykqpxA=;
        b=oUJu0VGOnYoOteVPI90JPyrvgpZt3ArP7EAuGj0Y21QEifxNeAptiZtI47Is5tdD+S
         NQD5ccEL/SkMHMwUvBAHz1EzbYXIaYT7sP7A0XQT1LSUBw2iP03cM+Dl3L19hI79aQVp
         BiCXHPwnjsJUhoBymKBC8ZFROgCIYfOK0Ft5G4X5Pblw8d2yO50mUiCsTYdajmEZJXGk
         iN3fm0zJsjupHD76aX9FIBFeRR5lHmOUH+gk5+/oGHjeC1+f7bLq8eRY0w8BU+y+LGBK
         xlbG44bBF7zP25NDkokveKxwNy6lLiwt8AgweGjhafm4Hg8Jy6nBZGZf6b+bstzEi2t9
         fxww==
X-Forwarded-Encrypted: i=1; AFNElJ/GHs5P8FqTJozpgOL7SZ8oMi52lOU86POks2Yb1PooFn6OmX/RvzcDwdU3zYlkUa8zeSOy59/zO7b4HTdf9Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt+Y5qOrmGjz89WtLugMfD7gLi76Wqa7U9mJG8VlCdWF6PDfR
	2MSswM9irswyQmQf1liqXxtVfK4Tgx1sDMHnSAC0tYxkJrezTHWDYuzpIe61K+pu1VzchSwx4o8
	tpndD3asM/g/1RwycYOq5d1HcP/Ym8TD5iGVczhu5mIHYGhfG78DI69vtJLYhVB/QPuooky0=
X-Gm-Gg: AeBDiev8VpmXVSDTLaYKW2fXDvZJBnEjP98JLqMZO3HO1sprFBO1B2zkowc6KUIB9oY
	8anq00P3OTCTLgL8fDvxQ7WPTyGgePgF8Ybp31faHbfAvM/uQWVB5E+LdCHzFyaf9fTaGZRtK0B
	U9hExXvxLrdNM7F9JTgfKqR0O1KkC8wRtjuyHq8QJMghbor7Or9hVOeIv7/oviGSTeab0oGCH3p
	TFtB4tueBNu0juAKDd6bhq0e7j4KZxiKQPas2/pfiI2t8eeXMTYKPpio85fLuBkBVqlZxuCD91c
	CRq3tCt+pEe40/5Wilw3T51hkA5Uu3k1gRlxZ1TJTd4CN8A58lStv/E3CF5+nwKYsMUzksz/OZO
	pSiNnU2oKOW+osNXVBv0EBE8yh/qyygbHw8fcyUbZpxPGgxeputCMSZFiqLjDzyFxUt8aTJB0au
	3cYbNrBqDlOFTF28rXdoqc136+6Kg=
X-Received: by 2002:ac8:5895:0:b0:50d:ce35:6e67 with SMTP id d75a77b69052e-50e36eba371mr600763591cf.42.1777294011621;
        Mon, 27 Apr 2026 05:46:51 -0700 (PDT)
X-Received: by 2002:ac8:5895:0:b0:50d:ce35:6e67 with SMTP id d75a77b69052e-50e36eba371mr600763061cf.42.1777294011031;
        Mon, 27 Apr 2026 05:46:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:36 +0200
Subject: [PATCH v2 09/14] media: qcom: camss: Add camss-isp-params helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-9-f430e7485009@oss.qualcomm.com>
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
X-Proofpoint-GUID: rPt729LPDkh8I_QENs5s2pGd9qwwHey6
X-Authority-Analysis: v=2.4 cv=CJEamxrD c=1 sm=1 tr=0 ts=69ef5abc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ELVW7ba-Z2avb-AJsJIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX58dcMmJ+GXEe
 OESivSLWPTNrJK6TkSqjknuyqi2XQYUU2UdFFrFWzE21c4H//nBbmZ5qXDP9qEosFmrPtcJwxn/
 aowlabIj16BuEj44MEQ2yg/d6FjWsVYisZ2hQk1uyBLyqQgUIa73v62tiX2q2pXWMD/3e2KKP7h
 LJpH54rCfabv1V3bbnx/ajclvAyxj5CpwlcJj58ePRU+zBLiG8QiXvFeeTSoC8VbD0DrAwFffox
 wyeyjxcFvUMDxqsGOsRoZbkuO/ZLGk+7DdX7wAlI3Zn2l4FNN+MzQBhqusIKlXFKKX95f/7y6a8
 3YXkSxk0pRvh1hzWeQizwWg0klX6ryN6lWEYqNB15irUw+ExrqS4bZ6dmBFFh2aHcvpsop0kj95
 2riDybpwQytvqMFvKGnZycXh4HU6sBQdaMwzk/Uj2BMHWJ9EXKY1uBmy+F9nRswe156cXBYDpzJ
 ExL/dy3/ithLcB7JRBg==
X-Proofpoint-ORIG-GUID: rPt729LPDkh8I_QENs5s2pGd9qwwHey6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135

Add an ISP parameter buffer parser for CAMSS offline ISP drivers.
camss_isp_params_apply() wraps the upstream v4l2-isp buffer validation
and adds a dispatch layer: after validation each block is forwarded
to a driver-supplied handler indexed by block type.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile         |  3 +-
 .../media/platform/qcom/camss/camss-isp-params.c   | 67 ++++++++++++++++++++++
 .../media/platform/qcom/camss/camss-isp-params.h   | 62 ++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index f3acb1b54b6c1455d72e2d947c860f0c337648de..fba6f34b8d9f70ea258f7ae1a293a8d58d866498 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -32,7 +32,8 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
 
 qcom-camss-isp-objs := camss-isp-bufq.o \
 		camss-isp-sched.o \
-		camss-isp-pipeline.o
+		camss-isp-pipeline.o \
+		camss-isp-params.o
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS_ISP) += qcom-camss-isp.o
 
diff --git a/drivers/media/platform/qcom/camss/camss-isp-params.c b/drivers/media/platform/qcom/camss/camss-isp-params.c
new file mode 100644
index 0000000000000000000000000000000000000000..66dc717bb3a2a26707d206e537691deb4d58f04d
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-isp-params.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-isp-params.c
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
+#include "camss-isp-params.h"
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
diff --git a/drivers/media/platform/qcom/camss/camss-isp-params.h b/drivers/media/platform/qcom/camss/camss-isp-params.h
new file mode 100644
index 0000000000000000000000000000000000000000..4cedfbc745f81655569ff8bdd8e389b35f2c67a7
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-isp-params.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * camss-isp-params.h
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
+#ifndef CAMSS_ISP_PARAMS_H
+#define CAMSS_ISP_PARAMS_H
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
+#endif /* CAMSS_ISP_PARAMS_H */

-- 
2.34.1

