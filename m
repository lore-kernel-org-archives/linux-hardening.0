Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE18346E74
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514859; cv=none; b=gA2WOce0hmWbdmM3OMkfPHUrRGgY1mvwhiOeYpSVbpypINH8tLrp9foXiPJ7X1KHGAnqstMwwXENo9qCxLVxkPOn31+j5zI3/Gay+bkXJZHuCgEQUuNKmaSDXvEe3b98SC8FhHJIb8WKWcPozrsJSQqWb+RV1qzgu/RfG7OlF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514859; c=relaxed/simple;
	bh=9eFDs61emi4sfTHgfT/aGOzHu+flEQ8b9nh1vAFK02s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjRYnrER9O1BOek1m6rdjOgjfyJBU0TSvjQHQc25wawltPyevcJZQq/0f+GFl7wGRbop3LZx2frUvglApNQM/onfLlxexZE+lxV1VeSFfmi0wYbM2j24waqTbO7WkdHXQcWzvKLkp/7DCzjZ7+hkq4iUlcjDiHwvmNIlEwBYVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dt9pZ1kq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LuQg3IGM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dt9pZ1kq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LuQg3IGM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R7RsmG112447
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wnf8iBeyskshIVYJYndhWW4y/eBQme9JrGBpWCNWUSU=; b=dt9pZ1kqLuyahlwi
	OSa5CtV+2V/l522Hg5Bqu605oMv2Zm6Lc2lpdEVpMiI20dUgqOxebQ0Vam3q9bnc
	0/gkxvXy9OynFjXpk5aK3MNHTP7IM+tCT8L7iGS4DY27u+OQofYaACWk9I5zZMJ0
	yQ+mnuAfHAiBs3kX4d9vGRuCoazx2CPww1JNBExhzCsC+HRMOlUa3QfObNlMu729
	VTVVf9wKTBMxRp1o6ukZWbbjqZIZN9J+CtEosZGSgB8sjtmMyxgVXOeJf1C906FT
	qCs2kC0kES3rJ0/Pe6n/ZcJFf1OVMtMx8SoM2qOiXrV4J7TZpNfxSF8tIeGCK+xO
	RBiy8w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxs0e0xv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:54:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-502aca58e75so13841391cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769514856; x=1770119656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wnf8iBeyskshIVYJYndhWW4y/eBQme9JrGBpWCNWUSU=;
        b=LuQg3IGMR++QAcgb9Yc9+TN0+zdF/hGRUTvBenIBV3TrTw9884DgebgGUI8DeX6pvQ
         zni4f2ntie7OsN8lcHnSXcvfYs6sCJLiNFKehuvQzsDN54rCMc4nmJkNy2f+Jjcfx+mE
         mjOOgmCuKzs4v7MWeuc10afmlnGLJD/EaR7elyXeZ50QNCmZeqcNyQRMTD9uRO3j5fr8
         KE67D1YuVAC+C4UHWjsI1OW+M1fTkbuWjfbvUcojNgX8QLNxX+oPERW8wkLpuF9wJJKg
         Cn+q5HAx0yIjXVC9M42SatkBe+PL4KflC2QSz9fk5Q2hbBTUpSnXB8ux4SmYQ8OhS1oC
         qvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769514856; x=1770119656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wnf8iBeyskshIVYJYndhWW4y/eBQme9JrGBpWCNWUSU=;
        b=jMicM3taLweJ7utiOGy0yzpooUtLjDZvo/TwTceY2a3qXL1f7/nqYbwY6s2gZgQ61L
         GmJXgyZH573xNqraZ2NHW82R5iDMxLpiG0J2cSq+z2mGSuHtvO2vHQaWXNhvN7DkbHHz
         wgrFH/jKKY3LvH0cn8U/GK1+D2trH1tXOEIpWdoN06dQiaBx0pUf/wuT5w69pwiyhiqS
         pQ4CpdaUoc24RH7zuaXugX31WOpomTyuKxHicb3k0XFjKOdHUBHAWl1qqGKes84pVo/d
         qyPAuXoZt54EvZyWr/iR8JMHmN19tEbo7S2xMk9J9kkmBQX5ldgu7gwk083mmhK9GtRf
         rzMA==
X-Forwarded-Encrypted: i=1; AJvYcCWAW+wlhlrwX0tUWPvCSqN3L3Op7FT7P1yDfOAcal7aoJesyfYxm9vsmQTN3YE62w+beXhFevAOd+B5f2OLWkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j4MZ1l6MuVXAzl4+z2ZdOtLwis/yTQmDVx4nLlaFmcIE0CDg
	7MKM4HPzDiQWJiNOpB3f5LShLWn24ufXEf9jsM/jllpPgtfrml9Ufoe0WBMw2DJdrGXW/NeSdTZ
	HvBNX60t6vYad0yYOLAmOAHBSy8QBxxj010avA0ylfe7UH3YFd/kiQ/ny24gJZy4sqnMXQx/zve
	LPx0w=
X-Gm-Gg: AZuq6aJE72Tlpv/b9eEX0UBs2Pp2h2gfCyIXPt8d4HaEmGWbjbPnRjsn6lVeKdSqffR
	U32tCkjpXWG+TdYIuqDbhdclb1yXHwjCSLF0eTi1qQAZs6aUpg62L185946IaEZATWNZFrpGdKv
	05B/JKrmeAMGXGiSU5zpM5+Y8u27GhCmTSMXm2j8BTWDMISIzY6uXSe1e4pOOh/WN7VWEDayB8H
	jCGfzBqGKl9/QgWFsJaEQbCskBRClAieFh1CEAkzI1sc3Qe1FWt38DmJ4NfMfap+lkgNkK4wphk
	38n/Z6jJH4wiQIg6pSmXfY/kx1l8S6EH6ur3rtNaaGNJl0QtzbYNvasdEG8EX6ab0RwVl8JDBD9
	xTH7hviJe1YG9fhG+sndJYjTtYYWyvA132YDlC7BQnY0woWImWRQl8jrTaYiz+Tuo6d8=
X-Received: by 2002:ac8:5f06:0:b0:502:a0cd:4ca0 with SMTP id d75a77b69052e-5032fa0a876mr11839291cf.8.1769514856042;
        Tue, 27 Jan 2026 03:54:16 -0800 (PST)
X-Received: by 2002:ac8:5f06:0:b0:502:a0cd:4ca0 with SMTP id d75a77b69052e-5032fa0a876mr11839011cf.8.1769514855671;
        Tue, 27 Jan 2026 03:54:15 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3f6ff8sm6356227a12.15.2026.01.27.03.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:54:15 -0800 (PST)
Message-ID: <1268a87c-a2c1-43ae-b99b-3940f4aff63b@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 12:54:12 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Set
 memory-region for framebuffer
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
 <20260126-xiaomi-willow-v3-3-aad7b106c311@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260126-xiaomi-willow-v3-3-aad7b106c311@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NiBTYWx0ZWRfX2o/LftkseGb4
 Kl6UfxLzG5U+45lAFKVfXnmwNbmDEbxBmZ60p9DVypJoXRSl8YWBjlhWXfsUT52eDIq9WLAliJO
 Tt3PTM93dQ4u4yt/bzMK7VmaSNk67NhRrjKZhyCUhPbRa6HdQKfHVRDfD1IRbxwNoCOZvFmf7K+
 1sHOtW/bC2nng6fkQUy7p//kKdpc2YofOxD1YYfCumbuuOTZnj9hYZxiX5ATMjMkZNH31qE7Bw3
 aT9VVIVN25Vy+0j6a2bmzVklX8GIejbzoD8FzIND9Wu9NZn8e0ACt5xZ5NC77YdE2YRHp76vyaX
 nKDzrq+WtTAPKwUZUrLSVSBwkUZoVwZMKOCsqa2dRUc47Gy8+UT3cCm5Ff+wogegRL3AdU9B6HS
 Sh1nboDFcJJNfhzdjvJmR/5kAJxQUOBKSnNlE20TJMEBqBNvuCv/9bo/cfIT/9JvaNun+LOsyLX
 WDTYh/hHMjt5EXiSuIg==
X-Proofpoint-ORIG-GUID: vmV93duUAtOug_eiN995a2f0jBciio9P
X-Authority-Analysis: v=2.4 cv=Hvh72kTS c=1 sm=1 tr=0 ts=6978a769 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=xgpo1DY4mcIGgMJ4Mc0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=YF3nxe-81eYA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: vmV93duUAtOug_eiN995a2f0jBciio9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270096

On 1/26/26 5:34 PM, Barnabás Czémán wrote:
> Use memory-region property for framebuffer instead of reg.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
