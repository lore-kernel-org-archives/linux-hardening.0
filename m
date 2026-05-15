Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1D2D3725
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849856; cv=none; b=bUgHMp3JaoUHUIwrNiywNga4oolPuweTW67gcBfqI8bl5o2UFk35giUj54SI4a6VarI6hrwnRq5gJ/9JPAYwP4/QUTz519jK963l2R/qqM7dTnzEnlQTJg118EyPGn9Lwk1K/cnA92NaR7uWLWqQxTHi1PPlgkqeP8w3vxc165c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849856; c=relaxed/simple;
	bh=6jZeY3fFm/RWu46vschP8gHQy+Evtx8dFt3HodsRJEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRshU1jIzk7vejiXfSrjdw03O8jDTSoUrq4ixLUjkgEhOeudzct5yQct9VoA+zctygiLqE+LR+Kt8Z5m9TIujq/2VFvCarOFVHBHb7uE5KRs0BG2nhJxNaMKRb5F/IEwJBDLhAj0MiaPrtTMioaVR2nEygSJiTKN8Ott3QykT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eZkJLlBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RseFilte; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZkJLlBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RseFilte"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAbC9b3512973
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 12:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdkIR6RMfY5OxV5lPVO4LlZZZ2NLTbP3dRMQlqgS3FU=; b=eZkJLlBljMbyAyQr
	TgNgygTHkLS0ix+U9krjIhm/mFnhYTguxqxgyrQYUaEkPRS2woekwR1HkcueC2j3
	ru4Cb5g/HSqYHEao/G4OqUgZP9zbt3C+qc7SSyhwf9aFHRl19DzniO9OiSH+O9/t
	I9zsoCWL270oBXW0xi1n77WO6LUBmwNIF9pN00iVSajFd9Hcq5rMmty80ND5iJpd
	1bEw2A5mxrHSieHNylYINM0M5SU6BfQKFjK/mtAgBymSjC7KLa2M/H7C7j7KDPbz
	NKXcfUU+FmbYeI1JvyIA73CxX8B5k8GBIfbo4ny6zdfKTsQC7myuPDnv/UygjSWN
	XqPc5g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vba9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 12:57:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-63142e319f7so517431137.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778849853; x=1779454653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdkIR6RMfY5OxV5lPVO4LlZZZ2NLTbP3dRMQlqgS3FU=;
        b=RseFilteNn+qPff2YG/aUtw81drJSMqs+HSKFGoaf1GskyLuVnZXVsmTyyanQVDN4Q
         MdN/uAIv8mQEkZpB98Ej34zJuVQb99/fFpVN9Z9BnNLbVgGhSRFnvfRdT4BbQFBWWfL7
         nc025NMIsg5EBD4R9y0w0pNm0fVDw9ohdZYIjrpYvuGjLmksTz/KGsMottR5Egxgx6Zh
         T2ING6TTyqxhr/ic/YzfbEvQKBEH7Gb9M22cNN5gsMAVLknecNiYC5MpvrmMJ07MwcH/
         ELgCpWfOo8hBivm23WSRPa/MQGMITM19fpW4svLG2ZenpebxF9TFKTL5q59Il5unmdol
         8PhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849853; x=1779454653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdkIR6RMfY5OxV5lPVO4LlZZZ2NLTbP3dRMQlqgS3FU=;
        b=l5gZUYQBkz7nbJMg+9fJIzYSi33LZOKPCuwxRbJzz2ePqU5kSjhZkaa6yeS52Sr8Q6
         nFmpLr5Oymw87ach0k2VKeLGZkNnYBeFkWA4LGBHWuFCcAUizGomps8pOd+eIB2Oir5t
         tq6JDMmZsO4HrEcsyhFLrv7PzI/39U82zDdM9KQADdTIl/JIYasGHEmCylP2vgtUxeiB
         NfSnc52X47p9Osod8raXEOsZlKrKhhwUkCYM6l8KPulJd4qKSgsDqe11Vvhlfe4lMyeE
         U5mK+8IcUL7IKY7HDM5mXi7yCSVWkKucmlfVB95ExO5TlrIZ7nZ3qwWrEhciVlaU6XNg
         CPbA==
X-Forwarded-Encrypted: i=1; AFNElJ+W7vZV92NGxjLSqekQf+yoA2LL8FTM3jYX+bR8P4fyX5duxBx+ZmU1oVGGa2tVAIaVPCm92TP2ztt48mX6hm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtWQaWDWgoYkqAyMJhCHWFUJB07bJw3EFuJFeEiY6WwqsnM5/
	TI0ndtPcYeqHxnR8YXGtlUnY5jZU7uSwPc8OLhSD7orEaBPTcOjsI/4ORtcN99JsVCkpn7xK9RW
	c1idxm16QCJnaZuUzaJ7bCBm4LV17i4fSrAW6F9B/ZEhm9XBYH/4X/0MtoRMoCCKxvyj/cdE=
X-Gm-Gg: Acq92OHdHaBRr6JOUrdANbfYKnyFoPl+u791uctyCZox9yWMm9TAxbm/HnNzZTHoQZP
	ivpIL/Q+PnpO12KWWvmxGIa2TovGq1eXNRM2H2+w0Zgl6UAipSX+ugzsaWN32Jagd7ehGTfx9Io
	t1GSALOxTy3Ft/67h/Q/3RatYcjYYrSuKLQcOg0CcDu8psEh4Agod40OI7X7JmnbdCzof+Xko1T
	oIOl3rk56n1IFEEGPZodVx1+iyG6QuNscWY+Ew/kQRPLUlnYxGNjjHZJxCPv7E3gP3gsVRdI+6D
	1Sb8NecfiVWrVVbKWlRTy2zRfGKticTIUz8rA/g9FBGmm8HD9fF5zuU8fghVpOZT5zzolQgTagl
	1EWfzQ1QfVjqJDRX+/EpY2HH4KF3jqZYJWcrzJP/DVv6T0G3+iQ6A/IQ9IoXM8mPY57CbFBDHBX
	9HKuY=
X-Received: by 2002:a05:6102:126b:b0:632:5db8:f656 with SMTP id ada2fe7eead31-63c002c3749mr339409137.4.1778849853072;
        Fri, 15 May 2026 05:57:33 -0700 (PDT)
X-Received: by 2002:a05:6102:126b:b0:632:5db8:f656 with SMTP id ada2fe7eead31-63c002c3749mr339390137.4.1778849852436;
        Fri, 15 May 2026 05:57:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea93dsm221177266b.38.2026.05.15.05.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:57:31 -0700 (PDT)
Message-ID: <bd4e93dd-5293-4cbc-bfbe-314b3f348d31@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
 <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com>
 <CAFEp6-38=hcUOvW1yd+hRZ2nHV8sLxiLeB18uu-au=LgA2bQTw@mail.gmail.com>
 <0c6c9366-a190-4143-a0fb-2aff38ed8804@oss.qualcomm.com>
 <CAFEp6-1uDO7UzYm+5ejRH0fCtnFZSA3z_Xa+4ibDEbXBh38ueA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-1uDO7UzYm+5ejRH0fCtnFZSA3z_Xa+4ibDEbXBh38ueA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzMSBTYWx0ZWRfX62c5mH4uX7G8
 DK92jzC9MTMdMWheBlI/uQrGvHbKwTKputNFk5lb5YvchV/eBoBRjy6jTRtEAPehzkHWZo5ynWP
 fF4UJImAErOafO2qj1udQsIr9aXC+FxSmVmZytHDPVm2BFt3SCyvNnxSAMJfXpxWxqmA9HY8sj2
 1jTiJD/gozpMO9/Y/yxDnc+3B5VrSNuAxNCMYaoAphQe6DxRi+/LAXmaadHg4asH/maFvjI92EK
 hPqIRxVJEZfVu0NqHMkEaUIW6xKAF4heu4zBGoXMLkwqgF+GOSzCB/CmTWAdp4ZHI2LPs6kUXEk
 YeEAztrsre56/VCVjWMBKo/F15zywmUcOIiNp6DNhPQtf0Y04opShDojNmBiBAy8nR9O2QphrH8
 owi+Q0aU2lw2VbArJ9/QIu2oh2McmUnodrEZql9xDF74icI/5n6DvQJpsiJ1d5g0M9KhKdkIGhh
 cxFQUYQ6MXVx4EeHY9g==
X-Proofpoint-GUID: AAisA5LF_1BGaBfScUA9t3hfaSkH34Rj
X-Proofpoint-ORIG-GUID: AAisA5LF_1BGaBfScUA9t3hfaSkH34Rj
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a07183d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=MDVsdYFiAoUeNHFhHhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150131

On 5/5/26 3:16 PM, Loic Poulain wrote:
> On Tue, Apr 28, 2026 at 12:16 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/27/26 10:33 PM, Loic Poulain wrote:
>>> On Mon, Apr 27, 2026 at 4:22 PM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 4/27/26 2:43 PM, Loic Poulain wrote:
>>>>> Add Devicetree binding documentation for the Qualcomm Camera Subsystem
>>>>> Offline Processing Engine (OPE) found on platforms such as Agatti.
>>>>> The OPE is a memory-to-memory image processing block which operates
>>>>> on frames read from and written back to system memory.
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +        clocks = <&gcc GCC_CAMSS_OPE_CLK>,
>>>>> +                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
>>>>> +                 <&gcc GCC_CAMSS_NRT_AXI_CLK>;
>>>>
>>>> Should the two AXI clocks be aggregated by camss-top instead?
>>>>
>>>> Otherwise we run the risk of the OPE driver setting a rate of A
>>>> and another sub-device setting a rate of B
>>>
>>> On qcm2290, OPE appears to be the only consumer of the NRT AXI clock,
>>> while the capture path (VFE/TFE) relies on the RT AXI clock. That
>>> said, this may not always be the case and these clocks (AXI / NRT‑AXI
>>> / RT‑AXI) seem like they could reasonably be managed at the
>>> camss-bus/top level.
>>>
>>> The open question is how the NRT AXI clock should be enabled when
>>> required? enabling them unconditionally (similar to other camss PM
>>> clocks), introducing a dedicated CAMSS top‑level interface for voting,
>>> or leveraging an existing framework to handle this?
>>
>> So, interconnect, or some internal, smaller version of it?
> 
> Downstream, there is a CPAS driver that handles these clocks in
> conjunction with the internal CAMNOC block. Dmitry also mentioned the
> existing icc_clock mechanism, but we likely need to investigate this
> further to support proper dynamic scaling of the required clocks.
> However, I don’t plan to address this as part of the current series,
> as it would significantly increase its scope.
>
> I believe the current approach is acceptable for now because:
> - This NRT clock is required by this specific sub-block, but not by
> all CAMSS sub-blocks (unlike, for example, camss-ahb), so referencing
> it makes sense here.
> - At the moment, the OPE only enables this clock without setting its
> rate (i.e., it uses the default), so this should not conflict with
> introducing a more complete scaling framework later.
> 
> Does this sound good?

Depends how you're going to want to tackle this debt in the future.
If you go through the icc framework, you'll end up needing to alter
the DT

If you bake in something internal to the camss family, say
camss_foo_bar_request_bandwidth(u32 val), you may get it done
without that. But I don't know what practical challenges that will
entail

Konrad
