Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB33132C15
	for <linux-hardening@vger.kernel.org>; Thu,  4 Apr 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259707; cv=none; b=E8gGCWE/slSJn7CzMFZN8BiFmL47ZBNTSMELgoSoPkvB2CPu4cA9fN5kwS6mN79Ss1UmJqq3dbh9F1LOTI27yZbxcTy42Ag5857hImXsjm39j9xtUTrFA98NlllLCTGQCqFl3bmBPZoEnpx66o57bet2XNBouAjX/IsGCcJjseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259707; c=relaxed/simple;
	bh=aVZcAkeixF4g7qxwWjpSl0cSU4/81MEvk4V1zf7bPjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoYfOh0prIOkIeAMWBMXQbKrcIy7ruBZQzcM4KXjL5FKgjoNThEwHFVqeKrsX2ec9krulaBm/FwUsrPDi82f2zcNgOmcDgB5rAmRxWXd1RFhG46owtrdzcQh+YA5uZFEWGT5CWNPXmJZ+ek0F8PzKwRwY4SjXM76sgTmsn8cVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgUfQpuO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgUfQpuO"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so23875241fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 Apr 2024 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712259702; x=1712864502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk29yQ8J33vjFT2n+Z8izmlALMtAMOY/5K09yHLiz2A=;
        b=dgUfQpuO2Lq9sV92pw61jzVuuIPlM7e7y8MVVel8u+SC99oDVItkYZHp3TJT0wgfwR
         z2u+Luc6nUbEIw06dKzbL1nkjVq/mKk13aW/eA+qM0kJyVoyxgwBj1JPL0ettd/+8mhE
         VGBcw0KnPisn2qLXRxvMJkyeEhsAR1M4uMSef3L9V+YkxQ9O94wCMOrMrlz7dFJuF9yg
         dfeDVcWA73X/3fy5o0LD1Qjn1CeSnC796/13ZkgGcBBtQATMD/I9Dw9OxyC7j/yaJtqQ
         /AyuraN5J2dfy+DnTwZnZsh8t08Ue+badnMTfzW2dqi20lmqvo9AlJYmGvI6o8D76l1L
         wgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259702; x=1712864502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk29yQ8J33vjFT2n+Z8izmlALMtAMOY/5K09yHLiz2A=;
        b=QGd56vOsY4ALpuUQifLNZnMzv2iwt9kgfpZuJjaOSMKkssNVuB4uOhmyATUgTMcNoA
         vnv6r00A1TCLrZSYlMUNwOXHs4DYlS+Jvtm7L62xzqCDUOSHQcyEJyxQzQha13yJXOyO
         cvGCHMGqDjfsKfscHN2Owa9NoADRB1S/f014zBuewCLkMRePBj5XeNQ1J/pir5C+T+Sh
         fSSPpkE1KtY1TWYqo4WLnvU8T4zukbefiJEAEmnWgEFkBhog3XFtZVFNF/fIsVf+MaLw
         fEcRvOXYY4Daondve/DAqTHheQqSu1qVrNqfT513qNPLA7H8WO45VDrJnqG18Je2CJf/
         MY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc/sBJzt9jWJV4jsKs/q1iaOT0Xez0/tZWOJcDBQ9jwD3dDip76HPkRawWQ47DTzh228MH93RM0nrQtLl8a7mOBxm42TaYsC9X1gstfp2U
X-Gm-Message-State: AOJu0YyMU7mAPNL40RSrTrEuP5k/eXFNgf/jq2sGRmTlnralNItUcuJ/
	bF7817wKhKhe2wrqjhqdejE7nuK/goi7tbZNa06VTAH9ojVCQ/NOZ4+Yr5e7jHE=
X-Google-Smtp-Source: AGHT+IGjdt8eK/21R8SNEkAuKUSS9YVD3OAhgQRK4DIdtp+I52YPNa8vy4Q5T+/BRUqKTzQAx5ppVA==
X-Received: by 2002:a05:651c:210d:b0:2d8:635d:56b9 with SMTP id a13-20020a05651c210d00b002d8635d56b9mr181907ljq.4.1712259702667;
        Thu, 04 Apr 2024 12:41:42 -0700 (PDT)
Received: from [172.30.205.19] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e844e000000b002d46be28dcfsm2239298ljh.127.2024.04.04.12.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:41:41 -0700 (PDT)
Message-ID: <8f6236db-0692-44c9-b136-8e0dff714c55@linaro.org>
Date: Thu, 4 Apr 2024 21:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: Add SM8550 Xperia 1 V
Content-Language: en-US
To: neil.armstrong@linaro.org, James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-7-fda0db38e29b@linaro.org>
 <05e6f92c-388c-4bc6-a4cd-e9d981166d1c@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <05e6f92c-388c-4bc6-a4cd-e9d981166d1c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/12/24 18:26, Neil Armstrong wrote:
> On 12/02/2024 14:10, Konrad Dybcio wrote:
>> Add support for Sony Xperia 1 V, a.k.a PDX234. This device is a part
>> of the SoMC SM8550 Yodo platform.
>>

[...]

>> +/* TODO: Only one SID of PMR735D seems accessible? */
> 
> 
> What's reported by the cpuinfo pmic array  ?

PMK8550 2.1
PM8550 2.0
PM8550VS 2.0
PM8550VS 2.0
PM8550VS 2.0
PM8550VE 2.0
PM8550VS 2.0
PM8550B 2.0
PMR735D 2.0
PM8010 1.1
PM8010 1.1

Not sure if there's only one or the other one is secure?

> 
> <snip>
> 
> With the pcie thing fixed:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

It's gonna be fine with the recent aux clock additions. If you
have no further comments, I'll happily ask for this to be merged ;)

Konrad
