Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22A18E03F;
	Mon, 12 Aug 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492195; cv=none; b=b4sSBRXUOKfT4Dd663QaDeSgsjp/SUvb+RwAIQmvmPR8g0ow79C/6HL71/65wpJ1UV4TsMlknF1dcz0RdS58ZqWeoo//j+zy1Qvfh8Dz+TslGKBHCgpX31MfW2jDmxkzyHhBQ1sh4zyFk/+0RkRLb3k/JGgw9arpv83zvpg3gXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492195; c=relaxed/simple;
	bh=0BOuvSSRu8XCinUSUY5a/2kuBisN7G3002X8lUgxHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irdHjbYQ3e5Wn3pD4qlZx08YxYyZBAtZFRGL1UbLLJzTOVm0GGLLxbHxeUgKcNWqyJoL6jvXAt7070Hs0SI8VghxuKfBCtRNp0URDx1nFMwdg4/E4GUlGgalcov2kLl4wY+Wd1r8XV/3C87mXyJ1B2/PpD3c0/Xv9hVF63yug/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: czJjokLiTAyFxKhpmK1QYg==
X-CSE-MsgGUID: w1Cb2MIFRFupMro/kpOogA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33011188"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="33011188"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:49:53 -0700
X-CSE-ConnectionGUID: YMlFUVuVRCancuF5oXQ2zg==
X-CSE-MsgGUID: YcgO8YgWRvmmxfen4S9sZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58618672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:49:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdb37-0000000ETiX-0Fdh;
	Mon, 12 Aug 2024 22:49:49 +0300
Date: Mon, 12 Aug 2024 22:49:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-hardening@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: Add rules to find str_down_up() replacements
Message-ID: <ZrpnXFzizCG5_nx8@smile.fi.intel.com>
References: <20240812183637.work.999-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812183637.work.999-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 11:36:38AM -0700, Kees Cook wrote:
> As done with str_up_down(), add checks for str_down_up() opportunities.
> 5 cases currently exist in the tree.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


