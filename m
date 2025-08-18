Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9E27CCC4
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560438; cv=none; b=S57idFGRnw3JKo660uTENi/CtazXsESS5UjBf6PnPdEsYTkhOxzgE/Yqeh9ej6oYLDdiotIMJocutVYwRJbLaFx7Mqab7APavqkVO1ivyGWkobE/E3LGX6J9SmPNZlTIIYVBfVkF55ko/95pEL75tPk4+6FHR8iY5g+oCQ1MTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560438; c=relaxed/simple;
	bh=wb94KLjt5N8FwYnn6nR18SO9z15Pu5lGZqzVknWG76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4JM0EswiPBzDbmFt879zbtJUPxGnQYJSJGmThl+IBLabzIB8tOtiRhkcip1i5iWWl52BrLCEr8DAmU+RLFL9fZV6/wFH3885fkVheD9HJ4MkgKuHuFm8BB/ouCZxGyek6JHy1RyF2Tufve2Hgh0bBAUDEW+zM6saGUyz4wssrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+y7Ozgy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+y7Ozgy"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e6666a4f55so24476385ab.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560436; x=1756165236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA2dGu/eo8bDyGQ+eks03J0QXMslB/lfrKKitSgi3Fs=;
        b=R+y7OzgylI0PmwLLY44VEJGslW53N7wa4Aa1IHi4gPWnrSX1bZqBcX3rVnKKVOgT4b
         x3lYoiBRJa/GtF4URuEI5HCUAJWiz53hIpkbfiUpho/OaSuwzaKVkxaWmTBcRfcy+Ovv
         EFoeK7NiDodFCpOAh8LlzzCWHMg2B+SeWisi4OilVMadak1FAFB3Q7SAAygJ2WOLerO6
         xMy7896zI7dHz9JysJsT56ti3wVRTlPuj5kLEi4ysoIAFHXFHKH1jNr/AqA4+HB+9HAt
         sxOqs+t/Tv9+zQgxwHdXZsjBoKWV4csd3Kw92+fdT0KS8ST5hQTIlgwYRaPuaLhkIxN4
         rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560436; x=1756165236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA2dGu/eo8bDyGQ+eks03J0QXMslB/lfrKKitSgi3Fs=;
        b=XVot5zVhfX+xQ0zpVSODd0wh6+Tjg5pFTyQ/i+TPZTYNhow0ahmRegszr5PPv4RBDc
         M1cm9yieHAhzCPTIIrbe+9+0T4cACW+VTn9GE+Pvt32GAZDYhcVlmelzL8JvUsjcVVYi
         ivkSwrG7TNSLLmrLPqnifQBC1a3PjrnDXzCsZvlzbgLSUxQhOb9ZjYb70jbjPy7j0qaD
         faA04BmECJ1ORhLoZRuvp4t+rYkUFx4DCBlZLZH2Cjm1YewLaCdV0ZY+/cdbli74i7R5
         CVAHKJLNZNQ2Ai2WXKiK5dtkyU039RHwRFlGtJ7VQ7tzi7ZLDAXxJNWLUivsfE7gIsGq
         R1VA==
X-Forwarded-Encrypted: i=1; AJvYcCW1lm9YbZCJAlC0is2JSd2QIxwP7L2W/RY5FtQUX1Y1qBi90XOc70flwDZNsHCsbGCGP/6VYrKg5vlCSRAWHRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZQayJze1S364tz/22QCMPn94iHU2XEdN2CPThvxZeZWkbUav
	e2k3X8jgh0DrY/EHhDYumIUBpwUznr+HrXR95jc1qs4t0OP3CSJyof6qq4dZSTr0RJbhMwLSAEz
	LSsMLhg==
X-Gm-Gg: ASbGncuBMyZImCK1TZKqJ8gS+yVLc+9Lasytzwz5KzE03pXqC8PX6ML8FldnTlPGtiX
	V5oH77WQGDAB/G5kKudTrXRwFN8Y2hJ6aaVtU48ny72D+LFc9S/vTtwxAFuvepKuYIJO74F0FEO
	a3ETcyFCbaQJuaFVSgTp9dGanTQrTGdyyMU22dW8ScJVN0roaXNzu8ZFTCl06txoz21uj1B3ilt
	W53JKYkwKSNjGaFKOrUPR+Pro/qq4u50RGGwGVwbkSq00bDxtG2awfSb/e+XPH2R9cmo/kvilhZ
	/ibCwHoLv5WiEYsZrBiz/+MffpZ89RpT/4v+nUpM1lwp2fQdFahKPwbcylC7S7GGJRQ+AGHqSCj
	rMHc+ymupqMhN7ABdNiJfkwb3dtGzjLVLyMXf9Y6OlIGQbEZzYhozjwUY/xLjnmE=
X-Google-Smtp-Source: AGHT+IFinOuMzyrwtYFXdoNFknlpEPk5CHa0T0D9qEO7QHRs26OORGLd2trxJDntZT6T7ED5hQka9w==
X-Received: by 2002:a05:6e02:1a6e:b0:3e5:50a5:a7dc with SMTP id e9e14a558f8ab-3e67665cac2mr12677825ab.18.1755560435840;
        Mon, 18 Aug 2025 16:40:35 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e66ed69ccdsm11182285ab.22.2025.08.18.16.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:40:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:40:33 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] MIPS: sgi-ip32: Replace deprecated strcpy() in
 plat_mem_setup()
Message-ID: <6d7mznlomgbhqexp64tswbozmlqk7svrek66zggjnhljsdzan3@3f66zsc5jm5y>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-2-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:12PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/mips/sgi-ip32/ip32-setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
> index aeb0805aae57..c2ebc4bbd866 100644
> --- a/arch/mips/sgi-ip32/ip32-setup.c
> +++ b/arch/mips/sgi-ip32/ip32-setup.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/param.h>
>  #include <linux/sched.h>
> +#include <linux/string.h>

This new include isn't strictly necessary as it was building with
strcpy() fine before?

>  
>  #include <asm/bootinfo.h>
>  #include <asm/mipsregs.h>
> @@ -90,7 +91,7 @@ void __init plat_mem_setup(void)
>  			static char options[8] __initdata;
>  			char *baud = ArcGetEnvironmentVariable("dbaud");
>  			if (baud)
> -				strcpy(options, baud);
> +				strscpy(options, baud);
>  			add_preferred_console("ttyS", *(con + 1) == '2' ? 1 : 0,
>  					      baud ? options : NULL);
>  		}
> -- 
> 2.50.1
> 
>

Thanks
Justin
