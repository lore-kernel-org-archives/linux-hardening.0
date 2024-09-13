Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F822224CF;
	Fri, 13 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254581; cv=none; b=elZ/3x8WArgBhEmV5zJhxUTgQd2Wegl7nSp0bY1Bdlp6Jwes162QbbNihO6neDbtclMLW0CMKMrDO1gnc8ifYFIoeNnuLB8mKDpwrXGAVpyPpmXiOZBlNKZR33BW6pGFImhdlfSNfM2Ke6pxC7BKz41cSRz0e+AAzJ/E2CyZqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254581; c=relaxed/simple;
	bh=KCdZUQQ5O5PJGQia/JEJFY80DSLSZnqo3Q8bd4vuNZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqpVXQqkX+3CRVA8aSXcL1AYehsFJT3/4Gp85IFCVf6ThddlGMjj+9wVdhEHnDQ4GbJcY9qe/gknw7qNtRqjOx09yGBUcYTNR57HMPrQNIbDjhhptJsTWx3PE+tNXUrIuGsOdYRkeU0CN1ecs6sVZBrGNqYE2QeFTi1tgR1CCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cpn2s8a3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cpn2s8a3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726254570; x=1757790570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCdZUQQ5O5PJGQia/JEJFY80DSLSZnqo3Q8bd4vuNZ4=;
  b=Cpn2s8a3CbdbiL3x+T0kHrSuNeZDtgIKjMPPvFIXARSPzSSJPSYNwUgI
   Lu4xZe47UGPUBRaoHZA1sFKYUTL6tf+1HTrArIuXR+kYVB0ksIpIVU7Sx
   URjIEU6AOovEzEnTfuNCK7f/RlKy/L6M55bvtEKI+m6lFE7R8jTS3cARy
   QTktznNKA0de7htL7+ryokq5m/dAZD+E8JtMq8TdjU4oYXXgeGZSTl+Ve
   AtAYyCsV1FSRi0f0noa4QWyLom3iMpc5kina8gvVqbReloJ7BD8vA8qMZ
   7rV/MyjXXdfijN4OkT/4X/O3xnJ499INZCD0PuOTMAHFr3aVs17Wc4H8k
   Q==;
X-CSE-ConnectionGUID: lVUShxOXSjOhcJEIbpsPgQ==
X-CSE-MsgGUID: ckjyA+LlS7iinA/hynjacg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24993441"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24993441"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:09:30 -0700
X-CSE-ConnectionGUID: FWemOUcGSTaAaoBE5OWKFA==
X-CSE-MsgGUID: kDmPWXevS0iVhS6G7ylxqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72536453"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:09:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spBfZ-00000008Ov0-1BeY;
	Fri, 13 Sep 2024 22:09:25 +0300
Date: Fri, 13 Sep 2024 22:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kees@kernel.org,
	gustavoars@kernel.org, mcgrof@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <ZuSN5L908dFtxMVu@smile.fi.intel.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
 <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
 <B46D6F09-6F81-45B3-833F-9785BBBC146F@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B46D6F09-6F81-45B3-833F-9785BBBC146F@toblux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 09:03:06PM +0200, Thorsten Blum wrote:
> On 13. Sep 2024, at 20:40, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
> >> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> >>> Add the __counted_by compiler attribute to the flexible array member
> >>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >>> CONFIG_FORTIFY_SOURCE.
> >>> 
> >>> Increment num before adding a new param_attribute to the attrs array and
> >>> adjust the array index accordingly. Increment num immediately after the
> >>> first reallocation such that the reallocation for the NULL terminator
> >>> only needs to add 1 (instead of 2) to mk->mp->num.
> >>> 
> >>> Use struct_size() instead of manually calculating the size for the
> >>> reallocation.
> >>> 
> >>> Use krealloc_array() for the additional NULL terminator.
> > 
> >>> /* Fix up all the pointers, since krealloc can move us */
> >>> for (i = 0; i < mk->mp->num; i++)
> > 
> > Shouldn't this for loop and followed by assignment also be -1:ed?
> 
> That should be fine as mk->mp->num was already incremented before the
> for-loop.

Exactly my point. This is behavioural change AFAICS as the original code used
the old (-1:ed) value, no?

-- 
With Best Regards,
Andy Shevchenko


