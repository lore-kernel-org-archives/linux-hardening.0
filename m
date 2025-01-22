Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCC212B14
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547209; cv=none; b=KSQypXwiYb033Le7b91WDVWjsHT1boKcCofPSqIeV61DtnuTksGtdzGTkdS/x5jtVV21B9eFARbrNhg2elJ5FwlJhnp4gU6Y5yOa3lETqz1hHotFWczuNjpd5UmZM78WnTKrUgWauuuwFCgpuLsKqk4a4useeoWNllAAsWfT4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547209; c=relaxed/simple;
	bh=JTiiUwfpur2s7UQ9ZRJEQTwGRhl0uvMOuAxGd3wUPSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELWvJnGo5l8yyHCP/YL7OzYRxBQKF4xWG3OU5Uh1sYS3iyHHnbNhWSLlCCcbAxHWap4buB6A2+oeGNyLNJqbYFMjfB2P/xGFHh08dIqn5iODPEMgnUiMiE7AHwxHJ/vzy0ewHiytAd8pWGuLx5ADdSV6wZIgcyfKathmkG8sW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCg7WSDF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCg7WSDF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso5522481f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 04:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737547205; x=1738152005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emPcfBpkB0Lpj8Qvfx5eQdF6Zl9UkKOkQ2t3+yyNddw=;
        b=ZCg7WSDFyFwu4+FUWjXCa3UObxgyfezONcaqhZS8zPtBXIajt8vV+rXKAW2eOgSifJ
         lKjqS7RhNATqGcf43yilOACzh2hKAIuu8cX1H5Js4NDbO/C2nWWgc0MX7QHHLPP8DGl+
         yW74KUXTmgLNHdjd0N6usyT3y4JyNtksZ1veAr0gPx+BB/5SGoYIHEqRU9bTA32kQg3k
         8CRtFqNtPszixjmMtlys2K7AROZqeuUFSfuQVHakbNdDz+q2F5rZ9s+gRrQj/prb8of4
         +bb6+CSyoTWOA/NxEkTkFkMGiqmI6vgpzeUvLQ8ybz5xi/HfcA0AenlM8A365s15LIIz
         RnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547205; x=1738152005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emPcfBpkB0Lpj8Qvfx5eQdF6Zl9UkKOkQ2t3+yyNddw=;
        b=CEGMSZNiROhPrxCRj1dwTnsyHtfHAFzpF7qXtJhc5AuinCFcAy2N26DzKg+EU1cqJ0
         J328gBQOWU+HRdsq1hAe/faQLG91j9RUXyAo6tewaOuupEJYgdKhVverFTFYKKry+hkw
         Mp084bKEXsws7EVYcPgo20KCW1EQcnGHpAlsN9sUatsU/aZcr2HNaGI9pWz/qOawWeIB
         +4l1kiy16NSmynOKliNFUL/AtfUp1MebXDe55Vcac1TRoiXp8pMEvWdbxX0BMSHIQGZP
         WnZnp/OUggpEhBookG4Q5xniRlqVLo5/nC3mHRChy+B66NU5renuZVk6VP5LwYLHuZ6e
         eARA==
X-Gm-Message-State: AOJu0YyX9uyoMZMxLhQXGxuicQqOOckhjMYrtPoHq4gfFiTQsGyNCmCA
	LBw+IcFGTqJ6UA5bJfwRT3CyZaQtPD9W2AdlK9sd9Mp0QorLtoQBEnWu01D+Srs=
X-Gm-Gg: ASbGncsoD1zUuAOzD/oHiUtgs/BwxMxzAWOyOu7Gd/CC4UavKNLS+ZEc9PWtwVLMB5s
	J4M+fim22jRXOhUPwfK6prrrsJjfSW493QXLz0yM9NMoc9Iq66/QbiPMIrEN+QFGuRI2PJz0cac
	p1qB1bNhEHBkJ4Hl8kXdEFiLNeNpnbI9n04IaYQ13xV+jBx2Cl9UY2CQeYSACtgWSvQ0YNL1zV0
	3E/meHwm1jZW9ixDXM6WDWjz+aLxdTCNtoJEg/b9i7Z6mXsZ4DQMQzARJ4MYfyhhSY/jBtULHNP
	mQ==
X-Google-Smtp-Source: AGHT+IE16r+ket2E8khA78y776u4bFfWeCwwvrE4JU1JIMZM6fCMmM7k22jAe/StCejERkA6nSlTqg==
X-Received: by 2002:a5d:64a3:0:b0:385:f909:eb2c with SMTP id ffacd0b85a97d-38bf57a77a2mr25500383f8f.38.1737547205415;
        Wed, 22 Jan 2025 04:00:05 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b3124a14sm22189545e9.0.2025.01.22.04.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 04:00:04 -0800 (PST)
Message-ID: <8836281c-e6cc-4731-9f97-dbd97fe0b0fc@linaro.org>
Date: Wed, 22 Jan 2025 14:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore/zone: fix return value for psz_init_zones
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121150617.608118-1-eugen.hristev@linaro.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250121150617.608118-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/25 17:06, Eugen Hristev wrote:
> psz_init_zones is not supposed to return NULL. It returns an errno,
> and its caller always checks for an errno to look for a problem.
> If the caller receives a NULL as a return, this code will go further
> without any errors:
> 
>         cxt->kpszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
>                         info->total_size - off_size,
>                         info->kmsg_size, &cxt->kmsg_max_cnt);
>         if (IS_ERR(cxt->kpszs)) {
>                 err = PTR_ERR(cxt->kpszs);
>                 cxt->kpszs = NULL;
>                 goto free_out;
>         }
> 
> Later, when dereferencing kpszs, a panic would occur.
> 
> Thus, to avoid this possible crash, it's better to avoid returning NULL
> in psz_init_zones, and just return -EINVAL if the parameters received
> are wrong (in this case, a zero size request).

Please disregard this patch. I found a case when NULL is being used
meaningfully so I have to find a better way to handle this.

Sorry for the noise.

