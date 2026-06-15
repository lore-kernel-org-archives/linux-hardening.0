Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12F3F888F
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534023; cv=none; b=SMR7qbph9TgmN6LCWs8Jb24GiuS12R91bi5zm4cqFY8HuiEwmnxm+DMI4ECl8hi7GqsMtktkAMOiI3QDBm/YgVRTqbbr8y/1rkeQ1XNMau1+jDrSVr5+npDcIHcY/WNYOBGN7lVZhuuswuiMehiMmwhAHLP0b+2EyqLO2bILQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534023; c=relaxed/simple;
	bh=4Wm4l/st3gWaMHoN5Bw5U9Pr/QJGQ1bGkwqydPvFm9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klEv2CamLl9CW5sQOXYiw9DNMm0HqwzjJO49oV1wyrYjomfk4holYRy+MOB+DzoleZv/FnK/gKMFhzZydIN8WqPtKKX27ZulGMF6me6al+5shU81/vY+IrbBmtdomBGpDePt9YNt5cL0wHypKUrcUp8nE4ZKz1SqhJonHgdxVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDJRlQES; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMKlb5H2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDJRlQES";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMKlb5H2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCaqG3366484
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 14:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=; b=DDJRlQESjIFuNyKl
	k5kRzn5+M3e93sSvxkkqq45B/3srqZe9zJXZVifACNYDIxlA2zk8EHg4P5lOw9TS
	2AyUibj0XZfyWZn+OzEDCwK82MpZf/kyLRtQ0Wf0gx7T4CHctCexao+pYbgbTonM
	VX7Df3fRFxTU0hOw3WlmCl/aLRHaSol4NgNiiJfg65WDghreBTxPqQ1gq+W+ihVg
	NNsE0hdC4wxrrm4PJiG5AlvaYGOFLrzBe3ahkoMusiTkNw4OMbujkg+Ir+XNbAru
	2J+xLr8crUW8LumVWHsZxQurWq8d6yzchDDZr7SbZ4ZdIseka+JjqrzfjwUyfApc
	K9vUnw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx14p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 14:33:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6751db2792dso1398203137.3
        for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781534020; x=1782138820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=;
        b=jMKlb5H2zgBDDIVh0W75SFvzkunxYiEMZHANAvpECbjfPAtq2lrbro5253fZe2buPO
         mrptL+ECra4klMIpeX8xuCv9Hokd8XvSFdnQJlXEvfD687jPgG482CycqTfEMb6/ZiCK
         +Vkt1eh1LsA3yj49Aevc0OvawxxS/mGLoIFhk9FVFbbUnZgN3N3BU5poEiOuj6C1tIDI
         Q+cJHSA+BmIkUuY6UYxL1EbbaZ23sL9eCORleihRw1w5EYKMkmfeitdRRwWp++CUn/ss
         4m2zkqcCuMmTVsu2UKn36S47hWSGK/v+x3dQ94zlEoKCPtxE/7WR4rFOU4kZ0csuyPp4
         7EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534020; x=1782138820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=;
        b=OFrSUsfq5EY/HoCH6Ch5IF7BwxcT0O3QrFfvWMqWFPCiTd3N6P4l7mQJ4NGO1edHdt
         0Yx71JWMGonkdFkyIxLIOgQKVlqm75HcPKtJr8pPCzMCRc2hAjDAtC28l8b0MDP+yvkU
         I4sL7Cbc5jS29u2fBZcHu5I5Vx7WrHbOpCgWfblPm4iHz9a5b/egvqf5LaVr+LIwsNRq
         LKbgSIXHdX/RbzKRPzUoulBRTkECp8VhO5FWjHi2ksaWRo8tO5gLpo0J1ErthdLT/sZE
         g4o0xz5fXYdtoYCxgFc12r5ssLr1lxUVBDVtJhr+Xa7nZKJ5YvFQKcozRPYh8azdZWzo
         16cQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OtVMwsy068Z2DKE2Zo+bIKD8qBsrf0z4d3zgo3lRTGyEVLDsDSSatfuy57mmk7fLi5xLUVzv2PJSDp4gepgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOCACA03erCCRu4goj7KKxVEeCinZCvbkS/k1Sj42Gn88Cd0Ag
	TtgXm3VKzzIwN2cZ3fUTDpiKBG0UrPfV8+7qPpIShdqlFEN/OFCO/feY8FQ3jcVuTMCh4yHSY6y
	KaGxG5pmXO19J1i4Hh1S4vCi2MqrqQZXQpSH3GYRgjJfR1pcHanrnm/vvIluIK2JJT9iixIE=
X-Gm-Gg: Acq92OFz0gM5swZ1x8kqeENDI0S8TQpqj82bAoTnJt0dg2wUzkRbCXsKwkHM8mAUAMF
	bmmR+dQ+mCyPiCdLC+yertjvSkm1zZf2NqRwX/a+s6g0TyI9eHidCofcCk/Ohgp4ZJpMqINm4Km
	2qBFCXnFgr4HFKPrywEl658CNTRoP3QLbuaHfw07FzywPbQ94jfsDww99jmgME+gICMvTfMm76c
	LTa6G+PJTPfwkQMaJBphdGQKGmZNDd4YUf2icaWKkPC0R3dkKMRWXnTu/CEp73bPqGussPRP5hv
	1ttdirDC96zpxM02Lrjh7SgEZ8DXPalJwK3xYZXhY1LSuI4o5I/TmdGF5DIE+ryCP5FPQvRHrDd
	GpB1vNxfG+Aql4s7l8bzxb7bUwrUJPUggEB+YbDgMSnll0StpV5pBiwY5SULe1uORVA6WlEj20V
	xrXVN/QHG8nJdfhA==
X-Received: by 2002:a05:6102:149c:b0:604:f849:462e with SMTP id ada2fe7eead31-71e88db5afamr7325429137.25.1781534020460;
        Mon, 15 Jun 2026 07:33:40 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:604:f849:462e with SMTP id ada2fe7eead31-71e88db5afamr7325358137.25.1781534019875;
        Mon, 15 Jun 2026 07:33:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm30916812f8f.32.2026.06.15.07.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:33:39 -0700 (PDT)
Message-ID: <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _4Kg-phLkp-A8LZ7-vxWqaNUt7vpkR9f
X-Proofpoint-GUID: _4Kg-phLkp-A8LZ7-vxWqaNUt7vpkR9f
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a300d45 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=y33DeBKr3xWxJ8ptnqUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MSBTYWx0ZWRfX2TlI5TA8WFJd
 HzWeqeXiXx+gWCCTS0EAsL/aCFSXVTWdMMEJ5Edsq61L0jl/T/vuubpQ6gR9SV2LfZ84pOVrom9
 HlhHEEn5X6+eS+lNvJNHmNrcewHweo8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MSBTYWx0ZWRfX9OsNOzNBIRgT
 AUuqkFhkCQXfDnHjmzDWUmvdt9uTrrBdgXqCtS79/0Ntxo+8QVyiaP0qJFwnQ4ZpBMdrSpWr+5w
 dz8q15US9Zd59O81HIppdNVDLigmKmo/DqTOb0rp/GSk/Nzk/6HGDnIBllCqYlA/eCd6bFZHVIb
 pjcpn2UfF5eqqrGW2/Fi4w7EC4Wpo57xW1aq0rKyJXMWPQKl8CUF4sG3BMSTpg0DGfjgZjhHOzz
 onoh1/D1peNGv9OZbEiWOWPnSelgs7dKY5wTvPAaAOx3ORoXTNwSXeWyYBQOVx+Uzav3pFbGtst
 NFficVoxTcLbZZaGF9YQX1t+OoO6vM/JZbgJTnR2yUL53nQeoD+x27fs2DqlBfYelElD61NIGlL
 Oxt6cgqlg8lFy96L/8DCs9fVchQy7WXT7rt9g0m+XOo9OmvYGrEOcnEZLY3FqCx74ksC8Cwn4iO
 getfeaO/AN8kJ/GltdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150151



Le 15/06/2026 à 16:11, Dmitry Baryshkov a écrit :
> On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
>> Hi Gaurav,
>>
>> Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
>>>
>>>
>>> On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
>>>> On 6/13/26 13:05, Gaurav Kohli wrote:
>>>>>
>>>>>
>>>>> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>>>>>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>>>>>> sprinkle generic properties in random bindings.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ack, will add why part.
>>>>>>>>> These names are matched with the thermal
>>>>>>>>> mitigation device identifiers
>>>>>>>>> populated by remote firmware over QMI and define
>>>>>>>>> mitigation devices are
>>>>>>>>> exposed as cooling devices.
>>>>>>>>
>>>>>>>> No, -names correspond to values passed via DT, not
>>>>>>>> some remote firmware.
>>>>>>>> The remote firmware should give you interface which
>>>>>>>> is explicit and does
>>>>>>>> not need such properties.
>>>>>>>
>>>>>>> thanks Krzysztof for review, We need tmd-names because
>>>>>>> of following reasons:
>>>>>>>
>>>>>>> Following Daniel's series [1], the thermal framework supports
>>>>>>> mapping multiple cooling devices per remoteproc/device via indexed
>>>>>>> cooling-cells.
>>>>>>>
>>>>>>> 1) The thermal framework's cooling-maps reference
>>>>>>> cooling devices by index (for #cooling-cells = <3>).
>>>>>>> Without tmd- names,
>>>>>>> there's no way to know which index corresponds to which
>>>>>>> TMD, as firmware
>>>>>>> may return tmd-names in any order.
>>>>>>>
>>>>>>> below are the changes post new thermal mapping changes:
>>>>>>> DT: tmd-names = "cdsp_sw", "xyz";
>>>>>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>>>>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>>>>>
>>>>>> names property are not to instruct drivers to register or not to
>>>>>> register something.
>>>>>>
>>>>>> I don't understand the problem and explanation in the binding is
>>>>>> basically non-existing.
>>>>>>
>>>>>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>>>>>> which index means what.
>>>>>>
>>>>>
>>>>> thanks for review, shall i use driver data, which is basically
>>>>> pas data structure like below:
>>>>>
>>>>> static const struct qcom_pas_data {
>>>>>       .crash_reason_smem = 601,
>>>>>       .firmware_name = "cdsp.mdt",
>>>>>       .tmd_names = (const char *[]){"xyz", NULL},
>>>>>       .num_tmds = 1,
>>>>>
>>>>> Is something like above acceptable? and this will also help to
>>>>> filter tmd names as well?
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
>>   - The QMI TMD returns a list of names, not ids
>>   - The QMI TMD may return the list in different order than assumed
>>   - The cooling map index points to the name of the TMD in the DT
>>   - This name is used to match the name in the aformentionned list
>>   - The index in the list and the id in the DT can differ
> 
> Would it be better if we define standard indices for the standard names?
> This way we decouple the actual firmware strings from the DT.

I don't think so, it seems to me too fragile and prone to error.

It is a remote proc, an external subsystem. The contract between the 
client and the server is the protocol. The protocol specifies the 
identifier as named strings, the TMD names, not numerical identifiers.

When asking for the list of TMDs, we get a list of strings. But as it is 
an external subsystems, may be tomorrow someone decide to send list 
ordered alphabetically, or per number of states, or whatever.

With hardcoded id the QMI TMD clients break

>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>> they describes the existing TMDs on the system and the cooling maps index
>> points to the one to be connected with thermal zone.
> 

