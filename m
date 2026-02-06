Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F173559D0;
	Fri,  6 Feb 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372715; cv=none; b=P8BMbBwLW8F+2Lina19xPRq6t2f4/Z3bemZihuhlt22KWv6S5L8nJao2Vl8dV0jwSTjfSdJetqUFHoUX46VIaSPNsziwz6zvO73pog+B+Stcsn2Z2LPvWXens+Rt37CDepY/SD0pFD0P+KDKgaga07kvziglgRc9xgjYR2RguZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372715; c=relaxed/simple;
	bh=NEpQf6P3zSDOqsrW7Vhs4EYdNRFfFRMX7ExDSxgdXpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxapuVLRZ3aNyPgZ/tCV0kFUP58J3zUHBcB0bD+0yFDtc91410XBAh0D8mjgqia31KkVfxLBZTiK9z0oEaU09UqiuTo1EFTK2R/C1GIHN6QfsqkrI+q6RqaxEkFzpkNGOX0VH4pffEVshV17f2gJvmoFKjoUhrojJ5vULqFNepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+UQLlEm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+UQLlEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770372715; x=1801908715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEpQf6P3zSDOqsrW7Vhs4EYdNRFfFRMX7ExDSxgdXpE=;
  b=C+UQLlEmTzLIwioTu8x0fkHGWmZPsgaMjo9tv8Vnu8vvtVe1dwyEo9Wv
   SJ/at/I53z6c8Cwh1x3h4Z9OkawqD8UPZsHENQpG5xN95AspO3nKe72sP
   oQg+m5v/l3kd+jk9Kp+iU9r5tqYGusuKu08c9XIsqISR4BP0xRrJoJ4XD
   xs72wpZB6XL2eIqiDEiyYCiglWgtRdpZRyMVRCMsqTvEANPE4X7HyFzIc
   m6GDmcO0HJx5o+2kzFBG4YMH1eGykRPzdVeJUYsMg2OaQq8FEKQO3THcR
   jF/FwIIGQHcfJUNE99aL/aMQv75zq6Kzq6ufsC0BOaR3AjN61PhXdmTET
   g==;
X-CSE-ConnectionGUID: RZAI9SWRQpKaM5fZtOaCYw==
X-CSE-MsgGUID: /VCsSEvdSgGTQVEXE91GHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71570773"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71570773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:11:55 -0800
X-CSE-ConnectionGUID: q4/EOio/QdSflDqpk8Wnlg==
X-CSE-MsgGUID: I1t1YjHoQXCL5BczLFI9kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210534802"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:11:46 -0800
Date: Fri, 6 Feb 2026 12:11:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: David Laight <david.laight.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYW-X-uss7n4S6Em@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-2-dmantipov@yandex.ru>
 <20260205221537.34778ff0@pumpkin>
 <aYWbcFb73qO16tEC@smile.fi.intel.com>
 <8bd4317ef717016ca5d921a96b15808b6c77845a.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd4317ef717016ca5d921a96b15808b6c77845a.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 12:53:50PM +0300, Dmitry Antipov wrote:
> On Fri, 2026-02-06 at 09:42 +0200, Andy Shevchenko wrote:
> 
> > > Code looking at the terminating character wont be expecting a digit
> > > and will treat it as a syntax error - which is what you are trying to do.
> > > 
> > > That is a much easier API to use, and a 'drop-in' for existing code.
> > 
> > Maybe, but problematic from the usage point of view as I described above.
> 
> Note that was an idea behihd memvalue(), see https://lists.openwall.net/linux-hardening/2026/01/07/23.
> IOW since "mem=64K" is expected to be used more often than, say, "mem=64K@0xaaaaa" or "mem=64K,sync",
> it may be useful to have a wrapper which is enough to parse "64K" but treat everything else as error.

It will make it less useful.

-- 
With Best Regards,
Andy Shevchenko


