Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE928B4FA;
	Wed, 18 Feb 2026 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422547; cv=none; b=H3grx9V6BrRwTcNrHk6q8LS7F69ZrvsSMOhMbJ3t9YK0de0X+5Ar0OfXnaHsELehM0tmTp6gCIzX+DjP3kUL1WUCIxQ3Nwtf052ykDOvT8dZfqbPxJq6VhLjANxRGyYnKb9SaGd1yNCCTTwBld6EAFOQhgnj2zrMAgHBYAvBVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422547; c=relaxed/simple;
	bh=J+tX2gMcCPNGlipwjl5pgP6ZPZpe1onLPoQCGIdw6JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpHZDXq0H1HiKN67Ha892rHHK9D74kXmvBFpLColfQ0hBQLHM6QkJODk8kfzAsjNKyGSrG88gCVLQSvq/EfbjdCcMOg5AWF6PFpZKuv49NQYK4X2F6THxVHNiWFUTznMsZUMMG6ZOqWIERI8kfuBOti5Leddv+QFQT3wibTSeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIZCbefx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIZCbefx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771422545; x=1802958545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J+tX2gMcCPNGlipwjl5pgP6ZPZpe1onLPoQCGIdw6JQ=;
  b=ZIZCbefxXwv97r1MAtQOqqUZ7TLpxLOIW5xFnt0O9EA9XaVptnj/s4+W
   7EnGS1GPJlSZynBO4X3IGODlZu+Ncqt1N3TrYKXI2QzTaZogWt/wUHB6x
   M3L+SZrwD9yB3RUGdgusPqjMNZng82pkLKuydnyFjvNNcbCfq93rPMmQd
   rkZqjtlcdWPSTlVJ9Uf1TRKmes58OegpYRS01Gq5Ef/sJ+04x0MV30vb9
   H2E4tVQWQDlkeFi1XDnnQijik2ap8xBY7cCXCPAS/PkpTHHCOsHTxfw1k
   Pw8AUQUi1sJMhECjSSzSSOaC+SRRjAJhBvCMFtGyiMKpwjgbZ58DCPkgT
   A==;
X-CSE-ConnectionGUID: jhpvny15QuKwRNXS2p4t8Q==
X-CSE-MsgGUID: E2gzpzbOTFCrT9oKyL83ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="76355670"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="76355670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:49:01 -0800
X-CSE-ConnectionGUID: NhK3lGd+QDOMYpA8eVjDFA==
X-CSE-MsgGUID: 6iI2G05RS0OPF4lTw9KRWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212289003"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:48:59 -0800
Date: Wed, 18 Feb 2026 15:48:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
Message-ID: <aZXDSbyH8tWmTPPL@smile.fi.intel.com>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
 <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 04:40:28PM +0300, Dmitry Antipov wrote:
> On Thu, 2026-02-12 at 19:44 +0300, Dmitry Antipov wrote:
> 
> > Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
> > overflows, extend string to 64-bit integer conversion tests, add
> > KUnit-based test for 'memparse()' and fix kernel-doc glitches
> > found in lib/cmdline.c.
> > 
> > Dmitry Antipov (5):
> >   lib: fix _parse_integer_limit() to handle overflow
> >   lib: fix memparse() to handle overflow
> >   lib: add more string to 64-bit integer conversion overflow tests
> >   lib/cmdline_kunit: add test case for memparse()
> >   lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
> 
> Any chance to move forward with this?

I think it's a grace period due to ongoing merge window.
Also we need more input on the first patch from others,
perhaps Kees and Andrew can take a look when they will be
less busy.

-- 
With Best Regards,
Andy Shevchenko


