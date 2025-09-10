Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310457081A
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463086; cv=none; b=ZGfrNNDYS14Y82DAPULvMsf5odWGw5iK8n9wJtyTkp4txKsTvpWJ2upueyA81g+dTouXOBK0qXAsyiVjMdS4TaYD4csIZkWFx2sRBvVE375sFxmm4BRS9eE6M8o3pzzsRpkCgtultJPn1m6cmdQw65PobyNyeVsVtusQSWxjJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463086; c=relaxed/simple;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UA/CKDEM+Ng8wJqRxoVekG9c5VouNiGnsEQR7xzcxCzbVeZ+4GY9Vp3pisBtd0fMkmy8327AuprkkV6GjrIHopPfPNfxRnKHUvb5tgDB/5FbYgstekcywLUMHvBZmD8g1UlBL6c+DPM6ZHDio/q1H/nrBLC8QE2lKzawyMAaOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCVqCmA8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCVqCmA8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589He6Dr030498
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=VCVqCmA8LvzaKotB
	Rx5VH0HyTtER9gxW8+rfTKV8Vhide5TTImYb2eJrVZybrk5g0Ab88G3L6VIbXb5p
	vE6byxfDUybcZSRxNzXYLBqqzwq0JSVTEA0+q/1hB2CGmrS4phl6XjLjKEoNOQBA
	wmkOeILxqY2ZEnYkqy25toXvVDEvOfRyAFynqSUGBzvrYUJkjHYL82IQfbgw361D
	A9f+UAImCIJE1ne1BTgRplOk8YvZ4TukxdNhW2yw7eUOLR/Ca3seStKo3TCEibkf
	xS+wvu6V5p7jMhewLGVEVmGXJuTxMiMny64/3+DdM+NI/9AghnOTPlc1eNZMiFqd
	nMhL3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9ja3s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329dbf4476cso5720259a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Sep 2025 17:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463081; x=1758067881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=jw0YIYpRD8HF4vPKLlb2ordksfQtHm1E1+v8q/CQ5lNrgJ4iMpBolVsmhRF1l7FfAF
         NEeCVvgJCM56ldu89NSprgIqki51/vgNLmvJaPsJqsk0/B+FIL0OGUaTNIibD2nY55+9
         0z47nycl8Ohtsnk7dJB/oXNcgQ8ExazKpVLtnl64DD2t6sjdkyEcyLvhXt9+rrBeGUiY
         zNBEAuJSQKGWIxOrD4PtXDHNq4TBsyotSGxNDCnmrZdk4sk1EEM2wf8zqreUw2FUGUJZ
         ft2sB1FluDoK6BM/hS6XB+ancU2+hTdix70q+fDna6hIuC+vGBpQZEthUmQBRmgCXdN3
         8KPg==
X-Forwarded-Encrypted: i=1; AJvYcCWXMavzt62iE5ObhJKsvqnBJhTJpAIkXRFRuof8s3KRDNDu9ewjTiaJRv4Svjr25OsqneU8JIi1nYxnFB1LSFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3khQ5Q35EEILsSoq28/xBIeU2swUcdciDzzF0OSmTSKuCgJY
	Bx7jyRnnVt0TbS6kowvG8dLUTGE+OGItoRd348+xvU8A0YGUzZluKmW73Nl+9oyLWA++U6k6eAI
	F2Ubb3XX3UVE4h9BElMq667fnlJi0ahRr27jRdFZURbb60DSD1Oio2urnvAbtibAcvwVxDA==
X-Gm-Gg: ASbGncu5tHFGiWxVitjvL4sMcFZlXVJ1cNJlScIwAvElGbBDioirIQfKMXjPJCme0dE
	5hsTIiSwYYLRThGc2WIIpHmbAD1yMUt8yrAHqkBvEVoT0Lw/Zkx384fvzrGQDjQvpvowCAIAlpT
	LPmvmGI1SXAAUvbGR59mw8eC/I+xTXcbqllkaTLDgtHLyJpGlpbvsH3aXODNKs79Yfg+5TsRaDf
	IBMBMq6BcUhb4HZph8eV+4wMgSerVcN/XygUBQgnOcVGIb3LtHei3Rv/SP66VOzt4Qi13dtVera
	IAVG3D56Z9YZvf6h3pdXZfmu8iSl/G/Yrphr1LMeQ1tXlmDjI9dXCwGJz/hl8mRI6htaX2uAs89
	s+l3eTthU1/Mzj8RiYQ7xn2I=
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21188040a91.15.1757463081473;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpB0vwyPXFQbNkrO3QbiG84lkfE6zB7czKy4X83WNMEMJNSWAA5xUsqNEV9v/dfKVZkRwvw==
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21187999a91.15.1757463081017;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:20 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:05 -0700
Subject: [PATCH v10 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-3-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX79ofOcAXNP1W
 3g6qoWerCIu8xdsoqCHQYK3XzGxFBbMQ8jrMTBwYJ1Ht9meFWsfvOScYSdmb6ErqqHSchZNlvTI
 Hxt1ckAgrp/Bx8rbvGiZGsyUjjCFAldh49FA65LOFSEhyn4KPlREEeVSdQn/C2EyorzeOvBT9FA
 CNSrcF36agpmCCe+ClFkeMjk/nMPGYabvj5q0n/HNR0+FhZ2dMALB3wAQh6/PLLVVLxeueabqDL
 CAKpYwG9BQQVY6FJ00xviqbyYnlNWecoS5/yzzP6peeixIyH5Shv4HgCN9yN/4SE/a6AWL9x0mH
 CVgc0HNWYkWuwsNDasNlM3Nj3FodRym8inRxan4PsTGRkxJxb5/5+klefDv/56SeSVAoyG760KC
 lf7D/PzT
X-Proofpoint-ORIG-GUID: gYYpch2vAX6G2zEvvrozdv0jRF9bB3PG
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c0c22b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: gYYpch2vAX6G2zEvvrozdv0jRF9bB3PG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

