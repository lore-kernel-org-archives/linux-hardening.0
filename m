Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DE3C1D
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497222; cv=none; b=J9qBr5CDq+nosuLqqgRqkvVify91PZablqlrHViJbNHi4i5r8RwX01IZ4z2/T9Oe2NlknT8wDz47s7OswxZV2Sx1DxCLPrRKVr0V04GuDce+F66BdNhAhdkJNz+HrvI5rnHEGIXKHHOYZ2xj0xQt74E1mI2+8F8oonWc+9TKz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497222; c=relaxed/simple;
	bh=9U1qnNv3hOvzoqGjHv7re9Rl7YDROl8tLzYgiXvD8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCHb+FeGiJ+y/r5OGdtxhh3L73ymAGOXtxrSWswcRD1Ii2YgGzc0jdW0bBl7JRKmPrkXP8yusikuuiFMJ70kSgAnqa9dL1XcqqoQxvqsSNGtq0PcNtpxn5LELQXv+aozKUKPkvjOoMt8e5gf3B8G6Bpz9j0qlyIaqIzbq+B1Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnxuGOqj; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnxuGOqj"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21e45ed41d7so2601787fac.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Feb 2024 22:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708497220; x=1709102020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzG1h3rFdE35vHs4nCO34Dzxpa3CLJjuLbNEkFJHymk=;
        b=dnxuGOqjQYE1lvChAb1rUVy8+8bd0kZhJXAef+kOuUKVHoC4IyZ5hfd/qZMjiTAfBx
         Bjvw8nzmeVSi0XwZPS+VKmR/4CVOdIt75fwcaciPxVIAfZye+e6mEGh+jTuO7c0PBQPQ
         yG+NxBxgHMo4vbbyXpP8gK/QtXWUWA/VvOw+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497220; x=1709102020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzG1h3rFdE35vHs4nCO34Dzxpa3CLJjuLbNEkFJHymk=;
        b=rzqKmmWPv48PdqoIFZ1Qoup+Cl5jSVNTVkzByUj7lRlbOaqEPirl6ZqOT3pchEeqhf
         Qm89kGAe94HxnQ7CYJYbt4bfWcrwjOwpRHKxd00MwCRt54kbNJOVUbEPHczUDTh4a2IP
         ugpimi0RkcQil/hhNiHfoyOYfUDIWD0QdP8gqzDmFkHdx7Mt//5gy+b1Y2r7t4suv8UL
         pWmfkWOZUsDJEHtc18H7teeNllR4bGm+6cvnkN9Cvugslf6itN1Jd+4DY/pNXe5pd7m7
         jQkkb1ekNiLiGoyKvdnB06IiVXwJnpqxGBcVDZc5r2e5LQPEPyUgtnCZHlrU0WYPrSxd
         muaA==
X-Forwarded-Encrypted: i=1; AJvYcCVMg3jMou2cgxvT4zKHvi/maQ+GJf4LTtQrYzHyu/wId0EeezUvUqIGvW/wjIGrRsOKT3SXhncJHdgVrdeSNMtLocgmQ9/PoGYOQIoGV+gh
X-Gm-Message-State: AOJu0YzpJZ3yEzGVRDNNeHL0ZRb6bwMLHKXn+QxAGbBfK/3RA/MmtdxC
	uo/kIfAomWhURlBcmIcz+OfF0AMZ0BeYXumbRUrFekXJFmtGarRzTy9xSFRxYA==
X-Google-Smtp-Source: AGHT+IHS0EkkrYoLQUwOe/rW4LoTJCwu0I6ZorfS97z10oAfJ3Ro71jhHZu8xNKWwV345YFzvVeUNg==
X-Received: by 2002:a05:6871:3a2a:b0:21e:d654:5c3f with SMTP id pu42-20020a0568713a2a00b0021ed6545c3fmr8228175oac.37.1708497220277;
        Tue, 20 Feb 2024 22:33:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm6682307pgm.10.2024.02.20.22.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:33:39 -0800 (PST)
Date: Tue, 20 Feb 2024 22:33:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, gustavoars@kernel.org, mark.rutland@arm.com,
	rostedt@goodmis.org, arnd@arndb.de, broonie@kernel.org,
	guohui@uniontech.com, Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202402202226.A6817927@keescook>
References: <20240221020258.1210148-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221020258.1210148-1-jeremy.linton@arm.com>

On Tue, Feb 20, 2024 at 08:02:58PM -0600, Jeremy Linton wrote:
> The existing arm64 stack randomization uses the kernel rng to acquire
> 5 bits of address space randomization. This is problematic because it
> creates non determinism in the syscall path when the rng needs to be
> generated or reseeded. This shows up as large tail latencies in some
> benchmarks and directly affects the minimum RT latencies as seen by
> cyclictest.

Some questions:

- for benchmarks, why not disable kstack randomization?
- if the existing pRNG reseeding is a problem here, why isn't it a
  problem in the many other places it's used?
- I though the pRNG already did out-of-line reseeding?

> Other architectures are using timers/cycle counters for this function,
> which is sketchy from a randomization perspective because it should be
> possible to estimate this value from knowledge of the syscall return
> time, and from reading the current value of the timer/counters.

The expectation is that it would be, at best, unstable.

> So, a poor rng should be better than the cycle counter if it is hard
> to extract the stack offsets sufficiently to be able to detect the
> PRNG's period.
> 
> So, we can potentially choose a 'better' or larger PRNG, going as far
> as using one of the CSPRNGs already in the kernel, but the overhead
> increases appropriately. Further, there are a few options for
> reseeding, possibly out of the syscall path, but is it even useful in
> this case?

I'd love to find a way to avoid an pRNG that could be reconstructed
given enough samples. (But perhaps this xorshift RNG resists that?)

-Kees

> Reported-by: James Yang <james.yang@arm.com>
> Reported-by: Shiyou Huang <shiyou.huang@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/syscall.c | 55 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a70d9746b66..70143cb8c7be 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -37,6 +37,59 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
>  	return syscall_fn(regs);
>  }
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +DEFINE_PER_CPU(u32, kstackrng);
> +static u32 xorshift32(u32 state)
> +{
> +	/*
> +	 * From top of page 4 of Marsaglia, "Xorshift RNGs"
> +	 * This algorithm is intended to have a period 2^32 -1
> +	 * And should not be used anywhere else outside of this
> +	 * code path.
> +	 */
> +	state ^= state << 13;
> +	state ^= state >> 17;
> +	state ^= state << 5;
> +	return state;
> +}
> +
> +static u16 kstack_rng(void)
> +{
> +	u32 rng = raw_cpu_read(kstackrng);
> +
> +	rng = xorshift32(rng);
> +	raw_cpu_write(kstackrng, rng);
> +	return rng & 0x1ff;
> +}
> +
> +/* Should we reseed? */
> +static int kstack_rng_setup(unsigned int cpu)
> +{
> +	u32 rng_seed;
> +
> +	do {
> +		rng_seed = get_random_u32();
> +	} while (!rng_seed);
> +	raw_cpu_write(kstackrng, rng_seed);
> +	return 0;
> +}
> +
> +static int kstack_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
> +				kstack_rng_setup, NULL);
> +	if (ret < 0)
> +		pr_err("kstack: failed to register rng callbacks.\n");
> +	return 0;
> +}
> +
> +arch_initcall(kstack_init);
> +#else
> +static u16 kstack_rng(void) { return 0; }
> +#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> +
>  static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  			   unsigned int sc_nr,
>  			   const syscall_fn_t syscall_table[])
> @@ -66,7 +119,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	 *
>  	 * The resulting 5 bits of entropy is seen in SP[8:4].
>  	 */
> -	choose_random_kstack_offset(get_random_u16() & 0x1FF);
> +	choose_random_kstack_offset(kstack_rng());
>  }
>  
>  static inline bool has_syscall_work(unsigned long flags)
> -- 
> 2.43.0
> 

-- 
Kees Cook
