Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF733BBCD;
	Tue, 24 Feb 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967269; cv=none; b=OSP5f3jYLuNZMKrktaxjEQxny21VAeu6kNJ5pyoQoryVla8+oClSK+YLoRrOwji8Ufd00Jd7vwtEUHZkjE2SzhRQ04fkGIDZPL/UD+3jxMauYXjjSoK7ehBKBKX9XR+DjmPxdoVQrN5i0yflbTLeEn+b+5ePBjFGr1p8lskKJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967269; c=relaxed/simple;
	bh=6hCBG7weEyJevMfD2njHUo2wuPYASbBAE3ywAdd0EUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxgkT2dyoFPggtjF0S7GlEbUa5oEU8aLRi9upLXIWDJ4iQFiJTNvCpZw4n0AbMYa9zU4wWUBdanEZK+KXjAP/nCNWSG0h0EdsPAyT3QmUtiDPC4Hd632wJIrtzjUeL5mXzqrj1SLd1ZMyMpkh+7dFdWQX+GfjpIni+m7BKHOLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWPYPo3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWPYPo3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC22C116D0;
	Tue, 24 Feb 2026 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771967269;
	bh=6hCBG7weEyJevMfD2njHUo2wuPYASbBAE3ywAdd0EUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWPYPo3JU3XKzAa08aiHdx28hKvE5jFtMIduAl1GaANoj9GLmBt6S4YBkF4nkihIq
	 Xqcn6Wl+ZcpEhATbKsiUhmEbPSV7e0tsp9iBNmZ0IN17GuCft8ztRkMKKjeIQIMXR1
	 EjJIUHWh4G4510eETFNya1UauYO917FhFKgHtcyHYLJVm6qCon/etzBcapsuKV8Wwf
	 nNuepzrdNXDPghANCH9ION0b5OKH2NrSd3jhB971e4t8VR0VcVx+ZKlmyVL0u7Tgup
	 1tMevGoQYBPV9IIgNxW+byYpvkFU205/fGizfh3QcSwovvT5QhdA3eLvWDSJXNikRB
	 WID0n3WkvFOKg==
Date: Tue, 24 Feb 2026 13:07:48 -0800
From: Kees Cook <kees@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
Message-ID: <202602241302.75B565883@keescook>
References: <20260224170427.2296592-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224170427.2296592-1-tabba@google.com>

On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> sized_strscpy() performs word-at-a-time writes to the destination
> buffer. If the destination buffer is not aligned to unsigned long,
> direct assignment causes UBSAN misaligned-access errors.

Is this via CONFIG_UBSAN_ALIGNMENT=y ? Note this in the Kconfig:

          Enabling this option on architectures that support unaligned
          accesses may produce a lot of false positives.

which architecture are you checking this on?

> Use put_unaligned() to safely write the words to the destination.

Also, I thought the word-at-a-time work in sized_strscpy() was
specifically to take advantage of aligned word writes? This doesn't seem
like the right solution, and I think we're already disabling the
unaligned access by using "max=0" in the earlier checks.

I think the bug may be that you got CONFIG_UBSAN_ALIGNMENT enabled for
an arch that doesn't suffer from unaligned access problems. :) We should
fix the Kconfig!

-Kees

> 
> Fixes: 30035e45753b7 ("string: provide strscpy()")
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  lib/string.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index b632c71df1a5..a1697bf72078 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -157,16 +157,16 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  		if (has_zero(c, &data, &constants)) {
>  			data = prep_zero_mask(c, data, &constants);
>  			data = create_zero_mask(data);
> -			*(unsigned long *)(dest+res) = c & zero_bytemask(data);
> +			put_unaligned(c & zero_bytemask(data), (unsigned long *)(dest+res));
>  			return res + find_zero(data);
>  		}
>  		count -= sizeof(unsigned long);
>  		if (unlikely(!count)) {
>  			c &= ALLBUTLAST_BYTE_MASK;
> -			*(unsigned long *)(dest+res) = c;
> +			put_unaligned(c, (unsigned long *)(dest+res));
>  			return -E2BIG;
>  		}
> -		*(unsigned long *)(dest+res) = c;
> +		put_unaligned(c, (unsigned long *)(dest+res));
>  		res += sizeof(unsigned long);
>  		max -= sizeof(unsigned long);
>  	}
> -- 
> 2.53.0.371.g1d285c8824-goog
> 
> 

-- 
Kees Cook
