Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B761FFC77
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329048; cv=none; b=UYZPxUUfx4lvcQqKBAs06OA8hq99kjsAl8hJGV/kUCJcmvDuDrICFAj3C9mPydj3lhQ4qt2NAfTZb3qbfvIwdiJ8nF64/7iLT8jMdZaRsx7NUvVo+PufRVwpAyNBETmMRN/hMBHoRZitRAPW6JGZqXy1ksKufOm/QSgu8sCeymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329048; c=relaxed/simple;
	bh=E6uzMlVABYzll5NXvUBttowq1iRwQDG93U4RQisFH+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JF36KPj7yEfWn7la7P2wuofwlsS1ByDzxnziZixIW/4o9qYiZ/wiAvKou0r+P1eKRf86VmVbquFHwkqK7lfUBJ239+gViRf7I/MivTPC5w9H1KyhTwPyQZpEmp/gSMqNV0NY8slfHHfVVE9ePRdKPx/QGU7F+AnXmuX4+T2H2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uy64nr5H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy64nr5H"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QMn1gR018926
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZtC+JQtO3gxDVAYbGb6Nhx3602teWQouLuAXr4MKzq4=; b=Uy64nr5HFEFTcqsT
	qlaxzxJ/o8pIouB/jOE0FGyB4oLs45KTCP7MjA9etAg5pnC9oYEdG3Q/LWBjIel3
	WihkVx0WPJdeJRUbW/Xb943MZ69CpKk6UVoVtooWfiNbmRfF5959m19NZSJwZJ+Y
	NhLYg1MWfIlb1LVn8WuDsk5ln7fHO/LmzqKvoi03f0j6r+Co2HcJTaRtSJ6Ytb9/
	YPFRGZ0/WEZ4OwIvzlTevSmtIT6jUC07iF8FPiESt0zImaCj5ngN/SmYYx2qG1DU
	JOYMijtBnDjNFfYzmUm6V8nTNiaz0vZF1+sxZtriBoKKph4RpH3E/vVx5hlAW/30
	GjEqBw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46vmgcte6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7394772635dso2079704b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329044; x=1748933844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtC+JQtO3gxDVAYbGb6Nhx3602teWQouLuAXr4MKzq4=;
        b=UmhdNDv4hn3r69OlsXUTTiLmLTnin1MRTQgU9I2hzrveURInkJIIYz13XtSsd/0FTx
         3gozsO6NiDIEZXl4HEx++4pifBjULrZnTN3pzizUPCrDGonlp0hK8jhQ/5qbtx0yRlB1
         lSLy/bhVrSodzgjVNhGfBNR2g3GtzlUTvLCsHHBoWYErDcjyFzvQUM12g1xx/IpsahBg
         /P5oehawvH036QZgm+tM0wfgke7wIo/tYI3RnXOF5lstuMtZscUA/GJhvWApv4hQYs5z
         Zjt9ndc9iYDcbUtXHsMYykqDkzsiB/Stj0KV+Tde5rVbJQYG6vJvPJRqXNKe9JwXHOpF
         pUNw==
X-Forwarded-Encrypted: i=1; AJvYcCUvvgS86+yz1tvXpQVgFvUrU4vPKM6NItvjn8SWrplwOEbz0Vn6nHfsF0emHziXrNI8YlrNYGJ/gZobBrRMSNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQdXZoFtIKS0uisPaCylmVeG5/0PMSmOrMxqUvsMJKI398Pyq
	61wPjya1dBWmifeQsKr6XM5Kzvh3x5uXqjxYVXxbSJFQZqoMp4/EbYuhrdeSrGXOnj14JXUQs0n
	2qzBhVwE1hfHU3NoJif0aYA4xt3Dwd8kYEFhw8tMBT7e6OKpejC80W3p5hpt9vjUKb6+bVA==
X-Gm-Gg: ASbGncvkoAA3KGFOdG+iFUCfgeofb2w4xt2stFXYBFf4Rd5AWQa4Yxr9JOUuXeIwtBc
	9GQ+JMdvZgmRbyP8SUWchOUUNPPw0sIG6dOvC5gAr+Rkm+wp9pC06JnU3HZPxd9zqeV1uHxzyrz
	jJon225BzkhyMFraCudUB3ep2hyNWZ1AkWUy5ZF3aaqAriKHj0mRE1IruHdhgkeLD03sIyRRdHi
	R5InwDB2IKCP1T2Wt1hVM20GFpsuu4x3960MS2JVvuNiLxaMnjTI5+3GTw3RvRuKkyOzmniya/1
	XV4UWHMUo7DYFIfPerMRKgCgwKMkrpvdTiMT8NwgSv0zAzKv6WF8waYabOBHUYycJxVDqng=
X-Received: by 2002:a05:6a00:22c2:b0:740:6630:633f with SMTP id d2e1a72fcca58-745fde9e86bmr17925598b3a.8.1748329043712;
        Mon, 26 May 2025 23:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuJK0Qw8sB9Ij2uNOo2Tek3D/ke3eqsRNl8h7Kgqs57y3/v4DiAHeFdr24Fp7zbHoUEgQ4Fw==
X-Received: by 2002:a05:6a00:22c2:b0:740:6630:633f with SMTP id d2e1a72fcca58-745fde9e86bmr17925560b3a.8.1748329043282;
        Mon, 26 May 2025 23:57:23 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:22 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 26 May 2025 23:56:50 -0700
Subject: [PATCH v5 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-5-024e3221b0b9@oss.qualcomm.com>
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
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: Hh4bstIMgwauGcdWcBYQKM64uZoYfXyG
X-Proofpoint-GUID: Hh4bstIMgwauGcdWcBYQKM64uZoYfXyG
X-Authority-Analysis: v=2.4 cv=Ws4rMcfv c=1 sm=1 tr=0 ts=68356254 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JCP0Puskdh6qvuzBaLcA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfXyEzBgHV3w8v1
 mdn3hfPQ9zSuS6EYAf4dPBqxcEIaycHuhZrhnJzOBzng+doZdT+aXHIrPmebx+RsCVWu9Gxs4R0
 8D/MPnQhoJr52JaK3aSQCHZppfpZpKIC/QXt/ZD6kuEMoUhURsmt4drJIPdtHdFmprz/ZE4Zw5r
 hwJnaqUmulQabq+SDeX/hXuVXWdjMG9NVSiK2yEEfxPgQ4G7KbCHDUhWrdoDU6uMsa/pE5/aQ7I
 NZeW9lEFX0s8G1LkXHJM18c/sZfjlI60IxtnXEYvkKAoBAWT4EPFKNogCB5ClHszWB7AQHD/uHV
 hK0hIQWJ30NSaTD6c7WONPtfpY6RYRGPUBC6Ck1j+yY9Egoi6vkL6BL8aC/oX5IKPO/EIOM+ujR
 +Kq2QRSXKFc4MfCmPzkkQjyZLaryW0iHPBGHEpMDHImU/Kw0uzdrZDWBGoZpciWt+QPAjsr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=925 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270054

Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
additional buffer space is required to pass all arguments to TEE.
This change is necessary for upcoming support for Qualcomm TEE, which
requires a larger buffer for argument marshaling.

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

