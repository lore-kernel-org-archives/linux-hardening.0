Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C51FBEAC
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329042; cv=none; b=BmZp3RvcQcm7qvdc6DUQIL5QS941US3BGmDgTIDdhoY567/HBr8CUjbdUT/CC6kJ5RcsdWxNaH60F2/9Mg5qx7rEWe2qA8sSGViv0LHtn8kf3kL8PkCMIspdaqoPv2/aWbNmzolAMU8RwszG0fcKxRWNgUUfvl/lU4jRypZtpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329042; c=relaxed/simple;
	bh=6ti6WK3uD8rSgx1+MJL0OTBiXFAh+a7/YuzQpoRdCak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8eOfnTqMyVvqp1TJ7ODRGMiAHp9lOaRFFdQPCX+2QoHXfRkCOTfoxh/0e6Mz+3XYaepQtLccIh4svAO8uVlTpGwi5R0pDQtMPcyjGG0/yCLKgwIokrk9/A4MTJOHZAbuVtvITBeda+e+biCs/qaJVnJGUQeORAl7oAUina9wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XffPuxZX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XffPuxZX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R4Tanu013944
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=; b=XffPuxZXV5ikZ74Y
	FE0lmCxHjo5s/ON9M906LHyjYA91qSos6chagS5LD9bgRB62zl3yWYtEcImewnz/
	S4wlFc/vLAnvfOVapph/himlXO/RPYFV4xg00rsR8xX9nFAK0yA6u6jCNKdwkYbX
	Yhp7AR3r/ijo4s7UNRRWSiCTi92E1iNwcAVtTgC9k6o4fseGGBVXhggt43xCn2or
	xrg2hSAQBwBmWXkJ4SwxkLqUF51hEJ4m9k7nQ4EnhpP9vQrrKYJGaGmCASfVmume
	QaHERKsVyXxFNQVJW49QLABQFu4wlSb2Z2w4MjHj4SyBZO5RV2JVtudl5MY1K5Le
	UqcMog==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u549dybs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74089884644so2618618b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329037; x=1748933837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=;
        b=JYXTCHWUoqktET+2D3c7HJXYvwznvQssXjQT2Q2mDxZ/XzkARTmWpFHWue6ND32yTO
         7YATPx2BdsZLDnSylFgRX5sAbeBb+7pBZ1Ixbp7DCVnwj/H1lh4Z9wMR/G2774785GML
         PF38QWVgq4zURXbJ2MWg40XGwzfKOvwnCSY+m7kqyFJwOdrXx6wnt84VOs0i+RnNjrmg
         nqBd7I7mqjBbLRq8U9O6v9BY55u7BNQk7L1kHscMK9c7SXNCJpMlfPyLuDnQigGtDM+w
         zccZsN7xqWlWFlw8iM+XtmNiEibppGgTITndhJKLo6s92v+uXoOFEQC/Rk7mwEmomBlE
         aLiw==
X-Forwarded-Encrypted: i=1; AJvYcCW38/nIm7IF3VMqSdKv7VZaWiv2Hvtre2I92ghnYjVcrES5GizfjFC79roWpS9kHHlPOHI9+p80nSDsRhFqsn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OO9Ohi8Y+FUDxO3JUD73Ip0zaGVzWvCi9VOiqoMy1078wv8q
	kv5tPjQD7SuFO/JKcmYSX9uxlQAXjxgxxpokAIuUnVuyblWM2MtwepxrkCg1AQ/omIpkr6HnHq3
	hPo84UtWmWPLnsTLWGvQH+muNa2kBY5YiOg7kP2z6gNrm4yuql2vZrOH+BBjNGQ+YBttylg==
X-Gm-Gg: ASbGncuelV4RR0XNLwmu1KZz82ViuNxj7pwxkqv1ktp27yoanPmakI9POEoGvL/LDH0
	HGxZRkEwGpX9TA2xJn2s3hStY9rVLPo/3glH6iMvQhlV7Q3GDAYXbVCWFLWmxgcWlz9RFbmzD+X
	dnudDe88l/IGcfUtK5348f2KFxMaBqo1rXGtcQFaJiVCwRQYnDmKr24xBmflaRs9WEPe/6W2zQj
	NioRDEtcoAAo9T+uhNGC79T4yG8yl/a0SAj0QXAO7tLe3YHY2OlCvb3uzBgdygWJzGscc8uTMi5
	VBi95B6SChYz+ej3+CXIgLfi9ZJ1pfMDb2ggUy0phKGCch1F33E+PDAxdiBSWabc78y32Zw=
X-Received: by 2002:a05:6a00:a94:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-745fe0589e6mr14944416b3a.22.1748329036969;
        Mon, 26 May 2025 23:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuN5nvo50ha0rqfJNyLS1nF/5MRTlYqa+OqS281BYZkxySrFxKujXSx05vTLcA79D9Jnj30g==
X-Received: by 2002:a05:6a00:a94:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-745fe0589e6mr14944391b3a.22.1748329036568;
        Mon, 26 May 2025 23:57:16 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:15 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 26 May 2025 23:56:46 -0700
Subject: [PATCH v5 01/12] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-1-024e3221b0b9@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: nwqQDe7gJGlOVFAH15NgucFu750aK923
X-Authority-Analysis: v=2.4 cv=E9nNpbdl c=1 sm=1 tr=0 ts=6835624e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfXyh9VEscblhQD
 Vr+NWl84Sfxy6AotI2WpYhsCGthssugd8o6Qkr6Z2jIId74Mznpyb/4PbvvSiH9N6CQTvpa0dcv
 5+eCP4KEW6iFG8EgvVUcGhd0NQt4OpcMyL1IgGwHhYZI062AROo8fIn2L5U3L0kF+hhgEQik8FH
 p4NDecIvCGpWG9gLXu68bLuh66HQ1hkUmIV4I+JYs9KUD4PYCPxtkYkmTgcd1cboQR8ZwKY9izo
 JVFHFsFFyciFbI/ykSeg3ZFv9u8M+CDCHS9KZtuSPzeCr0UT5CNuKYo42RShGV3nRvMKO2QyEgB
 abX7mqqCp08hysajHYLEDGrTKxugnddUUYJVGYcJfokABaBBfLT1c6Ze9aAliE8UPxhIcrfatvM
 wNN6PRok5NOEEqAba71t7JlUOaE+butTchEAerudmUhHovtyK89e8iU+n5ux6lewNDnmYQ3N
X-Proofpoint-ORIG-GUID: nwqQDe7gJGlOVFAH15NgucFu750aK923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270054

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

