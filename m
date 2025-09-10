Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABC1D5CFB
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463093; cv=none; b=OpHWBaCBrHwMyoR6OeJlW0ApZNPhesGogo75Q4J7Jp/BZxPwrHdZUDIzu5//ysWGpRL5vZlIJXWu7LRfuBUj1Hvm1mJAtPOtB/xVXCIPtq1Ewod7VmHq+rC5+NkyUjys48HDYv8DvignM2kt6M/Y6H28TYPYmP/AAv0I7ek+Yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463093; c=relaxed/simple;
	bh=2jLp+9owgiqgZBOCKFldUxG3+QmUa/8reLXIFzBTr08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbBfVIAl5Gzp7jcH+JmGO3p2GdhSwR6hPUIR6LkyZK2WEQvCymE7/3oQNLII3vYV6pDvunBBLTk0TTWysQ3psBFpiEg6kkr0e/SHiBvYLMISH0PM4joc7isTpctwMA/EiU4Vo6oDOQi7Lj0qH9qqxGQxWFuxAqVvTqovlh/Ub6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVwYk8PV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVwYk8PV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589IDC0g002306
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=; b=MVwYk8PVhFe5OTTR
	osJ8zYtkGNaKwQapy00sM8Me340JBh+tbaODTgTWBD3k0+g2v6M8QxKUtoiE2f2G
	LqaDTNrjPeN54eJcCPBBLNNqXIt+01tV6r5Z+1VwB71CTFLHCB+KzzV0N1IXrm/H
	EYI4T9qb3uK/XGZh5zGsqAF7HJ4yJc1n0Dy8Fs0Z8gKYGiyK8tZXvMoeMzg0eKsa
	Vv7AJ/1a+jc7FTS9/YlQ9L9DgGHwg6i3SlfEaX2ugoCy5zJBkIoTJpBsah2OpOam
	6PSDLOJV8BBxfSAH8qxPU+43+dFBPBxUaDwbw/CSuL5SpYXnUROzpcPOuXy49NCl
	E6A31A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg1uh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ca417fb41so72471795ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Sep 2025 17:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463089; x=1758067889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=;
        b=Nj6Zd2bBZIMIuLAgW0nOxC3/fubZho3tJJk4BlvpBLnzDaRmci9alt5cS6dIAp16QJ
         kDmEM4nEaqHnEjcvO8MGDLOCGyuM0LcwdRiax5W425XZCYgapzkM0lr4I7v/5F/aX1jV
         iyWdonhkkIbgMOLgVZHhwVr2tlJ20JYmIPkIJeicz6kidAv0vaWP33tazT19BPDBgnq3
         tf6N3HDk0coOSn+hJQQHlddTkYHHW4+AW60pg9e5iR0HO6VYbyD5ARhtg2i2rax3igQx
         MFXJhgbqUZ4UnmXFxFkut0grWoB7SodGmn6o7OlwX6b5OaTZKmXFD9pKCGCR827S/7nu
         Co4g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2xHNdPRuAsl3N2airiI31rLnmWR/EM3FExkjsFrtSmnq4RiQHvHBw991B0xbJh7B3vqTqVTx7azNgyS39so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uBgWFcyCw6qr9kI9ZASH/z1rMkqLB+2zoY0qbrszERn96XnF
	dHpaNG4kEF9qzniwSHfVL71K2uJov0nRIhJLLh+5ekcKIDKKFOcPUMRM680Bb4YvRUovekjzAcE
	n40OME3lehYVE+M/uEkaCpO54j1BAOqhcC2GBT4OktzBq9ycVdZ5zX+svy137U21kdlrlww==
X-Gm-Gg: ASbGnctzpQ4vV6ev0z42j6QBXUGcitRpGaoAimg2SrH3jgzjLyA+0m3Pe63s7Y84V9g
	YkPdxTyDFBvt1nzebghIxFVseFsbiPID42InOQSwxUTJVHHtR/L5Q/yVmnwVSV/lQTfqyK2zFzU
	83tk+losIR0IuB9xORB+9acpJZG2yCysZSGSWtbWzGrbFgSgvShuXCtqWFVFPW3m+IBnYMvYB4A
	ZRptK2VStjJ35D0GQ9n/nD7uaWk/FY1W3zn62g0qLswVLfQCsUn7KtMLsdVaeqyN8ttKna6h5JN
	7QT7DcOmGMehkEAhUbnBfoEfeZ1baJaoz+G+w6imG6u1LN8+L4Bpd1kI14xt9YQ0koBNiVun+UW
	IvszclHIoWKVrtFEG5/QCAEw=
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375645ad.59.1757463088825;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwv4U/CQ0DLFLSD+hMaG+/IFah4m6GULCeF3UMTUtfOmP+rVq3Sj4WE3bpGNjpxi71sWc8iQ==
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375195ad.59.1757463088335;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:09 -0700
Subject: [PATCH v10 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-7-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: UJG_RPuKpJFB3ny6EhqH5wxIi8Z3_t_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX93QokgxHbKsu
 E33SV8zxHBRTdj278dFA3PDGMveVGDt50dMJ0iEcYIJFbDzQNypSeawzu2SnrF/19a+xfKVH9Ix
 MBD2MofndHPF4jwjSNblDO9BJJD6E6aH+YNyvk2uIa2YAiINnj2ZKmvjTxFqiqCIrYQGkgw0cOi
 rWbPwIv/ymfaqizF94JcSbfg+EuF6tfPtHpFKFuizYAIpvJFI0QbTTYUcm45EeM3quBZNDwdzcN
 DCHgh60ZlgxdMDNGxW6e/uht3G5TvqI4DjQWEOFPx+agNap9Mhc5+Fc2i8kT8CrRcsqWk/a2LdU
 NaQTZOTxU7vqEhgadbQsJwc7WnqGbQJw91LyXQvndZrxBvUcJQ7YpLhuLEzifUbKrmzryOFXRBy
 9RsoQmwG
X-Proofpoint-GUID: UJG_RPuKpJFB3ny6EhqH5wxIi8Z3_t_f
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c0c232 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

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
index ac455683ab5b..5e393080fda1 100644
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

