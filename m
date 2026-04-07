Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AA25A2C6;
	Tue,  7 Apr 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573588; cv=none; b=FY8q73bHuMwhKtnpqg6EaNAP7bdsZN/sKlT3EKbjsAmCRYv7P5zZvzCB0Le8fitItp8qB7tVTQ1SZcwtLpFELcTjTEhAGH4BDaS2v6c/nQrubPtkmYEmG02ifRHB/+ynYPf75a40fEeyWyl6chKWjUPvWA+i5NeonWjGF6XwaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573588; c=relaxed/simple;
	bh=7KnGwQuVLRhKTI/XFGjYHDnXGe4PLS1Mec3+OBZjAPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plp55cCF9UzXt73xkB1/XXAFLd8mm9vk519TcXFiU3lDzHTftBbs72zEXHDpDQCty4D6qIYhnIiPRxtfDlNyR7DGLO2KsUz2IX6cR1mOjpQ828DflF3hgji6XXDLwm3QOz2IJF0ebhjj4+E/pXccYLaEtO2h8M9u2H6ejWVneBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS/KQp5i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS/KQp5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775573587; x=1807109587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7KnGwQuVLRhKTI/XFGjYHDnXGe4PLS1Mec3+OBZjAPQ=;
  b=RS/KQp5i+HJZxupQ6vz6m9GpYehkIjosYug6bfI5SZCE5xEStMHwgXai
   w5QqZKBSk+Xs+P7DyngQJ3axXXgO+j8p2FEvcFTgyPDZJ/4NQE71jyBTX
   LVsCr5/k/HMMuL4OBLi7ueTlp0hv6DlK5dzFzV4o6kATVg7n5qWqUUrFZ
   lIiIeTLQj2+54PMJVvE8EgyYcvK5NJhHlbZSgHj2wZGoBJQoI5PuvFCY4
   3gWpG+UB324IOJkD8tHLVw3AQfyHxc4htmwy22EybIgUKsAxYKFIH32yZ
   /V9iUneeb5bKWPTbp0LS9uLf1LvfecoZafpFlOza/KBMxkj9KPtq0cmsY
   g==;
X-CSE-ConnectionGUID: PYBGoT5cTligQGatTuFMVA==
X-CSE-MsgGUID: 6fa7hRC/QmqkZ/2dlTMitQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="93927652"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="93927652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:53:06 -0700
X-CSE-ConnectionGUID: caLrySRjRxm9atDpLtoTvg==
X-CSE-MsgGUID: cZ944G/JQPGkyfvaJ2vd0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223891063"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:53:04 -0700
Date: Tue, 7 Apr 2026 17:53:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: fix string_get_size() unit promotion
 after rounding
Message-ID: <adUaTrU_DZuK1Kd8@ashevche-desk.local>
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407143306.78809-1-shuvampandey1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 07, 2026 at 08:18:06PM +0545, Shuvam Pandey wrote:
> string_get_size() rounds the fractional part before formatting the
> result. If that carry pushes the integer part to the unit divisor, the
> value is still printed in the old unit.
> 
> This yields outputs like "1000 kB" for 999500 bytes and "1024 KiB" for
> 1048064 bytes instead of promoting them to the next unit.

What does it print for 1048575, 1048576, 1048577 respectively?
(before and after your patch)

All the same for numbers around 2MiB.

> Renormalize the value after the carry so it is promoted before
> formatting. Add KUnit coverage for the decimal and binary boundary
> cases.

...

> --- a/lib/tests/string_helpers_kunit.c
> +++ b/lib/tests/string_helpers_kunit.c

Thumb up for the test cases!

-- 
With Best Regards,
Andy Shevchenko


