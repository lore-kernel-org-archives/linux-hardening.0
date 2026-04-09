Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20433030F;
	Thu,  9 Apr 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724847; cv=none; b=UbppudiIn/pL2Ao+hhrlxKDMrR7WOX0SYejKRrkZrwIJ48N9NdjLxeDry2rn+DqMP0uN00GGvlIgBq5K3hZXgHgypVTtiDsyKytZooRDoaCmGv0l8/RJmu3vaOawVx2gdm3/k+RY6yCv9xuwfhj3xRpmA4XDMMeiWeRVEA/B5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724847; c=relaxed/simple;
	bh=6vJGThjJdys+FJGfRVveXqH3BI+PxKp5xUV9eCWhNdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSqSdun8FyvxJXe91xpan3iWn/HaO4jAVSTkA9ih1pFeYLLn9K6Osk33hYsWddX5xsZjJmHXNTzJK5WooJjEIAx2tMh9qrAp2KV2YVtj0JVe6W0Ers86OFqYkvILaClVChitkq0Lo6muo0ljarm9mDWrI6JiwJUC3mrMxFy8+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTxQSI9h; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTxQSI9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775724846; x=1807260846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vJGThjJdys+FJGfRVveXqH3BI+PxKp5xUV9eCWhNdY=;
  b=RTxQSI9hti1BDfYuMk3DTGODWHQyl3qifmMhXZjQ+h1WbfYFqBvU42lR
   YP9zr9uq30g7Jqae/vf6fEeX6Tk+e7BvHvxpHtw5bIADYcF/fbtAMCXKm
   rIvAcgNg5tlPZ1Mwoo+b8Xz/Pot9+cL58IqKcGutXkutIePX4Y/1u7xvF
   LLGEW/DaEFbEWOdFuwDZuggxKIfhVKGSrcv5FT0hAVV8QETZSgCQ+sR12
   UC/SiqP/j3LTiazz/mlRLXX3aemFmNy/VnGXH+vgospc9zqMGKwuDdS4X
   I6jlWHiF1V57d62iNyqHe6SJNpqwAT5RHTDdtLWlOAqaB60epW1JQjcC8
   A==;
X-CSE-ConnectionGUID: e3s5zkhjTVCRBFcDNFw+Ow==
X-CSE-MsgGUID: ccvgxzGlTsKSEp8+jkYCMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76688625"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76688625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:54:06 -0700
X-CSE-ConnectionGUID: 35KCd35eQ42aEMtX4njjIw==
X-CSE-MsgGUID: PY1UcLUnQtCoD/iCqm0u5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227856017"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:54:04 -0700
Date: Thu, 9 Apr 2026 11:54:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 0/2] lib/tests: string_helpers: Slight improvements
Message-ID: <addpKfKG2q1oIIu3@ashevche-desk.local>
References: <20260406193425.1534197-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406193425.1534197-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 09:32:46PM +0200, Andy Shevchenko wrote:
> There are two ad-hoc patches to improve the test module. It was induced
> by another patch that poorly tried to add (existing) test cases and make
> me revisit the string_helpers_kunit.c.

Kees, I assume you can take it? In any case I'm find with you or Andrew taking them.

-- 
With Best Regards,
Andy Shevchenko


