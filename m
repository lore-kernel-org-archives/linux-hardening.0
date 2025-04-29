Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED0274FC9
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745906825; cv=none; b=AOLdVuGF9q3DSRW3vYVnyCIujFyIXEEt5986D7gl2r4Wu0cuIEkso3dg1730hZDhAHthFXXVssihauRL2J9dox2Cc5YviIAQZcNqV21cpoYsYj0BcbYEK7A/9kzcA1m4Qbxe9XC2eHYTjk84yVtcHAjDC4DLIlWGsVuaAfeG2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745906825; c=relaxed/simple;
	bh=lm0UWskH7d1rtZJ/T+nzuR9G55DCPo2TN73ybskHlbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uV2VMXDljoFVBTvnZl2pH27+RK4uIsTs2MFfPh9jVzyPLVRnZuChJnXQ8zvnw6UZOmiMsaLvLli99/HTrjz9h+Q4L2ZzsrbjSvKpKsGasu070Wj+ijvbhi+AlyTmq7Cf8w2WrD4Rhm1qEdRavto/i75kP0FW2wZJ+h6PG8Bu4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJJolMfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJJolMfa"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq951025304
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sxprD47J1ns4+472DQayzeIlGvHftXTVadqiV/NL7Ig=; b=jJJolMfaE1pMIhbU
	peLzegYcWzF6XcdzV73llv3xnqmOWgsgWKvCQC8HsXPd+/adfvmW6/mAXoWrJCEX
	zTYgvXCihU3pEEZ3B9ZAXNlH3ZghHpbGJzbxJUJ4h2Pg6no7oHgqny/YPScxxakZ
	KRktGzZcsfLzgsEkafpC2n8x+uJCMreOwLowD8XDYA3wdBIGQv8VwTUr6JGIBwE4
	/G0eK3NwkII+O9uAU6/E+Ii55d1c9P8Ilhcgq3SzzrzxP0duGvmEaZCTcYFYFtAO
	/FhJ66gjHfRf3+AKLuj4RLAeRRybtg2jS3v0Z1y8DNDE3ra2BKBu6KEs8Lim+O++
	s41UgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468muqkm29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:07:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-739515de999so4407604b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 23:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745906820; x=1746511620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxprD47J1ns4+472DQayzeIlGvHftXTVadqiV/NL7Ig=;
        b=GrsqvQqikuQcxDmLaLKjb3kIXLcrRXCes0eD91JtYUUz3UT9PyyywvZW4KnraXJKoR
         Cpo5IOX3J+KsS9BHmsMCT73+D4GbB11QpaFhMMq2bi5nuoAhGeC+OeJq9pioI2ILZeri
         cW3THXwFg7ETvVGY216oaxnEgTEHMHC5ramCzxUtMviGul4I6gARBLYcUlpE5WzZi5zz
         Jv2WOSKl4tg+BCPYrMs0/MvCsjEXIAb34Aw1PsM0iih+zST6wMTz0da5ncXDnh3DUc2B
         qYdZQoW2kkBoyUtVtsPwyJ4OiFmwuKZIJlfJ3JndTAa493BedZ+wuSHDQPlcZpH8HBY/
         caBA==
X-Forwarded-Encrypted: i=1; AJvYcCWDdMNM0xMhYP9KY1bIHMXIwBdb6daY3M6V+t+5fSY19keLRKzm0rAaUfinAw1VhW05j2rjWwh3h+n4nM+fDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseHAiOOZAZG3Tkeqmt9rZHsCFb5lXL5yI62xwwAlLsu9M+xKu
	XbcZC7arZz04BxlyYOlhzs1BWF0vqLyAi1SaQLTXMm6nUex3u+Y4pnjaEyNv6E+tOxRPkUvF9HZ
	fujXO4oXC4c9txJ1YwVf4z2rp6c5EuE52sNgo4oWAdlPGZIOIA8TsOBibHTMkNSdqNg==
X-Gm-Gg: ASbGnctiWZVt4cD70tqErfGvxo2ko4GmOC5HIBzA3dNwcrPl0D7KybfQLwAe++XnzOm
	5myFL0eSDsxl6GqhH7jhWttswT+Mputi6bAkK8zcGxvEwlTXhC07UjMfWbHTqoKsB2Jpau+kOPE
	ZvtsDR7N7nPuuqSNbKpeSwxDiCkKlpZOuBvtzKbH5faa8fBFZVOwjTZbhrQKUrdWVIdR0xMPAZI
	PwYo9Ei9ACEXzPVKm06X+p5JKIde20pUpLWCFLf8WKLrpZkt4zHzS/pszhN4pqDo4JRh43hnnyR
	fiOAb8Rzm3efK3xSl/SWfKxFkk848m5SBOsp4jONMvnTj77SkURUxYSdOKZ8nrZpcw7SP1U=
X-Received: by 2002:a05:6a00:21c6:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-7402710658amr3514716b3a.4.1745906819979;
        Mon, 28 Apr 2025 23:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBuFacde4OVGB/zgIWhIZTviSUq1luP80t2jNeLYY1HUnZqwFAuegWqGa+YDw1+m78dpky5g==
X-Received: by 2002:a05:6a00:21c6:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-7402710658amr3514682b3a.4.1745906819523;
        Mon, 28 Apr 2025 23:06:59 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acd9cbsm9353642b3a.174.2025.04.28.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:06:58 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 23:06:24 -0700
Subject: [PATCH v4 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-3-6a143640a6cb@oss.qualcomm.com>
References: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
In-Reply-To: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0NCBTYWx0ZWRfXzY46iDn/NwX9 gT9JefwzWssPDEEi6//ejbkKAQdvaCamDw7OW3L4mZKE27BjIgtduaV4RKVMiXquqdVQa9k5Wgs dgU0DgwA+Ma32TiNMAmjAGaE/4Ob/FFbPKTytcEAKPXPfRt4u5odspA+CiirKYXs1qA2bS+tKDf
 1aRcF4Yja+4+cws0lvka6lUcf3epl/SbhA3MXG/wl8g0KEu7mSDRxF0x+BizbDGZ2PbCn8HeAgf W1kz2TYEmh7rDmdgaS54snShDWwjwOPwntFmcsm6/RKd3yGfxkak7KgpAlaY23cSUd4rtqh1czs ItOTerDIv/aQ9oD0AaoIAN/uk1bSjpSxykjUlkBM2INxaozT3797EONrzaHQBdSVTuN9V/v+fAG
 emsDkC0mT11WOCWFaqlHgwA3CLbQ6JWCPlRe6Kxdq1ly5K4hnn/Ur9gvYOirwUuEYCWhvJYM
X-Proofpoint-GUID: vfYXlLQl_hdS05W5sjrRSH_w_OuF82z1
X-Proofpoint-ORIG-GUID: vfYXlLQl_hdS05W5sjrRSH_w_OuF82z1
X-Authority-Analysis: v=2.4 cv=M/5NKzws c=1 sm=1 tr=0 ts=68106c85 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290044

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
index 721522fe5c63..7bf265c4ac65 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -386,6 +386,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -454,6 +465,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -654,6 +670,13 @@ static int params_to_supp(struct tee_context *ctx,
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
@@ -756,6 +779,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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

