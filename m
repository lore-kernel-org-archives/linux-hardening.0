Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136C3F4840
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526665; cv=none; b=o+Hw9nYEm5NJ2EaljgkVuEewIsXPsr/KEFRZdqEBn9jxaTw+iW030s0W4CjDmfeUFQ631Va6cvtIvWuvLaLcSN85uI/p7yZrZw5hRe7r3sCJxymuFfcx9qrjyQD8wLDCKIremmUgw3OGQV60NL6FNwyNy+TjsadY9p6Uao8f4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526665; c=relaxed/simple;
	bh=4nzEpuGwgNL0R2NblpKrggs9ml7l1I1ZGGJOsujlLzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNjTvGfnypodj56bDLmgHWHUN4/3+IoUzFdhFN6HEnJjx2rXHHFaRdY/6Irj9C8zKJ7U8XAjcFSKx3+qJ6Y1Ybv3Gg1aH0rI5sw+mAJNvzwWC5QNGqrgViuPBZmU2D2sKi6xzyi4PGnS4RShYO/wcltAoRe2cU/+wL3/G/Ak64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R51mfMBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ELsRiAeh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R51mfMBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ELsRiAeh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAoKDk3972213
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 12:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KiXHBkLlgkRaXk44sFimwo5t89c600tXG9f+rJEMgMI=; b=R51mfMBxrAYMYcOE
	Xy8Kn+eR8j/pJLt7NGydvGed32wbCQAW0d8UEsEsl147osIxIdl3VrmMiA2137ag
	rnKtpFD1XuDtDKXSv+ltL1OvXHp+7bbilNTZ155ZKPnSdfPIN5uuD1daEPctXyZf
	U2J5OxjGpYc+5WGI0hr9WnG6LObZV+aZAt5uDaUUmoiJzG0+21PHeWOkCgfTAUPF
	4HjLBmTP8FSWI+ugJCM8+1BXK+E5tLXiuqNanewOk1IGN7iIP/xJtrWkadwJxGQ6
	Tzq2Tp3oLmmMt8Z++VHpFVo6QxEUuRYlbX8mb7d6m9xr6gHlyPPc+R7/5X8ChaSN
	y+BWLA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteyd8mq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 12:30:53 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48576b309c7so5429275b6e.3
        for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781526653; x=1782131453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiXHBkLlgkRaXk44sFimwo5t89c600tXG9f+rJEMgMI=;
        b=ELsRiAehlCoKQp9E1oAFvqF4o5PhJLvFhC3MEVROEgyVg7npOqLMli50g3hptkluup
         mSQk5Ctj9Sh+3+QFi77YoACppjBCt3Mc7+MipnEVfPQtlOiceIbHJ11c6ZnJNY/VgYZy
         lXvIwbqcU2lKGZ2Ch+Vp/mV64GntRokI8/KF+QB56tiyRJYOi7z+wr9O2YZq6dTBUJgj
         4TOY/UrJIwdPZTO/pRdEfzNWP59W8QKwL8V6yRnUcKzNistXxaR3aIPz3ntzuNES24bb
         NM+ShxXY5MG8sYd3J2TCFQ+7gQnaKqi6ccvIyEkCkwa4dHZLXsZWWujTEHMtfCG7dXa5
         gMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526653; x=1782131453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiXHBkLlgkRaXk44sFimwo5t89c600tXG9f+rJEMgMI=;
        b=lq0RLGZDCA7tCkm+BpmbchpCMvPGzdkTEFEQKNm5ShZWZ8TU7gPMGXHUxi8YUMeoxW
         Pd47OvIS9AEtm7ZpCKEpwXYlgj6MwhGhZARvi8dlLFnwpZAcx40IcuTa+LIxnN2aGHyL
         JSt/OdR7qe81ATeQ6YQ92FGO6ofej5Pkjh4rUzwADyxWNlq/7Yu0L3owbnkR6EERkpme
         HRx+gZLtTaZlj8yEbRnwLbMypofa6ygjstsvk5QmujuUINA2Q536t6Ufn2ui8CsKGy/V
         TNKNkZMeak+LObMzumRjler6rmHW5H33cODL46hiOOwl3GEF5vkHsJHq8E2MTWE+PLzv
         UiUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7+4OlTmAvvi9CPYpRZa95+0pdUKnD5YOx+vPsAe7EFKpQHgXYIOztvjwOkMyREnqM5a4m4oOqLqVS2xYHPtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQyxlkYZR44BnErcrCWJOhv66Wqmrj09zUHYKIeXlR2aHn4D9
	oZFiAJLCCvpEAUkRvJSbX/iOXTVflreeavGw89KPcdlchDz4cuKfmlvBVbkHWbaq/7wlc1IUXki
	ViJZ5vXoj5ykTBn0ae2/FL63V39FWlV0jATRrn5Ltstgbpz6AFmY6wM5oEd4T187b5xXGhU4=
X-Gm-Gg: Acq92OEgy9tIp1+gLR1hTnFzfOdavEsOzfA9XI5Hh1TK6dGqEUx/dIHTmFlQi/B5poq
	HbISAwtrlPtBttfAvxT2qP50uMgvj6GiBGgtaVof/hy9t7d1Vxh6/XFg1db5FPzTGNrZpO6TWtU
	6V4LlKABFE4YlwIFUEmbaMMHsDqTbd1UqQ/CTtg0t/5ZsMSBf04LFuKwkSCFDwhZrKBfrpndi/B
	ilgU7xj6dxFU4asKUyXkLzTWKMjbgj4ZnplCKTmGn4ufG0SUdVeqMa5a27JqEo0Nr80w8Izha/A
	8Vo9ysqUloefAfa+TjQeuuvWadRGk6qNv3IDNpjL51W3yNK/UuJlT9woe4xoHOq2cYcSglOT5P7
	uF5RuhSDwf0Vk9K/Tsp3n9mePoPiCcYyCqKhMjeAGAbg99k4MGlA8lc7WvzW85GTJs/ork8RvLx
	fIQCDTMCAWbFVfOw==
X-Received: by 2002:a05:6808:6f91:b0:486:7e34:ebac with SMTP id 5614622812f47-4872f608696mr9488774b6e.42.1781526652560;
        Mon, 15 Jun 2026 05:30:52 -0700 (PDT)
X-Received: by 2002:a05:6808:6f91:b0:486:7e34:ebac with SMTP id 5614622812f47-4872f608696mr9488748b6e.42.1781526652092;
        Mon, 15 Jun 2026 05:30:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm203208835e9.2.2026.06.15.05.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:30:51 -0700 (PDT)
Message-ID: <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jXE_H-K017T0VB0ooe0Nu0xT4tZQRfit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMiBTYWx0ZWRfX6uJnmgvzVC6N
 bQQwVxK1q5Noax/xYcnJ6LoV9on9mTDyHVyD5mm4tCFv3osgtaJlHLs8Wp/9DDdbdCHV3UuKxvX
 7vA27v4hOYUQCYyhUGW+uGaWOuhXAzc=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a2ff07d cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=vdW527L6AYu-INn279QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: jXE_H-K017T0VB0ooe0Nu0xT4tZQRfit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMiBTYWx0ZWRfX+b8veRnR8GVK
 bny7ZBgYUIoNDxs4INK2RHFq6WWEiwtJgTop9oDeLDb8TbkPee3pphpOA9cBW5NinvRveJsTKLG
 5hv2GEwrsVsxEPn7VacyYcNboTKZN2WbRK5oqnqD0/6PfVFEHdrBH6nz4/6aCwJLJgLDWHlqlGY
 Bo5BwRPzgdQyKtDqfnwgTZ9m3bppA9jsYy0UjghjXOThLWstTXSYoNywdYg/0AcBu9YtTTI5Z9u
 95mS4VPXKGVcnTTJGTXn9HOAmL14IffAnco/djJniCjws3S4r+1VJPr1cCHwXaAdbgaGWmvgJ0b
 x5r0Ebo/aD8E6jHW+QH2R1bLkKoHjJPZbbrVsZ+G3BwOjZNz5LvnYtXZ4dq8iKzkvaHcT0uxvYD
 M5YDp/5Yh2lX0WhHCMkBsVXdDKgOPeP8Ih5B8IXjDDjuH8vqH3gtyJYD4F02oJFkAjkXNyi2uzL
 0IXzptQ3PmCemKlVFFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150132

Hi Gaurav,

Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
> 
> 
> On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
>> On 6/13/26 13:05, Gaurav Kohli wrote:
>>>
>>>
>>> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>>>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>>>
>>>>>
>>>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>>>> sprinkle generic properties in random bindings.
>>>>>>>>
>>>>>>>
>>>>>>> Ack, will add why part.
>>>>>>> These names are matched with the thermal mitigation device 
>>>>>>> identifiers
>>>>>>> populated by remote firmware over QMI and define mitigation 
>>>>>>> devices are
>>>>>>> exposed as cooling devices.
>>>>>>
>>>>>> No, -names correspond to values passed via DT, not some remote 
>>>>>> firmware.
>>>>>> The remote firmware should give you interface which is explicit 
>>>>>> and does
>>>>>> not need such properties.
>>>>>
>>>>> thanks Krzysztof for review, We need tmd-names because of following 
>>>>> reasons:
>>>>>
>>>>> Following Daniel's series [1], the thermal framework supports
>>>>> mapping multiple cooling devices per remoteproc/device via indexed
>>>>> cooling-cells.
>>>>>
>>>>> 1) The thermal framework's cooling-maps reference
>>>>> cooling devices by index (for #cooling-cells = <3>). Without tmd- 
>>>>> names,
>>>>> there's no way to know which index corresponds to which TMD, as 
>>>>> firmware
>>>>> may return tmd-names in any order.
>>>>>
>>>>> below are the changes post new thermal mapping changes:
>>>>> DT: tmd-names = "cdsp_sw", "xyz";
>>>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>>>
>>>> names property are not to instruct drivers to register or not to
>>>> register something.
>>>>
>>>> I don't understand the problem and explanation in the binding is
>>>> basically non-existing.
>>>>
>>>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>>>> which index means what.
>>>>
>>>
>>> thanks for review, shall i use driver data, which is basically pas 
>>> data structure like below:
>>>
>>> static const struct qcom_pas_data {
>>>      .crash_reason_smem = 601,
>>>      .firmware_name = "cdsp.mdt",
>>>      .tmd_names = (const char *[]){"xyz", NULL},
>>>      .num_tmds = 1,
>>>
>>> Is something like above acceptable? and this will also help to filter 
>>> tmd names as well?
>>
>>
>> How the thermal framework will bind the thermal zone with the TMD ? 
>> (node pointer, id) ?
>>
> 
> Hi Daniel,
> 
> thanks for review.
> 
> With id only, in this case instead of taking tmd names from device tree, 
> qmi_tmd will take tmd name from pas_data(driver) and register with the 
> cooling framework with id only. Please let us know if this looks fine.
May be I'm missing something but:

  - The QMI TMD returns a list of names, not ids
  - The QMI TMD may return the list in different order than assumed
  - The cooling map index points to the name of the TMD in the DT
  - This name is used to match the name in the aformentionned list
  - The index in the list and the id in the DT can differ

Krzysztof , I don't get why having the TMD names as properties is wrong, 
they describes the existing TMDs on the system and the cooling maps 
index points to the one to be connected with thermal zone.

