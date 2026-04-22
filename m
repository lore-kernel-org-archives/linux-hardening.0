Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2F37266E;
	Wed, 22 Apr 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843150; cv=none; b=Ku/is6KX+Q+0D8CGaU7LXE1tDWg2b7R0hIWg6o+WHBI0ftEOis0bep4jjS9iohHcPLE79reQoHLWnKTqUz9j6/KXSMm5sVnkSK1y5hdmePFWsm6PwouL2W+94BLd90xhjSoHQ6aVjRT7HQLOYw4BZqPQeRO1H4KjnVqU+iDUP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843150; c=relaxed/simple;
	bh=1dfkbuOBX9sr1XwlkIHQZDjA5uZOKZkpocxYX4pCEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIWh3HEI2/JooXkbkSzsbCXyHFaIz7FVy51DvhiFxJVOwANO3wSnRT5qvv1qFR2QDU7Rr7Jes7PxV/HY+vHzKz6InW+H/v10moj+wgg4c39JjzcJwBklena+nhN1BE9tlZSpUrHXIh4DO1CXTKONzsUeOeOkGLTbcNPTHUT4wLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwODaV9s; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwODaV9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776843150; x=1808379150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1dfkbuOBX9sr1XwlkIHQZDjA5uZOKZkpocxYX4pCEUs=;
  b=kwODaV9szQ/vfQXDPOAXEncpt5Pfl59Hkyp3LruAPuHgONwl6r4+wq5I
   sqcynab992ZDQFtoWWaM2WXTdollwsDZ9DH3qsi4wh8Xg19LP2TPvfqGI
   RvWTYyAQTaS0WYt7nxzspWVPj6pFOv7xZ9XL+RpRrFZeiFlGAtnlF6AEV
   mQwcGadqWnBMopSWz5C7Y50cxIGpzznYpFbTnTfWCUV9WxnR2ofAW8+sy
   V69YTnhHVqAn885+ZfGV0SvLvZXuqMb1lWWIZyWfQRNzOZqdzfGtvHv/W
   zu1HAXIPdQ/ADwRpFsTI5Mgo4yGopjYzvPQzLy9gsw3jm5qgWFThFuplq
   A==;
X-CSE-ConnectionGUID: j/ppcr6YRxq6C1eQAV8plg==
X-CSE-MsgGUID: np8lway7RDyueEolGRpmqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77772349"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77772349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:32:29 -0700
X-CSE-ConnectionGUID: UAI/oUllR26b/i+7Cb/NvQ==
X-CSE-MsgGUID: z2+YBY0cR+6MWvdN04CHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236281633"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:32:27 -0700
Date: Wed, 22 Apr 2026 10:32:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/tests: add string_get_size() boundary tests
Message-ID: <aeh5iHrCR4j6Auvt@ashevche-desk.local>
References: <177680283372.84187.11707577520741615468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177680283372.84187.11707577520741615468@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 02:04:06AM +0545, Shuvam Pandey wrote:
> string_get_size() has several non-obvious outputs around decimal and
> binary unit boundaries because the unit is chosen before the final
> rounding step. Decimal values just below 1 MB can print as "1000 kB";
> binary values below 1 KiB stay in bytes; and rounded binary values can
> print as "1000 KiB" or "1024 KiB" before the input reaches the next
> binary unit.
> 
> Add KUnit coverage for these current outputs and nearby threshold values
> so the existing behavior is explicit.

Always keen to see more test cases and hence almost automatic green light
from me!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


