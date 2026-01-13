Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0071326D70;
	Tue, 13 Jan 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293985; cv=none; b=ivPK9KJNexU2VkQ3RBpwz1zXfe61VtOFPUIqVpTra0q5P8rXpbYxnpH3YpukYS9TiEPuFhJeZSoM9lPixCn+MGXNAWUFCcM1mo9KSB7g8vMulMBGs5g578OH0YPg8aPgHjOpnVqJgn0CqVe5WOCpQaNCTkJPP3l7Y3qBzU+ytcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293985; c=relaxed/simple;
	bh=LuR1U+G1fxeaAcVaesDQDX6kj+hiGYDQWKnGdmCi+hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZOKLOVw33ypsJcfS2cUND/hBfWA2UIlNwuxNYEU0IA0zINdWsZuldNo/vLg7fGENby+1VLvSYabnxK7W1AFd+o37FynVEZ1taN9gk0FzKd1XhjkRuSL7c/VJWOmprbHeazEFeP7SEsTcV52k0WfBNZlgO4eSF7wa8h+PlK4CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjUVLWmb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjUVLWmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768293984; x=1799829984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LuR1U+G1fxeaAcVaesDQDX6kj+hiGYDQWKnGdmCi+hw=;
  b=UjUVLWmbYOTBnqciRznWo0ogqmUPtTHUic/MsIrXr+7bHOGhi01dNED4
   i+xWIPNLLMShlri1qu8bxa2kCg9YPd+W+bj0AYcF5wijL1LSQSOcTdBEV
   yW4sHhrBFLombVNoav9ZS1oWz17se9NNmyoToxY0pWcgq9pw0JFQsGfO0
   hj9HHewqAxLgZHZVH+TDSnnOgDPA2JZx0MgMv0HgwrqWEEVFVijLgq7JQ
   omyKHldPgT2m/zs9+j4wsQbMd5L31CtLxK5D6NnPr8egYSfxm78wYJvBH
   wqyYms4FaIAr+AKJJzWhvqJobrc01/rbBwNlzriDLxIV6410tisP/sxp9
   Q==;
X-CSE-ConnectionGUID: YISHqdh5SxWocAiS3I1IeA==
X-CSE-MsgGUID: hCMyrUD2Srm6a5n4TLx7lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="86989589"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="86989589"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:46:23 -0800
X-CSE-ConnectionGUID: ZzFm8NyUTlK/FhfmXPjeIA==
X-CSE-MsgGUID: OOPd+QWlR/OVKWtJe7hJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203483672"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:46:19 -0800
Date: Tue, 13 Jan 2026 10:46:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <aWYGWLEekWh3jJVf@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-9-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-9-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:27:42PM +0800, Feng Jiang wrote:
> Introduce a benchmark to compare the architecture-optimized strlen()
> implementation against the generic C version (__generic_strlen).
> 
> The benchmark uses a table-driven approach to evaluate performance
> across different string lengths (short, medium, and long). It employs
> ktime_get() for timing and get_random_bytes() followed by null-byte
> filtering to generate test data that prevents early termination.
> 
> This helps in quantifying the performance gains of architecture-specific
> optimizations on various platforms.

...

> +static void string_test_strlen_bench(struct kunit *test)
> +{
> +	char *buf;
> +	size_t buf_len, iters;
> +	ktime_t start, end;
> +	u64 time_arch, time_generic;
> +
> +	buf_len = get_max_bench_len(bench_cases, ARRAY_SIZE(bench_cases)) + 1;
> +
> +	buf = kunit_kzalloc(test, buf_len, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(bench_cases); i++) {
> +		get_random_nonzero_bytes(buf, bench_cases[i].len);
> +		buf[bench_cases[i].len] = '\0';
> +
> +		iters = bench_cases[i].iterations;
> +
> +		/* 1. Benchmark the architecture-optimized version */
> +		start = ktime_get();
> +		for (unsigned int j = 0; j < iters; j++) {
> +			OPTIMIZER_HIDE_VAR(buf);
> +			(void)strlen(buf);

First Q: Are you sure the compiler doesn't replace this with __builtin_strlen() ?

> +		}
> +		end = ktime_get();
> +		time_arch = ktime_to_ns(ktime_sub(end, start));
> +
> +		/* 2. Benchmark the generic C version */
> +		start = ktime_get();
> +		for (unsigned int j = 0; j < iters; j++) {
> +			OPTIMIZER_HIDE_VAR(buf);
> +			(void)__generic_strlen(buf);
> +		}

Are you sure the warmed up caches do not affect the benchmark? I think you need
to flush / make caches dirty or so on each iteration.

> +		end = ktime_get();
> +		time_generic = ktime_to_ns(ktime_sub(end, start));
> +
> +		string_bench_report(test, "strlen", &bench_cases[i],
> +				time_arch, time_generic);
> +	}
> +}


-- 
With Best Regards,
Andy Shevchenko


