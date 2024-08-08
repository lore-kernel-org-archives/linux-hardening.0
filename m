Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F0146A97
	for <linux-hardening@vger.kernel.org>; Thu,  8 Aug 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108218; cv=none; b=aSovn4OeWIXHo/bawtb7tzX20aO4tq1SZHr3uQauWrl/SrmKOeFGz+tyvqx7GzH43QEyO+VH8Naf409elCbDDThwaO1uz+ivacuG+lu0VOg7ssNQiD73+toS+aV0BDYwhci2OKpsu6FNtYexxq3Io3lGweQgniJargT7aZAyZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108218; c=relaxed/simple;
	bh=hRr3xEszEhk9BYpVF/uH23tXtfvSZFMRlshRvkYa5Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX0blSDWOanbTOE/n2G3zPnaWZqTTZmD4TzKdfEK6IJRwTpfbglpPW5PsHCRgPgAiNjrxDd9+uB8ujdVapURBsYnukwAZLICTCdMbNZvLc3ZNbEeRgKOekbYX+w31sMPjruIhpqQcp20u3QtZokU5yiPY7XbeNIFaYhj/DGeNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUJVb+je; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUJVb+je"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723108217; x=1754644217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRr3xEszEhk9BYpVF/uH23tXtfvSZFMRlshRvkYa5Bg=;
  b=BUJVb+je46VGi9CCeMUTuMMW22mySvJKJRod/m1YutQWcuaJGAxWOr2e
   seuzc2TtdQ9gzDXcEPOtXMXuEQq3ciImPzSfC01qdMAdiOy3ozvdC7nCw
   jZEz50ovmIbSEzj/Fb0du5h6FJEpCr+Aet0+lkriVaLZ4YKgABiO7d+/y
   wtZJsgAa7FKodL8kfFUXAemuHnnvWFObLXP6boS4DIiZxN/hnRLUSbY69
   /zX3+0jLFdSVn/S81CC7Gow2v3Wy6syAb3nXa+GAV2GxA2SFuLSvRnOZG
   z3P6YTpWOTGypKwLM21ill/ptwL8IvMW3pw/y3LAZNo0p5q73VumCb72g
   Q==;
X-CSE-ConnectionGUID: 5NxIcKY1TTmHZeNStwodNw==
X-CSE-MsgGUID: ABN9xIdvQ966FUvSswxYRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31850902"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="31850902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:10:16 -0700
X-CSE-ConnectionGUID: JZa6+RTPRnKA6rSB67xMHA==
X-CSE-MsgGUID: UMmEjXp2Th2IdCOHxY3QPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57113895"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:10:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sbz9w-0000000D0zb-3evB;
	Thu, 08 Aug 2024 12:10:12 +0300
Date: Thu, 8 Aug 2024 12:10:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] lib/string_choices: Add str_up_down() helper
Message-ID: <ZrSLdCwtZA-iB1L-@smile.fi.intel.com>
References: <20240725101841.574-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725101841.574-1-michal.wajdeczko@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jul 25, 2024 at 12:18:40PM +0200, Michal Wajdeczko wrote:
> Add str_up_down() helper to return "up" or "down" string literal.

...

> +static inline const char *str_up_down(bool v)
> +{
> +	return v ? "up" : "down";
> +}

Can you please add a respective macro for str_down_up() as it's done for (some)
others?

P.S. Yes, I see these two has been applied, so perhaps followup?

-- 
With Best Regards,
Andy Shevchenko


