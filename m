Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171320311
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045424; cv=none; b=OnGAgnkWedKInSBO3PmYN0Y32krZxQvqd5bOy+Vfnpneek3pvqZZnfuWiAmnmihMx+50PjijIkfhG0P48vAAEolTxLLOkaZ6MPDBhy+WsVxwKVYM+MKwkoMeVg/JahJlBhDT46Ax32BovtWc5x8aiSudOb3wDwDmeAS0DuT9a54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045424; c=relaxed/simple;
	bh=oYBmYKyNuJgx7AjR/DtMe3YDtEmf5yTSQmNY45/h+Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHp4CN3AW5t20jSGBPs8r7XwEafnZJJHDbNMv/sRbjZK66fOPDoduoq3veW3qXkH9FM2mHguBF50kDSrCIJh6tsc1CMithTEsdf/krlivbzHmhp82dN2q+qzHmE47Wh6avRVxyf2uEaavqFqEvNFQGacStP/L13yHQ6mMZDRyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5JbHF57; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5JbHF57"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLLCwT025508
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=; b=a5JbHF57vjtIG3Y+
	W9ifcik6dLYxdmud4XMvyhpXMtAJgEnVfwGGmbO0UtupfpoDEts8WtUNyKtyMU7M
	1xnLjB5lAP5sdW2bPRkFPZiEyZtjmPSfggk6B1Lv5bZIoBcgodGg19V8hsJgN3am
	0y4pxUNbeJJZDZS4DIWqA4D0MV2OCrxOX355vPVIHcyMB1dKNpiPt7xfNLBZpe0t
	40yumk4FYi8PvHDmEgDJ8khzdpJmnOVVU+OKEQb4VH8bWIPp4XpobsMotIl8tMEh
	4BKi6qJfQATmehkWHM16/CEY/kxVwkXsS7Zoqv+2idXUi6VkptW8BluOXGMqaDyt
	7qTQzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9st453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eec1709e7so9981855a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045421; x=1755650221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=;
        b=hE0PQpyXFlsEBe1ac9V/69jtTC64JsNVlBqrMkgKykxpzOxOx6pLdUmD83mPAvx/tM
         041bck8dzEH6UNgArYTHfLbBMJN6NCuh2824Lprg9ZP2TKaHwNJ9cbMKxONKA6gKtB/w
         Xg3W2r0EWKxo4lRrDCl1JnG+sdZAW6H5VTefejHPf7XXiCKy3oo9YJq7vbH+fHR1JsI+
         ofpx82ssfJ+//QovLP2tc93SeI4miejhGs3u6TlFLxhMc4mWxjEMeSUNddUGvbF6WKOQ
         rdwCWv1ilyqFA6elnjllvGCkzZFKr2jUnrfTPp4RmntmA+lOFzehbACWaTfmU6hYCPx+
         K/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8x8IkIuJikjkGK07XIbs54EHzXlBft30jw5+jeycG7hujdcqiNyq9ezhVuRQqQAOz4IunG81IkHCWCavUwSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mAGRO94AdO6iCpy6XHrAqKaRUFDW+Gs4iHcEF+mqc9MjtB+P
	gR26onHnatjd4/hCwLbSM2QeUCa0ae5j750K0tcyHU0ifBK9bdvZ1F4/LZQfXiMD9zyvW27rvFb
	N3p8CNrhpBFKBA/5JGDN8y2HJmWQVIZESYDY4uzdFxV6UCADcP6eGkGce7bmKPRI1WCR19A==
X-Gm-Gg: ASbGncuwL3px8BE4bg6rnc0IdLbawrebyAzLOg4YU9h613N51mXdGvcEAXEmPNwOx3e
	Lxgs0YzrK9uTYd//me0hNrCdscViPqY0Q/vPUJdPfCFrq2yObb0esEN23Q3zFZkVYh8kli9i2Pm
	miXzUgS+ez0wg34MOTSZX2OXWNlyf7e4xXrIDPFP+AQaH4rO0OVPf/uMpVRnzvHNnwRJT+wXTK5
	nD8m8zn16fhFL4QBdZZzsWzqFpwgbatvL5oXbQR3pu7J1YBYT/hAjHzegCXxcBSV76k6FOcpaHF
	8aog4fhBfJcmf0B0aIhUr2wz4RBVzDHBwA5ACaILdzbX/BXxvI2SSDoQW8+kwfKVsr9GHxcCnvS
	4DabXkqb4TYeuyAKEhWhqPw8=
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426335ad.19.1755045420806;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98zX42RSwWdppbMzosqG0TdHr9UoXTpkldnh54KBhgrVV7+MPU1d8WuN43VIfE3fGM3u3QA==
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426035ad.19.1755045420387;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:36:59 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:30 -0700
Subject: [PATCH v7 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-1-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689bde2d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: qlXFkV-9rVxeOpTTEOSb860X0-HNMTeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX39vra3Yb6EQ5
 mGyyiNB+bZCYE+xP9WnMc9uvc9KW6lxPCRvLImsXa2G+vfgeXIOnTf2a9F8w8z+WP1Xt+4vlm6u
 xtzVTxNVKFrQl0AFHzcHuSq/WnXbUutAqNJePwHN7OH8SWhrYs76lXuOAEmVnWP/mEZj0ba2nRv
 lEu1J0dLuYlwzvORtQrJLrpwgPv5k6j2wO7ZnLcB2JjUVfrGjwWCYJdRQhisYK7X9nef30/J2rJ
 B6RamWutCoLSGLU6UKsY8RIzdQh5/8vZsd58jnfROb0uL2EI6kWJIhgb9J5EohXtivjxtrHCuEP
 SGRz1U2seBk4c0VsQsvYMSEjm8nYQXA3thSZzVwiInjvO3isdkdmmdl7ljRB/2FaIxAx7m7gC86
 yuzCaOxW
X-Proofpoint-GUID: qlXFkV-9rVxeOpTTEOSb860X0-HNMTeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

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
index 944f913f8592..e47a68d337b4 100644
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

