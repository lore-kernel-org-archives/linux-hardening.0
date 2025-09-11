Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928F265632
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562100; cv=none; b=FcQaZKhEo8ggc+xUDAZWJq1P8DInrszofZHL2sn3tsSSPeNd9qKkXtOF/ei8q1cnF1Wp3NBuSOVeD3J8l7FcEGvl05295ffiPfYsCUxu5vkXFyjWknj8tCLlonlE57MQ9WbCgQgwhvurqLmAsVr/ryoP0sWyjxkroxEijvWlGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562100; c=relaxed/simple;
	bh=/lv6U+EjPMeafYia+qKbji5Tbq552Q5xbMPIUY9qAiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzAiK8JGqhICcQ/9p2VpRPIdnKa3exjFpz6f4JOhPak3ssF7Fxx33TM027xaNIQRVA5oiRbO28dqkTKKgMjlrblAR8BI/+sTfIS59vrRBBPOcaLVVYanOZtG3vxrIZ47QsIS0+BSrQqs1UQMAjWMjIpyZVly5ak28ZOlfz2ZNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lD81zjBU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lD81zjBU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IYm2002343
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=; b=lD81zjBUQ40u8W2l
	UmBOznX4JfGe5Uc8w5e1E5ljITBKS7BsvfJadjMBZVNwmuJjs3maPhCIm1VeKuP2
	Ao1EYPK75Vl1bjpsY8ngMmzHKZJMqg/kyUOs/mM1gVHTBPi5vPIv4/Paxkp1ZtxD
	erCgNiZIJKFbKYts0VENwvk1WpXjnCiIhIvm2W8cRSYKTHEOHhy2H6YbiYeorEPc
	mVWJlM2tuNDJD/dNAzbweTL2u4WH/A+eNML53zt6A93mQ/ODNh2m3dFV4BlIZXUV
	vUwZV8xUkxkTnof9CAQsHGV1o6qJFJVmtH1RPcOpFN4jaTpyQGbzTVipJ5SsgssL
	SIU22w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8p5gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24cc4458e89so5555815ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 20:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562096; x=1758166896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=;
        b=V4JVw21xwbOSv0mkMS7Vlu/Q+b+QzMc04W2yPGVN4OTHwgdzKPU6+j7wrhTJfQ1wzN
         BcKsW2Iq0NUnKkK52C0U/DB0+nMHS4OXgSyQq6H8JmH6X5zH4mFKCJ2tAceHBSUXsXZJ
         rkJpfo8frEQT0s03/pAbI5o5PXxKIo4lZv7tHgNeXibnnrS6ut7tXcY33a55+lLNCfY0
         IDiIlmproZEmioCMAKKaZbbuF4syPv0pK1HjyIFwJXcCk96ZuNH7igDqhXO4GEvVW2+m
         3he8Dgb5RcizK0SNvcZQcubVpdvB2UFokBGsiDqNYfkT2RZ0qGkZeo9T2UVSyMc0JJCY
         JU5A==
X-Forwarded-Encrypted: i=1; AJvYcCWvx/NTWvN9lIomtoI1+IM3p+Fcw997vCxRrYMVU/yaZMbZA9S7eVDegjY8henivYUA7AvmufbJ9pxA9ewBKjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrSnHq9KLzsjn7lpj9Tof1iWAKxli7SxJJa91j56GPsFrI+RQ
	GIshZdRkSSLAZMX0l/fA02QBAc2oU+dilgQjxNc34IiNUulWgA7SY6zh05v0Lxh9ykOJN5apC/Q
	zVjWBz9QHWYX8Kza/bF/XmTUyi5P+Kui8IDIC/wkMaLAuIkQnqnfWQetxX190GEOBsdXfsg==
X-Gm-Gg: ASbGncuaGgOgBpkcSzrf61s2zmhDrpQahCmPNmQyqAoklGKQSToQjuRCrSwfi6PwRr1
	6W4s/oAcMGfNbYNHDwyabnq+OYitLhtWfq1Jk6dJh7dbh5uqNhFimZBvZChXemCXTKWADj/47EE
	JULI8hku3l0u4hmCPaYnjWd5xYXwJO+FbTXH2qebG5JpqOQ+djOlcmEhG7EsORZODOuvXRv13j/
	gQVqWn8j9B0afUJPvZ1HQtiWZ1RavggsMV/lzLVVpl/0I7qsl72R6n/TKKwaNVPv/yYPVfIXxGV
	ItOGjrtAGPo6knYsi7PhulsgDAGj3WhNcLyyZSyZubLKCU1T3ie4p13KQEFXJAZaV3zY2zTEo+e
	SdHIaNBq4IxbHPftDi+K+Oeg=
X-Received: by 2002:a17:903:2b05:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-2517493a0bfmr195669805ad.61.1757562096058;
        Wed, 10 Sep 2025 20:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvQDQ9uOhNwBYBH4VDpBdDwefv3e3oaJPc/CzBPBFYYZmFclBHQ1LdmEcszkXBkPyeDRPZhw==
X-Received: by 2002:a17:903:2b05:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-2517493a0bfmr195669425ad.61.1757562095433;
        Wed, 10 Sep 2025 20:41:35 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:34 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:20 -0700
Subject: [PATCH v11 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-7-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXw8x/sddXqugd
 ugR4rsTqhSaq4FQ9dszbjFQmK13Z9sNBQerziQcrn+ih+C6q8lwKHrqgsr1S+jAiu0x2bexAvPL
 JrITnDm9jUYzYFAxfmhraZ233Ar5my+SjipIQlKMRB4e5BSuUQW/+EzOGzVDXJtX6UV47PbTvmJ
 pAtTRsKvzha0ZvCxfdSq3NKderXTd9ELgTvifIxP31OCf5/mXdgGj2MwwEznR+OpKwtG0R3/fXJ
 BZshwrFGI996ydnibz+1zHrPJ8105kwEihg7S70uEhSoWkC3tzAmphjrqVnoNS2ZE/g4KunzDnF
 kpUEHUjYrxKQdqNmZLMYEeflpobYncAzunUWNmFfYrbIiBb/mpAa4CTdzOxtZojgGg03RbjZYeW
 cwnfobEr
X-Proofpoint-ORIG-GUID: IkbfVZbT2T6tleyDvBLyiYZxErvZHo1S
X-Proofpoint-GUID: IkbfVZbT2T6tleyDvBLyiYZxErvZHo1S
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c244f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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

