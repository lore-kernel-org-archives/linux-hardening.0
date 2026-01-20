Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FE3A0E98;
	Tue, 20 Jan 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894606; cv=none; b=fjmStaZ5VT0HcTKfmPGx3DGCL240XXyM2foIzRXMTELHExcNUA+LdPb7QugvJ4R9H0GQ900IKPuBhhD4HK/qXSV7UJBLAAqi21rMNB/oW61VyPllFP6rgtP6wm2grnI7l0XX2mJLTo7UrFQ6HOjkazX6Pv+ZIkCsf7uLk8F/x34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894606; c=relaxed/simple;
	bh=dY/ITLky4ksuqTvlk+bheOz2RwnVsxxlZhktw+2usFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMLJAPW1q76b7Eo2Iw/3AImmBzeLMPGfIEMR7O+x+MN+xI8284TiLEY3zjBQLyZ8nGPqwtU3ps5tvjcfUXzPpqzyjkkyZqYfIMfvg3dOi/+drBttil4ZJaauSP1nLj5cNVO52skm++LEiGXx2f6mrgr5XVxaLUNv5taBF3HUV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFs002E5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFs002E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894604; x=1800430604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dY/ITLky4ksuqTvlk+bheOz2RwnVsxxlZhktw+2usFw=;
  b=IFs002E5CB9Jo/ApkeKzJQUxVeNSLJloUBTGMoVWOz/xk/Xcx/YkIyq9
   xO1lQF+Cifstp1OprEI9DhEk3ZV/JAW+fuukJ6qlmZKePMlNZRTtZYBwz
   6OEKFfKC540VoOW3kAXjrbnwlWc3PCNGifm/F6BDnmfkF+ZFkHAcL3dlT
   3kFe9p1CpA5B2SBLDowlxi8U/RoKMFkd1qJGwD8RKSWGD0wvW7nGKl9cZ
   kjryP/Tfh4YC0+jeIT9cFax/FR8kZQ+TW4kaiGLbK9apVmJ+sdDnrQeyA
   qvXBwZql9Dv4iexknXNHMZRD0KrTPIAlr+TJN6qxPNs7do2Xqb7dxeOZL
   A==;
X-CSE-ConnectionGUID: XHqEpvhuQL+bFp08pFl5pw==
X-CSE-MsgGUID: eoAXKhJwTKOfmTGXjZ0jJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80817802"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80817802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:36:43 -0800
X-CSE-ConnectionGUID: aHKjsF1ETVKAm/rOnd05ig==
X-CSE-MsgGUID: kqcYcfVPSbeawduoR8Oxig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205198375"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:36:39 -0800
Date: Tue, 20 Jan 2026 09:36:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	ardb@kernel.org, charlie@rivosinc.com, conor.dooley@microchip.com,
	ajones@ventanamicro.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit
 tests
Message-ID: <aW8whGcAR0x6FSRJ@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-1-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:44PM +0800, Feng Jiang wrote:
> This series provides optimized implementations of strnlen(), strchr(),
> and strrchr() for the RISC-V architecture. The strnlen implementation
> is derived from the existing optimized strlen. For strchr and strrchr,

strchr() and strrchr()

> the current versions use simple byte-by-byte assembly logic, which
> will serve as a baseline for future Zbb-based optimizations.
> 
> The patch series is organized into three parts:
> 1. Correctness Testing: The first three patches add KUnit test cases
>    for strlen, strnlen, and strrchr to ensure the baseline and optimized

strlen(), strnlen(), and strrchr()

>    versions are functionally correct.
> 2. Benchmarking Tool: Patches 4 and 5 extend string_kunit to include
>    performance measurement capabilities, allowing for comparative
>    analysis within the KUnit environment.
> 3. Architectural Optimizations: The final three patches introduce the
>    RISC-V specific assembly implementations.
> 
> Following suggestions from Andy Shevchenko, performance benchmarks have
> been added to string_kunit.c to provide quantifiable evidence of the
> improvements. Andy provided many specific comments on the implementation
> of the benchmark logic, which is also inspired by Eric Biggers'
> crc_benchmark(). Performance was measured in a QEMU TCG (rv64) environment,
> comparing the generic C implementation with the new RISC-V assembly versions.
> 
> Performance Summary (Improvement %):
> ---------------------------------------------------------------
> Function  |  16 B (Short) |  512 B (Mid) |  4096 B (Long)
> ---------------------------------------------------------------
> strnlen   |    +64.0%     |   +346.2%    |    +410.7%

This is still suspicious.

> strchr    |    +4.0%      |   +6.4%      |    +1.5%
> strrchr   |    +6.6%      |   +2.8%      |    +0.0%
> ---------------------------------------------------------------
> The benchmarks can be reproduced by enabling CONFIG_STRING_KUNIT_BENCH
> and running: ./tools/testing/kunit/kunit.py run --arch=riscv \
> --cross_compile=riscv64-linux-gnu- --kunitconfig=my_string.kunitconfig \
> --raw_output
> 
> The strnlen implementation leverages the Zbb 'orc.b' instruction and

strnlen()

> word-at-a-time logic, showing significant gains as the string length
> increases.

Hmm... Have you tried to optimise the generic implementation to use
word-at-a-time logic and compare?

> For strchr and strrchr, the handwritten assembly reduces

strchr() and strrchr()

> fixed overhead by eliminating stack frame management. The gain is most
> prominent on short strings (1-16B) where function call overhead dominates,
> while the performance converges with the C implementation for longer
> strings in the TCG environment.

-- 
With Best Regards,
Andy Shevchenko


