Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974B2673B5
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696826; cv=none; b=ncxGwXK4Y1S3KeYOfbKspSRsNPSDkM7K/SYAFM4qM8J+nOEQw5hV8XENJS7RIOSXj5gbgH6QMXX0KcO4h1vnX70aq+qKaklgRCzTUkIZt/TGpkiGHPvsienOMUQEOl8S2lk5du/zGpskpQVWEKdj7vSIbXC68SLaFmAQfpgwnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696826; c=relaxed/simple;
	bh=eR+ur1cKOg2flLGzDzwtH0YBRTLAIui1olriTCPWVSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWGnD27otE7lVqcFkmEBGqBqaM1TFuxL2D0erEyOtT4uqqjfub8rQB892iHdvVrQxdKCwq0QL+9it4CqMpnWqfjHeYoGEKspOe6jEAGXXeRcabeP05cqXmT90Cemy8OreFEFJbB5rYkD4+gkmrfsyVZsmtTkhzpphsMwTxaCpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXa4RjH5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXa4RjH5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9YYqk032017
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 16:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2bRT9SJHlT97u3ops9Jk5UZrZDQEVjvrIec/PkyZq8=; b=hXa4RjH5lR/jBXAK
	vycZBatVTqXUgXL2Phf9cnXpke7WyRnccJu7Vnt2/+9AniZUphgSxHf2wuqm66ii
	z2jpYcW3KYpA+ioPWrMygtQ8wqPbnmL/1+W7agkiP3AF45mGFU6a+Ry5l+5fINN5
	GHiXxgeFx3T1EYprBp6jYa3YpOdV7XUA5QlDhbMRuCF71ND4YTYRYF/YZHY9FwKx
	TmridgQDpb8Q8HqiPPwaP1RKLpFCzMzGsR2Eev9gGhae+UAj1wZzDjvCPAANVmuG
	+50uYvHHG1ufCz6ll2mPrx2mozE/1TxixyRqciDJ4X0O6Q3RpOm/J345wJgshww8
	fvr2Fg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4jn55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 16:40:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb5f7413beso8907976d6.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 09:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696811; x=1751301611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2bRT9SJHlT97u3ops9Jk5UZrZDQEVjvrIec/PkyZq8=;
        b=dvn9F0GgFvHoDXBVSaCF/p2Km97ejXkd5IUtRTJclLjZZ7FzjEN1UZDpmdiJOYHJ6j
         r23UZiYjjNA4/gWQz70svRoxhyJf3J4dU/+ZnHgcRAvbm/Cg+7z/jcOrMcTddzN0/pWC
         NVprZQYtfECu5Z/dxTuE07P+cRf4KT4f76sT59PcpyBrATcoOMMMmhbyWVsTNNkj8HsV
         LBiuVb7FyHafiPx1S0pa8CS5toCFaL88WILvRJZbEKgi2sj7uHqA9esNtCCounDDuh/t
         lcaz217HGg0cLy2O9Ir3Gx/VHNKYm9STMU6kJFwan7EIpMpL7817nJjNv2G+NJN/Zt6W
         IjCw==
X-Forwarded-Encrypted: i=1; AJvYcCXvP02sa344MlA/9wqZz3MMPviWvdwPwVy1Wb+9Xx4x0SijjjKWE4T2PnVuHbvHAfiqC4HgMGI/7N2en5T6Iu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUqMDwDXbIDuxl3/nNeEqQpKGSu4Z2NS+vxBSG5n3x6+4CXNC
	Xw62zRimcCx4Q2GIfXXaRJgrBR3ZGt+y1IYkgIwrgV0OC0rcz8qW38JGAbAumdpIByWyhnFRi52
	nawMOHtTKXTcIRETdkbD4gQ/m0Uu95RY4ANZ841RnFJ0hTF1zq/bhPY03dRq+SSR/y7Fg0dg=
X-Gm-Gg: ASbGnctm/KHgVIZ5z7j+O2nawI6PiafGs6voQJhCvLlkNlEbz3Xk7/WgXN8ypqDPK2R
	XJhoPEMaoxMsKfyMhfF9wdmYGvFTazKNyXTyDU0LhxPCaW8EthvbLD8o74C9XBOyWOIXpLa0G1J
	iGKL0s1+Q0bEaz7IT2w7AqYVcS9z8j+u4882bmV2/C2kXwlS6ipLYDgrgWOpmaIqrKiW+zjmrie
	zrk2+K9+yKOi/LNPMjevHQOj6p4TrkDM2WGtBjywRIaFfLAoRdeNhgnl8P05fm5ZhZZNhQ48BwZ
	elAsivHaMezPiz4caooJxpQO0r3UG2a3RkCbkaM6alCP6xTCtibjbgvM61mZ+bdwml/GUqMtZI7
	e5z0=
X-Received: by 2002:ac8:5c91:0:b0:48b:6eeb:f98e with SMTP id d75a77b69052e-4a780353b2fmr42899921cf.2.1750696810507;
        Mon, 23 Jun 2025 09:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq/XOpoxNvNR6RSBM0eTtgQkZh2y7a6j9L7YTt/WuGqvanSwKZAsgCnNh09krw6R1+H5c0WA==
X-Received: by 2002:ac8:5c91:0:b0:48b:6eeb:f98e with SMTP id d75a77b69052e-4a780353b2fmr42899651cf.2.1750696809833;
        Mon, 23 Jun 2025 09:40:09 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6e04sm730543266b.115.2025.06.23.09.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:40:09 -0700 (PDT)
Message-ID: <53a2cdba-0fb8-4b99-b58e-9318b1bd8ef6@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 18:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
To: Casey Connolly <casey.connolly@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
 <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
 <613f2812-3c60-41fe-bdd3-fbe8ea7eeb69@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <613f2812-3c60-41fe-bdd3-fbe8ea7eeb69@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=68598378 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=NTzqWVVAQLbBsVAMQFsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: P_q9sBdCDvUiu4VJhWyGtxY1Vl0RX2ww
X-Proofpoint-ORIG-GUID: P_q9sBdCDvUiu4VJhWyGtxY1Vl0RX2ww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMSBTYWx0ZWRfX8JJBFEKkPhH9
 uQGF5ZP0rzG7YWQq6suSMe/H7/HR4XZaI/gJD2ARHM0MKjP5wuovUWb5LKBJRD6AKpkhCvIS9hA
 GNssQzJQKu1k6RfxRMXR406Ku2dB4GBepKpNrha21Z1/mUR2kI/LGB2sMu8S5GlPYPJW52QOOGv
 10enOPEMA5os4sCkhaaHi+J2FTa5YPh05wQYhsuJy+n4UT4X23Vvqox2coc/0d6JLVhXp9PUyAB
 qL8/OKF+kwMZ7emaICaBaIpLbNLhEIYaR5KGb4xqpsA9pE4AIjWmnC7p710BXUDiiyMNWePdSdO
 8AoZNPuVHyzl0rDyTcminofoyV5DG5jRpaKWvo9v+JrPz1o1VZZSEMzoZ9UOS/M231wUKvljzaZ
 wMsycgZX5pg8AgXRGK4MSPDgx8/sbepj7LK6j4alELlYi3TUGo3MvVo8kkLigiVjFmIyRfYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230101

On 6/23/25 6:33 PM, Casey Connolly wrote:
> 
> 
> On 6/20/25 19:00, Konrad Dybcio wrote:
>> On 6/19/25 4:55 PM, Casey Connolly wrote:
>>> We don't know what the bootloader programmed here, but we want to have a
>>> consistent value. Program the automatic input current limit detection to
>>> re-run every 3 seconds. This seems to be necessary at least for smb5.
>>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>>   drivers/power/supply/qcom_smbx.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
>>> index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
>>> --- a/drivers/power/supply/qcom_smbx.c
>>> +++ b/drivers/power/supply/qcom_smbx.c
>>> @@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
>>>       if (rc < 0)
>>>           return dev_err_probe(chip->dev, rc,
>>>                        "Couldn't write fast charge current cfg");
>>>   +    rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
>>> +                   AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);
>>
>> FWIW a random downstream clone I have sets 0x01 which is claimed to
>> mean "every 12s" instead
> 
> hmm I saw that too, I think more documentation would be needed to understand this properly (I'm not exactly clear on what this actually means, when the AICL would re-run, etc).
> 
> I have reports that this works ok, so I'd just leave it unless we have info to suggest otherwise.

Well, in case of such lack of understanding I'd much prefer to see
a magic number that shipped on hundreds of millions of devices than
a magic number that was confirmed working on a couple dozen.. especially
since this looks like an improvement that people who had their hand in
the hw design wouldn't generally overlook unless there was reasons
(e.g. compatibility or some sort of a quirk)

Konrad
