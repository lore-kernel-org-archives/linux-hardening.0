Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460B3F9288
	for <linux-hardening@vger.kernel.org>; Thu,  9 Jul 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585413; cv=none; b=CJRweOAIvP306gaBvy/5foW3quFSPCZgG7wzJfPwvpc5w2YiMR78mr2mECn29KMgBTh3ABmyPcqWewQacwkxtWqKS4jW2XvHcbVlYDmwCEluvKpKU8nLUa+11iMMNW/bjebq5aNwvC4yRSuyj5XmLuxWl23MW7dWzob3XM8og1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585413; c=relaxed/simple;
	bh=134ufy4mmxPCaUX9tTVJwnO59LWqPJlkTcKMtmq1QQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJxxEAt2Gfie3sOAV6dWxe7lVd8pQXg794dWN2EiJ9E4B8jwm1Jglle7oVfSeXu5oLnKTGJnHtqF15LE1Y8JZHcSAR5QZloLl4iC+h55P7aA1+Gs+uUWbaZKDlPSVmXXT66RrQErlzLPf21/yWqSWypbdr04r0l9HhJOU494oZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5QQpBeM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P244gWBB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5QQpBeM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P244gWBB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669618JR892147
	for <linux-hardening@vger.kernel.org>; Thu, 9 Jul 2026 08:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=; b=b5QQpBeM9t+6pFMc
	74J69gGJ5C6ePwsMhBgzHybMrF6+CZlYJeQCb+LIMdwOW89DvfzyKssSObFeTHZe
	iz9Pz36OJ2gW/iyD8sMnzXmXQKgZxmr1nDUuUUQIwy2qOqowYOl1dQGATRl8hFCn
	ECKAh8soYT2mLC6Crcs/ZvscSUVQiDgexHoXvKEjop5ov48ihHpLx0Tu7RLWFJXn
	kuzLy7Jgz8E3AXwo8HvHsaFDB/qX2tlYv1j+8cFXyUjRkbvHi/8qYJBz/fjITbMN
	B54rgKNi3NyLvsiKOFRISAcPd1CQbcpivJ/UM2ux/Kt/OPXLceeCH4c+AzN0z9Mq
	3ov5nA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvtkmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 08:23:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1852a86fso9792951cf.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783585410; x=1784190210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=;
        b=P244gWBB764HE47V9w+Gg/OVyxc9vELrTUwxFtB21dfHTE/+INS+7cZWYXGmHQF13e
         HkW38Efj4wh2bsbaU/Ig2NRCEpXD0RxNTYrkY2LvRMa5X5lyCM4kYCH5u6EqK2Lj153I
         RN6kQGlL4Rezz2RuuutyTSPlynUXMVR8uAi9QUJSVqY1FEm1LnmQbVF5nev8mOyMUkgB
         f3h8msYZ0vc+kDRpXvjVXTvi+o0cRuF9tRmfiaRyrNzMBPL6WpLWmTqc3SU54Z3z+Eyj
         kdArRxhzvnZqMGcd3d/W33AKFwjhSj1Uups75X+DmK30+s9j//ksL+nrj1PHPZjLmEOS
         kLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585410; x=1784190210;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=;
        b=sSWmFK7TEAMhe10uGLSZWK6OJp9RGhgiJFXL8bMF7VsDO0rsOkXL5zQ7+ldDTihm2W
         GoAElB+Mu2JLFYUPsOIUiSR2x3Hq4Fg7JSYqjWeT0PeBDfitfwUz0S0sowu5CXJG8+4N
         kN7LqjHI7vTkDiWJjjE9Rm3n4S+HQB0F5FDvC4imC2dnt2L1QiZEF/06t19JlU3txB4c
         97r48tyjipjKrBqTnNPThAYEHvbRxB2DDo43zUvpAnlbdtOrSluhlz6kUzKdrAzUP0cl
         CdjMfmOcIOqBFdIBTyAnlE105V5S3awxk+T9V4X1yb/RfJVwMS4MtiEcgLgqBqaiB4M7
         jG+Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro0pHmdw4sW/LFW1oVOlZ1rQwMGbYVHXBpYprmbqH1ocQkFbNL6kzkYlkhVbxr/o/abpaMFjRYLJWKQghvdUm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXtpH2DeE2DXBZoiUcXXR+NmLNaHeYfpaMmwb3h6uwFPS9UZd
	3/99ZgxBL8SjpcsGuEoOhcr2mMk+yI2nTsKCHu3VRpSqFp7B/rUN10fpfXjfGzhQZZHJsoxbDBH
	DrEP+T9JiAdxciefgmG4e5M6Lq8WnyTKZOBlYiE9LJ77hoDJS9u5KsKbXGcNJLEDFSbep4/A=
X-Gm-Gg: AfdE7ckin0iW7ECaDxCl1FYJpGRefV3z3YSlabRK+Z5UP/kTm09NWT8KRuLtvbc32J+
	aVCYW5s83lvrcnHx9mze+xl3qJvB0c2z7I3L/vRLmtWyZ9tIgNxVyzlPS9qh7QGAwvvslHOACII
	5sU3bshQa9g214izY9+fQmom9xDbFlvXuZAKbfwWFX8iigOBdPhdxH70rtGtD/g43SIzLrbgFM8
	WGWbBJLB3XxRRZsfCNYeKM0/tzmFP68IyUXsFURLyxzzzCxyH1/JUOyuXOANbn1NDRgZdXN4KpQ
	AvGuFtJ+NtKxM7Q5pN6E2799dtDxu6hKZT9LjVpQssNnRdSo2seGSZbIii9GZGRpUYrkIYRMmhn
	mgLEIwISfoGYv7XKJjv57vq7k5n9GoSWcKu7JYet+Ccrn
X-Received: by 2002:a05:622a:2282:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c8b2df9a9mr62944401cf.31.1783585409796;
        Thu, 09 Jul 2026 01:23:29 -0700 (PDT)
X-Received: by 2002:a05:622a:2282:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c8b2df9a9mr62944101cf.31.1783585409169;
        Thu, 09 Jul 2026 01:23:29 -0700 (PDT)
Received: from [10.111.138.111] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c1470325sm288040366b.14.2026.07.09.01.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:23:28 -0700 (PDT)
Message-ID: <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 10:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
References: <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
 <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
 <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3OSBTYWx0ZWRfX3q5pgu91hTat
 wYXwVWbYeRYVOulevkPZIhLIVcRY0l3+iIdDCApmFancVY6ZaVfyi6BMpoiZZJC4FqpnvCc3ZM7
 9V8Q03H2HC7Axc8d5/2oeEi6IPUALjc=
X-Proofpoint-GUID: IHO9U1ElPsQJRpl8mwpSpf-RD1by6Vnr
X-Proofpoint-ORIG-GUID: IHO9U1ElPsQJRpl8mwpSpf-RD1by6Vnr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3OSBTYWx0ZWRfXyTk0DWivtLK1
 ZQ8ZQFvP26RkX9+NwjBnW94z/5WFToSp4VL8AnpsL+gtCRmZpMOsiY3TEwL24kymJgbsoXWnbh6
 looIT/Ojav64hw4rdXYUMiat+b38lLWwyOgA/X/pLxdNBdYlyuofoqBv4WruUE0XCqoWnt5vsP/
 5UGdXbiG/IW28Rw8VYHDnwXSUYuF9uAzjh00kL5th4xNiDewcbXrE5NZA2ssdXFlWC34tX6i/qg
 P9vSg22hLnJewqbfQXgzG1vMR4OF/T4YaFPHq/+MFW1UO8Yfw0IK/Y5vnoJFtG16u1SlesnysKR
 6LuhSrgXooZmSe5NsQUEFBQG7MKh39u+Hocg+x3TJRFAXr3VRrgt3NntX4UsSmUosytaG5lrMGT
 CTPG4J0OMUAz2FW35wHU0YcmMwy8t3w1F/dUqCgP6dMLAGLsjxrBf7vEMDHJNT1SeA22AUaoZTt
 4IFS//8BKcZf4ShQUgA==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f5a82 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ftX-3Su0G3PhC2htbk0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090079



Le 09/07/2026 à 09:58, Dmitry Baryshkov a écrit :
> On Thu, Jul 09, 2026 at 09:42:04AM +0200, Daniel Lezcano wrote:
>>
>>
>> Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
>>> On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
>>>>
>>>>
>>>> On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>>>>>
>>>>>>
>>>>>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>>>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>>>>>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>>>>>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>          <&phandle device_id min_state max_state>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Define common TMD device index constants shared across currently
>>>>>>>>>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>>>>>>>>>> additional target-specific constants can be introduced while preserving
>>>>>>>>>>>>>> existing DT ABI.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> [ ... ]
>>>>>>>>
>>>>>>>>>>> Why are you using only those TMD devices?
>>>>>>>>>>>
>>>>>>>>>>>> More constants can be added as needed.
>>>>>>>>>>>
>>>>>>>>>>> Kodiak is one of the supported platforms.
>>>>>>>>>>
>>>>>>>>>> What would be the benefit of having more than thirteen cooling devices
>>>>>>>>>> declared in the thermal framework and having only a couple of them mapped in
>>>>>>>>>> a thermal zone ?
>>>>>>>>>>
>>>>>>>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>>>>>>>> need to add them ? Can we do that incrementally ?
>>>>>>>>>
>>>>>>>>> That's what I am trying to understand: why the implementation uses only
>>>>>>>>> the selected two devices, if the modem on Kodiak supports others. How
>>>>>>>>> can we find out, which TMDs to use on other devices.
>>>>>>>>
>>>>>>>> My understanding is that is an initial thermal setup. Gaurav will add them
>>>>>>>> step by step while setting up all the thermal zones instead of sending a big
>>>>>>>> patchset. And TBH, that will be much easier to review.
>>>>>>>
>>>>>>> In such a case it should be noted in the commit message and/or cover
>>>>>>> letter.
>>>>>>
>>>>>> Thanks for the review/guidance. Not all TMD endpoints are relevant for
>>>>>> kernel thermal zone binding — some like BCL and cold temperature are handled
>>>>>> from userspace when needed. The constants here cover only
>>>>>
>>>>> What if there is no userspace? Or the userspace is different from what
>>>>> you expect? I doubt we have TMD-speaking userspace yet.
>>>>
>>>> Thanks for mail, The TMD userspace implementation is available upstream at
>>>> https://github.com/qualcomm/qmi-framework.
>>>
>>> Is it?
>>>
>>> lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
>>> lumag@rohan:/tmp/qmi-framework$
>>>
>>> I found no traces of TMD there. Moreover, I don't see why QMI framework
>>> implementation would react to thermal events.
>>>
>>>>>> what is needed for modem and CDSP thermal zones on the currently posted
>>>>>> targets.
>>>>>
>>>>> Again, SLPI, ADSP?
>>>>
>>>> Sorry, I should have said "generic subsystems" rather than listing specific
>>>> ones. SLPI and ADSP do not require active thermal mitigation on these
>>>> platforms.
>>>
>>> Could you please provide details, then. What is cpuv_restriction_cold
>>> TMD?
>>
>> It warms up the zone when the temperature is too cold
> 
> So, if we ever get back to supporting warming up, these TMDs would
> become relevant. Am I right?
Probably

Can we do some progress with these TMDs definition ?

Spending 95% of the effort to discuss 1% of the proposed changes, which 
is always DT discussion, is quite frustrating :/

You want to add all defines for existing TMDs for all platforms ?

We are talking about numerical values right ? Why is it a problem to add 
their define later ?

