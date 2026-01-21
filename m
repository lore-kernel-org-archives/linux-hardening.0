Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAD43E4A2
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009487; cv=none; b=uLfJe6M2PZFZFxcV7PR1AXRPMcWcSa77ygHmVXoI9xybdgApuCPxE71OEy1eHCC+QfClGvbqp/iDWc6K57BvRFDKc7V/6Eeukxx/XUjP9HSfEPE65Sh6xgVN6WPdAdGd7hPH0mlKADXbuRczkS+ARniKVrjyQxJLZrR+cT7jAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009487; c=relaxed/simple;
	bh=zsX27Mca8HN9B5bADNfbbpGBalcAWHy5dbS4xUpZk6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK45cBAvkblYBDDLdSk/eATnk8h8t+aifhH/OK0mfaHYRX4ASMiLJCQfXTbadGBoWp3dPah+QTFs8jVvjVs+2LPZzsriqV83nSKH2Kdc/f87GPLdjv97ChbgIYdRhRIUXwvUP59Zo1x4rw/2aip4xc8dle+FqYXrmXEV7NDd1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P4U2sjQQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2HcvOWZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P4U2sjQQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2HcvOWZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LDWork2727035
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 15:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zsX27Mca8HN9B5bADNfbbpGBalcAWHy5dbS4xUpZk6w=; b=P4U2sjQQcdRJ3zjO
	mCaMrL0+DW/1ael+/16AELa0KpX3EPSOh/lUK2074ig18a1gIFj3pcs1VKvaS+fk
	KMdmTn4HBrmY3U+XQbkMOLTAFQeyJEx/zaAcb7AzOrb8OyA4+uggiMlJPT3rCCmc
	xnpKfgAC1GiO/U2qEO7cG6z1URsAMRKT3+UcwuI8EUvcIFYuJmfCDfZzohe68GEK
	3hMKrYYaSMB7wMDAufPfIA8kiji+4VvVdVwPeAMBnkf7Bq0KzpJrVsGz0es1HSrb
	FSNUAOPDN3C40fqwO8pcFVuVec/kiqw2e91xBtjn6ertO09waJn5mMRIlAEx+AeQ
	Sh1r+Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btysfrdqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 15:31:23 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94807fe6f62so288600241.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769009483; x=1769614283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsX27Mca8HN9B5bADNfbbpGBalcAWHy5dbS4xUpZk6w=;
        b=Z2HcvOWZxlq0bqbF0GIaiTXrkZFle5ccsXM6HcdawV+e0JfbFU3ZfPeack8RMrYaDW
         Aaw1/FJV5NvDwetkwbdXyyISQH/eexZ8ROQT1NJAKx+WlrwupwsNgfih36vqOypBSD4Y
         afKNVD09FhVqUOQrBZwpzaIjS2sxzPnA0kpVwfnY679l1sU1t/jbKFDRk65rUakJU6Gn
         dWt5LaNeo9GT5R4h/fxIGwccb+wiM/mCtEMKd0HBRrbtbndRFRolKLwClTAF+LYsOWPv
         7YBJnRD1jsoYUADUMhLGpMj6wcyldRuttE6KanX3e3WpsCyYWqrt+cQuu9+3mZZFZVL6
         fspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009483; x=1769614283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsX27Mca8HN9B5bADNfbbpGBalcAWHy5dbS4xUpZk6w=;
        b=LK76vpTU9Zbq3dPzlBjprdnd6k/h+qpVR9ho1/tUvzR9ABdubmqVVn8+Lu1AVOQCqK
         rBErjb8DWe3fcrqBf02N1rAvW+5qhKmwz82TgAPgfO8BpUiTVJKu1w5sjN1t11gP8pGz
         rktLAqPVmqpUGlw7yVceq53ytNwdUzochaDWP5je6MtjxBngCP/xi1xb7e2esVJu+rGi
         913c8CoOkOdFJhNWFROHCOlYI7vh4+Xt72OPDjoTIw1Xp0uJNJJSYb4f7vpeGfVzvYlV
         4lgtobB7xph8HG0XyU1HvuzkH2vPfhqO9f3w91IrpTnjR0rD8WrCkL5Nfh6AmA4EfI4M
         v8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXha8y0aMisC+qsuMYlAUj2Q+nN6tPdmx+ICbF3zGmNoV5JyF21n+XZwEPs45M7yDdhLTmdpgktKUK+ijc2imA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1uLYxmiviNuWuw6jCLHE8L103dPqw3aNF9dSa7KOH0WS+C7Y
	8HlV/tXrYBFmqGT/opBaQo9EtqO2c867m2Y+AkJnCPIoWF19edoLbzXIwP6UPOO0+h73armzdia
	+xf47IyI7PXxenFqtY/2TYsfIh3HAYqpwmomdMw2tFwiszst1hiGCHUrBM4HHueggh+fXGow=
X-Gm-Gg: AZuq6aL+79cQuNn6MZUQBMLyQ3ZRrZlT9vpQnppszOkNgxn5y423YOknmVmDWxE/fGH
	bxtWcDk7HsvSBw2EViLAL7NXAm5mbC1l+L7eG2/knOlprGZtFi9gHp/eC0OJD+CE80wzhOwEpx+
	GTM2HzghDlIwXsdPkjDjSCZcdQuilCaxJtudGtjcs3g1AAmpqZbL5AUGM2xHEDdCJdgu3RPOc85
	8erJxdTi/3ch+p4d9rdV3aIMVXzRCCp0/e0Uq2ak77/OY4BYvt2sPAxD1R5CC/Q3iOeHU1ICpyd
	XIHbGcoWJpYq+GI0IApIICGM6ZJ/LMkf9aojIfMXwqVbnBqMLBaRbDC5s2cSfCXcfEZp3858PSZ
	RvErEprCD6Q7YY/OZjdNPGCoAuzOYfITEJHQqN9aGvKSASLcVDDZnYbLq1zTfiIj2XZU=
X-Received: by 2002:a05:6102:370e:b0:5e4:9555:8984 with SMTP id ada2fe7eead31-5f1a556805bmr3562939137.6.1769009483233;
        Wed, 21 Jan 2026 07:31:23 -0800 (PST)
X-Received: by 2002:a05:6102:370e:b0:5e4:9555:8984 with SMTP id ada2fe7eead31-5f1a556805bmr3562900137.6.1769009482784;
        Wed, 21 Jan 2026 07:31:22 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6580eabee8dsm2085168a12.30.2026.01.21.07.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:31:21 -0800 (PST)
Message-ID: <a51b1fab-c630-48b8-8b58-2a906ee31424@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 16:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct
 reserved memory ranges
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
References: <20260116-xiaomi-willow-v2-0-4694feb70cdb@mainlining.org>
 <20260116-xiaomi-willow-v2-2-4694feb70cdb@mainlining.org>
 <01d254f7-8c62-4061-ba7e-f358f1904ba5@oss.qualcomm.com>
 <90a74369a2c4d9453de733a46fdd0ef1@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <90a74369a2c4d9453de733a46fdd0ef1@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N8Ik1m9B c=1 sm=1 tr=0 ts=6970f14b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=tG82vpoCcTU8gc5Gbs4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=o1xkdb1NAhiiM49bd1HK:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: nbpD1F7gTw8OjhM6xvw3J868YVN5xssO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEzMSBTYWx0ZWRfXxTTqAgLpKPDi
 3AAdC/s/g82uPfbPgY5VLjq78y7/0Ttl2oTNtiYhKr5hyhb8xhmK/0tcCpiDyWmqUgc1E6PeseO
 QUdFykeKyt1vo6blwUPJeNI9LLXVGYT5gU+TVifejkic691rB4t/XwRhJddtr6OjWoDFkPkf5/i
 STNslbNOZU7R+N5j+ONv+VBMM9i/H6LrouHv1DdHmmOtUj4VNI8s44Jh/41TsU7xiqQNL8lyVff
 AyeRUE4NeQ1eGRkxTl+926niScC1l1apLHBRc7kCgLDxJVfizHPh6ntQP0LNsepO1u4gFq5SC5T
 jp00m20GZlR4Sn+MrX6rLyQdtSv6zZKQ8u9XkIdSPAAW39KCooB1WMlTjErQznlaTCayTkJfrTH
 5E0m6H1/JMAdQElEcYxEVaA0zELq0FCG3nClGurCr8ARbEtxugqbANRIimFJTKAq5WmE9F85u9v
 K5KXddmIoaGtJwNQ13w==
X-Proofpoint-ORIG-GUID: nbpD1F7gTw8OjhM6xvw3J868YVN5xssO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210131

On 1/21/26 3:21 PM, barnabas.czeman@mainlining.org wrote:
> On 2026-01-21 13:45, Konrad Dybcio wrote:
>> On 1/16/26 4:54 PM, Barnabás Czémán wrote:
>>> The device was crashing on high memory load because the reserved memory
>>> ranges was wrongly defined. Correct the ranges for avoid the crashes.
>>> Change the ramoops memory range to match with the values from the recovery
>>> to be able to get the results from the device.
>>>
>>> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>
>> Have you verified this new and improved(tm) map e.g. by booting up
>> the kernel with memtest=1 in cmdline?
> I have verified with cat /dev/zero | tail | sleep 5
> I can test with memtest=1 also

thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

