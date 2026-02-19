Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF304BDA
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502374; cv=none; b=VVRjC4c1QL+b36yI6437DuvzvNiPZhWa9GAb6YfM2YSwblaVn13S/TnJ5IsH7bP8V98Gw0XJi30cjLLRyc3U2cQ4Tywvn6WOjsya7HZPiq6xzrEmfEFt4BcIBnIoEYOqPRdwH1dxuoIJJIAHZ7G9EvnazURLL9bWE3+8W4fgTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502374; c=relaxed/simple;
	bh=jNG6NKM2obIk5OUBsjkkY3but/QE8iHDzB1+6teyTKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hylfdvj66FMYkQscap8KhA4vgoeHNNIKyLVbWYfdbHbm3Y4Ji+uT+VAKZGPadipTqdzmE+WVDlfLw7VoVpUgvLvEh1cihPzebkBlZqsajW54eY4DO71twDIDmsJMdVAAs9+qfukdc2m+plXyMMjLwIm0HF1TBF+S4l2zo1RwMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNtT3X/z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNtT3X/z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso9831975e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771502372; x=1772107172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmIgGmMzCzPMs3nWbq1Vj6DbI/moOSEXCUqKC+k5+GY=;
        b=jNtT3X/zG3bqhzVDjXA/iNN/yNQUuF0fndaP4qJcZgHQUdl1LpGCcGHdbUKr3l+H0R
         ceGprRXGWtwbNwFLsd7jkiS+AGUVaZz9pI7y1WKA2bEjAT9lg6g2LvEmhTA8igh8Nd9U
         zgW8a3gJ7Hte0fvupXFlHsRce7pAcyKLmqfZDLE5RlGymvjqpbaVsrR29VPHNodrheSJ
         7Zz9BwW2kQ4hQr5CH1eIT5sEo8M27mBzCyDB7k/l2mJtb0Wd+YjaPXhLG6pDU157G0vC
         9DSJE3NcKHqbnp3Ts7TCRurpK6Kc1NJLup2DUP6MobusROPDwgzrO3e4Zs+e+7Lu8Y2+
         yvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771502372; x=1772107172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmIgGmMzCzPMs3nWbq1Vj6DbI/moOSEXCUqKC+k5+GY=;
        b=G0xuh6d0bu08eAcD4D0EYFq7fy2/1ej/McnaTMQxyZ60T7nb77l6EjM5PtsLknSLI9
         nA/GdJ/f+/e0ZojabKVMH8+OijGbJW7PtdV+uj0n3hL0YkB4GgNLQauPPYYAZhjFDwHC
         Nb8T+efIzdozt2vSkc7dMiyOtUYydpLeTM9S/gpadh7RFhS7ZHXqQxhj+tMZMat7pkgB
         ng1XG0Xf3Aj8j2hsWoD12BRoaM1LDJU7XGNdVQHb607PQ0+3WrUKWE5qjSUiQbaY+ng3
         XDwcFCcvTgVhD7OKnyNC5qrcBHgJUqu3F9CcO9jzBRfraKSXnySfqe9IW9vK3ICdaZ67
         +Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCV6cNsEkS5uO5N8U6G46kMCZQ3iWhvzdu71DI7l2gJCRIb8S5rO58MuUPPKVCoGO0cR/zUfDI4KBXjqYFMkVWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEV2SoSiWkeSy4jnpMY6zQoIfljAb2uDMY+4GAtss5bcfv3mOF
	k9WMtGGxp15GdKzJn7qhOKV+tdcdAq8WrmOekdUV8De4xL5WrXXXNJt/Lp8hmy2XxRM=
X-Gm-Gg: AZuq6aIfpk9HhhNfFJvOyQh6r99ZjDzIWfwsKErQB4GV2fh5FFCMOK5mPMFleGtOJkS
	pLysFasQbH4xtLbD7+6QdWrcLuUwmYyQs4FPmkpKDv7+SNTjYNXez+m8iKbT3B4trPU2H90G0SG
	m8y8lY0eX5XGL6k65IXpK40DH5Z+iTTkdhGWSoraQStSkvZdixvZ2RKOKt1PgHZf8EMHsswm4uQ
	hH0Dl7gkRyMmFBYgl9HyFeh3adUQbHQ9NuleU0yndq0IsRc7ZlPXrnGC/WSxtg0MayAgVrmKUhE
	tfoD7qbtsz2l1ecy6Gn+lryTh0NBAK3skKmUKa4fYstKF0A2sF04ra88RB+s2DlISslEn/5w7fS
	w9R5YOJtA2FVyIb/6MN9pzVQvEeSRSvjmhrpuJiEmlyBKCVPStDWy2uFPdACgkU5kM2qUm3O2V+
	To+f+3Am4MVrQLsfYphLcU6sF71MzIhO4V
X-Received: by 2002:a05:600c:1c19:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-48379be817cmr338907725e9.20.1771502371842;
        Thu, 19 Feb 2026 03:59:31 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bac27sm267185e9.5.2026.02.19.03.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 03:59:31 -0800 (PST)
Message-ID: <cdfa7ca0-2c7b-42ef-ab79-4c63d4c10c35@linaro.org>
Date: Thu, 19 Feb 2026 13:59:30 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] firmware: exynos-acpm: Count number of commands in
 acpm_xfer
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
References: <20260219-firmare-acpm-counted-v2-0-e1f7389237d3@oss.qualcomm.com>
 <20260219-firmare-acpm-counted-v2-2-e1f7389237d3@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260219-firmare-acpm-counted-v2-2-e1f7389237d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/26 1:27 PM, Krzysztof Kozlowski wrote:
> Struct acpm_xfer holds two buffers with u32 commands - rxd and txd - and
> counts their size by rxlen and txlen.  "len" suffix is here ambiguous,
> so could mean length of the buffer or length of commands, and these are
> not the same since each command is u32.  Rename these to rxcnt and
> txcnt, and change their usage to count the number of commands in each
> buffer.
> 
> This will have a benefit of allowing to use __counted_by_ptr later.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thank you!
