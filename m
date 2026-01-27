Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAF1F63CD;
	Tue, 27 Jan 2026 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504228; cv=none; b=iuayOnpBsS9qUsEbiktuJGmQf9GMq6K5GomnTs0CBcQ37icoOdmDqivDuKPYew7MGSQ1tzHgAbiRYVrvLaA+VEriGzGUkBhSz6eV5lhMHCLoZMGMI1iXD+PlRC3fQcxjSVJ1sLrBjf5xJoRfDMpqKjtnmivHal+XCwRhpFQ76AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504228; c=relaxed/simple;
	bh=B0I0oaZQsAdILuwspLXSS9mmvQz9qSJghCZs0WfsOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd29yfjc7iGM4mhvlyPwWIJclqPyZZwVXfBtdY4BiRmJLlJBkxz/ar9NHBisVO6wBj4JiBNpMMygJRFeUldfgm+tnCVvhqOr1esdb+96Dm2d29Z+DW58bzMw/l/uI0bA0AzgfH2HH/GBE3ZAahbPluQ10H2wvkmUYbMSyAj1qQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwXzZ4iw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwXzZ4iw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769504228; x=1801040228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0I0oaZQsAdILuwspLXSS9mmvQz9qSJghCZs0WfsOQg=;
  b=DwXzZ4iwIbMLwHD7PH2PnKgcqQ+zIn8IRIjmCnkYjork5QjfltBbQwO6
   owVtvAIZfVdswjE2o5qXJdfuuIOyDbc1vzR2Tmll3dZMU5lZqGghLCG55
   OgpCFdu20+Bp1uFk6TiTHOxUrwstFrSpAufr6PB7ucR03OYA/McHxmAqD
   LH5cYkcHe3lvgEL+0UzO3NqPElhmzqeK4hpY4/agI3vgXtJ5vrpmCcpT+
   Sd9jJdWbrhi8qBHJNTs8dzlaj+KLSDXMQNbb2e6u4bcG+T8PBRN/DUa9l
   sI5xXcIT+5fb5zL63wgrKQ2zM5UzK/hqP2Z1ZPNbQroWyP9UiwSg7o96S
   g==;
X-CSE-ConnectionGUID: z4JRXlwXSauQBx6DBWpbFw==
X-CSE-MsgGUID: W4iiwfJUQSqPYLCuCARFRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82122911"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82122911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:57:07 -0800
X-CSE-ConnectionGUID: 4jAFmzE3SJClXjb5Py/jfw==
X-CSE-MsgGUID: 1Rfd1XACRZK1VZjGHVP01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207539221"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:57:02 -0800
Date: Tue, 27 Jan 2026 10:57:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	sohil.mehta@intel.com, charlie@rivosinc.com,
	conor.dooley@microchip.com, samuel.holland@sifive.com,
	linus.walleij@linaro.org, nathan@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 4/8] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <aXh93EVRSOrQQS6l@smile.fi.intel.com>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
 <20260127012558.40025-5-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127012558.40025-5-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 09:25:54AM +0800, Feng Jiang wrote:
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

Acked-by: Andy Shevchenko <andy@kernel.org>
A few nit-picks below.

...

> +static void *alloc_max_bench_buffer(struct kunit *test,
> +		const size_t *lens, size_t count, size_t *buf_len)
> +{
> +	size_t max_len = 0;
> +	void *buf;
> +
> +	for (size_t i = 0; i < count; i++)
> +		max_len = max(lens[i], max_len);

You also need minmax.h.

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
> +	u64 __bn_t;							\


Perhaps a short comment here

	/* Use 10% of the given iterations (maximum 50) to warm up */

> +	__bn_warm_iters = max(__bn_iters / 10, 50U);			\
> +									\
> +	for (size_t __bn_i = 0; __bn_i < __bn_warm_iters; __bn_i++)	\
> +		(void)__func(__VA_ARGS__);				\
> +									\
> +	preempt_disable();						\
> +	__bn_t = ktime_get_ns();					\
> +	for (size_t __bn_i = 0; __bn_i < __bn_iters; __bn_i++)		\
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
> +									\
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

Remove unneeded blank line.

> +		if (_bn_t > 0) {					\
> +			_bn_mbps = (u64)(buf_size) * _bn_iters		\

Why buf_size in the parentheses here and not anywhere else (above)?
I assume it's just an external temporary variable? But why do we need to have
it in the parameters to the macro?

> +					* (NSEC_PER_SEC / MEGA);	\

Leave '*' on the previous line.

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


