Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A31201278
	for <linux-hardening@vger.kernel.org>; Thu,  5 Feb 2026 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329741; cv=none; b=hSNPn8zc8+KYHahLevEu6KzaYfVv6Pz807f0scEuLFY/WhHVnfNExfhrV5pi0HGlXjhJ9dlxoOgbz7sMCmk327/WXdYLXdhX8csG+wKumSCEdgzTEY/DRYS7jVZJhcCAEqdxBJFCF2MvPG7Y9r3mQ1G1raV3hxEakqDNxFVvcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329741; c=relaxed/simple;
	bh=s7uFUf1HP9tkMoTKzYe53D6lm84A+4nOtVfMCdzTH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBPvMsJ9lmxAJnXbU41GaE8En9TV8v3xYcDdIZDTgTp8kjyVhz6pIfp7sqq4WWaehwlMeDZzhNHn44MUyJrt1tIR42sJEvrE4EZf7p13l2qFlZdXCgFknn8I+ghfqvYfLcLz8cByWrxViWePp+JEx6sGVh+u679zVWDZd/6zGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWa+li9B; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWa+li9B"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so580535e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Feb 2026 14:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770329739; x=1770934539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTsDmInbI2tRLigQMHn2tnLgVdMKoIYGwyixFddcuYY=;
        b=UWa+li9B6b7ZrthnPlNEhvhB9sU/+gOaSIdsFjFAK83IhfvxVty0/4Kzz73xm+6Kow
         RMeU/EpLHOripbCFb3sF4p6Klrm7Ys+BgK2PCeQrNHntLY2JWlo/TVsLOqiye4+XnI8F
         eGy/bPAyQ0VDMQ2IIevhxo9IJEycjxNPv9DvWYq1S+MVqUypTGXp1fBxOnGB/hmeROsD
         Tg6wV7K1ruiJreZTuKQWwYvFFb4S0qtx+8mJhStPCaRM6I6I3JKqw+3lpuVpaBlPL2to
         CToxX1iB4Lna1S5fOMlRRhNl09WYtThA7+t9tBrqxMetAZF68DpTpxHPijOgBbkegfLE
         59zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770329739; x=1770934539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTsDmInbI2tRLigQMHn2tnLgVdMKoIYGwyixFddcuYY=;
        b=qgbRcP1FlvrQgnozxpGGVKYDdDBFac1sGWhgzvdY+zODSVoOtUbO/oHzA5sPnxuJ8V
         x4SkYNfLDSbK6xET3bIoZYs1PKYnbsnOoLBhsLR6m1zyh/CKdN3CqmLoW1SRocOIn7IR
         5oJi9Bfv5D7J89V/X271V08Fodtf2WQhRt2eKFAEkH+ACb3hUdwwvL+djqA1YEYJJGQK
         ms/HY/+MR9As5vIknbRn4EFuVXbNd6gQAZQTteJ/qUm5RENSkO09EYTy49PtqQ4WL/G0
         GDptB86uCDMHSDX1d+AIHNdzZmLWb3B6hC0vhzzZ0pMywF/aCJrVFLLQsNY6atLtV2Se
         qj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXM4Sx9Tfhhv5euqNxhVsNELbN5mMNfDfb+00w7kjKP1NcbS5OZA+peWvuskuC1bq9H/+aA/8odEZBIi9DhF7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCj/ukPRFDfD086Lo6ViPNieD910H/HvuLs4JAPiirTwPxuid
	jV+AD2wcx1044/7fT+6RwhCymoRpnDKjPA0wMq8zQ3YOKZswv4IdiFm/
X-Gm-Gg: AZuq6aI0gtRRPzL88tq8Zjd4u7K4d6Z8UUA8yXNLIqjarFzE/sLt89CB+/LIx8OPXPX
	Au/6q/6QBZboJX7kPIzZaW2SiACOtlwSSODmboAYUCHSbwtJX29WBMld/9/Wk8LeZp5L94FSNIo
	IF/qX4rdPC5Sb3DZAEQXk6NuKbdkNSAA0YquzzoPVePT2omF6KjH8qMiWIzjYWZMKxnpFPgowwR
	ywbywlasgbRtXGTnJzRmG1XB7Sw1M4DQdS/vY1RLV0Pd4IqNqOpRPwQBTt57Do1ZidA+fvSUi//
	RBNx658usk3vWtrbVk3X6GU8fC8yss/Jlg8oSErV7zKZyny4KkSrfwlp6NiLmIalipO41ioaH/d
	DnbuODKMvVxtN78kzpP0SpZGg3xkOic685MwqteNaqvf2r08xjGMcUxKfNHBCtyVbyZ3Ga4FG0y
	1KXZ82yOUsq7gTkOsy7bTuUbrTDdqY58oTxlz6N2cWsa29s1l+EndJ
X-Received: by 2002:a05:600c:4f54:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-48320212d61mr11478545e9.21.1770329739101;
        Thu, 05 Feb 2026 14:15:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320983f18sm3676755e9.8.2026.02.05.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:15:38 -0800 (PST)
Date: Thu, 5 Feb 2026 22:15:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Darrick J .
 Wong" <djwong@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle
 overflow
Message-ID: <20260205221537.34778ff0@pumpkin>
In-Reply-To: <20260204135717.941256-2-dmantipov@yandex.ru>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
	<20260204135717.941256-2-dmantipov@yandex.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Feb 2026 16:57:13 +0300
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
> v5: minor brace style adjustment
> v4: restore plain integer arithmetic and use check_xxx_overflow()
>     on near-to-overflow branch only
> v3: adjust commit message and comments as suggested by Andy
> v2: initial version to join the series
> ---
>  lib/kstrtox.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index bdde40cd69d7..8691f85cf2ce 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -39,20 +39,26 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
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
>  				  size_t max_chars)
>  {
> -	unsigned long long res;
> +	unsigned long long tmp, res;
>  	unsigned int rv;
>  
>  	res = 0;
> @@ -72,14 +78,21 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
>  		if (val >= base)
>  			break;
>  		/*
> -		 * Check for overflow only if we are within range of
> -		 * it in the max base we support (16)
> +		 * Accumulate result if no overflow detected.
> +		 * Otherwise just consume valid characters.
>  		 */
> -		if (unlikely(res & (~0ull << 60))) {
> -			if (res > div_u64(ULLONG_MAX - val, base))
> -				rv |= KSTRTOX_OVERFLOW;
> +		if (likely(res != ULLONG_MAX)) {
> +			if (unlikely(res & (~0ull << 60))) {

Aren't those two checks in the wrong order?
The likely/unlikely really don't make that much difference
you want the main test first.

In any case what is the first check for?
I think it just stops 0xffffffffffffffff0 being treated as an error.
If you are trying to skip the rest of the digits after an overflow
you need to check 'rv'.

Although I wonder whether strtoul() (etc) should stop 'eating' input
when the value would overflow and return a pointer to the digit that
caused the error.
Code looking at the terminating character wont be expecting a digit
and will treat it as a syntax error - which is what you are trying to do.

That is a much easier API to use, and a 'drop-in' for existing code.

	David

> +				/* We're close to possible overflow. */
> +				if (check_mul_overflow(res, base, &tmp) ||
> +				    check_add_overflow(tmp, val, &res)) {
> +					res = ULLONG_MAX;
> +					rv |= KSTRTOX_OVERFLOW;
> +				}
> +			} else {
> +				res = res * base + val;
> +			}
>  		}
> -		res = res * base + val;
>  		rv++;
>  		s++;
>  	}

