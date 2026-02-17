Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C333122C
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327388; cv=none; b=iHdJhx895rR6Y6T9gbznkpuxp08M0+Olc+5rnqPlBPe+y59DOGoHkpFxiKq9AW1QSbvWlDRPnPezxmRWcMqQt2Pq4SWChl4ZUYmqyqqaDYATmX9GWlFJ/QdVypcJ4BNYwnxDZAT1dsbKl+F9HaH19B9XjWQ3S750OGhbZMZF5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327388; c=relaxed/simple;
	bh=xMN3I7zoAsk2QRMIeIe/BgW1V6LYLwzLJyzQwBQ1T6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxAg1NJpJv+37PCMiFDw5/4AfXwjh17qcqh2AEyA/zVUwxImyGLPRSkMXA1IgOuV1cSKFwos0ORSoihcZITFFnKpkkeZZKP+37G9jkJe6HqFTteva7LedxXzd5yDv8cUjRN/11359/bpBnlPndMZoiBUZPnWkkpW/r6lqRjpKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IsnF3Gnn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4DtzTA6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IsnF3Gnn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4DtzTA6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8Ljo9297047
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 11:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CLaDJ4loHiaVAWlFSAgg1xguJUSqstbP17hVYmDKCYs=; b=IsnF3Gnn5ye/iHcw
	Ybegrhzv4Dn8vOTIoswtCGxJln3J7pFCnQuBWp3mLmeR5KTtDBFLQRMuSCYpExW0
	jUwYtfKlIaLiUrNnH1nx74+sGAj0/wjvZGrNWpDO5PyPkClIWx6nET5WGqjolTzL
	lwjqV20oMJtnyuImRrWOPv03M0iTpp8F0qraTl/PlytuZQ3bCnMIQrkLIeahBKOU
	4PK3QwGS7kmlwExRGS6mo99T1E139RX//TCmFGuCuKNl0H8xgpwbCoBwKgEYS+wR
	N42BQaJOB0LlmT7wzNY//GhGVKgYzTlPi6oTFwNey00FKrUqLxqmMjQqTXdb+CfV
	pKguzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9t3w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 11:23:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb38346fdbso332686185a.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327385; x=1771932185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLaDJ4loHiaVAWlFSAgg1xguJUSqstbP17hVYmDKCYs=;
        b=A4DtzTA6/uQkXrmefpxp5FYxogPL/wQHbJ9EtBfZk/V7ePND9Ghi6nI4f6a5LQJd5t
         dpzcay4mkHE1ZeayfrUXK8QCuDi5gl40V3GieXSMNvva76dbIwUWYytXejvTGhbWW10Z
         mKON6BGMZflOMIbXtlOSLqgE4M1uEQSHLc5kgn886h9Ij+4BiyYioa2Xzee7rY5bZS+F
         KEI5x/NlV2vjaO9Q/kmSDjJtsd3mGgjMvDwEPic41Joa/avO9A/O8AWxr5Vm7K2/JlJS
         riKswsX1UgeOkwhDbEgk+F5fMG0JsThtx9ItkPOyOmTNQ+eK0vOxgu9uS0NV0rbd/uiG
         kxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327385; x=1771932185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLaDJ4loHiaVAWlFSAgg1xguJUSqstbP17hVYmDKCYs=;
        b=ws98cuBirpXyi8hORc41RUgwbCqObI4s4HP9S7DxXUY2mAXXnPqn89v6Jg+36bQmwM
         VXr+D2FPoUVN8VgS9NXgYWuT4TlQ8QBaYqjD3k0ht5pJ9zwI3oJ2e/8QI7lAVzleHXkx
         3IzyRhdvntV0D/VCS822zLW9Ypa4hiGdQ8PcITnnloIuirSc2pBw8H3IewC09j+tI1O+
         jO9G5gMysjJ7bZQ506f4EExOXXkBoZpEZ+BbcV9FuupjDGyeIC/TerlIHmkdZjjtkt3h
         kBDOUYhV/JJ5FIGzjpBQtXP4Wxxyo6eve93f8nSM3mhiRiDKuC46o04pyScd4oHwrAnr
         ZZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXvCEmr5aOBt/2ZULdDblrlsC8WuDD7vhGpPK/3CAzUOwlf1/75a2tea1IAvJUOAIOKuBqOhg3xWDj66Gaa2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwlFlqGim4KDwaBpExjW8X6m8LtZbsyQ27S0BdcaxVSwd9hDn
	yPnuIahClMlnryC8ivNaoz2ju0Abo9jLWXTbDFeeSC7JXma5V+YPT5IT84b5WXrYH6l0PWbHRPH
	4VxqIGk28GjQzGlPOblndQ1yfCm1OSo4Jbjbc/qseaW2w5vSSOOPDT3dWlsPQN/3fk+Cwa+8=
X-Gm-Gg: AZuq6aJBSXyWDFpnlupLdJscdaxFSqxAWrfMErJ9E+KPkXKuBV/a5nxwwZs1m8w6Qp6
	vDCWhDr7mdRg7i/AoxPmyvspYKXsXRUrcg8RAfQ2xaSG+GumraTV7oZIRIytVFaS4kdF4N1zsWV
	H+yN2nZY5fK2IaYAP9mVLjsELMx3WeqqtHfrNuQoKyb9o4BUSfsylF2Veb3IRb37PNeEjceTzOw
	j8FTU4cXJFNYw+DREtxq1NqWbAY4qSNWVaiFzmwJd73z2ZYCngTX7AeFNQCq5/GO4cKI4WCM+U/
	Jrdofnn8SevUcgKzEFRaLao8PG9xfw/5Ab0ww+clSTLDaVNK3oCEIi2EOWwxQe74eyGKXTtyM7d
	wos3xGYdt+RxO+jKMeGUC3W3vuAB/99FTgoRE+wtdcnS5zhkE8Q2kxh9LiqDb2bvWAwDSw+OK3e
	24epY=
X-Received: by 2002:a05:620a:d8a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8cb40820215mr1409356485a.1.1771327384736;
        Tue, 17 Feb 2026 03:23:04 -0800 (PST)
X-Received: by 2002:a05:620a:d8a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8cb40820215mr1409354085a.1.1771327384207;
        Tue, 17 Feb 2026 03:23:04 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc73f102dsm336964566b.26.2026.02.17.03.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:23:03 -0800 (PST)
Message-ID: <c99beabf-9841-44cd-9450-2f339d1d5c41@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Connor Abbott <cwabbott0@gmail.com>, rob.clark@oss.qualcomm.com
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
 <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com>
 <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NSBTYWx0ZWRfX8H7Qv+IWIASa
 4UWRfWVcY5q8TMsfGaCfKpuefHVZDGYWwMMgUc1zQpD0C7YHb9RtO/ZoBOJE/I8X0IcOV2tg4YG
 HvjbgT5uMCQAAFRpC+ZOI25XKvCQwxjPJ0RnCTwuAXgvZy42nPDaO1aMcT2rQNSeYLFF2U9KaRo
 Owfqel7R7iVZzl9Z4r2qkojT7I0/Md1e8v9Of6Ac2iyPEOjuGZ9f58PDmpu1sgPLkjWLapS15Pf
 BW1vLpl3d5jkjQhlmBIAoblP+fiXdx+rJlRkCm3dNGQ4+aglemAwTMLgpTQbUi7exVkABbaErH4
 6eAy/nbU9mkGSxpIDI6e3hfTSC8raXHwAh6eXSrMGAov5Pa/kUP/U9/EmBiRGzYBshlaga1ykw5
 /wj9l4CsiHTxQQxSE98OT1CQsHvL5f6v3iW4/r0ugCGf6L09M3LyUekogdG6bhd8QHq/ned0Y0E
 KKJJoqDECmWsBTtVh2w==
X-Proofpoint-GUID: B-ccFq5AGkhjVpumEifPE2qRfeiQ-dAy
X-Proofpoint-ORIG-GUID: B-ccFq5AGkhjVpumEifPE2qRfeiQ-dAy
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69944f99 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cGCGxpJvRk8pEJ-QcToA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170095

On 1/9/26 10:03 PM, Connor Abbott wrote:
> On Fri, Jan 9, 2026 at 3:41 PM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>>
>> On Fri, Jan 9, 2026 at 11:11 AM Connor Abbott <cwabbott0@gmail.com> wrote:
>>>
>>> On Thu, Jan 8, 2026 at 9:22 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>>>
>>>> SMEM allows the OS to retrieve information about the DDR memory.
>>>> Among that information, is a semi-magic value called 'HBB', or Highest
>>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>>>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>>>
>>>> This series introduces an API to retrieve that value, uses it in the
>>>> aforementioned programming sequences and exposes available DDR
>>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>>>> information can be exposed in the future, as needed.
>>>>
>>>> Patch 3 should really be merged after 1&2
>>>
>>> No. The HBB value currently returned by the bootloader is *not* always
>>> the same as what we use currently, because some SoCs (like SM8250)
>>> with the same DT ship with multiple different DRAM configurations and
>>> we've been using a sub-optimal value the whole time. After all, that's
>>> the whole point of using the bootloader value. But patches 1&2 will
>>> only make the DPU use the bootloader value for HBB, not the GPU. So on
>>> one of the affected SoCs, it will introduce a mismatch. You can't
>>> change anything until the GPU side uses the new ubwc config as its
>>> source of truth.
>>
>> Hmm, how is this even working today if DPU is using HBB from the
>> global table but GPU is not?  Are we just getting lucky with
>> compositors that don't know about modifiers and end up scanning out
>> linear?
> 
> It works out as well as it's always worked out, i.e. we try to make
> GPU and DPU config match and pray that we didn't mess it up. At least
> now we'll get a warning when they don't match.
> 
>>
>> We do log warnings when the global ubwc config does not match the
>> "fixed up" config.. google search for those msgs doesn't seem to turn
>> up anything other than the patch which introduced them.  Idk if that
>> is conclusive in any way, but I hope that means we could just delete
>> the fixup code on the GPU side.  I suppose we could add:
>>
>>        *cfg = *common_cfg;
>>
>> after the warning as a first step.  That would maybe get some bug
>> reports along with enough details in dmesg?
> 
> Yes, the plan was always to delete the fixup code in the GPU config.
> And even that first step would be enough to prevent regressions when
> switching to the bootloader HBB value.
> 
> There is a problem in that ubwc_swizzle isn't as well tested. Older
> parts supporting UBWC 1.0-3.0 partially or entirely ignore
> ubwc_swizzle, because it wasn't configurable back then, but we rely on
> it being set correctly in Mesa for VK_EXT_host_image_copy and sparse
> textures. So if ubwc_swizzle is incorrect you probably wouldn't
> notice, until you hit the HIC codepath in zink or some game using
> sparse textures. I think we fixed up all the cases where it was
> incorrectly set to 0x1 instead of 0x7, but it would be worth it to
> check again.

Just to double-check, is your expectation to just double-check the kernel
settings, or would that require some intervention on the mesa side too?

Konrad
