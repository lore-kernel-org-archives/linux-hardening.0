Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C0CC07E9D
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 18:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiIZSYr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIZSYL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 14:24:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A94A808
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 11:22:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u69so7313046pgd.2
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LiwNBqos6xaaK3YWH+/WPpsFGSo0QKCNP2I5hOKKSHY=;
        b=W9WSI3Nwcwrph87qzlHpUjhV5B6OODRNvOzC6vexa/UESpjpG7jTsHIx0+dsDGLtKR
         zJqvoqugZ7MjUnsdhsGI90brtn4o4SRlAYpJYIeq4SCgIPRlDLYRAnGGnNWvjmIIQxoZ
         F+/ipxQlCyP3+G+FOADo6OpWnmSf3AREj32Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LiwNBqos6xaaK3YWH+/WPpsFGSo0QKCNP2I5hOKKSHY=;
        b=GTb2U9sDoRKvHXdkRjcr6Nw6Qkz4gSzVFFqRKCiX9SYMGFTeHURLAXIuqOtsPVpMDz
         gb5HKRZSxDvExtkSInaY9uFbrWaEkZPB/N8Q6kGvtliXmnUScGusZvufzL5wzcwGGBdJ
         XlgxNY2AWlbm4YwtzYWgke113Z0WN6zNamQsUZZG1PNr6fdckZOFkrhTs2Ya5V5RdaVs
         eBMixNmpl14yKnliRNqKahe53nOxyL4JOLh1V17pPjbFzFCbUe/POD9ykxagE1MLFT8T
         zFEYUtuiYqmvbqu239zb1twWEil8cUYEIfBW/HpUX19eQog+Yb+OfVgaZT/ktTSVguBi
         cPtA==
X-Gm-Message-State: ACrzQf3uAgRV8b/boAkpBqAl6NuJt23KmD9pvFQKItaPuZ6/2yHy9EXb
        hCl4wmJwZYLk/VMs665ZtSEtMw==
X-Google-Smtp-Source: AMsMyM5P7fwrg4YBL2UFBL9sfng2RuwtvISGX9Ppkmp0AV+/dWK9yRSfS3mblCpuGyPXBRxSMXeDTw==
X-Received: by 2002:a63:f917:0:b0:439:1c07:d1da with SMTP id h23-20020a63f917000000b004391c07d1damr21017743pgi.13.1664216527669;
        Mon, 26 Sep 2022 11:22:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16-20020a63cc50000000b0043be31d490dsm10768624pgi.67.2022.09.26.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:22:06 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:22:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] random: split initialization into early arch step and
 later non-arch step
Message-ID: <202209261105.9C6AEEEE1@keescook>
References: <20220926160332.1473462-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926160332.1473462-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 06:03:32PM +0200, Jason A. Donenfeld wrote:
> The full RNG initialization relies on some timestamps, made possible
> with general functions like time_init() and timekeeping_init(). However,
> these are only available rather late in initialization. Meanwhile, other
> things, such as memory allocator functions, make use of the RNG much
> earlier.
> 
> So split RNG initialization into two phases. We can give arch randomness
> very early on, and then later, after timekeeping and such are available,
> initialize the rest.
> 
> This ensures that, for example, slabs are properly randomized if RDRAND
> is available. Another positive consequence is that on systems with
> RDRAND, running with CONFIG_WARN_ALL_UNSEEDED_RANDOM=y results in no
> warnings at all.

Nice! I like it. Notes below...

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> I intend to take this through the random.git tree, but reviews/acks
> would be appreciated, given that I'm touching init/main.c.
> 
>  drivers/char/random.c  | 47 ++++++++++++++++++++++++------------------
>  include/linux/random.h |  3 ++-
>  init/main.c            | 17 +++++++--------
>  3 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index a90d96f4b3bb..1cb53495e8f7 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -772,18 +772,13 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
>  static struct notifier_block pm_notifier = { .notifier_call = random_pm_notification };
>  
>  /*
> - * The first collection of entropy occurs at system boot while interrupts
> - * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
> - * utsname(), and the command line. Depending on the above configuration knob,
> - * RDSEED may be considered sufficient for initialization. Note that much
> - * earlier setup may already have pushed entropy into the input pool by the
> - * time we get here.
> + * This is called extremely early, before time keeping functionality is
> + * available, but arch randomness is. Interrupts are not yet enabled.
>   */
> -int __init random_init(const char *command_line)
> +void __init random_init_early(const char *command_line)
>  {
> -	ktime_t now = ktime_get_real();
> -	size_t i, longs, arch_bits;
>  	unsigned long entropy[BLAKE2S_BLOCK_SIZE / sizeof(long)];
> +	size_t i, longs, arch_bits;
>  
>  #if defined(LATENT_ENTROPY_PLUGIN)
>  	static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
> @@ -803,34 +798,46 @@ int __init random_init(const char *command_line)
>  			i += longs;
>  			continue;
>  		}

Can find a way to get efi_get_random_bytes() in here too? (As a separate
patch.) I don't see where that actually happens anywhere currently,
and we should have it available at this point in the boot, yes?

> -		entropy[0] = random_get_entropy();
> -		_mix_pool_bytes(entropy, sizeof(*entropy));
>  		arch_bits -= sizeof(*entropy) * 8;
>  		++i;
>  	}
> -	_mix_pool_bytes(&now, sizeof(now));
> -	_mix_pool_bytes(utsname(), sizeof(*(utsname())));

Hm, can't we keep utsname in the early half by using init_utsname() ?

> +
>  	_mix_pool_bytes(command_line, strlen(command_line));
> +
> +	if (trust_cpu)
> +		credit_init_bits(arch_bits);
> +}
> +
> +/*
> + * This is called a little bit after the prior function, and now there is
> + * access to timestamps counters. Interrupts are not yet enabled.
> + */
> +void __init random_init(void)
> +{
> +	unsigned long entropy = random_get_entropy();
> +	ktime_t now = ktime_get_real();
> +
> +	_mix_pool_bytes(utsname(), sizeof(*(utsname())));

(...and then obviously don't repeat it here.)

> +	_mix_pool_bytes(&now, sizeof(now));
> +	_mix_pool_bytes(&entropy, sizeof(entropy));
>  	add_latent_entropy();
>  
>  	/*
> -	 * If we were initialized by the bootloader before jump labels are
> -	 * initialized, then we should enable the static branch here, where
> +	 * If we were initialized by the cpu or bootloader before jump labels
> +	 * are initialized, then we should enable the static branch here, where
>  	 * it's guaranteed that jump labels have been initialized.
>  	 */
>  	if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
>  		crng_set_ready(NULL);
>  
> +	/* Reseed if already seeded by earlier phases. */
>  	if (crng_ready())
>  		crng_reseed();
> -	else if (trust_cpu)
> -		_credit_init_bits(arch_bits);
>  
>  	WARN_ON(register_pm_notifier(&pm_notifier));
>  
> -	WARN(!random_get_entropy(), "Missing cycle counter and fallback timer; RNG "
> -				    "entropy collection will consequently suffer.");
> -	return 0;
> +	WARN(!entropy, "Missing cycle counter and fallback timer; RNG "
> +		       "entropy collection will consequently suffer.");
>  }
>  
>  /*
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 3fec206487f6..a9e6e16f9774 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -72,7 +72,8 @@ static inline unsigned long get_random_canary(void)
>  	return get_random_long() & CANARY_MASK;
>  }
>  
> -int __init random_init(const char *command_line);
> +void __init random_init_early(const char *command_line);
> +void __init random_init(void);
>  bool rng_is_initialized(void);
>  int wait_for_random_bytes(void);
>  
> diff --git a/init/main.c b/init/main.c
> index 1fe7942f5d4a..611886430e28 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -976,6 +976,9 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  		parse_args("Setting extra init args", extra_init_args,
>  			   NULL, 0, -1, -1, NULL, set_init_arg);
>  
> +	/* Call before any memory or allocators are initialized */

Maybe for greater clarity:

	/* Pre-time-keeping entropy collection before allocator init. */

> +	random_init_early(command_line);
> +
>  	/*
>  	 * These use large bootmem allocations and must precede
>  	 * kmem_cache_init()
> @@ -1035,17 +1038,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	hrtimers_init();
>  	softirq_init();
>  	timekeeping_init();
> -	kfence_init();
>  	time_init();

Was there a reason kfence_init() was happening before time_init()?

>  
> -	/*
> -	 * For best initial stack canary entropy, prepare it after:
> -	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
> -	 * - timekeeping_init() for ktime entropy used in random_init()
> -	 * - time_init() for making random_get_entropy() work on some platforms
> -	 * - random_init() to initialize the RNG from from early entropy sources
> -	 */
> -	random_init(command_line);
> +	/* This must be after timekeeping is initialized */
> +	random_init();
> +
> +	/* These make use of the initialized randomness */

I'd clarify this more:

	/* These make use of the fully initialized randomness entropy. */

> +	kfence_init();
>  	boot_init_stack_canary();
>  
>  	perf_event_init();
> -- 
> 2.37.3
> 

-- 
Kees Cook
