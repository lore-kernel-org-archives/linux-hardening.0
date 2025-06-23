Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB74266EE7
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696424; cv=none; b=uTsGLfi2ylI8U2UAGhemRqHlQX/2ODuWSz2ZLJrwsVWvghAA0Mc0+pXsfPzi9lzhLZmDJYxW+vLDjbxV+hPJNclXSAqQnhdzWLx7UsYdVx0cW3NF/27tytT3vrzFg0hAdVA2+HMnLhN8tCDmdSGZA76KtP/oIzi1IJ/mm1qWS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696424; c=relaxed/simple;
	bh=bUrESiPRUdiT3aZBD/7m90ntrZOEQs+uNbXB0hfmyLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAUjyqyjNspdyErAeB5qOAzEbJ1hTGl093tuI2CJT4qH3UAe38NsTQnG1TOSZJZ2sXq/bvYO4D48ZVgsaXNb65HdHEhoVxk2k/gyWODwS7uJtpMH9J2NPnkvJQ2RggaZgUY9fJAgwtwf7wLkfiSj+fJo74GYzxDrVQ022CCYYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZutgFjj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZutgFjj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad89333d603so809456566b.2
        for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750696421; x=1751301221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXbXOUYB6IBOkueWjAb33r4P7mb75EnqewGXePwUiUc=;
        b=PZutgFjjE1wzaRvF4ETc7QoGsoTEEUDKTVkzYNkXkoYszUGKlGsHGUSRk0enpvArNS
         lTBA5d1Lu3ZQzGDN40009BUpWDw6RkspNHAGO6JqtGIm18QjpVY+3TtjQNNvkgVphkSG
         H7jDfH0fdHjyXxjwmBa+N14Ox3L3AiNgJtP7sYxJ4qNdTmAXRuGIb7/S64sQNPzergW/
         Yfftagh5OSoY8a3EdnW5XBg9uu6wVZ7W3hD78jqK0iHYkiypuEKEvVN38u9uJqkiUe6/
         2uoTIFnPBTDwdaYuYC7XLc3qbw5mEbrVHDS35AOxNiIdsuSW9N2593UYBiXv8630J4Ai
         WB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696421; x=1751301221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXbXOUYB6IBOkueWjAb33r4P7mb75EnqewGXePwUiUc=;
        b=MBrXbvoEqQAV2udyXLALJrfRQHBK+pIeJ5MNGidlqUNTjw/Uk/kfMO+6DZ0HQZ6WxL
         0ABudTsRdyb2OfQ2BASeKGG+/Ex3J1WqXKhCTdvKUzZ2jf+lrFz99IJcUBhQQvnCeiHU
         v6CHdfKFYCZ7VosQsJSR2J8rcTq1nQh+6gp8OGi1pXf+wNcg0XpzYe7W9q2wdzf0og8c
         6Hw6hwMAQv4C/NUmd2p5o7h0W/HJcLyQxNjNypNwYwraAzbc5iOry2hra/XJ9B8b0/9J
         PzbUjj6PfNv7Tojl65s9v18xpMJA/emXjrhk26OISyVxNqUyw7gQeZpCAEi2kFzUjxMW
         Dwqw==
X-Forwarded-Encrypted: i=1; AJvYcCUm29L+2EGh/CX3Z53il5+NyoCG7n/qq6wvzPzrzUEnUQ/AX8FUvUwcKYe61l3bdLntOBP9y1bVqa11mxnAQ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vPQutV4Cm+gb30mb3mzTAZT4ngHEOrYIOVckWSZ2DtKoWNGJ
	LBOGbfUzQET49XGHuOgoitnbaTpVWWXKE6mRoPf1AVCJ/HVFhLF1kB695PpOdk2NMGU=
X-Gm-Gg: ASbGncso0tQr6TS2UJ2aELjwHG1CNFB1c7M9GkjgEYL2RG12DRRM0vqKbF7Y8EJFSdt
	i/aQGhXZLRGQNL0zmj8WdpxciC0MU0to7F+B1WC2QS+gUI0RlgtbOzxzOUwYd3Jd3WHo4r95bks
	1I/CL+Lyma5X6B+mJY3AcGM7/UWPo71oR49UdAiqMvX1MpDCLKMmhPXCrljffMriDqQYVmDoU59
	CIE0TnOZWkAz50KJsfrMGZZeDk8Vgq4VD+7lwP2hcYe0sX/19Fpcs1c3UeO7fslZXHtALLXLkz3
	8EH8EyAoJo7NnLlJiU30vp0Atk6NLg8EUKHd4rct05cKegoRt+kyDYrkvVTRFbMpFfJ6mOkPcuP
	jiOt4lUsiSA==
X-Google-Smtp-Source: AGHT+IExPgFei+2P+PVJukxiS3aE9U+PHRfpSN5B4qb4zFW+/87BEDL9btqRL9zzd7hz7A0oT7z89A==
X-Received: by 2002:a17:906:2c1b:b0:ad5:23e3:48b6 with SMTP id a640c23a62f3a-ae057bd6e23mr1051197566b.45.1750696421104;
        Mon, 23 Jun 2025 09:33:41 -0700 (PDT)
Received: from [192.168.1.159] ([213.240.182.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209349sm734281666b.152.2025.06.23.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:33:40 -0700 (PDT)
Message-ID: <613f2812-3c60-41fe-bdd3-fbe8ea7eeb69@linaro.org>
Date: Mon, 23 Jun 2025 18:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
 <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <2d3ff07d-1cd8-4eb6-8b3b-2d0d6f64445f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/20/25 19:00, Konrad Dybcio wrote:
> On 6/19/25 4:55 PM, Casey Connolly wrote:
>> We don't know what the bootloader programmed here, but we want to have a
>> consistent value. Program the automatic input current limit detection to
>> re-run every 3 seconds. This seems to be necessary at least for smb5.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   drivers/power/supply/qcom_smbx.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
>> index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
>> --- a/drivers/power/supply/qcom_smbx.c
>> +++ b/drivers/power/supply/qcom_smbx.c
>> @@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
>>   	if (rc < 0)
>>   		return dev_err_probe(chip->dev, rc,
>>   				     "Couldn't write fast charge current cfg");
>>   
>> +	rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
>> +			       AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);
> 
> FWIW a random downstream clone I have sets 0x01 which is claimed to
> mean "every 12s" instead

hmm I saw that too, I think more documentation would be needed to 
understand this properly (I'm not exactly clear on what this actually 
means, when the AICL would re-run, etc).

I have reports that this works ok, so I'd just leave it unless we have 
info to suggest otherwise.

> 
> Konrad
-- 
Casey (she/they)

