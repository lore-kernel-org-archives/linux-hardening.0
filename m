Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DE269CF1
	for <linux-hardening@vger.kernel.org>; Fri,  9 May 2025 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771946; cv=none; b=bQIsRfINuCthLfKO5YVo/7qxDrL3fl4KYLBZrRzd7Z+y7vaJNmcSox827FILeXN39DFbw8wTZag30pQErsn3qtrscZEL6z55ViXKWWnBHnQ33vI7OtTAJLOLCOdq9No7KLNV2xvduOghovlpXkLB8qWAIu3n826tvsXSqs9ytsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771946; c=relaxed/simple;
	bh=sT78nN+pkguiIepeHcI/OhL3YYwqizIKDFZ8qkd6c8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePdV6ZeGMHEKLIlTCgZEVuTpFsn1HGV6iXkq9tF5CIx11uX3wl2rpB2GmZ5FuzsN7DBU8EuthVIgTRElIKlcyy9kF8YOn+cUQ4cRL+TrcKjQvp/Tdwo3xxOa6JCsY1snuEQLWTYaz13uI4kgJ3HMGmod7EU3ekogTOF9nC/q4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wX2BB27V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wX2BB27V"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so244706566b.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 May 2025 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746771942; x=1747376742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2sBRlj94okcxqPX5H1gKCJTax9lnG2hxBuhlKbj+a4=;
        b=wX2BB27Vx43IPn2aYK0lKLCtuCYeGDal9fuuR+ZZd9vX3WnekUtbFpkDYMBDwkdrFF
         1RSdMeNVicaNWzy8Sdh92oUk8iYdEixVdxbWDxTTHHpvY/V12+fz369NgojlyppkayjX
         MKkmLMeSY35587rMLQOsHIccvcoWRiVXSsW2OdCct3FIYcg2RWepxGcS+myeZTJBxMmE
         jIB+iFiJJCcft+YiaAf4dghTa7DOMHEjESEeLPN4S5uRkJSZd2HNvIc97zFApPwNohSe
         UvWJfxuTnt3LZajz8iL3UQ+XKLaiQVvJBmnWLQ15XkGy4THz/2MazC9Jm+9w9QJbbEJY
         VUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771942; x=1747376742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2sBRlj94okcxqPX5H1gKCJTax9lnG2hxBuhlKbj+a4=;
        b=ANxkFCcVXKJ7iT2WfOziWhRGskpkrXIapzWdgT7rTIQO+fjgjIWYNsknAStLJPH1Bl
         nuBHtyvdcCm5ZrZGhsSLmKFkUB1GuYDPOaQlEZxjGDZVPPkuZTyD2tGLrHT3zScOkNC/
         +w8E5PXlGzGWSMyMDjpeDZu/Gk9MW+gU2qndaeKAvwP1lMTGx59AO5arnM3m/enz6gGx
         5Bqe8LOGrfygR8pQ6PYGqcJOMPbnyKtcAPyZ7w0cADOba3wvg85pflqp3L2gdEZroqKz
         sAJw96Jv9v/Dh6PFbJQWGA1FxVsLRrSPN+yEqJblkv8j0gDY4LJTqy+uPRcSxqbEtMxd
         9yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6a/zbJpMZZsX3fSXbE5GVSRLcZODyVEL1MxLsIVf3QxuqKqzniatnl7++iD9adqRSPZsHk/fqU8UiFTnar/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LY2JBZaqUcw0cML7Xy4ouPXRWmHMX4mVqm9C9gcjJlq7Iemh
	w7D5eJE+/WpRQcqNG/RFyuyrPwattqDZKig/hRY/qzElsM3BALhNXnAHeCXHZmY=
X-Gm-Gg: ASbGncsY0r5UR58JLcVWMev/lXQDBlLpxaqHeiMGJMfsBiRu5fFlAqZv3lLIwVkddK/
	EjpWIbyUKrq7p5m7utPJ/Fb5PRmXSx2D3mS8q4C34xPI+wN+4PXoO2OuZZPBB2/3ANU0BtLedeN
	CmW9oHV4WYFmaGfipIQyGY8Qa3QnKXJwBwA3JPtK+Zq4qNXcsuiCCnkpjostdqM9IKQOaQY+/3S
	0VCMaf0lqT+U39RRgc9dV1JtnMITjVnlgO48Z3v0AOLtoeZj/fi6e0iHzP5EZzJKZywAkDdGlQ8
	U7yEvO3p1xJ9JIftCgAkhcDVhrz1749ZQZ+pWou2c0GWki5T
X-Google-Smtp-Source: AGHT+IFMIuFKiOjLQ3eIogAmMtah9CU+aZgki/iojua/5RZ6ucOc6hJ3VkVi8yBlgIxrbQ2NIDXCJA==
X-Received: by 2002:a17:907:d9e:b0:ad1:dbec:44d3 with SMTP id a640c23a62f3a-ad218f79625mr256897766b.27.1746771942340;
        Thu, 08 May 2025 23:25:42 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd2a8sm101212866b.145.2025.05.08.23.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 23:25:41 -0700 (PDT)
Message-ID: <e03d3e18-9868-4896-a8fc-1443372c0c5b@linaro.org>
Date: Fri, 9 May 2025 09:25:41 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore/zone: fix trivial comment typo
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241224154405.295840-1-eugen.hristev@linaro.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241224154405.295840-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/24/24 17:44, Eugen Hristev wrote:
> s/conpressed/compressed
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  fs/pstore/zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index 694db616663f..a4ee4e04d1cd 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -43,7 +43,7 @@ struct psz_buffer {
>   *
>   * @magic: magic num for kmsg dump header
>   * @time: kmsg dump trigger time
> - * @compressed: whether conpressed
> + * @compressed: whether compressed
>   * @counter: kmsg dump counter
>   * @reason: the kmsg dump reason (e.g. oops, panic, etc)
>   * @data: pointer to log data

Hi Kees,

While you are at it, there is also this trivial typo

Eugen
