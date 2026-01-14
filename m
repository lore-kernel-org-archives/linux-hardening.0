Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7D378D69;
	Wed, 14 Jan 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374478; cv=none; b=aGFOOUr6tQuRBTaqzAemqLhN7JtImv1gAiVLn9smGVe96uVzmfayowWzm4wgw3G2XYXR1EuwN16iwxk+lSk8aLMzB7QlDZJK57rLCLSocNugzNnDP0kjSDBnAh+1fa8as4kmponXTvDdM8mBYf5Fqm5efuOytejpGK8sUrd1sB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374478; c=relaxed/simple;
	bh=2z55lQeEFN0tV+1Vom2Fy3lGVm2xlsns7xXqQyYQ5mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovqWT+aLfzyF6eD0/FAEBO5CIR3eL04MoVXUGUESxvGPb9E22sFuL6rD6ANTDqb89CMp2lzckHmnqwmSnUIo2RnkYsjY8y96Dq79Tdqrbh7+ZWnjcsqjIxcMkYoMn/5kTjoOYQ0kkl9JBp1Uz759KznmjHPSgnCWaRhdCD6UZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RU31QgFC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RU31QgFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768374474; x=1799910474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2z55lQeEFN0tV+1Vom2Fy3lGVm2xlsns7xXqQyYQ5mY=;
  b=RU31QgFCtiSKvuR6TOKEVx84at4eSFpivopPdyJTkyZfzrQSnGtm2A7k
   HnJUJatvHvnNXJmhUL6kph2aN0R+/OjtfaYkvWrczqawOSKiZ9+NYk5A4
   EbljbAjVZz8tzkx5Ro/SBTOsnaijlrPV3VWe7s026JRO9WP8A+l9Xw5lL
   dHa/8q829Pc1pdh+i9cx+c5kzxR8QMgTvleyK9GKFpo8w6FRn5nvSDbGG
   Ycd2tZ1h3zXcVieb5d7rF+dgHS78etwXKi9qtMx6eSW8C4DFeriE9KfQh
   UyhHZ6zMTd9ZzYyfhQ3s8lxlhrxIg6L4hPrSDjqd8AI8tRhTdjijH1fbL
   A==;
X-CSE-ConnectionGUID: 4avcLj0kTz6sNVA/Nu6Dxw==
X-CSE-MsgGUID: R0Gmu5exSGePtDjAqNADhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69588037"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69588037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:07:51 -0800
X-CSE-ConnectionGUID: mfcot9iJSQ+9+7LLinCy0Q==
X-CSE-MsgGUID: YAYONSpeRc+yCnfwbsdTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235317211"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:07:47 -0800
Date: Wed, 14 Jan 2026 09:07:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Feng Jiang <jiangfeng@kylinos.cn>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
	andy@kernel.org, akpm@linux-foundation.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
Message-ID: <aWdAwHy77V8EiDeX@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-2-jiangfeng@kylinos.cn>
 <20260114000151.GB2178@quark>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114000151.GB2178@quark>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:01:51PM -0800, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 04:27:35PM +0800, Feng Jiang wrote:
> > To support performance benchmarking in KUnit tests, extract the
> > generic C implementation of strlen() into a standalone function
> > __generic_strlen(). This allows tests to compare architecture-optimized
> > versions against the generic baseline without duplicating code.

...

> A similar problem exists with the architecture-optimized CRC and crypto
> functions.  Historically, these subsystems exported both generic and
> architecture-optimized functions.
> 
> We've actually been moving away from that design to simplify things.
> For example, for CRC-32C there's now just the crc32c() function which
> delegates to the "best" CRC-32C implementation, with no direct access to
> the generic implementation of CRC-32C.
> 
> crc_kunit then just tests and benchmarks crc32c().  To check how the
> performance of crc32c() changes when its implementation changes (whether
> the change is the addition of an arch-optimized implementation or a
> change in an existing arch-optimized implementation), the developer just
> needs to run crc_kunit with two kernels, before and after.
> 
> I suggest just doing that.  In that case there would be no need to
> export the generic implementations of these functions.

This also would work for me! Whatever, folks, you find the best from the
readability and maintenance point of view.

> (Also note that *if* the generic functions are exported, they probably
> should be exported only when the KUnit test is enabled.  There's no need
> to include them in the kernel image when the test isn't enabled.)

True.

-- 
With Best Regards,
Andy Shevchenko


