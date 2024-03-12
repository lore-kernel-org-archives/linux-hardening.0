Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787D14374A
	for <linux-hardening@vger.kernel.org>; Tue, 12 Mar 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280429; cv=none; b=V5h4CNTwbJxdVH+MA2eiqksAtm0BFy0Z3xwIkCSUpdPoLJxaHBgRkIJVU1ZY5z459zIERDHBFXbsN36cPg1Fo4PivoWRtsRQwtE5txCuLu+BIBG354HhWI5N+7gcW0jP3Js7Q/gltdtBuoaXhuoDyloqh8RyohaNp8P24Sq73B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280429; c=relaxed/simple;
	bh=G/4hgM5wTxTmcKRjygTzdn2/ODwGo/XzRcupSuCiDhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6/xnVuHiJZHGaNHpPCH9DQMjL+YF9k2mUnAHFs1IM2TIJBvghFqi8JIMwW1yjvDO65Eks0SYx9rdSEPm4YE86yRtvfU75DSdi3g8+HeXYgfPeRlqJD8yAWk+GsFRzjZQkdrcyzA5OsjobYQ3Hs0Wtp9zElQhEpK+Ps/EWOnXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DcMXjwU6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcMXjwU6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5eaf5bb3eso4801794b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Mar 2024 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280427; x=1710885227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRdVUDa2pta5KTvFc1TATmL7fgNoVWU4s2HJtfq2h88=;
        b=DcMXjwU6D7ZrXjjXKE4tykgbSaRw0TFieADBO1R/PU2HXROSSmvjPox8tWcagM2njS
         UQ0ULslyDc2QlWNuhArc2JqJISt31OdL0q7odDIDghiq4/qqFYNPD+QIzVQSf6MfkSBJ
         ErRA3azwkH4JAnvq8ZcMaXI00exrsBAVTO1kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280427; x=1710885227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRdVUDa2pta5KTvFc1TATmL7fgNoVWU4s2HJtfq2h88=;
        b=n7yZzkj3hZuHxa1ZZf64bahHZk46lJGFmK9mFCwbfZ1yJvbqkKPxrBhJAzAnt9Y3Q5
         0fZvQDjW4rUc0uyKixvUk0pnit5QICT1n2menM/cV/XCTB8kPZEo9NMA/+hsfyO9wVCD
         xFjZ5B2iy0udkHdkDc/4xtPjzchAeAINyIi1y3Km9MycEtm6kNmVcyRZ6a2v/aaPzEU/
         oaRI6bKSJaDcZiLFxERWiBPhAHVgXtcEnxgxDAuQ8jVLl3q+GDDpUQAPMlm+4JyW/Oyj
         bmTPCHfEI+ZVfO8LLScHZ1an5uihHdXXHsdWQPtA91waOKteGhXwkulN9JMge89W64VY
         8FfA==
X-Forwarded-Encrypted: i=1; AJvYcCXTuAGTwLUW18tiRK5IW6mwdZ3MVsYLcEC6T64CwExTpaoOyIyEgquSDlFGBc6U/6gJSHvchiexafInWyV1xtwZNSB8kxTJ45jvDgfIaVuX
X-Gm-Message-State: AOJu0YyIs8fzXPK9FIgqEOhr/oNYvgcII2EXCIhJy3BX7g5TTPDzKxAX
	rT5AhZsL6PB6RO0MoijXOOPAqeQQkkz9eR7wNJRKUV4uP4Rs/VoW8PPi8fGGhQ==
X-Google-Smtp-Source: AGHT+IFqNTbSHg5S7yBJU7eqizCMy2N+F3f//0dRar/vDWfMpE1iigmGI34L3PlR68X94oFiT6tW4A==
X-Received: by 2002:a05:6a00:4fcb:b0:6e6:afa3:7b32 with SMTP id le11-20020a056a004fcb00b006e6afa37b32mr843588pfb.6.1710280427387;
        Tue, 12 Mar 2024 14:53:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b006e694719fa0sm4235092pff.147.2024.03.12.14.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:53:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:53:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] gcc-plugins: disable plugins when gmp.h is
 unavailable
Message-ID: <202403121452.701C91AF6E@keescook>
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
 <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>

On Tue, Mar 12, 2024 at 04:03:30PM +0100, Thomas Weiﬂschuh wrote:
> The header gmp.h is meant to be picked up from the host system.
> 
> When it is unavailable the plugin build fails:
> 
> In file included from ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/gcc-plugin.h:28,
>                  from ../scripts/gcc-plugins/gcc-common.h:7,
>                  from ../scripts/gcc-plugins/stackleak_plugin.c:30:
> ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/system.h:703:10: fatal error: gmp.h: No such file or directory
>   703 | #include <gmp.h>
>       |          ^~~~~~~
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  scripts/gcc-plugins/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e383cda05367..a664fb5cdde5 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -10,6 +10,7 @@ menuconfig GCC_PLUGINS
>  	depends on HAVE_GCC_PLUGINS
>  	depends on CC_IS_GCC
>  	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
> +	depends on $(host-cc-option,-include gmp.h)

Why does the prior depends not fail? That's where plugin detection is
happening.

-- 
Kees Cook
