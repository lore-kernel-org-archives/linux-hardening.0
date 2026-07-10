Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B353C2782
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719667; cv=none; b=mFkThvQcPUh2xw6bBz8wSYeF1QMlsTgZsZuryihE6IdSgjDfF67PkK8EaBa3jYqQ80QGHbiVfksXvuMXCWETKuNNMjaCmRlSbAsx8/1sHaqDT6eJN754RU6tgvgkbaViFjojOyrES9U2nXOlKxk34A2d68MzM6+msNFc36gNYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719667; c=relaxed/simple;
	bh=sRLsKhX3nbX3ip0h+lFJX6a9doiDlrP1aVmvc5UQZsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdio8yjTdr1HcfAtKT9l8ItHk3Grk+ddLJd/pJn693NjPK+xmEcbGYaMDHqBONSaENFToalnR8hN5MxskPMugRemxFsPaPBxSQuqzhC52x3cvE6MXTcVu7ONWKaCzLLwrVOxZUlBtNDwL7GIxeu9SRTxM8YRLf4SsHNiHh0exCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7RIYxd7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7RIYxd7"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1368114f8f.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783719663; x=1784324463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98z+F18zm2o1eM5nkxQ5VKYEoQh7CpUJdp3ti2B74Ec=;
        b=F7RIYxd708YM3jQHsLdNtcVcoZ7aOviKcVmkiiGo0mw7fvIMpGl0CsQgrlft/cOoKG
         kSxqFPAhQEDSKD9vtdUO3nC8TR95bDPsIkFAJZPEzeKXeLh6zN56ERp8njtiz0nSwJLV
         rFDjyB0UhTpMquTModkqZZTPRT8CKZ6o/8cq0vORdwFq3+SxTucffQf5BWaSl1Q+ChcT
         3c74Gxh4yEFqLyla7jImI1NifWzRXT0u8zNHNGUMFntD/kF4BbVw2BZ5FIuqrMae5j9Y
         OOn8SwEYz1BCFmSSeTPf2aMLro5JZ0hBakzJ2mCcNneCI2K82MuGjRldftO5ZY+sZ84q
         SMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783719663; x=1784324463;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98z+F18zm2o1eM5nkxQ5VKYEoQh7CpUJdp3ti2B74Ec=;
        b=LaGH+jes5Y0VghEEmw+DgvHO7coLiArmYxJrgIyAV1LRdU0DjiERRnUd8iLN7/Y/OT
         /aTIMGabilTpczK31ljE4QWakEJLJ3eAzDnujSWFvw1VBh1L5oEZqdnKuHip+jCPDAHx
         vdyHQ36W9inyU3uVKv6VoLJ2O5Rey2F4+51t5D3Hbg5Sf0xpBx6M6tGIcnx9Ga/HiS1B
         wqIPEEv3pYtDNNTuezQIQjdI5w23e6Atpr+kzK93OfUrF5U+FB07EeoW1jHHtdg5TM71
         WZVgCSBAOavK5XHcYv8FJwYfhc69Fg4Upw2/0aupsKbfyxeQ26PfppggFG1WyiwiBoft
         m9aQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrow/R/bgtsXo2e0CmqOSFCHznkgzSAs2XBmVgM37eSI+jY5+ASM4GQ8WFKkEH8kRsAJvR2Ckos6DJuITLUdwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWqS4D1SvCLv4chSMKxGuPJLKMIOdE9CchbriTafG5KkWBmtI
	lZFs3adnlTc0UKJ/rUsRh52cu+GYd7bdxJXW28H59WswQ0mmzuPgG0R3QL1D7zAnKk8=
X-Gm-Gg: AfdE7cmjOi2DYUIgII3jrP2CRKv6F8EBhYjNctIDF96pu5tio2pnTOo9CXc2yJvH+Tr
	on4A0ZRGMeaOLnusCC7F03kui6VVKbFNLGDiewRnQ8c8kKoWFnhSvOrY8DVrTppCG1RSAnJMVeA
	azbOuBgdLz6MeTdZerCE1z8MElhwTG2qKsONgp8dTJfs9azUz0kcEp1Dr2E7eAJHRmOLunXSfeC
	SD2h9PNME9t23mvV/qgJDbJaAC8QcspFWEHvm7xHNVTGvujV69qEYJP/WBBp+EDIXJGPkRbTzx9
	T5/Zmpi/w7krXhIAoZzrsESoa+b49U9D7xfq4RAQNzK97QNeFuItzRQVBDHhR1U2UD+btn4bL+W
	fPlm1CwngDP8q/9qK8GWxu5l/vtmbOqcnBZhm2eXDxCigTYvglhl409HFikhXrWuQ07xstLWiWn
	LYTSdKdJDGUF2x2/99v4GhRaGN
X-Received: by 2002:a05:6000:4284:b0:477:b22:488d with SMTP id ffacd0b85a97d-47f2dca803amr471641f8f.10.1783719662677;
        Fri, 10 Jul 2026 14:41:02 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.243.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm65817946f8f.21.2026.07.10.14.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 14:41:02 -0700 (PDT)
Message-ID: <54d76244-8ba2-472f-8577-b5d445d6ede0@linaro.org>
Date: Fri, 10 Jul 2026 22:41:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] media: uapi: Add CAMSS ISP configuration
 definition
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
 <20260710-camss-isp-ope-v4-5-51207a0319d8@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260710-camss-isp-ope-v4-5-51207a0319d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/2026 10:04, Loic Poulain wrote:
> Add the uapi header camss-config.h defining the ISP parameter
> structures used by the CAMSS Offline Processing Engine (OPE) driver.
> This includes structures for white balance, chroma enhancement and
> color correction configuration.
> 
> Signed-off-by: Loic Poulain<loic.poulain@oss.qualcomm.com>
> ---
>   include/uapi/linux/camss-config.h | 161 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 161 insertions(+)
> 
> diff --git a/include/uapi/linux/camss-config.h b/include/uapi/linux/camss-config.h

Why haven't you based this on the HFI stuff I supplied though ? Its the 
same hardware right ?

---
bod
