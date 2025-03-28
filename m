Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5720E32D
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130106; cv=none; b=uQPDgbE1i+bqUqCFChUpH1FdlvhCz/Pxxm3jjeK5QfJqMCHU3j2+HHpi9mBYwcrWIn2aufnng1DG/CWIfIaL56I1olPxF3tmn4UQNhwsKd1qJupV7x86EKx3jsGz6Fr8BkbaJfaA7T3E6Xp+pvOHT+6bgJHp2lfa0osH1jmIHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130106; c=relaxed/simple;
	bh=LzVtnGgyPnlPDvjJg3jowQoQ5TJ34BYyk4JKQqlUgVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pu2VqaaNEgYS1FK3zeGdUKfvyJGoiVtIe2+aPs004G+2/4C98W6DF1BDsJDITLZhNicxeORJitOOnoPhcJLWHI+UEdAY+w36Hv2Car1bDM3BEISUOw9JFmusBlG0P1F5j/+2M/WwteOBKalBFw20Rkf+4+Hk8VOyQBk/PPogbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P44kuPEg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P44kuPEg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52REhGCA012440
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	trKK2m78JzvLO6nqfaUxmrBsvPpEOHdXYJeoKZHWxvo=; b=P44kuPEgsyvxxnTW
	bc98CDp+5V85r8rvdIHdUXkPvUDQl7NjmLOVGYop9gG6Vd0MMj+2QODaiLULueTG
	M/wiO0MLJCfbFyScx9f6vDNVagQwgZzMAqYQ1WxIWzHEENSj4to6axHJ5cBkp2DW
	YCfMWOcQ0j2ZcClitf8PcIDHbgnV/leJZfPhFowu0o9bBy3ZDg8mo05dgIGniPcd
	wpjnpbgePiJN58ZFQOacIpNC7HRsRW5yPOxvSEYtan1gW9bylGG9ttrHKle9HGrk
	Yz2ePzFQ3jSYSoXXfBH20TC8KamqDrZUOJrmtnrfn84wHAaZpV/lp0IHbbAni64O
	VPSI4Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mmutmugg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227a8cdd272so28144425ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 19:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130103; x=1743734903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trKK2m78JzvLO6nqfaUxmrBsvPpEOHdXYJeoKZHWxvo=;
        b=lLq5F2vLSAoih0lX0CYTiLHef1GX01Getqj0XaGIx1nyWuazxj6FgEuPYrvRXksLG1
         nuSuKmKIGysL8N1c0XssHg3647ujcpPRo3m+kZaYJy17OVM7B7AnC9VTlK3EHBFhKeUn
         JgRtw0tyI97q0wA/SnPUsSUX7PV7B83zanQGJiQPHQWVZZ8pLu8xKPbRRyvoGI5mK+HB
         sFlyDK/G5yufq24WsJF1iQ6yYdoFywTXG3R82YxUPM2RoOMbDLiSdcIPJxNwpclUX0nR
         SEi+asYdu74SAX1XuGMBGiUVa9nw8hE0+Vdf5wmvyMtnxtnv7/f0jkYx9B+oxruFyEgP
         1zHA==
X-Forwarded-Encrypted: i=1; AJvYcCWe5N+YVTOM/PgUgAPbuyFkItX1h5lGcQBjou3xw5iH2XY8sSyUzaacAh5cfANrYrQzoKXjO+0qNtyyvW/RFtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+Rmm8mp9xjx31DoUAMFDpLFlAsAuFqs3dZ1mzw/0QTyqzsfq
	mWtIKRWaGR9hsTivxTg2aD+gJjuxQNsdxUDxlV4qb+9hGrnonTQDbcmbPmjxeR4NoDOLiXmfS5H
	u06syjD/yTwitfWyFDWQ4atIBrlKR6sZync6uuyEYR6BY/mdnbLLPtzC1YsX0M3ni+g==
X-Gm-Gg: ASbGncsg7YyWcsODYERtQZ+xGX6u6P4MrK25vo8QW7lWJ1Ryo1SO8wPWrKc4A0c+w2Y
	eAzi6E1M7OmDJtqdnJ2cDAvCKiF7NtUk4uVrZhhZyFAvBUZbr+RAcbRWXsxcdib/dQ9guRpglNE
	woVvHOdLVi8xlcK2IsnqTx9qJOtOG1/Bs0g4NphCRHGdZn0LiwJGWbcBNRiDlU6mbRUPzA3Dv23
	rYawmfMilwSx3lfUi8/koYJ7PorL7fWzDFh1tMmGZZTKOPYJxirwR0G9jwkbxZl/3sh2ULnuA/v
	0EmUaowaBjH/pcyWTc5u9kLdG7UAp6JwdXin+rWWyx+IKRdKd/y0FiKein0eVRjKN/mLTWndtqg
	=
X-Received: by 2002:a17:903:22cf:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22804913b7bmr83993985ad.39.1743130102613;
        Thu, 27 Mar 2025 19:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7+ElBhiGbOyQrc0oht55G7S+WnkDU1W9p2p0aUzNmyvIvkEqpNdJbhyrq+E2XKQGbTqpmKg==
X-Received: by 2002:a17:903:22cf:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22804913b7bmr83993515ad.39.1743130102069;
        Thu, 27 Mar 2025 19:48:22 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca203sm7317565ad.30.2025.03.27.19.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:48:21 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 19:47:25 -0700
Subject: [PATCH v3 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-3-7f457073282d@oss.qualcomm.com>
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
In-Reply-To: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: 1IDz5JJZ2OiOi4j7_5SpniZZRRag2-ng
X-Authority-Analysis: v=2.4 cv=MqlS63ae c=1 sm=1 tr=0 ts=67e60df7 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1IDz5JJZ2OiOi4j7_5SpniZZRRag2-ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280017

For drivers that can transfer data to the TEE without using shared
memory from client, it is necessary to receive the user address
directly, bypassing any processing by the TEE subsystem. Introduce
TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
userspace buffers.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 include/uapi/linux/tee.h | 22 ++++++++++++++++------
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 22cc7d624b0c..bc862a11d437 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -404,6 +404,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -472,6 +483,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -672,6 +688,13 @@ static int params_to_supp(struct tee_context *ctx,
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
@@ -774,6 +797,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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
index ce23fd42c5d4..d773f91c6bdd 100644
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

