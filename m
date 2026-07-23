Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5548BD33
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jul 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817325; cv=none; b=NKhsrJIsd/75resUDav/cs5eV5vu8U3d+MTdDy+384iCNw2DYMDOMEBhhT77Pv9PXLSaU6RLKeT3YyvQ6gaVsjCAQsX6E6v6GzkpfyZ+5Y8Y0tj0T/ii/VyPV5g02OqkaPoOXCf0JDxRvpwNUgRnekfx6rtqsP8j7beD2EK83oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817325; c=relaxed/simple;
	bh=p9Vp280xaE22Q1gXqDAsqCZd0ENl4y1Gz/XX/HR4hVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu9HoLNcWJC0doMZ28dJladfYTb+/PDBkBjy9ej0OlGs4yZdPXceWGrUBOVnD3Op/+GgzEpleHyzWhUMlgzANlckjTP1Yebqax2sIUYWeyaU2V8x6Tkp4a2RYL/eNXRb4rQ2jd5K1Kv5oWp/9t/D+/zd+IQSByG113N1wSHFdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=czh/A/FW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ESDAhq8/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="czh/A/FW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ESDAhq8/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NCvdOe038252
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jul 2026 14:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4KGSGRzuLSfmOFG5NGnFr5iZ7/7ggQeEqhX+DpWMNPw=; b=czh/A/FWeQNPXXPY
	Nz/ZyHDge3qpkiItowNMpGMyJQb3YvqBET05e1LkEKixbqzryCmKTKTYiT+yDEuX
	0rgP46hNDy0XCKAu9XJa1DfPqSxUJJYZMHhyB8yy9BJwELwUHWQDB8hlYEPc141/
	Q8O4dnQiNRobDaABZ3J4k3/w34xuwsj2aE8GGxjVQ1PfH7w13+5ELJYDMF9TPtYj
	ti9ncghejm5uxIAhx8wN5CFN2eUsKhQ8GK7PRnBDcfDs5bOt5Z+Xnhr1HFS3gw//
	L267UVf+v0m+ZhZO4E/m9ID8KrrC2NemmzjE3vP2I7byyso414LXk3Ad0/Rfdcwq
	NzLThA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc3rxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jul 2026 14:35:17 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a13b72112dso811082eaf.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jul 2026 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784817317; x=1785422117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KGSGRzuLSfmOFG5NGnFr5iZ7/7ggQeEqhX+DpWMNPw=;
        b=ESDAhq8/fAW7Q+OXAiq3r0wDIvEAYcnk92aSKLVvnDwyGU/okaAtL/dEYTkdqULl2a
         5/beGDgLjLfd4KSBqEXSmytO+W1joCJa2q9kSwnw48gMj9oWLEHpYTr21XHKpa/q/UyD
         FK/UfEgD7pXRO/CMtxEDhPcw8QPde5FhLhJ9rbhuipFqSK1v7W+aT37DgKl2M6opeDEL
         3d7t9cRkk354FzsLycNB0RxmKjfNcWrdjUPh9ElF6RNo6YfCNbwx29s37XJq/Iqx3Kd8
         21tIySRCFEBlH0NhX4s4p123Boz4i5T7q2t0warOhCQaiqErIHfuKCCT7mi/gaRGtwt8
         jdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817317; x=1785422117;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KGSGRzuLSfmOFG5NGnFr5iZ7/7ggQeEqhX+DpWMNPw=;
        b=WZn4miKcaruVY4857AGgcVhxbB4ETIdgJXnxq1ysJu4zkE2p67c0jLhGFVgN3p9Tti
         NU3MSN57UrdJw3yyLwxUFRrcLvb7FgaMqrtJkEUY3yqnQmLw5AOTgC7a2r+M9ncHkTZS
         rORdCtGK4A9/W032vq8ycGRh2RuGz+ZEp6N4vWTqVu/OczrM9IlWpw07RMWb8epIxu03
         o91OUj0dwh+ZSZfmLre2F8OmwhnoKLSWSTAgUTWYBwo5a/92pppDadxQ+CTVctcWs62L
         CvbgMQVNC4JU7AyJqEzXk6VBCmf5vCVfPoi+7yptoOUuYHreScWPD/YDEHtJbaCdBUn4
         oX2g==
X-Forwarded-Encrypted: i=1; AHgh+Ro7GYBjhLhb+WLPd2CVU7qkhTF4httfrIFftH3j8eaWf0zvbaoNQHSTrG2vm2grpBXZITXqjdaDBA4aOro7AII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5LILn2YJK9i1KPi53D0D8PMnSGLYei/cH+OQC6cjovSvE7UO
	wCawX6AhlflWn+RTzBIS7HkID3SwxHSPtYYzYHMWqxmsk2sMsDCz56HgafGiF2Q0U/T4npxPY1o
	RKjsg5QS4LOFmxkNl24CEKdrf3Ywm4uGo4EiFh5TXCBpd850vRG0aVcfmr88lrcSK69VK/0k=
X-Gm-Gg: AR+sD108atEfwifPpygvBwiSu6YTZOZC+uzNnBWM949O8vBWNakPnyVi+XEanr0MIzt
	Nq8ya11REgxN7t9XOiKvJhzdfz3Mz79/RgQP+U3M8kkOe4QU02rE+0fLrTUHb1luudDUucLx1PA
	heE+jA+9HKi+sX+LxUp9GgbD0icKh5BkvhZds1SgJzdq/wrA6i29X6/gjnedmclZH5/WPH/HBpE
	oUfL4pzDN5skBLFbyLec49d1WDnOAAp4cEFGSbHsT7sp1t2oaSdfOjpUVoBiE2WRv989ANaqLBy
	Gegwl6aJULKD/8C5Xuowi2ksImd0L4zxe51APMfFA9iXptha2Xd9OAyC5SJrkOMQL1/NJuf9O98
	Vx+eXK//3gyS7nPAgQzujIysolpdIX/jX
X-Received: by 2002:a4a:e911:0:b0:68d:2f4:82be with SMTP id 006d021491bc7-6aad3fe2b14mr1423037eaf.22.1784817316896;
        Thu, 23 Jul 2026 07:35:16 -0700 (PDT)
X-Received: by 2002:a4a:e911:0:b0:68d:2f4:82be with SMTP id 006d021491bc7-6aad3fe2b14mr1423015eaf.22.1784817316466;
        Thu, 23 Jul 2026 07:35:16 -0700 (PDT)
Received: from [192.168.1.11] ([106.222.235.129])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa73256e7dsm3555333eaf.0.2026.07.23.07.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:35:16 -0700 (PDT)
Message-ID: <3e52b76b-9ecb-4c6f-b6c2-a9a2245dc376@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 20:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] remoteproc: qcom: pas: add support for TMD thermal
 cooling devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-3-99620e07f505@oss.qualcomm.com>
 <vxmb3padun4hydx3g7r7gecpeawoslc7djpaaxjl3o5bq5n5ip@nf5djjaelfy3>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <vxmb3padun4hydx3g7r7gecpeawoslc7djpaaxjl3o5bq5n5ip@nf5djjaelfy3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SJSUerlmfPWT2ORRWlrRZecaMfn5Ff6m
X-Proofpoint-GUID: SJSUerlmfPWT2ORRWlrRZecaMfn5Ff6m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0MyBTYWx0ZWRfX/TZtu/jCV0hm
 qCw86aG2ezqpxsJ75cXJVpCVPQGKZ6gowPgR+8/e7PntKxVKQsXemuj11/qARz0VSFY3+QLQzJN
 3WkMnZt5SlftWjmW4fN4S/qICQv6y6E=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a6226a5 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=/HV6WY1oXUpe+KOgORLkYw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dNpu8_jO4Ua9YSCl4dAA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0MyBTYWx0ZWRfX81uys0zQgn5b
 qCyvLvP5WCFKQ5t4eB92qXC+sAALrM4hjF0vV6e6FXHPuDgkpmwzmKEBcrWxUkcMUnBzGswzm8O
 UQFJ0YUusZcBggnEW6wo2m1XfflC9B5QXPUAWOdKTDwCjvQCbHdqAllmZ4PxOtq6XvPb9q7DXaF
 pnYR74rOlDRypUU28mO43WCZYZ+Pe8s9ljA6C3OxSWEk/k/Cuq/P0fOmA8DcqBf7hNTioUCARtI
 GLskckzOrIB8mpStFSfZDmpfK3RtgGbuLTZS/uPVVj5wyNFboTp5J3ManO0tVDQdiS6HmLd24Zl
 bDu9IW0d9vyPBlI4f9Wa2W8ncYegn/6QGUkkEbbvUjOmqsk5HctOUSB5U/5+W8kC6VNOpymY63a
 eH0TJ0sUxDBKVChbrPzGQUp4zb4JclKcUeSBRkOmZmlbEb8JYBm0HboPVNSjBtQ1DNUhGeqF04Y
 DuKTWy4+IrvYRNX7W9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230143



On 7/22/2026 4:37 AM, Dmitry Baryshkov wrote:
> On Tue, Jul 21, 2026 at 11:59:00AM +0530, Gaurav Kohli wrote:
>> Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
>> processors to enable thermal throttling through QMI.
>>
>> This allows the thermal framework to request mitigation when remote
>> subsystems such as modem and CDSP contribute to thermal pressure.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   drivers/remoteproc/Kconfig         |  1 +
>>   drivers/remoteproc/qcom_q6v5_pas.c | 90 +++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 65befdbfa5f7..f7c02edf395f 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -229,6 +229,7 @@ config QCOM_Q6V5_PAS
>>   	select QCOM_PIL_INFO
>>   	select QCOM_MDT_LOADER
>>   	select QCOM_Q6V5_COMMON
>> +	select QCOM_QMI_TMD
> 
> Sashiko warned here about the missing NET dependencies.

thanks for review, will fix this.
> 
>>   	select QCOM_RPROC_COMMON
>>   	select QCOM_SCM
>>   	select QCOM_PAS
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 25599d728208..dc5be2c030cf 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2016 Linaro Ltd
>>    * Copyright (C) 2014 Sony Mobile Communications AB
>>    * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>>   #include <linux/clk.h>
>> @@ -26,8 +27,10 @@
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/remoteproc.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/qmi_tmd.h>
>>   #include <linux/soc/qcom/smem.h>
>>   #include <linux/soc/qcom/smem_state.h>
>> +#include <dt-bindings/thermal/qcom,qmi-tmd.h>
>>   
>>   #include "qcom_common.h"
>>   #include "qcom_pil_info.h"
>> @@ -38,6 +41,16 @@
>>   
>>   #define MAX_ASSIGN_COUNT 3
>>   
>> +/**
>> + * struct tmd_name - TMD device name to cooling-device index mapping
>> + * @name: TMD device name
>> + * @id: Cooling-device index used as #cooling-cells cell 0 in DT
>> + */
>> +struct tmd_name {
>> +	const char *name;
>> +	int id;
>> +};
>> +
>>   struct qcom_pas_data {
>>   	int crash_reason_smem;
>>   	const char *firmware_name;
>> @@ -58,6 +71,10 @@ struct qcom_pas_data {
>>   	int ssctl_id;
>>   	unsigned int smem_host_id;
>>   
>> +	unsigned int tmd_instance_id;
>> +	const struct tmd_name *tmd_name;
>> +	int num_tmd;
>> +
>>   	int region_assign_idx;
>>   	int region_assign_count;
>>   	bool region_assign_shared;
>> @@ -122,6 +139,8 @@ struct qcom_pas {
>>   
>>   	struct qcom_pas_context *pas_ctx;
>>   	struct qcom_pas_context *dtb_pas_ctx;
>> +
>> +	struct qmi_tmd_client *tmd_inst;
>>   };
>>   
>>   static void qcom_pas_segment_dump(struct rproc *rproc,
>> @@ -798,6 +817,64 @@ static void qcom_pas_unassign_memory_region(struct qcom_pas *pas)
>>   	}
>>   }
>>   
>> +static int qcom_pas_setup_tmd(struct qcom_pas *pas, const struct qcom_pas_data *desc)
>> +{
>> +	struct qmi_tmd_client *tmd_inst;
>> +	const struct tmd_name *tmd;
>> +	const char **tmd_names;
>> +	int i, ret;
>> +
>> +	if (!device_property_present(pas->dev, "#cooling-cells"))
>> +		return 0;
>> +
>> +	if (!desc->tmd_name || desc->num_tmd == 0)
>> +		return 0;
>> +
>> +	tmd_names = devm_kcalloc(pas->dev, desc->num_tmd,
>> +				 sizeof(*tmd_names), GFP_KERNEL);
>> +	if (!tmd_names)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < desc->num_tmd; i++) {
>> +		tmd = &desc->tmd_name[i];
>> +
>> +		if (tmd->id < 0 || tmd->id >= desc->num_tmd) {
> 
> The < 0 check is totally redundant.

Ack, this is redundant only.
> 
> For the second check, currently the driver will set num_tmd to
> ARRAY_SIZE(desc->tmds), which makes second part either redundant or
> invalid. I assume that here you want to compare to some maximum TMD
> number to be supported rather than a fixed ARRAY_SIZE().

This is just a defensive check to prevent mistakes in the static mapping
table. The current mappings use dense IDs starting from 0, so
desc->num_tmd matches the valid ID range today.

> 
>> +			dev_err(pas->dev, "Invalid TMD id %d for '%s'\n",
>> +				tmd->id, tmd->name);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (tmd_names[tmd->id]) {
>> +			dev_err(pas->dev, "Duplicate TMD id %d for '%s'\n",
>> +				tmd->id, tmd->name);
>> +			return -EINVAL;
>> +		}
>> +
>> +		tmd_names[tmd->id] = tmd->name;
>> +	}
>> +
>> +	for (i = 0; i < desc->num_tmd; i++) {
>> +		if (!tmd_names[i]) {
>> +			dev_err(pas->dev, "Missing TMD mapping for id %d\n", i);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names,
>> +				desc->num_tmd);
> 
> And this makes it even more strange. Can there be holes in the
> tmd_names? Can platform omit some of the TMDs? Assumingly yes, this
> is not correct (nor is devm_kcalloc).

thanks for review.
For example, if the static table contains:

   tmd1 -> id 0
   tmd2 -> id 1
   tmd3 -> id 2

but firmware reports only tmd1 and tmd3, then cooling devices are
registered only for IDs 0 and 2. No cooling device is registered for
tmd2, so the corresponding DT cooling-device binding will not happen.

The devm_kcalloc() is still needed because qmi_tmd_init() expects an
indexed name array matching the DT cooling-device IDs. The current 
static mapping assumes those IDs are dense, so there are no holes in the 
mapping array itself.

> 
>> +	if (IS_ERR(tmd_inst)) {
>> +		ret = PTR_ERR(tmd_inst);
>> +		if (ret == -ENODEV)
>> +			return 0;
>> +
>> +		return ret;
>> +	}
>> +
>> +	pas->tmd_inst = tmd_inst;
>> +
>> +	return 0;
>> +}
>> +
>>   static int qcom_pas_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_pas_data *desc;
>> @@ -925,16 +1002,24 @@ static int qcom_pas_probe(struct platform_device *pdev)
>>   	if (desc->early_boot)
>>   		pas->rproc->state = RPROC_DETACHED;
>>   
>> -	ret = rproc_add(rproc);
>> +	ret = qcom_pas_setup_tmd(pas, desc);
>>   	if (ret)
>>   		goto remove_ssr_sysmon;
>>   
>> +	ret = rproc_add(rproc);
>> +	if (ret)
>> +		goto remove_setup_tmd;
>> +
>>   	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
>>   	pas->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
>>   	of_node_put(node);
>>   
>>   	return 0;
>>   
>> +remove_setup_tmd:
>> +	if (pas->tmd_inst)
>> +		qmi_tmd_exit(pas->tmd_inst);
>> +
>>   remove_ssr_sysmon:
>>   	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
>>   	qcom_remove_sysmon_subdev(pas->sysmon);
>> @@ -960,6 +1045,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
>>   	if (pas->bam_dmux)
>>   		of_platform_device_destroy(&pas->bam_dmux->dev, NULL);
>>   
>> +	if (pas->tmd_inst)
>> +		qmi_tmd_exit(pas->tmd_inst);
>> +
>>   	rproc_del(pas->rproc);
>>   
>>   	qcom_q6v5_deinit(&pas->q6v5);
>>
>> -- 
>> 2.34.1
>>
> 

