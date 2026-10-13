Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE14F0546
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900116; cv=none; b=AuZNSw4zHCITZQP8K6IeuDyj3z3r0C5bf15clHoOKZXn0LzBCzY8ZBIc9kHGkdO+bWmVj6xkxuiBjPnO81GzjbiF93OyqnuXfa1onzBCGy7odbokT88tZPrTaIaASwhouwNvLVYKbxSvUowk2r60fNi58P5gBluwj3c+OlzkQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900116; c=relaxed/simple;
	bh=ssqHTpXGgabYsxdvcp1m8bbcmPreD+147iRzWVW6JUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTOlYmxHDY/ikEdNoPpuigmYzpmj8d5Da7gPI6pnsTeZP+3JMdCC+um2KYTmAiYD+GjKXSbqdzvjjxCuegaaXseuwlTFOG9TbUCwFOax9KkYI7Un61RfRMtzqtn9IuJPp/MO+yUS/vN6kxSrObTFP22nugNu6VO+J0M3Cpq1Dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpjj8CGK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O+qPpj3s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpjj8CGK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+qPpj3s"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DClwUC015278
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=; b=Wpjj8CGKvd6syAsW
	wtKuWOEMzXdAwfjyWwU63oFbmTGJfc9gDeAOVjepqzpkkwH2dYSgTtltVa7IPRAA
	75SD+S49d5Ta2NT8UQbJavnB1yms8R04z7KGX9/T2o8WZZYRTbsiDOiYK5+X+fbq
	ADm3eslKt96bcRGzrl58ToWkng3HWPaKp5Kxq102O5hvnQJ96HuQ2ghQThOjYg6/
	D2GT8VtVNImIR797Bb40m6XIzGj3ztNJbUjovqtOLzJMGC16JTJK812OFSw4ofAn
	khHOX9hNckkAnRUnuoA1OKmbr2Jm5WZjW0+wrGX+m7dXsNNhbMOnrxOY5Kx52GUt
	ZFBK/Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7uhm74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:01:54 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5e199541d01so4827655e0c.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791900113; x=1792504913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=;
        b=O+qPpj3sc3Qsu1ijR5JNfBPshJhgFrbuRtC6V03Hkgxz6wc5tVE1DcXD8KVy0EcHGs
         vX/3FfSTf8DTfpuKMubQwLkVUbJCeKH334VL+CaSarIHRJabGaefXlsTbqkt49yZKnj9
         YxX4BpEBSE76fRwX5TZA5rXiX7E+4y8ZGXaNRUWNujGKwvTKjRcRoShA5W8yrFYN8yfG
         Rk9VkS28qFAnguDFA8EARI+NmxX6ScNyxW2fyUhNOiKt1f/jk1KxCzBiJLtWszJF5eV7
         rQj7k3hdm8q1jXiaNPPLNYJOnUcTiilP4+38ch1ZIm+6gFDH/inbzk59p78KAUvXf+eZ
         0FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900113; x=1792504913;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=;
        b=TaYb64ZY9nb/f3PNM19MgFHlskfQjnkxzC//6xL8r91/U6SrQQ9z6AUowu7t0QOPJP
         iF9CXdkGsQcQykDp4DLMOAcunhbB86M2OJWACwB5qu1Zwymmfwyr87v6b8SmyzGCFhke
         DxE2Tu6WXST8tZsqwwN5cJ3ayEewDPH+q5/cia1Uys/2FfqX1e2raXxvYpol4WNfhW94
         wqnwkvRmoiQ8J8SJWcrh2TYjQsk1eyOlA+HT96XpvcppMnWqP+gbP6GrrzfBMUxAjKt4
         CsRVJvKxduxmwdQsN2Gd4No6bMrPsf8kB6SR6bXpydSngqaaqkCtfrN0eZlG3d6o1XtI
         Eptw==
X-Forwarded-Encrypted: i=1; AKwUvBzI59L5f4MudUbxprXGZ+aLjzzBxDqpncD3DV4vYmdKZqkFK0v38C5BnQ0cordtYFNoRDST8siBpfYClJBOK3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEgbZsZQwBLyQdyUlaGBtXoT3RIGOpqyj/c96P/CRnsXMCXTYa
	rTK3QSG8qZ0tI0g6bqBzb46o2te3VtGFO0ew63W8cF/cetAeMFxxJYf1ufPkfiSWoahrr3UTM7E
	l84V/lhzP8ZTUc9uRE01nwbk8F9hb75qkrATQlN2G643qpFm10lrjXDPxaAAWTesaSCfGRwU=
X-Gm-Gg: AYBFou211ROoZCAqu6bIj7XHTzf1sa1bru+OIAi1GaAkT/wgrZg4rXRY9TxwfVQ9sc2
	8A5c5JXtd8GLtS8UUHnS+Bes1gJFBoDMaQ0n6FwLd9/p92zmwi+rowAt1yF/JN8zQ25Akyl5633
	+4XHA5zfTXyRmgsq/DIVAm0fTJpwk/IckQG/MveIcvpDXRZaecaWLazJ2JvBkg1WD+OtmtL8ajn
	Oxs/2HBCeWdaDeM5UjK1oSHSih/dFOtRb1/mE1gllUvM1yTYkmaeINhe0lsDUgAu5E2eKhOdMF3
	cG2eswjb9o9IDP/lUmvaOAgfaUtOTN6//3UuV3EKF1wclhKAlKmKVg/5RAyqBtce7Gr4TFB/hMW
	byI7kTGux4/+OMIIHJRXjGSwtlKDH
X-Received: by 2002:a05:6122:d1b:b0:5e7:8bd1:731f with SMTP id 71dfb90a1353d-5e91f4815a8mr4193265e0c.10.1791900112828;
        Tue, 13 Oct 2026 07:01:52 -0700 (PDT)
X-Received: by 2002:a05:6122:d1b:b0:5e7:8bd1:731f with SMTP id 71dfb90a1353d-5e91f4815a8mr4193151e0c.10.1791900111802;
        Tue, 13 Oct 2026 07:01:51 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm377260985e9.1.2026.10.13.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:01:50 -0700 (PDT)
Message-ID: <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX5dRXnacgXRDm
 p8kbsJfMTUPAmTVO/SGSQUSOnFFLoIt+p7jwGGkgCOQNnytXrUWfBLrgCwdBygB1fHDImQoxccv
 UcWY1RvmuXZOyNPxfharf7LHWx96wOEj2r5X8EV7MS8fd9xq911CmazMzyzRp9CBlZeqBayskDV
 Qa3zYa80RJItb7ETcvvlcEYCLjBmiw1hoidariXSc3lWEoQINJAFuvAQPHnv6CRAgaLSiflHi2S
 htp9KBs/+v8lKy4jGyubIdFa8PFSX41f3EKswQCZx2ezrmiFg3oC+lMxNnsDi11VTiEmnjK09z9
 JsCkRrq3h5BVTza1WxDirS+AbmQNwGefGiIlfRf5rXpq5zDhotE1/yLU8SaNrqmjIvyTq6Vz/Yu
 LziGEbche5iZHZiRMa+K3sIxuDKQvNZgin3G3//LvXIhjQGKdkQ5HRhxXX6yHfF+JreT46hyfdN
 A1mRrQip/+kiPwD4AGw==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace39d2 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=xpaw9_Cwbs5_s0yaehoA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: u2L0m6OKmVoOjxk-OIiItfOBRuwdOFBg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX0j2vWkKyNZly
 S564aX9JLijcGb3spVYpMEMTv8JIBmRkl5VagUxTJH9NRphfRWuYJYGkvMqCuaRU9LBKTGfIoWA
 nwBEO7lWqo+uxWGmSx9ewrLDN3b9Ifg=
X-Proofpoint-GUID: u2L0m6OKmVoOjxk-OIiItfOBRuwdOFBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130055

On 13/10/2026 15:33, Daniel Lezcano wrote:
> Hi Tudor,
> 
> I noticed I picked up your series without notifying you
> 
> However, I did not pay attention but picked also the dts files.
> 
> Shall I drop them ? (AFAICS there is one comment) and let you handle 
> them separately ?

Were they reviewed? I think no, so that's another reason not to take
DTS. Anyway, it must not go via driver subsystem, so please drop.

Best regards,
Krzysztof
