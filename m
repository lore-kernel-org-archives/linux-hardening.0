Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484E128396
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936586; cv=none; b=hGQm2R31JQdnKN4wpVPhmw4EeBqhbhBX4d5LrhhkBtCPjnpX6IAHShEP/J18ikCfzcHZqiilmlagsFtG2iljNw1z6aN4cYaJ+mn9WqGvNDEQ58lkSJ+AZy84zlxnfVdz0X85jj5bd58OQ41b0VefPlL9mSydtETOV13BLMZI9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936586; c=relaxed/simple;
	bh=2q98+VCXXu+h6rl7kfpbKdYjOMRThjiOS7yvP/dF944=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEgE9sEwe0aiyiD319Kpy+Sarv4GmyJSeZ2vUlL/UxmiHBdB0id6Ikki3H5/QatUab2r+zrRxD7MABWTZy4PKijCqCOaMssCXPkABuayxxEwDPczjyycxwJPS7PfvI8+eAphI6Ttz4RqLzSSk92remddau3yT9BIFU+5/kmrDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y34PGjro; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y34PGjro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707936584; x=1739472584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2q98+VCXXu+h6rl7kfpbKdYjOMRThjiOS7yvP/dF944=;
  b=Y34PGjro6BREChxxezcB0f71Gc/bZcmXl8xCpB0vYLnTFXjfMjQ4ARNC
   yTMwCoUhyAYUdfagbKfa929FWi8EHMvsRF0AOfsFE/kt3tKP9F6aGs2oF
   U+BdNA6D433RornQZ2dnE7sSlAu5R9ksI/r6J59w9giGUl6iNhUl5Q32U
   yX4v7Yo8jBONX7oxoeFvPhCyR7nubZlt3hxkvjlbtrLqR9ORq1/jTYDKu
   zFtdkgRo4wOjy02Afk5aHU4MilKUHy6fowCMKE+oOZGl6nJ5HEVkcc8jm
   k5GOJVMX/ZDZSWrgjmAcoWUjbm4kh5tVOlZPtZ5fCoVUyESaWPmm46KCw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1869628"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1869628"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912094153"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912094153"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:49:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raKKC-00000004ZsA-1O4D;
	Wed, 14 Feb 2024 20:49:40 +0200
Date: Wed, 14 Feb 2024 20:49:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1bm6gpu.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 08:30:53PM +0200, Jani Nikula wrote:
> On Wed, 14 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
> >> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
> >> > Add str_plural() helper to replace existing open implementations
> >> > used by many drivers and help improve future user facing messages.
> >> 
> >> Any user of this, please?
> 
> git grep "\"\" *: *\"s\""

You know what I meant.
Second patch in the series that shows usefulness of the first patch.

...

> >> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >> 
> >> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> > Cc: Jani Nikula <jani.nikula@intel.com>
> >> 
> >> Move these Cc to the after '---' line.
> 
> Why?

At bare minimum to reduce noise in the commit message.
If going further, to be environment friendly (no jokes).

-- 
With Best Regards,
Andy Shevchenko


