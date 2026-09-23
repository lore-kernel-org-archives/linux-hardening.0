Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FF414A3B
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140275; cv=none; b=SEgHkLyfo1g8/CA6leaqEvsTnaa9p9NjD9CN1KnFsJQECuBBoBRZcbFD+rsvLQC2XwY4kN7BW3fEFhPcCrNUWB6xn1f5jy9Zy75guuj7uB3GgwJuJsUVa4ozk0v28DryXnvBCWdb5e4aUClVYw5YoOWrxLC5MOAzTJwsJXtCdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140275; c=relaxed/simple;
	bh=sylCtSF2MlCfq1b39cak/n9U1b8c8EdsoicVmdhuVhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKvxksCG8TsUJ95UmkHN7s5by40+k3gMeKflQrqPlzEdJ/Sh1mjzhGXZaZYM9Oub/KeQOx4FUWizd1GqeZG8dBFQAwaRqVQT4UXmqXoSqvyUPp1DSvM8/kTbewNUqTsjPczP5Cn+Ha5VVzl0UQbopGKuGFxoCVwMfiBLxcnfo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=hkDBI41l; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="hkDBI41l"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85a4329731cso324950b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1790140273; x=1790745073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JoQb5pHgIxz8ZF+3NPp5p/PXUFzw+s+TYUg7wlblHUk=;
        b=hkDBI41lKKn9Chq2Iu1D8GJJOw74FzWgCNOSY/PdPITZrLZW3xjObUtCtGJVBFqRwH
         3XD2dF+/NzqHHzaYWeAiDhzGHY+ZlJiXZQeOsq9BkjwrowcGGP330es8AI3561KX60RB
         wtT7Wofg4Xh5hu7ZDx7vwnlaLKvOUM0HIIZxfStpse6UaYabApX9mD7JRM9q/szrrNOG
         Ic+8LeRz3MG5la3F3w7btJy3RaFEuomDNqSatmG/WopYCzwhrBqChSYJ4QQ2kpRS4zFK
         gMxOxFFO1dn18enx2GC5ISkwmKNAO0nyUxZtmXy5wQR3tE+/e+R45b8dvfrB+PWCR18F
         L0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790140273; x=1790745073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JoQb5pHgIxz8ZF+3NPp5p/PXUFzw+s+TYUg7wlblHUk=;
        b=rqk7+UJ7o9rp2ME5K38Emf0180ZCvUM4cUc5VjX7boGOkgf6TMGTSa2i2K4eqboBCl
         cgVtYEgOeg1lYYs+T27rnjzaUwxqa7MtXs1QQPCmyqVlZ31GQZEu1w0JqUsGZpTXMXbh
         RLu22k9xVRLsDq39ZtIAs8SOJSTqc218E/ZRiuwbb8BNJBCMRjTnAF/D19T44sIekZE4
         uRFI5+eldqQ5YL0ZRl8oiBvtfzv+sZwrfrXKgAyB55aySVPB/LoE7Qg7be43F6VwVNwD
         3VMubcreiMchGvAQ/k0pTo+pDlzriM0PjtB+qYmqld/zZAlQB4Sor5RZNOCwYZKiwwHM
         s80w==
X-Forwarded-Encrypted: i=1; AKwUvByHtXXcVYAvqSTde8w5q64UVR8I2/WOmwptkQcUzR4rQZmvjgI3MA784WSq3+DftvIMERm/qdO5EGS08nO7PYE=@vger.kernel.org
X-Gm-Message-State: AFuF++mo3m+VHSCNUMpVycCILAAhYBfBQc+yAp2v9B7VDViZ57bxPOdp
	o/1JG/jQ4D6o+Q5VYaZL2GZ6RDLPyOCsSDjsgOj3hoBBGTKfn2P5lmi8A50GXP9UC14=
X-Gm-Gg: AYBFou0T2fREyDo4EbZFKPgPlaODCULiUW+QmNhR/FO5JhzSg6G3E8dJoqfpkoUOMsL
	/Um5bXb5roR/0LwUmuZnznMyTaUHwrotWob+gzoUVC13lI9264wrFhEiYUT/vkPuyjdmxvhopQX
	w+F0xY1GTDLrAqXkXP9+GBw9jfNWjI2/Etam0yhWqYHUCgJSBqNkqiJKab+qLVAvdvZTIXzLuN+
	oNfkCXvK9apGbH4iitdEpi26wJK0KdOJ9Nuk8Gcanz4SLO2egvSWl0dgvjuiLUNXHD+08R5tPDB
	mzoKuaKy9k8lrnmDDdfohCK6Ijo2yJaUd5lhyvBxjHrjaqiPu5ygAK3S1oQKprjmZZJjoCOwhFf
	8zDCXaa8KNx4P5dMYLU8MDd49HQw4BqijZHBqKFnY5BcklC2NlgGobeWnWuc3i9puT/+TIuulbw
	Xuf1lLe6uEYZrLWQo0M9aXp66IQg4RCx1881c3jOSNaJTskjBzOfyERwXVkGd3v3Ao0+WIJQiR4
	LzYi0ipSKlzRzVXAitCVEwfYMzQY90zcn8dB5tA5vS5SUAiz4FiyL8jXPKmzmKv33PrTyE=
X-Received: by 2002:a05:6a00:761a:b0:87d:3894:197d with SMTP id d2e1a72fcca58-87d3894223amr1197529b3a.40.1790140273603;
        Tue, 22 Sep 2026 22:11:13 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfc0a05sm693810b3a.10.2026.09.22.22.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:11:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:11:10 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, codemender-patching+linux@google.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ieee80211: annotate struct s1g_tim_enc_block with
 __counted_by_ptr
Message-ID: <lia5ezt3tyf6vcpe742sel3vz4w2fuxva25uxgnztc7rkftk56@4qrkx22hmx5v>
References: <20260923045233.2579591-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923045233.2579591-1-morbo@google.com>

+CC Johannes

On Wed, Sep 23, 2026 at 04:52:33AM +0000, Bill Wendling wrote:
> The GCC and Clang compilers support the "__counted_by_ptr" attribute on
> pointer fields to associate them with an element count in the same
> struct. This enables KASAN and UBSan bounds checking to detect
> out-of-bounds accesses to the pointer.
> 
> In "include/linux/ieee80211-s1g.h", "struct s1g_tim_enc_block" has a
> pointer member "ptr" of type "const u8 *" whose size is described by the
> "len" member, which is correctly populated with the size of the buffer
> before any pointer dereferences.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/ieee80211-s1g.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ieee80211-s1g.h b/include/linux/ieee80211-s1g.h
> index 3f9626ad3d97..8f6107782c38 100644
> --- a/include/linux/ieee80211-s1g.h
> +++ b/include/linux/ieee80211-s1g.h
> @@ -349,7 +349,7 @@ struct s1g_tim_aid {
>  struct s1g_tim_enc_block {
>  	u8 enc_mode;
>  	bool inverse;
> -	const u8 *ptr;
> +	const u8 *ptr __counted_by_ptr(len);
>  	u8 len;

Sure

Reviewed-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
