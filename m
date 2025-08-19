Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79921469D
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561740; cv=none; b=fYX3jGsgvKFBDqxn5LLSnktJqFKv1HulteClG6upS1gGabmsSOxnv2MRKZDZtas5sMdcAh9MbYJt4GPh1iYi9PtJl6W4TknMdIsWUrbrJ7HNEFb2ygPnST1u7UX1/VxnsGJNMWA/LFbvVMLOdpnuembnEiKql3dOigD+/Zfh+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561740; c=relaxed/simple;
	bh=IYI91/LE9Llcly1/RR9GAXRgHt5xZK04GitaKe7QsYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5LZTgJusViTFT4j//ALMESojST/mXfi48o+7h3KawO5HuWbTcpWSIpwdFTe5BTN6RaoouMYzssXbj07hSTgwUhXoIG1Uu5mJ3cC66E8XWGx3TTq7jdGg4hL9so5tqZN4uG+VyFPFD0yntGD78g6mM16FyvT44VH73vcqqKJDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4tMuMFn; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4tMuMFn"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-435de7dd94aso3217629b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561738; x=1756166538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMsgbwBVAVhf//iwhRHAmazuWGfkfHKPwkTozN8mYH0=;
        b=W4tMuMFnm25GdNZbPYhPn7cwIhzmZU7JAQ54Nx5hcDY4ZvarRH/o5jDOkUL2YAbG2g
         lnuGIGF3aGFdgaF+4j7mDk3X8CFNvDQEjhIdrA6JvyvYgUj9nEzBFu8nCXyEKqa8TuaY
         cZBaOpOCAPNNFmVe5dnw5ERkOMAMsMo9kWnMT8snfWi7+mGq/bfBE2NJj1WpokRLBnFp
         h+JJWEeA1G/NHsQoY6lm844YTdNfHv6aAxKLpWIVg1m31FpNgyWm0n0Xh0/1ggAmxs4a
         Ewyco05MWIm8QQNy2bzdIXppbPBbdBDBPoB7tZu/p8wuCOajACLWd5wBsQ9efx00YLv3
         k+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561738; x=1756166538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMsgbwBVAVhf//iwhRHAmazuWGfkfHKPwkTozN8mYH0=;
        b=bE+ineML7cv4X88HYu/fX7ogME6H1acYne32p19cfkMBjQng8W2AUAeW+OmpN/Aq0a
         kC4M51vqaVUwJoUHnEoUdfRBx8ApMs29YFZXWBEcL2tBBKVyJ88yodWITnXr5cCDnne0
         Y8yzli15+z6M8q+FGm9K57v7FEGzKDGucaDJ7j29oEBCErtNdEKCNKmnjPkLjVET2xUU
         sUtcLvgYI/TBQBoV/k4VvAemrrRufhHEseHCcscjQsPLFk2AAjc9IlOPy7GOV1tRc9EI
         LCQUGP20RMCJQarUykwLmT7iJ+9aV0U/2dfD1uLBbbBgc0LDABuPSPiBiYqIYlljyun6
         fqUw==
X-Forwarded-Encrypted: i=1; AJvYcCWpClUCe2+iNesXPYOYx4H7ony/e0uQN33twuAFohewkKgKxVdSttQNvv4+FmeXry3zLyoLclfuBSadhUyFYx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDp1fGLISMsiDS7zP64F16sY3y/kJ9MsMDG4f4876nhsddCP/
	JuRKtAkNbFOthQPk3nqu2pe2zmynUQnPK9lo1ulWYtKnXJykYjGbjwhxSyB3cdQGsQ==
X-Gm-Gg: ASbGncsZWXb2vzbTOxw0WISC5onw/fFJoVNJJyjha8XI0FvmURIvFKKf6BBOJlLFivb
	diXC21ClZEpyJ5mpW5fxkElHa2yaLSRyfL+LvJqwMG3YUo601J/fh0e5kHIyxbUubv841eZUDWn
	yhkm6Ge1MfejwKR2rFTvEbVFx1y47oGBEIJeunbhuFOPYDt8uGZ/ZRvGME6BekKl8mLVeXG+pNQ
	uhXE2HYxzE1PSjrs+PFxgT65TH7p7wal9+GRYSNcfJuZbKEmUPiFFU0HZGaF0ON9l+oVto1VGeD
	uNa74xupZ7tlN5YH42HHNTbJ0MAQ7X3oBNRnkhImZPd8ODFwEGyU70pvRibhh429bs7xnjVvwhO
	8WX93UvtReDPYKaE2X7loAI0sIPa5HSMBBfW0zshng+0SDUXJHwiFi6644r4kk2A=
X-Google-Smtp-Source: AGHT+IHxC2a8ADbE8Man2mxRnjf7l32j3oW2wJDIpc4tYOrxF0mDpcOuNs9sRV+UqoA+G+aHiT1l0g==
X-Received: by 2002:a05:6808:11ce:b0:433:fe69:fd85 with SMTP id 5614622812f47-436da1e48dfmr462238b6e.20.1755561738182;
        Mon, 18 Aug 2025 17:02:18 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94786c0fsm2917906173.3.2025.08.18.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:02:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 17:02:14 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] MIPS: octeon: Replace memset(0) + deprecated
 strcpy() with strscpy_pad()
Message-ID: <mnqgvgvlnnamfyy7eb54thjs4edkrcdwqy6mg2ybqhf3nxtapu@rntlepvgtbd6>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-6-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:16PM +0200, Thorsten Blum wrote:
> Replace memset(0) followed by the deprecated strcpy() with strscpy_pad()
> to improve octeon_fdt_set_phy(). This avoids zeroing the memory before
> copying the string and ensures the destination buffer is only written to
> once, simplifying the code and improving efficiency.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 5e1dd4e6e82f..47677b5d7ed0 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/platform_device.h>
>  #include <linux/libfdt.h>
> +#include <linux/string.h>
>  
>  #include <asm/octeon/octeon.h>
>  #include <asm/octeon/cvmx-helper-board.h>
> @@ -538,8 +539,7 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
>  
>  	if (octeon_has_88e1145()) {
>  		fdt_nop_property(initial_boot_params, phy, "marvell,reg-init");
> -		memset(new_name, 0, sizeof(new_name));
> -		strcpy(new_name, "marvell,88e1145");
> +		strscpy_pad(new_name, "marvell,88e1145");
>  		p = fdt_getprop(initial_boot_params, phy, "compatible",
>  				&current_len);
>  		if (p && current_len >= strlen(new_name))
> -- 
> 2.50.1
> 
>

Thanks
Justin
