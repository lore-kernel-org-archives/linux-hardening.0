Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E9405C23
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537601; cv=none; b=IwfrR6D0V0iubLcnRQF8ck/5lGatdiB+Q/b/ELZsOZC632XIG7NNEY1/HX+dcAdAZV/OeS8BqTCVDe8cAkg5Xb3c3/534UA3ndD0fa0+4UkZGDsuBd5Zhf7NTf/UKdRYik6HZ9jWtGmsH5Ji/y81hF9k9zLHDWFOlPeI6K8TXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537601; c=relaxed/simple;
	bh=KwUenCCTGlmgA/VcqQxmvfMpJVnf0YViC+wBXBgr9oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tos2f7PBjDGCmH4/b7aAlhczK+s2OSC5XyVMvVUUIL2ockvfd0zE6+mXroHFEZZ6E9goOuOhN0UyzcgTUelAdg+XgQo60T3kHPDMLSoRrMFZ/FqR9pWTWZQyuo8CL3DBRy8z8y00+XCgAZFXqLH7e97JMIXpVjfgFl4Kn7UuCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACi9lPJz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4FVspkn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACi9lPJz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4FVspkn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFK8II732529
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=; b=ACi9lPJzRqm6Ft+O
	dQs5XME/f76WWxRbnjH7GJ7yfRAJ2lHzskCTVl96VVuuwqmcqBRtVMUqPQwW3fwS
	5F9ZAoMx6bOYAxIPNQlAWCSXjLoJ4Um3P8BhymdqZ2s17XAFb4Kao6Of/JHgdHUE
	RRvkmeUAi1K/Hu99t6ZtQ7AJOh2FiEv3YyIrtJV7JS8h0jxdJV4ijb0mzl+w9tKL
	FUpM643/Y29wQJ3odnMZPs0FD3oeVVC6ozRBJ9OmCs5L15B0NNVkHRkkzAVhExJq
	RWspUUlJU1bFkheNdOxoMzD1T7sL4hrierQXWZ0N1FFreFhI9v/FL/0U6kwB81US
	d4yZwQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx1e9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 15:33:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-59ebf602dbcso1955862e0c.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781537598; x=1782142398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=;
        b=G4FVspknmIx4qVoSmnuMkxSLBE9M1h+QgmFvJXAkA0MM+xpJ291axmz6HFAZwv3vbV
         OA36TNKiRxVHTbo7dpXJzXXQYWeJTuBTZ1hqm2lHvt/9iZvBNUxbsq90/joqunGa1tI0
         FitYOUNVbGxNZ5cHkGgZZAW/4QU3R4bZycwOYedYlfHLqWULuA++qFJirzs/TqpUqJ7I
         l3ZaIjh9+Wu8rECSW+EBsEUzFlvSysEKDRwcJ2XnuMOKfP7Z3+961fcu70S0aP5wCFxi
         1ypytZIQmWUr7zKNG1K+y5kP/WtElpaK2bR6QnqO2xa5G7pa/erQJ2+KA2OY0/4yjccJ
         HNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537598; x=1782142398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=;
        b=W8Uhi9zn8Y3Q0NpQqn7EPDqmncYo1Z1HOs19ZuRrHfC0TBGWpMuWN5JMN96Z8gkF/z
         wK0vM3MUnYuGY0mmnICFXdzS2b+roN5YEbPXLTbpUcxzmZqUWWXMHxiVtFrlQkVhLtPj
         IGDSvmQR92TqGMjbWmJtODwoHawcfk9yI7vGDaJxQbD3cHfCPzi2gnDWLTy/fPDd2eiZ
         d7q9Z4LJ4wuhZtBdVGYP5M7zuJlIDDNagOh1n71V+vmu6Vr4I/65GAtgcQQoFIbB0XD9
         GG2zYjqiJkocONxXKmj4QqKuToRSeqKqw73qPkYDvEY/C3MwzK6i1+C8u+yFLzxVgYfx
         Nodg==
X-Forwarded-Encrypted: i=1; AFNElJ+HZSApOomCUGLpZzSAkpfJyFWhk1GRdI45JBel2LkwPdSOA/IBmMc4uyr48wpoG+D1KZHOP2qNjuL01W0h5kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOo9PxY24GSFiLhP6goLl3SZ0I3DRmABWA7MOsRG1FlIsdT7X
	f/kf2UEVPulgh103dD3B1KLK8m2IrXpvGzy1Uj9YJv/CT70JG1/mVZnEcio2HQQtnNVrwh2vSfK
	ZsTL2sAaJrQvYlOE/gHei3ll9kGu0gjScPBSSmQvkCiYB440JZMhDfzmTkfxCah7+6M6HVKA=
X-Gm-Gg: Acq92OEDI3qecfW+Tb79EjfgWtH3zhmCay26GTjtKIe0sLLAg4zGO0UjhOvgqSVyjBk
	WzrtLbj2dRVq/9+dmkJzh8+Uq9ZBeJetSMdRL/axxvDzly9DmI9EpXO3tlmFe+U/9ibnzG6xjaX
	wJYtZb3jVkAoDgwK+bIGN6a3WsJpfDaia2mVrnYVK6gPeZlEGs4jGV66/NgugdxDANGJgdu8QQW
	Z3Jd6mSfYOHZ26MyXbmnZ69ob7sWROXN5TEO1Y+wi2/Q2v4Tk2CYxvNnXO+YJXi2rwqJpGoKoUT
	GJ2akS2pwcD+YQLhDnvtr3q3TA3Z2wbZF7s22NCTG5f3ZgB4w+uVxk1+y0sdr2szEhhlyFS9ujD
	X3FDVebvoxU9g+2iMPJ3P/v3yY4cqu7f1POTXNoUSnaYTXNNwJok4XFbczsfezYb1QFmXcrU5iK
	NjglZlvICgqhQ/eA==
X-Received: by 2002:a05:6122:907:b0:5a0:9ad4:7016 with SMTP id 71dfb90a1353d-5bb6c13290fmr6584828e0c.10.1781537598496;
        Mon, 15 Jun 2026 08:33:18 -0700 (PDT)
X-Received: by 2002:a05:6122:907:b0:5a0:9ad4:7016 with SMTP id 71dfb90a1353d-5bb6c13290fmr6584791e0c.10.1781537597998;
        Mon, 15 Jun 2026 08:33:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa51440sm739885e9.9.2026.06.15.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:33:16 -0700 (PDT)
Message-ID: <dcdfe9f4-aeec-4d85-92a1-a42592fe11c8@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:33:15 +0200
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
References: <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
 <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
 <mp2hl67rupxrssa43dcy36m3dwatlxsu7n27l7qdqsguo5i3bp@bo6sdzxglxt2>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <mp2hl67rupxrssa43dcy36m3dwatlxsu7n27l7qdqsguo5i3bp@bo6sdzxglxt2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nlB_6ac9gwc7cfNAUnkzAnnLAsD8_U_-
X-Proofpoint-GUID: nlB_6ac9gwc7cfNAUnkzAnnLAsD8_U_-
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a301b3f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=UGbA0b5lBdDrEDKOv_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NCBTYWx0ZWRfX2X+KIVVtLlmc
 M+5Np03TzSHIg/avONvQ5IdQnZTFmQVGYsmiuEMjuOS6qhMD8QMosn4BgAGu+zSKLV+2CAn3Kzx
 esSUIc1593XOG6WJ6t62/qj60pHK8dg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NCBTYWx0ZWRfXw9WStkyUrxBC
 C9uQZkK2XSE2zzbsEccREz+MdwUEHDVYYqP9ZS6xeh/NYTUSyFKKCMJLF+clM4sRRn7tSC7/13p
 LiE1Wz88f24Mq6MaJcUxyNnvQa0eKBW+wyycYoKineFBPiwUNlotWFfVhtdYyj4oTVWGVQnQVAt
 ODMpTAkj5bI5Xkw6a1/Tjp4jbaPX4qXcm5ddAGPkvIm2TvHLRMUiDW5XGxMSG1Nh0cf2Sejngee
 cxhQtZ5qRJZamwky/G6CyEm5fzSLavFT+jj3xu3tuZOv57ryoIwyF7WaNxTODYVAXUo5B8V6Ses
 S0o++YweUWBI3/Dk+OQE57OL4tRMm+Tj7s1JmMptgGTUisBnnNvYQNW6z9j3pLRvlrDMaU6InKe
 D7UZtKX4lTYBTbdKBlpOBR2tkIGvZOXjTavZqwevuC25iDiHvlQzqOefapaFi4KOE/JEn23gAiJ
 QCYLOTDrYT8kta6KlBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150164



Le 15/06/2026 à 17:14, Dmitry Baryshkov a écrit :
> On Mon, Jun 15, 2026 at 04:33:38PM +0200, Daniel Lezcano wrote:
>>
>>
>> Le 15/06/2026 à 16:11, Dmitry Baryshkov a écrit :
>>> On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
>>>> Hi Gaurav,
>>>>
>>>> Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
>>>>>
>>>>>
>>>>> On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
>>>>>> On 6/13/26 13:05, Gaurav Kohli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>>>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>>>>>>>> sprinkle generic properties in random bindings.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Ack, will add why part.
>>>>>>>>>>> These names are matched with the thermal
>>>>>>>>>>> mitigation device identifiers
>>>>>>>>>>> populated by remote firmware over QMI and define
>>>>>>>>>>> mitigation devices are
>>>>>>>>>>> exposed as cooling devices.
>>>>>>>>>>
>>>>>>>>>> No, -names correspond to values passed via DT, not
>>>>>>>>>> some remote firmware.
>>>>>>>>>> The remote firmware should give you interface which
>>>>>>>>>> is explicit and does
>>>>>>>>>> not need such properties.
>>>>>>>>>
>>>>>>>>> thanks Krzysztof for review, We need tmd-names because
>>>>>>>>> of following reasons:
>>>>>>>>>
>>>>>>>>> Following Daniel's series [1], the thermal framework supports
>>>>>>>>> mapping multiple cooling devices per remoteproc/device via indexed
>>>>>>>>> cooling-cells.
>>>>>>>>>
>>>>>>>>> 1) The thermal framework's cooling-maps reference
>>>>>>>>> cooling devices by index (for #cooling-cells = <3>).
>>>>>>>>> Without tmd- names,
>>>>>>>>> there's no way to know which index corresponds to which
>>>>>>>>> TMD, as firmware
>>>>>>>>> may return tmd-names in any order.
>>>>>>>>>
>>>>>>>>> below are the changes post new thermal mapping changes:
>>>>>>>>> DT: tmd-names = "cdsp_sw", "xyz";
>>>>>>>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>>>>>>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>>>>>>>
>>>>>>>> names property are not to instruct drivers to register or not to
>>>>>>>> register something.
>>>>>>>>
>>>>>>>> I don't understand the problem and explanation in the binding is
>>>>>>>> basically non-existing.
>>>>>>>>
>>>>>>>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>>>>>>>> which index means what.
>>>>>>>>
>>>>>>>
>>>>>>> thanks for review, shall i use driver data, which is basically
>>>>>>> pas data structure like below:
>>>>>>>
>>>>>>> static const struct qcom_pas_data {
>>>>>>>        .crash_reason_smem = 601,
>>>>>>>        .firmware_name = "cdsp.mdt",
>>>>>>>        .tmd_names = (const char *[]){"xyz", NULL},
>>>>>>>        .num_tmds = 1,
>>>>>>>
>>>>>>> Is something like above acceptable? and this will also help to
>>>>>>> filter tmd names as well?
>>>>>>
>>>>>>
>>>>>> How the thermal framework will bind the thermal zone with the TMD ?
>>>>>> (node pointer, id) ?
>>>>>>
>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>> thanks for review.
>>>>>
>>>>> With id only, in this case instead of taking tmd names from device tree,
>>>>> qmi_tmd will take tmd name from pas_data(driver) and register with the
>>>>> cooling framework with id only. Please let us know if this looks fine.
>>>> May be I'm missing something but:
>>>>
>>>>    - The QMI TMD returns a list of names, not ids
>>>>    - The QMI TMD may return the list in different order than assumed
>>>>    - The cooling map index points to the name of the TMD in the DT
>>>>    - This name is used to match the name in the aformentionned list
>>>>    - The index in the list and the id in the DT can differ
>>>
>>> Would it be better if we define standard indices for the standard names?
>>> This way we decouple the actual firmware strings from the DT.
>>
>> I don't think so, it seems to me too fragile and prone to error.
>>
>> It is a remote proc, an external subsystem. The contract between the client
>> and the server is the protocol. The protocol specifies the identifier as
>> named strings, the TMD names, not numerical identifiers.
>>
>> When asking for the list of TMDs, we get a list of strings. But as it is an
>> external subsystems, may be tomorrow someone decide to send list ordered
>> alphabetically, or per number of states, or whatever.
>>
>> With hardcoded id the QMI TMD clients break
> 
> I was thinking about something like:
> 
> #define QCOM_TMD_DSP	0
> #define QCOM_TMD_PA	1

Ah ok, it is correct if:

tmd-names = "dsp", "pa"

Or

#define QCOM_TMD_PA	0
#define QCOM_TMD_DSP	1

tmd-names = "pa", "dsp"

> cooling-maps {
> 	map0 {
> 		cooling-device = <&remoteproc_cdsp QCOM_TMD_DSP 0 2>;
> 	};
> 	map1 {
> 		cooling-device = <&remoteproc_mpss QCOM_TMD_DSP 0 2>;
> 	};
> 	map2 {
> 		cooling-device = <&remoteproc_mpss QCOM_TMD_PA 0 2>;
> 	};
> };
> 
> 
>>
>>>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>>>> they describes the existing TMDs on the system and the cooling maps index
>>>> points to the one to be connected with thermal zone.
>>>
>>
> 

