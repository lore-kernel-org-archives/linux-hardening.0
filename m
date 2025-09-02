Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B8286D69
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788978; cv=none; b=ierGPj5ziJ0BGP+wy0v8wwMzH8yy47qcOv/HYF/mpOkStbHrv+vtuJ3Tvu95JfwT9rKBVvCLVnWCLL6Kh04XGKa374ivv/B/oPS7zcQ7AHKe6RhUeUhXgSAuwyqo9SqAu1oXLvqpjVZ0ADapztunv2XSHfurJnO5e1WXfW2zY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788978; c=relaxed/simple;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ti4w3I7N4+JVZdGsFv574y1U+aNHHcJ4b6SsLFPCuHf2BbeSc9dYevrFNvyg0vzzmRDmgz/2LfFoWkDRyd0hPrWxeJJDZ/mdStExrOIUtKerC9xKM/k19T5XB7qneZZEQ5UtGdKojHlhurCyGSwT0JMZjADuO4AmsBTbLgFbGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqOKYmKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqOKYmKe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SBJ2010468
	for <linux-hardening@vger.kernel.org>; Tue, 2 Sep 2025 04:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=QqOKYmKe0XQ+cJer
	S7yxq/GR/a8nz2SpXqpPS7AHVNwRYITkRQoGmkfvB/adUqPOkFq+yQCKXN/giXly
	8ExalnQXrlVApG7T/ZJ+3YQl9jeCmpe0EEx4pUZkjk9uAIexpTBlq2IW05Ld27GU
	7GEHAfKwBSnzfaOd0hofr9x7tam5xHVceVvAaEBO/aDzXc/QxR7qkLjQkYCrv1cu
	wd6xto8mmM1dLy9UV9y+ZNpS7meuP5zX2gKpulzdYyXWAsz4UQLPl+f+bFRIiJtF
	QnVcOIAXlZwX5QpuYE+a04Od7X/cexzX/sN94rYVgs+HNDv4IB7+bauLgSw1OnIv
	+Htl1Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjehnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:56:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24919af9fc7so24682885ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 21:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788973; x=1757393773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=gx57lRgP7084CXNi1lMTcyTUIaNpBz1ThHRknmJMIwpwM2zahEtj0fY3BUjKt75iiU
         dRi6guR49oR/mG+MBm5tYpKFTQOK1wA0rlg2lsLUez88uQxYbq+b2v0IQc2LfylwRUVV
         Lj0pn5QPMe6N83iIVngToFs1qH6b0q06cm2Ox6oBV1mPNlbgyRx/KWs9L+ogJjwin50a
         XuUKhd8F9b5fO+VJL4anD1B4cYr7TgkNJJ4Xr2T0mSoiY0iSFIX7sG8lSXPijZwlaHYE
         Y0JD+AQyAuO08dYsA52Qkhw9KyEhf9kZVMYoy2xjm/9vvhxNcI22zn368kaJ/qJiC8Tc
         FwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+J3M/dV8w/cUCVkqGdMkM+WP5TK+dBQcfpns3qj/yGBvNcF76xJdVu82YC5Ek42LrUeO8sdr/jt67tZiB11s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlhO+Ye9byUY3iudyuUaF0Qol4ieC3NuZAkexJ95bhz1b5RFw
	0y/zBT9UYcf/G32YBU59M+qIWkt/9XiSk0d7N5Dwwlb+OU3AUMJLeQO78qM3xgC/9hMq/cAxEUB
	OTTAGqK7IHsobgNBu6X1Q5BWOYhia3vzZWtGLsUKr6pOF6wMIJ9BijC/udIKS7Ph4ZXTP5g==
X-Gm-Gg: ASbGncsgcEjP7G9dhJsU+mQqBM5wEA4LZUCS8ZmvXF+FiVTuTcefDu2IkGxF/93dm06
	we6Mm3V2MwzRrJBRAgju8yJbOGIYcK5qA4WMUQ9k82IqyHeMURVJFb4IvL6IrHFx2SS+7+TC0G/
	/VvDote1tRjG1vZdvXTz5Ak8DbfCwrraXrrqNVyTKOikaB9KBH2G4+TTPbQdXQsT1QJL2TnejAb
	ZmsOKHnGqjRJdcIKO6UgUWRl8VrOITsuJKAdwEEJaL9wxzmeZYiYtlMPwUvB5H6sviokMLqBSrU
	zgbJS7JWDLVw10EGNREB2Nwx+5GO6Ab7NnAZslafOtZO9dOkvYOyH90hz/vxbEnNdaqy+DdHsoK
	g0vbtfJzac/aBzjUq6na2Rsk=
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474825ad.55.1756788972847;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvJn27s/WB6VKXSdt4GGDpr0OsZic3u0pMEKyv76QDPWFnyOWUl96Fri/gUJz77+TBs2FX6w==
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474415ad.55.1756788972346;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:11 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:48 -0700
Subject: [PATCH v9 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-1-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b678ee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 4c_R1uTU0ydBnSqb376Hrf7UUvMB3Cep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX0+NipFnfbvXy
 hr9064PgPFUmUKguud0eobCnwCR9yLi91tvmNXhZKOQcETnSoywkoPgz4Gkj57DHOyDAOhwWL+8
 T8v4b5VVYTf2xanpl5t1DQr+9qYhsYK9XutUTcm1iFOabw03U87ZlOFM8Mcqe7OhKoG+kvkKsPO
 35nT4HsEp+tSJFzGJFxJ7UBYdEHMpoVtfYstup1CiRoH/Tu09PID5+rZkD39tcM6xl57NCqMyXi
 zfDROUfC34vzUOL9blFzrNrcOzsXi6BTsOf8bXv8rcSTJc3lb2lmERg+/TXaMHNc3BYHs4XkSgT
 xr9Jgdl1YbGNn8qESrYLSdRUnbY4N2oPsVJ9JmYOvLig/9ipHc91ZpNT3odYct/z+Eu5PIPrtpX
 tq2MweJX
X-Proofpoint-ORIG-GUID: 4c_R1uTU0ydBnSqb376Hrf7UUvMB3Cep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

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

