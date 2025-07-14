Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4201898E9
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454223; cv=none; b=h8Wu82rrrcDWhexnaZoX1PCO2vHKG08OE+P9Hc44/JxZaqSvwC1M2OBFa3PGhTstZXsgHyqA60UVYUAcj4gMxuruj6gI/NRWo07Wzj5OI1hVKjH7KqngoqwHNKMN7uVNeo/1UpM6zoXJaP/5x0knjFTfP0kG+2/fT2CngNOgvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454223; c=relaxed/simple;
	bh=6ti6WK3uD8rSgx1+MJL0OTBiXFAh+a7/YuzQpoRdCak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGH5qwPc6k7l9e0mIh0o4U+EE52j8g/Rc4ZAx7eAEsbdKDrwaPMp5DeP+hdLlzG3ZfUd47SgJw1H2A64cTRNl7DlNW4mkd3qVqLBGI1cEthzPbJIrVY2BKqxi1e+TinwyRf8xvHg6Kp6+gZx/gPNeno6pA0rg2ufeXlYnH2clWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOO7aGet; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOO7aGet"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNPPYt032000
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=; b=kOO7aGetcaOOn6EB
	Dd7pX87VNVIXtpo/51n/LvG/uFmmmpkLbdVj7S/Y9a9ZhTOK4ld2Bjnjrzl6IUzq
	GmCpxnf/jviR9foVmIJj2CtNvPOOiyv5I36XiuGm5UuuwNghtWV/3KXpP+2bL4I8
	9nMzl2y+YLlDGgywqnKV+fkahjtIaZFOEt5tE8KTNMXuR35hlsBSYQ5t/yo04DrM
	IO7f6N8xUHnQZwZNzJ0ENlYTVkvLYObRtZuZ81+ifVBVv8G145g05Sy6wgiMBU2A
	5KkPqJx7znQLXJUtYZkC+7yKhEB8Nve9jrd704GrpVTfECzhUI1WfjdrDR8ucZpj
	o0+8qQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtsq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3642ab4429so2927171a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454220; x=1753059020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=;
        b=SltSZZgUqHEdU9YbNqVYmBRrifwS3ZrcIZtNA6DVGtHU8r0QwcUDMRaoPM1ECyiK7k
         87wx7BSwbgW7IhjOtTzClf0CkPeVzkY6orxN+fnarEgc87HZoSqkI2e/QYdTK1RwFAv5
         0Wyok6ioDwTYh9WpeLO0BD2QSNU8YoqvlVB0kx53gSefpn8dAmdfYpfnc5xEtuLw1Air
         SRFd6KUUnb6QAmbpPHR8T4tg4v+hnDUII1+pMPWtMpdUcyp7QSRVD2xl3BlH002tewNa
         ZZFAwP5iRdI4LNt5eem/dcAGQIe8RiVolS4MR+/yeiXYMRkpoP/M/PN4M20LAYrDX7DV
         nc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7pi2JqsA9CasbQ5s9Qpxo9cOC1M/gp0Nnplcwe4e0j3C1UEDQk5YMGusaILTGXjfFbcE2JHdFeOM5g9WpGrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ozEgSaUc6X/XuqNpZmOud4xIFSE5Gl3zLurF38cHbxc/trrm
	Cw6yrrfwgKExwaiz9VpAgmscjkT7GbMlKEUpjWUn1mlSUfEO+N8odmz1hFQmaEtJvOnRXcNBAaA
	NDRa2oUJHFpvpqv59lXGlbLYmi5pqbYkMiTTWA1T7M31MiF8yFyIj9bqiM0lc4umsl+o1WA==
X-Gm-Gg: ASbGncvhyb9ZC13/166NlPVHk5N/G6kcN4GxCGuGCIdlp41EDdXPJ+WLhbdBVYL7mwN
	0bTiQSd6gAVQK17h/UB529f6RR8kG3iWaOWCT9N52Vd+o0Q0SZ5Sr9l6gjPyFM5ialNWiebD4Pr
	i6UsILcdcjm77kxT0rT2CGqxULM4/qb+0JZ2fASHGtuLBOIvE0iGR6hGFra+yMTTZP1eDEut6K1
	4Vptp50n7d83yJQ9CuIHfvaj+Gy294VWpCH8o6PcM9PIR6p+lfMwpzO/ouUAoUw8GFvKw8JcDSF
	NhxhEL01+IsQo2FGwPKAGhxrAPhKA6cZlYKrE3n+T5cxN8e4eNW5ObO9aNrnJrX4aAnTNSBHxiv
	QxlxuotpyjEbk4kA85zMT19c=
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151875ad.43.1752454219745;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/mJiuun06sM2rMzoQb2znJePjSbapMiG5DW5Qq5P5rJEhFEAxnwJjdWQYDnBpyFcOi0O4OQ==
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151455ad.43.1752454219307;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:18 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:13 -0700
Subject: [PATCH v6 01/12] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-1-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: 2VP7I4fv-XSs0mUlcmtKmsZ7zqQ3huhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX4oA41HKVaXJm
 wMgfkvzt16wiASFN8VoB8Raj8YuTSpjp+/BXL0AQ63XOr5F5yoOq9yhCQvhHb2LcprhXb0VnpQa
 56YSLKSs5/vsSF9Ll56t3q0o3QM+w3/NbIvGhd/vPniKpGMaqERYgI4EC0i1VfHVORBXnRfxxv0
 WIrj3w8fm8Q4OAZLKn5m7+Vbo5E0Vy32FJR5QuchH/B10a7VCRs70Hq/2fgfFfZvAoF6hnt3FDk
 9b2u2gWwsoUbSxTnoIIdAFZ5N7/qcjmRwzJapuCdq9Ptl58wAR3Ez5x7Nj8oBfUQvkdV1lAPTpp
 9txOwH5SGEPcnQ5cgqJKuPgApFyF5KuEVJK5YQvKN28g913F0cC5h0uFhMlHtRxrqVCQfS+FuuV
 xm3ixsSC4O8Y5uMfeBQE9hLdwXzXiP6VmvbGBCdleI1OY4HZNNNdFU4fIOs5d02SfxyGvqSZ
X-Proofpoint-ORIG-GUID: 2VP7I4fv-XSs0mUlcmtKmsZ7zqQ3huhz
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874544c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

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
index acc7998758ad..133447f25065 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

