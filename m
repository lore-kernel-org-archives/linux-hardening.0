Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660840D58B
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220886; cv=none; b=qLYXSq3oaKnmNt++d6gkbIlLmZFDtYdjuRZ24WcS2/dzYw6dq9B2abhTtDcUpq+yDHeDmR6VbmpzQwHi3dc7P/O8bhr1O3tOgWSr3muvPsTKHaPZMmyH2+JHhn05Re82ItLZgjWTBwJQaU7crfOe/75nStnTsHdXLPtff2fBTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220886; c=relaxed/simple;
	bh=X8y3v8iSC3IAclYNrqRIQfkR16kO7jg414q29IlRxqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2u9EKAwHV5pcD1+sMCSH1RLFsX0Bif/GM16U/g1bHt5YOP+LqRzcxSsg+1UL4VsoiSZh43oXrYTR5th+ijzvDlo5JV3jtxmmOiHfBy8r3caJecG3c+EioCIe3Cg4Ho5/0a8MYIASaStEA+1A5a6bnOINSU4hjWxOsoLgv3aebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6OF2lEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBm7sTNG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6OF2lEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBm7sTNG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9JCM92927108
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KHYsELtpGLLEt+3xi1H3gM/7xSFfDKi5oNRL0o5VJZ4=; b=R6OF2lEgK6gOcZHa
	vIv1bRpXxjXfv7JjDWrPzr8Kmn8uXHCvgC8QRerddtRsjlYdiqAmuFiWr45ffaQp
	nVuoxYkoNsMBi1e4bQZNUdOTWiJXi2a8qj3JnkwBgSkr8j7eEiWRU1TEDFprYKce
	hQrnDombFedtjMuSHbyVOAMLsB0UBz1vox8mz9UyHZXpGy6CenNsqhnEhUbs6Rvp
	h4bXJNfvP5MfwCnsBuUdY4Yhaq4nEyDeLRhjx+Z1ooAUwItPAZQYevTezeYlECFG
	njXZdy62UzSclQcmuNp9umjJUDqEaiNIG9uBxjqrzNrlIi2OuWp4teAYCy+48dBW
	Wklv6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk078v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:14:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7ef17031so271781cf.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787220870; x=1787825670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHYsELtpGLLEt+3xi1H3gM/7xSFfDKi5oNRL0o5VJZ4=;
        b=RBm7sTNGqUktCCRwz69BPpahDNtXAKTrtgmi+FpwqL6qU56RzCZHYsWfqIgOx3302K
         t3lXhCOoe4CmVqbQdR+guPXEG2Y6XH2Ue5DxRN25nO4dkXLE5SMB4fWflp+NrMngpvkN
         f2vT9J9je6i8w+SnlaRzbGsNjmY2yLT2CKT0uE2XSnS9BAD5WImflD0sSkY45UBfdLZC
         Y0/riCCmo+eklwuRWbZUhbNjbNtwceQYpq2VveApICxMAmFROm1siJrVZs1MIrkh+OIh
         fUB7zqUVJZ2mQl7jvmVtC8gbPgmaFUm9+YqyD6K0L/sQbutozjjHUGgupbQTv0v65E33
         ZooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220870; x=1787825670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHYsELtpGLLEt+3xi1H3gM/7xSFfDKi5oNRL0o5VJZ4=;
        b=TllyiA6BGAkGncam9SGtYx2iZ3zv0gb4ZWkbbPsJs/Eex8LPNm4LdnIEBXoNV1KkUy
         YjOK+3DlxAtwm91D86sLGsp1zNXzmblxEnLptp4FM3AQUnjvOBfq4F3d319VtsHt/hY9
         EuFAiEb3vHxTI5em2lilZeKjoKUTB9JtsBp0vPD0ApxkiB0lk09FlY380J1dftQjZgNE
         cHFas3IFGL1E1BlhvxYQVLe5Z8db3GdSE4+u7AuGkXUrWfrRWqhZ9leJ++FlHFt1xAu1
         ANxlgpr/7JwxNB1VNN9lD8t+2cSecYTUEh7kC1P6ijeiqUTMP4+e1qR7noSovCAsugfT
         FlIg==
X-Forwarded-Encrypted: i=1; AHgh+Rrc/y92weP0XnLoYKybJDVA9Dt9iVf4vSCT+Co9e3d3ZMQKo9XHnHNdRussbaQ4446drIz6HFM/Fl+MhiKvcg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIVrGnezWO6HzJSmAZyUNHyaY7aarxKKB+RYdWMq9PtpJX/Zx
	qRA7pEuCJ2vfsb1CtVL14kXyLDgZuw1Qv3U71tGNjMQtDwJdLjgsIi2qawbwINAleqa6rr2hENT
	Gd5TU6EHHuOyPjUK1WZHzAxPRhatOjARw0Vatd0Txw/lxnAuT3pch0TY+N+zsmVgDOJ3CbMZIdg
	N0w+I=
X-Gm-Gg: AR+sD12tj40jW1ib39afJydJr/5QYJgIc2PEKC95K2MkhU4gca3oU9miP9l12YHQGe3
	RBP+MfcXw1gI7zDgI04FIiZ7ee+b07etavo/AEPqPLMhq22e8LIPdtGJYjBqUR56166JFCMzCYU
	VMQfbMhQ45u2BRm9maiIKKc8p04pRrFSFaDh9pol8CMH7yvbYXl7NqXZMtnPKb2iAmdpl2xTh2x
	gXAPnwOvQWjxqWIYiB1PP+bBjsHBAfXr7+Ns8Fi8ARsFa8ZuRCFk7lrXm8kfij+UgoswdV9SJFJ
	laKwR2csXYetH2GQx7a4QiHaqPW56YX8aP+VDdXvqZ+Iusb+nSDbp6ZCyz8wFe1z8s8pIqygthR
	nht93sTso9aXaO6y46D4OBMs4
X-Received: by 2002:ac8:7f0f:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52dd5dfdcf9mr78319641cf.4.1787220870010;
        Thu, 20 Aug 2026 03:14:30 -0700 (PDT)
X-Received: by 2002:ac8:7f0f:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52dd5dfdcf9mr78319291cf.4.1787220869552;
        Thu, 20 Aug 2026 03:14:29 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591e0397sm49055166b.53.2026.08.20.03.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:14:28 -0700 (PDT)
Message-ID: <f0db00f5-af61-4bc3-b607-1ae3a399745a@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:14:27 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
To: Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
 <20260820-next-patches-v2-7-7130d68183d9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-next-patches-v2-7-7130d68183d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jK9XA8wSJc1oGnchd4Gj7S6Pr6iZH9H4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfXwUevMaaZXr4Z
 pPCU8FRAgAoBtuTaxsL0SWaSlv8qBVeJ5pDIIoLTa5NQqlsih4rqAUXpTnWVuh+pY2de3jwM1zc
 3/FZw3HRaPhBRig4c0d/V6GC4LrdM30=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a86d386 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=m8Yw1JhN3ITPm4ObUbYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX0zNyBVGKe1hC
 Z0wcJzUsGF1IuncuGhp5PbwwoGkE0xRmgyk/OeXOtqJYbN7/7JSztjZj7jZhGF1+8oPnkQowD0H
 KLkFzpvF36h1zu6kmBlFBsam7mSvH5DULUvlzsFIVAbQAbmM2wZmi98tfYO/baMEiQVOq0lJc1j
 YABVFGOYmm24hfsPYjDTYjGZnht/sojG7yYjJyf47tb6rpZCv3T33AUkWvdGKl7cD9DHLTqtYoy
 piRPxrE1EYwO/tJvH7JbY8CCVXGUuVifepvXte0Uj4hTXgtKwl6l37k0IcFnA59p/z/hakfGBJQ
 vFsZ0PJvUOHBpmwMX+hS2GaYjzLF/QHNJRTTCdentKEKmksWJJW0FTw+G2P6sF7tEni50pcar5A
 7ESBEALCChyj/SrMBDlZHLcFHETvMncyE5hWcfnGu3ESKAku2tT3JCgyvu30dTU64yEcJNbCeMH
 JFVyO/T/92FqbCVhYhg==
X-Proofpoint-ORIG-GUID: jK9XA8wSJc1oGnchd4Gj7S6Pr6iZH9H4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200075

On 8/20/26 11:42 AM, Adam Skladowski wrote:
> Add a devicetree for the Xiaomi Redmi 9T smartphone, which is based
> on the Bengal/SM6115 SoC.
> 
> Supported functionality as of this initial submission:
> 
> * Display via SimpleFB/SimpleDRM
> * GPU
> * I2C peripherals (Backlight)
> * Power Button, Volume Keys
> * Regulators
> * Remoteprocs (ADSP, CDSP, MPSS)
> * UFS/SDCARD
> * USB
> 
> Device tree also contains supply maps to other subsystems like MDSS
> but due to missing dependencies like panel those are disabled.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
