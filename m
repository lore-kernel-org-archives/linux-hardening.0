Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C12F39AB
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496187; cv=none; b=hK6C+N8o3plwOvZ7bgFF+XQz0xfQjFYoJB3h4WbYQAzHj1jjE+ki+O/aAUFv84gKDXCZQ9+tzz3doJRTCzHoLVKZkYFIfLHH+F5aIJ3dmsYTt8UXDB64QNJPCSyeFeDdadLkvNJFLnhYn8ckH0uacbMYR7Hu4Pd4VklhS9sR9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496187; c=relaxed/simple;
	bh=w0okaFhRI38jPOXfvOe7745j7gtMsdJt2nwM9DZt5TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLfm19a16bxtVFrtgAD4lZ6ByyNRLrQ8qebwhIqEopxZlLQGzdgihXrwgOsqbzcgkgpsExOOjkIjCSrbPvtO+LAXbg4jp6G68BdKClxHQ5kMzg6DbEzIxb1rjKimdzF0opPTHX4HwAHKQ5o4PjIOpKhcgLfLERuzxXXzHb/oDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6UkpHf7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6UkpHf7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43767807cf3so577487f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771496185; x=1772100985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcSCzwxqg7VWiur4dwM2dEy5lv+NIQcB10C1LX2/4m4=;
        b=n6UkpHf77W0SruUKqA3W4jRm5DrjGtCSIWH7M3IioQs4An+DD9DsS1VM9INOBhbIAK
         OO78lmnYt3ZcKsZ1An31eCytLquwqM535WxbcvN8qBwuZ8GvqHx/PUwioAzGKU0GwnIF
         mJajMsmYkLisFB20x64vdKgW73oksxZy5Z5Fzy+ef9sIHb4HbXdXbopaMloDkLDRXu5L
         wkn/2sIuIH4ZPQOQGnjFXt7iPZOFZ5ZZqit72Nq6MyMR+0eyOtWS+W8ccMHHONuV3G9G
         sd10WGDqePgOZz9+YnKJmfY2cn6vdnPNqir/S/AgKN1Ea8o8nNK3BPiiVU40k6eu/ljE
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771496185; x=1772100985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcSCzwxqg7VWiur4dwM2dEy5lv+NIQcB10C1LX2/4m4=;
        b=Y+5HOwfO6VuJLlFi7UDoGGkZxV9dfCgvVAMNpEc/PLL6XLJnxfs8pt5MfGCvI3beuG
         dexBeSt6AJOOqzsUScFAqdV+JCieuWBkEK/wdBl0hTIMxPB4rg5z6eicCbOP8Uz+sHYk
         M6VJrQFc7YGSLqxbBWwUUu0o/jhfNC7c1Gc+V6ME8XGqW7XLp7Xpo/i23Wvni6R3AMW1
         iKdE+ezOe5gKfH/Gz6Qq6kzBH33YPX1GB9p2duddFLhQ9gX+bM3QgIrXQ9CTxdlKlszq
         DnP3+3ivdIIItCzd5Gt1ubquW+r8MIEESZLhlNkqd4EpCB0XpfkLzYxlStTfEsQIt76w
         6Glw==
X-Forwarded-Encrypted: i=1; AJvYcCVkNPHNpx6mPKd/IEU311fkJJLr+VisHaxZeV8hMhqD+dFDamyyOo/4Bxyk/e6LZdAY9bA9AmlzTIOj+NecvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZE+wtGFpfLMy72NFifyXmFtzJNm0U+fZLNPhs6Ba3rB8qL4x
	++tD0zmScWr7DSt007OUvqScX/h5ObpZbzCLWbJUBpXzNwweUlG0O9tBXeBITv/TeIk=
X-Gm-Gg: AZuq6aKqubwWSnBUuVMNyTMiDVJUFeWQ/wi4X0bZYLCh780IjISRVuYIhDsD+zoBxx2
	drSNxH/0FY6Fhah/DUISGSVhfJzfuMNUqVkPkXi8DR5R/wrctSoVQYu8e8O8TQ3rkba5urKubk9
	iBfSg95u1Cv8KXPx+qkUXJ+LTV/kfLp6gnvAaI6XliRuhhHO//rbDNRoa4uPzYKuxvgQ63pzM+v
	k2ls02UxIjT37wPDboRLsw6lXTsPFwLwjNcTyT3m1SIIU2o/ncM1ti/WBCWSYAdNHNOD/bfiqik
	G4Vgopw2X5b+Nlb79GDlht63hyGZthWtBEZQTsjoKJ/PnlNyhoQ7ItICP/j/IpsII9BfXR30Anw
	5xnCW5UD8c0EsomOsSPz58BY7phd6ssHB7sdCqyDe4NrEVwulScSDN6NLZk9xFYBsyhXtAb6J7c
	9GITauNr2oiU0SS0/jmBLzjt70Z+kujKdh
X-Received: by 2002:a05:6000:4305:b0:437:68d5:f167 with SMTP id ffacd0b85a97d-4379db9859fmr33226037f8f.44.1771496184734;
        Thu, 19 Feb 2026 02:16:24 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm14050703f8f.36.2026.02.19.02.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:16:24 -0800 (PST)
Message-ID: <17020b22-6e80-49a2-8890-b16917586b49@linaro.org>
Date: Thu, 19 Feb 2026 12:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 1/3] firmware: exynos-acpm: Use unsigned int for
 acpm_pmic_linux_errmap index
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
 <20260214-firmare-acpm-counted-v1-1-32af5735470e@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260214-firmare-acpm-counted-v1-1-32af5735470e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/26 2:39 PM, Krzysztof Kozlowski wrote:
> acpm_pmic_to_linux_err() uses an unsigned integer obtained from messages
> as index of array to map them to error codes.  Array index cannot be
> negative, so make that explicit.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/firmware/samsung/exynos-acpm-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
> index 961d7599e422..44265db34ae6 100644
> --- a/drivers/firmware/samsung/exynos-acpm-pmic.c
> +++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
> @@ -41,7 +41,7 @@ static const int acpm_pmic_linux_errmap[] = {
>  	[2] = -EACCES, /* Write register can't be accessed or issues to access it. */
>  };
>  
> -static int acpm_pmic_to_linux_err(int err)
> +static int acpm_pmic_to_linux_err(unsigned int err)
>  {
>  	if (err >= 0 && err < ARRAY_SIZE(acpm_pmic_linux_errmap))
>  		return acpm_pmic_linux_errmap[err];
> 

