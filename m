Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655992E091D;
	Thu, 12 Feb 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907540; cv=none; b=o8VDGavLumNYvCQDq4Mrmtp9BJPke80W0u4ZjWsiEOr2FX+MK3YinDuky6auFm7phoHkg6cej1J79MSpz8tPSv/UeXtYiLwUf5KXIUbO3kJaDIjP3RgLPXiuYBp3CZThTTlKUmvRcFj0RBjDOQ10ctf66aGEP+0akFlCJ1pl1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907540; c=relaxed/simple;
	bh=LmqU5d39cm4T0ml27ZhvPn6arOqxdUDHzdo0e4KWzS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f77RJmZeswOpIQHgnoFtLmNHne6bA1YH3/pB/vdMhUHYepxwS7kw1E7Wsx8Iy162n/ID/CXEaPPxI1l+mNZ+9jyjRJIIaK02Y11aWrQe1JypSUMHqWulqWQW4tS8IXFZ8JWHaTPhgRfVL8BPLYrmfCOHLwWk1gOqJcgA7QRiDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FREUaEla; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FREUaEla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770907540; x=1802443540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmqU5d39cm4T0ml27ZhvPn6arOqxdUDHzdo0e4KWzS8=;
  b=FREUaElaxrjQDvP5Dlneb4C1mLIPWeMi+yuxV3sXXznT4k0Sjlebm5FU
   P4tOMglj6u0R0+bcGlEfdyepWpO6kScGUFzGkRFqI9RQVpMr/hKbA6od1
   gq8mhbZercpRSwD7aw/Wd9l8vOi0GOG96cIdoxpH/FFqRfTPPIjAxjcHT
   tqBelVys5K/qK0pJAkx2qs0Fu1b2YrlVEXfzSpB4m9/hHrAU5PMytT72M
   VmsHezWzAc18sC9K/sb5g5kItxmbyUQLphKmVRBLxQXqSRBtxXBgCAAvc
   SmtAkLNcJXTRKoXwLFYJ6MFNZP88HfTKvrlU4WWO1MAkvu6/5FURBZhyS
   w==;
X-CSE-ConnectionGUID: qEPC1cu6QF+YdUKPagTk3g==
X-CSE-MsgGUID: DpOcGkTMSji3i7jtnxLcIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71795743"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71795743"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:45:39 -0800
X-CSE-ConnectionGUID: Ph1uPDQvRWWaOB+xiotgNQ==
X-CSE-MsgGUID: nrUqYznfRNe/p4xJesqmEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211867347"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:45:37 -0800
Date: Thu, 12 Feb 2026 16:45:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aY3njs-gh9P0cEjj@smile.fi.intel.com>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
 <20260212125628.739276-2-dmantipov@yandex.ru>
 <aY3Yp89R1cl-sacD@smile.fi.intel.com>
 <20260212143239.7039596a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212143239.7039596a@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:32:39PM +0000, David Laight wrote:
> On Thu, 12 Feb 2026 15:41:59 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Feb 12, 2026 at 03:56:24PM +0300, Dmitry Antipov wrote:

...

> > > +	for (rv = 0; max_chars--; rv++, s++) {  
> > 
> > Hmm... is max_chars being used inside for-loop body? I would rather use regular
> > pattern here:
> > 
> > 	for (rv = 0; rv < max_chars; rv++, s++) {
> > 
> > (just check that any integer / sign promotion doesn't change the logic).
> 
> The 'problem' is that the loop sets 'OVERFLOW' in rv.

Ah, true...

-- 
With Best Regards,
Andy Shevchenko


