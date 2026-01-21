Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27686478E43
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999585; cv=none; b=EpflTURZLh1AxGkFi0bMfsR7L+wePQFWvUCJqZQ+Sq02qT0e9MvPV3axa8rX4bN5/kFc3QLdyXeXuqQq+0pP3pUiWMtLdK2wHC0ZHHjC6nC8rdqx+IX2M9Hb7UEaWnjthBB/t02AHpBOcoUS6LtGra/GhtFy5i4WVSwXWDDV8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999585; c=relaxed/simple;
	bh=sgWtRnw99EfRs3QA6PvVAaarJHuEsYQ+e3YplyKExbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnGAjeLn8doLh633nwPnCWy5zusfOHr/Re/Br3KwKRvvK/MhPayapd9TSSgOY4eaBKBlmyAOoyCT5NJsERiDwJF5QtapLrmI7yX2agVjtJunGEJQD8bpK6/Dqqk7Hdo+1/zZLP0Y3a2+hTT2Wjvl7BXlgQYhUWlGEx2uZnU6TdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BUts4gyl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O7RUd2l0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUts4gyl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7RUd2l0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LC4SeB2938579
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQhi+tn/ENDKqMs6jsm6wY4LmSS3Rn/Smy/fNQJO3mo=; b=BUts4gylIKRk+sSE
	7B6DfsHjW8SF7BPFa4nSX9rEgYjslAceqQu6WfcjVOs2YtlhQRu6FIH0YDGkVGOi
	8N7v7EO9aZDRL56KNYig9xr3lCksJ0NVwPQtL7nEmW3IzNWa0JBmrwGDttLdJ63t
	//g1voUNdPPrUafqakeLfPoIGhOPwhUF3+O5dZBsjyTmi35phzjpd2SRvvGkgVvI
	1VSYEcHZAQBMsQ6Rxbhe5AxXIzo1UjCfRhnht+hZUr5D40sXzF22S63PDRhMhBwQ
	HSbLogH3JdBaJF6AjAT6VrYTYQeiymJvNJhjsAcgVMlPBQ83RG7AjWJCw/Vy8/SB
	TFoQXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btsmu9fw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b48c08deso75213385a.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768999582; x=1769604382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQhi+tn/ENDKqMs6jsm6wY4LmSS3Rn/Smy/fNQJO3mo=;
        b=O7RUd2l0aImyodcW7mU9Ik4rVYbPhrQ4ZC0NY2PElvra5CfbO8e9B0WVbxJmRocRud
         z3uO1Ukn9VbtiVqsGCkJzQdv80DoESbtRad3aJwd8O8Sd6UZpO+rvJaqu5aunIlhKCFu
         SnFCmOgKmRGZEcp/HyLTzVmq5UJpVk96xhYhVmOt6LFBZ0bbVbjnAhI49qmmiCb7ZklR
         uGT9qkKZasIikT3Al8rb580yBIEjeHJEa+hkggvQ6jkQXGpGntbxUyW9l1R6OTCRB02a
         5zhjO7veMOM8+N/G7nheCebsVWY2qel2wL6TrLOPOoGffuUZ1opiX+9xVcuxtZdK6i5A
         R5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999582; x=1769604382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQhi+tn/ENDKqMs6jsm6wY4LmSS3Rn/Smy/fNQJO3mo=;
        b=H2/jAVdHnLlvZFWgLqn+rSZ4fxrJyDOBkSG8G2a8eDsXnlM4jIxjACwPI4vhXsOmO3
         WYl0lOAaWnvBOIMndZeS1vzQipeETPQ+sIwi3gDuKhM3e4BBGolbxqcA9a84qRFkbPKi
         HcPVbWBwEm1B0hlILdeHY791vBRLP7uTbe8QaCip7vE6S4Tn1WNqctMlUuDNu6F7RjIS
         JqvxCXA/PzFcpbqx3CfulyVr7YG8/seAvdVxlv9TPFk4uBjZrt8MYGVRVqtGNNNSI2rt
         YGuVGISXw0nzmRTRHlyZ5GRc0mI37XiErtFqbnHqFQ5JGB6TqtY2s/WJ+D5p+IbjVlam
         gRtg==
X-Forwarded-Encrypted: i=1; AJvYcCX2KVK0LNvZlKBvBYdagdSyMw55asOP3UH3xDvcxERJmFdL8araqMAvKCQzDxwv3+M8sxPvUlrximVg62nFR8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuelbFhL5L+m17g0Ugr64GFOYCHCyfOoQpcRjqZ2bLz5o4RWc
	7oHzPqDEppZaUx/wLtS1fMIp9K/QTqUAzDU2rIA8pXcEbro92C40TEWRM0dFBibrOSA82Ea5ihk
	s2BlAWdAQpemE/4heOh8kkAKxuHMK7Jola7ENVNeEYPeAaNLmHgWLJZSGwML6CuA5p6a1ncg=
X-Gm-Gg: AZuq6aJjRCWEePQffNDSsPMj19hFvVkbQVxTuxTmXnWdzvPCGyFSfUe4BPr9KJvVeOj
	sjW+IXy12RtmdEdfOW3+lJHy3O02zQSOPFYjnL9sUzQNHRI8gJ+zeDDIbo2WFIovE6Z/5pCtS5X
	MAloT0UuGL1eeVApPbqSb3ydoU4I86BsKp4DMLTA/AEnId3xUrRAwIxdD+eVluXXD/NrbLYXi3a
	8lcHK/ooY84rJJ3lzhzL+CsOHEEVvaOCvuc/PvM5vYuN0LSrQV8nEI3ll/9zAJ367UWfGZCuRAT
	v1MmkiDYtVliPhWb8VeLWbUzEgCXYq4+kzuWbbxi7benet5/w3A+3z/JkU2m1anZORlC7x3+Rou
	xdcGTx76rhxLlq2SYAKAI9rL4ngzPAgK8P2vBRrD184GP+gnHDPLdvd3HoSpKTGxJxMc=
X-Received: by 2002:a05:620a:198d:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c6a660afdemr1968911485a.0.1768999582266;
        Wed, 21 Jan 2026 04:46:22 -0800 (PST)
X-Received: by 2002:a05:620a:198d:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c6a660afdemr1968905685a.0.1768999581556;
        Wed, 21 Jan 2026 04:46:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9f98sm1639040466b.42.2026.01.21.04.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 04:46:21 -0800 (PST)
Message-ID: <50c8abcc-e3aa-48f3-933f-a79af359c654@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 13:46:18 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Set
 memory-region for framebuffer
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20260116-xiaomi-willow-v2-0-4694feb70cdb@mainlining.org>
 <20260116-xiaomi-willow-v2-3-4694feb70cdb@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260116-xiaomi-willow-v2-3-4694feb70cdb@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OaiVzxTY c=1 sm=1 tr=0 ts=6970ca9f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=RhDKmtT3Wz6S_GBH838A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: JJohae-FBSDjCm_AqulyS2idybybjyDG
X-Proofpoint-ORIG-GUID: JJohae-FBSDjCm_AqulyS2idybybjyDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwNyBTYWx0ZWRfXwx28IRR5qIEm
 UlsvaGa3FqheTK9UF3ZskSuQX3rSENBR4OBGj4uYhMyLLxLJxn6vqB+t2mbqo9TdFyZa/oqOGuY
 mk7sbrpZNTF8CRUX58dmFS0a7/8eSW+rMbzioqdmk8pN2umKDSgwx6v12gyonnSFE37IklHUkpL
 2AwYre/CKKO/Nv7FBZyH2qw1M/xeZX/8bQPOCeW613h52NLM1+7RaQjZjM/evMPP/m6GRAI8S8B
 4oN+c1QH6Wo6j76ANkXacJNcV5OsK3JwqUc3bYkB0tJ9GyOWvEypn5st20XOaimMElX/5P71UoX
 3Q73JzXbQSJvka/1zjT1GijNj9+79HbtyWEE04GI/9IZgW+7xLOm0yRxqLXpr3B8M5cphq5uDFi
 5LdTKlRxUvkfokoWMLhBHr7uuN/QeWgqrPTiOhR4yWziRYjloMddaJx62QZHQ2aDoU/8Rawi6Oi
 vxlb405nEUowI4h8uhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210107

On 1/16/26 4:54 PM, Barnabás Czémán wrote:
> Use memory-region property for framebuffer instead of reg.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> index d5e5abdb3b2f..4e1444abc29b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> @@ -33,7 +33,7 @@ chosen {
>  
>  		framebuffer0: framebuffer@5c000000 {

You have to remove the unit address now, as 'reg' is gone

Konrad

>  			compatible = "simple-framebuffer";
> -			reg = <0 0x5c000000 0 (2340 * 1080 * 4)>;
> +			memory-region = <&framebuffer_mem>;
>  			width = <1080>;
>  			height = <2340>;
>  			stride = <(1080 * 4)>;
> @@ -62,7 +62,7 @@ gpu_mem: gpu_mem@57515000 {
>  			no-map;
>  		};
>  
> -		framebuffer@5c000000 {
> +		framebuffer_mem: framebuffer@5c000000 {
>  			reg = <0x0 0x5c000000 0x0 (2340 * 1080 * 4)>;
>  			no-map;
>  		};
> 
