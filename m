Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA240FD86
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431428; cv=none; b=KAfiZk2TJxUzvX039pM/KbLKx+1KFagSTH02+sOXvBh0VdHn/AJKN5gY/gohNVQjsdAqwstGpl3Y4kxhf+yEpNip49n5/iHmXz2K0L53yxLqsSUjVR5aSQicq0dA5v7R/boudKAWqZW4XxcCagfiisB3+ZukNDF5PnsCEQxQZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431428; c=relaxed/simple;
	bh=fqTSDQN7nJlREtRO3Fm1yNRF9pzv58xXEuu6JG9X3TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBS2nmhyAAnhTHGv2bVrvQ+Q2SGO6+btFIzYczz4RqFlevecJa0VyvJ23Iac/CqPSHuPnBtDRm2wPKHNHemN1UPV4W2/05LMupeLqrUKl/+fzi/ptKPKRoikKOS37BiiDs1QIwmta8A2QwIn8/gt8T1qvwmZ6vHhPJEiCZV02b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UBBy/EH4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7HMRfQt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBBy/EH4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7HMRfQt"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWVxf1238382
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 17:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ho3uBP1okvITlExnW9igFrl0dofyDrS+e5s1TgETMgA=; b=UBBy/EH4eTWBX0Tn
	AVOdHWoyU8LrVZtHlD3F36nCQV22VwWBBeyg7nrZ1hh2vaKsMF7Ktm68fuv27sBK
	rqVZbzO3Rrs0HZQLRpOKzIdFoXwY36qlcAvwWb+8KyEQWkQVrHXAhaLhtLu1iRmq
	rsatS7DOR4+fhvOOSgehwwSl5MKVoMUQtmNQ8G1vKOADqpsH8fqms+MZQtp5UE8s
	hmKXQWr8vWwikGX8gGkk8GzhAgnymfvCqAfLAEzUb9lxd/zG4hDbAUwIlesf+HH0
	Afi2xQCMeOZgRa4518qxTr9oreC87FbPGdgRnwOqoxPbUySts7nWUgNGcqXCPqrr
	9zqGIQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38sbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 17:10:26 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81f0e988059so2090047b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785431426; x=1786036226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ho3uBP1okvITlExnW9igFrl0dofyDrS+e5s1TgETMgA=;
        b=j7HMRfQtV8IdaZwv6a0t0XSmldKWYBN3TM81xzD3EYVx+jp/o3veo/FQnoIxvUy3+n
         kdQVWzdZSw5WJMy6K2cftqilBcRhnv9JzzTYPtxidB9hxuJXwakE5y85MLAS16L1o6v+
         p6srn37T/zWeudhmPdDtWK176RTm/BdQk7be9Mup+K8ISdUK/WJkFBiO4Qmkx1CicY2P
         Jnwh1Zf3BtjRMPZSxqqaC9c6l0klZ+FpjEUWtYRXI543VncaSCTqneqSFNtddZXUM7m+
         al7N6pIlp0PzqX8DQutUY5Os2DqY1jj8cbSHb+0LDHBPjsqKnqe2Qn4W5Fgt0X7SytwV
         x2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785431426; x=1786036226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ho3uBP1okvITlExnW9igFrl0dofyDrS+e5s1TgETMgA=;
        b=GdVLUsYukySxr8hJKC76ABfx9nLvp8cSZE2CfUqnXTDaN/to7aQnpyoqpKLYtyFpQ1
         lUWtkvp6Q6muGVulMcuJzpkN5PHycKdBoD90I8k/OPZVTJY/8UVJr+Cca98kMtfp7gtH
         InicqlAjfUc8DSbeS5J3noCppdq1p+PI9BZyCv07tgLhIr93RNa4BraMrzFjpz94tkdZ
         KFXuCQO9Cup6NrsHKz+2FTQ5DYX+vCbQbEj7rI1BnEv5+0FqnRiEOlolqQS7LdndreQo
         Cm4gLWcrIdIJssTrQFmQaVL5+dxCapYExnPQq/Y3Z9OKt4D5yXU9SBbEtLPfQ234CAT7
         aeNw==
X-Forwarded-Encrypted: i=1; AHgh+RrszTHTWw/mx+RTFSKJ2wtn3Sz7W2jEhsEjejQIxPCUKLqD9ER7C0p7y9W0rusvGI1aiKu+6Rocbj1tVcysFKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysyR1l9eEjGYQbzkVJLEs6CC6dyUFA+hivUmBTkTkJ5gw1CdWt
	Oiz625GgB8NB3aWtlkRpSMv1QWRShQubJi/7lcDmUVbuKUXBpLA3h09xWDwWGoGvhWgltpyAWez
	6qYM2nVM4I2xGyDQWLAb/PvLmkVZvVlkQoIcoKwr9TfZmIPJnW5pHlEe4nBeWjF831S5X1XptcA
	j6xQ3PloiC
X-Gm-Gg: AR+sD103HkJpX6Z3t2UIzsNVZImUiL3/z0xE9uBqMxWJWIyRQaFyUBHxyKIZg1Ldpp5
	Qy6DxZxiVrwgmcFV1tHb6S7yP+h2fTaivBWR11xrQ8oIPWQdOe5o2bJ8eYiKsolJY2GbcxjLnYW
	x81o11xsjUq4DUZfYEVmB557JCqOR/Imp9NfG9rI48NuA4l3L8IWND3ZEiDr943L9+wWl5F6LxE
	fIC6iOJTwKi0nFtGzsZUxfk+JM7tqaQQI2FffGe01jr40vhwJ0OaD6YDVV8JZUjUHilnDDBXklD
	TjcjZNgQZjH6+xh76xiO9QwhO//kS6/sa1gTjmgc8RLCRI+gaL1bb0WsU0CtRTef7OHNTNaJtSO
	H597TUlmIn/KQbSjbGSAQZrz3IigxU3Pw32qr+gTdscZ0nlh9mGhnWbwdMHE21feV
X-Received: by 2002:a05:690c:7342:b0:81e:8b2c:a7f0 with SMTP id 00721157ae682-81fb89ce3ffmr24565007b3.10.1785431425585;
        Thu, 30 Jul 2026 10:10:25 -0700 (PDT)
X-Received: by 2002:a05:690c:7342:b0:81e:8b2c:a7f0 with SMTP id 00721157ae682-81fb89ce3ffmr24564627b3.10.1785431425081;
        Thu, 30 Jul 2026 10:10:25 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8a8feb5sm13764387b3.31.2026.07.30.10.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 10:10:24 -0700 (PDT)
Message-ID: <0f56d22d-437d-409a-852f-9fbf4e303284@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-9-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-9-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b8582 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=vpmf1welhrwVHoobIegA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: zrVydUNjF6nYuJEbI6f0rJF0E7T70psQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyOCBTYWx0ZWRfX+fIn+8x5rEzY
 muPwjQ339dJ+k1qX44cuNovuiJtPYk4Ngm/fok9Qf0NYxgFMvSwg1zoXIADZkvpfrne1t18A0z6
 U9k7T6UTSch5b/cAF3h9IhWIcMHPPDBw5UahYjn7P7xRmmn9jNY5fQDrYR++NYfYTZz6QRzpNpY
 LKq5tnB3R8c6FWQmn/Kv7DoYyguiCOJctFEAHhDpUM4OUjRThNtDVwxJwOV/KYOL/9K7gP6AsQK
 WyHm1RrrwstZf10MsT/uEKV+VSSA0i6rA7c/2R1FQ9y+cA1GhJfgXIOXQFtOps0Lz1DdbxQ5RUu
 Qx0E4caTS4gWPsKCcf9+EL6A1abDLIYDZmFCfo0Rlz7OtTtymY2hsVz37Ecc2JDII1Hv3r8AsEQ
 PSpmHN6yJHW/NoGPOkOmWr9L82Tz3TptrflepSjv0QzyF94H0yl5N6a8f5S40T2gTOV3lYb9hr0
 lYMQIKpob2U8mVKMSHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyOCBTYWx0ZWRfX+byxVlApO/g0
 RU7WzL3Sq+zdiv6HszE+D1XLT7OWMnWIr29X81hiTqZRrL62HXiohQhmoc2WD2yYGlO/aN50ANz
 gVZOuOxMcmD4Sk6+wibMJqRDhjdPyfs=
X-Proofpoint-ORIG-GUID: zrVydUNjF6nYuJEbI6f0rJF0E7T70psQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300128

On 7/27/26 16:22, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>   arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 9fa86bb6438e..a146be1cb5fb 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -1684,4 +1684,36 @@ trip-point0 {
>   			};
>   		};
>   	};
> +
> +	nsp0-thermal {
> +		trips {
> +			trip-point1 {
> +				temperature = <105000>;
> +			};
> +		};
> +	};
> +
> +	nsp1-thermal {
> +		trips {
> +			trip-point1 {
> +				temperature = <105000>;
> +			};
> +		};
> +	};
> +
> +	nsp2-thermal {
> +		trips {
> +			trip-point1 {
> +				temperature = <105000>;
> +			};
> +		};
> +	};
> +
> +	nsp3-thermal {
> +		trips {
> +			trip-point1 {
> +				temperature = <105000>;
> +			};
> +		};
> +	};

 From thermal-zones.yaml:

	...

	required:
	  - temperature
	  - hysteresis
	  - type

	...



