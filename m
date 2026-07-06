Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10E2EB5CD
	for <linux-hardening@vger.kernel.org>; Mon,  6 Jul 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357405; cv=none; b=iq55pDPzvwr/OyZj2UqEuwCHaPw2KoukgAnGmTGvGcS/zbU0tViC5nSEBuCImbKEXeHKxJLtfmCezYRdjnyCcxP6RId1odLO5jQeiTJkQWLhz5ffsqkzelt18GJW+FxgjjjAJH3HOpKxdcgsjavco34qamI9+7MZvPO/d+Krjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357405; c=relaxed/simple;
	bh=r8dr8IOcfwg+4aJ5OP62vUJ51fIC4sI6eTxM/L8hnk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMgtGF/Gn9HRFCuLsGiL+2HlrRNqqOI878fVY5BUA8jRzsZX8tQgEKFyVHEaey0LluUi+XlWrh0YhaVidRsAdbhvbkOxcdtCAlccZF59wotjIeWNhy/q+JhYnaiCwmx1HgoKT6UP9gBCJKjV8he6Nm77VJC2G48wEXttH41d6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tu7MeVVr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bGbsV6ei; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu7MeVVr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGbsV6ei"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6Rd982426
	for <linux-hardening@vger.kernel.org>; Mon, 6 Jul 2026 17:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TA5xENm3BPzH4HkN/s4HznkDy9RVKhTBp0zdzzCIVNs=; b=Tu7MeVVrAugFsCM/
	xPF7t41ayaUL90CDOqxaGRHihK9UHaRDskqS+JB9IsvA53cIQFCobztUcV8c+UQF
	2RRulqTD6p6UtXhStUX/Eh/f2MK35rrmgmf1mP7tQXZPRiFETNt9jnl9zEJQ4Qg8
	khIN9aWlMWrhnl5fsy7X1prLb/wInie7UFXty9UPQW5ct8D3n8dd81M8ZXf/TXTy
	C39T3Bm1z0sJaImrivoTO8rHCGCEhizPrbQDeFwRUk310NuGoi1KKhSRrwa8coft
	OPBlowCrW26XAWT+h+r17HeGcPhxJjIQRs/ymVIrS69sizm5U0wa0FQ3x9L4zh3/
	/6vt/w==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpj333-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 17:03:23 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a1791a6281so4654321eaf.2
        for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357402; x=1783962202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA5xENm3BPzH4HkN/s4HznkDy9RVKhTBp0zdzzCIVNs=;
        b=bGbsV6ei+BTTFcEd5kkOIFQ6MsXHtx7dbLDdGnL/7d3fGwbfrA49zhNnlYbISxxzCQ
         IHnIJjOFR28NC3OWmX4BVLkqC9hr7bgAqaJWP3Akazs5ZUendAecx9vs6jJIqhSOC1HB
         6uvdQAd3VFz+42ZcS2fLi4PJ4jdlXuv0SIm8YmaIOOdfQkHiKui2GG1llDAUM5uU31IN
         ckNcxkNVISTUUKCYq/9WckJBwJ917tvS4x8GanDa85dynXoIBSRYnN0VQXJwsJlynieO
         awfru+2UU5zEVMAn4Xl1wInNl7Zh5ol0J01wHKBc+N2zMGQMA664bl0Ib9tD7Ancs02p
         2/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357402; x=1783962202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TA5xENm3BPzH4HkN/s4HznkDy9RVKhTBp0zdzzCIVNs=;
        b=eeT+AbyGAB4RzdYKjKYCYVbj5EeHaRQGGFxkFgH8WxtKQ0UhEA/4neuv2uow30KstF
         sB3Atg79XWc4We1ubU+8lWFZSgBty5rdipqUh3/xNDHbmqEaleh78VmpuePuLR/KCJ0a
         WBCxQBVyYbdQv1JcpkB2DwjaLl4l2DtdOAHAIpb/sPvkIb7HTzCOFCehf+yrCwvULG1T
         eFC23rKyCQhEuwLHcDzrVm8ywp6Ufoet7zrz2q9Zs7+4iI7wc9qsvcZqvUl7+FRxLyNh
         T/4kQOKZnizsDFQ54Py7ObSVGtSpYoJ5ObpG2ptqv9D+znk7+EB9rwqN1bovEwQc3Uqy
         HxAA==
X-Forwarded-Encrypted: i=1; AFNElJ/h3ffCKeHhGSuKdpaj/+WUM31rmQFBuLk/sSIeo9I8elRRsw4rpdU3QiQJyCPX05E9uPgdUV52gGGHiFnthQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaxYN86IYT35OpD03wddcTU26yfIfeZbCiibMSWCTW68oX4Ci
	WKpjztyLk8E4oNBiXO8Okbn7rtnvwvDKzuFWGhAjryGIdE3FBwWfIkaYQdEmFh27DDgXfsiVnhv
	7vhb//P4NLw649bJ8We/y9MjwKD7gu1xtfdJlqghtYc8+eQ5tnoUlDkS6x5lvqRJkb83hNVs=
X-Gm-Gg: AfdE7cn3ZmAUDweSy29w5+fmXojPym5xjmkqKvwNle7sNMXMocHMMO5H/GLmQ+t8Xs1
	ELOaPNrdovayCn6VYSDL9j2WIIQEF/V5N7QdfgilvVDXWd9qE9Nb9VTH5KYCDoCmI6m7wBiH+YO
	mZk3wDJ7Ca+3zePDgAUf/AQs0TrGXgZh/4RrRcD5uHiT1q9Bgf9bMeJQ9FRuJTp3+XheIixMXYe
	he2KEOe5BMODwj6PT4VDELATXs4ca3nGf1iC2Kd4Q1BYca5JIyPX22x83E8PsUIvOjy61NWvaza
	aJJHxqOketK7kieM3L58tVN62dGSOh453rzKmbg1rzQRqVdYyGpmWMygw+ZSQf4vjyunfu716UV
	fi46L58ZJBkp8NFXTDoqTVMxz3khfyKeYdZ5FMxXrSXqaABvUPQkNmIQRAp/KVeTOWVaB1RlBMQ
	==
X-Received: by 2002:a4a:e909:0:b0:6a1:9a9f:7be5 with SMTP id 006d021491bc7-6a35531fb57mr834942eaf.10.1783357401957;
        Mon, 06 Jul 2026 10:03:21 -0700 (PDT)
X-Received: by 2002:a4a:e909:0:b0:6a1:9a9f:7be5 with SMTP id 006d021491bc7-6a35531fb57mr834897eaf.10.1783357401401;
        Mon, 06 Jul 2026 10:03:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdabda3sm302109075e9.5.2026.07.06.10.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 10:03:19 -0700 (PDT)
Message-ID: <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 19:03:18 +0200
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
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bdfdb cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JlQGkihngbUv9gwkSFUA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: xKKLY5ffrFoWHomPJkRmZoyUSJz6M1st
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MiBTYWx0ZWRfX6754YXyrErHQ
 rMPFEaVUpAtJBVKuCNXDqfjcRc1zF/I3yCg4S+OC2USTghbldd5ftF9pGxIqhMYv4M1finjohEG
 pvbNJcN17GUsBgIGtLgAqvwz+Q+ri+iOSmIff0ODXj+nVDaVEFznhSVOtW8pZ8gt1IOs0cFsnMo
 /+mgcaKzezpqekunwmNcgC4rvldbdo+qdqX9Nkq1WHU/+NhEKlnWYPw2tafjiuq67ishluPGE0B
 C+gNgz07uHRMgbxyJY0Mye3fEJMrySI1lLtVE/XazMcq6MrF6GqLYTnYeXYxP2M1pSLF+/YBiFb
 JwVvoyXeRmwLPuJ4/XG7/tvcFUfzwf8U1pUe8lnssY20DkC5hZQ1cxh2OKOA6hYqZaM06Hlo2mu
 ZPMbHW2l9WvicwZehCBQTR9Cd2gfTYqMCWwxr1EOsjo4/X+hw5KiX6sCj14DsD+zk2ImqJVFyOg
 2qgkNdyCL5ky98Yub3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MiBTYWx0ZWRfX6e5snvMKAqcy
 GDUaPDR3RBmqTthfgh94t1+SuDEo4nqkFPfUKhHHMp9HaM9Tf4XqG/B5vMo6Fn1yViduBGsk/q2
 wK/ut7BzzS0RT3awadu1feYIk0pKflA=
X-Proofpoint-GUID: xKKLY5ffrFoWHomPJkRmZoyUSJz6M1st
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060172

On 7/3/26 17:42, Dmitry Baryshkov wrote:
> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>
>>
>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>
>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>> through QMI. These endpoints can be registered with the thermal
>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>
>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>
>>>>     <&phandle device_id min_state max_state>
>>>>
>>>> Define common TMD device index constants shared across currently
>>>> supported platforms. If a future target requires a different mapping,
>>>> additional target-specific constants can be introduced while preserving
>>>> existing DT ABI.
>>>>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> ---
>>>>    MAINTAINERS                                 |  1 +
>>>>    include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
>>>>    2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 57656ec0e9d5..ffd85fd1dd80 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
>>>>    F:	drivers/soc/qcom/
>>>>    F:	drivers/watchdog/gunyah_wdt.c
>>>>    F:	include/dt-bindings/arm/qcom,ids.h
>>>> +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
>>>>    F:	include/dt-bindings/firmware/qcom,scm.h
>>>>    F:	include/dt-bindings/soc/qcom*
>>>>    F:	include/linux/firmware/qcom
>>>> diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>>>> new file mode 100644
>>>> index 000000000000..73efecef0f3c
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>>>> @@ -0,0 +1,20 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>>> +/*
>>>> + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
>>>> + *
>>>> + * These indices are used in device tree cooling-maps to reference
>>>> + * specific TMD devices provided by remote processors via QMI.
>>>> + *
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>>>> +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>>>> +
>>>> +/* CDSP thermal mitigation device id */
>>>> +#define QCOM_CDSP_TMD_CDSP_SW	0
>>>> +
>>>> +/* Modem thermal mitigation device id */
>>>> +#define QCOM_MODEM_TMD_PA	0
>>>> +#define QCOM_MODEM_TMD_MODEM	1
>>>
>>> What about the dozens other ones that Dmitry's laptop reports?Ri
>>>
>>
>> Thanks for the review, Konrad.
>>
>> We are only defining constants for the TMD devices that are actually used
>> for thermal mitigation on the platforms supported by this series.
> 
> Why are you using only those TMD devices?
> 
>> More constants can be added as needed.
> 
> Kodiak is one of the supported platforms.

What would be the benefit of having more than thirteen cooling devices 
declared in the thermal framework and having only a couple of them 
mapped in a thermal zone ?

I agree there are more TMDs but if they are unused for the moment, why 
do we need to add them ? Can we do that incrementally ?

> Running the same tool produces:
> 
> TMD service: instance=0x00 (modem) node=0 port=20
>    29 mitigation device(s):
>      [ 0] pa                       max_mitigation_level=3
>      [ 1] pa_fr1                   max_mitigation_level=3
>      [ 2] modem                    max_mitigation_level=3
>      [ 3] cpuv_restriction_cold    max_mitigation_level=1
>      [ 4] modem_current            max_mitigation_level=3
>      [ 5] vbatt_low                max_mitigation_level=3
>      [ 6] charge_state             max_mitigation_level=3
>      [ 7] modem_skin               max_mitigation_level=3
>      [ 8] modem_bw                 max_mitigation_level=5
>      [ 9] mmw0                     max_mitigation_level=3
>      [10] mmw1                     max_mitigation_level=3
>      [11] mmw2                     max_mitigation_level=3
>      [12] mmw3                     max_mitigation_level=3
>      [13] mmw_skin0                max_mitigation_level=3
>      [14] mmw_skin1                max_mitigation_level=3
>      [15] mmw_skin2                max_mitigation_level=3
>      [16] mmw_skin3                max_mitigation_level=3
>      [17] mmw_skin0_dsc            max_mitigation_level=15
>      [18] mmw_skin1_dsc            max_mitigation_level=15
>      [19] mmw_skin2_dsc            max_mitigation_level=15
>      [20] mmw_skin3_dsc            max_mitigation_level=15
>      [21] wlan                     max_mitigation_level=4
>      [22] wlan_bw                  max_mitigation_level=1
>      [23] modem_skin_lte_dsc       max_mitigation_level=255
>      [24] modem_skin_nr_dsc        max_mitigation_level=255
>      [25] pa_dsc                   max_mitigation_level=255
>      [26] pa_fr1_dsc               max_mitigation_level=255
>      [27] modem_bw_backoff         max_mitigation_level=255
>      [28] cpr_cold                 max_mitigation_level=3
> 
> TMD service: instance=0x01 (adsp) node=5 port=8
>    1 mitigation device(s):
>      [ 0] cpuv_restriction_cold    max_mitigation_level=1
> 
> TMD service: instance=0x43 (cdsp) node=10 port=9
>    3 mitigation device(s):
>      [ 0] cpuv_restriction_cold    max_mitigation_level=1
>      [ 1] cdsp_hw                  max_mitigation_level=1
>      [ 2] cdsp_sw                  max_mitigation_level=7
> 
> 
>>
>>> https://lore.kernel.org/linux-arm-msm/4gs664zboaqgpok33x7bgorfmhh3f2fahjkt4jjl6fbzpwixnm@hxzz2xeogd4k/
>>>
>>> Konrad
>>
> 

