Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68535CBBB;
	Wed, 14 Jan 2026 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375280; cv=none; b=WCnjNAbB9vnGLBy1E5N0BLCm6We4NnDKSeiQzfcLFgIe9RX8lx/OoqJgKfflYGsvlb9zCBhwK2XShW+iJZEc+pTDORRkh3wNTbZedQmtZdc79FcIWvjmw/i1Dm0UlnPM3bNMJ9LxRpWXz5IyG5uPz1eKHL04nIj3jFSYnpNYWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375280; c=relaxed/simple;
	bh=mmjY70xA4kJmtSvrt/yNudpzGyf32tcP39W+0SNo7So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM6zghHnCIsrWHPB4UAkHCyWF8xMKLsxO6PK3OmucWRS3rQlYFanJMUmb2XIfLqe3+LRUwEmXeKZhn5pTdkEb3KqNOSGaO8ttUHmz6eO4spLQMwXlIOz/2JKK6OR7MW+qE+XdDyVTHT7clqVdsO0joKwz9SA/qvc06evV0TGFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zhh/DEpj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zhh/DEpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768375276; x=1799911276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mmjY70xA4kJmtSvrt/yNudpzGyf32tcP39W+0SNo7So=;
  b=Zhh/DEpj3xbDO9Q7ZLQtCrKYu7TA/Lb2HNMMTo8ZX2cwSnNoA6UP0/LQ
   oDsM5lVIrZ4NfNQyPmGpQUojrifgzvbgAyckMwpOuQh/iPHZJhBnc80LN
   kiAhQsledf2JGRlZkdE2GSxo98YeON73/JiCYAJCvpEVQQaecUuVZpt/o
   tLVnVDKEGC6aRj1S/S6AGUhL5vTsBazAcN7hobs+zm15lKH7HwxxAxReA
   YbLEm90YF9jGESnWH3N6Dp6lY82frJdj07Oy2wKS0O/7Ru+BsDyvjHOz7
   0sv7zoFHDax6vr0ODAKJVwUtVM92BT/ocGl2Uskfg34vZZx4+lcDJNvFg
   w==;
X-CSE-ConnectionGUID: nBrFSeA6QvCqLUlh/4RhGg==
X-CSE-MsgGUID: Y9qmUetPReSp0Z0IMQzuPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="81033881"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="81033881"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:21:07 -0800
X-CSE-ConnectionGUID: /wvwk29fTw6Bl2yqMqnRbg==
X-CSE-MsgGUID: buH5lw+ZSYiWMRM4xlmZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204618101"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:21:03 -0800
Date: Wed, 14 Jan 2026 09:21:00 +0200
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
Message-ID: <aWdD3N_jwnt_ncc1@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-9-jiangfeng@kylinos.cn>
 <aWYGWLEekWh3jJVf@smile.fi.intel.com>
 <b06e4a63-85c2-4420-8077-f4c059ef33fb@kylinos.cn>
 <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a58e97ad-a69e-498d-9382-2be4914569b0@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 03:04:58PM +0800, Feng Jiang wrote:
> On 2026/1/14 14:14, Feng Jiang wrote:
> > On 2026/1/13 16:46, Andy Shevchenko wrote:

...

> > Thank you for the catch. You are absolutely correct—the 2500x figure is heavily
> > distorted and does not reflect real-world performance.
> > 
> > I've found that by using a volatile function pointer to call the implementations
> > (instead of direct calls), the results returned to a realistic range. It appears
> > the previous benchmark logic allowed the compiler to over-optimize the test loop
> > in ways that skewed the data.
> > 
> > I will refactor the benchmark logic in v3, specifically referencing the crc32
> > KUnit implementation (e.g., using warm-up loops and adding preempt_disable()
> > to eliminate context-switch interference) to ensure the data is robust and accurate.
> > 
> 
> Just a quick follow-up: I've also verified that using a volatile variable to store
> the return value (as seen in crc_benchmark()) is equally effective at preventing
> the optimization.
> 
> The core change is as follows:
> 
>     volatile size_t len;
>     ...
>     for (unsigned int j = 0; j < iters; j++) {
>         OPTIMIZER_HIDE_VAR(buf);
>         len = strlen(buf);

But please, check for sure this is Linux kernel generic implementation (before)
and not __builtin_strlen() from GCC. (OTOH, it would be nice to benchmark that
one as well, although I think that __builtin_strlen() in general maybe slightly
better choice than Linux kernel generic implementation.) I.o.w. be sure *what*
you test.

>     }

Or using WRITE_ONCE() :-) But that one will probably be confusing as it usually
should be paired with READ_ONCE() somewhere else in the code. So, I agree on
crc_benchmark() approach taken.

> Preliminary results with this change look much more reasonable:
> 
>     ok 4 string_test_strlen
>     # string_test_strlen_bench: strlen performance (short, len: 8, iters: 100000):
>     # string_test_strlen_bench:   arch-optimized: 4767500 ns
>     # string_test_strlen_bench:   generic C:      5815800 ns
>     # string_test_strlen_bench:   speedup:        1.21x
>     # string_test_strlen_bench: strlen performance (medium, len: 64, iters: 100000):
>     # string_test_strlen_bench:   arch-optimized: 6573600 ns
>     # string_test_strlen_bench:   generic C:      16342500 ns
>     # string_test_strlen_bench:   speedup:        2.48x
>     # string_test_strlen_bench: strlen performance (long, len: 2048, iters: 10000):
>     # string_test_strlen_bench:   arch-optimized: 7931000 ns
>     # string_test_strlen_bench:   generic C:      35347300 ns
>     # string_test_strlen_bench:   speedup:        4.45x
>     ok 5 string_test_strlen_bench
> 
> I will adopt this pattern in v3, along with cache warm-up and preempt_disable(),
> to stay consistent with existing kernel benchmarks and ensure robust measurements.

-- 
With Best Regards,
Andy Shevchenko


