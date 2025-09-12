Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D93277818
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650081; cv=none; b=TKw6+enda8+lbLkNPDMoClbxUMzRvmQBG+BWIaeDyIagQnIQxJz0n5dGKq+nvHAI6HDlO/F/gZn5CfJ1z9sOV8qZB+XcUv2nynwd1czCC4K1vdauoj8T3G8Mrg/zVC3w+GcFaqV/DoTelMdchZAH/cpyn8wzbhGHUQ9NCVELLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650081; c=relaxed/simple;
	bh=/lv6U+EjPMeafYia+qKbji5Tbq552Q5xbMPIUY9qAiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHjqYe2rGG4c6dq3uWb982AW5iOLgJPUfo9R6AhyQ123ocKCZzB/sHWjgsvNFASm/IJjXYATNlQB+EG9WsyQQDHfcGVEGqHwbQkPcvUh+otW/UmZ3T1o5yTUs6hdvcUKeU3pRog/xGiptBG8Uj0fiXSIRDztNACzkk6d6xSbFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=myK/rdMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="myK/rdMl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJw4XO016098
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=; b=myK/rdMl99YEWJ+9
	xmp2+5NdqcR+Mu+5y0d5ntrTJX9/3MebyNDBN6k2hK86ki46zaHW748n/KtCBdeD
	E7qghvpX0ci8pjksyjhbtkX+LtEM5Gt1MZcYZtDy5JafX2Khhg7DaqXXzsANT7xe
	DivRXSpi6QsdkYn0hI3Osyenpa1JFJHDpZQHErgoOrUjSxa63457nU2i06IqMgAw
	zE/Vzu1O0sX6KCtTHFnWxXY6ji6a9apjzErEzNhHq1r1DvPPAAfNx/A/bNvvC+KY
	aF1b1ZNKfjQIJ+Y8/VfNenfusgpvFdpATG0XArnnzpTg8ooKN9Ke01LjlaSqpCEU
	fQo7aw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t386jx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso1042969a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650078; x=1758254878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=;
        b=IKq+Q4LhwjcUZwajceSCDVWujZSgnAQ+ySKvcQR6kvRq6zRtOPyLGqVWn9kny/W2fl
         kUBoIlrXhU2XNEABnncSwyy5Sz8Naqpy7nCrdZPAEAuVJlK937avAVKM3MaZ63TqC2zk
         vypN+O2Jnv35n8IR1TQnXFE4juYDmI/O98AyAhEDRvLxvAJm1ju1L/0BZ9Gf8ygAEGtg
         PbKd84eXk7O5oak12c9R9Aj0brTG+S+HWuJ+tf1uXE5zRn9a0dGBehoa/9fLfjFYcUqY
         vHFB3J2K63BzYOEXkRP2eTavjc8UjZ38g4ewVWJxA5VqGQDcYUXkM9aDPtsMd5f8cgQP
         BhdA==
X-Forwarded-Encrypted: i=1; AJvYcCV+B8aEw0yEXT/IFC+cQGdrjQHshD+jpPvUvwnGeSud3/ENZQOv69N8PRrUbedUfOakY2vYBeRwNZIEzYxnvmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqCtYY+sjlqh1upkG/GL+Im36PcTOOjDaeVEMK8Tu4kFL1+D+
	3zDvWAAJJF6/eAP3FS2fr8wAyEbHrRbSECHXyKRa8bXkKC0Ro+yMeHmoDSh7h1cmJzG6WQ8djKA
	5/h/vKyeM6bHKQyzC84sRcn8oB5yX05vr5xhFA1ApF0Bel0CVOHgBHQFrqyPrt/X0JMIWEA==
X-Gm-Gg: ASbGncvWEN4/x9iQeqwh/mN+fvRne2V+YCFJ/hvBI19WOzy9ofcjY8XCZZpoGOjhFyj
	mIsyI/JE7uFMhRhL/X6e7XpVt1jL28Fwjb4H1vMHDfVO9m1eWejlSfqmqzsb96uK/vsgbTYQ07s
	Tl6FYXRrcitRJxxxdHic0Bqg5ttcNV9DymoyzFevkKXf7X0XHZbQjYa/YZFRBWcl0fV+qZJcmkc
	s+2f7EdyNwD9xC4uRCYbN4Xy1shAzpNBfNJ4hmC4FuAj4n458tIXzvhsI7wD5s9l6fdKFSjsZ//
	KBE0tGY+TPE7mu4myASDWErxgHwBur476ap4YsR/7M2WTs4zKy31/gJRoLUcPOBvkyV3xupDBll
	KV7T1pH0hjQrJqEDMCfQ+ogE=
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108814637.19.1757650078392;
        Thu, 11 Sep 2025 21:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ46PSyhK+l4ntr3olYRusLBfLu7HsNfzRgfw3MxvnYkVZfq0w6ancyu/i44/JHqDSTmkaxg==
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108762637.19.1757650077930;
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:46 -0700
Subject: [PATCH v12 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-7-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: R9rfjlraJj-VDLtrhlRamNO5-je9W3uZ
X-Proofpoint-GUID: R9rfjlraJj-VDLtrhlRamNO5-je9W3uZ
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c39c9f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX/lit04QGOmtZ
 SeP/d4L6VVPk02aCQhmeIfoB9k09TP+/W4GVwg5YtoWYY3qjxQPSladZ/h8IiR+t7iGUeaQtOhQ
 CHA+JQsLb2HiWwv4JEvivJShvKkQeEmnKSF4xv05Kt782wcTvN9hAohWe1+dOSKEd6ovAoSJ9jt
 7H0HX6y4GV1004hv6AZFfqdxTTGGYk+V1Sa8+WHP9iGE0qyP0WlOGCu9g7hyhx3oaFw+Gv+2+11
 Xr71WhrT4Ra61f8/Oqgs9l4q4Slo1POQxrkDfYjDg2vi3yK0Tfcl4bnKqbb+bL7m8tPsoR/LJOI
 A6Rs6hN/Wh0pSMvokrLjsz1Sb5Ep7OQh10jBIavv6IwBXm/1yWoX3woSm0Zk3Y9uQRlbox+j3At
 6AlYzaMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
additional buffer space is required to pass all arguments to TEE.
This change is necessary for upcoming support for Qualcomm TEE, which
requires a larger buffer for argument marshaling.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 include/uapi/linux/tee.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 9abb0f299549..a5466b503bfe 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -42,7 +42,7 @@
 #define TEE_IOC_MAGIC	0xa4
 #define TEE_IOC_BASE	0
 
-#define TEE_MAX_ARG_SIZE	1024
+#define TEE_MAX_ARG_SIZE	4096
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */

-- 
2.34.1

