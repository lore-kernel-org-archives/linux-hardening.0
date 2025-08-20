Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBF2E2822
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733151; cv=none; b=QXu7GGFpSHE/NqrWf4w8J5Pg0rH5vuXmpeAVHL71j0yYgofTflu24b36EnEpZYtfJhxWpgm4CAXk8f5+tjBIRc9R9rDWTtSDcE2UAwI0So1d1Kon7B2MV46hE4A26hcUIy0ezOZoFbdd0vK1yUymYWneucewaiHt6pmUyhUfTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733151; c=relaxed/simple;
	bh=l+gCAkpYYZQ9/QpAMnLhH344j4oKiv1+YukXPatT5xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fif77WPU6qv8TAZyICIOKeLyQe6Rs8r5novMH9hKsTQGHZjrtQ4PS4YJ+CLkCoaC3z4IkDjYY1orobwrIVT8KtX/jygNbT9tmwK5gIPzGGEkUHR4gXIHoZeb0/3EjgGHB9jS7jwNv0zp4TpuL6YGUsFkeeDlodrQ+Nr6tdACVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ty7lxVAK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty7lxVAK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIiR79009202
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kA2t4DUz1VB5leIiGtQRvZZgbMfKTdedtPP/wTAuryY=; b=Ty7lxVAKC/0+zkbe
	ggPEiRsT55PXPmotdcLSuiCfxWrsrxx7vTovDUCXtIj3EdnLgGavCzz9jZETX5OG
	3bxg5ZZjnqEpgUTlBL1M7VIU13DuLA0V11ip8mKfmQgHNo+wl3vozM4gRsF9JBXF
	iGiQarlQxtUBQR/cf+cTg9Bt0GJzlavCIGblYz6BzQYvM8ex+XMl8qbgxn5ovSxj
	XL+cqVgpR/VHuxf8fgNXbMTnfZS3lmHY0EJkWTLD40FVMsf2HCc0qWMlPlgErLS1
	8V527I4AJlbY51SrE8zDsNuYnk/NOxBYcKWJg5+1gCRhTKgYHQsoG8DRm2psKCl4
	2eLaZQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a3e9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so452789b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 16:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733148; x=1756337948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA2t4DUz1VB5leIiGtQRvZZgbMfKTdedtPP/wTAuryY=;
        b=s2mj2lXOrNltHv1WTI84lCl+fhm2Pfn8U5iVLiTHO9nyXKeTWvsrbpTuF8MRzYWW4P
         nl4rD4BcdSQQ/Jt4qUbkKBYpqQVAM/AHGwXGKpu3rNvbH8+mY6ylltzgZKNas1S/Yvws
         14MUyAjk/Zcti+GK3jP9jatQ2TFihuuyqeQ/VMOWbdX82/C6Hwi4OSwy8fF8R4y2gONL
         /2vEXoNhjeDOVrAo8BZKZC7OBhU0Owcyn5cfLp6oNWy6WeC8yn2GG8mFBb5nEDGdHvBh
         dE9u1+e7WeRJQQQ2jYZLrvE0Xdl+uo6jbIi8mDgZMzyZlJTsio+K5OXE8+jTTrRTujvD
         gbpA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjaz7ORb6rQQ67jr6iT3ENsgAcU4y0r9jv9IkxWV+RA7urE9mEHuBERMl/OnmBndkiZlPpxNYDnx/EWZtv5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC54Nz2YLqON6gWns6f+yfzo2s7s+VZX4y8Euk5NnCPi1cG/3P
	pFAoVC5tNtZiZtkl8UrIGTteKGLpRDie5FN7qqsLUstMoZQrLL2mMA4mUZGtFT3eWrPSpbTruU1
	1s58b5w1qg+5kzvYPPx29H2s2Zc5KHwZcjfDxxDwNTxwnz0gGOw68HxcgcI5PFm17MrcSZ+6jQI
	O+O/Gl
X-Gm-Gg: ASbGncv70lbZXjavs5lnC9eXdBP0zuVm1kux1ZSiG3cFTQm0oPRCB60atMzvMmskfc+
	H/XW+cBZ0NKfpo3fxsWtCW3TK+kV/BWmB2QciID3iDzwdiYXssB9Pem60dTaMnPJ/QBuImcc1GK
	5vv1UEvvdzcOGRSrBxGg2cIj0pnvvzCDYLxMFBxpiplUasT2/R/C/WhNxhTBjb6AyXcz01HZ3Sv
	oE/1HQExZcZpmnNf0NLJwoMQp5Su2BKbGefh2W4b1R3triR4PJA8nBRKNjGCkLZQwxb/tcvEag4
	2qYCDE5cQXhkLh1DM1C1clGkGmZrywt2iy4VUmL4BYi1ADHLlynZrM/vPCUBPCgP5nG0B4lp66M
	IqOIsWgicLADEdBFEqzBmbP0=
X-Received: by 2002:a05:6a20:9150:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-2433082520fmr432514637.12.1755733147738;
        Wed, 20 Aug 2025 16:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6rff5A8cwSZC9TAcPXV7NBevAv/40cK3tC90Bkit2HX0eTDDc/WBQOUnwFnPZxiBFVC56AQ==
X-Received: by 2002:a05:6a20:9150:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-2433082520fmr432479637.12.1755733147246;
        Wed, 20 Aug 2025 16:39:07 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:06 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:50 -0700
Subject: [PATCH v8 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-3-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a65c9d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: f7Pt0Fxc5vKNm1-k8Oe-p0VqpBj_cpnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7jZR3QjtklMC
 tTOz+Ypp+VRbYKHXkO8l3dYjDqn1uilwqaNyQ2gDwWLis9llIxvVi4W0n6SW07Zao4wiC27EwIa
 n3cIIaeLptY9KQV2tdr/Fpn/blb+5T5sEXzWZmy6/ba2LYdPK4h3dRbR/pN9rNGCDVNHf2wc3pc
 0FpwlNXoHoEvNzei1t41H7alMYLawEpvu60b/InqypIx+H9Vf/VOaS7+pvJFfhpWDsdenax9Sqg
 EvwN1rgtixBIHMmrp6NJfeGwiChgYg60f9K31iyr70Jsy2Rnr9DvQ6156vaa1poWWQeW1hEaXvi
 jWFy2ZHbpk/rQ85Qx4m8DIskZbFYVoAYJR3ndaNSjmByLjoC0yAV4IJN7byP9/rOzCB4vwZYiPX
 pdclVXtZTjieCsab4JChKGfxXh1F7Q==
X-Proofpoint-GUID: f7Pt0Fxc5vKNm1-k8Oe-p0VqpBj_cpnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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
index 0b4c65dc14cc..ec0094291c69 100644
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
+			ip.a = (u64)p->u.ubuf.uaddr;
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

