Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271D388363
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259787; cv=none; b=hvt0nSGwOVnGTLPOz6ht7/88oOZCTn1xAT9rTmxv75820XNLFimeSsfKi17jpRuXOe+Fu51AeFrqMXmEV9GhVOWzhSvNqDofSVxnou8gEm2rbJdy1fNJdhVM5R3KZznaytqH6EuyW1qWRWA1UeowFhivknh5Q6JAg2qPVS8x0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259787; c=relaxed/simple;
	bh=be9bYc8p9EIUnGdjIf69LDNuA5uavvc9sw3zZw5cDiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFEu5TRVVgGH0bpEZdgHu8Bb9B6BqZdQT+wF5dGffqaajBqGk0PFQO4J++N0ruf/B4UBlUZLYG1lhleh+UgyX0Lr5q99kAXbFQuKyaPUXLTsQSIHxwWIukI063Ulwg2W2dmYCI9qXQTYgoUQwBDZw4JN7bLH6k+WoQtUuM9222A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBDYcwo8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CK8/qQM8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBDYcwo8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CK8/qQM8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7trt33468141
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 09:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0L4WkgdbL0ERVJyI8K4T4Krrj8ZxJ/wrVMo0PWvP3Gc=; b=SBDYcwo8Oz+S2wkK
	Rg+h+BeJmC0oG472ZkXGybeXzvSfoT1l7wLDl6Qhm+TadRzlv9bwpym6jjlrDOIo
	JW5Qe9ABGQTePMXtxDfFwqdxkXc7CXARd1mja6hi8UJyxz4lt1j9bFc+jKzmlqE9
	krbymC6H3qTRKYoPGdBrnv7qMQbPI1TLc9WimmL1S2QXsBVNnhvGU5Tm1SOYBQqk
	hTg7pi9k0UPTHg8oznS3nEI1FiO55vznIaNIqf7eVqHvpK1HIu+LpN22Z3UPvBrD
	ulV4Kr1uZ2NLFhL3u8RJOkTz5IsBrRkSyvS9KBiZ0hEmiz4893VIRuLEfG8Voa0T
	meJjLQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jggejc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 09:56:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b274f94f8so302941961cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774259784; x=1774864584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L4WkgdbL0ERVJyI8K4T4Krrj8ZxJ/wrVMo0PWvP3Gc=;
        b=CK8/qQM85oC/uSk8znWyMDWwVOkv4oIRqJHVTBw0BStrnCqER/NZELFft7dVrYBAg1
         a55q9LOZya4ex6V9TrqaBMoB90am4QIY8hQ6gyDFUZPO7RyKRj0MAhURYvZZLhwYDYF0
         +1SYnjcRH5Di5xpGMYaZSeWhRtbNw/c9LPanDXlBg2jjROLHMqeAtzRZQio6JeSw0Y49
         iDmc1KnRlAIsZLJyqO0+kBbTVZR0JENIyBLnflSlPFmgx8nLApO5MarWNeqO87hAvqNY
         gMRfHP+nlOZigjpawRsxvGY79O2k0dKdY6ihimDoXb1sY4BfjlwoP091PS57p5vIu51P
         h7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259784; x=1774864584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L4WkgdbL0ERVJyI8K4T4Krrj8ZxJ/wrVMo0PWvP3Gc=;
        b=dnXAs6pMsiNVjRyn8yJFx4UDdJ15ElLSRrje4bKaXYAntOxt0ALGoKoIEtR8MphcuQ
         T61qPNgn0hEIiVCPPs2tkP23kqrclwpo7d7xqGBN9DZU3ZEwDOAemKp2Ib74sod19BEm
         cQKQ1t+T16QYrO/8xUxRsA57MgEuQ6HdFrRb/OaGjPuXdRU+HEMfoK2HXjo1fSByfK2p
         s0BeaS8oWqRFAr8a8wAL3EuN1YV5kr+VIL+MFjYTp5r/OUHYkat2V4Qjt/IA/VBR4q0r
         8RIhVaZdeXueLDGuHHBuicW60b3QoB/cmmA8HbTKiYvb6r7R58eHFrFssqOpApsKHY67
         6+6w==
X-Forwarded-Encrypted: i=1; AJvYcCW1xt9ep5XQRsX7b3kMy7QvOTU5uQup2tG7OoN52RwQCGakC2Zr6Q+aZnpKDcjj5YxleCQTKS3gmHdf5ZVg2tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ucROS50w8djZe2NiUfRJR73mMYmR0ZVV6yg0ln0E3VmbCY6D
	9W4sQS0E8kjMFvuOWmz3G3x/CKYg9wnupQlIiMrgI1uwKMycg0mb6B54mrfLNs39UjQYN1G6m6c
	a4mDfx0QaIoc6ym2iruibv3V9QM6+sa5eMIAYVTC9V3nNIilTDqljiB3aNi8N39e//UQFZw4=
X-Gm-Gg: ATEYQzzr5EVWztcDMpf/f8CN5vZMNDXvmbzARw97d1x8i06Ajslx1UJ/3kNxPsSCgKM
	kNCclF7Fl/ZxtsuwU9vYjeqzDir/alrEYJEIcYke/OhJ/I+t5DHdFT87sE488F2d9vija2vqTFl
	+/e5+mQJVPNOalSo8gKY12U2mTs+oWGCwRDMXNzmLTKCvPiO2xTQpHzxu0DfHmqJbOzE40Ro15R
	4uJLZa1NO0UtTZGJZB97TMwNwZUZDGsT9UZEMXzX6Z5EqIKvDzEV1WTH5YSpV5Mu/Ip8YeU4/O9
	pQHGBRQCVF4iTntT+FzljvwBWXkv7NH0NPHEFsV+2R3T1n2RrBuC5j+Hgb4+idlra0S6WKoHySx
	fFHyNJDJOrEEOxbTUuf4cfu2hEtrM2e2dtyOQ4gdIXeIES/HY+0E=
X-Received: by 2002:a05:622a:8d17:b0:50b:3ef9:7985 with SMTP id d75a77b69052e-50b3ef98021mr115749781cf.26.1774259784472;
        Mon, 23 Mar 2026 02:56:24 -0700 (PDT)
X-Received: by 2002:a05:622a:8d17:b0:50b:3ef9:7985 with SMTP id d75a77b69052e-50b3ef98021mr115749651cf.26.1774259784077;
        Mon, 23 Mar 2026 02:56:24 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:abd5:2e93:595d:57eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668cfdb4659sm3688967a12.13.2026.03.23.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:56:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gpio: dwapb: reduce allocation to single kzalloc
Date: Mon, 23 Mar 2026 10:56:19 +0100
Message-ID: <177425976891.21144.17113953246213685933.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320005338.30355-1-rosenp@gmail.com>
References: <20260320005338.30355-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4O5li9349TVcul6EYbJkhbl1L4_wWsKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3NiBTYWx0ZWRfX1vA3q312NIcX
 +PS4oAFeaznUNjPVWZP2Plm+V56r8IYmkfX+Q4r8pPdn7lkSjwLugVU/tCv5HxZc2nJOPB9qrq0
 WUjfIcbLaTMDpNv1eVhQkoy4X+N9PBVSJDWAxrlW6pBY78EckVxKdpoUl+PCKGpjEwK/w0mvYmU
 nXrxDVOVg/czjDAE3M3FWVTVS7RZL+KAQLZUmg4N00MzREcOfzed69aqZgU9Fd9CyhgaW+L+7yl
 Qc+xLZoSXvyVLoBZ/aw6RMLvaSSOFi4TE6cVAWRzbzSpQX/dWUuQhyF4twi0dJXPia3AAPNeOPg
 fv5T91zJUohHEIamETsSeRY/tpOn/gDCzCGwa8Oz10SNZKHBw2yhYeee3EwQXbtlaeDFCoop9Nc
 N3F/wCQIPGfbKgghzQJMbvV59T4WSf0pVAKuwTCVf+oG9pnBCSvMjtZl/J3wgsiB1JzhO2WbP5f
 50WDI5hYYpyAE7ZhoYw==
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=69c10e49 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ek9T_fdv5d9Sg3W4T1sA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 4O5li9349TVcul6EYbJkhbl1L4_wWsKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230076


On Thu, 19 Mar 2026 17:53:38 -0700, Rosen Penev wrote:
> Instead of kzalloc + kcalloc, Combine the two using a flexible array
> member.
> 
> Allows using __counted_by for extra runtime analysis. Move counting
> variable to right after allocation as required by __counted_by.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: dwapb: reduce allocation to single kzalloc
      https://git.kernel.org/brgl/c/9a5bf2f53b76b1619c602f9e751fe4c0e64713ca

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
