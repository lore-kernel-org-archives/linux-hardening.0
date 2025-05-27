Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D711FDA97
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329051; cv=none; b=ZPiMULEXkKxcyNQ3hsQBr7oKGoNmKNB4+iOj8x7/WyUMeyQAEm5e5Fv7QWCSA6l7hhZA92yrjEYXq9+EmaWRVX90LfoLx2/evLWOKKg58m5ptRN3Lt0uxiWtrU+2NtSWF++8W0uTDsrLPdjEOwLyOXsP2NbKdaLwQgtoBALL/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329051; c=relaxed/simple;
	bh=Zth/3P/FjsXFcXOPT+DjG5974NddOP5SrXJoKFpW5WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFaLvW5GUxkWXCphkXwmOfGNBbOZAhS/xXvwyZ9RDpf9kPNDiioIkD8C0uqZQdD2arhadNy4YbeRqbd/oe4xz5iYy92vMEIzGriqOVHSwRQf6AS+vtWaTdS48F/WbuOxYipfxC/M2HcTTc3MFG7UkFBknr1e9uat7K3CYhMk1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VWHmPsAS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VWHmPsAS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QMeNDL003699
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8VjfmWoJoDXBpYwZyd2P0w0BU5tyeVntRTG/sihbWg=; b=VWHmPsASvegByRyw
	WczWGexUVZdgO11kVlRtNY3jNcZlPNDXPu2E4w2nrwXOuhJofYYCofy4N3N3/Zxn
	c4AF26N76SAmzvNrSzLwMGIG8H3Upcu0LrA//O/bOHJ/FYtKblcA9hq0czTOmLey
	7ZAwupKbEEY6OSFqJDyF8A6zdjbckwiWdtfSjCQS1WzhoTHBgS3rpsVB6048CWxA
	zL/2hYhQlxSBnX2nz0rQhAkvQzvjnas9u/LzVkPb8tFAzN39wkyG8R7iYHTP6eGQ
	NDD9+Lf53PtxB1XfsRhQzPV9wKmaEuQAjK6UdaD5VB0LMkB39JK0bG76zr4bFLv2
	lf8z8A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u3fq6447-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742aa6581caso2240893b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329047; x=1748933847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8VjfmWoJoDXBpYwZyd2P0w0BU5tyeVntRTG/sihbWg=;
        b=QvJ0rawtUtg4FXYdN/nlIeND/U1RMU0iAwXsoBBMk62TKJSyEFHi078Sgrtm7YSF7Y
         vdmGnId3Ej7adp97o+5O23VghHs7OTqhac/TPOTL6FXjseErgkQ5Ekeq3hOc2RfhxM4n
         RL5JP01E7jZEZY43vVCK02vKf8mOk7mgiyR0+PK2NcF8inxb74s2Oab9/7/HnFzzMcdA
         xJaqxYYntIn0lyYDKW5whoaAvsdPYmHHT3ToFTJ2/lBZgROXS7UtRnb6MfkkjFnkrWU8
         tV9T2bbEQm9s9uLPmffz9K+DmXd2mGUxHMIs0iv4R7o2B7b5qtVoPBB9tYfclxDUabQe
         SGsA==
X-Forwarded-Encrypted: i=1; AJvYcCV2G3NalkBc3pG2+1O4S/w4DMhvLiVZHgiwpVkVhIusLY5QhgXOXMAkd8ysIUCz16xONtR4etF7iQp9d95IiXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZh07zt6xlAK7mvT8Tyv3YcypCQxFmrorPGH6jjNG4GbddWjmI
	DykL7Aai+kbJiFwjnXjchO3T3xKVjVGm+ouN/DGqiSGM1ScBJQVeH0ukfmmeS8F6j+LT7hpZkvR
	MlSL3rR6jH7IqvpkLnptLX/r86O1ODQYX80voPgS/TaCfEAKsWi3eM6KvWNyhi5MydAajOQ==
X-Gm-Gg: ASbGncsEnIs+ltLIFPiuKmj8RNNhPWAetyz5YCsIUCbyGpLHSTjvUZQXUcGap+vF/0X
	YAOwsuYS7W+eA5UoYAMcq7amEZXtvkcz4G3P3pNM1tOWajGHrRbfjSG1BysvvfDmEp36ueuhmnU
	ggUp2Hlh8GhGOrKktc94y3oj6kzyyBvtDfM6arxTBnhgvKuJ8y8b7i9KwXHrxnB0OIZCfVlZAT4
	6JTmruXbBjIg7B1BGkMnla6NAAREvIswhTZLL1bwotf2rJdQSZBxnKp99+LMnkrwymqAyMFgRvI
	JrfqVHeZMDju3ahUOoYPhwNXTDfBDgfkdUQ49RZBNbMie61OUk2BuBEoYXAETpIfFWe28fM=
X-Received: by 2002:a05:6a00:801:b0:730:9946:5973 with SMTP id d2e1a72fcca58-745fde6003bmr16336349b3a.5.1748329046829;
        Mon, 26 May 2025 23:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu3CU3ay8afRL2sXBe8+ebw8AHA7te8dS/i0NED7172wSL2eRoWnyesqmcAWty/3PYQAF30Q==
X-Received: by 2002:a05:6a00:801:b0:730:9946:5973 with SMTP id d2e1a72fcca58-745fde6003bmr16336323b3a.5.1748329046422;
        Mon, 26 May 2025 23:57:26 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:25 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 26 May 2025 23:56:52 -0700
Subject: [PATCH v5 07/12] firmware: qcom: scm: remove unused arguments to
 the shm_brige
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-7-024e3221b0b9@oss.qualcomm.com>
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
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: sAjru5RQaqkoGpB9SGUxL_7b-qjz24Zj
X-Proofpoint-ORIG-GUID: sAjru5RQaqkoGpB9SGUxL_7b-qjz24Zj
X-Authority-Analysis: v=2.4 cv=X8FSKHTe c=1 sm=1 tr=0 ts=68356258 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ViJ-rRY3MSY-B2NivjAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX9fj5DE8r5qS5
 dBaqgu6dfnCOoBaK6d1GCZA3XhXhj4b0+9YnevBr6Qg6oGz+muHTJf0jtZzf21IDxtBDeW6RL4a
 1hqxMd3B/uqQBwV9dmHMImXrcCiIX1Sv/ErDnq9E9418hfFqgi4aDx0kn3OHhaFAD0nuIKyJqU4
 Y81IypnIiteR21twXNr/ZAJP+mnvzFZN7/DByXz7gsp6POQzLgZSQtUpRvh6iREUd5CmLb9miCZ
 yUwH+2ZGrgKb2pGYQChJ2NIk2ptF7SOm3YAB9oZA6K3m9LNQ1rPLERQk9lJbCH4ZFSl4tk3EBO3
 PGw8Qi7qHKYEn9wEIVtrJZR8C51W5f5pvTfkKZVqoyntEYxMNk5Dzv/Sm11T4wJYLQRhV/nbM+v
 Fx1QoUUsavd/tRWF24CqjqQjJkmj/3VwOgs34OV5cX0bAGLfVB649dBazs1oqKbzKXiR5zhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270054

shm_bridge create/delete functions always use the scm device.
There is no need to pass it as an argument.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 4 ++--
 drivers/firmware/qcom/qcom_tzmem.c     | 8 ++++----
 include/linux/firmware/qcom/qcom_scm.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e3207a9d2de6..72223d7dc33d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1631,7 +1631,7 @@ int qcom_scm_shm_bridge_enable(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
 
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle)
 {
@@ -1659,7 +1659,7 @@ int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_create);
 
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle)
+int qcom_scm_shm_bridge_delete(u64 handle)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_MP,
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 94196ad87105..4fe333fd2f07 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -124,9 +124,9 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
 	if (!handle)
 		return -ENOMEM;
 
-	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
-					 ipfn_and_s_perm, size_and_flags,
-					 QCOM_SCM_VMID_HLOS, handle);
+	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
 	if (ret)
 		return ret;
 
@@ -142,7 +142,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return;
 
-	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
+	qcom_scm_shm_bridge_delete(*handle);
 	kfree(handle);
 }
 
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index b3a7cc20e617..796de61c7e9e 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -149,10 +149,10 @@ bool qcom_scm_lmh_dcvsh_available(void);
 int qcom_scm_gpu_init_regs(u32 gpu_req);
 
 int qcom_scm_shm_bridge_enable(void);
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle);
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle);
+int qcom_scm_shm_bridge_delete(u64 handle);
 
 #ifdef CONFIG_QCOM_QSEECOM
 

-- 
2.34.1

