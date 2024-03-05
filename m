Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0A12D215
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681639; cv=none; b=Eb6YawGWjmOgG72n+QyimFOATR69ZN9xEfVyuElzQ2XzDR/vlsCtQsyC5Otn66s+vMJXcmptNJSynWj68fK+z0uy7IIsaqpRn0bdEBHfT7+J67TzkzzdSvsfieVFIDxLRV7hq1YvGVl1BXLkGlVcRjAqdxzxhWPjA1KBO9mhAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681639; c=relaxed/simple;
	bh=1SnJ59Ps7URmLCLfC/TBTkRIQ6+QZh83O+LxVECZ4eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUyMe5lON+6H/vxT48pv9uxL0pJ6Vb3K1PTSpqEl5v1uAyGJw9wNkj6Hq+lNrNzuN9tMDJPHyHyS4IYKdw710fZdb7+z7z/1QWXDibdMn2UjTDmQC+XLY1qpMSZ61jqeRShPlQRbyTebNUa8eQapprIGKVdD4F/G7KfBpurCGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDoNyAqj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDoNyAqj"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso256744b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 15:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709681637; x=1710286437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVqJYG4NwJpbVhIQ4ejb78hlZKAflZdt5zQRCQZdbhg=;
        b=YDoNyAqjT4+JsgTrVnl6OAgF1k64GJMlbCpU5D4eDqNf2O9lAGCgFz+aAhOLoIHwhd
         TD7DBSOjOK4eP0tZwdcV4Mv0gyUEaI4uyNQ2nrVSa7h412iV3qbbB3tAONSQjBafu044
         us7oVi+DRKkVfH+7Aq5xqFtH94K1j+tykG6J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681637; x=1710286437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVqJYG4NwJpbVhIQ4ejb78hlZKAflZdt5zQRCQZdbhg=;
        b=GVGG5o9eG286EAX5wA807WBEzLHkJgbB7Vk9GovowI+F8GW/lZ7R3IcV4XfUsLSfAG
         xt0Ii3D1wHonHd+nXFOgMoXI/MXbqRdNPZzug36OZ01/6IiJ+fe59mracSklF753J7Af
         NimeCPVEEs61Sy/Vo9Zu07FzuEC7fLlrps5wf5PX6cgIUzWIHHWx5QxMqPNAAXfTRAfo
         6tdr9/PyGmmj6g/jIPPB2ygM2H/8+qa6zoJ/1vd29Q6yi8dE+bl/WnRTYQ2ZYajoKBI9
         DYBxdvmXD0yyn9MinmLcvVP8o4qsefDNTtlLHGmA6mp2eDPAfuX9JKItr8gKFZmnXRgs
         ueew==
X-Forwarded-Encrypted: i=1; AJvYcCWAt/GH7DsK1TMl9xC9O8e6V8y0i8m/lqzfR183ROuk2O2M4iLzFCISN6pHOH4XiIWTc+sD9hvexDj//IYLdTkyy+MzoOVJqoVa8ZbzRsP/
X-Gm-Message-State: AOJu0YytZZCtsBZuwX7yktmjQLt+wbPLIoCgG3Z40XgtCt3wl5T/4Po6
	dZInuhMUWoXtje6CIP6RmnVC6eXp1C6EH1stPBvkkOVisHIFsM/giEAcWiRDTg==
X-Google-Smtp-Source: AGHT+IHQdYS5+xMryfTT1IOdZhcc6rZew5WCVjHi9VllATBYGMQVhc0/wPSb9IRr0q52NcbVnxEBdQ==
X-Received: by 2002:a05:6a00:1ac7:b0:6e6:27d3:96ab with SMTP id f7-20020a056a001ac700b006e627d396abmr6963065pfv.16.1709681636969;
        Tue, 05 Mar 2024 15:33:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm9524721pfl.123.2024.03.05.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:33:55 -0800 (PST)
Date: Tue, 5 Mar 2024 15:33:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, Jason@zx2c4.com, gustavoars@kernel.org,
	mark.rutland@arm.com, rostedt@goodmis.org, arnd@arndb.de,
	broonie@kernel.org, guohui@uniontech.com, Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403051526.0BE26F99E@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305221824.3300322-2-jeremy.linton@arm.com>

On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
> The existing arm64 stack randomization uses the kernel rng to acquire
> 5 bits of address space randomization. This is problematic because it
> creates non determinism in the syscall path when the rng needs to be
> generated or reseeded. This shows up as large tail latencies in some
> benchmarks and directly affects the minimum RT latencies as seen by
> cyclictest.
> 
> Other architectures are using timers/cycle counters for this function,
> which is sketchy from a randomization perspective because it should be
> possible to estimate this value from knowledge of the syscall return
> time, and from reading the current value of the timer/counters.
> 
> So, a poor rng should be better than the cycle counter if it is hard
> to extract the stack offsets sufficiently to be able to detect the
> PRNG's period. Lets downgrade from get_random_u16() to
> prandom_u32_state() under the theory that the danger of someone
> guessing the 1 in 32 per call offset, is larger than that of being
> able to extract sufficient history to accurately predict future
> offsets. Further it should be safer to run with prandom_u32_state than
> disabling stack randomization for those subset of applications where the
> difference in latency is on the order of ~5X worse.
> 
> Reported-by: James Yang <james.yang@arm.com>
> Reported-by: Shiyou Huang <shiyou.huang@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/syscall.c | 42 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a70d9746b66..33b3ea4adff8 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -5,6 +5,7 @@
>  #include <linux/errno.h>
>  #include <linux/nospec.h>
>  #include <linux/ptrace.h>
> +#include <linux/prandom.h>
>  #include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  
> @@ -37,6 +38,45 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>  	return syscall_fn(regs);
>  }
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +DEFINE_PER_CPU(struct rnd_state, kstackrng);
> +
> +static u16 kstack_rng(void)
> +{
> +	u32 rng = prandom_u32_state(this_cpu_ptr(&kstackrng));
> +
> +	return rng & 0x1ff;
> +}
> +
> +/* Should we reseed? */
> +static int kstack_rng_setup(unsigned int cpu)
> +{
> +	u32 rng_seed;
> +
> +	/* zero should be avoided as a seed */
> +	do {
> +		rng_seed = get_random_u32();
> +	} while (!rng_seed);
> +	prandom_seed_state(this_cpu_ptr(&kstackrng), rng_seed);
> +	return 0;
> +}
> +
> +static int kstack_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
> +				kstack_rng_setup, NULL);

This will run initial seeding, but don't we need to reseed this with
some kind of frequency?

Otherwise, seems fine to me.

-- 
Kees Cook
