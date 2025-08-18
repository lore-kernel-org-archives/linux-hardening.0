Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92340202C3A
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559450; cv=none; b=WCxLr80Meiv1imt69CSWzh7rtPdynFYA+gjL+XD5GP1THwmkM2G25WILaSi7vEJqJos3LRk/3v9KfjFwmsw9Yh5ko+/WJHwdEmihRxTx4twWTHKBkuQRctrOu5dC50aUx8iQ9JHtOrZXybvIWA0Apn4Wp98Xt0ZHyX05pf0tTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559450; c=relaxed/simple;
	bh=88pFRxPpReZuhh52+eqRfeXx6L+V5nMjiJpTP1SIHQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGr9zktngJeJzRW62S4Hj3f07ptA4C8TDn1490WFADrAE0AuFrrWqTtrG5H/+Hp7Dal8/5wE3Lw+KcWYQ3daClcePqcAbjyXzVar1b4506BmziBWAwNGPRGLwpb7kV3E4jrfNSVHdWBLeV90286EdVdLYO8S4jZxPlfGN0KKg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDZdhzFV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDZdhzFV"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8844ee2cb61so52388139f.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 16:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755559448; x=1756164248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhajVtK66yTySwyrLZ2p1bbpHPegFOXW1beKh398ayc=;
        b=iDZdhzFVJfxw1MAPUbHO23epDWa7vElcnbwd6TkhM7kl6xvYdBdZI+uOES7JkjRfUl
         vbCaRGdSxXctYsBOsWdtxSZ/wqek+DiGQX4hETIwqFL9CNS0xBduEDHyeS84LZ4CZ7eS
         OOFtaRvTUXfP8KHgN8w2imHlc3u3gbRRmvNcRZ5YfeTqZ4hMc8+8JW16EyRZNiIK2/yV
         2fX5HjuYy/Lxqf032/Tn0wHBR7RdAjQZaS5fHW00skHqx2/DskYsuSpnReahhV9LTWmI
         QixStgZOX3rcQJ0lPSPgYi0t/GPURbJ8Ku31qV5JQJH29h5I/PHxQu8PtI5P3yeT7zKR
         QBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755559448; x=1756164248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhajVtK66yTySwyrLZ2p1bbpHPegFOXW1beKh398ayc=;
        b=HtQEjARilwiQcYMuYZEoZ5YDUzDoOcfrLQcCjIgtQajj70WPMQqrhWm+8QnCJWFSW0
         IJU159UQSMo1NoiM9CHyGZ6umKNnwDzyQJ7iQt+3BZdXryN0fW9Cml7orH0AgXR/w8Zo
         W/pTXr6w+uejNBZvyKBeVgEb9RGbHuZ1KaImiWM9TlQpwWn20XAqmCKxCXPBboIfMP5z
         I1oY0XQKHyI+6R3Z4QRN5ntKZqcJW4DddnYRxzHhvm+5X8DZtYDRSQxujYCq/A2oY+d/
         n42cAhD+Cihd/R2Oc/vWVoXw+4dFb+84vsX1ml5EPd/RODB8RR/cG0dmg4YYrOc/WcHT
         wgjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYvaTpxCSv5NvH7+r2EVCpATXCf0E9gAkiyzs0A+65DiTvfSKyULo1t0COi1wNlAUjt27blMk8/WOOhZYpuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueNDnWaXqFhlP4mosslQruH78KgdjSB61psMGJmmixlBQXOny
	tPVNGtVZbmvcL9Mm48IQ+6Su34KjSE9lfVchffWZplgmhLpgJWK7L4jyiCbXFbs2+tccC+wRnIt
	Rjdew7g==
X-Gm-Gg: ASbGnctpZNTy9fgTO2NlQUBSKp9HgU494QPH6tBY+dBDYrBTh02cVY69mn5w+/ZCX0y
	p9DaLcpm3wfJtitBJv4uJupXZfK5rFZmI4Pdd68neBYGk4Rp9H1Dd0PAnpw7nNIU9lZp/DHSWwV
	bIlr3jMBUFybgU0tHRmv32rDEMIEze+u/gqyqjjBuosuLXrSEfGI81n83w+dafaPxhBS/ObU6g+
	cVclvUl+EWcPb4bYjM0Jqb6PE98w0xaijfxvXnB8jMCxgg56hyJKPRtrilgeYALecMwLVo0Uwxt
	GdhMIMkOMfcTgJ6HAHYbsAHDVGW5ot8S2Uar9d6ThI6xpIOhrKliMLMJv3vX/gtmd1iYFgaNYCl
	Z8VYSy2Y6EKl0UevrLLSGckw2tXhAv0ssJtujZRQwyCniLYJ6g7PV8UlhQwgOnyk=
X-Google-Smtp-Source: AGHT+IFW67NxhKSu0Fp/FRczJDzd+y9jHARgkjmLy8eub8JVPX4L9X4bg29UADbaCuXul/vURpj+Kg==
X-Received: by 2002:a05:6e02:156e:b0:3e5:738c:3f3a with SMTP id e9e14a558f8ab-3e67667beb6mr10658085ab.21.1755559447494;
        Mon, 18 Aug 2025 16:24:07 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94998c07sm2973697173.49.2025.08.18.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:24:06 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:24:03 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] MIPS: sgi-ip22: Replace deprecated strcpy() in
 plat_mem_setup()
Message-ID: <j5eb4ffqiz65prvai6ufn2zi5ywupirrwk5zfdlnafeye6i7ei@m2vipesyx7z7>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-1-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:11PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/mips/sgi-ip22/ip22-setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
> index e06a818fe792..f083b25be13b 100644
> --- a/arch/mips/sgi-ip22/ip22-setup.c
> +++ b/arch/mips/sgi-ip22/ip22-setup.c
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  #include <linux/console.h>
>  #include <linux/sched.h>
> +#include <linux/string.h>
>  #include <linux/tty.h>
>  
>  #include <asm/addrspace.h>
> @@ -65,7 +66,7 @@ void __init plat_mem_setup(void)
>  		static char options[8] __initdata;
>  		char *baud = ArcGetEnvironmentVariable("dbaud");
>  		if (baud)
> -			strcpy(options, baud);
> +			strscpy(options, baud);
>  		add_preferred_console("ttyS", *(ctype + 1) == '2' ? 1 : 0,
>  				      baud ? options : NULL);
>  	} else if (!ctype || *ctype != 'g') {
> -- 
> 2.50.1
> 
>

Thanks
Justin
