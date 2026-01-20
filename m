Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222783644DB;
	Tue, 20 Jan 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894295; cv=none; b=fkN3HrmnW+Kxwt1C2D+oe6Aeo7ywyye4V0pEri22SJEk2lqFzE2Bxiuw2nJKNeH90rvKfBxs+4bE9i9SJ01GdCDhMXg+5KUSjJR86TYnCtUul8loKjEs5qMO4JRFRL8u2IAUTJZ4T/pOwlgIsyL9RIy/+X9BN50GWkh/jWgBQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894295; c=relaxed/simple;
	bh=G9HzxjN0Yu3oOjEo97n42KKy1eIhD6tKisYWbW2wsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idRhPUd6N0+k1+kKmw2YKmV36775HQ0iAXUynQxuX95jb6IruPGyHmNxye/mrx/zoH0HwXaJRxrb0HkLAyPCNrOQxKc2WqPMq7vGb6+i8BvKD02CCPyPEzN307Q5RNfUv2LPGPYYjf00xNwFiY8bmwpiffN+pQ/LxQ+OxscZ5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MThM998l; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MThM998l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894294; x=1800430294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G9HzxjN0Yu3oOjEo97n42KKy1eIhD6tKisYWbW2wsH0=;
  b=MThM998lviTFOgGFRL9aceugnz9gKfJ2oTx18JPuMIQE4RQvsDZWMg+h
   mBRnzIgtCnk2p5knOlOuofqXnGX/WBmODFHAg7GOgtPu43CiFvpw7BYp4
   TwBBlCrL6UEe7ZxlK+j912g2uxd6utvGBOc/ZAr745TQXhNDmGjMUMTMA
   Yj5vfEUCge896b5tPdnRwo2o7ha1vKRDBSq8EaK9inoFqtLuuNszwRX3V
   GIExuShWgnVHfpkB/KlWweUfa/vQC6b9/+LSt2MV/jXpC+tFwmhqRwe0b
   deHcQMWwTacF5dY2lbWd/je6r4tRALW7M1Z1CSszIu/6bSYCBfi6VKmlM
   w==;
X-CSE-ConnectionGUID: 1MpyobPaSEq85mbeAUXS5w==
X-CSE-MsgGUID: zpv5gUdlQiqumjazU5B2HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70147475"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70147475"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:31:33 -0800
X-CSE-ConnectionGUID: eFNTO8iUTJ6+e71sTJ6Yvg==
X-CSE-MsgGUID: 6SjcySW9QJu2PdVpZUWjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206078277"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:31:28 -0800
Date: Tue, 20 Jan 2026 09:31:25 +0200
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
Subject: Re: [PATCH v3 6/8] riscv: lib: add strnlen implementation
Message-ID: <aW8vTc4mieqmJKhE@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-7-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-7-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:50PM +0800, Feng Jiang wrote:
> Add an optimized strnlen() implementation for RISC-V. This version
> includes a generic word-at-a-time optimization and a Zbb-powered
> optimization using the 'orc.b' instruction, derived from the strlen
> implementation.
> 
> Benchmark results (QEMU TCG, rv64):
>   Length | Original (MB/s) | Optimized (MB/s) | Improvement
>   -------|-----------------|------------------|------------
>   16 B   | 189             | 310              | +64.0%
>   512 B  | 344             | 1535             | +346.2%
>   4096 B | 363             | 1854             | +410.7%

> Suggested-by: Andy Shevchenko <andy@kernel.org>

Wrong tag, I have zero knowledge about RISC V.

-- 
With Best Regards,
Andy Shevchenko


