Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53519CC20;
	Thu,  9 Jan 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444910; cv=none; b=ClKxpaqLT7Smo9c0mzywT0hxUJGhvsW9Z92AI5jNEh+KxcwHt3Ray0BDlEjkjMU5kkGeAOjR1OAi0u/qIZb1MKj157e6TowvM5dsr/YFvBdxmT8dfzq2BegHe9+AB3o29IosFUmP/hLkQlCK+tirE2LVSMwN5zBBHfWU1XH0xyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444910; c=relaxed/simple;
	bh=Oupr2ADGnFXbb+lA545sXVkg508tXecBZ4wLoU1tz6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6zzv+y0mbkHnHTzUg3thK7CZvGbeH1X7G94FqQ1MB0LjmRSEi773+RG7ehYEZyeo1OF/YUQyER35dRBqDo/h7IlqOIV5fsxNFRuYisJaEXTm5MCbwCC1N/V/iUwA5PKwqFnItddOa90xp4SLnUucdMO4wmYHHlU2cl0xnHqz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEvbNblF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEvbNblF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52075C4CEDF;
	Thu,  9 Jan 2025 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736444910;
	bh=Oupr2ADGnFXbb+lA545sXVkg508tXecBZ4wLoU1tz6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEvbNblFCZke0f9gKL/3l4eE+SVnYMVP66m1aM2zsvpkyrZhIwm4pccELCJ3epsLW
	 M/jhsJhcAaKkBz9SqtM9Hu27Qu9XbQousr38KQAcfKEcZtEhYS/rrpaYmYRArWoryX
	 y7LfpAo0btGx4Oo4WesfPzkm6sulNvsBYUIb8CM4CoUftOHIuR87QtOOP8LlORlIFY
	 tg5IXAcCnGGQzFwp/2Gj2p0r2kZoXu3v11lmc/BV/aQJIY6NRwJjZB6nMSK6vta7IM
	 RcwUWvKXsIRjtmq10vYeHqKYF9jUNHjd74n6n9dAQT4b+IYQFpWqOX0iDzRi1nXvkT
	 IWVkpBz2WdfLQ==
Date: Thu, 9 Jan 2025 09:48:27 -0800
From: Kees Cook <kees@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: liaoweixiong@allwinnertech.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, gpiccoli@igalia.com,
	tony.luck@intel.com
Subject: Re: [PATCH] pstore/zone: avoid dereferencing zero sized ptr after
 init zones
Message-ID: <202501090947.3619CFD5E9@keescook>
References: <20241227170459.622630-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227170459.622630-1-eugen.hristev@linaro.org>

On Fri, Dec 27, 2024 at 07:04:59PM +0200, Eugen Hristev wrote:
> In psz_init_zones, if the requested area has a total_size less than
> record_size, kcalloc will be called with c == 0 and will return
> ZERO_SIZE_PTR.
> Further, this will lead to an oops.
> 
> With this patch, in this scenario, it will look like this :
> [    6.865545] pstore_zone:     total size : 28672 Bytes
> [    6.865547] pstore_zone:     kmsg size : 65536 Bytes
> [    6.865549] pstore_zone:     pmsg size : 0 Bytes
> [    6.865551] pstore_zone:     console size : 0 Bytes
> [    6.865553] pstore_zone:     ftrace size : 0 Bytes
> [    6.872095] pstore_zone: zone dmesg total_size too small
> [    6.878234] pstore_zone: alloc zones failed
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  fs/pstore/zone.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index 694db616663f..50a765999b54 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -1217,6 +1217,10 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
>  		pr_err("allocate for zones %s failed\n", name);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +	if (unlikely(zones == ZERO_SIZE_PTR)) {
> +		pr_err("zone %s total_size too small\n", name);
> +		return ERR_PTR(-EINVAL);
> +	}

I'd rather catch this after the calculation of "c" rather than after a
zero-sized allocation. Can you rework the patch to test it then?

-Kees

>  
>  	for (i = 0; i < c; i++) {
>  		zone = psz_init_zone(type, off, record_size);
> -- 
> 2.43.0
> 

-- 
Kees Cook
