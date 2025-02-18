Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7E22AE42
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869921; cv=none; b=KkU85nzZZk8NjxFbIqdlutzpbzZ0U2uA0FnpS9nWzdiXNd/56V2NPXtdsLMfauorSvzfstOow6yMSwX3ie2XzVgBrgZORnMHaGLMGAyqdXLUqbM0UtkiYHY4OsRKIWXv3b84US2b4dwOVpoisxbgKoXEmL1BBhcTdvgQoZmEGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869921; c=relaxed/simple;
	bh=UzhNznqgAAuIcZzZPrJUtoMO3STF21152UGRG8HaC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuf3NQNgM119NrszvHh1x4IoaCBlUvTt99oVxBReCBZx7ni0IAt45k+dQCDWPXNIHcICTppLQ1ARyYRj7NOpHoV53rDpAgQ6L/CK0b2N52Lbaxor6LAHW9HdFV0yj8qBC016najGAzOdk03jTyGre2kDGV6Y9oOfzH3RYwPIepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guX+IQym; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guX+IQym"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so8616720a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739869918; x=1740474718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3uXTrr03eTBp4TQInaTHeB1lyJsdQisBIQEzz1BspM=;
        b=guX+IQymz6uDTHw8M8yrP85wM1puEgjhC8F5+CFOiJb4WQwjgb4GEfCIBQL8xUQknw
         kcpgvAYBypq9pd/p/7U/ZLY81HzUezgMuab/FCggH//Km/kKDB9ynoslCRKfam/ga/Gz
         4sER1E62Q8Kz6cBLghd1uAw2RGRFfom5TF3sLNy74OrZOqy//3mk3IIT+hwDk7uDq1o9
         0spohzSseEG2AUoUPL9Z2EyzE6gxADlDndIEQTKgGFEFpdXUUHotqdtfMAV8CPqtqBtI
         5Ca+T5xJRC1gtzS2Tz4Wv93xFIG1MTtH41hGf0jJbstEEWPVtgkOm9gbPwstjfZnJwBD
         ooJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869918; x=1740474718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3uXTrr03eTBp4TQInaTHeB1lyJsdQisBIQEzz1BspM=;
        b=XJLmopwO3ik5eXz6yu7KX6E00gm9ubX87MLU1OhxidKfN45Bo5uopEmYdsIM8v1kH/
         i6NTscF/AZjiG+RKtiJWi7v33ayB7RSZvMhhf5aNngSws6ZS7UGLB2mzVamHuy+i7hgW
         HzGVlhBrDOmgw5MFTeX0dBWN+YjQd773PzYzVSU95W0bq2ac6iEW6tEykOsjEougI858
         jSI6WL94w+8yHSOSPs/ZbjO3xcPnaCj8BVqT4i9yHim/RhKSAfkta36QYUIIgukLSy4O
         sL+eQrf0zj/6/yfkD1hCDexSwyRS/0KmaHelKtMTvqrh2jgRda/bbXbzjbsZe7plJFKP
         w7sw==
X-Forwarded-Encrypted: i=1; AJvYcCWr1ckyczbp3WI6wKZwrpU5NzJZCJTzBegUzoXIEFstT7S9Ck4jSQhNmUQz2SUFahbGg0SvOO+bYYZT9ZBV7us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAebBUq0vHRd2j9qx6BmZKn9DEDuGL5p+H0Ma31NbvrK+wMLy
	U0EIUZRiNuzto8xP02horK1pZSRhiTdFAPE3vUjmlwQ6eaWQu7qfM1YYpb7cv4A=
X-Gm-Gg: ASbGncsC1cPxQYqTg1YG3BpgLnkeCWFdcoCCZfOpCTdwyEAbu5i+BfDIiamIH58glx6
	IBUneCyG+G+efS+aivCnvMaQkNEa21WunKiBi5457Hel+7Mr05Okf2JW8ZWAgGIvmqPo4ZeQaNY
	AeuPC3SRPrBPPUVs4kjshDq5bzNLbFchMJXb8689NOUbs5o9jdMBxRnoyknmo1T4DB8lVAbn1sP
	qLGarBaNBs/yqT1RVS0ZlMtqAWzey+O+2Gpvr33Hs+X9NnfHiR5szUTGsUxcllZoQ+cSlJ5D92z
	733u/phZBLNJvGtEjBw0Q+Y=
X-Google-Smtp-Source: AGHT+IElObB+wPJH8ll7VWsYIuWeUZ3GQukv025YddeShYC2NXJtKepo4lLlRZ3MwK7mM+8bMe+zXw==
X-Received: by 2002:a05:6402:5246:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5e036055eb7mr13524262a12.6.1739869918369;
        Tue, 18 Feb 2025 01:11:58 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e076048c05sm924724a12.35.2025.02.18.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:11:58 -0800 (PST)
Message-ID: <e925a6d7-aa71-43cf-ab84-bed65b78cbe3@linaro.org>
Date: Tue, 18 Feb 2025 11:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 07/10] printk: export symbols for buffer address and
 length functions
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, quic_mojha@quicinc.com,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <20250217101706.2104498-8-eugen.hristev@linaro.org>
 <Z7RELnyWRLietj9b@infradead.org>
 <20250218-175733-neomutt-senozhatsky@chromium.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250218-175733-neomutt-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 10:58, Sergey Senozhatsky wrote:
> On (25/02/18 00:26), Christoph Hellwig wrote:
>> On Mon, Feb 17, 2025 at 12:17:03PM +0200, Eugen Hristev wrote:
>>> log_buf_addr_get() and log_buf_len_get() can be reused in another module,
>>> export the symbols.
>>
>> Err, no way.
> 
> Yeah I think we've been there before [1]
> 
> [1] https://lore.kernel.org/all/20230905081902.321778-1-hch@lst.de/

Okay... in the line of the purpose of this patch series, I would like to
be able to have the dmesg ready to be retrieved out of the kernel in
case the kernel becomes unusable (due to various reasons as described in
the cover letter). However to know exactly 'where' is the buffer stored
I would need some way to point to it.
Do you have any other suggestion on how to do this ? Using the
kmsg_dump() API works only if the kernel/CPU can run code.

Thanks for looking into the patches,
Eugen
