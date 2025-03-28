Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441120DD54
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130104; cv=none; b=IAk+9zho3uxY4ETZ8wLmltG+P9xaZ7WNzC8M1dKW2m6cXWFQiF5mdiJ5H8Xfqf9rg1mzl9Vpc/vZ5RPRbPXt/Z7mGoMZLDVVh6wC/iHSR25faTG52uFivlJLEhYeIK/E/c12A7vJg8802cZfNTEkBxsq8z6+RL5ljlwbfIuNwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130104; c=relaxed/simple;
	bh=1k1C9VP7BU3rWXxl+8j1x0TGpEuno44voPw5THBCC9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTUu00aN48q9AYQJeISucuZSI15kLtzYiIUTLBXSAztMipb2Qae/RMvNW55Kq6BPy3JNrGslpUyoBtEvgwCI+E+E6/JpMgqjUjfze19NB6DalgKcBbfH1Xt5pVVgyWU1XuG8DleuLQK24v8EUE1mShBPXWDsUQPXQUxPttQKnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsCoTPVm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsCoTPVm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52REfLaZ013188
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sjobw0Qvu+HD2r6/N5ib6f1zTdWIPLIs8HbgKzd8qfw=; b=MsCoTPVmUHmW0pVm
	5dAQq56G9qxHbB6CphNSZkK+5GifZp4Uyp9Y27F7gyixsjEbFOACY5MIUZkHqO+A
	IwM4fw3Fy84wuHeZK9RD4gyigIG2TAuqzTOGCAy8BASqxLyVUJyPTMp9qAJq+V/l
	5ZP9Y41xIhtlC+tL1KnLupGLKpFA7gG1KEi0/tqdDdVU8cX0jrhRSAclmUIWhtAk
	CpWepYh7lGxa77g9a9EaQOGuWqpkH8z5xh2mJJyQ2kHdkZ6HWg+DMjtgnd5aM4AT
	LGNlCkWpV4ocWVGkiOnEuJ8VLNtnwcZX9oAlu+d1+Me89YsvZg4tpy/1vpaMsFPg
	HC9BWg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mmutmug9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so2175114a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 19:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130100; x=1743734900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjobw0Qvu+HD2r6/N5ib6f1zTdWIPLIs8HbgKzd8qfw=;
        b=mw/ggvM2hZ7qG+Z/e4sn4USLl97zK6QACpoNRRHxilE4+U7l2m4dUoLr0E9LRrH5qL
         v4hgpXUqE6dGlTGaSIcvWjSUSYqgDPE2tQ6PH7zDUnvRallmxVQD1rztxU4DogcmG9+n
         dMiBU4YhDm8yb6vdxNtNUdXtmqxFXdCmfUD0gWnMZCq+1Vir3O9wNl6wfD64q2nOE5/D
         3wZFgvUt19fG+p3PTQqvLDLr7vNKqfehkvNfouS59dyrapSpGumU9ciy5ebcshNipZbc
         tNCfwcEN/JaiHdGl8nwREG6HIeRw/kzz+ilq6WK0aqw1f5LHqIVajpUvWLqrGaaI5YN8
         EN2A==
X-Forwarded-Encrypted: i=1; AJvYcCWWWIRpXd49poArOXJIqvPyudEYnzwgaLmXqM03CCVrnAnPhNc/ms5GS1puswCh8panqirlt49ob0GQZDjv4Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjN3WTNILfmdXj0gXDBh+aclp5CosNUgYvQUcACHHMOCM9a9c
	BOmVX4nRgTqN/QVGUTMMioNMi3LebRfTUpBgmlLa4QaFpSDwTG1tOvRaXs3tNJyRvsvMxraF3RW
	2ugRZ4dyCEFzkEQVmeepR9lpGrdJYHtPjwyCy9/ykvjhikxWJiT51d0ixphijekB9Hw==
X-Gm-Gg: ASbGnctKUQliouVPaRWKM1rQ6N2Lu1WrkRXSH+C07O5FR9HWJzxIQy8vmvS93uou+rV
	Z4F83558EMVVOkryhjFz6Lk4vx3pte/0hBEl3lURZ7QoM5gNRnl5vUs0BiijRkgoPwEeKQkbJOO
	PqfNQq13mePswoErS8sdZAhuQtljfYSqcHLaaq5kHeVEf+DfD7HUU8U/f2iD96GvAo/JY9BTmjH
	uJD88foEu2TWWyWykAa1fr+rZaBzRMMjjFLgFwZs1Vr4vFiBHb61XR3Wr7p4t8Tmn4Jcp5wxMNY
	WW1aAnxGjf3f8x1iIEFA0Wo7eI2MwFFJyonUHn6022X4P0rJI40QPELqczcpg6Yt7FwPyo/3JGU
	=
X-Received: by 2002:a17:90a:d44f:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-303a7d6a7ffmr9395581a91.10.1743130099762;
        Thu, 27 Mar 2025 19:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfuggGkq4jSTgbcoTzgRuHjPVKkGNdwncF5LgoWm+8c97edaKwNQFJPvOaF357TftOkkfmkw==
X-Received: by 2002:a17:90a:d44f:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-303a7d6a7ffmr9395547a91.10.1743130099182;
        Thu, 27 Mar 2025 19:48:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca203sm7317565ad.30.2025.03.27.19.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:48:18 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 19:47:23 -0700
Subject: [PATCH v3 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-1-7f457073282d@oss.qualcomm.com>
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
In-Reply-To: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: ltgV5YkWxNvJ0-Aj0duh0uJL-ogBi4SS
X-Authority-Analysis: v=2.4 cv=MqlS63ae c=1 sm=1 tr=0 ts=67e60df4 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ltgV5YkWxNvJ0-Aj0duh0uJL-ogBi4SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280017

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..24edce4cdbaa 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -888,7 +888,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

