Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5042798EA
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561531; cv=none; b=sasZWMaiJMw33m+Q0zUH1wmJJCdD5ma6POPj3UbWBsaIMxc35HrrfT2eGvmQTnl8WbQbtbp1crLfj7B20pWDVaNuWBVxM1BaQ9Nf4I+YzOgmtUG6gRPip87Ad9vsFzPSxBStaBnF1/jICemxCPUXigJhx3y7rtb4PV7CQ/BlY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561531; c=relaxed/simple;
	bh=glVk/hY3UV087gQCtno8h+R3ZP+p7PuN1b//8T9JP7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDUgKY+0AkT55fVssTmY64ynlqMdLfzrZ82rqNG8m0s44xDsWOZtUB5pjX1CXV0Neg6QZcrOkU6z+Hw9F7T3Wmog/MOVtMbhnM7tS7g9mIcONkxzg7hnl5UVdsGrwwPmFuVfFK27ah/uNR1nV1iKR0yr08T+bZjULdigA5CPOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mffIIZQB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mffIIZQB"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e57376f661so18272045ab.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561528; x=1756166328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i19yi9n59eMxo8uVt+mvLfPM1/Jk8FxebqQQMeUMWso=;
        b=mffIIZQBPNk6uCAAQSeq90VMwd+6Vm8I5APcRrg+MvbgbrVGOqT+e1VEkMDFn3TQCn
         2FPd+ucQLZ+e/0lkXeqHTvjAcpyeEFc3Z/Pel8E7USfdvtWYUko64R4PvpFMUkikAbGm
         YOWbpOpIRakQzg/XkXKAd2QVlFlHtoPMxu9wh0URzJ2T4fTDIVZQasfNH0WmRh4MJGHP
         E3Hb7RKdbryPQTTsdz0P5Y0fQhJTGnBbyV6dTDe5zHoPoauUgUHAPk/SR7kq+4iuxdUD
         nbRDRtJ6HWPSotQnB/IvudTZgopRER4k1GDsBByztdnVwxjxzGWQInb1rNUO+MhsFoCo
         sGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561528; x=1756166328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i19yi9n59eMxo8uVt+mvLfPM1/Jk8FxebqQQMeUMWso=;
        b=jvfwEBiR/KM63m6llJoooUm38OYUFFY4MDzCqS9ZrMzbKwZQxMO2Nc2l0QKZ54qUE3
         LERkyjzaSkrzmDBHiqexAzDJGnm8f9o6BZklgoFOHjEO1x6M+tn5z4LXfuv/dZz41LGq
         LnHGkxxRhYALDM8AnRvAnHMU8pwBC3tjA7GCuN6fvYJ8i/+Bjnymt0YuSp0XxTDQuK2M
         BZQt7mzJSWTcNlHAYNNrPnCzTD4DzfpZBJNx5NW8VflrU3C675R28TBfrSpVAFiNXq5I
         jmsl9X9xEzxNrck39bBGyAqE+/pRKmTy2zODkp2dqF7mRdcSA7VM0yPzv5/azGLI/1bA
         cUyw==
X-Forwarded-Encrypted: i=1; AJvYcCVPMrIo2puvqn/A9sfzBAvOu43cLC9s4+QEHwFkAJbabskwU3/JNCqKP0d6XC9daez8mifo4sqc7XL+jiyv7wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMw2s4D7afAYbWWdl15ZDlnkWib4qlpsPsvKZESRsEA8KURk+
	C8ufELDyHBisaR9IBa5SP0RlFLcuSPoH04A2c7DoRviW4Enp3/SQVzySpa9Sm8wBm8O/dtTfdi+
	B7JPuZw==
X-Gm-Gg: ASbGncsxuP7177NMmHnlcHuXX12fSRtM0hiMhOklyKMGjnC1MoTEFJAM+4Vm4VYEMFf
	eZLqYtJf0wBSxE3fxW57A8f9KsyrREocGleZCQXX3zde+sGCPfiKD+foJ4Cwfdp/xdU1J9LeGmV
	wQO3L162zeV2OxScRkcfsoMQ1K3npejQwPBQDDMfqSBaMdbgDIyn4gscdXKz9WpvwmkwZjMvV8I
	cRq7kPFg1MvMHj3auXVbST28OlVwCEcSIWhXw3pwSXlphKr0mthGJAX3yfzQZIktLX83bV6rb0R
	1n9rsQKToCctCnA9iF7kRFK6K7iGQwwVL7I1us6DDXGd6N6hdMNOlsGE493V32r/1UPGDueKFEU
	+9ZKrxYUO0zZRipOC+9cXMaOXVY+UbTLfOhdIhlSaYEiN46TG1hfOEL+21QxvVCaybpUWZSKEGg
	==
X-Google-Smtp-Source: AGHT+IEz/EI+LZtyAIW9MjYSAxlsQgeLXFtkoryUpRnIuhRS73z7iBfg2JLP0JM/2ebqh0wR5R8r8g==
X-Received: by 2002:a05:6e02:1947:b0:3e5:7de6:c348 with SMTP id e9e14a558f8ab-3e6765ce30dmr12922565ab.3.1755561528238;
        Mon, 18 Aug 2025 16:58:48 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94781b7csm2898883173.15.2025.08.18.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:58:47 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:58:45 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] MIPS: arc: Replace deprecated strcpy() with memcpy()
Message-ID: <yisgcmjp5cj27yozthudyrdpfcovhcrgpqbyip5kcum4aa7qwl@52bccatjuiak>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-5-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:15PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use memcpy() instead.
> 
> Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
> warning.

I'd like to see more reasoning for why you chose memcpy() here. With api
refactors like this I think most folks want to know if 1) there is any
functional change and 2) why you chose the api.

> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/mips/fw/arc/cmdline.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
> index 155c5e911723..86b0e377b713 100644
> --- a/arch/mips/fw/arc/cmdline.c
> +++ b/arch/mips/fw/arc/cmdline.c
> @@ -42,12 +42,13 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
>  {
>  	char *s;
>  	int actr, i;
> +	size_t len;
>  
>  	actr = 1; /* Always ignore argv[0] */
>  
>  	while (actr < argc) {
> -		for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
> -			int len = strlen(used_arc[i][0]);
> +		for (i = 0; i < ARRAY_SIZE(used_arc); i++) {
> +			len = strlen(used_arc[i][0]);
>  
>  			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
>  			/* Ok, we want it. First append the replacement... */
> @@ -57,8 +58,9 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
>  				s = strchr(prom_argv(actr), '=');
>  				if (s) {
>  					s++;
> -					strcpy(cp, s);
> -					cp += strlen(s);
> +					len = strlen(s);
> +					memcpy(cp, s, len + 1);
> +					cp += len;
>  				}
>  				*cp++ = ' ';
>  				break;
> @@ -74,6 +76,7 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  {
>  	char *cp;
>  	int actr, i;
> +	size_t len;
>  
>  	actr = 1; /* Always ignore argv[0] */
>  
> @@ -86,14 +89,15 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  
>  	while (actr < argc) {
>  		for (i = 0; i < ARRAY_SIZE(ignored); i++) {
> -			int len = strlen(ignored[i]);
> -
> +			len = strlen(ignored[i]);
>  			if (!strncmp(prom_argv(actr), ignored[i], len))
>  				goto pic_cont;
>  		}
> +
>  		/* Ok, we want it. */
> -		strcpy(cp, prom_argv(actr));
> -		cp += strlen(prom_argv(actr));
> +		len = strlen(prom_argv(actr));
> +		memcpy(cp, prom_argv(actr), len + 1);
> +		cp += len;
>  		*cp++ = ' ';
>  
>  	pic_cont:
> @@ -105,6 +109,6 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  	*cp = '\0';
>  
>  #ifdef DEBUG_CMDLINE
> -	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
> +	pr_debug("prom cmdline: %s\n", arcs_cmdline);
>  #endif
>  }
> -- 
> 2.50.1
> 
>

Thanks
Justin
