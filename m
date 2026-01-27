Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B25235045;
	Tue, 27 Jan 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507458; cv=none; b=e5oUFXQbxxPDrjnQGWJ1F1SXKuQOwtoX15uJRQ2KOnldR9GbnW6K4lw5LP5RptxGWATT2UR9TFq55wZ7aTFv9vCUQKXr02g4g4/lADFvCJTuU/liO5yfjs4Pyzh0Z88k7Crqr6HGxuLcHy8UedOOAPZ6UOqydfKlzAFvXmIyN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507458; c=relaxed/simple;
	bh=9JoGMgukM4DO2lRnKpbhZfoRHZo0S35f5oyw0yGG8sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRbrTD6tz1cFX1mjHu3qN4t2SuUfMBr+Msw1k38hwRYB0q0rNS9FNiJUrBP8HSUkdQhWBt1EYk0xDhfoGdqoJL7+xUoUL9n5NMxnlccj7NWFl0FQ4tCro9I7yt0s6wALcv9GJ4haIGGat2w+3oP9TTUFodA1Fzh0bc5FFKDT74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK19/LuI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK19/LuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769507457; x=1801043457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JoGMgukM4DO2lRnKpbhZfoRHZo0S35f5oyw0yGG8sI=;
  b=dK19/LuI8OsPEvVVTuU2fxboeQpTfaE/bfqVa1FonvkhPDwRLLkcJ7mt
   kZsSzRF+E0d9z+STVoiVe//11P+lWUq9y7d86roejPweJZuR0LEP3w2sh
   bZgDTtFaKwmrcCEmkWgNkCQVXK9GtuU4l2Yi4bELd2cuDrex2MhdMB3E1
   C8Ouxv5XLdWLCrIHreLAOlfnaQOtR1k2B5iYZE3nLzrZx7naGYY5tZjIP
   7kDg+zSect0TIVSDvjlW8DmN7/rxjPnQqRgSO44LMMtzlsaKmsQnqePWi
   Fr4DRek3ziT9fELnTxLfBH9b5tubnqWDFBvphPI84wY20iZsmoqybc8f2
   g==;
X-CSE-ConnectionGUID: XEBlY4UpQSGcLd2rtbpATg==
X-CSE-MsgGUID: r3A7P1wgTdGNLXn9npNt6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="58271395"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="58271395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:50:56 -0800
X-CSE-ConnectionGUID: OqvKmhYqSd2jgX+m0sRoEQ==
X-CSE-MsgGUID: 2zHo4xzOTYyK0NqT/J5mqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208301388"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:50:52 -0800
Date: Tue, 27 Jan 2026 11:50:50 +0200
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
Message-ID: <aXiKelsJF-SiqnVS@smile.fi.intel.com>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
 <20260127012558.40025-5-jiangfeng@kylinos.cn>
 <aXh93EVRSOrQQS6l@smile.fi.intel.com>
 <dcdb82e8-691a-4cc1-88d5-755039ed0313@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdb82e8-691a-4cc1-88d5-755039ed0313@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 05:33:10PM +0800, Feng Jiang wrote:
> On 2026/1/27 16:57, Andy Shevchenko wrote:
> > On Tue, Jan 27, 2026 at 09:25:54AM +0800, Feng Jiang wrote:

...

> >> +#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
> >> +do {									\
> >> +	size_t buf_size, _bn_i, _bn_iters, _bn_size = 0;		\
> >> +	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
> >> +	char *buf_name, *_bn_buf;					\
> >> +									\
> >> +	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
> >> +			ARRAY_SIZE(bench_lens), &_bn_size);		\
> >> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
> >> +									\
> >> +	fill_random_string(_bn_buf, _bn_size);				\
> >> +									\
> >> +	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
> >> +		buf_size = bench_lens[_bn_i];				\
> >> +		buf_name = _bn_buf + _bn_size - buf_size - 1;		\
> >> +		_bn_iters = STRING_BENCH_WORKLOAD / max(buf_size, 1U);	\
> >> +									\
> >> +		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
> > 
> >> +									\
> > 
> > Remove unneeded blank line.
> 
> Will fix.
> 
> >> +		if (_bn_t > 0) {					\
> >> +			_bn_mbps = (u64)(buf_size) * _bn_iters		\
> > 
> > Why buf_size in the parentheses here and not anywhere else (above)?
> 
> It was a bit inconsistent. I'll remove the unneeded parentheses for buf_size.
> 
> > I assume it's just an external temporary variable? But why do we need to have
> > it in the parameters to the macro?
> 
> This is necessary because buf_size often needs to be passed as an argument
> to the function under test. For instance, when benchmarking strnlen, the
> caller must pass the current length as an argument:
> STRING_BENCH_BUF(test, buf, len, strnlen, buf, len);

Okay, and why is it needed in this macro? It get overridden immediately in
the loop. Assuming that the array size of bench lengths is not zero, this
has no visible use. Can you elaborate?

> >> +					* (NSEC_PER_SEC / MEGA);	\
> > > Leave '*' on the previous line.
> 
> Will fix.
> 
> >> +			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
> >> +			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
> >> +		}							\
> >> +		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
> >> +				buf_size, _bn_mbps, _bn_lat);		\
> >> +	}								\
> >> +} while (0)

-- 
With Best Regards,
Andy Shevchenko


