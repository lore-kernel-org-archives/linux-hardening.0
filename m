Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B41AF0C1
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233958; cv=none; b=GenSQTeVwD36XBiL7k8OqHTxFR+BX6RWgRcg4oixWoNOt18lu4q/MD7QW6rpvvPfnTcUjTLhO6YEYMEeNmnd9HwDI8UKqrChCuTdsus9sUdBOfgpmfs/FjKm+P+DgjOok29IoTtZgrJify1FcBczU2c60aFobC1IY8yi4nPwBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233958; c=relaxed/simple;
	bh=f62ojl+o4A2l90TEjbig1mzXjGY+K9lbk5ckJztb9fI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BeI80CeRqopJAUoLW8sv3huJw0/Jjn/ZzMyH70ESQ9PhH+uawUuQBpQXMq+mc2BhdMaCEvVUfiR8FXTYV17jAnqvvHTqlse4bKqEWzdXyb3R9fBaQLopWql1AQ+535gzOnRhhHv304WSQlLXrJCtgSBW6BwDAfeVBqTw2mrC+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2GX2AuS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2GX2AuS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HA4YBM025359
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 17:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=; b=N2GX2AuS7C7jtsmU
	utzBsgrhMK8REKcFP5qyJPfU6W0xRQVGyB7jErhersrg7uIA6emij9BKup7Fi/GV
	SV2G9K8a7KWDg/s4Fpl0Znty7O52uIp+KFrbpNUQfYdGLq6X+WiWuoKIyFEM7oTG
	CTpfv3hqXHPtE4W75+SRRAj8bkcSpHQx35FdXl+56M5dWJEzmrIOkFOnlq6KJEUw
	scw19AdC2K1nUu9TSGDl88efrTXo1AgPdMQs+tTKTvR/pzSshUXtzJKRNButHGVY
	eZVxQnqGg2L8Xn15dM0RyZjjTv4P2E83wb/02nCsfKpqV8JEFpwJmagKJCKEV3mZ
	hV/dRg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3wkk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 17:52:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241e7e3addso69206505ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233945; x=1742838745;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=;
        b=emWMmlox3LL4wcdTmUauzA4Pg5qlttLCxj0QN6xybw4TeDy7/eLV6gzjc21r5A6KTo
         Z5L5eR6vfyWyOA8af+duYC9+Ao9ZNpvYsf2Os/EcGE1p25HoFxXWiy/7SbQx1rSw0BZt
         7Y6aPCvDO6/DSYUQFe8q4BEoPUV3MUG8fSwMRo9V5YsJ+xkQc07nZy2abR9NE7Pku5/u
         gTKv3G2SU5FJKMLGlgseWx+otCkN1T31i2mgyHkO5bf5yRsY/Ten6thqaH3N5ysEEgIH
         LTMXW8BRUTEEwUZvK25DqYOAwMPzWe/1lxZNOsz49G4S1Y5UEAJiJEGORYTsmX7Mcd0v
         dGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZcNZ2n5Qm4CYBv02+v53KMlKrNQLmfRhv5dPHrwToVqFjcG9xe6J882m427wX5wuQX58NERSRQbmMCfiMGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaeigeeDDSt6ifCkPyN+mNPh9oZuDAdI24EVy3SRUZfCnYzb+
	xsQbkHNLBNPxLCBnXyNhIfM49abmdT4kw68JoeCQsJ4KHv971gYEZzuan+zbXZUGFGLqPdZGkgD
	z4iSlxTWHOtkN32QeuN9Hrbnt9RXpD1EOR1e5NBOKZ6BXVFUYPhLW50OT3m8Nrp17FQM=
X-Gm-Gg: ASbGncsmccMQ7Cg/6jF7rb4hrqxAmYsaMm8OuP11bCntkivi0BmtWLnncqZI0/7khgU
	2wVWrQbZMNlnZjwwSJ2m2MRqwRMrK5pvecP7qnK4CDO0v61Kxsp8mm05eAlDvOj7yzhs/Izt7F8
	wi3aHb2GEeKBsLe5203AVjBKAO321I+T7Cs/r6McCS16PeShVgS3XhvGsRKVHARqZuw12nhZJc2
	TnobCmj9B8MaGLeFpQOay5ESME8/vlG7ih8COhqF3pnKDlO8jy8AHdBv+29UyJBp8TOuFmH2SL9
	Bsqglql1rqraE6QGlnjiJWhJ1K1bVadzwLCBjcp+a04MU+PYGUG8
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184232355ad.43.1742233945098;
        Mon, 17 Mar 2025 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIwZ/XaW2xB5u/EDFQEQhDMqg39v0rU7Oq0/roBytKAynLPkZcvcV3MFWkdWN+E2yf8FxAg==
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184231995ad.43.1742233944697;
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm78291485ad.252.2025.03.17.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Christian Lamparter <chunkeey@googlemail.com>, Kees Cook <kees@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250310222339.work.654-kees@kernel.org>
References: <20250310222339.work.654-kees@kernel.org>
Subject: Re: [PATCH] wifi: carl9170: Add __nonstring annotations for
 unterminated strings
Message-Id: <174223394380.578193.6449253449477522706.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 10:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d86164 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=a8UXU1FYSwnUjzW3zpYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: PlcSm2JYqiGjFtTkvbmfhbe_MfKRUVHp
X-Proofpoint-ORIG-GUID: PlcSm2JYqiGjFtTkvbmfhbe_MfKRUVHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=609 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170129


On Mon, 10 Mar 2025 15:23:40 -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: carl9170: Add __nonstring annotations for unterminated strings
      commit: 9a1cf85c9c7cca15bfc452f207818977621dedf8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

