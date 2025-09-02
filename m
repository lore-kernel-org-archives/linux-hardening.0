Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6D2E1743
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788980; cv=none; b=rlHGi2eEkwuWevMi1sa1y6wl1H3rhRP3bEU9rE4PXa/4SvRs/MimHF6I7gGZJD339hl43ZSzyYUn54M7R8HRIXzWL6kuiHhIF7pTWging1yub5fb5HccfyVpf3N7Tzx5l6P5Uh/6W3FGw9hskolrMpLrOWKxBb92POnRff86ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788980; c=relaxed/simple;
	bh=sh07O4YZIr6OH/f9rqWASPPFkuLSDXmilsOY1U6tBTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCY4oP7CaF9vDfQpre3UMX9q5P5ftk2KOCM2AcjgIQl9dM+fSlI9nPMb2o2BRd/lcdwqJ+LJNvJRzmwelgrChtArgNEi4EtElSnpIyJchnHiRaawByGC2wuq9jV1u4GXIEefhG6cc4D6vvzDYzqAzLmsLfIhKy2mWXgsoC9Pvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaSnfnha; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaSnfnha"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Ro3w029965
	for <linux-hardening@vger.kernel.org>; Tue, 2 Sep 2025 04:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exB8k5oMv8UirS+TCY7pH521pSkqtyclXWflYWec7IY=; b=aaSnfnhaaX31S0D7
	sW7czhsOD6LuJRZqDLA7ruIq6NwDulNHrHlgssdlwclKtZKZ8MtudsPTg3FPX+yW
	2PS3I8+gFV1DnoA6NEBU5XacW14X/JYHkjFcvwgK/qcsftbY6nynkHSbQsK6D11R
	hmnOnEZ/vQt5q6R4Xm+tXxKbMOzAjzi7LYtY2gCJTfesifAoUlu3KKNhZjpB94rD
	UEEC8L2+C/K/2hA+9ket0tUn6AIkSEI6g7kYAKreMUZFUIq6TiIz32i964iJv6Nx
	f+tPZYZJ24bSWqezbLqxBJwF3HVY6C7EEcNxm6QZLReDp/H+HL9CXJZ5BJtxnKQ7
	9pYkoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2b84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:56:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f59889so52412985ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 21:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788976; x=1757393776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exB8k5oMv8UirS+TCY7pH521pSkqtyclXWflYWec7IY=;
        b=HwNZLnpDM4f3o2fxgS5kwO0CBLFrbpWbIcs2Ww8U+sZnjfvJoanfV+UMRXdo0uwvvj
         O8zb2U9u9vsNie4AOTXK6sFnG9PBrkvzHwss+1+ysXlqPgt13BQ1gyDiipt9GDsimJ8T
         lZZRDxpY7+Q9HYAHOhAyb+bpl3c9GMb9BCdGUGMFNA2yDLItTaJddjS/A+C1qzbTQhoC
         nwoP2q7oAyXQkzIULzOpnqAx1T5BdStTKWYWsMtRlAKsE+tO8P/p6kJGBHArfeLvhAt4
         HeRmFKFdG46iIBD18EJWU1r9fPW7YYKqZRx02mDW51O7J6rZGuNWKjPDn73z6+d4hRAj
         LNAA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHj4PgVrwuvXOsrzc7jVIeAtMv7A+HrvgEvm5XMKDYiHZqsY6SNZzLbYL5A6CyvKzI7rKg7ivTOCIdCXxy10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxabFgKErPxSGrK1kxIncIBvkVEvoDgk26VkuAf7rs3zCFFMl
	FEJtnP8+00lVEaHOiHByJyFEtRjR2iBNMKS+CaBTcb8QshSdVIjvBVwBKKuiqMyWsJn4tuLBp/8
	bgu1m+YlU/BcitEaMiK95PYJBF3KQk5nBeyXzxDMer11a+EOq7ZrKSoXYHQ2AD1idZLUs+g==
X-Gm-Gg: ASbGncuFfG46poy5ULoYcUs6na1sJ+lql2AGYsdlnHE6vSAGBQJ5OrA1sBZkV6I6owO
	xKRIuIH7ZuPGtDe0+kmZPGqCiBwWOzPdNfDAk/LuqQ26WfquZeDbijkmD/8d5jFKSjEDtPoTBdk
	l+BjSSxxnfGNBP1xmPi3utsZ6o9ANwPVJ3KPjYl0yNJL9DaQEEWaME9uWY6BqruIBtfip8ikYLA
	fL9XrudWZNS3zcWIXClEhXpfGNAZ/SBIptPvy42/8dwuu2Uadp0NkxymU7GQldx8XRrfeF5uYZe
	L0Zs9Wy/sqSe+e3ZU0bX7+57d8QIfUgm/SkCZyrdXgT5YlhtjrSdfAMMhrBUQdDDrsVqhfYdmDt
	2EEkZZIFUc7AHov7L1fqOJRk=
X-Received: by 2002:a17:902:e5cf:b0:246:ace5:e1db with SMTP id d9443c01a7336-24944aa23a3mr134493375ad.28.1756788975860;
        Mon, 01 Sep 2025 21:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8NKEshakdEandYGTY0w0wWetA22GAUfl4c5xzhOF8SG7rlq0GvSoZHu9sYzXXgjFS1+x+Rw==
X-Received: by 2002:a17:902:e5cf:b0:246:ace5:e1db with SMTP id d9443c01a7336-24944aa23a3mr134492995ad.28.1756788975350;
        Mon, 01 Sep 2025 21:56:15 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:14 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:50 -0700
Subject: [PATCH v9 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-3-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b678f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oMkTC02YJgf1m2ujztx8RuA8sQkYuvcq
X-Proofpoint-ORIG-GUID: oMkTC02YJgf1m2ujztx8RuA8sQkYuvcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX83fwDTiwFRAC
 q3xUYj4N5KtNgvJoeJ3zDbNLmlxgSgH+DoQ1MROV82lKJTA/qflJELentHoiaWK/yNhG41dlhmz
 0ZOByTjy7Lvvvqa50lpbSNAaQhoNPTxwGVIOkljRARy9B7vlBGt3sY8x8Hpw+r9fPyD3Hj+X3a2
 iP6qy6tpKzpcuS3jU3B6QVf25nEC91VJf3maTm93EP5y7DB/kacAFMKaXZ//ctZ1qXmuUwgmJ1i
 fSZ5R38YZSMYrdO2VhOtWO0I7FIv9mAQ8tC9WPrB1Ldiind7P9GvqmyLCE8806e3wj/bkF0lbRG
 aWotagApV9//scxLm72Geim5HkswEUFZdH0+OFW2ZqIngph5IdBkutin+7e5P4iaBThTvHn6KhP
 yOmFteb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

For drivers that can transfer data to the TEE without using shared
memory from client, it is necessary to receive the user address
directly, bypassing any processing by the TEE subsystem. Introduce
TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
userspace buffers.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 include/uapi/linux/tee.h | 22 ++++++++++++++++------
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0b4c65dc14cc..c21f1909ed17 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -350,6 +350,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 			params[n].u.value.b = ip.b;
 			params[n].u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			params[n].u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			params[n].u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -418,6 +429,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 			    put_user(p->u.value.c, &up->c))
 				return -EFAULT;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			if (put_user((u64)p->u.ubuf.size, &up->b))
+				return -EFAULT;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
@@ -618,6 +634,13 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.value.b;
 			ip.c = p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			ip.a = (__force u64)p->u.ubuf.uaddr;
+			ip.b = p->u.ubuf.size;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -720,6 +743,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
 			p->u.value.b = ip.b;
 			p->u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			p->u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			p->u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..bec9a918b950 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void __user *uaddr;
+	size_t size;
+};
+
 struct tee_param_value {
 	u64 a;
 	u64 b;
@@ -92,6 +97,7 @@ struct tee_param {
 	u64 attr;
 	union {
 		struct tee_param_memref memref;
+		struct tee_param_ubuf ubuf;
 		struct tee_param_value value;
 	} u;
 };
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index d0430bee8292..3e9b1ec5dfde 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT	6
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT	7	/* input and output */
 
+/*
+ * These defines userspace buffer parameters.
+ */
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT	8
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
+
 /*
  * Mask for the type part of the attribute, leaves room for more types
  */
@@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
 /**
  * struct tee_ioctl_param - parameter
  * @attr: attributes
- * @a: if a memref, offset into the shared memory object, else a value parameter
- * @b: if a memref, size of the buffer, else a value parameter
+ * @a: if a memref, offset into the shared memory object,
+ *     else if a ubuf, address of the user buffer,
+ *     else a value parameter
+ * @b: if a memref or ubuf, size of the buffer, else a value parameter
  * @c: if a memref, shared memory identifier, else a value parameter
  *
- * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
- * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
- * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
- * indicates that none of the members are used.
+ * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
+ * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
+ * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_UBUF_*
+ * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members
+ * are used.
  *
  * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
  * identifier representing the shared memory object. A memref can reference

-- 
2.34.1

