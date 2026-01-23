Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364E22D78A;
	Fri, 23 Jan 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166137; cv=none; b=lv50DAEuPZv0tGbe1DM5kvnlbQ3vFEa3JQDyeA+TyLasNoPLRrW4u2lxvjR154B7idDXFrIQQCJPcVqSnHuTWdkFxVwINCmQjxXpNge+bWHXS9xpR8g6UvFsLknIGypvE/xsNRCUkuqLNirqjV4FSVZVIIKPPrrMmwRYBwGvO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166137; c=relaxed/simple;
	bh=TnAJh/kYI3vezbRFK4R/V29ptgvspkFfTPz2BdA1TY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1X6fkl4RncSkw5eDSKjbLvmxifaoAg187w3IjyM0Ficihp3VWsGq+eKLsDS4WKx79QaNKdpDcIB+PqqnSr02pnUG8q4bpCR4S0jOdfXeDGy3XRQG65k2DPBDkqip+3HK6KOh4gE/Jl9q/hk9zbi/XDjQI9m+/JZU53+h4bpN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTdxvXIj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTdxvXIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769166133; x=1800702133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TnAJh/kYI3vezbRFK4R/V29ptgvspkFfTPz2BdA1TY0=;
  b=FTdxvXIjGp32+PdhXsUOF/XUqDyOOTLaV4Yyx5Mo00BoY80tbXk+SXy9
   agHzexJ5ZoD8k0IppTn1PyhFtl5nerXJ9yt/zulOqZIOYBgAtlPYGg/fN
   qyI2pF9XX8qSeeLKKYb5afcBJynNoZ1tLDALVd4jig+IcXbdjWWtL9pod
   z1P9LBNRwK5rbik+JvkVk9vYtvyTDczHw/jRRjnue9QOLzweic3iE6S7S
   AzPhkfMQKqED3h3xwxQ+FbwzwYT+BTWtyIPRu1G2CvVE3Dqmwfqd7FmaO
   YTk5Xr/i7P1u/ES1SbyafYlCUyp8O7bY62NrAPG2JLtxN7golmdX/bWeN
   A==;
X-CSE-ConnectionGUID: d8PssuKzSZul9RvyrnaK8g==
X-CSE-MsgGUID: MXvX9FKnTLOcsuTedydodQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74270797"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74270797"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:02:12 -0800
X-CSE-ConnectionGUID: dBmA4e4xR6eGC+YW+e7q0Q==
X-CSE-MsgGUID: spZj5O1RSnOzbrBu0gQN2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="229961255"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:02:09 -0800
Date: Fri, 23 Jan 2026 13:02:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	mingo@kernel.org, charlie@rivosinc.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 4/8] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <aXNVL318XTTQ3tsU@smile.fi.intel.com>
References: <20260123085841.212468-1-jiangfeng@kylinos.cn>
 <20260123085841.212468-5-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123085841.212468-5-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 04:58:37PM +0800, Feng Jiang wrote:
> Introduce a benchmarking framework to the string_kunit test suite to
> measure the execution efficiency of string functions.
> 
> The implementation is inspired by crc_benchmark(), measuring throughput
> (MB/s) and latency (ns/call) across a range of string lengths. It
> includes a warm-up phase, disables preemption during measurement, and
> uses a fixed seed for reproducible results.
> 
> This framework allows for comparing different implementations (e.g.,
> generic C vs. architecture-optimized assembly) within the KUnit
> environment.
> 
> Initially, provide a benchmark for strlen().

...

> +static void *alloc_max_bench_buffer(struct kunit *test,
> +		const size_t *lens, size_t count, size_t *buf_len)
> +{
> +	size_t i, max_len = 0;
> +	void *buf;

> +	for (i = 0; i < count; i++) {
> +		if (max_len < lens[i])
> +			max_len = lens[i];
> +	}

	size_t max_len = 0;
	void *buf;

	for (size_t i = 0; i < count; i++)
		max_len = max(lens[i], max_len);

> +	/* Add space for NUL character */
> +	max_len += 1;
> +
> +	buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	if (buf_len)
> +		*buf_len = max_len;
> +
> +	return buf;
> +}

...

> +#define STRING_BENCH(iters, func, ...)					\
> +({									\
> +	/* Volatile function pointer prevents dead code elimination */	\
> +	typeof(func) (* volatile __func) = (func);			\
> +	size_t __bn_iters = (iters);					\
> +	size_t __bn_warm_iters;						\

> +	size_t __bn_i;							\

Define it inside for-loop:s.

> +	u64 __bn_t;							\
> +									\
> +	__bn_warm_iters = max(__bn_iters / 10, 50U);			\
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

...

> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> +do {									\
> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
> +	char *buf_name, *_bn_buf;					\

> +	if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))			\
> +		kunit_skip(test, "not enabled");			\

Hmm... Since it's a macro anyway, I think the old style is okay:


#if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
	...
#else
#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
	kunit_skip(test, "not enabled");				\
#endif

But check it that it doesn't produce warnings in `make W=1` case.

> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
> +									\
> +	fill_random_string(_bn_buf, _bn_size);				\
> +									\
> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
> +		buf_size = bench_lens[_bn_i];				\
> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
> +		_bn_iters = STRING_BENCH_WORKLOAD / max(buf_size, 1U);	\
> +									\
> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
> +									\
> +		if (_bn_t > 0) {					\
> +			_bn_mbps = (u64)(buf_size) * _bn_iters * 1000;	\

"KILO"? Or "(MEGA/KILO)"? I'm puzzled with this 1000 multiplier.

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


