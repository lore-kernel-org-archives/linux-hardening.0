Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E820FABA
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329055; cv=none; b=AYAP6+xZFz3AGKAonnMi0sbp+EBerowr7FlfLlr5K7DN/G8umtztyMJtcB7EJckigBryTplSHRMSCA3kxFrFRTIXrIDoKn3RqLmlL+Fm8bZjE/uPbPNJYGn3aJ7wV/krjKBZk54fwiDZZotrHZMzYzQT64ZeUDLz6cuBLDAfEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329055; c=relaxed/simple;
	bh=aXe1yZumvUJJkI92L5z+O6jNwRKaOCyXZQ9Biqrb7Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+cWeUf+TBi++zgRSvMjABdWuhFQwodXrdyt8uXOmdRb17jIPuysDGCupqP5f4Ka3bIpQZIh5KpmEXXpEqU/1drK8tyw3GelL9OyhSAlaBiIvCqKinFX6vdjcYWtRK6p7rhquHsMhcglCci07AR3Q5Ud3vW0nvtRGq1XqxGvhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6Zrv7SA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6Zrv7SA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R4K29Z012712
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	He/2xOHm9r8pxCyAR/q53OU1lKXDtAqoYmT/PoWo34Q=; b=Q6Zrv7SATwo5RxJn
	HleoTOKrdjRKYdaY/Es+9f33/oqcBveynYV9YbraUdzbG5/xBktFfMJylZ8q11Vf
	kPKRgERl1EvUoYWUArSyim77C3ngg61GDD9GI03PY82DBdv9LAkp9OEtInG4fw6f
	lV0QP5Oh+sMlLX31HBJIBWxzUvbPY/e2pfY/oxx8uNMRbqwf64hJ3vQxCGTbFz6g
	4tp2asNtpwr1N4K+qe3WgLih3SjWeTopecWWRb1W52le0Y6Rp2dQLpUDSQMMA7iG
	Z0xUGjw/jmZdUQj3DKoAdqWhFvvQXhDMVME/sG9vIepuEjJD1iroMaEiyW7D2pqm
	RTn06w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w6918auy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af59547f55bso1735188a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329052; x=1748933852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He/2xOHm9r8pxCyAR/q53OU1lKXDtAqoYmT/PoWo34Q=;
        b=JKRu1Uu6hBSUBHHr31XwEn8VmZViW/5UaVdWCoVcU2/YwZKZfmpQl9nEuiBBFMmc1k
         sCn0rTIXvgEf6IIJqPC74tiS2YIJHOMlT6vDXEW+IS0cTJ0inLq5kSPKuCMH0lL7RfUP
         on2mbVecojlWfNrneInXbFXLeQnpI4lxnlByWGAWC6NuWM62cWy3k/qR3jYTRnv4VT0F
         rPQCEG2hzKjhR6nqQCvQ87/uduC/DQphBxTYqEYPepuvMDAUBRu3whDL2C9P+TERyT9y
         2l0Jnfo9a+x7v18BQ4w3D3bR1AoXT8LfbLt+N8pEPzgI44Z4gSIx55s1V3JgsbzCXeTK
         Bxbg==
X-Forwarded-Encrypted: i=1; AJvYcCUzbtXoBg8uQhMPKpRv9SplrBmKxHGUdk9dbZx8Xj2/aVCjGNdhu9/6A3bL+eL4JgoqhOa3Kn8q9D7qQPP2PEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4LMGAtei4ciIumE9PkE/Jt0aqlf27GgTkOWUfvBwLCppZaW5
	cvNVf0hLBT9DF7LCVrvNRctMQOVMZzNrMq0BwjdUByZv6x5aummSjQrUENn/iGwaZHLnLQFA7Uw
	fZPxK7SvcigrLgqskdrsrWIUn3f6iNKtXV3uSse+0uyi89RnFwU5QZr3q5xBYS5sIzUL5Vg==
X-Gm-Gg: ASbGnctnkRlbgApqW8JmKIcaa+8qEJfh2/Ry6eXqZzMVZxGFVoJvArWP4H1SnuJMHs/
	ddxBPSs0f/L4OyX8iIgRN+1vLKACFqUCsY4Mcp3nbS3wmQm9QyAxePy3GJy1uFcgNoSi5W/AH4w
	4NlhqHdUn6/vved4103TZ02Evsk9AFQOidmbjwcgjjZ0ruD/K4wK08FbhIw5ODnnOnAn7V7pqRc
	PzxdEY6ah9DngRi4slvnoIiji2omvnFJ+b3Jm9x1jl10Xbg35kwemX5V6GT5GIeTwfT/fn+KUiA
	9rYg4d5r3Gs3rIaVSuWeNi7oAk8mlMz+iYomMBxPLXiJf51sTLVS7Cgi8Y8I7d+WSymptbU=
X-Received: by 2002:a05:6a20:2d07:b0:203:bb3b:5f1e with SMTP id adf61e73a8af0-2188c1e8dacmr17039852637.1.1748329052268;
        Mon, 26 May 2025 23:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVgxAu8lBxbrpstlo7/hYePbT6lFQVTqYcw3BdUiB7ZTFvd2Pr5m7vLP3HE+0xPQeMXwjGWw==
X-Received: by 2002:a05:6a20:2d07:b0:203:bb3b:5f1e with SMTP id adf61e73a8af0-2188c1e8dacmr17039810637.1.1748329051813;
        Mon, 26 May 2025 23:57:31 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:31 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 26 May 2025 23:56:55 -0700
Subject: [PATCH v5 10/12] qcomtee: add primordial object
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-10-024e3221b0b9@oss.qualcomm.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6835625d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8oKOjnTxTfYIYKgR0Nh7FI9AffGJh1ls
X-Proofpoint-ORIG-GUID: 8oKOjnTxTfYIYKgR0Nh7FI9AffGJh1ls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX27pDEc/zXA4q
 7PZhXTXQ/GnPeLKW/eNuerF1bGGCWD9dlfgDF7PjpQlMxjJ1SN7r0UVzRodzllS1c6GC5Pmfudh
 C4CjeYWaFNj0QkJX1MA05nyyqH+o0031HtXG8XDfuvmJh9EYBJ0gI//CX/ZHsT1d9GyBnSM+X8D
 PZ/tZiI+xbmjt6DrV8pEk7vodJwpplw02kxOcyd5WRgRirNlROqc52GkFZdtG1ANtDIKbaYILTz
 ZTGuvu+N1Bm5L5sQQC0rVc7yFWm6UHoLavQOxYrPo87An/JCOZfJWiPn2Dns0IhRxI13AMyoe8z
 zBx97L6rcdmeJaLQAHkdNHCV9qfBZGZvD6b0fMpeRYA5x+nZ0bXe1oXb3e1TOHSxNUwfBx7mJAP
 2oE31M/V0tQrTCAi+E1s5U1uZ3YWHDourvECxAJBd5K3tk/W+yZ9QdYJyaohy6g3/SkURCSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270054

After booting, the kernel provides a static object known as the
primordial object. This object is utilized by QTEE for native
kernel services such as yield or privileged operations.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/Makefile         |  1 +
 drivers/tee/qcomtee/core.c           | 19 ++++++++---
 drivers/tee/qcomtee/primordial_obj.c | 66 ++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  3 ++
 4 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 600af2b8f1c1..78f8e899d143 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_QCOMTEE) += qcomtee.o
 qcomtee-objs += async.o
 qcomtee-objs += call.o
 qcomtee-objs += core.o
+qcomtee-objs += primordial_obj.o
 qcomtee-objs += shm.o
 qcomtee-objs += user_obj.o
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 0e7f3ab8242a..a949c41dc687 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -30,10 +30,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
 }
 
 /*
- * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
- * of the QCOMTEE_OBJECT_TYPE_CB type.
+ * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
+ * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
+ * set is reserved for the primordial object.
  */
-#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
+#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
+#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
 #define QCOMTEE_OBJECT_ID_END (U32_MAX)
 
 #define QCOMTEE_OBJECT_SET(p, type, ...) \
@@ -156,7 +158,9 @@ static void qcomtee_object_release(struct kref *refcount)
  */
 int qcomtee_object_get(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		return kref_get_unless_zero(&object->refcount);
 
 	return 0;
@@ -168,7 +172,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 
@@ -260,6 +266,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
 	struct qcomtee *qcomtee = tee_get_drvdata(oic->ctx->teedev);
 	struct qcomtee_object *object;
 
+	if (object_id == QCOMTEE_OBJECT_PRIMORDIAL)
+		return &qcomtee_primordial_object;
+
 	guard(rcu)();
 	object = xa_load(&qcomtee->xa_local_objects, object_id);
 	/* It already checks for %NULL_QCOMTEE_OBJECT. */
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primordial_obj.c
new file mode 100644
index 000000000000..025346cde835
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+
+#include "qcomtee.h"
+
+/**
+ * DOC: Primordial Object
+ *
+ * After boot, the kernel provides a static object of type
+ * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is used
+ * for native kernel services or privileged operations.
+ *
+ * We support:
+ *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
+ *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
+ */
+
+#define QCOMTEE_OBJECT_OP_YIELD 1
+#define QCOMTEE_OBJECT_OP_SLEEP 2
+
+static int
+qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				struct qcomtee_object *primordial_object_unused,
+				u32 op, struct qcomtee_arg *args)
+{
+	int err = 0;
+
+	switch (op) {
+	case QCOMTEE_OBJECT_OP_YIELD:
+		cond_resched();
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	case QCOMTEE_OBJECT_OP_SLEEP:
+		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
+		if (qcomtee_args_len(args) != 1 ||
+		    args[0].type != QCOMTEE_ARG_TYPE_IB ||
+		    args[0].b.size < sizeof(u32))
+			return -EINVAL;
+
+		msleep(*(u32 *)(args[0].b.addr));
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static struct qcomtee_object_operations qcomtee_primordial_obj_ops = {
+	.dispatch = qcomtee_primordial_obj_dispatch,
+};
+
+struct qcomtee_object qcomtee_primordial_object = {
+	.name = "primordial",
+	.object_type = QCOMTEE_OBJECT_TYPE_CB,
+	.ops = &qcomtee_primordial_obj_ops
+};
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index a69d7c091637..f3a5c4658792 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -221,4 +221,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 			       struct tee_param *params, int num_params,
 			       int req_id, int errno);
 
+/* (2) Primordial Object. */
+extern struct qcomtee_object qcomtee_primordial_object;
+
 #endif /* QCOMTEE_H */

-- 
2.34.1

