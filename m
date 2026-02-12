Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DE2C11FA
	for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904295; cv=none; b=tjtlQOZb/32TE84h961+hCPNXynqLK8wCJxUm4shyQnTmZy2H3iTTdBWLgKnnk59GPqZO0qqAM9QmtShK2kMVa4itwK6/pXZ66FeFfd0xAyUtEHvX8jbXkjs9UGAFgC0ImUcyjk7pZrWuYcqrZI03QKTbCX5WdK0xrzp8Gb79Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904295; c=relaxed/simple;
	bh=6kxMnabhMAwglNElaLKNhQ/MZytHLp7WT7da7lPDGVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6Fw9WqxspiPUwD7osmHJyRwM7rXmuj3iR+8eOYE13/1Vf8LflwknwcTsTgm4gbp8OaShRKOlLBburwayNEEZnT6MnMlar0YOqx5ZzRt5TZfoMh0++aFkxI6RuXmnIumFnnuZpd6fSvJJPyXuYY2djjha7SwvFyjkCqXZ60OIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bboXz/ny; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bboXz/ny"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so62587395e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770904292; x=1771509092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb8rB32Awhno0bn6RPWJX3/e8hA1sYQyTYJwiIxYNjs=;
        b=bboXz/nyKpBfeIihnK9jeKtDzwJ9gKFHWMCItaAhNAftKZWbKOXP0MlTS/lpJE5Xgv
         0pVyjDvCqlU4EsPmgAtKytGO+gTt+L+7eJbbsGLQ7K6fdT6B/kvlepDK/zCCAedCVHFN
         M1O7nB+VClnR7ikf0KDlWFcIcLKEacVQ5XaRvHk++zxkRphU4RdEvUAc+csmanAxoUN6
         Rd8h6/+H1afHHJoYORNFY1Zs6GXhtEtKduIGRq962zSkXf4HiL/VpgOp1KpiLengn2pK
         DpwT6m9tiB4GGoJyRZUsKchqZZWTylQDGanzz0iXjyaGH3mQoiNyTT8NWZ5H8ALQx9z3
         6OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904292; x=1771509092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hb8rB32Awhno0bn6RPWJX3/e8hA1sYQyTYJwiIxYNjs=;
        b=mLv9Im/3cIi5IizL06s7SYyOVq9t4i/E2FD/CBDfRUTdqDErJN0C6lKuzt0540N9XK
         HsMBil8QsN6l+uDRk8z7h+CKwpNQTLaUreZDWXGU5y+f5DetNtFaI10u1ocO/wC1UbkM
         HeVCezzN1bp9lmgpSZnntDwtop1Fj9YNEZRyjJ4CpwDCMw86ISkWj0Nv1ZKgb4WM5uPn
         pimnE6Rtejb9lBBES4xGjIbINQQk1vzJ6zBkGkkSdUvTtGX12Qf2yI3yKRyDhMA3jWrd
         Hg32Cxvm1gsfw0NZZq8W5REJLh/4SVvrRWB0NGdRohEkc4Q6t8z5aoOjsuZlw45g4URz
         PL5g==
X-Forwarded-Encrypted: i=1; AJvYcCVy392ELudqCXnrAiwlO9Aw7PscCgpUbRTv+qCYY6rnjJwwNh4znfkMn7a+mdztdege0jYLv1fz5WGTE97xkZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTsoQ9BUrYeM3OCmrCbe4vjyr9EY3DiALBDk+9gBDDZMIs5y7
	DupEgempLnqOA/WfEYDHrxT5+VAmqkBjyKelk+u8K8py+VJyQhrbYctI
X-Gm-Gg: AZuq6aIqkYPvTt5hXC55ILAMZIdPjEUWCEWlzZosTRj5CkWPnFrB6wbQLobMNFafLN5
	CtFmGXYMHXQI3Q6T+veSsQWE8ydknkBd7/pSO5jJVH2GNwzyVCQga6fXr23MntJ8iYMNqnp4+am
	Xa0SOpB4PP98JveOuTtB0AgFOaG1hlZmxyfqliJykcOMVH+OSeq7zZZMMwmoquB+sdKrPtrssl3
	2+f0/FGs5AKVuELes3eTPHNx57O92h+VdwsvA0m3BRjW7P6MTSFyZzBk1Urex0K3Jws/zzsD4d6
	HtgDJC39ib0CqmHx9HLhdu+wuM8F/XKFObSiMdpzXr9j7ePDTa6l493CGjQI+G5oPyK8RbBzB6t
	RJa7/PETzPYQh7Pftv4I+zzb9PL+wJxLGSuM0we8OV4AI+8pZkl1HMp2u4YdkPcDuuMHxpYPSB/
	pe9HZghe+nFJ5VGtt1V/rqEYToqse+r+0gH8iB3dAB7uoYZ4P7En9nShH/eqUS7jgN
X-Received: by 2002:a05:600c:1907:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-483656ae5a3mr40177585e9.5.1770904291372;
        Thu, 12 Feb 2026 05:51:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a627c96sm70181415e9.2.2026.02.12.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:51:31 -0800 (PST)
Date: Thu, 12 Feb 2026 13:51:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 <djwong@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] lib: fix _parse_integer_limit() to handle
 overflow
Message-ID: <20260212135129.358c2462@pumpkin>
In-Reply-To: <20260212125628.739276-2-dmantipov@yandex.ru>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
	<20260212125628.739276-2-dmantipov@yandex.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 15:56:24 +0300
Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In '_parse_integer_limit()', adjust native integer arithmetic
> with near-to-overflow branch where 'check_mul_overflow()' and
> 'check_add_overflow()' are used to check whether an intermediate
> result goes out of range, and denote such a case with ULLONG_MAX,
> thus making the function more similar to standard C library's
> 'strtoull()'. Adjust comment to kernel-doc style as well.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v7: drop redundant check against ULLONG_MAX and restore
>     original comment
> v6: more compact for-loop and minor style adjustments again
> v5: minor brace style adjustment
> v4: restore plain integer arithmetic and use check_xxx_overflow()
>     on near-to-overflow branch only
> v3: adjust commit message and comments as suggested by Andy
> v2: initial version to join the series
> ---
>  lib/kstrtox.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index bdde40cd69d7..ffcf0219b1f1 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -39,14 +39,20 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>  	return s;
>  }
>  
> -/*
> - * Convert non-negative integer string representation in explicitly given radix
> - * to an integer. A maximum of max_chars characters will be converted.
> +/**
> + * _parse_integer_limit - Convert integer string representation to an integer
> + * @s: Integer string representation
> + * @base: Radix
> + * @p: Where to store result
> + * @max_chars: Maximum amount of characters to convert
> + *
> + * Convert non-negative integer string representation in explicitly given
> + * radix to an integer. If overflow occurs, value at @p is set to ULLONG_MAX.
>   *
> - * Return number of characters consumed maybe or-ed with overflow bit.
> - * If overflow occurs, result integer (incorrect) is still returned.
> + * This function is the workhorse of other string conversion functions and it
> + * is discouraged to use it explicitly. Consider kstrto*() family instead.
>   *
> - * Don't you dare use this function.
> + * Return: Number of characters consumed, maybe ORed with overflow bit
>   */
>  noinline
>  unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> @@ -56,8 +62,7 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
>  	unsigned int rv;
>  
>  	res = 0;
> -	rv = 0;
> -	while (max_chars--) {
> +	for (rv = 0; max_chars--; rv++, s++) {
>  		unsigned int c = *s;

I think it would be better to use a separate variable for OVERFLOW.
Then the above would be the much more readable:
	overflow = 0;
	for (rv = 0; rv < max_chars; rv++) {
		unsigned int c = s[rv];
with a final:
	return rv | overflow;
('rv' is probably not a good name any more...)
I'd guess the code comes out a bit smaller, rather depends on how the
compiler pessimises it.

>  		unsigned int lc = _tolower(c);
>  		unsigned int val;
> @@ -76,12 +81,16 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
>  		 * it in the max base we support (16)
>  		 */
>  		if (unlikely(res & (~0ull << 60))) {
> -			if (res > div_u64(ULLONG_MAX - val, base))
> +			unsigned long long tmp;
> +
> +			if (check_mul_overflow(res, base, &tmp) ||
> +			    check_add_overflow(tmp, val, &res)) {

Do you need 'tmp' at all?
I think you can just use 'res'.

	David

> +				res = ULLONG_MAX;
>  				rv |= KSTRTOX_OVERFLOW;
> +			}
> +		} else {
> +			res = res * base + val;
>  		}
> -		res = res * base + val;
> -		rv++;
> -		s++;
>  	}
>  	*p = res;
>  	return rv;

