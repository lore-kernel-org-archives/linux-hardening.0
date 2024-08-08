Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E8146A97
	for <linux-hardening@vger.kernel.org>; Thu,  8 Aug 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108274; cv=none; b=SApzZoCYZTNu7p3UAgqTDcaX/H2zoJXmABVqvPQP7MMFk2bwQDBEg5ephArB9u3Kyj/0tX1pG0m51H/V+R/7CROVa6Ee3q2EMoLBnxzKMoJbTs1fN4OY6qpuyPpI3Pzqu/7E3VdRNWcXrZgavW5get6priblqgJikJqrch2YRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108274; c=relaxed/simple;
	bh=b0OpzdpdhhO0nLd9K/u2DPfFKntqE3kpTtJPQcXOLvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUJmjrZQuEgJ7gZHq7Ne8Vl7+9TpbGWrPXf1z0XPFXyzHOFxKDWN1B+XctppvO+SaCF2Xt7LXMoUoN/lVDHBG7O+1fsmvgKDHJqKGMmBZU0mTmGMwpO96ELp8EA4hDxI26VA6qoQKjT4sG0HhdquJOa5HrWgtv9u68BgS8Yf9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPDc5sVU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPDc5sVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723108273; x=1754644273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0OpzdpdhhO0nLd9K/u2DPfFKntqE3kpTtJPQcXOLvE=;
  b=QPDc5sVUz92ByNvXSgaOzdaVjxBx6hZViZQGcHUR+MWy4Lq5y6FnxKbg
   Pfllyz1prD+c8/35f5LpXra2qfCkPMHdEFf3SMtZVRChvvSEypWnp/XoJ
   xpqmdPNIeKkii8CHLf6vQFCfaaXdWyXzrqAUYyULbgRbsm37ESw3PqKpT
   VPE0R87+IRPKN0kQXBWEy3J9gnHxSmcYmJ0R/Jj9GVZnRbHHxqIKndALM
   HgoiQVG3imedyr6GCX3HUIhsTrnOVol3fNZYHhG4hN8kk2hosqPk13IYy
   W+MXK6nDiW8jyWgwwWMKOb9YbVEi5cVOhhse+d0t5p2q//F4J0GxQbfpp
   g==;
X-CSE-ConnectionGUID: 0q3EACuFTP+GRi9D4ldE5A==
X-CSE-MsgGUID: IyRoaDGaTy2vAK9/kGUoJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21102493"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21102493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:11:10 -0700
X-CSE-ConnectionGUID: T6BeP2UYSfic/YRRnm/RcQ==
X-CSE-MsgGUID: eLQwu1HHSTii2ke0rwmrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57389344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:11:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sbzAn-0000000D10M-48jx;
	Thu, 08 Aug 2024 12:11:05 +0300
Date: Thu, 8 Aug 2024 12:11:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] coccinelle: Add rules to find str_up_down()
 replacements
Message-ID: <ZrSLqZhlrd2v-GfG@smile.fi.intel.com>
References: <20240725101841.574-1-michal.wajdeczko@intel.com>
 <20240725101841.574-2-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725101841.574-2-michal.wajdeczko@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jul 25, 2024 at 12:18:41PM +0200, Michal Wajdeczko wrote:
> Add rules for finding places where str_up_down() can be used.
> This currently finds over 20 locations.

This would be need an update as well in accordance with the review comment on
patch 1.

-- 
With Best Regards,
Andy Shevchenko


