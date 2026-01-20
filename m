Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958513A7F63;
	Tue, 20 Jan 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894350; cv=none; b=cP4NPi1daYlZjpOAcNCvpwpcmzR06rzOBUSv2E12D2hOuSDLeKO8r0Ru7VmIFoq+OzggaHPoFGpyj7FJT+HGF2HWDbhvUVr68S2khfkjvKpedxGD4qZ9nwFx61X41sngZsEZyP1Qg9kp8ZTbmPO6+stkKSqXAP5wAXkKvgYM2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894350; c=relaxed/simple;
	bh=nb3aJk8nyDTzbplwGZGJ0Q/PSSQgwHA8tn4+tbQmuPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbbW0Dc6PP37r3SIgjzkCYfPCxw6OdE40pIsOZoM7Z/xyIfXiMZnqU/ZTc3dSi5pv/d5lOsZVlRfz27a0b9KN8tTLro65+w6WhW4ZrcsxfEmB/0fqXZknNvgpdDnKEnaULfSiDxUNL47K+8FW1K0iALH+u12uNv6L0iogo/e4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU6PzSpc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU6PzSpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894348; x=1800430348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nb3aJk8nyDTzbplwGZGJ0Q/PSSQgwHA8tn4+tbQmuPs=;
  b=gU6PzSpc62pqOLwxNop6JTBrmcBUYhX/EvpZywd3ZBmsCeHe3brW9xa2
   wKs3Q5b/t4rJnnnQqslUTXN9MU1xu26Gznf1wycR75URbo9nQv1CLhJ/t
   kPlv9O2QJc7LtXxHtHm7Rae97QL/58eBXM4j8bKKgBG3D8D/CF4FReSjq
   qwjsBuOnlipZ+HZtL+iL87CvZuObYoVmGRK/AtKsOgCHaRJCLEhGMIWLQ
   ytg3bNMNVEpksOYP4s6Gjl2fyc/FeKy2vO4VEwVcBZUK4c1uQrw6k+Iz1
   Gj40feYpLTQryaw16HktMDdASmBMwP7MLpnoUlnHaKGAEg0kXuuVbtxBU
   g==;
X-CSE-ConnectionGUID: yf+ZehkwRQCLmqJC6JQ9nQ==
X-CSE-MsgGUID: uZYiaUxUTKm/SaFuKOZs4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70147559"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70147559"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:32:28 -0800
X-CSE-ConnectionGUID: tx2GBIdAQea0qouo7OESYA==
X-CSE-MsgGUID: F57grxlgTQGhgqj1ORpCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210893958"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:32:23 -0800
Date: Tue, 20 Jan 2026 09:32:21 +0200
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
Subject: Re: [PATCH v3 8/8] riscv: lib: add strrchr implementation
Message-ID: <aW8vhU-ECUIITPoh@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-9-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-9-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:52PM +0800, Feng Jiang wrote:
> Add an assembly implementation of strrchr() for RISC-V.
> 
> This implementation minimizes instruction count and avoids unnecessary
> memory access to the stack. The performance benefits are most visible
> on small workloads (1-16 bytes) where the architectural savings in
> function overhead outweigh the execution time of the scan loop.
> 
> Benchmark results (QEMU TCG, rv64):
>   Length | Original (MB/s) | Optimized (MB/s) | Improvement
>   -------|-----------------|------------------|------------
>   1 B    | 21              | 22               | +4.7%
>   7 B    | 116             | 122              | +5.1%
>   16 B   | 195             | 208              | +6.6%
>   512 B  | 388             | 399              | +2.8%
>   4096 B | 411             | 411              | +0.0%

> Suggested-by: Andy Shevchenko <andy@kernel.org>

Wrong tag.

-- 
With Best Regards,
Andy Shevchenko


