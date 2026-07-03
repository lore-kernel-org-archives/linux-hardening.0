Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7A3D9DBB
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088032; cv=none; b=rbMAAq0ye8zfMt9qkaH2cHje0zmx6aRjqP0VHstd/2L7LtViv16ioqg7c0m+Afn0nZM0qobhFizz2GEnSVG8jgkuJhvX+Da1cmFvQxNsoy9YgG8yvojsJx7CgLbKgUWSJtv5xk4AZd4kyfu1prLWBgKkrZQO3qWzcdDF0nYLf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088032; c=relaxed/simple;
	bh=jZH7Z/Hh9/KA7OFIOvJ+Blue//Yx5ANVh8OHRWIHUL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg9za2opizaLIJv43HvED9aBYY/IW37HO1doNNw92BIukAbRepF0auw5xKQ0S1B7eKMfi1/h/jZRXCIVaoobz5GcFWm3Rtz+2+5kYPO8ozbUg+dhwMxV5GdEgKHJ4W/dZOoHM3UqbqhMZUydrpFL0yhAu1kOUlB3y2X4JYf7Huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nih+aH55; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eb4evn1j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nih+aH55";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eb4evn1j"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BOTdm2995006
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 14:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GHZ92YcdPWa0r97qjH1sqNLcd4z27ftXzdTvY6KflVg=; b=nih+aH553/jrJcar
	AKW+idlmhmgME47w/cwuMueRhmbaO8B9JNsBqMR4C/Z8MxXFGlAdQsUERPv7kFzq
	apt/yG0BKz1j6weTVQh/2edOBnAeV9blSk16Owz7culb6ZvvpjbLjQ8sS/rZ1pYD
	UueElgcDlxqSbqaAz3FpuAEjQfcDbwcrTc3zLDSiGnsNsF0jAdMBMGPv/OO/xUwf
	O+ztrxHvkolXC/oAg20uqZRJ0anFMH22m7p0uksWPiLpw4Qt5oio88vDEb9EwkLs
	1hEd9Mw9+sPBNqAT0oUw1xI0DtS1Dy3b9gVV33BX2ZwTL/ZRiEA4KwQiZb7uMq5B
	KTkvZg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n2qrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 14:13:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca3b314193so10830125ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783088028; x=1783692828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHZ92YcdPWa0r97qjH1sqNLcd4z27ftXzdTvY6KflVg=;
        b=Eb4evn1jP6AXqJy6AodiSm9En5UNNizCsst9IYF4h7ZI0sJR5mvpcUEoEjiJkvT5y+
         ur7XIH0PJhqnhLEb+22apuFgJsnPukD9QwJWa4zHX9sOfyCUIdxP8D9q9gv3sQPDgjo/
         i4/OrBbZp4Ekz/dNyFZfCE3blZXGtV15HhKXFjLjmQZOKhT7Sag4YuTOAqxbhA6bQe3z
         Os4eRd8nscR3lQuX8KKCOQPz9P6pfJHBrRtnYp+tNNpNjqTcafSO/L+2lwJVRkcp5PyA
         n+zGoyrPBaea2Eu+ueULU4Za4f5cGP8ntNIIFqYRlvWH9Jnpx+G9vxrvjNASQWUGK1yq
         upow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783088028; x=1783692828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHZ92YcdPWa0r97qjH1sqNLcd4z27ftXzdTvY6KflVg=;
        b=X3e4TG3Qgx7yzQZO34IGMnVddvrzfvGrM0q9hCTQA3n10Tp4AiJ8vyGCbJ1OxccK8p
         ra8dl+WEVH82Uwu0pd7t7jVXMn/Xh8sM6GhcKBajt/vpsJBS+FRMwyuHMIVmTYxQ0+kI
         IeK4eIu7ealoCNIff+3ovnOWZHXGXlIq1P4O1WRkK9r7pv+DKX3hVxzv7ckYsMYoejkc
         kVTkzX++qD/P3m0o/V+ml3yKx3vBBJCedkYyqRqEIKIukvmubo6uqgfeZ9t5BlGeyfWk
         wG0r/yBeiAHlUtPe9cfnPg2VbIZ8kF7OfouXeCFxibxt4H4zZ9KqGSclSwAzAi4AvKxS
         2T4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqxnX2jHw23/KMP3yHn3mLC1zLioHr1q93DOsMPojsN+299pGPNcFq91Eo2E8Tet+i9XCrZxIuIQbFdBD6uJTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalGiCDh7Iz52aLZKZAv40Awp+Mto+OYV73rG4X5n49zUss8sl
	k8ybB6ZGO1dtmT1scyQsXK9+mZFvQQEFYrvKkOLnQZejC0lA7bBS6JBVtEXn6Ua3Qps5KWn1sDP
	JTeKooVZDBNNkApU4xi7eNVhaammwYfO1BpeCbmbWmdLlFuKqGRp/Gm0U1He90SOk47Dt6UY=
X-Gm-Gg: AfdE7cnC3lfIj5MSUCzVFAx4SECBykDV/6gVGb7X9FVooBgu0TE+LgB5LY58IkSIwwf
	CZrMYfDO/+9pHucUH+/TCMHzejkbRK/BG5HdQxoSK6h8lYvOJ4acTHjE13S6yTivNAQW1rom8cz
	sMHwzh5D5WLCww7h6b8ELyNxpJgBmEYtvott0bt4tJ3ArHL0i/+deQtC7zuEyCZUpC//WOfpsSF
	DGP4W4d3PZ2ZaDeBw/4rFMB4W/xH8z9OtAkPSIkDbnP7JRbir1gAh4MKSJfKMgb8Ajtm8pqTTXv
	pph01sj2p/HsD0Qw6+3RcmVUuaWoPJGXmd4tTcxxDwf7h5KzDQD/FNnnUNd4n55y2le7ugGPEwW
	Exch3X86xUmq0R5BNlpMXkcOtcgWJ85sk/n0OYIakNQ==
X-Received: by 2002:a17:903:22c5:b0:2ca:ecf6:9122 with SMTP id d9443c01a7336-2caecf698d5mr12018585ad.17.1783088028447;
        Fri, 03 Jul 2026 07:13:48 -0700 (PDT)
X-Received: by 2002:a17:903:22c5:b0:2ca:ecf6:9122 with SMTP id d9443c01a7336-2caecf698d5mr12018115ad.17.1783088027979;
        Fri, 03 Jul 2026 07:13:47 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm32244894c88.10.2026.07.03.07.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 07:13:47 -0700 (PDT)
Message-ID: <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 19:43:39 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0MCBTYWx0ZWRfX8HC64HPvwxXs
 fL7th53NZMdu1eHkbsOjcAs20OUflO4KS/ubMjNlqpN2BScVMkAAIK8iB8wqHAUIn/N5KqiWtGk
 qGi9aIZUtjuH5fGWopI+0A8OqKK1FOs=
X-Proofpoint-ORIG-GUID: uGegOUfHfWjIsILro77cjQH1CtBfFihk
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47c39d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KAs4MCmhXsdL-kvopiEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: uGegOUfHfWjIsILro77cjQH1CtBfFihk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0MCBTYWx0ZWRfXwbQPlf7CWkgd
 pC9JOVJriWo7BtIVBgm2yRabJ/BmGAvurjtR7+GWCPw5fF8EzjSFq1s6iLorLnHIlR+3VWJgcLx
 cITQwi2wjpJZDLraX4XazZyk7a0WombVotHITYh/2+hPi2II5BSqg4lAjsx0N9AYScDAdxHeiic
 arAkG+NQIHhgwQc1CDXYNMz4GQE3YxgLcGpylLuR2pvHb6tdKTOj5qvAZINLNh+XAkmS12tpu3d
 pSvz0n0HWNeZLfSYJkXSJK6toNoB4qLdBQEvXhQdcltclxoXAgHNR17Wa4ipy616fPLqvtZ1Uq1
 Pt3VYSQUCdr4PzRx57Qo91HuxfGSAAg3gdITC/oSkDGLhXOSKYzRaSIPVIG8H+8/95N06QHCqYW
 RFk0HQRk7+vGDRmSDSegh3R5DKM+TvF59o4NpogdEH6F+uZ0IlG+FoRxUQlnWibq7KqIz9+wkEB
 /gOKKLNTY+WW9fhlcsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030140



On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
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
>> +
>> +/* Modem thermal mitigation device id */
>> +#define QCOM_MODEM_TMD_PA	0
>> +#define QCOM_MODEM_TMD_MODEM	1
> 
> What about the dozens other ones that Dmitry's laptop reports?Ri
> 

Thanks for the review, Konrad.

We are only defining constants for the TMD devices that are actually 
used for thermal mitigation on the platforms supported by this series.
More constants can be added as needed.

> https://lore.kernel.org/linux-arm-msm/4gs664zboaqgpok33x7bgorfmhh3f2fahjkt4jjl6fbzpwixnm@hxzz2xeogd4k/
> 
> Konrad

