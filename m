Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14930C16F
	for <linux-hardening@vger.kernel.org>; Sun,  5 Jul 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246783; cv=none; b=AvJCWL+BGI/h0iNcUFqw+e9pFfV7UxanNT7KEXzm+Cth0oyXZJI5WYysnahAgXdNhaokoS69HpNuZZPSe8LaHvdLyxIWBT6PEg4npqHqbvIPqXKBwu7zO6x8ZrWg2tMQLx+bhZV09s7ccIXA3cUD+o/2N2NzzX3GzsrCS+FDBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246783; c=relaxed/simple;
	bh=xBY+X7nL5AZz+gzrhUliZqJVFe9VocGCCYH1oenG6VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBKyJsBkaunYtbwzNBWUjOz4h/YLxCVs8uiqQYb7nFSvlGstsq/VvQe68DR63/J8yN3gQ/pqjLpnoQSOJ/h2iq/EBjpjrXjyYQvJIzmYbQU9gTUsGBbnGOsGmCW0+Xx/MBJ/ToXYYjXPzIh/5GTw1xchy8BgmlsjksTrNDUWOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/p/r6Ck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JrB6TEO+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/p/r6Ck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JrB6TEO+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664NIjax100653
	for <linux-hardening@vger.kernel.org>; Sun, 5 Jul 2026 10:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xpbe7dAQLjNnNWc71nhAnTIRBBKphawt2IUV/ANXlWw=; b=d/p/r6Ckktk9AztM
	pGL3GsxkNLlTiaAAekulPH8g6Z9lVwCHBHkqkfzqMlZc0jPDh2RUkq4r97Uh6Hry
	bkT7G9R/Sx/AceKnkVKzXGQVqDYSzmpn4tVKuhl3JzrCrSP0Ar03ljwrYrQCPZeV
	xIDsucmeigO5sbEFiX7dm4z/3Yk3lmgc5//ZxJYcRhQe7vn47rl8sz7y5DtgyaQF
	pfID5+WfqrlG+FhaaTmIEZxmJxBO4GSJFd9/PMaDg45fOJqJ5CbnUugtO5jzUKJm
	T/f1et17VY7/NQZ1AYciPCvMYDJkd+DmuX/t5CyENXMCnzlabqweu9AqHCV7FqAx
	+WbiZA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgttuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 10:19:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso3897104a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783246781; x=1783851581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xpbe7dAQLjNnNWc71nhAnTIRBBKphawt2IUV/ANXlWw=;
        b=JrB6TEO+Eg09ew9nbnj1qDaJaCkIR/ELjm06lr4v91afQKD/Jzfy1DxTuQ0tjof9hV
         AwQC5OyDzj+9MnKfjMVownl/AOf9KplDEJsKDRQB+QPO/3ZzgU/ws4EcnXlzVwXfeoBe
         6QHFCJaGq2xMAMPE78bvmBJepJbsbwnTGAXxxJ86u+lrDKMBdafbJ2XhguMibxDrsYUo
         RmprW1ENYIANs0LvbPJJVFBus2URh9wWdz6mgbzZ9L/t80rbTbTIJqKMlwp17Hu5VFXm
         FxXicAv9PBVSSuz7ltbhJRNcT17f9PRIfokIqbHTcOpDeXcD/gqS3zU6itVp8ucqYTe2
         H98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246781; x=1783851581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xpbe7dAQLjNnNWc71nhAnTIRBBKphawt2IUV/ANXlWw=;
        b=ndCu00LmBNRMt7+HgDb/YrcYVtQ8RBimHS5gXUxUg49afUsxRfJAg1bBvmNK1gyJs1
         jSf+ZDaabPvmYTOZvNlOOyzdw47UQkfGEMa7/jMNqy8tWcz9WluSRUJIiH8JzTT7+y+N
         CilXyB8Ee7Lq8bDVtwVDHksKP53eUG7vQDmNE1tQeBXZrCgjZOWLZu0nqMppIgXZ9nIg
         2pACEe0nYf3ZwzZE1VqwPy3CRn37DShOiuG1BoZNxNsNyp1SzBLDnxrW6XbI27rFOQHj
         fclvNM5pXKJf0SPG4jyLzN6Cl/2lYviON5D3dd/bAzmEPqSpi14k63yV8eeGH8ivj/i1
         FpZw==
X-Forwarded-Encrypted: i=1; AHgh+RqwvDWl4gW5ucMImYy4AH+A07qSUvAevS2oZeYIbmKyQrcsECSCpha0cVQhZ9pGEUdz7K/sx4YlAyvewFkqTLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5/R4TG2Ia8RIfGxo1sDblma74nX3Yd655Hs20zs/0XRh3McN
	3Ceyo0MbaYBFY25LYnwlhtN1gBSwTzsAS9JHSV3lC4sQ6qo3mCauQ+dTMjviR8PbTWWpUTngp7N
	TQCy79Y2bNpLS0vxnKo8W0vf7c5qzMwqsZMKAH8irBge9VPpHDmiGMqKAjYic7mUDvTdEieM=
X-Gm-Gg: AfdE7clc/3SbGcfPJzlq2EPz6mZTCEjMBXrUNIhrBd5cCRA+Kzp8RfA2Kaqrn+VpaXx
	dNpdw9tyP8crUwJYTlfLK4h4EE9XGcrqHTWniqEDTbju4DXeAAl63FN+tByn+MPq+/puHXEMJuU
	edhNI0CP1LKV7HUybKmfxv4OcExiIm+JhMT9/p4PYYLnouyF4oL0BDuBxy/iMsFGPSLlw0BK102
	ueyYO4Hk+xv5Rikm+vCh2pmB8uDizyJPQA7NMB0SgwUf9Zgf3hrzhmDYAu3oqw88G3EFqrsTYoC
	8DgmJhMOsbG2kWhVr0MHknDRILq9Yg4/ZJICTxjG4evYYZRXFqBBl3RsqC3io8QZfOdyMGevjjC
	6yRhnEtsoLUmnH87k1tnZWSx/69QTOnrwikqYa9nA2w==
X-Received: by 2002:a17:90b:3fcf:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-3829f100a13mr5642960a91.23.1783246780487;
        Sun, 05 Jul 2026 03:19:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcf:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-3829f100a13mr5642945a91.23.1783246779990;
        Sun, 05 Jul 2026 03:19:39 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm9099831eec.15.2026.07.05.03.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 03:19:39 -0700 (PDT)
Message-ID: <49566b40-324b-4234-bb07-09e84749e666@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:49:31 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <20260703-qmi-tmd-v4-6-3882189c1f83@oss.qualcomm.com>
 <pli4napz5xis7i24oum73wnaecvqz53nxy7ek6mftlxsq7qkyt@nc7jp6oi4fix>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <pli4napz5xis7i24oum73wnaecvqz53nxy7ek6mftlxsq7qkyt@nc7jp6oi4fix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4a2fbd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dzk2ctQkzv_BcHpUmM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: dCxVREqRRwpFvfNi9wVFSon7S3qPrvgF
X-Proofpoint-GUID: dCxVREqRRwpFvfNi9wVFSon7S3qPrvgF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEwNiBTYWx0ZWRfX6qLCKF7s3rti
 jP60l2hL6csOAIvOTJCTsBhzsYZAQUp4RxOlXb2G5sIBLfYDDqRnYYz63X1sn2IeDyYmIBthYZs
 8iuWEgQOwpbKQ5+Zb23pglAsy9cM+ww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEwNiBTYWx0ZWRfX1upUi1VzGUKA
 cAE2EJ1z9WApVjl1xMyZPvOigIKgeUPw3b2ApXSx1dbdc/dMzyGQwKXABt/GSTVHxlyfZhtlSyp
 BLANPq86rOw/LMT8qi70yAk/uMupP+sR5iml+07MT+XceNRfp9FFaumjQT2WyFzVXdORd6zo/IA
 g6JtR5ASQlqIawJgRbaTar2sVGgxFc6PszZVvPQrJMeMQ+PqgtY8YVyOEmlWT59VyJuvRC6BNBI
 A3YrHCBGvWicwpHbMzUcZciCO6jAXg6KxCtcE2uZQ+TxUuYMoQxS83quhGRfna8aRwOcRNnwyoa
 KcfW6RIZv9OGtdJMWrzOCrbOz/nPo2D6PgeE2HlWQwXDI++YyBK6uT0AwbWQLF8+vwIyakL4JSt
 UXu8R6HeqoLjR5XdpsoJFNZj8YCeVy1+OOKqrIZ/3OPNI3FBSQWVqY0iW2uJ28L8wMGxmGqvBmd
 opYSlUQG0icDbYegRWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050106



On 7/3/2026 9:18 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 03, 2026 at 10:33:09AM +0530, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
>> when it reaches high temperatures in kodiak.
>>
>> Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
>> for modem when it reaches to 95°C.
>>
>> Since the remoteproc_mpss node doesn't exist on non modem boards, the
>> cooling-maps that reference it cause DT compilation errors. To fix that
>> remove inherited mdmss cooling-map nodes.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++++++++++++++++++-
>>   .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +++
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  17 +++
>>   .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +++
>>   .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +++
>>   .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +++
>>   .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +++
>>   7 files changed, 231 insertions(+), 4 deletions(-)
>>
>> @@ -7716,6 +7722,8 @@ map0 {
>>   		};
>>   
>>   		nspss0-thermal {
>> +			polling-delay-passive = <200>;
> 
> Why? This applies to all added polling delays.

Thanks for review, will update the reasoning(passive polling mode) in 
commit message.

> 
>> +
>>   			thermal-sensors = <&tsens1 3>;
>>   
>>   			trips {
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
>> index bb5a42b038f1..400d128132fc 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
>> @@ -24,6 +24,23 @@
>>   /delete-node/ &adsp_mem;
>>   /delete-node/ &cdsp_mem;
>>   /delete-node/ &ipa_fw_mem;
>> +
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
> 
> Don't kill what is unnecessary to be killed. Remove only MPSS maps.

Thanks for review, will change this to delete only the MPSS map entries.

> 
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   /delete-node/ &mpss_mem;
>>   /delete-node/ &remoteproc_mpss;
>>   /delete-node/ &remoteproc_wpss;
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 37a3b51323ce..187bc2899191 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -25,6 +25,23 @@
>>   /delete-node/ &rmtfs_mem;
>>   /delete-node/ &adsp_mem;
>>   /delete-node/ &cdsp_mem;
>> +
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
> 
> But MPSS is there. Why are you removing it?

thanks for review, Let me recheck this and fix this.

> 
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   /delete-node/ &video_mem;
>>   /delete-node/ &wlan_ce_mem;
>>   /delete-node/ &wpss_mem;
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
>> index a5ad796cb65d..1e190ed18ae5 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
>> @@ -22,6 +22,23 @@
>>   /delete-node/ &cdsp_mem;
>>   /delete-node/ &ipa_fw_mem;
>>   /delete-node/ &mpss_mem;
>> +
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   /delete-node/ &remoteproc_mpss;
>>   /delete-node/ &remoteproc_wpss;
>>   /delete-node/ &rmtfs_mem;
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
>> index f47efca42d48..8e8dd4efd8c0 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
>> @@ -23,6 +23,23 @@
>>   /delete-node/ &adsp_mem;
>>   /delete-node/ &cdsp_mem;
>>   /delete-node/ &ipa_fw_mem;
>> +
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   /delete-node/ &mpss_mem;
>>   /delete-node/ &remoteproc_mpss;
>>   /delete-node/ &remoteproc_wpss;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> index b721a8546800..1e9d7e7b5fa2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>> @@ -26,8 +26,25 @@ &ipa {
>>   	status = "okay";
>>   };
>>   
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   &remoteproc_mpss {
>>   	compatible = "qcom,sc7280-mss-pil";
>> +	/delete-property/ #cooling-cells;
>>   	reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
>>   	reg-names = "qdsp6", "rmb";
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
>> index 3ebc915f0dc2..6642076f62c4 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
>> @@ -7,6 +7,22 @@
>>   
>>   /* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
>>   
>> +&mdmss0_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss1_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss2_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>> +&mdmss3_thermal {
>> +	/delete-node/ cooling-maps;
>> +};
>> +
>>   /delete-node/ &mpss_mem;
>>   /delete-node/ &remoteproc_mpss;
>>   /delete-node/ &rmtfs_mem;
>>
>> -- 
>> 2.34.1
>>
> 

