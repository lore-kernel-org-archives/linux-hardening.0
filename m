Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCF199934
	for <linux-hardening@vger.kernel.org>; Thu,  5 Sep 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535960; cv=none; b=Ob6fhHt/GiKGUQn8dqc9/7t8D3itQTNkXGR+o2en7gOt5ut1gFk0E1tBa/j0zh9y6qM9Mtx8BdQw1nOJj1ZaquBHxH0L3XJ0Xhtd2S78BEDvZ8NphSLfFytiuLXA/Do+kLkdxgzimhAhdMNMSR/Mk3ThDG5M6RSWYAKKYsThGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535960; c=relaxed/simple;
	bh=eltSm83KZ6cgwIakRTZsRBT6XtYFQUFyrrshOhssA5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJeMkVg3kX4Dm0zDFTXDcd9jW2khi4uezF94996V3CSmr+JnBnK4sJ7fpe7anuECCGabqnmIQ0ULyPvVQyeIhBjk5zew8OpDpLC+c8r1DM4KAUmLZmIl19QZi5WZkfpp3H319VfkOltni8um4jWMUumKHvkfcCgbU0kubamnGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: hqOA8ZcQRkSzQn/H9yjXaw==
X-CSE-MsgGUID: i3Xt903xTr+hMI96VPAaHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41722023"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="41722023"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:32:39 -0700
X-CSE-ConnectionGUID: Pz/9VDjYQIyAk9srGCU7IA==
X-CSE-MsgGUID: luvy4VXiRzeT9vulX5q2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70191548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:32:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1smAj5-00000005NSK-0Wn8;
	Thu, 05 Sep 2024 14:32:35 +0300
Date: Thu, 5 Sep 2024 14:32:20 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org, chris.zjh@huawei.com
Subject: Re: [PATCH -next v2 0/2] Introduce several opposite string choice
 helpers
Message-ID: <ZtmWxFG9RrKilRee@smile.fi.intel.com>
References: <20240905092540.2962122-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905092540.2962122-1-lihongbo22@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 05:25:38PM +0800, Hongbo Li wrote:
> Similar to the exists helper: str_enable_disable/
> str_enabled_disabled/str_on_off/str_yes_no helpers, we can
> add the opposite helpers. That's str_disable_enable,
> str_disabled_enabled, str_off_on and str_no_yes.
> 
> There are more than 10 cases currently (expect
> str_disable_enable now has 3 use cases) exist in the code
> can be replaced with these helper.

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


