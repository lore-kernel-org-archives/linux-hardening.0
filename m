Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4433F0A8C
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901443; cv=none; b=t+/4a+nJFPMCYPkoplfCbKIE3JihoTo9O8I9yNBuKYQD2g+3OFKztbBadYC2l3ehOQT2PtPyJo0g/Z0As9nhDRCWm6CExWjouoCX3FYifHKTtlKZlbnMitYdPiEtQUont3mhggwKxkOy6wQ1HQ6g5IiGVP4JOpk1tUznBgZiBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901443; c=relaxed/simple;
	bh=SyE2Z25hzP8HKj4fDJ94fsBx77haZvgbrgT6zrnosF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV4WwSzPqHiRPiZB9UWHKNjswQXH/Dtdb5DyFHw4rkRFVIDmsXgTojrj97p+HgsCKNZnAjZxI2wlHyFaDw18kOIrfEdeugaB3lsHxxTARL4E9HtnzPl7fGuifdt2LntMelm22iJvTN+SvBDN5AEh+mdt0MGFLF35vU1Bavp6mnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbCqkCaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VP31E+RW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbCqkCaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VP31E+RW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE4Vbw1298872
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=; b=WbCqkCaVPtk9UIzR
	KDKCSMaLmcYdP1tdpf5tOpRaO0mn3OH1PnNolvBIODrRshpHOQfeyiC+HAXuuXSb
	NMa9FhyDweL/7ImGGK8oKAqobGVozeO6L87r76PpKW+7iisKT0zS206/mAvQ7DOy
	kyQZdimk5uqwwh/51UT868ZFKMrZOTn4+EN5b/SxxASJqRgF7BfceQ9oa5t9/VIo
	K6LiMfrkkofmAUwth/Rp08/e82hXilLVyHidvYkaRGkAA1aVu9T1JaO9O+qDHZ4F
	XUPdAnjZ67Sz2kIDDaDH8cdmpxJclU/KNn0vRPg4NpQRLKwZ1pGsHfr8ygRY8WOI
	bvlirw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqv0fp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:24:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ecdc701a2so369787385a.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791901440; x=1792506240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=;
        b=VP31E+RWjjXDpdmtRhXqyS5lIdoqFwygLrAkqc/e+meRskF3iEk3EiCtdksVwRKL6b
         SVFt9JIzmZNR7qWljPagdJZlwaW3HlqWIXGGf5xxk8PW09+oEYBhK+Rvd+GVYkoZLywt
         VJ9KYshbdJhejyfCw/wnIUWZTRdITRVWLaxzAfWP5WAdg2ooqR12BBtxwqyVud8o1O29
         4gyb4dsGS6qaibD/MflADrcMF8VV3ey7Ics79DA1+p0EtJK8g1ogp6WJknuQ71Tvzs1S
         vRKQ3jjpOIWt0xVIs0Dmt/neiRmf026SWrLovOFWyX9tTLwnUOx8TEbOMt/8l9lUAt26
         WXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901440; x=1792506240;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=;
        b=Mfz4mipK7pquMVsSeLavq3hjT++w/A9DjBsAdgQcIYIhCVij8DMU8Eq7eI02uI8AKR
         XkjrDfTCODyk0Bpp4gC1tZD26yxEVN0FQWb/k8+rfpBIPJgQf0Gveqz91LSHUPJmwsNl
         9aVBHIsgLmrVIJNbXExwPWc2pLvL7o2f/NVo7b6Bv4U4Pe2SeqFlXQCtSd6UpX6Ahv7P
         +kticv0aFFCNRVu8ODW1F54GMiIZtP1fKbqAfQiRySnhbSNVxOygjFwx5IEYt5iilh/+
         vKuW4Vml9MhQSU17nir7II+hSKqp+DCTiA0WVuFAVgvFVtFgmPp2a/7hkBZenUT+BaZs
         HcjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI3P0Z2UmemBQIpZ+FBO0yiaAAlCGI6lFMCYfDxpn71ZeGKDdGycv4sG2IAxZdTDAW6q8PoO697Xl32Gkkp3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV+vyj65yWJFw6pw9mgaoZ+NgPwGQNnMx+uFizX1XTmTUNn5Gk
	zT1KgKEbY7whbDxOaonKCRSMFS77JHopjA6dhvOY41mnMlY1MF6YEJXQlREwra/sAs+WinRrciY
	zJTuecVdBJo6yxIPNc9yxO+Cs8sQbTPwLA9jk/rzBcRQ5RCYIEBWpqJDOz+pUe965EbD9GKo=
X-Gm-Gg: AYBFou3CpX6wco0yhP5Ya/S6WKaZnbXugQG+TGuNn8D/ypBgrYTy+io/OBqr9GuGb+6
	XuZXxMr/pU7ZXkOB5qkNm4chrLx4bIZKj505oALO8QEDVHEocQPl/nfhunIWVwmYWr7bhe0PINS
	MVOOKxC0f22N753QzdeOp3F+iZKnCf9r1UVSUk21zFPXbwwkl+JpKjlbQjhgdudzwYix1brE/9O
	3yHW6nrO9dgUda2ZW4iUWmTaz0uL5JnAHSkGEHOPU7z4EF49rZK+UZWmDR8GTGSGiwgGmyLXl53
	8n7L5YJCM2FrJX1q9TteZeAxhtYqm73jVRksFh8UHw55f7RqVUQvJy7k6Z4kQWF8KG+8YmYvSmZ
	obYP+Tv5CYxt8ZMuQ
X-Received: by 2002:a05:620a:6081:b0:93a:1fa7:1afb with SMTP id af79cd13be357-93ebd24d180mr2046718985a.42.1791901439877;
        Tue, 13 Oct 2026 07:23:59 -0700 (PDT)
X-Received: by 2002:a05:620a:6081:b0:93a:1fa7:1afb with SMTP id af79cd13be357-93ebd24d180mr2046711485a.42.1791901438883;
        Tue, 13 Oct 2026 07:23:58 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.4.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab48a7sm5417001f8f.24.2026.10.13.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:23:57 -0700 (PDT)
Message-ID: <5cf4bf60-00c1-4aa3-b264-aafba8af19bf@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
 <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX84+RLrp3Rdof
 yZlCDWo7hS4ECQaatB2X9R7buiENAaz0pu3YO9sNIhNy112oVJdm9rZ/vqG82fKJ5jXGPI3haCp
 zopGmt8lgc4w8XGld+B3ZRzneNuwiiIm+WTcjjNl2m6yB36NIsCwJETxE5NatMmt0eeLJhSVaTL
 qcjgq63979oGfERl0Mh7UazfRzgH7LD9fktIAkHu5+fJx54vE4wOaJrzzxbEoR/y/OjFANFVFdL
 6o4q3XWHHpMxVAPT7XLkAgF4+4VihoNrp8nsLH8akfwsxow/GHH1ySovE9ouXfStc8vfyW80OrJ
 tlNcMI6IS4FwBwuVi4UB/m4Ltpu3NKyfrtWtI7aKNidsE550qSPUYaOrTzsB11k09C01boZXqEo
 ESZpPfKXOSYGRWySBUpNiYgOO6q7WBasFyfL5MklVMWzTLLXdWQOvXmV4asTmsum8yK5aW1Y1AH
 tuWqHIseSbzTkbutB8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfXxvTYNeZNHD5m
 JwjrMXtcAoFBVGLknGHO97w9cIYNEY7ATdg9lytSt7l/WVzJZYhn3bjZDKJcCAHFTx54l6b8yXn
 r2+TCez/K7VzmuHHrzlugdRSP7zVxug=
X-Proofpoint-ORIG-GUID: -oxWUJsZEulHhlrvUlnGRf0Qu9vncnzm
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace3f00 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Pwpi88Ktxb2v7RWwfB9ReQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=4bmiNBAiDDOXaXc57RkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -oxWUJsZEulHhlrvUlnGRf0Qu9vncnzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130057

On 10/13/26 16:01, Krzysztof Kozlowski wrote:
> On 13/10/2026 15:33, Daniel Lezcano wrote:
>> Hi Tudor,
>>
>> I noticed I picked up your series without notifying you
>>
>> However, I did not pay attention but picked also the dts files.
>>
>> Shall I drop them ? (AFAICS there is one comment) and let you handle
>> them separately ?
> 
> Were they reviewed? I think no, so that's another reason not to take
> DTS. Anyway, it must not go via driver subsystem, so please drop.
Yep, I agree, I'll drop them and keep the driver specific changes

Thanks
