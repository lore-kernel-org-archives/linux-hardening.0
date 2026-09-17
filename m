Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26447C0FF;
	Thu, 17 Sep 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629718; cv=none; b=qIPOak8iprqnP3IJJ2kjTi2KTx/70fwqhe1LHjTnC4srJXOd9g1V7iwEHpZfwJfTutpornn/oHTc2GaNyH6rkqxGRIo6Un91+5ENIeO2TElFRZ2uAEwInwgNlJUK+0hS349Reic3cb5hx4NxdbCjtzLKDZuUwxI02dnQFUkyReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629718; c=relaxed/simple;
	bh=0pWI1owwg2Gxme2CT2NlF/sakhzZkiXmP5htqFtCBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrIJWahtHTZVWWkhW3awfunkKdx4gIYl39sBq2tElHyrm68CXF5JAfjtDbUCw0+jGSAqjxxcw3m4mpVUHp247Mzq8vC4gPDR2MmlAIm8iLuZkXM1XYqop5a9qM0y9Q8CFoYs5WOAChFYUhAuzxorjYdEGrkClnWM/c1GoZAiigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBO2hf90; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBO2hf90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629713; x=1821165713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pWI1owwg2Gxme2CT2NlF/sakhzZkiXmP5htqFtCBdw=;
  b=bBO2hf90t1Qe5qU5Kq0Xqd0jiKAC69tjKIEwg2dvZRjPeLlLvY1IiouA
   Bem3kNQo7TH3cKVspEZI0kJkzAxjvItHzhv5z1RxWEliiycwU5tEWP1Ej
   plkwIrDbZ34BTnX+BuMYWpEHPGf4JIWl9scEmitp1WmNbOEM7nz/j2Bs1
   7JeaZJmAw0OpJXLO5wGZ9gDebl5FIvx+sovTmra5anKMly9Jvy2x7+MU0
   bF+9ZuF4cgoawg+SgyT4CVxVsNDWuds5GlJngKOOoMFTlbW/dW6uJkX/D
   cFBNJGgUseJDaDJJDwXE9cgGKhNbcY+zihyPbf6IwSDC5LSxdosl8N2fV
   g==;
X-CSE-ConnectionGUID: AF9OMB5gTXSFlCs0yfEtHQ==
X-CSE-MsgGUID: qnuSfPo9SFq/jVsu6xxFLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115559489"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115559489"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:48 -0700
X-CSE-ConnectionGUID: n4jhpPmPSUOakkI3fhYqxg==
X-CSE-MsgGUID: 6D4hMM8eQdaMGtzjLEKmXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270983930"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:46 -0700
Date: Thu, 17 Sep 2026 10:21:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/5] lib/tests: string_helpers: introduce
 test_string_unescape_one
Message-ID: <aquVCG4NwM1ezLLm@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:38:08PM +0200, Jonas Rebmann wrote:
> The existing test_string_unescape() function follows a complex procedure
> where it, given a set of UNESCAPE flags, appends multiple test fragments
> and predicts their unescape result for the chosen set of flags. Rename
> test_string_unescape() to a more descriptive
> test_string_unescape_combined
> 
> In preparation to add simple regression tests, introduce
> test_string_unescape_one() which asserts on exactly one call to
> string_unescape.
> 
> Add some tests for corner cases which already pass.

So, this is two-in-one patch change. Needs a split, but I'm not sure why
we even need this. Can't your case be incorporated into the existing
"combined" variant?

-- 
With Best Regards,
Andy Shevchenko


