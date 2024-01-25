Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FA1CA8C
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jan 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173451; cv=none; b=rFSvTmSyhaeg2suZwjwIcSkEe2xqsByOZDFb5e3INhohcGYVmdqZZHw4totsz39MxripJinWk1jFiGRYmDk7N+nlPpzKF9/xhT6xXrQ7gqBlnrW7ZqS7rbTahfSZODm/hxgTQRQzbhReNDhrQed4GqLwUKDgagtZjceYXLpg6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173451; c=relaxed/simple;
	bh=t3PoyixPqjIsRdWxrARK2mipFAAs6+1u6qmkZWCVi9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYvQ48fqsYWR09dVmv9OKsTtHKDE3Qz6yySo69LiAuG0I1E9Hw8JfqaIcVGqLPmKMCgEOeJv/RTlz6tclMpEo/5KE9RUIBXwtmq9lbzcFxOJPvZbqptxlw6hG6Apz8u6rl3wnSN5+3J7ww8qs1uAG4qGkh2jolijRQo3G/eyT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=G06rnHn7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G06rnHn7"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101021c816so500151e87.1
        for <linux-hardening@vger.kernel.org>; Thu, 25 Jan 2024 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1706173447; x=1706778247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b4GmpdmQ39XyN782t8l/PIUCF5z/MQh/W0VBMfJrxY=;
        b=G06rnHn7eMO+mIWoUYP7vEZazAc36n+C+mH37WyvBoXUJyjQvOHBOUbUoszPCIFaB6
         GCgzKVcn+KDlDmwpMBfCD65OUU6LCeSVfyEogq8Y4y3y9VQRCe705CaWLWmS+4jjjxea
         /G4hVZFq8W9uPrh/Ak6VqWVFYQ9Duw2x6Szv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173447; x=1706778247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b4GmpdmQ39XyN782t8l/PIUCF5z/MQh/W0VBMfJrxY=;
        b=Otv1NgysgGQ426+rGGDRvdZPjgTCnCTlCHEBpgnRJOW6P7tB6XfG2gJQQGYCaLw4vm
         Ld1GEldZGyH4JnRg+YjL+hgb6rKdjOHv0p52OS4K30i2EcpIZ0vO9IXOosEuBhoWCNK+
         eTxsTbyTN4lVWR4IxOUnutWxjAN3l7XDYonYhjhmCFJuOhTlxk71m2vEEwdM1YfDi9Un
         Af1NvaXjR3LvwPoqJSABjCDmpgUWCaxf8qzrIIKfbts33BKcBOl3UTn0IPnJfxhHDUP9
         NyjZWoNygD69KbWvshFrzS2vzNx6QXpgm88JPwnn9iHC113iUdq7Y+MqE+X8F9zhL9zx
         vLAA==
X-Gm-Message-State: AOJu0YxAbUBt/LRiJLoNrmMzxkHXOLh3R37ltl8HXLSjeCvFvY4laJi/
	3d90qAoovlm3lkF8Jh4BsrHKwvPqLlXzkN1fvR5KxPwDAlK0xWZfhI3xw1cD4w8=
X-Google-Smtp-Source: AGHT+IHlc4R4+CZGIhdVfP+ARGpqmSuwNTlgJL9lPpzYjqUjhdLDUdiIqmnob17Xo90bVN3+dlTlBA==
X-Received: by 2002:ac2:5f89:0:b0:510:183c:9af3 with SMTP id r9-20020ac25f89000000b00510183c9af3mr522098lfe.19.1706173447057;
        Thu, 25 Jan 2024 01:04:07 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ep25-20020a056512485900b005100fb026dbsm333651lfb.146.2024.01.25.01.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:04:06 -0800 (PST)
Message-ID: <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
Date: Thu, 25 Jan 2024 10:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch truncated
 strings
Content-Language: en-US, da
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
 Juergen Quade <quade@hsnr.de>
References: <20240125083921.1312709-1-lee@kernel.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240125083921.1312709-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 09.39, Lee Jones wrote:
> There is an ongoing effort to replace the use of {v}snprintf() variants
> with safer alternatives - for a more in depth view, see Jon's write-up
> on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].
> 
> Whist executing the task, it quickly became apparent that the initial
> thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
> a number of cases.  Specifically ones where the caller needs to know
> whether the given string ends up being truncated.  This is where
> ssprintf() [based on similar semantics of strscpy()] comes in, since it
> takes the best parts of both of the aforementioned variants.  It has the
> testability of truncation of snprintf() and returns the number of Bytes
> *actually* written, similar to scnprintf(), making it a very programmer
> friendly alternative.
> 
> Here's some examples to show the differences:
> 
>   Success: No truncation - all 9 Bytes successfully written to the buffer
> 
>     ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
>     ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
>     ret = ssprintf (buf, 10, "%s", "123456789");  // ret = 9
> 
>   Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated
> 
>     ret = snprintf (buf, 10, "%s", "123456789-"); // ret = 10
> 
>       Reports: "10 Bytes would have been written if buf was large enough"
>       Issue: Programmers need to know/remember to check ret against "10"

Yeah, so I'm not at all sure we need yet-another-wrapper with
yet-another-hard-to-read-prefix when people can just RTFM and learn how
to check for truncation or whatnot. But if you do this:

> +/**
> + * vssprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt: The format string to use
> + * @args: Arguments for the format string
> + *
> + * The return value is the number of characters which have been written into
> + * the @buf not including the trailing '\0' or -E2BIG if the string was
> + * truncated. If @size is == 0 the function returns 0.
> + *
> + * If you're not already dealing with a va_list consider using ssprintf().
> + *
> + * See the vsnprintf() documentation for format string extensions over C99.
> + */
> +int vssprintf(char *buf, size_t size, const char *fmt, va_list args)
> +{
> +	int i;
> +
> +	if (unlikely(!size))
> +		return 0;

No, don't special-case size 0 here. Passing size==0 should just
guarantee -E2BIG because that's essentially a programmer error, and the
calling code is then at least much more likely to not believe that buf
now contains a nul-terminated (empty) string.

And since it's essentially a bug, there's no need to special-case size 0
to avoid calling vsnprintf(), just let it be caught by the i >= size check.

> +	i = vsnprintf(buf, size, fmt, args);
> +
> +	if (unlikely(i >= size))
> +		return -E2BIG;
> +
> +	if (likely(i < size))
> +		return i;

Those two ifs are mutually exclusive, so why the second if() and not
just a direct "return i"? That final "return size-1" is unreachable, and
confusing.

Rasmus

