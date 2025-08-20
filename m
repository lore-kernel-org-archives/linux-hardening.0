Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95B2E543F
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733154; cv=none; b=AInLCEE25kaAu8GNowyVOQlWIpmxzVXurBGsfAOfV925Sw8BMwo6U8RWRUqDEIz99tKQogqy40xcZJHTH1F42wMjf94yImkIQVOS7Q8CwXRRtIWieNCAn3Wxswg4y7PEmhiT5htdD1tZ/YRWXrI1ePSipHhjlSraCdUZ6yOf4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733154; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBDNXKBPO5knZD9IfWqd3AQuwACHiDzaOZ9yzfa1lC7+cdvO9q+H0AF0KXckjBXH026qG2SnEz2oMpSAgBtVIKAxCvNFMRGKGX9TgdS3iBqlCGRvBp9yUdY0clbq5UNBEjKKg2Oh6eW8Z4ziHxsVghW6v52f6Pm0YnT0T4B7HO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCWZUO4a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCWZUO4a"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCuwU021477
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=PCWZUO4aCsixtpoF
	ZFGaRiI/6mzDtjoEH40urxBiBbP6+XNt3WvN4/qYQsr0fqBATlGs6cJR1+romPz0
	ZSHD9uWkf8dQeqx7lef6lfm4tn/VqwZPFqnoHAr2zjvtMmN0srjxjmxQDwW1rK2M
	YfsXkmo2edya5VKqK90hmv3Ews9/uixj7AguCvnrt3k+Y9Zi+MyHZbZo+CiuS6Q2
	NwIfZ80OyNi3rOn3CnM+IOLEGoeXD5fceAWlDqohdSvOTCMo1M2Zdfg5ALM+RwKU
	zfCtSOwoEcVuUQitrXscftqWHOkiBOK6s8PZMHZiq/o3/oSRfXybseTb02YY4wBM
	aATMBg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdh7km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806eab4so4165765ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 16:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733151; x=1756337951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=nPsuxwrLXVpg6Zj+sop1F8sxEugZToKzggLm3eeaKOKdgR1DUhrriSX7t2bemUStZM
         OZ0r4iJEkd0a2tZZGHT7SVLZeLJPLoxZnctW2TMRQi9saXFyfZtLpY6Y03EvexLVSMdU
         rWJCb3tVSjeiVspy/RWwHqn5hW6uZk3fyFp+w18auX11F2tbWr0WlZsn6rHhZKxsK5tR
         Tdr0HsB23sJ6tbOc7T55jeOrOIBjF+B2Qo6fFI4fO2YiJnbt4X6TAIAQeHmX+cRG/mUG
         fojiGbwvbpXxqjXHYQfsXmDiTLwJExdelCzajJ151/vM5ZesdAsIFP3Iz33wKyYAX4hg
         SlhA==
X-Forwarded-Encrypted: i=1; AJvYcCXMSGXxjx4Z1UHNA+sd1b97NGXviJ314AjiTRULtLDYhneRcUQlhimRH2m4jO3g1fMbpaT6lg2KX/0BF5FPnaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyLIh62uUat01koAp2LaRZabzX4KnaVShOL5vv/c0ucWu/8hH
	6EB7f9NdIXSbE9fejYD83ZtQKoMDTxdu+FCtNxZzh4XSkLGD+RdYQT4jjKPDhiFFHBqtkQk5X8r
	CnWtyKbrLRD69bp3wIEI7hAFXGLE+928wYLp4GEtKDfWHm0KqfP4NU3nRISzYi3xV/ZgG6g==
X-Gm-Gg: ASbGncvi4khPrmfdCcz2zZuk915HCXzO5OmZ3+NxBLoGc0jEVDBI0d4jsoIOQFBndhu
	NOJwnvHLd4HefB2ufGoECiEcvi8OWanP2rBgxKVL7DdBTx3L+Clk0TMOFEBE4qwgDV/AjiKERnW
	v4mYxNInxDIS13QiNqUCkvcfnQBXMWDByUK7GHGuJNA4en+amu32RAq8qiHD0D8/c7H8VjfFyqB
	X8LUH3UKA2YRNNZPte6e1c5d0j+omVGDr7BlUi/xN+1OxsCWCw332nPG++eD2Uk9oiDINQTvB+x
	UK0tmWkalRrUATbvDishF2yZQQeFBCVYExedy7Hbu6oQ8prPwuiVHFU+4Sex4uiYluKwPHneJ+A
	GbS554nGfMzQKJhjK4/ABrYg=
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982585ad.51.1755733150816;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJciBVPvgUAISLnaeCIDM3TBinhx3jI5VVAs1yjKKv+IWNyYEVSSEyv5G7WBqrbl04hMo4gQ==
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982475ad.51.1755733150316;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:09 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:52 -0700
Subject: [PATCH v8 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-5-7066680f138a@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a65c9f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0zDBtI8WbWVdeAOfHbDQuxUG6JyEt-gV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXyMC//Xfs+1xc
 e9sY600XiKp24KZwLoDSeKyRsnN3SNRrbxD4IfASv/1IvEvn2g60HuiTWoduS75RNzW0lye3GVv
 iPG1tRpr+I4AgZ4NXN7N0GyzCZIzp8Fplv/+EcwqEXzHIPfmP6BHmy4LmABHw/BAdlXYLZYxg5S
 4sqXI+nJ0r1V89xjmEX2lWVEbKZJQXUsI0wQAesowXk4RqAW7KjJp6eOMAMgJdLK+DYnlakucmJ
 3PGtO3wFZEqojmOLi3BoXZh2HBah9fCqNtA5BxM8DMAOOwveJiAoiTQayFw2io9W+pwdIlRCSAc
 HrH8W85tNY2rInRO1RT6XwI9zWaQbFqreqxHYvff74k6kqEb7+kYk8CrNYeVC2tPEotukXnnH/f
 j0F8cW+KANCROK/Nf/rTCvnALCUZuw==
X-Proofpoint-ORIG-GUID: 0zDBtI8WbWVdeAOfHbDQuxUG6JyEt-gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

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

