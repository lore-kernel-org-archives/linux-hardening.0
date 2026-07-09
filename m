Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574303E3D9D
	for <linux-hardening@vger.kernel.org>; Thu,  9 Jul 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582932; cv=none; b=Sk0ETUzYYjrpY1+VBnp3G99Ws16XSrkOmZVyu7tZC/8uV8Rj6DKAS6JaioCG9AnxQ6uvkhQpaCz3zqnX9xjz3Gs4sPjpoNorUW+78HJ+E5JNBpHoHD2Z7uxtRT8yICBpGbcB7x2bcI3S/yqNUqP9Kg1GrGTMU9LCn2XtfdGDMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582932; c=relaxed/simple;
	bh=bPecE3m2OmnvvsAJ5paIV4IX5QUb0uPCLNDhDlmDFJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toczc3wQqe5Km+9aWux7rAiJc/9LjPv6gLGjQBcTWgjy6dv7z3jdZc+dQojyCAHS1pUhvnIGg/G48k3Z4OZvFK+KHXu+2zO4ww7k9saP0ufyB/R5L1Fj4D52zOb8qdvUAd7p42yzeou8htzwQtRRKPwJJWWruozMrGnjQ4Ddie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZB+EWCLb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ew3c2/u5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZB+EWCLb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ew3c2/u5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669618Ce892147
	for <linux-hardening@vger.kernel.org>; Thu, 9 Jul 2026 07:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=; b=ZB+EWCLbVRB6LAVY
	FlMili/eUg16k7aTqUKZRX+ZMpA2U7vuegYR5qNnZW1RwHoEcP0+uKC0mP9Ub0Z4
	JjIJiYLu/dLPBSdlAabzq/UUwSZ7Ti+dguYtNhoyBOVIRnjrY8liV/5w9smn96/X
	nwMvx6RrDF2KbPojgd7h+GLG3TP8G6P6nUrn0wC3PxRH6PgsOEfksA7tJ0G3qppN
	3cUawxbH8Be088noUzN8PduC6dAhZN9szo18STmSgbqrMI6AkpIXCYYDjQT1C21K
	zONAgxjidpJ0xHDxaoOOcroG72xYNNi8Oz7ilJM3/jWVq0T/gxLSneiwT1RGZU5g
	hIkDSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvtdux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 07:42:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0d6a2f4cso17504991cf.3
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582928; x=1784187728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=;
        b=Ew3c2/u5/rIcCDlu2Ao+lMelsIJBb/bph9WEBSD0JbULnfTJx3IVT+CnClr5MLxNbL
         x23jP+ilN8NTw8t2NeDbzbcn+V01iyGXlVMdSoJ5wfgw9a20RXrR6SdpT17ASntEzo9w
         pt1Y9sKBthnHWAQLbAma9kIGU8FZcseb0Duz9zKcZWaJpB894PxwT3TSLBqeUR9ptRFd
         gSDYoy/rLZAVJLe5SA4vbfQhj4vShT4jCxTPdEmk+3JPP0on9SRsuqEXebIquaZxSyBv
         1HaExdiJomY+SvdQQqGIS4kNAxs5LoFKvxWD+cH56DlILyEzE0dJyufvZAHk3GgWm2K8
         DsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582928; x=1784187728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=;
        b=DfzGwKXXEKi3gq5gUWGsfI4LKG+nHAMBBdjBi6eeBRD1AknQF51KUPA4M26MW1tbmA
         s19r0AwFYftGLbsfwBtbZtyn4P/mh+ucySEDftE6xK/SJhIrhSJ7cQt7b94Eu2UtRh+k
         V5hFfjEdl6dV06fpTNeLbLi4noqF/WbKSjtuKOEn1p8ZaBqVISvqofsOTxbWXum8dr0y
         Qdvcy/8L+z8zQkuAVzkRUOy0rVTCG3iq+1afyexcXR9GQ5Z/VKjtiTikJH7kVkI7SaBS
         f06CZkzpF+na4Cu57qPnFql+1U/oNEyUdN7LWyzoELri28OYhjjVMNLJdKeqBkXMdjYc
         twwg==
X-Forwarded-Encrypted: i=1; AHgh+Rrt1hXZkN4fDX+lBPgTsXvjoMYsppZXBc7ZlJNFO5hdfT9CV/j8vVX+jH4eqbX4Jvf6knWHu8CWwQGbKQDAfTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PQD62Kasqdl8Vh1pA2lUvRzkZP7HEkCJ1jmsIB/Dox2WI+vW
	G/TNyIQJdXsTrwELg6GHnXIs752Pc/XhuO9pIZjZRvjtLII035HguiLfZzdfkSAb9e6Zas0K84U
	dcQyrqHlQ3T1N1fWS23EjzjXNj1RUyUwBQchdgx9FnzzyKb1ZU1RVKW4ptvgADqels1jos7w=
X-Gm-Gg: AfdE7ckGkgdkZmOITZ8uEWtIG7D1Q+nVt4N3+83MSwG53tKp+/DC7e5hX5UL2BP/T+z
	lJVddk1M6nRSHoW5S0/sA4Zl2sLaZbYFs56phiio9JOXyx3ELNyYTxEEZeD4DkNsIDBynRf+aUt
	zDTGQNeHhfgkFxTsJ4N+K8dBKc1jtHtIoZNcgifX0W0RVetW469GaAAhP2X4qoVJ+crMeL75vEJ
	+ax+Ssw14MD0ve2PPkAHw+enHp/uMAPbovDF53tw3q9bqmKgcjTMfac2Y4Dgg/ZHT2I6b+jwpkS
	qCzfxXWOqSlEo1SzMcM8V68A0SkBIufAlObe54cSACrkpObFvQSxylMZB5zl0J3E5SHcVEyMXlz
	tY15F1ZWaPg6u6jmCzJYSTSagpwOONTrsgsHjbAfvVB4V
X-Received: by 2002:ac8:5d02:0:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-51c8b54a8f8mr64315111cf.50.1783582928494;
        Thu, 09 Jul 2026 00:42:08 -0700 (PDT)
X-Received: by 2002:ac8:5d02:0:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-51c8b54a8f8mr64314671cf.50.1783582927994;
        Thu, 09 Jul 2026 00:42:07 -0700 (PDT)
Received: from [10.111.138.111] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d799dfsm10078060a12.17.2026.07.09.00.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 00:42:06 -0700 (PDT)
Message-ID: <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MSBTYWx0ZWRfX6HtQNV0+y0dA
 to496sklqaszxfs5NxVr+d3SfNKYOeCvAXu1sH1ZERU7souSaHOOs5OVifOw9Hz4RUUlKzpcySw
 4ftSKc+OwNDWljljbV0i7feM5qItg9c=
X-Proofpoint-GUID: L3CP0rSsDtnXgDliZyEEmwLoD1PsxXq-
X-Proofpoint-ORIG-GUID: L3CP0rSsDtnXgDliZyEEmwLoD1PsxXq-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MSBTYWx0ZWRfX7y32f0T3mZna
 Q1qwQU/wi8gvskz90eY8yIiPPs3FBP6dis3m/8tD38cGo8zXm8tBhCRweql5ruTEQD9K8EmZoqi
 zr8CCFF+x/VOd+hif3xr+m0kKEhQ8eU51cduQ6Ul2LWPrOlm0tCtOIYHAAsHaWkhuksxqQzmFna
 k/w1p54ZQxsZuIJlV144VTlzKHNVSgRzIZzLeynpTNuau1hWVBDW4RR3qJyXl0jHH42/+tPuNW9
 jCP5VHOcHFkEQm5+NSstWvLD69t0U47bAEGxB9kzQrltTQ5byEzbmelZgoWY27h+1ouT9GmOXxn
 5dVm/J5t4KjG4/GcwDY/s2rQcrRorXnMY2MRW9MYLu3lZJLtlprSKCY+35rMzpt5mFfh5Qcs+Qy
 Uk4IMG19gVvq2uZeiSkqFkLhLph1L6zjffFRVXw/BD/Ws0+PwWkSgAHz+1eYLo0lLfWF8PFBwJA
 e+gE6u2u0WKNPFjkJ5g==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f50d1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=fjlDWTYzx9GH-NWLRPsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090071



Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
> On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
>>
>>
>> On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>>>
>>>>
>>>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>>>>>>>
>>>>>>>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>>>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>>>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>>>>>>>
>>>>>>>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>>>>>>>
>>>>>>>>>>>>         <&phandle device_id min_state max_state>
>>>>>>>>>>>>
>>>>>>>>>>>> Define common TMD device index constants shared across currently
>>>>>>>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>>>>>>>> additional target-specific constants can be introduced while preserving
>>>>>>>>>>>> existing DT ABI.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>>>> Why are you using only those TMD devices?
>>>>>>>>>
>>>>>>>>>> More constants can be added as needed.
>>>>>>>>>
>>>>>>>>> Kodiak is one of the supported platforms.
>>>>>>>>
>>>>>>>> What would be the benefit of having more than thirteen cooling devices
>>>>>>>> declared in the thermal framework and having only a couple of them mapped in
>>>>>>>> a thermal zone ?
>>>>>>>>
>>>>>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>>>>>> need to add them ? Can we do that incrementally ?
>>>>>>>
>>>>>>> That's what I am trying to understand: why the implementation uses only
>>>>>>> the selected two devices, if the modem on Kodiak supports others. How
>>>>>>> can we find out, which TMDs to use on other devices.
>>>>>>
>>>>>> My understanding is that is an initial thermal setup. Gaurav will add them
>>>>>> step by step while setting up all the thermal zones instead of sending a big
>>>>>> patchset. And TBH, that will be much easier to review.
>>>>>
>>>>> In such a case it should be noted in the commit message and/or cover
>>>>> letter.
>>>>
>>>> Thanks for the review/guidance. Not all TMD endpoints are relevant for
>>>> kernel thermal zone binding — some like BCL and cold temperature are handled
>>>> from userspace when needed. The constants here cover only
>>>
>>> What if there is no userspace? Or the userspace is different from what
>>> you expect? I doubt we have TMD-speaking userspace yet.
>>
>> Thanks for mail, The TMD userspace implementation is available upstream at
>> https://github.com/qualcomm/qmi-framework.
> 
> Is it?
> 
> lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
> lumag@rohan:/tmp/qmi-framework$
> 
> I found no traces of TMD there. Moreover, I don't see why QMI framework
> implementation would react to thermal events.
> 
>>>> what is needed for modem and CDSP thermal zones on the currently posted
>>>> targets.
>>>
>>> Again, SLPI, ADSP?
>>
>> Sorry, I should have said "generic subsystems" rather than listing specific
>> ones. SLPI and ADSP do not require active thermal mitigation on these
>> platforms.
> 
> Could you please provide details, then. What is cpuv_restriction_cold
> TMD?

It warms up the zone when the temperature is too cold

