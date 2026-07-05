Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB036492C
	for <linux-hardening@vger.kernel.org>; Sun,  5 Jul 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245020; cv=none; b=oYAWKF57ysGpr/iUb+rRvnV5UkoL3EG0HirTWLKOkw5w5NhjIZmumkxcbnVSfSzft/caBqcuTHAnCYY4TerhCSnQgSjzkVvxeie9IIG++sDINJ3mSAD9Qne0L3DaEcD5rpcW2rBNmBeZ4JaJ8qMG6b09cTek7L6D0kgbvwK4Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245020; c=relaxed/simple;
	bh=lN6FGnIyO9hbyJ7xO4gq9+8O9xbjfOEMppV/97DZ0RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d60SvRKFN2YQPDIoLd2umUbzlD69p2qg4lAKqCgTF1xYH00KsJOuGRmZG5GcYqqZPkC3c215JTONLllNk2PdJEeALhwsvWadvovoiJbl/YJLoqLYyrGRFztfIy9kG0KwoBKk3vTXgdobjHzdYysJXH0KgqOLQjnwVVtBv71vqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imbAsPdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5BRU/Za; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imbAsPdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5BRU/Za"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664LTRVv4090299
	for <linux-hardening@vger.kernel.org>; Sun, 5 Jul 2026 09:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=; b=imbAsPdI/78wXBPN
	D0jns2ekSIYAng0zSD8Qr0QGrA4nE6kfm84r2+FVj4Sz5fnKda6YbCZV61/yYjte
	bX88MARylaYfdjIldXpQqTc4d8bQMTM3P5KAvCWdS7izXTeB3Ci0j6UzGbPIT4UQ
	sGwrlLrEd2AZf6ZpzLsZpAMUXqzvjJZkXpLUOW84IdlyOnNJZnLwRN16J54QcPtR
	Ls5YoTtZxFs6AeHN9ZNF+ocuZKTTP3URp0eJuOXm+AVn2tN3DdEbT2CWypvnSUZv
	QO4uI7Ag56uHZrbzF4JdYbVY1UbYF83iHHPOD89XMNf6MgfHaIJd/pnzcieEIntE
	HUyRFw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64jk64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 09:50:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-384636ba25dso1118532a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783245017; x=1783849817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=;
        b=P5BRU/Za8vZTDqTHaPZwCQ7WDHvnn8UHQulI217PrNmw9wCon4pbXPOIHbEsoyn5PS
         gHStj3I4ahEgL9X0cVeEnOfbIOX/QLxT3dFtW8azG3hBCAKYMapkKk69Zv0YeRNrOYW5
         JdeVVfbQujU3Oc1uYGQ+ef02CyjIDHtlO5Tm0YaUUKn87bLfCzCimauKFxFIOFCpC56E
         Ln1Vj4KVyp7yecYJyFozpHtaDPIk4vrsrR3GgMzoS2iLAbvGE8TqvPtCeg4+6SEsoeE3
         5dyMi0XfOFKit0JHcYPSJJKpY/dPafXi5mc7qDzFfYp8jKvsJLXtwiQAPnxRgPhnNM4d
         ti1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783245017; x=1783849817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=;
        b=Phsr0s/7w0VMgTNuSLyvRu2cIpjkUzCuu4/9Rn0EAlpGaa413/ZEJKVgTXTN4TBuUP
         /9UzILKorAiXvPYWSJD8QpmBERYmBOVAzQh6vWWk4UW+h+V2Jkv2zC9RMpWpl9mYoRwI
         5ZjbZIStCJc8RmWhyILmgsYLUbVaUWHNLB/2S70xWRJTbHdD9uEV0XHSMNDhq+j2xx3B
         9Ihs9HXgTBAAOKg5NU2EDa4Abtq/4QPtRzt/ycZ/gOpugCy5AyKQxNmLmdk3T6fZHezj
         ZvoO4LZBwqq/+KKaJEQA2y/8uyaVo3cwBkRnWIrTqbPsEf4p2JJIDKzK/hpdUMjqvmkR
         vnmA==
X-Forwarded-Encrypted: i=1; AHgh+RrV6fyRI6/Hbg+dR/AmwfDuDRMhVNXwb+ZCm4hRew3MFZ7TGl72cpEe1zQYna2lFEoBvmJjl9ldYzAIsxiRS/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbzGy7JGcLwGFQ/RWEgoT7x7368y002quKnP8Fl8iNbEDM5WZ
	e5iovlyP2D5oIO3+xhVHxQAzhJbOsqircPDLFMEwcb91CuOC9U4PK2eEhYfpPadxh6GvmC8Rgv5
	snRFfSFxdQcX1S1kX7wQkTt9QJ19+IlnYcXL9Rlgc5bWpggMRyPf452ugiCzw71PT+ZVPpDQ=
X-Gm-Gg: AfdE7cksgClPyFBwXwaT25Wp3HwA0WeBEaWXs47K8l8ir3fNh6ISFNky6BkUn5oh0FY
	jNPCxZuPgxyYLPCmK4hWRVcF13+xtwr6Q44rEjRfltyMCw9rZiDqeh58g7DSnLIraNYHVJHJ1f8
	hA5DaRzIgXFmjbXoXixd8wc6qT3ncBaE3mRD1m/b3kfbXkFw7YLX4/MvA4uSc6mJq8gzKSNX6MN
	GsIZ5sgHtzq92ohxbxG8noAe/LHGGpdHYWPRc97oQ6AsaaCItKW2Z3B41jaShZ9dnAI6yxB57b6
	qGZ75yU5MPb8+d8dz+k/DkodWj4EPJU87dux1l0lciGaNdlwn1WYNTCLyLWEyzd2BcUo6+u8ZVK
	70tNFehmpvis1+SjEaUP37C1JfPRIMaC+zJSpNtOELw==
X-Received: by 2002:a17:90a:e7c4:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-3829eff9c3bmr5733640a91.19.1783245016895;
        Sun, 05 Jul 2026 02:50:16 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c4:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-3829eff9c3bmr5733595a91.19.1783245016127;
        Sun, 05 Jul 2026 02:50:16 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b4c5577sm45758032eec.0.2026.07.05.02.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 02:50:15 -0700 (PDT)
Message-ID: <afe16407-c0ea-4498-ac24-9fefe94b0474@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:20:08 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] soc: qcom: Add QMI TMD support for remote
 thermal mitigation
To: Julian Braha <julianbraha@gmail.com>,
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
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
 <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfXwLcnuthye+0Q
 txABxZY5GQviTHgazryvFKUwjIyc8GlmeRuCr+mw4CslLOCS+E65lt2LfTVcQBDTpS9WIrQEoG9
 iuZRw5+mKIbf/i53coJ29ltFEy8PqiObEqR1he/1RV0wey/8mmOgT3OBddp17O4L5jzY7a7hiKj
 OR3TwViYz59Tsbgqi0YLyvomw+P+uY6zzEvONPgJwgrSMra/maRzWsn2MWbxnrQCFlk2Y5d8BQI
 JyIl2OKKTz1SzbbLJnuogNCrtntWl/0+qXCVl3cKI69hGQ4/Tvs5qyFHOWrIc9p52GMFyZvSnoM
 Vyw3aDXteKCcFWdl6FozLdasgkLtfjhjvEe2YZzNi/fRNIuFcusr36FXvike6jeFZ9y+XAo2tmR
 pNdlZiY2YXEgW4pUjwXqU2CfJ/zjLXj5ndZHjv7B6JFnWElKuzmY6RmAkfqjdtMm6y6Sj0OTlSm
 uJQOd/Cf0PJIMSAjIpQ==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4a28d9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VSZR59-1Ue7iRqHKT1IA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: zlv3YSH2RqlnELKLgU0NeINoLJpDsrvq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfX9qsRb18D2F02
 wKlasZB8tmtoi0TaSHSAJGIUMbRgBYSsxc9j6Qtnvz4q8web8vEl7JbiS86m7AUK5b2lriO3jjl
 KG7dvN07h9B1ryEJfRrKKMeS/o8aqfE=
X-Proofpoint-GUID: zlv3YSH2RqlnELKLgU0NeINoLJpDsrvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050101



On 7/3/2026 11:39 PM, Julian Braha wrote:
> Hi all,
> 
> On 7/3/26 06:03, Gaurav Kohli wrote:
>> +config QCOM_QMI_TMD
>> +	bool "Qualcomm remote subsystem TMD" if COMPILE_TEST
>> +	depends on ARCH_QCOM
>> +	select QCOM_QMI_HELPERS
>> +	help
>> +	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
>> +	  Device (TMD) support for Qualcomm remote subsystems. It manages
>> +	  TMD messaging and handles QMI communication with remote processors
>> +	  to exchange mitigation state and apply thermal mitigation requests.
>> +
> 
> QCOM_QMI_TMD can trigger an unmet dependency and build failure due to
> selecting QCOM_QMI_HELPERS, without ensuring NET is enabled:
> 
> WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
>    Depends on [n]: NET [=n]
>    Selected by [y]:
>    - QCOM_QMI_TMD [=y] && ARCH_QCOM [=y]

Thanks for review. Will add depends on NET to fix the unmet dependency.

> 
> - Julian Braha

