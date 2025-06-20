Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC92C0313
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439266; cv=none; b=sgwO+ACqrl1gpyq1YWaqt/DHmxI1Wwn3MQcTTGQVrIlwoyWpU4Ff0+AJDmeXEFnqyBPlFcGvnsEytAwroJt9jeSMfXkrMaYuQkym7UnRJuly+7WEkOni99YywI0psRSgWG6dHRea6Ftk8YFZswgGbuNtOlwU4bJdBzZcjsC7XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439266; c=relaxed/simple;
	bh=TJoa2xPImS4wAM1uUVWoOFg2ZyzLr2gFfx8eCrn+wM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a14Kns4wt1F2hCg0VhGrztKwvDlELDm/AJP/lcAlk4jKrWe/ghnDTksMTrtLwP0lNKSvrE7trI6bo1TxGZmx4Tf36YLemVDRbiEjbbARsZVeSZPmbxrDKOY1D/yhTUWXKPNZtsiEK3j9UUen3Vz/fE+L71IYg46sZD5U5Ebu7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGFbBnwr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGFbBnwr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KG2csX009133
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKKwQ1dKYiwuL/gFRwwSIgyThK0XHURSCnVrX9k5gJg=; b=jGFbBnwrmAaYrBWh
	0xzZGscS1uyi5Kkfttcn23aT9G8l2Rm+6h0wVa2FWYAxlCSHsrN+K6+AVY9Vo3i4
	B67RczhwXtXSPBUggERRf2kSNESIGDWPQ4bN53te4EnYjnLbLzOoC2LoLrIMAQ5T
	f4zz2zR5SK2FeIj62BUGC3ly6O1DF72RH9+wbt5Cfz96BOJaHz/4AznNj7EAVMj6
	ESsiyHmo0bWm5zfZJJ7eL2W6BfwOhcPoMp9Z3p2np17DhKDPhQiaTe+rJSvcuyiq
	qiDF1RABlLwmL7Ec51bOyE2nVy1mWfhM+1oUc3C4LQnBPTSrH21iu/J7V/rVMB2c
	zdgdHQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47date05b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 17:07:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb030f541bso5006266d6.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 10:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750439262; x=1751044062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKKwQ1dKYiwuL/gFRwwSIgyThK0XHURSCnVrX9k5gJg=;
        b=SAVUPYcAr2lfoc7RDgQ68ovT1QpZccrUnZ04qYAq2GlhYKA8MutrsmRNTVo9ZFYtwC
         LFvgJby20fIE0kndgXNk6SoZtNFd6k2R1jms5pcw/o2r8Zhq7nFMj7p8u4jgLlqX08Sk
         DX8clZpKTXM7dPfzK0c0ih0gbkqv6ivhOAoMfd1tRRBzGY55MbvPkINRHvbbtteZxsw6
         4NDS3ZL/cx6uyOyFCeC3ujMJCaq8bfkJUp8Nv3ywYKY0Fb7WSJDVTkEo6p7YdQG55Hjp
         GEC62eEMkMEsbxcCNT8MRTy4TlV8G5IhYR5tn1WXteZ3CMujWmTL4VaNmjfFv/e0qx8A
         MDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVzs1MTxtLy79z0DIGkjUXeyyUAkvVsoo58SgJZ8qn705K/PuPxv2NIHrY+8qJBdVaghfdT+Xb/tvNoZBD3zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxoXGB8M5E6xqi66pKBKTBKQ2IT7Kxlcqn+1GTrw6PKBIzbtn
	MFf+sNmmmWl7+06VHsmWJ2JeuPOb772EXV9r1ckGna42JDpeU3jd1y+ttirYRsKA4OgafbBBLcm
	GH+Pu7JqntzUUPCdM3KLCWjPQCstZdIAM61969s7Ppna0QRIgFHbOzd0sOydBcRfjGc6woiA=
X-Gm-Gg: ASbGncu1D/31GeLy1yO+u0bHd13sGWEQHapPJi+2QjMlFC/O75i7kmvNF7jVJl5nKN1
	nx0SsExmKzuPGdmAoRK4PNx702mgalIodhHAXO0X6ctsWIRl4PgdS2MHEerunctleqQqPqHw3EM
	YmcHJy9Q7S5KFmZt/uB6MhW9tWQ4UZuxuX7ZHaSjAd/mxCotilKgjQW//OoQ1w0IWZzH7UO9f+4
	+XC2XgoHDY7Ng1v+Xr9k7kZAqhBlgNNlgN16H8kPxTN3Vy7Wzum0MOboxnXrrCK0WfxLgbMVTCS
	hc/QRl/lTbB7P559M7SonMmebtuaskmY7WZf8ndk6B/WvVPzxfgZ38LJt7/ukOXPRBzggS2zGeF
	KUrg=
X-Received: by 2002:a05:620a:f10:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d3f9916bfamr156997785a.11.1750439262637;
        Fri, 20 Jun 2025 10:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVSWLQFC0kpw0PBqz9gCS9IFs8NVF3u0lcuSEdXmZtlYNC6FTQskFyKD9xoz9LSWWobdlLxQ==
X-Received: by 2002:a05:620a:f10:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d3f9916bfamr156996185a.11.1750439262103;
        Fri, 20 Jun 2025 10:07:42 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05433aa56sm188279866b.183.2025.06.20.10.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:07:41 -0700 (PDT)
Message-ID: <efa03e46-35c1-468e-a188-8e857ecd4b8b@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 19:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] power: supply: qcom_smbx: bump up the max current
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
 <20250619-smb2-smb5-support-v1-7-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-7-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyMCBTYWx0ZWRfX22wEe+ZLszJG
 CA2kUJUAvc5oGRUTaEvpQ68VMGr6xhDv0LUA6I609a8DVXPlHgi/o/RsOk6hEKEuendmeIBFeZS
 SWN/BjIzuFekVHCB3KoGggPMqzQX4d7JTj7aRRok0KoZqzoPQqgOOa4edMhYLlI1yuBZO077g4q
 TvOld2/62beu42jlEA40GZrKjtEUBHQSsKUUVT+g2YmlGjXk2qChAhGJOqHbk6tuv4ts/r1ij7i
 GgSbCurBMFYH9ee+I2M2Us4zJyVIswC9ZKkhMjBIEdkFrMECDGWoyLVrhHw8b5EAaQZTZc+Rj9w
 BEOqbad98u71V9dXLyxs5n4Ee0UX9whyIzWHmDiP3ESV+UbrDvhk2kMJpO2cDK9IuIohThlwQfv
 z+D2BdkBxFFrcTm9TFTIw/j9vEi/P8NMV124dJ13/ejtXaMrL6EipTfT/OKMxgUR9YjSGho7
X-Proofpoint-GUID: 3Obj6fJWZ6GZTYFRdjTKFNNuHsBLqU1i
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=6855955f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=rhSfmRiNZEirnHGn6ZAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3Obj6fJWZ6GZTYFRdjTKFNNuHsBLqU1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200120

On 6/19/25 4:55 PM, Casey Connolly wrote:
> I set a super conservative current limit since we lack many of the
> safety features (thermal monitoring, etc) that these drivers really
> need. However now we have a better understanding of the hardware, it's
> fine to bump this limit up a bit, devices can additionally set the max
> current via devicetree instead.
> 
> Since this is common to smb2 and smb5, move this write out of the init
> sequence and into probe proper.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index 7fc232fa7260a7422ac12a48686cd7d396edd9a4..d1607674d291d6ef5762d35acd3330e2116f41a3 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -875,16 +875,8 @@ static const struct smb_init_register smb_init_seq[] = {
>  	 */
>  	{ .addr = PRE_CHARGE_CURRENT_CFG,
>  	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
>  	  .val = 500000 / CURRENT_SCALE_FACTOR },
> -	/*
> -	 * This overrides all of the current limit options exposed to userspace
> -	 * and prevents the device from pulling more than ~1A. This is done
> -	 * to minimise potential fire hazard risks.
> -	 */
> -	{ .addr = FAST_CHARGE_CURRENT_CFG,
> -	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
> -	  .val = 1000000 / CURRENT_SCALE_FACTOR },
>  };
>  
>  static int smb_init_hw(struct smb_chip *chip)
>  {
> @@ -1029,8 +1021,22 @@ static int smb_probe(struct platform_device *pdev)
>  		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
>  
>  	platform_set_drvdata(pdev, chip);
>  
> +	/*
> +	 * This overrides all of the other current limits and is expected
> +	 * to be used for setting limits based on temperature. We set some
> +	 * relatively safe default value while still allowing a comfortably
> +	 * fast charging rate. Once temperature monitoring is hooked up we
> +	 * would expect this to be changed dynamically based on temperature
> +	 * reporting.
> +	 */
> +	rc = regmap_write(chip->regmap, chip->base + FAST_CHARGE_CURRENT_CFG,
> +			  1950000 / CURRENT_SCALE_FACTOR);

In surprise to no one, I'm really not sure..

1A is not a bad default value if no other information at all is provided.
I'd say deferring this to DTS would be the best, so that if the programmer
knows that e.g. the batt/skin temp sensors are there, it takes an explicit
addition to allow more current

Konrad
