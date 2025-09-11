Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF72239E81
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562093; cv=none; b=jkQW+M77sNaA3XWnMoc0Nu6DTqjxxi7UBwG2fJ3hA+o6JW9JcCNGbDZh5UYdJIUMFiyPl4cDFKhWGR5DSryYbj9jCanaz7ahxpMS+HScP83GC8DmjCaVuNpeyReAymejPl9yNeVuJUv6AY8E9pXL5+I02RmnVAl3CafdK5XSJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562093; c=relaxed/simple;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIm/WU7m/B5w3hMOMrOxOb8HFsNG16jJDT+Q81h93AjHQaAXqKHBLrd6WyVcg2bwKQiAidgptQHzlUktU3iMpHaHzfYtFbsEW41hJk1SKXxh+EYZ5T98NISpi+LHV4C1gJxNi/pvEEfAwyarH2uoqNqotXpbffscyh+vb9cDIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O88QfUT9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O88QfUT9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IVbv025747
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=O88QfUT9GmAis5Ps
	Rd3Etve6sOMnGsOB1PoKeD8JHjerLUfP2tnBbArzZBPIyEuWUNXDvA90enzHZYIM
	jMDje6iPstBEmlMOQI0rDe8TGPMgSQ66X/hLrnByK0zob7QCeJHlUHP9PVPKnzPa
	RcC3Kvr248vdGcBYGqIDecQvOTyole3a9jungNRYUt4VFw+5F8QTQ82+JovIV5pY
	Q35cY677ctHy0L3+qubkkYTiZmCVZGMj9qJzY3hk0rLj6eOLDtL7r96VEgfcCR7M
	NMOtOdB5Fw0DLtcxbWyCJXKdIZuppx/BaG4rEIlxKmTIeUcbY8MEURsYwd/HohAH
	F8hwkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0x2vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso3335325ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562089; x=1758166889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=AGBI3A6wAnttQXO9rgCB/eZCsGr14onzZcwqwIU/eZ0XjG6guil54nQjpux9KzpFx3
         dGbm6sahLR9tGhvz1lRTM8TT9L3yJh5Fwh2GM5wnZnGO/sK/TrTfVZtACW13fSrvqP3n
         pDfvhQxUqtPG2IqF8Zg+O8Z17KQU4L36OCWKhqasw0hYEAnsDUpjHI1wAtj3/3+Ks+BX
         TiZ9z6oQF3j4310J7FOOmeKe4A2hRPo/L/j8bGTt+tfpRlRIeglQH7C1Mhf8pISca4pa
         Gj4D08KvBugePGHfzUwKMar0FCL5Byu/NcaZYMiLQsjzdQc2O1NGSibq54UlTHebTEUz
         bGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVEZf3DGNNCRJyjJNXCvJ8WfzXaL1Nsg2gyoAB0zfSAZpoVgVamwQuN402v0ljJH9JJTIQrafE6EVp0c8uZdbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBb74nY1ayPK+rtnEV1dc4JbE1XoRSnCPO1SvQ7j7zH+QazhPE
	DeqlrVt0RloD7auxE0Fxx8w+zyr4QVdW+egCdh6gR43rsv7dNSxOkrgq4MKAj2yQid8ntJj7Wtw
	OfOxXPy8/GBYYAn1KQXr1ygeoeL2Zfv8Lcdb5eENc7o6/60o/HzD37OPQHrYihDI48EvIE0I/Bh
	tW1W3E
X-Gm-Gg: ASbGncs9Qp2B5TfH1mmNKKymlqid77fsgFaVGOkOoPUtLKsYUYr2xe021D3jO8p/Wuw
	+0jw2CPasIUdylbjnUkjSnA8qWCeh2Koj+KlFCEtwMKI9s1+t8sPQUUsqqSeFyFjwg+EojjcBRD
	CknJ7BqX3gFTZX/H8+WHnbtVPGuvcq3vBXEq/f1hEL47GIV6zG5xwf6rTgPrUS/8Lk8nQnkXy1j
	cVNjxn1HmX1W1baWPrCeWbyvplP61Q7Zwx8Npl0hGfr5FrJbrd2AmR5bCeAXJeZYAM1NtyDG7r1
	kAgUPEdkvc28jpXn7DDqrp5r8STEQK7QFqhaxHRHLBxjnSEU59IW+yJi/b+h8W4zxufyLOEFmSb
	j+64omZyr6kP1btw774Lr4Oo=
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434595ad.36.1757562088990;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKhpZZ7QQ2u4bajGkkm1KKWLUYyswJaL/iiPppE3MndRE8NjcBrWi4HRB5LTZP40i4NipFKg==
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434315ad.36.1757562088589;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:16 -0700
Subject: [PATCH v11 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-3-520e867b3d74@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZB2wnJEfAH-7bQpDKwU1f6dAL1MWJfVY
X-Proofpoint-GUID: ZB2wnJEfAH-7bQpDKwU1f6dAL1MWJfVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX9wR+CcIqKYx2
 G10qCvFo9AwUoqaboxq/wE6l62kjprEdq7M/AeEm9IDobTNpLNCDj/MKqGsmt0fOvERuFnnpfXn
 OQ+C3VCoONA6UIfpXQbR7GjDVrxS7301YIrHg+Ir+f5gqw27voTC4DYsKVudZ0cIMmTDGtTyRFr
 jrIRg5by7ig897OctrwMHdfyOGTa/K3XAgD5zhIK4i5aNAsXnPkcrIeT40BEeKY8jlH0lC905kO
 NKZmFPfMjFgqxlbOu3diVtJ4Di6Oa8w2Ce6jaczaJ60qaWqy8dB7r6kkXV3wVPwMukA5cl5/BaS
 /N0odDxPwKSqxa1OklprZrzHzL7xhYH5G0+VOf1JcV5gyf99N5HyMRwBKfyYPnKfiEsyMC5bX3t
 oVMcWZFl
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c244ea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

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

