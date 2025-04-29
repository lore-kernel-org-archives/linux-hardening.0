Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C645270ECD
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745906820; cv=none; b=a1RtuORmGXAxhNPiHeXtYXPrPfxhVGv3Fl/2sgMiCmdbl7wnwOygaaUtpMJApnoF/k2hxGX0+Pa8MbOMeq+wbQAMPSwhhOgeO5SKS94i7HemB7ntdYt6FP+DKHfBYaeszsMCMldev5MCxH3dFnKD4PntGBQX3iKK9KPIbsGsqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745906820; c=relaxed/simple;
	bh=jFBkkTZSAMc8YsW5eR17yaZHeNm/0DGHN2MFjL1ufWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otJ6JeE7pewTRWzbrUZrLVBliCjwVo9nsnu3plzN9B8d/GkjTYvbOQ1AIxiVWVW3fYMBEFfTuwVNL5IVrxwNVEU5PvpDDcure0Pd9xR3NEjNJ5sTeRq1ScoQePcosPS2BsI0eGF3c4eQY8h9sBA5B/VXal3yalk/1E8vWDu7BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVy0cjHP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVy0cjHP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNr8YF014387
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tluKXCMaC5kMOu8ljoIfLsf72OuKjTNKaAhw+onm69U=; b=CVy0cjHPv3Zr2qaf
	Y+ZYOFhfBxNo77Y4SZCjSzR70EWrwd5eMxTNdDvBq72VomkAOI9/s8nTVCqYl+vr
	GKO7tHkNDe08BEqDIFHqg+Jk2INqyc5v1jkuO6ozFw4NrdCC7hv0uuKFINMD6Sk+
	BV9//jH7cenb49NC7bQ21xqtanpg3zLjq705iiHC9GKOMA4XehXsy0pUW9cLreEu
	LNBiJe9dy0iS0gttCSqRcONQ363t6ZrHJYYB8vpo1XTbX/u/VJg+A/KSttpARnnX
	HiNEe8LAWySAkg+ygDmBRA3uldMTSyvvlP17vJ9RbmV3pwc4Rlf/gbB1lbS1EpaW
	J5RZCA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rnn2b4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 06:06:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73c205898aaso3895304b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 23:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745906817; x=1746511617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tluKXCMaC5kMOu8ljoIfLsf72OuKjTNKaAhw+onm69U=;
        b=YWAFBdxUPu0rIi9Pvmv5HL08twgRKVNYvIKkaymRdyEpLVU7qa9TrhvUQPukj324Vd
         1stBbfMlZoRmUPMPpQxMsThBdvwLzxIw1GF7GPHCMSJ59TMSj/6XN038aABl3s8NKU0R
         WvfQ28kizenYpt9RdG5B00hqTs2qG3CpMcPPAGtw3AZ0Astg3mwR9djvna6jQKMNZLU+
         btt1CPKfzfu87aBRvtomAfIxVRnH61nXl7y6Tg9GAgxwtCm+BzX1SL5QDbXcfcxJWZ6v
         macd11z0rVWxcZhEZNwQibPaUOl9TFRLcNk+eGOu71GvwvwPyS6sF1o4KdfNjkcYefxa
         x3xA==
X-Forwarded-Encrypted: i=1; AJvYcCUJUrzbL016fp+BBUtjE4kJE+H9C8oNb/KIxYrlA1NmuS9bmMQ0yW+1BZd1TxLkxKFSF9DBVZJ/TQ6bAyKsI40=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyzTCQnzem66+mKN4RW2KaeZYS41tdTf7vAqg8NJkeHLwvCGS
	FwKMycTWmfrlOKX8ooqFEtkJS41tAgM3kVokn+mlr8nnCscmjpL0vRU9cMcChbBb3Y9BG/KFwMg
	G39EcOW4CGEu4wVmbhP//HiJVLXpgSmu0NYf48DNcoRS+siSHnA21JHbjsEH1ADebEA==
X-Gm-Gg: ASbGncuzOGnb0nee4fjtmI0bGeC+PG+3f0OxNGMcGyER4H127GTT1lY8dPPvsgktJ8Q
	6+AeH7vfjQbwsE6RcIcHR/LFDD6mLfeoRBeLp+rjjf++y9f9fUgerUpTIlQOn9LpCc8lyQv9Gu2
	O2y1nTKJxB0GxxPl9WYvTqt8adoefsiVzmmp5VkTWiJiuXfkkQOavdRQhWwxzx9CWtXjIEMno0J
	C26qrbDcEOg0PyKf7DfxbSgF1TtIEOezYv0oZCyz9enTLhur66DksL96rWIEnxdPuT+3Dsxt92S
	zlNdDzDw2g1NzJhPDQJ0kJ8RCcPlWTiCVVHCE6XKM+QItiEoyICTYVQ4eq+q/rMQl9RfHiI=
X-Received: by 2002:a05:6a00:2883:b0:736:8c0f:774f with SMTP id d2e1a72fcca58-74029565221mr2187773b3a.22.1745906816672;
        Mon, 28 Apr 2025 23:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg07otcOVfNPJ8y+U5whY82XEhwy5M5k9eRX8C8wg/VMa0dKjj+wgL5TymAJ0tRCcizjOWNQ==
X-Received: by 2002:a05:6a00:2883:b0:736:8c0f:774f with SMTP id d2e1a72fcca58-74029565221mr2187751b3a.22.1745906816303;
        Mon, 28 Apr 2025 23:06:56 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acd9cbsm9353642b3a.174.2025.04.28.23.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:06:55 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 23:06:22 -0700
Subject: [PATCH v4 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-1-6a143640a6cb@oss.qualcomm.com>
References: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
In-Reply-To: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
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
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: JLb9_PMJ40F_WDf4euiaAG3elozlHe6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0NSBTYWx0ZWRfX9wYuy/GWENJu LHH1DAVUloNuc/06d/0/JJaxW+AXjcTgYbYV5tqcTU2h9haF74cJRctX4nPF/97UXuREeIdWf4b 2O6tMP77ccLo1EXiD5tthNjatcxEqUtoWHTlcpS8QBIf/ljWAkOJy/Wg5x0FQpVmKAWjYQLOqjl
 IQR8CHh4yaeCIAXmJi5zPsuqy/FNkgHK9HgpdDwfRmH9coXQuSD+40YMVUU6ZEvnRfBxSFkwMbI 5zi2jdcrfuayR7idabVV65OEZ+ja2ksxHBD2yZpndedGU8zOhyvtjfgQRjj09VFe1xfhUu7Yb/S FYD0tgA6T6x98M7cvXO4q0aE3qdKzgMYzUT+tBzOQ63vnAtmq5y3HGYXs1BSEErcYvb3GEKMmPD
 Fr3beAZcMcYIzRbCr6LJTNNgI0dgrr4+QE8DkEf6QMXjU3bbvMY7XDDSYEr0u1JjeIH4Wmxh
X-Proofpoint-GUID: JLb9_PMJ40F_WDf4euiaAG3elozlHe6D
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=68106c81 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290045

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

