Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2433D6C7
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500014; cv=none; b=tkoZEj6ZTvBDxvbIqbwyL7yApRsQMNXQjBPuEd1SNzJnYTjkgxIhHtcaKgMZU+BA1PQ2AjRQzLcit77jZdOaGC50lovs6DTnKnPJiLWjp+AJAfMJbV0jZ83EpdK0ckm2M1G9n2fHYrD2e0rmwWeGnTbPMlTSO5mFczMphOEDKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500014; c=relaxed/simple;
	bh=7SI3pNlFJcJxczuftGfGka9em3SqZ3kPpBvA2zpQvVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3bPFbZemoFRJm1wWKPN6iuB9EgOdfOjyGH1glQKNuvzpBm1Qrlz/cExsp8ohQbwdiJ6T6o/oO6xwc/pCikTJ9phPo1OUeD3GdGzk1FZacvI+CVa28RjoDgupcv0CKcm0Lvbng4L4KlNrsQ3bnIINUf6VANG3EA/8rqxtXQsqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9FEC5od; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9FEC5od"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43590777e22so497421f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771500011; x=1772104811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gb+ajUpfigq+RIG2NV/9p+NS7XUIm6gYBjHjGxo/4ws=;
        b=X9FEC5odHAVc2DVZXvzhdl8eZoJMejMRgziz25Maus0y1jwkgPHthw49/xpKZ/nYhB
         9CyMOuAfPRbGg6CMOmcjArsS78yTqmi1yJUuQoxF9H2m9OOIQwfhOGiNz3incGehX3GZ
         iVbWrRHFurta1FRBwrtRSzTSsN/9OG8qyCO7+fR8M/Xawn7bEGIMPynR9mexym5f2yyQ
         sorU5uTxI8K5PK5MYHN1g8st89cetIRJ40Pig5hkUAzYok3ecPiaipytfmgBzDu4Ej0w
         wfiQVivGe5XcoFd8jcWTbf3A51ZLT5lQLjywJXZoWjGI8wLa1OrQe+M2vA6I/3ZLC1gD
         IxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771500011; x=1772104811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb+ajUpfigq+RIG2NV/9p+NS7XUIm6gYBjHjGxo/4ws=;
        b=V+I7pPThOG1BE6lsR2r8fDopyJkVIWuWbVK3Gn+y2jk8FDM6iJO1gMxRDfyJc32deM
         5NDFPPzzrrKQ/cZAFreSB+SGT6V2ZOJLRMd5q1OvCZhaiRR8gyulcNUg9HzqyZhaRTlg
         EeiC06FD90LCKzYutFQhijso3Ec/B8/MITDnHccDa1Uv1CVHpCr5RXAkUUwRh/XouXur
         cON1WxhGVsMqI77m5W85HFEIhRStdu0rl1ypWYUJnSIM8Kh2QNV6XpeftQ/9p7Uo3v8e
         NQLXrWdiuDOtcG8vRKqxX9HiV5EG7b6U+JOMVhh56dla7Tb8q+j04aGsHRhgyc/XqT98
         MNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVnc7BUhhkdvvkG5g2h6g/djnDC1WTtTAy8zKorklp2gx+l4oZa9WyiGHm3SSsZCxXEmfw9Fv3MmlyeEV6LeKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdxqCJI+ldBINxhiTO8Gzi0EiR7U6G2ygNRninANPwxPTPfQD
	ogA3Expu7TYMSH+Z9zXjXQ/0Yov8SCNbOi0FL0UqUsyNnF+pHF3qu7RslXYmbAPtov0=
X-Gm-Gg: AZuq6aIsL9yA7B+IVIJBfrs7kGhWJT77/a+78no1mi2eTRGurEPzSAWMOIo9hO036Tp
	SXxG4jxObttDl5FbHN2CaQYErQetwCC83KTIb6KzwU5VsHK74EkvKozkd8J03I1ybB6TP1gZ1+S
	hWOQR5EKe3VDxSfpYDDnChYNiS496sJ5g37co2XJfTMPa+FUVqvVp7q25cOWPUZowujlVnMrWTZ
	QPunMPVGJtXPM8cESOqykium85+F75+prAXIx99bLvlfxqv3onzNlUZO4s0hS7IdK2SKSTb2/ly
	6V5wBgnju/iROASxEYHs9h7b5AigrASdFcxriwKcXr52pJgCaMgbVCjzH4P0MuFvFMid49EFMVm
	LGCKhG44e06WPe4UOOfrQJ0RxSTDi0ZzA151M7URpw2BqJUklHNtbaaYZBDS+CNI/I/05Z/VKS8
	wUUQ1POjyWf4O6sJ+klUwkTQYTBDT5//3S
X-Received: by 2002:a05:6000:144b:b0:431:808:2d58 with SMTP id ffacd0b85a97d-4379db98611mr32771301f8f.51.1771500011417;
        Thu, 19 Feb 2026 03:20:11 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm51473650f8f.27.2026.02.19.03.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 03:20:11 -0800 (PST)
Message-ID: <47bbcacc-32be-4a64-9ce6-9b441622e84e@linaro.org>
Date: Thu, 19 Feb 2026 13:20:09 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 3/3] firmware: exynos-acpm: Count acpm_xfer buffers
 with __counted_by_ptr
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260214-firmare-acpm-counted-v1-0-32af5735470e@oss.qualcomm.com>
 <20260214-firmare-acpm-counted-v1-3-32af5735470e@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260214-firmare-acpm-counted-v1-3-32af5735470e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/26 2:39 PM, Krzysztof Kozlowski wrote:
> Use __counted_by_ptr() attribute on the acpm_xfer buffers so UBSAN will
> validate runtime that we do not pass over the buffer size, thus making
> code safer.
> 
> Usage of __counted_by_ptr() (or actually __counted_by()) requires that
> counter is initialized before counted array.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> __counted_by_ptr() actually maps to __counted_by() for clang v20.
> Alternatively we could introduce new __sized_by(), already supported by
> clang v20, but it is not available for GCC, AFAIU.
> 
> RFT, testing would need clang=20+ with COMNFIG_UBSAN and
> CONFIG_UBSAN_BOUNDS enabled.

Tested cpufreq (ACPM DVFS) with:
CONFIG_CLANG_VERSION=220100
CONFIG_UBSAN=y
CONFIG_UBSAN_BOUNDS=y

Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/firmware/samsung/exynos-acpm-dvfs.c | 4 ++--
>  drivers/firmware/samsung/exynos-acpm.h      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
> index 55ec6ad9d87e..a4864973f65d 100644
> --- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
> +++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
> @@ -24,12 +24,12 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
>  			       unsigned int acpm_chan_id, bool response)
>  {
>  	xfer->acpm_chan_id = acpm_chan_id;
> -	xfer->txd = cmd;
>  	xfer->txcnt = cmdlen;
> +	xfer->txd = cmd;
>  
>  	if (response) {
> -		xfer->rxd = cmd;
>  		xfer->rxcnt = cmdlen;
> +		xfer->rxd = cmd;
>  	}
>  }
>  
> diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
> index 422fbcac7284..8392fcb91f45 100644
> --- a/drivers/firmware/samsung/exynos-acpm.h
> +++ b/drivers/firmware/samsung/exynos-acpm.h
> @@ -8,8 +8,8 @@
>  #define __EXYNOS_ACPM_H__
>  
>  struct acpm_xfer {
> -	const u32 *txd;
> -	u32 *rxd;
> +	const u32 *txd __counted_by_ptr(txcnt);
> +	u32 *rxd __counted_by_ptr(rxcnt);
>  	size_t txcnt;
>  	size_t rxcnt;
>  	unsigned int acpm_chan_id;
> 

