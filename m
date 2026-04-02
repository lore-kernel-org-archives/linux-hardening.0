Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BC308F15;
	Thu,  2 Apr 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118648; cv=none; b=Hz6acYWTpVXqhiFGDK3B5AynhciAAdBwA7fmrGQOsfuyGdB2lKCFr2/bQd/1HN93BNwEwsS/Fd8u7We0dYbD34ES3al9ssI1qFpkd/sCMb2BauLkOJEp2Io+Y43dXLZhid1NF+Zmy/Tv6fDMzW9++IccJgT2CDwFztzpwK+2C4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118648; c=relaxed/simple;
	bh=pxl/fkJM7dYtMIlvsje5y2GJQuVk3FGPx73Bi7fwTEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNBVMNNCcBwP+c5HE6HFFe5eBi1ryttoZuBTBmMBzTBSitAY1zb1oYILOKUH2swc8NB9r0JLoXE2OeYSr8MKkgl1FnAosABlcIOTFNXA2Fe9rbTM8iWP3fT8S1v1YFVqNf/BSCDyGW4m5zt4+3o4bcStfoP9CEavQZgdK/koXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlWKOGIH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlWKOGIH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775118647; x=1806654647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pxl/fkJM7dYtMIlvsje5y2GJQuVk3FGPx73Bi7fwTEw=;
  b=YlWKOGIH+SflkDiRrn7hFZvEIUi5ica7aNu4p/kSdwtefN8lV4D/YFPk
   QwDKW6pP0IhKnqJ1bki68Gkf4s5XKNEqAlDL7gcktXdaIs/KIE4eaezJ/
   t4fgLMC+y7AfElKgyAFKM9z99lJOHlasp3CzP1HQDVZCl1q/CBhQNcUdT
   BKXlx8s+QO9S3siVaPIs46cGSzGZYm+HkqPFRuh2xn+weq2H+hd9gLbIp
   qm54OqQwFn7reJhO3u2aHmXyhU4uxMQjecnWcezhvrk8tHF0dFNP31mVh
   JKdzIeIg1q8RTXygLxTUVO9JUDvub+9Nfb3+Dmr58yBDmc88Cg34wqGtC
   Q==;
X-CSE-ConnectionGUID: EubxaxfyRv6/rR4yx2Xguw==
X-CSE-MsgGUID: Hi/U1GN5ShWNZuNmgEoLeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76063570"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76063570"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:30:46 -0700
X-CSE-ConnectionGUID: oHORlP+pTZ+I5DDFwdjPDQ==
X-CSE-MsgGUID: 5g7pmLHDSyGDS7wMtm149Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="220257882"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:30:45 -0700
Date: Thu, 2 Apr 2026 11:30:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
Message-ID: <ac4pM6kHVI8cK1Xb@ashevche-desk.local>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
 <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
 <aZXDSbyH8tWmTPPL@smile.fi.intel.com>
 <4ece2ada3067d3668fc380d3dcf807ff73073c21.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ece2ada3067d3668fc380d3dcf807ff73073c21.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 09:56:45AM +0300, Dmitry Antipov wrote:
> On Wed, 2026-02-18 at 15:48 +0200, Andy Shevchenko wrote:
> > On Wed, Feb 18, 2026 at 04:40:28PM +0300, Dmitry Antipov wrote:
> > > On Thu, 2026-02-12 at 19:44 +0300, Dmitry Antipov wrote:
> > > 
> > > > Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
> > > > overflows, extend string to 64-bit integer conversion tests, add
> > > > KUnit-based test for 'memparse()' and fix kernel-doc glitches
> > > > found in lib/cmdline.c.
> > > > 
> > > > Dmitry Antipov (5):
> > > >   lib: fix _parse_integer_limit() to handle overflow
> > > >   lib: fix memparse() to handle overflow
> > > >   lib: add more string to 64-bit integer conversion overflow tests
> > > >   lib/cmdline_kunit: add test case for memparse()
> > > >   lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
> > > 
> > > Any chance to move forward with this?
> > 
> > I think it's a grace period due to ongoing merge window.
> > Also we need more input on the first patch from others,
> > perhaps Kees and Andrew can take a look when they will be
> > less busy.
> 
> The same question again...

I'm not sure why. The patches are in Linux Next for several days already.
$ git tag --contains b85c7e022e1c # the last one
next-20260401

Yet it needs to be merged into nomm-stable (if I understood the process right).

-- 
With Best Regards,
Andy Shevchenko


