Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9615332ED3;
	Mon, 16 Mar 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679905; cv=none; b=H4nB4ApvEiIN2s+XpDfSB4IKFsk+vRss9/njU3f16lZdkjeIFUS3rA9e5e+3GozqfMraTs6xTAZ9Ja64GKMjQjRqftERrnkkqHtASk7zwPifbZPKVXVm0+iPwRoJNEY5BTbcYqEzGuTKv7Ro8V+LWuqV2EJLuAwF/hmDldmGtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679905; c=relaxed/simple;
	bh=WpDsGXSnARC5nIJPZaBcjN+QmvbgsoUT44sBnvUrdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVTeDHKny9iRtnxYVxHna0HhHvmiAwGEPjnfAKEsUxiKwVJraVEEahq7RTGiPfQkcPbhQILgZvsdwjqsIp7hKP8682dnbxANtNFQV+9QCfND+WIPNl+dNoF62StMLb7nS9xvA2RFZjn/k//ehuGipbyuHYyQvxVCf5vtX1XzzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE7E8Xd2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE7E8Xd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773679904; x=1805215904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WpDsGXSnARC5nIJPZaBcjN+QmvbgsoUT44sBnvUrdac=;
  b=bE7E8Xd2eY47zl0Ef+yvVX7dg8sdaU8bac6LbfXqPlikfRTYCTKQfvFk
   ooHbKBxdot0v7GiHtHTTZXeD2mz3WB55+etQPsavvtYzsRbdj95+fQ8vq
   BPW643Rd/poFz1C0cSAza7PD66HY3QOOILt9bdFRFxrFebSmCWgoXl1QR
   mTWu6YTvl35ASMFO0VR8YID8XsLxN75WeHDF3R82rxTSNYz83hj8KnfJM
   bphc3ynz7QZ16Tc8qlpodl+/L5I6nwKEXgZh+V89w3zj1O4Y/8zsVe7VZ
   qBM038pUvHIfObeCzU0a6uHYvquVNE1PDBdXBCQzkju4xgiJIgEKjZuTS
   w==;
X-CSE-ConnectionGUID: lo+er71BRjO8eR55UbKz+Q==
X-CSE-MsgGUID: 2dFsOqlESWWxfZHr0n/VUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92273194"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92273194"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:51:43 -0700
X-CSE-ConnectionGUID: uxinB/BASbSRKmwJMzqCWA==
X-CSE-MsgGUID: dHzAoI8UQIekl9VCJvsjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="245000637"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:51:41 -0700
Date: Mon, 16 Mar 2026 18:51:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Josh Law <objecting@objecting.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
Message-ID: <abg1G8UodaBu47Pl@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org>
 <abgwF-yT_FtLTgQ3@ashevche-desk.local>
 <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org>
 <abgzILD0L2sdvAFZ@ashevche-desk.local>
 <11CFF535-91DF-4E73-ADA8-51CD8D51FACE@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11CFF535-91DF-4E73-ADA8-51CD8D51FACE@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 04:46:47PM +0000, Josh Law wrote:
> On 16 March 2026 16:43:12 GMT, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Mar 16, 2026 at 04:36:40PM +0000, Josh Law wrote:

...

> >Drop the function. Start from converting users to strscpy() or similar
> >(we have a few for different cases) and then drop strlcat() all for good.
> 
> Okie dokie. I'm doing a patch on that right now, keep your eyes peeled on
> your emails, thanks for the suggestion 

I'm taking my breath!

-- 
With Best Regards,
Andy Shevchenko


