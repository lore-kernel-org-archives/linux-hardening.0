Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F28463B7A
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150450; cv=none; b=PXdkfVPiyx6ZSOHKT2LdxhL84Fe7j64ZXblZKudsegnV9ePb6dBgL4dgC6QnFQjkjEwatvjE6hKT0CsRsUPvctA3KrhyxgugRNXjrvnTstWcwEoFFUP3cATjIfptRvUTdDwdKgRdO45Mdh/8sCkueX71O4ZbESfQS4ck3y2vwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150450; c=relaxed/simple;
	bh=JwN6hTpQMoQFMwVkfyByUPHFjCGMZVwMl45a+afjvpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDlg7OYm7RM5UhttwF0PUF434JpVcweQX21lNuyYxQpQSsJqoEGZvTy6IV/hQvyrH7EGoRhrPhjbRxbME6WR1uA/yxlp8s3WSqcEHqqQ3N2HnqubYxMkxuPFPBv4MeKjmIlrAouO/4sQG1LXIVi4bbGOIuXztdZL2w61cvD5C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSn+6HK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsQRL5qF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSn+6HK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsQRL5qF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79QoT2819106
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 08:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=; b=LSn+6HK3iMvlf/8v
	2vGE28m8DpnxLe0zP7QeJOxg/CDxJ9LZFz8fRoUfug+UhvaY4RQnRcDxF4ygZ6mo
	eBCOkj8k+FvVzO5s6MmbvehNlRZkFUvImuPT1FVBKUR29QoRgq4C4yNO2NU6yUJG
	ayjiatt/of3JYKUCeuA203Cb+Ol9M2oG7iyudnNkNAz7OsrzrzJMGBgl51EPav6a
	l3Cxy1w7ZceleOiTAu9i0WGM0Ssh5pk8baya1d4MsTDkS79trxUMUf7msRHiy26T
	5XGQubQaeeE7QQ50toylZIDDSST/25DxG6Fw8mnlZErDWzirBc/aacpNYPtwMJzt
	Iim9uw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n0v61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 08:00:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90cddf4f59eso14209006d6.3
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790150445; x=1790755245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=;
        b=PsQRL5qFCmE/loHsC97ocj3utn39DkLM/5YdtHTimQXaPDiVU10eXmEUUBOiWIpnKM
         4F1NC9ZxnYcK7ejDszE9vxbcOCLh9N43UxiaXreCnrVC8X+wtM0YEDjgVUaF+jFN3qcW
         kVfZa3i4fT4MEt+cpaQMNi1h/8/V96tJfuX8yvcxRYtsKyePxYkDAGme2mywlAxOT/bK
         K2dHc5lYXQJ9fHX57hXPX2bfMDPzecl45skt8KfXxhQBtnjLEimzOCmFk9gLCiTJdglv
         PuC3rbPS3HJQZ+beIOClbfw+Da1gfLuLzC+7ojVbtF94QqNo0Z6CxOxtpJq6v6ySzYIw
         uQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150445; x=1790755245;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=;
        b=fN17MPI3PPoiPLMM4arpDbgtxeuITeTtAg21X5inZK1b2/eXvBVhU+TZMYiqFh9RS6
         9iySyWTEKc5aVdaVfaMtPKdHqpBPm++ozgkHgq/HJgpl6Z+Z8S3daM6tRVPwY25oAgDA
         ynI0m+HE33SI5TVA3wzwL0nlpimyJirPKq7Lec+D0b/WC5C3LLckw8fPleRaD3gysMv5
         czusKTDHO14rLqsnyRjTwvRgpoYz9xVL/ISx/TB0q016MgcC2cvMmYX6HppeAVFaYpwg
         W9VS1OhJwxTlCXKh//MNQWwBDNq5uafQnnrGFJHvDnWCeW1LrHK2uPDr3haMN7zvlqxa
         YK0g==
X-Forwarded-Encrypted: i=1; AKwUvBwncOo4UivW1o9aJ2iaETZUuliwvIhDazHAwQMlJmYrUek+PuUCK/znB0HbnlbeHtBsiJsuJm7tgB/Ikd/2GnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kRdPxu76C+fjHElLThnTJ811cG0eqIqds+SZaydb48ex4T0erk
	2hmu7gwBNkdUgPE2jbkuTkbek7RV8TY24uBXHEDrUmIdxuejHRyg2tsKMk6sbYIaLuSgkCaZPrt
	LqsYAbKhpzmwY/P+1ggiRGyxF6CN4DyrLo5ayibsyPKZdUcnywW5baIV6/6OKCi1iycNXXiE=
X-Gm-Gg: AYBFou398tBKquk7Ox7JkZW164Fjk55/fPyJD2+h6G/CSAAYUQauf8ZitoEjjUiT3L5
	Oe3JKl1+Dg2KpqZrgJNtATub8YXtTezpPKqV40fJ3/gLa4hKqDSj5yKbgYkARaXjn9b6bIZNcc7
	s0w+HWUN3r/Bj30lALzclwqsT5GsPuYdCiezjiOQMglFRPe1VEpmsBeF2y8xQPgqhPfi2oLovic
	LHCiht9TXIvFGEbU+Bk7m4ii1rce1GD+Cav5eZPDQhDZorJE0+MsQEqF1yRm2k6HVcru7qNRlmB
	LuEaRr0sDUzYqSlq5ESIxUx9kPQ4wrCn60R80XFAbezD91gjDuspLhEQr/NwUpKtIOtARXlDcci
	8fy89pgKbrL2x1/HzjYFq2raXWMCMy0EcutDW9AUm0T8J11XT/y5ruLKqq/kCig==
X-Received: by 2002:a05:620a:3910:b0:93a:252:705b with SMTP id af79cd13be357-93c2513e511mr295176985a.23.1790150444765;
        Wed, 23 Sep 2026 01:00:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:93a:252:705b with SMTP id af79cd13be357-93c2513e511mr295172185a.23.1790150444287;
        Wed, 23 Sep 2026 01:00:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a913:ba43:96d7:743c? ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1a3b46sm55135535e9.11.2026.09.23.01.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:00:43 -0700 (PDT)
Message-ID: <313f498d-a66f-4e38-ba9b-6393f42a3826@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        codemender-patching+linux@google.com
References: <20260922220950.2267270-1-morbo@google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260922220950.2267270-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX14TIb/u+URNC
 6dXU+ORipleuoa668DpbTmt3Sd/skESqPxRvpw1Kb5S128vo7pD6qS22rNi46Ql/Ro0+3fO1L1z
 JtoNeW+nrr/1/LYgPaH+rKu5zbZrTaA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfXz15dOQGhK1ae
 BH4a7KnA9BEabvgqwuWse5mzLYKxrBrxoGUN5aj/UbOKgsm5m+Z7dehtuANOHVMy6aPryCouVAl
 2JULZ5T4o5ISrDXgQ+cb536z3AAMrD+AwXmP7kIAPQbrcIZCfN/qMCCnafaW9BYsvB5+6+36c99
 CiMKJcS148FEQ36it/jsJEzysiGeEFUltUSZuYvtkOpqnVSHNT488cd9Le+3kjP5vqgavvY0I3t
 5LAO1zY7GR5jPSM5tWqLW/MiZcW3YeXlOfsa4UphGjeyaQP1tPSmwKof9PHAFuvcETwwZTsiHQ8
 bR+6iYdurn/ekOoC6x4K1mk3H2vIFPN9qP1QTCX+bFCz5ORByvxbqtt5piQFncO1uE60Wd3t/Rm
 hQTqk5MI5Y/gIf2qmzAKh1MqaHxC59HvIFuicVyKTm0kheAgAtyrfF/zTvTR/PRvk0hGSIX6N/Q
 E4l2J//UyIlCfydXvwQ==
X-Proofpoint-ORIG-GUID: rWrsV0NNWtsGqk3ZdHMT71yDkFPgMT2t
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab3872d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=4ffO35K8LLM2FldQJH0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: rWrsV0NNWtsGqk3ZdHMT71yDkFPgMT2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230031

On 9/23/26 00:09, Bill Wendling wrote:
> Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> fields inside structures can be annotated with the '__counted_by_ptr'
> attribute to specify which field in the same structure holds the element
> count. This enables the compiler to perform runtime bounds checking on
> the pointer.
> 
> Annotate the "base" pointer field in "struct adc5_device_data" with the
> "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> SDAMs is determined from the device property and assigned to "num_sdams"
> which is then used to initialize "base" via "devm_kcalloc".
> 
> By ensuring "num_sdams" is set to the correct element count prior to
> the "base" pointer allocation, and since the size of "base" is never
> reallocated or changed, this annotation is safe and will not cause any
> false-positive runtime bounds check panics or KASAN issues.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

