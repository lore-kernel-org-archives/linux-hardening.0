Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8E4FB9DF;
	Thu, 17 Sep 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648347; cv=none; b=MdSN5ppXSRVe0pWmMEVuxe+EDQmdYIRosH4+nAneJzZXnb3/XAYG5cfnNbRmkCNAAk6++2AS1uBnkXFgcBjxvHtBlkaaBmlDCSLp+jUrUdcfU/6AWKUGDfsEe/N0Jc31mP+BlnQ3x1agBWrkCkC3ml69ytVDeX6DFjavRQhVeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648347; c=relaxed/simple;
	bh=TXviPstt43oqdt/S8lXvxEH3Jr6SXOhu1KleLF12y6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR35wXosWlU29+dgRny8/vmIHC/CsrVsanD/YraiaMn2JKpJLlfNBWqvHuohinibziFjXiK0S6+0tTnC+ghBjM3WwZIgnEGgwBd6B5GQbOhypcIV+YDQGLGiQedg2ifOnO7FeEa+xelzwWgkV+wzY5l0NuQQvAVxLAbKQgXMgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvJfGXP5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvJfGXP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789648338; x=1821184338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXviPstt43oqdt/S8lXvxEH3Jr6SXOhu1KleLF12y6c=;
  b=CvJfGXP5wyUuxGdCvsw58yK4Y81RJYej6JffpAex7IoWAB3UQXsByplr
   ZOsLUasJ+J2E6SzyIneQ0gnHjnpfI6o2as+T8N9as0Gckfa/KtyhSvcCY
   FI1SDfcmSA57+DnRMYZANDQihjzDqK7thLJJHqlPfssAQsY7x6lzJhEiI
   Q13F8ccggGYxsdBSUlSy8R8yk2pO8Y33h6HvBl1/JRxlmT+X+3LzJXbf1
   wX/PqxvgIltPJ0Pz0LSyDqiA6vqJBhqWlolsPGKshNK4/YAGOpOqD5QNU
   pi5GZjk5yeKfUjpCbbTa8ImQfcSSeBJPjHEXu94AQU0vBxYae1QmqU0Tg
   Q==;
X-CSE-ConnectionGUID: s5Cr9iIFSTK94DGTzPetqA==
X-CSE-MsgGUID: W02mfBVdROu8AcPrr47/kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115601473"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115601473"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:32:13 -0700
X-CSE-ConnectionGUID: b/gsi3SeQ/6QBcJHA1l55A==
X-CSE-MsgGUID: SHWTCUXiTXanZepb4szeag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271123228"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:32:10 -0700
Date: Thu, 17 Sep 2026 15:32:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/5] lib/string_helpers: use full destination buffer in
 string_unescape()
Message-ID: <aqvdyIsM_TV4OC4W@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
 <aquahuZKdB1haZrN@ashevche-desk.local>
 <ae3d04de-b12b-454d-93f7-31ce912f6f8c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3d04de-b12b-454d-93f7-31ce912f6f8c@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 11:02:52AM +0200, Jonas Rebmann wrote:
> On 2026-09-17 09:45, Andy Shevchenko wrote:
> > On Wed, Sep 16, 2026 at 07:38:09PM +0200, Jonas Rebmann wrote:

...

> > > +	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
> > > +	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
> > 
> > Still wondering if we can incorporate this into the "combined" loop?
> 
> Both these tests really only fail without my fixes because the
> destination buffer is short, barely fitting the result.
> 
> With a buffer length of 4 it yields "A\", for 5 "AA" and for 6 "AAB",
> a bug because "AAB" would fit the 4 byte buffer too.

So, we need to extend the current loop to pass the buffer length like -5, -4,
-3, -2, -1, 0, +1 from the expected length and check that it's cut correctly
along with no garbage at the end. It will help all test cases, and not just
a single one or a couple.

-- 
With Best Regards,
Andy Shevchenko


