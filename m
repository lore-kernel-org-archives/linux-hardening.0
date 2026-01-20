Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8669392C3F;
	Tue, 20 Jan 2026 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894327; cv=none; b=jlU5MMJY9l0xopAJCMnuBFgKq8ydwAz99aTNeHG3DLQgx6+tBiSU7nbottb0JFiAPD5xz8ATHckEwTW7lr9+Nkmt0BM0nNaG1zVmu1AUq9gCvdjw0zPqPQOKccPU6ijweEwQw6tkZWz7x73Kxg0BFqMzpYaxDQZPZ00oqUqTego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894327; c=relaxed/simple;
	bh=OmF9ROhAwoFF0+L+lPu8M2077C2feF/Mm1H4FmoZKdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgQQcLQDY/d7cpg7v6khWHC7iQeVFS4bUVXum63uXHw19th7Mixwmqgu5093s6RN2xSyLrm/x1U2aglz9LPsFmuUePT3ZRuEB75bcqs+uLLSBZYv/S/R5GO3ZfFz2fu4XmGdo0vFArkExdRwemeWL0chGMrUswmYgtPXruiZQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNqX+/4L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNqX+/4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894326; x=1800430326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OmF9ROhAwoFF0+L+lPu8M2077C2feF/Mm1H4FmoZKdg=;
  b=YNqX+/4LPq1UFE79sgTAOt4kALcQDH8FFiexZTCV0KmhWANRCW0naipO
   yClrV00jpgngGA4fppWj49+kpeHYD1sUfbO0K2KecdojG+6i7SwFnmzof
   usz3I4JJYQIjgxNPn4NzHxYMVO+MZHWGSgLwFx4/gDH/ZIHI+RlnW93Ns
   sY6SdjBgBMdIUxpTC8mpm+ncamr9efGjgd7X5YBTGt+GGf1mJuyY1SH+g
   zZSGF7E6aCSur58TwVkqlaPhTcs0ZAxzepvYed1w6lNdppZmJD6WqZmOv
   yv1Z+xhUMZgiRtmeoSK7AI4j3esFPVtZWLJ5WMzjvigz9+yL79YQCYyRv
   w==;
X-CSE-ConnectionGUID: 8MBptJOjTpKsQZMWMlFckQ==
X-CSE-MsgGUID: 41m0I82uQRmibDdYGZ+Jpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70147528"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70147528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:32:04 -0800
X-CSE-ConnectionGUID: etsXmKX+TWObLJHg8Be6ew==
X-CSE-MsgGUID: TU+1hW09QCm6DrHHEKu5FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210893899"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:32:00 -0800
Date: Tue, 20 Jan 2026 09:31:57 +0200
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
Subject: Re: [PATCH v3 7/8] riscv: lib: add strchr implementation
Message-ID: <aW8vbXlk-vXVQ8M_@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-8-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-8-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:51PM +0800, Feng Jiang wrote:
> Add an assembly implementation of strchr() for RISC-V.
> 
> By eliminating stack frame management (prologue/epilogue) and optimizing
> the function entries, the assembly version provides significant relative
> gains for short strings where the fixed overhead of the C function is
> most prominent. As the string length increases, the performance converges
> with the byte-oriented scan logic.
> 
> Benchmark results (QEMU TCG, rv64):
>   Length | Original (MB/s) | Optimized (MB/s) | Improvement
>   -------|-----------------|------------------|------------
>   1 B    | 21              | 23               | +9.5%
>   7 B    | 118             | 126              | +6.7%
>   16 B   | 200             | 208              | +4.0%
>   512 B  | 375             | 399              | +6.4%
>   4096 B | 395             | 401              | +1.5%

> Suggested-by: Andy Shevchenko <andy@kernel.org>

Wrong tag.

-- 
With Best Regards,
Andy Shevchenko


