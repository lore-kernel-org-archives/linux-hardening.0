Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738B2C3251
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073659; cv=none; b=H/GVNu6f2PdjeWoA0vg37y8ohX+IQSfzJNm5ypVyofHFm+q7jpkjg4o5rkus6gR/y/kgxC/BFEYvWPx2/xF6cT7lJqujrIWlxL1oVEMBXH39NYIavQE37sCNtkDsWe2BR4tZlVWtCUi8kh5kcOZKUlacU9VrqIW0csHh5qovb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073659; c=relaxed/simple;
	bh=OG4yzh9m5tXYU7JzloUdXPR26V6HBgZzOX6TH+TU2F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQFAJzUbXOtSz7ayRLvplc+DliWtEt+NcvvOfWawsVp0/crMHpZuEuiDF+Ao52i/4c6kBTuIG8TQl/UIGAmGKEsrKwN9la3EIt8AY+66x7YZX8yMeXi7vDbYxSrQgEBjnDO79GIoFcfP8oxchucfG3BjAQRv72+45YfzRRncuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/snRQ3s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1va09do; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/snRQ3s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1va09do"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rim23134744
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 10:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=; b=c/snRQ3sHra2mRRR
	bWBzcIEQ8j6mV72//Koy6uD2Ju1x5jrO1iAnaQrWhvcJ+3rbjIPMJJJnPJflFecM
	ZTEZpYiJsyX3VJoJZvVpWHdOhQT4bXAc7L34/hrL+mfME/fWMJZRrNvGVSnXcpPi
	leadoaz6z9KhD9wJLc5CDtXDj39GuFX74hTIEyH5jzmip9BWoZXAIZ4I8ZP+mh6D
	XK/vOpL15JCfXqpp47VwFsn5QlfUU5/ax5JFUTac7jm24pZp+cmTL3tiwnqnckct
	CysxPec5rjZWP+bVVV21kgUiljUX0W6mtLBAOAFB0xTEVg+OFRuz9E7LJPiqpJgi
	PlVT4A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qchhy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 10:14:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso394691a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783073656; x=1783678456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=;
        b=V1va09doKOyDgwZoqhIfZMYo9N1KOmnLazew4C0kEtD1IdqTISOwxYrPCIX5F3KiTv
         QH3dUhXdmvKu+FA3xPBokNxpKzMGJtyoQe1s6l5bA85uszfUnwPn3KsZk9cYS50U7/Fs
         KmicSVRbiLVzIIiOG5npJSr/By5D/napWyFzWLIoHAkb7BfPh9VUehG8q5hhUeEBUuBv
         6m1uq8l3iAIZ0WIVIZsx/GBfZE7d1H94v/E0EV0cIGXzauvX9cF+yIh6ABOVThPH6bQN
         /g44yRbS4BjYJGWK4DbBFyZnmEE6DO8MXSvWKMiAu5vQarUeWWj2gfEkU9diWVRPMmxy
         8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073656; x=1783678456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=;
        b=Ad8LbXGYbOdbK45J05wA7lJy/DBBYzsBk/JOaEUm+q1RWHeCsOpGHa78+dHX2ZGa05
         sHBXxYC4mtPf1RgxtBtQ6Kx+r5+ZNUjh09n9GM/eVLqOKcf7yjtDpdLuMAMatdCTDlJ+
         EacHTnwmGj8jDANSD6u22uhLzQH7M3iYJPjwICHSfmTZymIw78qEMRX/+DCHaJU1Tcnc
         6WLKiYZDZLGE1JdS6wSYNmsGkaiX7/2sje0R7EO0i6cPauL9cL6QuT315JOnkey3bcVo
         tAMQbE5Ai1/e4qiRAtMJ1+sua6lrBnUWn6iR2e5GI7kqHG8p9/rfwaABGZBcKVnC1RND
         jMjA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vs2/npRZ1VxVaYdtU4ieaf4RQwBo/AFujbxwPzstal+IirwWYYfd8RtA64FadrJiE85NZobfMycXzkuq3e00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLzhWpjIRMx52kjllEeyl8ufetHgDXQbq1rAjm6mk+I44D0a4
	IecPaswFB7D0tIfPupeP34N3EjxbQo8vL9qrKs9ZaP5tmqPdpLCbzZ0oOHkovEAza+R5tJmko7d
	+nE/J7l48CvPMrHn21/Xzknt3O7tzKssKUeSY5oQ7Bx7PyENk0Zgq030itgA+ZrxuV7VzAv4=
X-Gm-Gg: AfdE7ckSNQamPge2kQ/2LNIhrQDGGLSGv3Yeh5GG/4StJ1tYkEhQgK6OvDGIkmjhAeB
	z6AtJeBHp/dyCEOyJn+5yux2liFNW2JEvKCWue98pGzbQUI7f9vgKZ499TJ3yqendQ0nhCrC0OO
	sTSxjBMLZb3iL3Eg4tCDeSA/oGLcS4Nj38VOoYcdqB0LBaDbQ1enxdW4TMkv18EOQxw8zRuc3eX
	4P+Y90gJPbSN/IL3qXxriZxjAXgrl8AO07dRlsSGidrE9BxSuDYVGS1mHPFFzIXkJjI7reH8eJZ
	c+/8+7A7qd30ViX8jIKpKbmx4FulyeP7ohvSdXVHBdWQ96liu6SKCAeWa7Q2COqFXKrii8OGfdp
	jOGFhOvyKwSruLJyac9IL+/gLtPGzuuohNFds9Kd39Q==
X-Received: by 2002:a05:6a00:b53:b0:847:759e:f61c with SMTP id d2e1a72fcca58-847c519357emr9585753b3a.47.1783073656238;
        Fri, 03 Jul 2026 03:14:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:b53:b0:847:759e:f61c with SMTP id d2e1a72fcca58-847c519357emr9585712b3a.47.1783073655667;
        Fri, 03 Jul 2026 03:14:15 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6e42a3sm2824907b3a.12.2026.07.03.03.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:14:15 -0700 (PDT)
Message-ID: <54885628-ad41-49a8-8b39-33035753ac5b@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:44:08 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
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
 <20260703-humorous-blue-agama-4b668a@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-humorous-blue-agama-4b668a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9CyQZsAG-nFBYq3Nm7xLsMs3rmPEDp-y
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a478b79 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FDCMAMj9kxRoxUuqswEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 9CyQZsAG-nFBYq3Nm7xLsMs3rmPEDp-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX9wXvId/cFfdH
 xaTuNWqplXpvh/EkF3ub9MNtZIDjGq9Maps9Qv0en8jBnsnuiV4TimVncPtNOh8Npy9pF7x5MSM
 /olOvctEa/U3jQbcJLrKiUTM+UKQMpHOmbXL0ra/AUeDJJFA8u9jBWocC9J5CRrqYuE5+OYN8Uy
 PCZfV28xhhJt1ae6usmIoeYpTHvHFgT3zMORfjTJDFyhL2bSulaoS59v92JbLBJd2YiiDFtVvYp
 FD21TFqLgf+/kgW5KObcQ0hFnn6hOTpQeI1QYbGBnXlCzzm1LyRsW5Xv6WSxdnF+F9QCz2oQz+m
 n0rQpT4MKW3TzXlAYfFmgcAK0h8aNjUGOAE5HUiAt2BvCZupsGldTpqINz6WqfnT4v1khI3k5Ag
 CV6w//0S3BKZ3B1BsQkUq5CEfg3GUFG/wj+DqIcwZjHbUdU7cib8tkJD6pWSH76Skq04HK7wvLj
 51UxbM+Vts3cVYZypDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX5rDCoNjcr8n2
 uT8dukzokiiwxEws8YFOJnPEfxrTS8T8668WeugSdifrA/XGT1jYv1/SRCE+jAVVnbHq4xT1Ueo
 R42eIGirj176IiK9/7QlgbKBxZ1PlIQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030098



On 7/3/2026 1:17 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:04AM +0530, Gaurav Kohli wrote:
>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>
>> Qualcomm remote processors expose thermal mitigation endpoints
>> through QMI. These endpoints can be registered with the thermal
>> framework via the `#cooling-cells` property on the remoteproc node.
>>
>> The QMI TMD protocol identifies devices using string names (for example,
>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>> `#cooling-cells = <3>` requires numeric device id in the form:
>>
>>    <&phandle device_id min_state max_state>
>>
>> Define common TMD device index constants shared across currently
>> supported platforms. If a future target requires a different mapping,
>> additional target-specific constants can be introduced while preserving
>> existing DT ABI.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                                 |  1 +
>>   include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
> 
> As explained many times: Header file is not a separate commit. You need
> binding using this.

thanks for review, will club this with binding patch.

> 
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57656ec0e9d5..ffd85fd1dd80 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
>>   F:	drivers/soc/qcom/
>>   F:	drivers/watchdog/gunyah_wdt.c
>>   F:	include/dt-bindings/arm/qcom,ids.h
>> +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
>>   F:	include/dt-bindings/firmware/qcom,scm.h
>>   F:	include/dt-bindings/soc/qcom*
>>   F:	include/linux/firmware/qcom
>> diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>> new file mode 100644
>> index 000000000000..73efecef0f3c
>> --- /dev/null
>> +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
>> + *
>> + * These indices are used in device tree cooling-maps to reference
>> + * specific TMD devices provided by remote processors via QMI.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>> +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>> +
>> +/* CDSP thermal mitigation device id */
>> +#define QCOM_CDSP_TMD_CDSP_SW	0
> 
> QCOM_TMD_CDSP
> 
>> +
>> +/* Modem thermal mitigation device id */
>> +#define QCOM_MODEM_TMD_PA	0
> 
> QCOM_TMD_MODEM_PA
> 
>> +#define QCOM_MODEM_TMD_MODEM	1
> 
> QCOM_TMD_MODEM

Ack, will update like this QMI_TMD_<name>.

> 
> Best regards,
> Krzysztof
> 

