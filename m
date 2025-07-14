Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CF19D8AC
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454226; cv=none; b=sogIeYXOH6/z9jje6raX4sxMDhcnthz/HybAGFlC5Be7tGd2+pJ/7ohlMhieopNyMVVaMVkInN6PCkiwh/MarGp5yH0bVEACt9npbzCWj09hORyU/mTeK94N9P0ySyRlHlGZve2VMoRKjUHnriDyEsVuqQ1oEiMODC6Oqboibxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454226; c=relaxed/simple;
	bh=yjYoGAD9MyX4aHdTmPfeHHWvzzmNNK3os0Di5d6Z2VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oIrPJO2sa3IEBqp7cB4/wkjMSB/ejs1l5bN6HGXsIKPEnxn7zROIdHUclDD4PdXIIIcNBL3Wqjy+odN8d40Zr0RNqwN1zicHvs5Yo2kxsR1B324LgYM+HVGgVn9ISAeYTQiRqkYatNm6LgVAGIg3kwjDXHFT8ANOvAsi4QiRvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJs0HsEt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJs0HsEt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMeVpU031774
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=; b=PJs0HsEtgFHbJ3/s
	1Gn9ZT1UzOQjj8RO7IiM20BHTgn/ySGtOPjNW8uGY5zAQGQEY6Pvldv32IoPHh2U
	Js+7k40jxZFRcVEs4KJvzTFBh/EUiOuxVyLS4wsgGZKsCtYrB5fopLoS3GcpNBEh
	soQpDKZEhBolnEXk43dD3JWrt4Nc42Tv3FEXzytBUHJ0FEr0XyIV6BDB9Aw72THk
	0Br4pVCqOQlczXE5jdySd/IpdFWuudp8995zBgJsGgpCX82CxFCAkzOgzVb/WAC3
	rV3f8vnPJM0SojOH7Oia9IQvy07dmwoYcRvf8X0IXi18kO3odQf4HdBlZasHjbfH
	Omx6iQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a1b43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso2899041a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454223; x=1753059023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=;
        b=ntE4N9HHwcfczPlxtF2B+zmZZi5MIRo9ZS18UztXytfnZcvY9C2oeZnjWkVaTItPyw
         WmW5Y8abjprSjZtZ1FgfW059eA3i5nV44b31yAJIGJ9r1ul7JZ7dGMydTWmzSowgSf/4
         tDLun2EyT9Zakevg0PUB4m57NpdHR+vrSxuF4xKExEZUI5wHt5Rk4xNz9xJF2R2dxdhg
         NZeov+CJdX7HUvFKLvjVYZZ+x5i+dd8zL5crcdmUPEZplMVTnbo1fBdrVwafKr0gZyxt
         1PDVJ1n20xxDDmVCXXvJinM6mUefBoUdF+cPC2MxQi86M5IOZ0SAGbNGvYcXJif/LK36
         pRtw==
X-Forwarded-Encrypted: i=1; AJvYcCXNtsFfOqELxzXfKCJoaRSp+LzqG03l38Qj/k6H5WjYYiaw3KtSLJT9iNkK6jObX2ZZv7NRkPU7sI1GHS7MbWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy367Q16/Ui1+9/7+X/fKS23Et4vybxKMTo+XSNdfbxZYKeemM4
	D7dy6nINyijz0qWFnI0k0KT9OuJp1q50Q7qTBcdSuX4ExeFui9UyZUNHrBebjn13/CXl/7imYQk
	Fxvda+lo3YAHJv/ckR94Vpq1+0ENQ/feZ7QbGNI7z0uE+dFMf11jLnTz/mQmlk+zvB7+o5w==
X-Gm-Gg: ASbGncv6d/7ntH3vbCLhBBK8GttQ/iAWFLJLW8RWNT/+vmu1WBYquu3+g8H7rZr03Sm
	8e/0Ca8Um2QjdY0xFtFZNPLviUEAZp4z1otgul2u5sqnwJmJtdYl04fbE889E9+wly1Si103btK
	/BihlAyg4FFhWKk2nqD43CCJTrO8RPjYl0jCae+WifC6ZKQnNwrPhiUT/N+U6049fZlyqh4Xbc0
	FrTKSO3bdUjCmQjiz274wmBYh6yfB1NNKssm4Y0OeT0BNYVETEvv3E7op1+nPK7Sc2PbkS/iPeT
	bf2z8JS4IjmeD4VKlp5S/FIak9Xvtm0OBU+CrVH0Vo5flItXWc8yjO3EvJwZ4jnT1rxCyiipzSO
	VMDXDbirBSaYmALIunRpXsYk=
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639575ad.33.1752454223097;
        Sun, 13 Jul 2025 17:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRvCzZx5+d3JANtyF1yGNZHHvelXYTT1n9iuGKmxng2HkXNTyORmuj/a9u8CgR2vAWn3cpxg==
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639265ad.33.1752454222644;
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:15 -0700
Subject: [PATCH v6 03/12] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-3-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: rOnIvQO5hIDlhLXwK9lY37TPSuaYNs8h
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68745450 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rOnIvQO5hIDlhLXwK9lY37TPSuaYNs8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX6U8op4UQ+ubv
 1RVmLClfWCXJGWfRWj9GtgEF5nczyx9765f/t0CVp0oDOF6vsAkV8X/JkVEBYtYPzJahBTBIuof
 HR9eu2E6otga/txmLoAzSlFtvqaFnvPm3cWeyV1+8czdpqRLev2+ueg0qj6MVvO4xgR2pDQ2ct2
 OfLRFCysaaxz0HrR5Rr3DU3HrnUkPjW9e0Zas9D9dbQ4evARo3ypaRjVmEnwqRw8rXoq7ZZrCBn
 Tf+uFxCnOrM6akzM2Cj863L6qGiQz8g+FmUu5JADkf8jy9oN8NQ0nAreQT8KCsMDiCESwK/Ap5H
 O5/yWrxw9DtQEgYrsl4uPA92chv/w59Rwbu3EybPJQmX5dAG9azf/FWL2Yt6W5F+w0tmMuf9Yh/
 kfLq+pY6Alz9SK89fKEhINMo/EYv+zbdy/WCZeLfhszlyvYo9JVZK2nN+iLXTWG5a+7GN/M/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

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
index b9ea5a85278c..74e40ed83fa7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -387,6 +387,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -455,6 +466,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -655,6 +671,13 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.value.b;
 			ip.c = p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			ip.a = (u64)p->u.ubuf.uaddr;
+			ip.b = p->u.ubuf.size;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -757,6 +780,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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
index a54c203000ed..78bbf12f02f0 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void * __user uaddr;
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

