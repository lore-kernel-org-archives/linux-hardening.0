Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FE3BE65D
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218785; cv=none; b=BnGSMOmh6ZXFxN9JsTHgcm4EsvIky/dZv/PsYtdAFjg7olWqHX0S8Ak5XVLa5ufCHwKdbAy1RjtYZ9NzlhCM+P2x2KTye1DjwXwpG8wqmIvNRG702wHWG146YnjcZ9/9fzRkfbgi8vvDE7MBJeNgkvpHcsXS9wYqI1bwwLlTOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218785; c=relaxed/simple;
	bh=P8Z3aRg8c5RsXqdsgyV6sJ8PSh4dn0GTrc1mkFTKoDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GO4hqq4T4dCdTGSnbeRipA4F7aCp1M5ITWI6nVrKAzgMXn1mUK9g47KimA+kUqB8M2oT8u7yKXj3bg6Gnf55CU676xYWGXpew+dU26ZfFH6rcvvYnBv6qh3nVICWsOgP4ZBmZkM3vnBbPGRjez/R09u2bwp4+vYw7zvsHY/QvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSRIRMhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AFKwL+Ia; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSRIRMhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AFKwL+Ia"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3sauM3892673
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnt3yTSJaxJO/yAVJ9uGDS14wEhUsP8e8yGzBYhzhoo=; b=YSRIRMhPtyFl7lFR
	VyyCRIuCqstKgZBF70TvJENc4P6m+nIChJz0L+4T35S7rBjoJIktarPxggqPtdMD
	FRmj5+rDB0cQCHscJYkEfYnThp5A1O/G1iVUhNjR4WKGWAk7Etze1nUFKkYMxo+f
	eq/dCn6YOguaDGqgyVasksvBbJMpe//1PVvYfPqPZx68FScvkNIDvW37YYjcCV4c
	uf3kHZn0pmO9axIChw6AEEn68Ilr5L79DFD5k79FiJBc934KvI6mWrwd1anX2OWj
	2QB7C9VLAWnbAtic0Xz9KPGR9fT37nS9M87dU0GSdPDMwtZSoY7WXAjB4Q6gsiYr
	a1zBBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyuvwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7fc27cf7so1997235985a.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773218776; x=1773823576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnt3yTSJaxJO/yAVJ9uGDS14wEhUsP8e8yGzBYhzhoo=;
        b=AFKwL+IagXUAA2DYBIlrKTNlWrR6ReLn8HbGfccjZ9sNuAuTCXad0ErwsKYqd2P+Dc
         KzlMEkgXkhX+Cn8lScQKDhyFTJwPDtF0AekIFPbN73ymhFcZpDocghhqvxyrVEyQNoMa
         ADs4CmuMKALNq4R3eea7T2XB9vRwAU126zFD7/vEgplIniW5ulD9f7/j3H1ZmNTZCwh5
         EgNGtTVFxpJh338qhM0RIO0tLXT6onfnRz+O4mSTJDK/5qKIuiEIXXROduN4hFV8VV1u
         SQPjAUC4Cq/FK3SRz+WTyGxazcLDPg0j11bDhMdXrl8vwMLAtcrC80eePuYH/3AxBpyr
         P92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218776; x=1773823576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnt3yTSJaxJO/yAVJ9uGDS14wEhUsP8e8yGzBYhzhoo=;
        b=G4tPuhNlEKg2s2M14xbtlNBCi/3kiUIVPClrET8Re8Gel9HCD3261Wq8lfYAsikwZL
         T/15FOaPXxttaM2sOhT6PWphwTTJaQEk6MXbd/jvxoqXKygcY0yHtzaI7bXVVGFOIxPk
         TpTFh9RqKoKTyMWTZwZ01LL/bcMPftTmcNbgklJCfzhNKDu5unQELHaH9ujtsK3JAD+p
         eno/HtZIZm/cXOp5bGFcVlo6gry7TJkeVyndDB34AyOWDZzZNwIMAscXAq3JAMNOMeZL
         fjWvhJcwasO8LsgfnZ60FKsUcJJ258Gg65TxaaBZn7k2vnNzsNMrWo9gdAPeHMb3CeTK
         993A==
X-Forwarded-Encrypted: i=1; AJvYcCVe7521NIenXI3Ly4MS96Q+XGqCencwAmzXQEEsWxIakS39YcInl5qxJESOrcB3OkJrmouokMVn10pC45dLHTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziF9DK/BnuTyGbo1QgHDcMMJtt3njgKoUKVCyIY62EaMc61QLr
	H9VrSj6+Mfnr5iY+pVZI9QzEoLQdMTR64b1e08QWXvBG/Nhx4yo30IvXuDSqWEXrsF2FLNPGmWg
	BvB0w73QUC+oJaZ4nBgKd8kkot7Wo9QRQ0Y+9dwd2SnhVBiqLCf1v/lLAiK+N7Yg1I122GZUCjU
	NFtOA=
X-Gm-Gg: ATEYQzyhmOcdDIWBmB+9qPHzOw3rmnlzzVSY4S80jZYf+s/OyIRoiaf1KQ7kd03DQjU
	nV9cN/oxGhEWz3CN8wqZBBSuctQxgIVDiBxet6nv2Wk1YepEeg0HKvathtvHZbx4u1GuFQl9gX2
	NCb+jq+Zr46yLct79XQBwxCSYYz3uGTlLQ+9As0SP8JLaTzUY8QPaft71q4qY+dazOxeOYiA6st
	R3XX2eD6loddUyp+zo4vX7FGAmeFyxKDYCoXfEgOhfH/luUtV1TJ+n+Jwq3JyLjfi+dZLifLAYo
	lrZolf7sAu2eGyl4HePBAnfMghc1TF70ALqYCAjz7xJgSwb8Kr3DuyyI4Pjes9k7azLbVwOC18y
	MtX+oZEzGjdCFZ/SH3UDYH+UOSX3RydjHkDf3JxpAhpV+EEPlRCE=
X-Received: by 2002:a05:620a:2989:b0:8cd:8ddd:26a3 with SMTP id af79cd13be357-8cda1aa41a3mr206247685a.48.1773218775976;
        Wed, 11 Mar 2026 01:46:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:8cd:8ddd:26a3 with SMTP id af79cd13be357-8cda1aa41a3mr206245685a.48.1773218775555;
        Wed, 11 Mar 2026 01:46:15 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1f4c:200b:aaaf:c666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81fcd65sm5503816f8f.26.2026.03.11.01.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:46:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>, linux-hardening@vger.kernel.org,
        gustavoars@kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: htc-egpio: allocate irq with the main struct
Date: Wed, 11 Mar 2026 09:46:08 +0100
Message-ID: <177321876119.6763.9079303881840248589.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309225204.44789-1-rosenp@gmail.com>
References: <20260309225204.44789-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b12bd8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1JiJqiyCQh_NQNgg8OIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Ce0NjvfAY1p9f4FAA_6rXmm-8_ACqzx8
X-Proofpoint-ORIG-GUID: Ce0NjvfAY1p9f4FAA_6rXmm-8_ACqzx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3MyBTYWx0ZWRfXzNsWsOcPcsta
 w0qtNx5XmBiKyrNr+/i8rr2m66K8JZOfINV4GPAfvu5ccbaWOECCApVOo5hB9y+qGr906rxAgVR
 dBqDDKay7PKD5Xg7IFq2Oic5F4uNzUysdeZ1sEeGpiPb7tEk+MfpJp+3/5HBpmlnxhQgHHtrlW9
 99DRRfrdMxPxu6bVWD7a8+4N1fuuOZjOHdkJbOtvE3tbT0LMBsOWuJoOXMnt+lyAjyZvgT3PFsu
 ugEmuJgkVy9cPHe4IB4xH8imiALKkTD7NmejFCUa26CcSrZfeSDQhGlFc7D5pTe29Oe/gFCSlBC
 6pij6dGTXqcDL1/iTUjMFhpTktzTJ1Qs4ncPLgBCSRRLDJDGbo5y4CZQzAaJpPqEm0Km8tPvQYh
 Fxm7GTjusgmMYselcSBQNBrjcFymBHY87PImKBzG4+WHzKmWncXZ4DytKlLMJQWxIxMM7fS2WFD
 tEufSb+AuXI3387wAGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110073


On Mon, 09 Mar 2026 15:52:04 -0700, Rosen Penev wrote:
> Use a flexible array member to combinwe allocations.
> 
> Add __counted_by for extra runtime analysis.
> 
> 

Applied, thanks!

[1/1] gpio: htc-egpio: allocate irq with the main struct
      https://git.kernel.org/brgl/c/223d9a310c7bd785f08320de8d2b66a5af6a25e6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
