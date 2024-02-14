Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB412882A
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934102; cv=none; b=DXZetuGTP8XdBGvuegRakOoGrb8ryXSG0fGGzYuuqYlZleXay9dDELeIS1unDelzDD+23ZBIXI6De+ku7/u0pztl8vUrYuaLXqfcSBpjO64eZeqsKSXB7JNDha0lnc0aweuQxJYPOl3tG2TzElze8F8wOA7MYUUeM2z4YPzkYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934102; c=relaxed/simple;
	bh=GEskh4OwgCxU6+2XRLs6cgU3AkLytYOWrfx/McRXP0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd5jxd/zToyZFgZqOsC1DWBP+/HKZPxKxYYcTYzjAx8RgcWJfs6p3GPe+ItCiMXkfMS20jI/hsKTTYzhdZAP+m53HgDHfAolMYoQFU7ipsfOFtvopEx8Vxjw5yfDF4cLM8rSobYjg8Tk+fQYNwIrwTfBfMi5Aw66j75GB7le5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDvFet49; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDvFet49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707934101; x=1739470101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GEskh4OwgCxU6+2XRLs6cgU3AkLytYOWrfx/McRXP0A=;
  b=TDvFet49WvoZREbDT0vw7Misg6cQhV6TBN+Q2FtEyL/VW29EJzqZcZMy
   4txkxCYt5wSGPTAd67YAzbAsttRo7vWvsxvMLNKTpNpSPapjJlx/CwFqy
   g39/flFjHeTod7JwT+hvoxAEKA5PGPGzqPaNT2O52QNjvqAovVR0Lx1Wl
   eP177jhOtEN2NxsqfihOi2zMIHd5FUAYG2jKIVbGobOMZIYVV8WuPeyXG
   U7KlY15hoNeomVU+L6WZ4bSVeKJEvJb889W62S/s9Bdpxtr8j22NeE42q
   l0K5Tl4le2WwIK3mmr1sOoQsHmgs1pM4v+XcyBf5gxS8y+5iOUCUWicWO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12542886"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="12542886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912093269"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912093269"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:08:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJg8-00000004Yxj-37NV;
	Wed, 14 Feb 2024 20:08:16 +0200
Date: Wed, 14 Feb 2024 20:08:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214165015.1656-1-michal.wajdeczko@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
> Add str_plural() helper to replace existing open implementations
> used by many drivers and help improve future user facing messages.

Any user of this, please?

> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>

Move these Cc to the after '---' line.

> ---

-- 
With Best Regards,
Andy Shevchenko


