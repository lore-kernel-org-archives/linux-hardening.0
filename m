Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECC221FA8
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650075; cv=none; b=k05eULE3yGo1aYsXZK4jLon0L4xnyx+rB+Xc4ROmqhqAbXu72TJir2IIgCcr95i5LNenQgJON0ojwGV7KeACQbpzPp+0T949xi+me+V+Uz5J50rKsW9daKh34XxMoA3PqdWcZhB5AnXZt9dqEb3Bh3D38+6ohhxAdQeqT21bewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650075; c=relaxed/simple;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXFXCRFze7jZeSRwF5fnrAyct3XuIIjVwqXdwp9X6qYQwN1ib7yB56/v/Sgnb0Xa6TJmIObDRnDzPCK2461POd9xni35/qEOvuHaT5CIQmPMXEVos5kSVdP0VSlgZWIsC7+qgI3lrK4PArGiTem2fEKcaDB4K+b4kukWJS6Hq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqMrXJvD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqMrXJvD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIuIYB005760
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=TqMrXJvDnndTHE8V
	cdwpRbB7NMB0Uza1PdVqtA1sHoldiQ07zAcyYHo3s7661dkj8pj1MPfX+eDE79oj
	tsvYh/G0xeJJnhUxmHuCLO4hzWvP8BgITilhMfSL5Q/23TfwqWXKjZngNcSnYsCH
	azw2ZMTjSeDkWvbef0COzDWFwVFYpBTPumj5KpxRetgAGkBGsu+Fsgh1pNp6BwLZ
	yo8jLYDSOMR5VSMPnQnKDWhhd64PgQIdlduHN6P1KyBgdR9jv7XBH012MgKg/X+w
	90f6jtIBkn+JwuF/KEs8/JbZ/NefXQvm1XNbs2I4wCPYfM6akRUAZW1TRIZJ4zZw
	szBOpA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2e7va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25d7c72e163so6235335ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650071; x=1758254871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=PbBKRjdQ6PC8x9jNn7aTkw/xpjpqYHZ2tCMXeZUXMqMwuRcfNJH7DCr8bIiaQdTdki
         heUIFx9m0hRSPdeSJlhyvTvAs8+LFl8KVJ+O/8H4RrncaGV+AwhvR0fttohchqc/zXdZ
         tv0ucQEX9OfNe1hDMP8UeV0engBPbuVoqvm6qHMUS44PSEppLK9blFxP/D3ctQFka0yB
         ZBMH95VdmR/w+LyJ4H7rjuNMj0/iip2L77mkacr6bZvuErrZ2ku5R9At9SnmV4oZ46U8
         30St88T5irVQZni/0spTAOPrb61MIUfPdFqUtcsgqBorXMJZPnfgekmfQy9zRFtWY5sj
         zUTA==
X-Forwarded-Encrypted: i=1; AJvYcCXoYkhy2I0/jLll6u6zxp4t7gPkH1WA3Fe/Zh0C4Ftsm43eyN0RU0VUb1CT/NIaskg7k4DKOxRCVlQJjeVWNP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGToeFQQM6llMd3yrgoHPyLaLf7adfBbcjX/Ne+bv89oBMpKiV
	V2W5sgJtTpJ9JKas6ySADFoFBpuNzrYEssebIO764zUw9G/7IvoSAWQAT5R/9kB7/kWE79eNzmq
	72lO7uJPnbTSpQVzVVaOsoi4ZSQWkrz9WJHgE3KjzM/iep8rsgDCSqcP2V42gnXvSAs/+cA==
X-Gm-Gg: ASbGncvzU+mn14/5Ij+8d8hL75H4HPigjU+/DS4DuBxosbI3TZJf29OcFfocFVacgz+
	DMMlz6DTw2l5CuV178hkP4iYG8hFJqexGDAAvvf+xghAYvBEoGvBFCYMA1Z/4oFmOwwlRU6rN5I
	T63ENHMPo2iSHbRMExEbx9jVO6tUeScncWvxNwoiGU+ethJAQP4LdBPkoXyescjNTZDN7EYVC6+
	oApX0e/aeBzFz1+dS6izD2VpSHCMUPvnS27gRXgrPMvRqtX4sN6sm/jJVz4UrEpaxKivqwHEh4S
	LZfpB+5jSO2QMrrEakC3A1Oju/GaxnOyPmNOMDIbbWUmd+rZnbhmOZ1biZB0kq/BWTjlULTAZXc
	NinftaNCbpJUKwPDdeHbb7/c=
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317575ad.14.1757650071299;
        Thu, 11 Sep 2025 21:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoqJc1O/uAlEAxgaKcABrHUnAHQ+NKSR7AY913bzR8AUunHyu+K06+VfdNdepa7qcmVz579A==
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317345ad.14.1757650070858;
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:42 -0700
Subject: [PATCH v12 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-3-17f07a942b8d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c39c98 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: N7jqwhm1rUp5nD40L8xV-J71sAEsakPI
X-Proofpoint-GUID: N7jqwhm1rUp5nD40L8xV-J71sAEsakPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX+XXQdLcdJK2F
 UweBjEmJFfF0H5FOUIe/LBpx6oMnnbl2rerEU9w9EmBjkMDCxKxL1DRhyQKbGlwgA+7c0YvQZsv
 6OzrqCnysIaxgnkhkDkoxFL37gL5guMNmG35bLhKEyW9lf/tPdAnEoGsdqzPW42XdMRukYCGFFi
 HDRQhYSymVvfypjjjP5AzezYP9t3yNhVhmUVhe3mIVyoB800EVIVrs+K+6EEa6EtSLHNF4nHcoG
 T4GJkVyNUpechLr9v9VnFrMDIXB9mBvjleZox7Cdhj0oqz2LnvMeerOhTze3tCgQvFvlPzby2gJ
 0yjcHqTAix3hr4ECXV1I6+D8fhPcDPRyqLGY7Quzv3B3GDrZg3zBpZcsL2O77iJXz27wNJBijFq
 ROD4P+SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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
index 807317d7b3c5..9fa042d80622 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -926,7 +926,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

