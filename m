Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DA32143A
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132535; cv=none; b=d9kbPcD678s0K/bJcoIAHFG+ACbIdyA9vfLhWr1dq2Y4rgtyXgywWuA0IoWaSCagFKnjrxL1NMfVylNYTwdNInsxZJ0H2phn04ro8gKsMeskONyhkTRB0Hk668/G3UtfacyLqIOT0REp9xEyr+r/MQxpII73anv1217MXyezd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132535; c=relaxed/simple;
	bh=WsPVMmryO2QRx2Xp4l1oL5HQgH0irrFM+LGLFSthqWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYEEDzl3ISRBYNf9vBWdrzYMYNQvg05qZk1uOuQxzQ7wnCd1Fs6VA4GsXqj4D8zLn71hCPhlpshiyGDzP0Oqg4saRMRHPY+CrC0Wd7QMWTgeBTng2JphiJwVbCa4ttQ3THCw7HScJaBcJp7qjVgwifVY6PkNwJ2JwhcmZZ9RYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amFl/htq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amFl/htq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so13385915e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763132532; x=1763737332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArZZMcVGxA/fyahR3ThATogsNHyENVsjurNGhgvKTQ0=;
        b=amFl/htqQHpI2IuAgtzE9qcGt/+eh1L6gstoOTaM6wEiSMWwF9VHQT/SvWNEGIhkEa
         qnSFjcNNHNeF7gof1rcbC+dbIpCZ1YjegS1bb0VF6e+NfmogoiS4MBjoduHPrasJYMth
         z13o2vsqwOiaBichtOkAbsVrfiqMxLG3iP8uRSX1feu2Z5D0KcH20fPDiblbnFKugyEV
         bINNMF5ki1ohfVgqEv/67L0TnTxh6V5VPaAWzXgxF32kEsK+9gVqrVgTS9utq096ZZU5
         2nXozxppbX85YITxKhe7DvNgFPi0opPpwGsGw2n8w0IM6UzVo1xElNCHgG1SIFktpkkN
         khDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132532; x=1763737332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArZZMcVGxA/fyahR3ThATogsNHyENVsjurNGhgvKTQ0=;
        b=KCUwEETNZQi0cVwOKCpMeHboRerbmtL4nDVL71Ju7Zi1ovQ/9EJcIIABbclkQWXC1k
         NJtlV9HsABzxuhG2DS5jrmsVqAz0Vk9YiLYb/L+LEaqjZMOGJJCx60ZJskKmgeMEp3Er
         zsvgaN41we/LFLn4KkaXttN+hivVVNPwBwe83TPD4YeXFbQ9yuVuDGx+z1EUmieLawya
         63vWO59dxMy5gmGMs/8xSWOU/7DbxTTs6n+jGT9vYrcZo14+7cH7XlI+W1plM2G9g9HW
         HRTSF7ZjVvqJKtlzweoB02DRt/mH8oN+CcmhUgIP4U7dlxL6rIKV0Affhfw1tTh0riPX
         v/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUi2uY2ashedlRriUA5Me9p0bjNhaheiGPy/VwTQLZgKOzn9ul9lE4EaH9WS48tTpA217BRPRrQ+/lU0iNeOoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtTm0R/0erdKg5ffU9QnuSleoVflOpJkYe5giFn9VNFgQ8ZfH
	VglcHOE71LfWoOWq7XYabhuRltSADFuTHiJnZHl66moih00Tt3sPWihw
X-Gm-Gg: ASbGncsScc6SfX0/ovcq47jfmSAqv6q1MSp8oqXK2og2frOVnQN0DhwsFY/WpUKLMW9
	ilYN1SeUPGhMY5gj97ZJCQkdkoOQLGnGwMddxgHcXPYBm7GxcLuqVZlezWPDlTka5QrxM/ro2HN
	4QEczDHrbIPYh4u/UZYjcT6Ltbp/OEy8/z9lrFFEp+ZfLS/x/8FJuETBQqGeVOaFGt64ZmS52jk
	k9TgM1bsv2piS1kJmCD0FBU5ObaCfsoe+UJ0iAb3MVJp7xxjfYRWb70ijt+7ExbxM6QoT2GHIB5
	XnsMpsMG4BRh1DWy9lrX/Zb8aEbtPqC71yrOTG+V8ZmlPbOoYsTyp/jy16WA10ML50B8ThbHK/2
	pIqd7FOZ+EgrJzjmVdHvFfg3VwnctkWVYhcnI6A6mKY/UPZZA8KPaowKJMRTjZiRhOBjySDHe6r
	mpJIxIC3ZP/ACUHwoKo5chGv6CiqCDV9HYDFtVZhxnnIdNpypCC0f5JfmqhBE1V2MCLAX0astM8
	Q==
X-Google-Smtp-Source: AGHT+IFxB7cDW2rsqld9Yz9oqhMfcsoEwLrS/BP/u5dMUdlMLbed8X7koUFMcuWWEOnw7mvDGT1HGQ==
X-Received: by 2002:a05:600c:4f53:b0:477:8985:4038 with SMTP id 5b1f17b1804b1-4778fe5e5a9mr30392615e9.13.1763132531255;
        Fri, 14 Nov 2025 07:02:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e43c2fsm146421585e9.6.2025.11.14.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:02:10 -0800 (PST)
Date: Fri, 14 Nov 2025 15:02:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114150209.27354ddd@pumpkin>
In-Reply-To: <20251114085332.396aff85@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114085332.396aff85@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 08:53:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Nov 2025 08:43:46 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I need to add a comment here that entries is not bound by nr_entries.
> > 
> >    https://lore.kernel.org/all/20250730093249.4833be14@gandalf.local.home/
> > 
> > Maybe this?:  
> 
> Or better yet, if this compiles (I haven't tried):
> 
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 33b62ac25c86..253a69b21e76 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,10 +2,14 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  
> +/* Make the cache fit in a 4K page */
> +#define UNWIND_MAX_ENTRIES					\
> +	((SZ_4K - offset_of(struct unwind_cache, entries)) / sizeof(long))
> +
>  struct unwind_cache {
>  	unsigned long		unwind_completed;
>  	unsigned int		nr_entries;
> -	unsigned long		entries[];
> +	unsigned long		entries[UNWIND_MAX_ENTRIES];

That won't compile - I tried it.

You could add __aligned(4096) to force the structure to be padded to 4k,
and then define UNWIND_MAX_ENTRIES in terms of the structure size.

	David

>  };
>  
>  /*
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index dc6040aae3ee..5dfd0ac264d1 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -37,10 +37,6 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
>  }
>  #endif
>  
> -/* Make the cache fit in a 4K page */
> -#define UNWIND_MAX_ENTRIES					\
> -	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
> -
>  /* Guards adding to or removing from the list of callbacks */
>  static DEFINE_MUTEX(callback_mutex);
>  static LIST_HEAD(callbacks);
> @@ -118,8 +114,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
>  		return -EINVAL;
>  
>  	if (!info->cache) {
> -		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
> -				      GFP_KERNEL);
> +		info->cache = kzalloc(sizeof(*cache), GFP_KERNEL);
>  		if (!info->cache)
>  			return -ENOMEM;
>  	}
> 
> -- Steve
> 

