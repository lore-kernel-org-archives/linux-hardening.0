Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B42E06C7
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438879; cv=none; b=cTEXsyJFC+0xyS0llj18rjrJiPjMdzUfNSh0yfsnrDbbPKkfj2JnKyVvsTb1Qb1fItf463arWnNTWYheqtmhMZ8M0MPcfiyWeH0ZqQblxngDisPdg4l2kiGvTvORVZGuCKLYn6ROX/4UR21k6aHwsteCuQhJtzjZ2jUW0o1PpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438879; c=relaxed/simple;
	bh=XAukmnt5QjBdMQI+xuahj+iBwVBMbadMcYelH+EV8+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfwvpnFr57XoR6SWoGDwkNjE/cEhauq5y7JP4rBlXl35yAb1K4ur5z7Gv0/RShdBYun1RV+vSV5ZEuQ3oXDnl5n6HYJZDhrd9oLfKGJLfltA2hBhcmzNqUBOxfIyOsyGxa7d4K/Rba+EsC9GVIvoRQ4sCFZV28NMiXICnBtfkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXIuSAl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXIuSAl6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KGYDmm014524
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fpu0l6974H5V385jR1/L6yeOq9JUIfEhJX1r1r81aaM=; b=LXIuSAl6/qDRZB8x
	Rou07E5KSwJ2siNkOf3nRzeATHpXzlQBkuSyYIHUDMWKbO/ceb1UGe8aeHw1tRuV
	+ALWNpKymXnEnJc8yCtBdXL71yc4l/lHODXnx99U3EOQAd/yeavU40JDasmldLF1
	bM3fUiy0kAAIffnJB+O1IZn4sWUH3LQ1XxgIdenwpQ9ryYTqloVOQPrBr8MNlpfY
	X11lR/oJ87wYWKTBtLQIs5+QdYm8dYMDDSKWxDJQMk7VSYu1TdVoOC3rv0YG6Ih5
	7NR0cEOC7gKJL+/PCCh+FSb07j0Fcdsv9kOuohxSs25CEBa75BaBeWCJSDo4lTYM
	K97zFQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47db9801pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:01:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d0a9d20c2eso36238385a.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 10:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438876; x=1751043676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpu0l6974H5V385jR1/L6yeOq9JUIfEhJX1r1r81aaM=;
        b=GLTmtvPR+dBQndjPwOPF9uRMHb27N3uMcxI/mNbJXkN5xWthGfrzCL+dSCEISUYn9e
         kXuaqbaRk/9hz+1YRPOWf6NkJgPEcZxsJi7tkX+XWxUANU96HR+I/XWprdQJGXrqEpFs
         RBXd6OWVpGiLH3JiVaZ1zLeWrVMO07OirqDYRvSdFS4fiyoTLJdmqdpf5fGNMjddJMtw
         g+O1nuiCeGcePyyPAsE4oRnZzpnSrOqMi+0emuJl6vCaFcHBUs31PItRMOdLesqlN0M/
         KuGZePVQyYlDdPE8yMe2SHZawuKMjtNXIbLnZTt7j1EV3/h/Q60FPTSa6z9RZjrbx5Bh
         4Twg==
X-Forwarded-Encrypted: i=1; AJvYcCUzHnJZoGATEEjs8S0SdqTldqure3Hr2HmZ0L8RAq1UZH0o8y0Agw9rAaP/gsYYji5cGRLBtGq+d3vFBK6Q1C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpKzn7HRRZUmXdomfcIx53JzlIKDF+GxVSMcNZLMoIXf25M/im
	pdqGUZF166W/vfP9lBNhvoBBh1+bfjlLm/XawaSYGhHIEUI50A3DA3+s+uyFneSewQA7dcpgckY
	I0OjE3Dg+bPtFMSZvkm39JK1OXlfvrc2lkP5vSowMvJSlVKGF07Zol0sYOZrwgVDn+WmiUUQ=
X-Gm-Gg: ASbGncuwSM4Amuq4S1drDhrxCOLChx5jEGcCZHlkunXcMDkHCBzcLnQV2juC+4FiElM
	WPyZhutpAAXzofBU0vAVKi8Gx6JcjcZ+aGz/p4enSJncJZctD0jDz7NAqKgLEiG7E67lP9D3jDE
	DKtwUUTnkI3qQo06SkZhaRiNyRfdXhqvniih5J3mVqyN54C8EKybpYjfIG92Q6G2GDmV/ZNg1fl
	sCCKBd9+ZWBo18tq00nh8lp/GziN9HLIKeMXSwJ+7RIhKg5BlcATDFxxsQ9DDV3OjqSt8ll/1eU
	RxUhWJIlbInFGZmDDSl7r/AI30z2mmGgG/jKwS3h+zMZ2rLIP+vN3ap9Jju6CJqTyxnjbe+cC6y
	O1Vs=
X-Received: by 2002:a05:620a:1707:b0:7d3:c69d:ed69 with SMTP id af79cd13be357-7d3f98ec727mr193721885a.6.1750438875909;
        Fri, 20 Jun 2025 10:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG16STpHVdEHhYbxIqd3DOFgM6T+wJ9+inbvmdt4Ws0DP1ihUKEnE1P7W/LjHT61a5uRN3b1w==
X-Received: by 2002:a05:620a:1707:b0:7d3:c69d:ed69 with SMTP id af79cd13be357-7d3f98ec727mr193718585a.6.1750438875323;
        Fri, 20 Jun 2025 10:01:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a185797bbsm1647747a12.35.2025.06.20.10.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:00:46 -0700 (PDT)
Message-ID: <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 19:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
To: Casey Connolly <casey.connolly@linaro.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8Kp6OEKB5JfYAdgd1bYZsr72eqNXPNHm
X-Authority-Analysis: v=2.4 cv=TYyWtQQh c=1 sm=1 tr=0 ts=685593dd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=tPfAkDRKdS00ijgZXEcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8Kp6OEKB5JfYAdgd1bYZsr72eqNXPNHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyMCBTYWx0ZWRfXy/FjGGF6UYoF
 eOUhCcQ5FTh0XMkFxb5+jWcfdA0uSkMq7V+M6Vm502HJCDiA/IJWEHMpWBD+rsyY9PRuzW+VdvR
 RJZoke0akus2vYMqRgRikWDLnUD56k9M1r4IG3k8nqluyhXq7g7DhobpqEWTkkSV5jbFXCCuKRc
 ol1GAXc30fjWbqRSRzY7deOVig+5UVGVXJr3R2Hvq+9oV2BLtGpsA2mYUJTp3tstvWEAhmzaTQL
 Ne6QmTAVpfO6n3X44DUO9wD2cie0xzcMH9GfL2zU4DANa7uCPJGfLRvyeR6qCK3e6XjNERnfyoc
 QOL/vXkh0ORKEsPosBDOQ6Kv5PRy+l6Deq0NVYeBX3qLI1KnsvlzUc+m/4EEq0APmZzmSS5t723
 kxNsCc6hPRZzpxg/VcAyW2SZtUnf/WlvvbTvurNmU4YY9iWm8vxJPFcoDoWo1rVHys1gxo30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200120

On 6/19/25 4:55 PM, Casey Connolly wrote:
> We don't know what the bootloader programmed here, but we want to have a
> consistent value. Program the automatic input current limit detection to
> re-run every 3 seconds. This seems to be necessary at least for smb5.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return dev_err_probe(chip->dev, rc,
>  				     "Couldn't write fast charge current cfg");
>  
> +	rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
> +			       AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);

FWIW a random downstream clone I have sets 0x01 which is claimed to
mean "every 12s" instead

Konrad
