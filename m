Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85642467C;
	Thu, 17 Sep 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636131; cv=none; b=KDAsixkBtB18Ps2YiLZBiCLfFbh986xZRubYS7YLbfi+sbvRUxmi0fxgy9gjnRPHhfjdeoJs6CUCAPtikjZ+i/firJe/QEBijx1TVDep+cqs5R6CzQiLDeQBa1d7S9QDyv6DqQt34dptWjmvUNLTV0JY5oNSnJ/dggu1W2Cr4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636131; c=relaxed/simple;
	bh=sCImTtgex6RkAC5SI4v651xOFxCQuHKxp9fOw/jr6eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN9cpd5h9heYo3aYquLUfq+/8iaobTAaW/lEOXRyLBdeweebTweM5Q4982NJDp2kIit8oNeqsSiqZTyZ1eEM/howSzAB6sTWRsFuvD8vj08NlveMz6WoygqTyDYU3QL9jvIftqzDzAzSmugeR1Sxr8cM5z62Z47F414CK+RjA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mao+9DfD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mao+9DfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789636129; x=1821172129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sCImTtgex6RkAC5SI4v651xOFxCQuHKxp9fOw/jr6eY=;
  b=Mao+9DfDevmQcY05HbmOeJUHCAlCGOlHHlabI5PhGk93WKQj7CeH8s6s
   85kWqtWQGHvCPSu6D2+FHS8Zrpth8uN+fcn6JgbOU5fOicSXPyHslQKaj
   V7RAuMCPIsQojYCCMkAKjmJvWCdR6PrM9X2E4xnxYtH1AM3OLoZajzTJU
   6ykehFC2CkApUTvMM0fX4tVdgbolrN+5zMOSE5WjRSMhv5KqWXVVCucT4
   m7yYzAXw4vZuqu2jsy6WGpOHkkfogARX/As7dTTUeMt3mdYcSXp7N1Us9
   oqb+gjFj94S10GOjQUWQJt0RVL0LiP4U/kQNoHAhQwKRPqm/3dVP5KbF/
   w==;
X-CSE-ConnectionGUID: uf1AbyKPRk6DmuXF0Mb9Eg==
X-CSE-MsgGUID: 03Kei1XvRIWR/2tVARBlYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90055610"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90055610"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:08:48 -0700
X-CSE-ConnectionGUID: 5PjGRrfhRbmrHznmpFaCFQ==
X-CSE-MsgGUID: He8ZQOv3QT27/9OONngMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270378840"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:08:46 -0700
Date: Thu, 17 Sep 2026 12:08:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/5] lib/tests: string_helpers: introduce
 test_string_unescape_one
Message-ID: <aquuHKFFN7tGKbCf@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
 <aquVCG4NwM1ezLLm@ashevche-desk.local>
 <7ad3889a-d9f9-426c-916f-3900d2c4ab8a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad3889a-d9f9-426c-916f-3900d2c4ab8a@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 10:58:27AM +0200, Jonas Rebmann wrote:
> On 2026-09-17 09:21, Andy Shevchenko wrote:
> > On Wed, Sep 16, 2026 at 07:38:08PM +0200, Jonas Rebmann wrote:
> > > The existing test_string_unescape() function follows a complex procedure
> > > where it, given a set of UNESCAPE flags, appends multiple test fragments
> > > and predicts their unescape result for the chosen set of flags. Rename
> > > test_string_unescape() to a more descriptive
> > > test_string_unescape_combined
> > > 
> > > In preparation to add simple regression tests, introduce
> > > test_string_unescape_one() which asserts on exactly one call to
> > > string_unescape.
> > > 
> > > Add some tests for corner cases which already pass.
> > 
> > So, this is two-in-one patch change. Needs a split, but I'm not sure why
> > we even need this. Can't your case be incorporated into the existing
> > "combined" variant?
> 
> They can not be incorporated into the combined variant because that
> makes it impossible to control the size of the destination buffer. This
> can not be fixed because the idea of the combined test is that all test
> strings are combined into one buffer. The bugs fixed in this series only
> occur when the destination buffer is limited.

We may modify the loop to provide the length of the destination buffer to be
exactly what we expect, no?

> Furthermore, for the regression tests, I want each test tailored for a
> specific case and when it fails, to show me which one failed.

> I'll update the commit message and split the commit.

-- 
With Best Regards,
Andy Shevchenko


