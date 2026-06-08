Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150C388361
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905727; cv=none; b=RL5W4fBNhms93ArgU50+lxYsvWILHukdX8gd35v5CqYe6qKTzf1RCUIDrYI0/b9MIZVW/A3N2Wr5hdTAs3a5w0RD3JmZZ4nJQBaN+fAuv0g9BKIP0Ktk6uma5bfwrX/5721ewxNJdFQNwHm/XqHF6IlZc+8n/fzLc5y8nvm0c2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905727; c=relaxed/simple;
	bh=eaI6IvA8CC0peKwRQqHGFnazyaoZ+QsnVLRibILeED0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axY3j7Iz4jZoH3tKOiRe+yVeXTaJ7zi1OxHU51Mpy/w8c90hO48K6k+/1E07j7SnqSWAdmhkmiMSjQnWfPKJNEwklP1UcDKhX6WU1sPPiAcq6fMhHEIslYyCHIR5J4d6Cbg5O/ZwrqtINNDV9jIhUoiEsgGdGmAbLf6jX1paogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPToVGIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jNtCIr0j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPToVGIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNtCIr0j"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OkUW2382832
	for <linux-hardening@vger.kernel.org>; Mon, 8 Jun 2026 08:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	luB0/y1C2J3GY6bJol69fJAcDK7lywSoLu6n/9624kw=; b=JPToVGIY55f7bAKJ
	pPPOgFRoLVpjN0iYleusIERnvhX0NCREPTVSc8a9qLqqSEMpj72jGrDH2rZ+y7tW
	/irDT8ogPBQJMUglBAteAZ7obcz9IRNsrMK44M1D8fnYqjWxPIrbzrTGDYj75vul
	Tm/cr383A0dfdK9DW+rYynUKAt1o5r9lnYKHCGjZJtxGpY9sCSSZj+zsbteZIhX8
	xhHijH/fhGzk4oqADQZF314/xq4yokcEdr803EVIKo1PtuM4rG3q0VXKzY9RdSFx
	Q5qMoki1mJRHb8rqLZu2dHa+NBU77oUD76YVPMjAQttqHbn2yVcOHSzW0Ydr8ujq
	y7kxUQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cy62d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 08:02:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915732517cdso68812685a.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780905724; x=1781510524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luB0/y1C2J3GY6bJol69fJAcDK7lywSoLu6n/9624kw=;
        b=jNtCIr0jjexDAnMsqyP27gaMTdyweyljaPo/H6gPxp934RViSDqv/w6Qk7zxPLufr1
         IcZ2OfUyNigvF8aPuX5+h/fWFoprVZ52yCk32eCoULAVAYYJp+kFS+Y3JPyLtO6gcKuM
         rNG7+Au92k/VOSMjvA5xXC42+YJtCE8QFPQ5gb1laeuswPgZM/X5dKm7a7KB33Pcg+bW
         P17D+hwjvHfGt+17TzYSTeJpqNl55vKgI6+bDg5qZ/zyGsHhWeyUZAZ2NKSLfvNokq7o
         sLY+s/qG88ado7XOqYrQYGnw555rh1WfVkN/xuyuQrSRvO4X+nfGUSxX3ii15a3EtnL4
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905724; x=1781510524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luB0/y1C2J3GY6bJol69fJAcDK7lywSoLu6n/9624kw=;
        b=rRbfGTxBl6Jsp4YZ2HZ0lStJGT4gBBRlme6hkyOZPOl2dgeXwx7RHYoYm8Vx66WD5p
         ay7uzdXeOa+/CNaFZPUr/WfbTrJrTEMNldkXgYh/T05gXWjts+aqT+ToTayxva3MWkhl
         57HOsyEfmxDuURVNvJOhekWZKp2g3oBBjmr9rOguDwEBtw/VbhujldP6iL0PZHg+w9PD
         FRONDFa8b5Jri0MLJ44cgUapENmBZI+uFdiM4HnskbvRdLd2ahcEOCIzTDf+2Ku7nfLZ
         fxU4TzZKMANoQDSabimPo3Ltiqx37gbSqV1Q7f8ZdDZTrQGtcPEkR+BL8qWnOJkg0xOB
         eR+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8g4ihM+rjU50XLiVVetn/24I+2Fr12qPFZAFPHPUwgEaqIISIYsbRWPaS63wRNkzBBdDEfbDaVrcV7lsChGqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RiDgbBGIYvWYcoP0rm0vMeyI/GBvBt5lqt/CQRtM64Ki+yDA
	PtDNYKjdXUxIX79fDCHDULwJwbreQYuwWp4wapXH1uet02dw6ed0hEBVnai18HLSn8OCKVJuKRH
	DWH2ESU5HL3fDJrIf5meGhrsOy+tvNYKAikO9b6Bl5FBxmQxGKHFBUa7w/btirVbXKOyWFL8=
X-Gm-Gg: Acq92OEpqdSvBSRoGVqSbsDwAbSx7p611JihrKlVuxVLeIrWa3BSFrnrB6wvBPFewUb
	8/bhs3VZJwIXvK0fXZ+kg7Y0utX9d7tVKWZqn9/0USCtyhIzVESgn1PxEPGzV5RQ4/OuSyVoDL+
	d9Twnn2vOqUU2Rqj3XWkxDXpXLoT/H5PmXzricEVdvY5KR2dyw+o2A87+gCkpjk4wHoR19s99uN
	D3cLJ54EaOegelcRhA20kSbnSbALqUxQhptZVKuiEjqn3qPu55ix0MnHd074Wb1K1jBOMoTXQ+B
	K2mn0Mp/W2LeU6nlcUmDJO9nAFjTq6NsUTkcGd6w9e6zUv4KjSxRTyqTBioYFlfoKloE9+bIaFX
	ZKuJ96zQS4loLvw+ZE6c8An5+GeoLAyk1sXmayXa9TrK/XCdBeuZytI15
X-Received: by 2002:a05:620a:45a4:b0:915:2b2b:fbdc with SMTP id af79cd13be357-915a9c41cbemr1397044385a.2.1780905723734;
        Mon, 08 Jun 2026 01:02:03 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:915:2b2b:fbdc with SMTP id af79cd13be357-915a9c41cbemr1397041785a.2.1780905723227;
        Mon, 08 Jun 2026 01:02:03 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65868049sm6655703a12.24.2026.06.08.01.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 01:02:01 -0700 (PDT)
Message-ID: <aaf40cb5-e40e-4239-bf66-4f21252bc8cf@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:01:57 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: Annotate flex arrays with __counted_by()
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org
Cc: kees@kernel.org, gustavoars@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260607111933.6398-1-med08elkadiri@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260607111933.6398-1-med08elkadiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3MyBTYWx0ZWRfX5mjx+zIYHGhh
 3zzF+b3GqmtkfV+WZnUD2rPpSewN9wprBGupWWQU2/2C+uoqI+Z5EmpxtZYbUce5GHFgqAYidcJ
 Q0kGh/RieEFDbxp+xMAWK/zdkgVWmYCRVCCyEMmCy3FSeU5nyLlRaXNH5foIqrbUhzJgiFK8qZ9
 8PzZkFx5pPYUkZemYnR84jafroFMaXPRR1yudK1aME7JTRXfERGtVKK0fnkLLoG7Qm//8GMdyKE
 FgPFchtf7yuTrwQi5DT9KEsCIOPglkFQr545wMt4z0qYAhI5kRDC/Mk28oqUb+qwoG3g6uUOp86
 DE7MU8wtXhOstcCPkqukoGpwp1RbrBPn8XrmPtiAGuAB5s9zrrkIw2lrjfc+OsJ5EM+gZ6zoheP
 Dtp5cIrDxKxZ1xLDZKbT2tHnow+gbNvAMGB3eTqSZbmRmszMZxDNmOHlSug8dS+5q2hEwPmoiog
 /zdoujLWJT0d+a6AfXQ==
X-Proofpoint-ORIG-GUID: 4hQR95xElSDFWT-mDv1sKL8HkD6GsbXQ
X-Proofpoint-GUID: 4hQR95xElSDFWT-mDv1sKL8HkD6GsbXQ
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a2676fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=J3NlhzYKM2y1xIgm7VMA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080073

On 6/7/26 1:19 PM, Mohammed EL Kadiri wrote:
> Add __counted_by() annotations to flexible array members:
> 
> - hfi_capabilities::data, counted by num_capabilities
> - hfi_profile_level_supported::profile_level, counted by profile_count
> - hfi_resource_ocmem_requirement_info::requirements, counted by num_entries
> 
> This improves run-time bounds checking via CONFIG_UBSAN_BOUNDS and
> compile-time object size resolution via __builtin_dynamic_object_size().
> 
> Assisted-by: Claude:claude-opus-4
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
