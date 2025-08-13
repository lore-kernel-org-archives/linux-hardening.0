Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EF6D1A7
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045430; cv=none; b=lgFbmkrdWstl+fgo5UaVihEvUMennjNtxnPv5FgMVs2g0T4UqqkaDu/1lTRCLMJZwJnpH3Trca0LqAXCjsCpeZ1U+yoRScrZ/SE3ncRK58DLgaMCftvY01LUWlPajzDMU5xlmoS9eLB/YteUoH5EPGp+0o5eYuKZT0t2IbOI4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045430; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKcnoQtyCZiwNUTMyUcPnRSODem0mB5sJGg+IZsj/fU1CiYEd9dppxAMLLVo0HLaF9NO5jOMFHI6D6j3ktKgRoH0OnZ/gD6O0SVwdJUNzGbB9jDeZxcz+vrcAcjOuBnGE/ZOvQ5Qy9HmDyHEKX0QmzIggctPc72TwH5P2sqjIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hpBhiATq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpBhiATq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJ7SMB012675
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=hpBhiATq/lYNQoNl
	JU0LE67zXI73ccU1PvZFZjE6yyrHd6m+Rex7gpWZXVjKmVucI0LExqgRMNhd0J98
	9LH0ei/1XvHw7Bjhh90eu6VvCtoJ2dnUsaGkCTQs+sXNwK8JudT7rxMIcpW9t54d
	KWyPtiMr1bEO9bWZanKSUoeqx3C7bs46ZQ9e7TEIYovgNoDN3M4/BrpqIsDnZ2gE
	CC9qnem/iRSbNs15mScprIvuAeZSl/Yoj/TAq8IQoxpi9J2bPjDiFm+lteTwdnCz
	P7+grhIauu1rR6yPuSwvZO1FLPfM7Ee1lqPxDahF437iZV+vk563+0j+eJZVv2vK
	eYKKOg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vmthm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4293085605so5707108a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 17:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045427; x=1755650227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=HPjshNOGW60Fd+FC6ws8ZIQX0dJomCKm93clPvRikaiWkL5KLisRHMw+vUj0yXkdVD
         kQqWeYo6jZMvMM0L5erROap8cFngBYXKSQc/cp5pIpVvW7HeolUC6fZj9jzpWxujfOCo
         RHbg0obh5aUoPx62fgarWRo5jVnT3nDhHIIc6VyR+Vp91nxw6/Z8X/hgcwYCycvylnwj
         5Ha2VQM6GzKM0EE6j1b2/PqlGU7ACZhke7VeCue030iPDyrbIn//wLYdSjSWJ/k3OE+C
         QvekD7QYSlCMk8JSSztpgcMe+YDjlOdbd2X0AerwDkUsvW3bKh4NU+I27qbRZ0TCaIPn
         V+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWZnezfxbd/YRWOGPBWYWedMuIUt68f5nuA2GrrEBoGRpErd3wH5WZZSeBOTUaEVkNQBAD9V3qFRFkqMprXE8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqNcrL2kZ0dYrxv1ss7I5OE4v6nl5BiJH9f53Cl/JJ4BeH0oO
	gmKKDaWTnhEI3ljjnm4sqRsixLDocFoLwTZPYgICIJks3w4N3d2Ze5IRBdyEzG2HenF1AsBUDqD
	y28tjMrNOZwV3A769kS7dydGCaWO3hApmIqUxXGAUlsUUVIXFtaiiLK9nX14p1j5az+1hqA==
X-Gm-Gg: ASbGncvZVsMvkG58FrFk6UZcJCbA/HtridVguwrOpZFR2ewJc3LlNDqyXZvVQbiWL1L
	MAsDqyIHnT7yWblYuwuqRO3M4RloA3cjBtPNwoS6jNq3/IWKS/kWXG8EmzRtSXwmsZlfQW/KyzQ
	UgD0Iv7l4Qr2JFBsl8DwD+dEA0++5sQYpHr7SY5MtnBm6ChajCwCDVetFFcE7T15HPf4li+Gqzs
	UROWYttKsL83dblYoovfWtSKEoyirthD4csZikSyvviIzwb5E/5bF8Y1Cl//VplAgv15elLYMOT
	sfpT7XxyQEFxXsGWw3xI79KVKYsNJsuFsfSUffkGdOJTpouM3ZYtJP0SLUKf/BLk+r3YtNpF55z
	prNukModBEt3QVzmXSnAcMyQ=
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr17668645ad.3.1755045426975;
        Tue, 12 Aug 2025 17:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq1Kn7j1C7ztFuBwXBgmFYHdC9nyMf6zyzl32DpAdGpojtxsRNAvOz4Khl5wCYv7bj+v3xFw==
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr17668205ad.3.1755045426556;
        Tue, 12 Aug 2025 17:37:06 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:05 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:34 -0700
Subject: [PATCH v7 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-5-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX4+mHiAZSfv07
 OPvKgRzpCNyG7STuxCVCy84Udax45GG2GfsuUA3NDz8dptLSYKknyIdXzz/5svebSVUxaiWNxVZ
 ASQMAZbIRRs8wr1Oq4qN3HM1r6Px0UBbbz4fm8WwcorMpeZ83HXzeT/VYILb0wsEDexV2Bqnvla
 tXGLkgbTc8wwD8+W8yAWGx37+sLXgVLVc4Z3qzTo2sPtYoqHRGMKMgUQ28j2Yhb6xaKNTg6XbpN
 8MrphBmziBlRtrBooe+FMogUOVDfgF5YaO0RlWMkeE33lr4VPzukO6tyr1VDLxzsacx9Ff6Rf/L
 +BdksYhoSaS/FO/9Bk516qmAJYQDRrF47ZrEiyAO8SE2Xxlpv2+FPKBRmBd8WfsoBZhw3N1Rybz
 NUVEE+vz
X-Proofpoint-GUID: BU3_9LMAUXpg9uozJ5xUz4mCcmpwKCDY
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689bde34 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BU3_9LMAUXpg9uozJ5xUz4mCcmpwKCDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

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
index 441d97add53f..71a365afb89b 100644
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

