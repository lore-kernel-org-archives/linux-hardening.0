Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB912BE87
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934175; cv=none; b=ulW0XmNTX6quVn0sF2pnFKUZ7NcHXJkZcICtsrdPGSnaeeEdh5cvyw3rNvVzAfCHNIKKH0wHa05ziWjsATdpgMuCibymRG71JKbsR7GuRF/TE27QxTNIJJnDS/DpxPk1upmLUA2tGLfU+90j5bxzyhUVkCu6wZ1dM+uiLupglwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934175; c=relaxed/simple;
	bh=cQM/pjCJX5NBvNdR5lYUwT2mLQZZefUEgxknmoOjuW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaZQkJX1msg9QbiVx1B8R425mOEoMTnjHEhViYk9t+dTWStlRWZF0tUiYcmo54GlKAUB9rbBOAvtKSnEnVY0wxjjynydc7tS/EolvNES3j6zNktLlkG2W0aBgrfhfPT+z9mvuHLJh+sQAdkJbjigWvg1+T+MjcF/e7s0u/kQNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpfmk/3U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpfmk/3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707934174; x=1739470174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQM/pjCJX5NBvNdR5lYUwT2mLQZZefUEgxknmoOjuW4=;
  b=Gpfmk/3UU5x3EQ2VmGeXJjMGJtykmjpDzXuBuWz9iHZxj4cF29FCs//h
   k8tuDBbgB85N9m0GcCCq5T9l38s57w4zMhcPfc3bzCjYYHWkpaDalrj/t
   Xy6qt4S+0F3OAlQJHqHAh6qm2spRw/+n2VxrUyI0eRaxI/NdSEPNpYmQJ
   O8BEMlPhLFZ++/ZF2fSvmBVoZf/OjjPeuRKUOHtjhoEPwYkgbLf1ov6re
   hUAKVYAyJzyTmib9julFKyugLqGjdRYFaq3dqFNJmRnukSg3PQ/B8qIWe
   QIRwNQoWv5qftxqbrgcdE7OnW/yAYPO4lQ6eCtu0oOu2jBLBgskKJYfrm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12543232"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="12543232"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912093292"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912093292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:09:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJh9-00000004Yyi-2Lwa;
	Wed, 14 Feb 2024 20:09:19 +0200
Date: Wed, 14 Feb 2024 20:09:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
> > Add str_plural() helper to replace existing open implementations
> > used by many drivers and help improve future user facing messages.
> 
> Any user of this, please?
> 
> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> 
> Move these Cc to the after '---' line.
> 
> > ---

Besides that, check with the latest MAINTAINERS updates,
you missed the maintainer of this file.

-- 
With Best Regards,
Andy Shevchenko


