Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6EE2E175F
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058408; cv=none; b=Ht0Rbo0trbfKhxqOj6nVDO6ehPUV1enP0dN1qrAfiV4KKTSn9RY6YpBArMUvjIB/vg1A6nVmZPHZIWPg5gLF6FiydcJeUDekQhV0LpaOs97wMwrXwKXjlHISXWkpg2qlOJSUIC5M8igN3v9AEuKSaxEZjuSOL7sASYHpYg5en8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058408; c=relaxed/simple;
	bh=KYv5PL/TF+d76RiJqFNjvnmyTh4nizUzZ3HOo3pZhXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXgojnf49RG612HHzuBzC9tL00brUBSy0uKcIyx27jJTwoMR6XQJGmEO2zNfm0CABw2g7buizD3DqIWHo3fwrFK6rq4Nyj4Jen5iTINI1HkBdKfhd9KU5AbtjFLCkFGJeVOLa8qNQgkRKhy4+vz9EEImvMeCjd/Rjx9uz53Ook0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvdPxaxC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8Ps5oXN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvdPxaxC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8Ps5oXN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ID6RY01407404
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 13:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7e2FtV7p71m6bF85tuF07LQ6OZkylmUItn06kMAU0Bs=; b=VvdPxaxCKy6r/ZxM
	AH4+i+/ej09M7SW4xUbAnC+7O25p8UH8tKmXf8rUyMh65PLmjMdZM4ngRwMK97/Y
	xWy1aCvF1x5C7Q5PRmC6JMWg320cRLX2MYtQQHviwWUg5fYqn6cyZ998CDt9ngkE
	0Vlcex6uc6NhS/jyL5FBgrGxq1qVQhbaYfQALtF1JnEylR6vRQE0+tPO4n/cOa6K
	4Padp5OdZkvzlgN0lo1a3OZ0pjee3Z/qmKgqyIlVsCIPT6Y33Sc0h2c4rzGCvIwz
	7d6dPmog+JxguBEN+TGCZE4dBotSPwwWDJFpHF4ZDSQwz7TeP6fmwP0HIXSKl8cn
	7/75/g==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx0036-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 13:06:45 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c39b4f3229so58370e0c.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787058405; x=1787663205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7e2FtV7p71m6bF85tuF07LQ6OZkylmUItn06kMAU0Bs=;
        b=i8Ps5oXNyxKe4E2FihFgv0U9wkPWCBE5JIP2PDMZnTGBUZ7JFariSfCW5yxG+H6F7O
         1rPdCYB7EpiicuEe6U1bEznhLtnMVT2k+X8DcST0fn46tkwunNNiFYkIY7YRUHsvmycd
         6ut4J2kB4LjCZsemyyWxSWBF8CmEU+IU82QVkukJzMIe3pL36F9nBuySkWJIqYVfb6Kt
         Ift2sS9vqoYbjomomsBRZbt8UVVizbY9XkUxHFSJB9+2lPBmIbXdSfMt75oXMTj0rvIf
         JNJuWYrdB+GIzDMsdRZhN3q4FSD4UgRhdQ2EYvv+x6U366hXcuUxEu2F+l45kmHn4dcR
         ejLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058405; x=1787663205;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7e2FtV7p71m6bF85tuF07LQ6OZkylmUItn06kMAU0Bs=;
        b=T1VHp0hoy/0S1V0CGTHa+gFdlX8V0pgtX2KVx3FXdhA6A3jpFTClrOAMqGhS0XrqIw
         bgmUxJv7KKVJWzjNxPbd79MdxHFoSjfNShBQIHhZPqIRRJL1OdCSQ/7bVhy8hqxC2a/W
         EjTjHPrp2W4OFdNbkPA/X4nzaPAWqzFimf/eas39/cgtC0HaF7UEPTIt8gVuTRJ1xkuX
         9B/OR6QwWXM8r80Gc++rc4zthWs2oDHgISipZxj5zMjTATKgmvZ5jHY5QArpJ6DOlMVm
         tQ8YDorkXhhWxlThIAHusbh9UqZXg2iNo7Yb07GOb2+WiqcA+yk0wl9xsfsZlIKRkxwd
         +n/w==
X-Forwarded-Encrypted: i=1; AHgh+RoIWEGQs17hXbAQa9MvfKomswPEcwfk7alJpsEPaMpz7n/pwdVkjDkOxtl1btTRwSdsOGbc29J2JFpdgY/HYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbBWqYDXNkdPLLAAxC0nlR8Vd8V0Jq9KzIByCJ0cTimxm3vMK
	u0CQAXBnIESnKcX77o3WCZ7QGxi68IBzk8bPJfGRbZTNJsqTIJmg9ofHuLW7hAp//r8b94xCktF
	NxBJ0f1nP7+EpoStuFEt37DUex9n5dAz0A46rofekpr792bIyi9CSR5LYBPTdfsEWH34EocQ=
X-Gm-Gg: AR+sD13aPLSCJTMTYDfq0iOJvAW8kCN4ad+yIO7mVtLZia1/hvf51/Tf7totCOOsutD
	c4dG4AoWAb0jlvHeVPSYhF3xpBhZyJAemJIIPoB6qV8nF/htR46CEX3ZCThDydCZO7ppWwHc/Ou
	fCCgVtFM67/OmmagJ3dul/XQL+aoV8czd50USAA1ePNHoxj78V+RAXRf9PUj7NvMler2aX9nUX5
	KVhEueveCtlwZcGeGs3+2Sn9V/EWzBgfReXt9Ysx9xqZSu+W1uiTtZfkbzXnESZGjjXvY2fjaUK
	77FUTcdrxbaI5U7vMAKrif1CCBWhH0FS4AHvsybInHod/UAFRo7xFkeXQDDxgZbmmFb4nqH8nG+
	R2SdtRbK0+MGTYda32X5MbXxG
X-Received: by 2002:a05:6123:4205:20b0:5c3:6e8a:4a22 with SMTP id 71dfb90a1353d-5c591f2c4afmr2346525e0c.3.1787058404929;
        Tue, 18 Aug 2026 06:06:44 -0700 (PDT)
X-Received: by 2002:a05:6123:4205:20b0:5c3:6e8a:4a22 with SMTP id 71dfb90a1353d-5c591f2c4afmr2346474e0c.3.1787058404495;
        Tue, 18 Aug 2026 06:06:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d00ab3fsm1214108e87.59.2026.08.18.06.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:06:43 -0700 (PDT)
Message-ID: <ed39625a-5b38-426d-9cb5-a1e486d25ff3@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:06:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345:
 introduce EC
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Tobias Heider <tobias.heider@canonical.com>,
        Val Packett <val@packett.cool>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-hardening@vger.kernel.org
References: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
 <20260809-dell-xps-9345-ec-v4-3-88306dbbc7aa@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-dell-xps-9345-ec-v4-3-88306dbbc7aa@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfXwhQi2MX74blS
 YMxdl5EkuoOJyPan524nIU+/UzSOcoxv8ZsZewDdop9eCqt9rbpUIIEmBrBji/o5EYajbrLRJY/
 mMtinlJMK8tgeq3HYOCtsKpyBgJi08U=
X-Proofpoint-GUID: gjblspNpEy-JF-NvDWEI7EMN57CinjrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfX4W9DTkwLEBRa
 ucKXtnrwSGSRYrMUJtvDpYgR+fpeOLMo3V2qGn90mECUkCi/i6at9zy0E2gMPHxN/UojFd/qLxu
 P0uO++oc8fw6tAMbPRkZWsFIBIlF5LefXcROCTdK1b8ANoNdYCrbye+Hqtpi+tXpUkt2O8GZzTm
 Hi8Zt/7dEXsORb3XG/qFDspRUzML3UrnDxMTt9hI4pEBhY/C4UH7az5rxXfVr2EHtegE9KPyL5p
 znHhin1Y3PEFqvtNLNkHcv04gp0K42UYAfLxXbYPRgok9THgDxF/IkFBA7RwZhgkh4J/eAwpp4G
 927rUJgeNRAUBwn9qVs9fWkVusPnNGSEMTb6TKNKSgF1eFASEBJ7XxG/ULtSb+R/ZgOa2g/ALTF
 a4iNkyxEsrohjz3B9huE6ObqDCyasSbhnw847EJ/2Ud2BzdbqsUydrtdypeirwtjukRnR4VEgfM
 NhSTxJncbxXVpdnYqnA==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a8458e5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=I76Qk8w-AAAA:8 a=EUspDBNiAAAA:8 a=BDX-M9UYCxStvK4FQfUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-ORIG-GUID: gjblspNpEy-JF-NvDWEI7EMN57CinjrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180096

On 8/9/26 3:32 PM, Aleksandrs Vinarskis wrote:
> Describe embedded controller, its interrupt and required thermal zones.
> Add EC's reset GPIO to reserved range, as triggering it during device
> operation leads to unrecoverable and unusable state.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
