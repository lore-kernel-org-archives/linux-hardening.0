Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FA824A1;
	Fri, 13 Sep 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254747; cv=none; b=FkebZY7bt3vHucSi5WzylRTNPZmOgEWlsX7E6vOGyowROmOkI3q+mydTWEOkuhLYhd229fwyV04khBvs+qP5m5BDde88pTXrOc4LeoNC36ccOZp07o32lFTIuLFuqCL+7zwOdi5AZKIhBujIKXUbIz8pkAixLfEhl3HgmQFmtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254747; c=relaxed/simple;
	bh=Sb4+U4yLLBbIdHQbNqHJRVnEI2OoGlJZVmeNGxBQVfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6eCKcSaAQ/KmbnaaAI7H1QaMgGA7Lvd23n1JKk9b7UpOefw/38SSOBrDQZNaZDmWJ/jMXB4ZbBNBEhvK2GfvSjed6700K54YKKIz7IBNTDIfItMDz+G23vTB1DoyccfqCB7KLMjg9OL7Oau4v8rKXWeZltKRG4frjoDqVQI48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djnJnZuT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djnJnZuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726254746; x=1757790746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sb4+U4yLLBbIdHQbNqHJRVnEI2OoGlJZVmeNGxBQVfw=;
  b=djnJnZuTdho61ECd8kSJrCn3Q3CNveE61Dosie6cy1+irxB/TwY8S5Nu
   IrfWCwm4cujrQxqZp9A6KzNAVc6irr7eKL9ynzzyqM2oDV4f6P4oc6geq
   fx4xNpoLf/53RO27yjRYA8z+565+qoe1Pn6tJMrnL81eFFyyWOkRW05an
   YhDVBEhO9vOtiZr3hWA7sJ+DgCZ87bXTk5mM42EfNNhFR6lNlZGb2DS1D
   2NdkaFFM5iMRsZhFkGYz1UHvQGwoWsnQm9LoABuUSSWfJ2L0TRUB4XuUE
   51xMlzHrhAFnJ1wDWlalwjxO9ZN99vbd2HAMiD/ism+ILFxrXjpWAmOE9
   w==;
X-CSE-ConnectionGUID: awwraUMMTjyLvDECYh2Uog==
X-CSE-MsgGUID: AX9E4+IaTwqQeXm0fIqCqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42678170"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="42678170"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:12:16 -0700
X-CSE-ConnectionGUID: xncgdaqeQZGRFzl9BR+Qjw==
X-CSE-MsgGUID: 0ZoL7sxoSLK4ctgPWWQiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72930342"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:12:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spBiF-00000008OxM-1Mtp;
	Fri, 13 Sep 2024 22:12:11 +0300
Date: Fri, 13 Sep 2024 22:12:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kees@kernel.org,
	gustavoars@kernel.org, mcgrof@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <ZuSOi0Hj16oTrHGU@smile.fi.intel.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
 <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
 <B46D6F09-6F81-45B3-833F-9785BBBC146F@toblux.com>
 <ZuSN5L908dFtxMVu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSN5L908dFtxMVu@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:09:25PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2024 at 09:03:06PM +0200, Thorsten Blum wrote:
> > On 13. Sep 2024, at 20:40, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
> > >> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> > >>> Add the __counted_by compiler attribute to the flexible array member
> > >>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > >>> CONFIG_FORTIFY_SOURCE.
> > >>> 
> > >>> Increment num before adding a new param_attribute to the attrs array and
> > >>> adjust the array index accordingly. Increment num immediately after the
> > >>> first reallocation such that the reallocation for the NULL terminator
> > >>> only needs to add 1 (instead of 2) to mk->mp->num.
> > >>> 
> > >>> Use struct_size() instead of manually calculating the size for the
> > >>> reallocation.
> > >>> 
> > >>> Use krealloc_array() for the additional NULL terminator.
> > > 
> > >>> /* Fix up all the pointers, since krealloc can move us */
> > >>> for (i = 0; i < mk->mp->num; i++)
> > > 
> > > Shouldn't this for loop and followed by assignment also be -1:ed?
> > 
> > That should be fine as mk->mp->num was already incremented before the
> > for-loop.
> 
> Exactly my point. This is behavioural change AFAICS as the original code used
> the old (-1:ed) value, no?

Ah, I see now. It was in the original code, but closer to that loop...


-- 
With Best Regards,
Andy Shevchenko


