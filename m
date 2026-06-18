Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328D3C10BF
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767044; cv=none; b=D2Wr1fWLQXBVdDZNmeeWXxkxr7umGYY2PXZePiIP7PEz+fBzGuGK+5vezMudgWM41FheDwagci55S5w/yKfcHADWHSzWF8Hb3YqaiMNTtFddB+WXR+diCpYac6oIoQGj93RQxKOl0/+wJg5/EgCJcG4/d2ikNbTW7dnNOepuHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767044; c=relaxed/simple;
	bh=8E5qzq+mZ2iFEEVvuk30mGz2SpkrQKNDsaBE7t3Hf5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2sH9HzDB/xz3VNh3lCXIQyzqd+9sF4QHAGZOYcr1OD4K7aVrvx/WbzugSAZhWFzL9U7YSTF5gmZ4fGTq0ufXDaR/OKDdWjrr9UO2HnVbbtuxlQCLjeMJSFAI80Q33yFwxS3sbXR2OhmDffe8M0TK8Yf8FLIfLxEq7b0kjwDqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvtMUwOx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XAiMlrKz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvtMUwOx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAiMlrKz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I7DY7B1084930
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 07:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=; b=UvtMUwOx+IBw1L42
	6Vx/3Jt9wIEbq1W3cy4jzghi9EIUr2I98o1Xip77t/5rGDmy+0rPIPGnnoOBxFy3
	qKwdu8vlJI9GNln/DNllB1BVC4bQneecQsvu5yga0JMalJHqFQl/DAxiFdn5/3Dv
	VxE/CgMDGRf3OboxAgtogVAfEC6aK5EMUvpczIzOV/6QYcGVhimzs8BhiA2NEU0F
	fxwQaWLSHz6oFLTc1SSzV7P71b03lf8Ds+BrWr8+R+rI1EjGDGRE9c4+j8zcUfGY
	V3E2bkE0kd7GkIzYmaHMk4atgy5EEwF1rjxTMsOthHZScdWFnvMZqxRNmHjVlyyW
	7cVCmw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2judef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 07:17:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cce230de8bso23752106d6.3
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781767041; x=1782371841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=;
        b=XAiMlrKzSuGFQinYsnKI0sIkOLCPoueU2DPq4+3p3XLPW0ZLwJyeAa7yzm9sVFJHrr
         ZB26njiwBysPA09xMu9gtmk444GTGPvF47A8dIm6Qm6bSprWHAO86yqjsBNJdba1YzMR
         3ov/OCa0sr0IQ2FUe27C3l4KyavJBX37BWzwtSxnJAyl9dUMRvywMM3lORk04xOe1uM3
         BaKd4+dX58XytcgsUslYVqVnfQKJ9Y+pIr1A91RsjE8XyeKDWpfJx1+f6E9p5kWTKbPQ
         k0FMkOYAWm/he2CBYDw++BVQljKN9o7tdZ0kGp4bXn7QkbD32AeqMKmRI2KnBcC5jQXr
         Z3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767041; x=1782371841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=;
        b=ejzhK/iNpOsI5gQKu+4bfNnOuMcpna5It46aVGl1JoVEUNPOLITDmRtaPlGzTX1Eog
         HT2b5oEGzpq8WQmTc1eVJUtpJBOsq5eHvkJBpAFZw/6RkXtJVpMRjGbOJFNCy1r0B6Pc
         OpQar/+fi1FeU94Qe3awBhFy0pbUCPKwYB2/uyLstffaKC9BjqUf46os6tLBJd6GwxOH
         MjZYWauLfnQCH7CkaY2vxDeNnFyYzRQtSCK7vMjzw4UUUrh8rYmyKQMCjVyAYp+D+kNt
         1f2HaO8xt/x7UY+Ug3L6GVOxgnTM0GwHhcLPemrWUSchWj34zTFQfoehNtunMSlMgtqo
         Xgtw==
X-Forwarded-Encrypted: i=1; AFNElJ9H/5unoU41zHeVURKX82Z0X179rQps9KzzIJt7JhNSZtAs2XPOF05CwRp3jPcrJrsoSaanuubc9fvYvfp7WKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZjJ8ogpCwuxWgy2lUXpa/4snn1STHIFkvMrL1ipytiA7TVrD
	XK9+rL5zxz+jedGX2W2tJmsw/0AsHa0oecXqxdm19q3MuhqLvjWrUcMJiyjtLvhVZJXR1sPLz85
	mehGbNpmzg/XkS9SEGdaCSRJU1mLE6v8Rxi3lDKcjO50ZZNTmUnzDw7PqZkUcgbL36t3HesM=
X-Gm-Gg: Acq92OGewajOxonZrYNeFi+gYnk4NvDgjytDT0sQAzMCUXPbV4rCYKUJv8qvMyqOj9+
	SIJkGEqRJFSMJLcamfJj7K/2JQOVcFxR/bNBk5DHx4IrZsqpXFNQi0cepvNAXO8tydBoaJqwF7n
	nKvZ/TQvq879Bsh85y2pFNnX8FriiSRyJ/erQh8iRetz9zem1aTULmnXUi0K4/iE4M3fjQHAQHT
	F3PK2wOOd06ZSP01aQh2STDfq3hSJb6ay+GSa5pgmvADLJxCAwaqKcTqo2HAgEsJap+aoA/iXJs
	emw4U3J6TffEBSlO3rqZhxs7Ncj0njubjVDeOBZhD5QgulakyZYFWlyi8Px+OwrYRfj3wACPM4Q
	Wn9/9+S1kcWUY7v/OxQ0de+qiMpol7/uCMr91cB9xxRfx7Coava+dD3nftFetF5TtrIMY7L0Ukw
	==
X-Received: by 2002:a05:620a:4722:b0:915:8502:f808 with SMTP id af79cd13be357-91f27600dc1mr350112185a.25.1781767039517;
        Thu, 18 Jun 2026 00:17:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:915:8502:f808 with SMTP id af79cd13be357-91f27600dc1mr350109585a.25.1781767039081;
        Thu, 18 Jun 2026 00:17:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5ac4:8c5e:b742:f9c9? ([2a05:6e02:1041:c10:5ac4:8c5e:b742:f9c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm55095264f8f.25.2026.06.18.00.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 00:17:18 -0700 (PDT)
Message-ID: <61765401-3397-497d-a0ca-e9bf9d76cc6a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 09:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfX6tY9tx0aU9DZ
 znWxAIF317zvfBUzvd6lQ2xvBktA7Lofktvy7N6pY0s0rftu1Y/LQNnDyyUO7esbUSjJ5PPOk7x
 S/NN0ae8XeHEr4wX4tKOvnz/G+EDeDeoXA4kKKTPiIEmBr24SdjAPKdE1U3k9u8ZKB3XdPhg8uf
 tkEy3T4WijY+W9Sk3FiDllYFTcFHP3khk/NnqFK5ljYsJic8EeX+IyAJSo9nf8EBGa7b06ewKg7
 wAhlwLIDwUwjY93W+aAzda4sybHtdYxV58iXieqS+o0/1wRhxgjBkq2CJjaYcZLjWcEmqncz3FX
 je6J2aGkt/+LEDLhKEEVb87AvRJ3geZHR2vOE9eRUzSDu1X7L96Gvu+fcVALA7BLY/GJc77H+fz
 1INhV9XynbHrzX6GRiVlkAwcMdQ8DhQ/o7Phyfstb3Kl2CjEBP3BtglRUd0XYKbBgC7ICTUoCYu
 C+9KMgEvPFekA6FUmVQ==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a339b82 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kCrNj1x4bCXofucgv5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: KL-c-IjQQXkQ-9TXVi3hu7MGkhNk3D42
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfX9wUqddgtcXnS
 n2sDbKql/e2TFxea4Pw2uzrdsxxGthUcA/6V48sd6GECLklmugshSXM31UV/E1A9UTDc32WiL/P
 c+chbf2Cvo2WI8FX7VhTiJMlAfQipEg=
X-Proofpoint-GUID: KL-c-IjQQXkQ-9TXVi3hu7MGkhNk3D42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180065

On 6/16/26 06:21, Krzysztof Kozlowski wrote:
> On 15/06/2026 14:30, Daniel Lezcano wrote:
>> Hi Gaurav,
>>>>> thanks for review, shall i use driver data, which is basically pas
>>>>> data structure like below:
>>>>>
>>>>> static const struct qcom_pas_data {
>>>>>       .crash_reason_smem = 601,
>>>>>       .firmware_name = "cdsp.mdt",
>>>>>       .tmd_names = (const char *[]){"xyz", NULL},
>>>>>       .num_tmds = 1,
>>>>>
>>>>> Is something like above acceptable? and this will also help to filter
>>>>> tmd names as well?
>>>>
>>>>
>>>> How the thermal framework will bind the thermal zone with the TMD ?
>>>> (node pointer, id) ?
>>>>
>>>
>>> Hi Daniel,
>>>
>>> thanks for review.
>>>
>>> With id only, in this case instead of taking tmd names from device tree,
>>> qmi_tmd will take tmd name from pas_data(driver) and register with the
>>> cooling framework with id only. Please let us know if this looks fine.
>> May be I'm missing something but:
>>
>>    - The QMI TMD returns a list of names, not ids
>>    - The QMI TMD may return the list in different order than assumed
>>    - The cooling map index points to the name of the TMD in the DT
>>    - This name is used to match the name in the aformentionned list
>>    - The index in the list and the id in the DT can differ
>>
>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>> they describes the existing TMDs on the system and the cooling maps
>> index points to the one to be connected with thermal zone.
> 
> 
> 'xxx-names' have a fixed meaning in DT by convention - assign
> identifiable strings to the 'xxx'. I miss the property 'tmd' in such
> case - its definition and meaning. Where is it?
> 
> But maybe you just want list of strings, so I am open to discuss it - I
> don't understand the need for this property and commit and property
> description tell me nothing.
> 
> Really, this commit message is basically non-existing. It explains what
> it did and provides that much explanation WHY:
> 
> "- tmd-names (thermal mitigation device names)"
> 
> Really? This is the explanation why this change is being made, why this
> property is needed?
> 
> So sure, describe the problem being solved and WHY this problem is being
> solved that way. Maybe it will fit DT.

Ok, I understand

Let me try to clarify.

When the QMI TMD protocol is initialized, the list of available TMDs 
provided by the service is requested. They are identified by a *string* 
not a numerical id.

We can not assume the list is always in the same order because the QMI 
TMD is a separate subsystem and the interface is the protocol. The 
protocol does not refer to any TMD with an index but its name. 
Hardcoding an index here is not possible.

The name identifies the TMD we connect to and in return we receive a 
handler to use when sending the QMI messages.

That is for the driver part.

I understand for the DT, it is possible to not give the tmd-names 
because the it can go into the driver's data structure.

But the thermal framework won't be able to associate a cooling device 
(one TMD) with a thermal zone because the cooling mapping must point to 
a cooling device in the DT.

Initially, Gaurav sent a description where each TMD was a child node of 
the remote proc node. And you rightfully told us it is no longer the way 
to go as stated in the documentation. And you suggested to replace the 
child nodes with an array with the tmd-names and add an index in the 
cooling map pointing to this array.

The thermal framework has been extended to support this new format and 
associate the cooling device with the thermal zone. This change is now 
upstream for v7.2 [1]

The resulting implementation is the driver gets the tmd-names array 
property. For each name, it connects to the QMI TMD and register the 
cooling device with the index corresponding to the name position on the 
tmd-names array.

On the other side, the thermal framework parses the cooling-map, gets 
the index and do the association (binding).

The tmd-names array property replaces the child nodes and allows to do 
the mapping between the string based identifier with a numerical id.

I hope that clarifies the approach.

   -- Daniel

[1] 
https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/
