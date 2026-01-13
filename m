Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FB3806B5;
	Tue, 13 Jan 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294359; cv=none; b=RH3w5WrSMwdhZ1VarwYC69qjJj2DSr3EdAKS2fNuVQn1+TYqzTo2YHqeiPm4g198aPeIU4kqjIeG+vO75fkVAsrahZk5CbUg48dl3r57JztcCVXCWzklPEIJqireiEVab34hOD7eCtTZHxTKsC4JrgVAUHTvANj09XzX5CzOaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294359; c=relaxed/simple;
	bh=2w9juWxXXUE4lrZsuZProFjKz0C3LTNwy37wnA64u30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ5YfGv1+9+CYKft57oeG9SCpvBalGgmpIU1k4v5oEt976cwV1qzNEk3e8P1S3irFJsjPkaJmed+g9fpx6XvIcYmjQjuuvdiapDlYnGpH9SI/fUj8j/Zp6H2f+6U+yDwlw1G1swAXz9Iq4wz2u0SgYCECYS1zucsJnBQgvs7vEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVa1jOR/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVa1jOR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768294356; x=1799830356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2w9juWxXXUE4lrZsuZProFjKz0C3LTNwy37wnA64u30=;
  b=UVa1jOR//aDiSS8LgQExNhum8bHUmaqqxksOM3RRISiZ7SzQ+0M2si9b
   PqPki2H4A16k763TjTzSgM9NutaiRcEMvj2nhO/AtEaZuvo4Dur8Wt7Eg
   0/Xy7u7kME0ZepyTXa9maQyW5TVCDKXGx/DK7NARAqXcTCHomY89IVa0m
   8P49x3g2qQMF1XG1U8M1FOO6RmM5pLejv/9hi8NY+YRcLYkCKoiLqRjSU
   Oir1+i2r4K+fLrpS1BSNidY4ngHVkx0BuDBs839tA01Fp5QN3WZTvVJ9/
   83HuPxuWeM2VOfSsRdu2kSGDBHaIiakspKPmsGGbH9mTkviYrIXgjyqyh
   Q==;
X-CSE-ConnectionGUID: J1XFpEtDQom4F5MD5dBfKQ==
X-CSE-MsgGUID: i/Ib0sXOQOOzscdb+42NBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="92242445"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="92242445"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:52:34 -0800
X-CSE-ConnectionGUID: RGJCxMJOTQu/YvscrZy7KQ==
X-CSE-MsgGUID: 7SfGecD0TqqSkqhlMfWbuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="209160773"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:52:30 -0800
Date: Tue, 13 Jan 2026 10:52:29 +0200
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
Subject: Re: [PATCH v2 00/14] riscv: optimize string functions and add kunit
 tests
Message-ID: <aWYHzYRdba03HSIH@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-1-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:27:34PM +0800, Feng Jiang wrote:
> This series introduces optimized assembly implementations for strnlen,
> strchr, and strrchr on the RISC-V architecture. To support a rigorous
> verification process, the series also significantly expands the
> string_kunit test suite with both functional correctness tests and
> performance benchmarks.
> 
> The patchset is organized as follows:
> - Refactoring (Patches 1-4): Extract generic C implementations for
>   strlen, strnlen, strchr, and strrchr into exported __generic_* functions.
> - Correctness Testing (Patches 5-7): Extend string_kunit with detailed
>   functional tests for the target functions.
> - Performance Benchmarking (Patches 8-11): Add a benchmarking framework
>   to string_kunit to measure execution time across various string lengths.
> - RISC-V Optimizations (Patches 12-14): Provide the optimized assembly
>   implementations for the RISC-V architecture.

...

>         # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
>         # string_test_strlen_bench:   arch-optimized: 14100 ns
>         # string_test_strlen_bench:   generic C:      35605600 ns
>         # string_test_strlen_bench:   speedup:        2525.21x

Doesn't sound right. I think you measured cache performance and not your algo.

-- 
With Best Regards,
Andy Shevchenko


