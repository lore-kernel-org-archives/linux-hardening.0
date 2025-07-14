Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128731EEA31
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454233; cv=none; b=fPJO6lECJroZ5cNlDqmToLliHHBJyo24+DkDzzM4cy9f2JdfJpqvvX7U0imn+L3JXXSwV2kbwEl9xMA5MW3AvIHA8HdnTenOhl2zMWUewkNzUt+5R6VwVw5J3qYgOeeMF+5X/vWQwh3IcVULc5f6C5X38m8v5na283D4Wsykt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454233; c=relaxed/simple;
	bh=4sISDrGhRvzrnVyaxYAEMv5e7n4PAkRIO/PLmW7kiE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZe8xELh+kxKpAHsk41qA3Wvesba08+o5ITmcozKLzqxTRhGWbivn6lG9BKOUnEckhCLkNFSBzLnmNckV8KU3lvq3ppwaGf59ts+UJvaSYnTbk6OsilMk7XTZaSH11uFq0+GAXRn32P7vCFOtn2vDK9IvdTKE0i26fO4mZgFe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNJdeMb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNJdeMb9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNPPYx032000
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtCsRmh8jzrf56uQEtvaGnF/ZyolBNlXVAA72gSdinI=; b=HNJdeMb9smyVNK3d
	hqdELrLLMjefMpu5GvCEEyP5jEGz1Ad/YoSo2c+pF0CJz38Ln3Ed1rbWEXY5BrL0
	vFey9++CqUZoSXnM9SHVtvRfqp5PjjhaDIaM0HctjIZc0LQLNrDeuUjkbJ3i9Fb2
	U8HKdHQ4aCiJHWkZdOQcLv7CEFTDThX51y4PyknoMHrQV58M4pk68ErOLQtxpxno
	Q6s2ODXPMHWxxkBIgDBuCm842HflStjf5LYNTH/Ym1fRsCwH1JahJGjCIEGjrTpY
	hucKwDwk9suN2iG7tDZUDu9/6MPDFouL4mZMRxTwL27L5ChtNkrM5bU9hifoIVau
	ezrdEw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtsre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2363bb41664so29615525ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454230; x=1753059030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtCsRmh8jzrf56uQEtvaGnF/ZyolBNlXVAA72gSdinI=;
        b=ivyxXuXpRTvmnYBeBD+McTqGn7Td4h+7nFycMjE7Pe160trWzBmxy+FUH/rmnuayvB
         SaWB99myvLK8bA6gCTjgijJfxFAuhuG3Ck6WC4uBdf7i4U7GTlhCyDQ+hG8k8wrqaNja
         fLhOdiQTZdh8NJqrEUK5o+D46xARatxgDTlZeEpCDgwmwkq7XBpli3Ce6VHEDxYGaHwd
         m3FRAgsMXETCOpo5UUIHGezQ+pCZyqNI8LpELDMdy8Kk+2lfzlsVH1EB1tKDZ+EEnM+b
         G9yfho0IYKSgbFnjdX6saPMs2FXcb3I6R748+IvBlUxiW78X5Anu+dz54EBHoG/3OQVh
         mopA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDKFCfMF4hqWm9i6RNTCKze16p4cQXUgeIMM9t+yelPwGHdBtAYsyTIAJGWUDZkt8/Xvhixj9sN0AK0x6+eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRPSYZTC7H2SvIICsNQEKVVzcHhgStfv8HLzIlWmMnPi+C9Cx
	zueIvLHYnnLHLNzJUxSN8yLd1hhFYXh/sQe9cs/fMSq++1OBwuHeQ4P6e/87SIElvfJ3t2Gg+Tn
	udBUAaZ38xlchXCqbUHCT4+QRlJHDYse7xmcIu+GELD9UCkWxjGVrgaf1qkIBikxmFHXVRQ==
X-Gm-Gg: ASbGncsMDHE0P3fD9ALL1qwXcaBLpipRbQi6gsZ5ZdayHrCHk+seMCEpOVbhMG0Sm4/
	B3n7y5kxqS1XdqdMyojSysSQ9gNUeaWH+v6vG42BU2nszHTJczX3MYiXHPBo8NbeS3/5d+E3E0+
	/Ogl8hoRmTm1uKab+oxlaK2apA4pV6a15RBujaWg6FqTXsRf43jVT72vqpPfGulJ05EjYmpHNrT
	6WxwVDqBoC5TvS5ZH1s1O+duOFOkyPjbkuo/Fp+y+h/Hr83zQkO1nbmhiC9cCqHV0vOQwXzvAjm
	31mGdOixJtiWjGGJXQEpiHUxaoOBKMnqK0e0fitYPSm0Ag7e9MAbjYNal8sm8n6nq6BgOmwSklj
	65TmIBV7j4khkKpoGHi/XYQc=
X-Received: by 2002:a17:902:e841:b0:237:e753:1808 with SMTP id d9443c01a7336-23de2feb28cmr210286355ad.20.1752454230212;
        Sun, 13 Jul 2025 17:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwgOuMB01t9d/8iPExWoQH54161e+s537wrXhm1aY46pxdDIukSkyHhGxM1PtdRNmE8e9+NQ==
X-Received: by 2002:a17:902:e841:b0:237:e753:1808 with SMTP id d9443c01a7336-23de2feb28cmr210285805ad.20.1752454229772;
        Sun, 13 Jul 2025 17:50:29 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:28 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:19 -0700
Subject: [PATCH v6 07/12] firmware: qcom: scm: remove unused arguments to
 the shm_brige
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-7-697fb7d41c36@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: tWLMpQ4b1yaHiWIKNtNypd7RBy-A6hXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX7oB64LZpMn5M
 lB0jpeem0yFUaIW1IDe1m9PFT6EiiAUHiwqCDm4l+k3lTRuIRebjNgM41KC2G19cysjrG1e3FQK
 owFwXC+Ga11obqFqxthXL6me3WWN+uz2b5Ie219nQs0LEfJyvdMQ65g82s+5hc8IJWMPD08wR08
 1WqM102dgBX7J6q4TLFWlt1FmCsoanGP3KZEwYwkDpWPnDuWcTVzDhR5Jy70CDtJwj/VjxvWhIQ
 3lhxVhxU3h4QA8qrsgkz0QdZN+yBdIBOFJvHQUdZ7xTgwMG2WHu0aua3PpeNmeASTysIdrlhazp
 FFk2PItWTyFyadnOthsHUQ3fmuOgcKn8ufjGykX4ThRqyvzJ+uJBa9yTL2uCYrcGRfV9i8pyZeI
 Vngh/hU9T4uynQCAHYyzxQhAouQlx3VDWCaxGBjhXJpfKQZnu/JnA8jhjJp1WCo5o0daWGw/
X-Proofpoint-ORIG-GUID: tWLMpQ4b1yaHiWIKNtNypd7RBy-A6hXK
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=68745457 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ViJ-rRY3MSY-B2NivjAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

shm_bridge create/delete functions always use the scm device.
There is no need to pass it as an argument.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
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

