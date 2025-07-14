Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255461D6DA9
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454229; cv=none; b=moZeOjJBR2lEvuLie4lUgFfsW406K+zIe0DB/otRIlA750Ncksv5ixapjbVMx+a2JKNVBOW2ZlsjxMSi5dCGShQbfI0v+cE5zHkqlHOs4A/da8G0I0E6lfdoPFeDTbHxLzOpGM9IAUHcrBHvWKFTACOTKIzl5JU6GzhySLKM2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454229; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sosDX9Al8HFcHazvuMte7iqRVIE1dM/V4OhieI9hm7mWYIONGnOeTQhRBmLM1vBJIQDoIwOyRvI2lCtgfF+cAOG3S0gDY2aGAnlo4I7bT9+pbcqCTIhowLGUc11qKZbHLtKmq4XgbgPP1Qp8N5z02k/H+jLmfL1Wz6qB7Ybh6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiBFiTjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiBFiTjo"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNp9Y5020932
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=FiBFiTjoRgGWwliv
	A6NRpzvOrEY2F2d1GiOU+gG2D98jldeZyZNBG22V6PrZlHFWpEl/xLQCPSRcULzO
	q0cJQxFLngWl3AwSZMCPnGNa/dyB2lt71XzCbGo/Kk4XG7jH/bHUFmn6ikqJBcsV
	y9j/g6P1dkTPEDY0Uxig5mgd2UjorcNhxy+w+Yz+A92pb4IKFcmPc4b4dVhAPcMa
	RhCmpNIj3t7qJm2/gAZtqZhyogUUhXXtStWx7Ay9TJSE5KaK/JLz5eVVIm9t0LVk
	NrqkvD/GYdR1qL/7LBW+gUho6lXnuv4YVKTAqx4lBs6xgtFsV+iAGI2eUnhFg7S9
	FKvmGg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufuejvy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235c897d378so36037765ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454226; x=1753059026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=dO49O+50NmkzWH9ABjPR4QU4WkIrlVyJjXXRlehLPT+Wfhny/CcNpL1Rl59L3E2zNy
         /ubW3GlMwzcGL+a8fXxaCMU4KdKav4VrfChdmmA5DKKckg7r42ocInRvs2NEomc7fUag
         2HTsTt3t3chyTeM36toRJjMcFZAJNXNDPng16z4J9SyuJl+0Rftt2DEeYH8BSY8Zmhp6
         sDuBw+ZHABJY3yIR4CPz6s+W0KkswQs15896Pv4HNwpmsWHW4SbI3rEi6mdT4YuZ5nN8
         eef3JdSHJiXjVBZAhfnpgwxyrq2rNKGu492fSpw3ZEdQZuccR1LYwXsq8ZnjUFU4iUzF
         Xoog==
X-Forwarded-Encrypted: i=1; AJvYcCXa9Agn0LTwWtUp50C9fxnUXm9jCLAzazJBHdtA12V6Yo6/IsjqUGO8bGOzQgBG4q3aGdnuerhPCLqM73TlvVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcrXJ1DDR5PXH+Kp9I2ig8k/50y0Ts7Pm3GwVqSbNhz8DfP1R
	k11xAc9kaxkAinMB6OS9EYQL3yYlwh77ri+6MA/37pHrEdM1yAQ3+CorBjRcU+YFJvXWCqthGcH
	ivg8A7ua0F2ZjMYggSxGAC5GMflxog62xch8I/dO3vsD7bsa1d6gyenAR/oMj2eGK3FBLFw==
X-Gm-Gg: ASbGncvAnayLO6OSVCfZksbbrYIasK0ERerYzYxcUb4hD+f5d1h7MjRM2gKMLUbUkOh
	/lisuJdG0nLiLpmqjdApGRGlyeIFXNVxfLp7L+ziXwwBDo+AS7rL6pgDURTCUex/lLu1fd+HZbh
	ydr8A/NOxwpzZAgk2yNUSmGLT2oC7oAdMbacyGZbveGnJzqzqN20msnr+DWyYKrMIYZrRkQIxJ+
	yv0H3FLcgZ1nLCStyX/JIdzmNPzrTtUG+F0CWWQi1sg3iHPYbvFOED9Pd6R3MVdG5/mcH0bNq74
	jkqSalitxe16Kji2cn6uW7Mm2xtgdK1+vDdMSMZx7IwPAdNbmjyUezp3itfNeKBg5S79KKf+/1F
	M5BCEJo6/SWH+N+CiMk3HPjg=
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211645ad.22.1752454226438;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKkQ1vcVqMqiNeyFPoUR8IIMJMh4dpPpOY24o/EK6hmUwpEmfMEVSQBsWp82yDp7UsudZ3w==
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211335ad.22.1752454226033;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:25 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:17 -0700
Subject: [PATCH v6 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-5-697fb7d41c36@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: SEg80RmmMdOAPoNUUoATHo_JJt31g-kE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX/11mK5QbNZNy
 FpPVGSalvRtMAISFbGM+ircbz9YCMv8ierPfVzRqGnpC7EyUV4cq0rw1YTKAy4ygs8K7XiAlBIM
 r6FV4bkwcBtB0wpWKNFCXZHtmgrqWvKMoPz8xRoqmIJsb6noYgfmxOuXwKBnhOLCwH0qH9Zaihq
 mVYL8Fqh7dPoHZSD7l9ywD9Wk7o5HBJGk9PGo5V9Ga6jWClafScJelcsjXZx50tYvHli0iGRo3X
 ZO/vMN/E4/3EHP6Ij9a8vtzSYD+EIt1yHKC6j5SSfVe5dpEqKMMMWSwJZHvKCeZpuYigayVIqUo
 Rm9Aqe8fW9DELg7SMATzck4B5nFSL0hluoRlK/rFD7m4ylESQYYYds10W6GezOeae6QYylld6YC
 +VgXE9grcZQNuJAHqSMNspC7nM/3MyQv7Sl8DFgpMOnd2o82BpNuzgUwBqpwvDSARomf40KR
X-Proofpoint-GUID: SEg80RmmMdOAPoNUUoATHo_JJt31g-kE
X-Authority-Analysis: v=2.4 cv=TL9FS0la c=1 sm=1 tr=0 ts=68745453 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=963 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

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

