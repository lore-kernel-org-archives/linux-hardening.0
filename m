Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B531428841;
	Thu,  5 Feb 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307512; cv=none; b=GKpHuThrAhkRe8Nuu5kbY55pZmQkoLn+hqs2gEkJTsFm9EaIllACFE8s0zaW1jP/ouVwd9vMfxyYaVy1ijfAvn+Z7AZE1f4rRHaSopTPQtBHyIWGKy1LWOG1EvAMhZzKl+CpYfTLkuk0uHsDZCDB5ejRnusR2oWyFFFrNj9Co8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307512; c=relaxed/simple;
	bh=5GOclHoYEwiw14naHhZGybz56LxUNG7v3G+5+vJBpGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPkIBl1aOzO8v7fEtCrRw0SqvvtNOdLRHugC/nJXhyreQes2d+lF2MAY3nQy09U4TdJ+EyJ2UAi2Tg+6aKpSjn8RvsbfH7KwMBskw6Luj6mVkp8F0azMo2BzEPxI5uB7tw3aqnf5eciALAIPT4BVC4b8SV1VI8YVYZcnHbyees8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSkcTq7V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSkcTq7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770307512; x=1801843512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GOclHoYEwiw14naHhZGybz56LxUNG7v3G+5+vJBpGk=;
  b=mSkcTq7VrdEAO3OH42/PwHCgEAvEXpyQmPgiZu2ApNzxK4wgdXdgbaZe
   fL7qRU8lSqyg8+2G/O1OsQoThtadQ9JL+VN95sqynM5zlxPOVZxjCzP2M
   3TIPib5roqBFddBb/1C3jwsuThL928nNmPcuxLRuKOg54WhUQXhuohh5x
   vuDOJmGOaYH12eZ/YClPTQTlK9/SW7yYqPdi/bC+w6r3ou+GQF+H+JLh3
   ICN6lOBCj1y8Ep8HJPcrTDEDss4fcP/sZxTV+lavt8Fbg86XQLTmyQGSW
   +aVADkzA/rPkRSH5WVbRDGLo+RCLOPWKOgql9wt82+vqLTqvbDvMq2iwf
   g==;
X-CSE-ConnectionGUID: fs0ht8qVSLOJw1eYZBfS6w==
X-CSE-MsgGUID: RPY5h2lYSTOS+TNi52U7TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82247094"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82247094"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:05:12 -0800
X-CSE-ConnectionGUID: EGgWjKbjSU+5DC7wgk/Bqw==
X-CSE-MsgGUID: xwLUuTyoTSOWkeeOuYheLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210622255"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:05:10 -0800
Date: Thu, 5 Feb 2026 18:05:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] lib: fix memparse() to handle overflow
Message-ID: <aYS_s0lleaOWeYud@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-3-dmantipov@yandex.ru>
 <aYNa5ZBcA_pJqS7Y@smile.fi.intel.com>
 <bd627279346a8eb8096371c899325ccfc6fd07d7.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd627279346a8eb8096371c899325ccfc6fd07d7.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 12:17:16PM +0300, Dmitry Antipov wrote:
> On Wed, 2026-02-04 at 16:42 +0200, Andy Shevchenko wrote:
> > On Wed, Feb 04, 2026 at 04:57:14PM +0300, Dmitry Antipov wrote:
> > > Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> > > capable to handle overflow, adjust 'memparse()' to handle overflow
> > > (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> > > use 'check_shl_overflow()' to catch an overflow possibly caused
> > > by processing size suffix and denote it with ULLONG_MAX as well.
> > 
> > Do we have already test cases to cover this?
> 
> In
> 
> static const struct cmdline_test_memparse_entry testdata[] = {
>         ...
>         { "1111111111111111111T",       "",     ULLONG_MAX },
>         ...
> };
> 
> the whole string is valid and so should be recognized by memparse(). Next,
> 1111111111111111111 fits unsigned long long but 1111111111111111111 << 40
> is too large and should be catched by check_shl_overflow().

But if there is a case already, how does it pass?

My understanding is that if we modify the code behaviour the test cases should
be amended at the same time. I guess I missed something here.

-- 
With Best Regards,
Andy Shevchenko


