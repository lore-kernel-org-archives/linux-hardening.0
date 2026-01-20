Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB01DC9B3;
	Tue, 20 Jan 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895218; cv=none; b=jt1r1xUiTgjmrcELkVW7TkrbkIMFTgESW+N387mp/hTkMFTUxiTSe6TOYwvDMvira1aRZaYexlAge7dqVVUQqzZjhwZ7dNhkXqjWIGw5FBdkCm8YejqHAJNtc60blNDf4HOMavzkH7Z+X1F2WFWIMaTBDdTKyul58VHyY+6XKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895218; c=relaxed/simple;
	bh=pb8tSIzBxYh1mdHVNtiPrkxwBz/DRwHlXyU5R42quzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSXwAC/iP5AGPAK0FtIrG5u6RrGGAa45INZEXVUVfWer1v/e8vOiQ/djYjtVuSKHaoC6IQFuSMWV085eMPDwI1mci/fDSe32h+B8mD5hZ2F2JOJFWYMJ7d28MLmf+/yBl+q0QEUZsImfXCZxj6m+WNLUS+VCxdmY27oAby/APsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmH4riqK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmH4riqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895217; x=1800431217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pb8tSIzBxYh1mdHVNtiPrkxwBz/DRwHlXyU5R42quzg=;
  b=XmH4riqK4olgDKeO8B87xQtuF9xiJ7eY002RSCMVxdgB9HmD6sowhnZA
   +gyOttJUa8+0NmKCyylgOqqwDW+W5TbORmviskyWX2fY0uq8fVkBPrt9r
   vQWOY8yKUcPvD4rUtLvpE+/sH1wdzPJqVjUzugKQ8HA2SL1CZQ3O8QV+x
   pmjlvG5ztg8oqyWU1kr+Ch0UWTgcBkuasCWFRJVucL3MrRw5hSIfnksir
   7Dxt1jTW+IwMR2QGh1f+bN487MRyWv/jPC9vDkB9GYPIdpE7aDwjy4kFY
   +RuvwpP5ckkLTo0YssCj80tPsHsRYHibSmKnjJXnoS//GC/dJMYKanaPE
   g==;
X-CSE-ConnectionGUID: UdrppCDvQa22aAJUaDcOSw==
X-CSE-MsgGUID: pRzxjNSKRAKHTeIbeh1lNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81535183"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81535183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:46:56 -0800
X-CSE-ConnectionGUID: 7rcAUTaoT0OvH3k6m888nQ==
X-CSE-MsgGUID: Z2hO9ovlTva2gue1TaydKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205957242"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:46:51 -0800
Date: Tue, 20 Jan 2026 09:46:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	ardb@kernel.org, charlie@rivosinc.com, conor.dooley@microchip.com,
	ajones@ventanamicro.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 4/8] lib/string_kunit: add performance benchmarks for
 strlen
Message-ID: <aW8y6eC7ZGRYIWkn@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-5-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-5-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:48PM +0800, Feng Jiang wrote:
> Introduce a benchmarking framework to the string_kunit test suite to
> measure the execution efficiency of string functions.
> 
> The implementation is inspired by crc_benchmark(), measuring throughput
> (MB/s) and latency (ns/call) across a range of string lengths. It
> includes a warm-up phase, disables preemption during measurement, and
> uses a fixed seed for reproducible results.
> 
> This allows for comparing different implementations (e.g., generic C vs.
> architecture-optimized assembly) within the KUnit environment.
> 
> Initially, provide benchmarks for strlen().

...

> +#define STRING_BENCH_SEED	888
> +#define STRING_BENCH_WORKLOAD	1000000UL

Can also be (1 * MEGA) from units.h.

...

> +static const size_t bench_lens[] = {
> +	0, 1, 7, 8, 16, 31, 64, 127, 512, 1024, 3173, 4096

Leave trailing comma.

> +};

...

> +static void *alloc_max_bench_buffer(struct kunit *test,
> +		const size_t *lens, size_t count, size_t *buf_len)
> +{
> +	void *buf;
> +	size_t i, max_len = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		if (max_len < lens[i])
> +			max_len = lens[i];
> +	}
> +
> +	/* Add space for NUL terminator */
> +	max_len += 1;

> +	buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
> +	if (buf && buf_len)
> +		*buf_len = max_len;
> +
> +	return buf;

	if (!buf)
		return NULL;

	*buf_len ...
	return buf;

> +}

...

> +static void fill_random_string(char *buf, size_t len)
> +{
> +	size_t i;
> +	struct rnd_state state;

Reversed xmas tree ordering?

> +	if (!buf || !len)
> +		return;
> +
> +	/* Use a fixed seed to ensure deterministic benchmark results */
> +	prandom_seed_state(&state, 888);
> +	prandom_bytes_state(&state, buf, len);
> +
> +	/* Replace null bytes to avoid early string termination */
> +	for (i = 0; i < len; i++) {
> +		if (buf[i] == '\0')
> +			buf[i] = 0x01;
> +	}
> +
> +	buf[len - 1] = '\0';
> +}

...

> +#define STRING_BENCH(iters, func, ...)					\

Is this same / similar code to crc_benchmark()? Perhaps we need to have KUnit
provided macro / environment to perform such tests... Have you talked to KUnit
people about all this?

> +({									\
> +	u64 __bn_t;							\
> +	size_t __bn_i;							\
> +	size_t __bn_iters = (iters);					\
> +	size_t __bn_warm_iters = max_t(size_t, __bn_iters / 10, 50U);	\

Try to avoid max_t() as much as possible. Wouldn't max() suffice?

> +	/* Volatile function pointer prevents dead code elimination */	\
> +	typeof(func) (* volatile __func) = (func);			\
> +									\
> +	for (__bn_i = 0; __bn_i < __bn_warm_iters; __bn_i++)		\
> +		(void)__func(__VA_ARGS__);				\
> +									\
> +	preempt_disable();						\
> +	__bn_t = ktime_get_ns();					\
> +	for (__bn_i = 0; __bn_i < __bn_iters; __bn_i++)			\
> +		(void)__func(__VA_ARGS__);				\
> +	__bn_t = ktime_get_ns() - __bn_t;				\
> +	preempt_enable();						\
> +	__bn_t;								\
> +})
> +
> +/**
> + * STRING_BENCH_BUF() - Benchmark harness for single-buffer functions.
> + * @test: KUnit context.
> + * @buf_name: Local char * variable name to be defined.
> + * @buf_size: Local size_t variable name to be defined.
> + * @func: Function to benchmark.
> + * @...: Extra arguments for @func.
> + *
> + * Prepares a randomized, null-terminated buffer and iterates through lengths
> + * in bench_lens, defining @buf_name and @buf_size in each loop.
> + */
> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> +do {									\
> +	char *buf_name, *_bn_buf;					\
> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
> +									\
> +	if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))			\
> +		kunit_skip(test, "not enabled");			\
> +									\
> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
> +									\
> +	fill_random_string(_bn_buf, _bn_size);				\

> +	_bn_buf[_bn_size - 1] = '\0';					\

You have already this there in the function, no?

> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
> +		buf_size = bench_lens[_bn_i];				\
> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
> +		_bn_iters = STRING_BENCH_WORKLOAD /			\
> +				max_t(size_t, buf_size, 1U);		\

max()

> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
> +									\
> +		if (_bn_t > 0) {					\
> +			_bn_mbps = (u64)(buf_size) * _bn_iters * 1000;	\
> +			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
> +			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
> +		}							\
> +		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
> +				buf_size, _bn_mbps, _bn_lat);		\
> +	}								\
> +} while (0)

-- 
With Best Regards,
Andy Shevchenko


