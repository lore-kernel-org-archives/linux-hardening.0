Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C442C027A;
	Tue, 10 Feb 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708998; cv=none; b=rPo9zyBpvpELVKRcEhC2eVpguMmso44O6vnfqEFnaT0Mgxp7WcipyxNSDnfO0qzwmpenQARN1OvTd9WD/aggxKHI7sv6XRd1IlKC7XsiYpAw8uhEhcdHXB6llbaHEOSYDG7ku062ouzx+o2HXIGsN3tb901NeVUcdBJBcd//Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708998; c=relaxed/simple;
	bh=kIEn+qMKSnpw0K89feAvR4xHo+tGFOMI2fzHHfvHvPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC1mYOvhwQRB/BpboLXD1gOCa9otkFqCoYRRcae4LgqEBWqO/mlJ9npUw6/QqdvlghBbA2xS7AVArq+zh+x31dX67l+B9sfTBP1w3s7nPnS2i95smoB5YCVJ1yz8E+D9904nts30//BZs0NiqJEuvLAmYWevwgxClf47YCox7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfa2gyDy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfa2gyDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770708998; x=1802244998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIEn+qMKSnpw0K89feAvR4xHo+tGFOMI2fzHHfvHvPQ=;
  b=lfa2gyDyFXPTNV2xYnkMlr1zwLsvOqi4mDE2ut/P8JsHhjtYjqEqMbGL
   w2n4Z0fX904TclMja3+DY7bFfyjWIKDsO0JZbScBGmcY/Yr/KDfiSw7wz
   jPrz2Vod1X1qYmYIJduRup+bdTj9mXV3ZcSwo/BdubW835EWFMGj4YNOK
   hiY3na2peCx9zEZiWZ3Yh8OrH19jkpzSkeqf8ikYLp7U1OCo1F57Cf32R
   I3FPT3YO8mYC2GiFqkujv4jXhqmQxCfuTH6r8aB9Lnx4Wr4MOomn+UF5G
   jlxdxcTI1S3qnq2aYOc72K4tYjJ3K/2Z4oEKji72Agl1iA34XGFD1hmXU
   w==;
X-CSE-ConnectionGUID: btuPH5vITfqR1mr5CA+srw==
X-CSE-MsgGUID: 6G+MCvBtRuWi1pTudSh6uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74434216"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="74434216"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:36:37 -0800
X-CSE-ConnectionGUID: uaw6ahSoTMe77i9dz79bmQ==
X-CSE-MsgGUID: hQBc0s8PSMmFjBt0J7zq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216807157"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:36:35 -0800
Date: Tue, 10 Feb 2026 09:36:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYrgASJXAyoholbF@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
 <20260209164757.433932-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209164757.433932-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 07:47:53PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', adjust native integer arithmetic
> with near-to-overflow branch where 'check_mul_overflow()' and
> 'check_add_overflow()' are used to check whether an intermediate
> result goes out of range, and denote such a case with ULLONG_MAX,
> thus making the function more similar to standard C library's
> 'strtoull()'. Adjust comment to kernel-doc style as well.

...

> -	unsigned long long res;
> +	unsigned long long res = 0;

>  
> -	res = 0;

We can leave this untouched.

...


> -	while (max_chars--) {
> +	for (rv = 0; max_chars--; rv++, s++) {

I don't see how max_chars is used. With that said, I would rather see the usual
way of expressing the condition in the for-loop:

	for (rv = 0; rv < max_chars; rv++, s++) {

...

> +		if (likely(res != ULLONG_MAX)) {

Have you seen David's question about these checks?
Maybe I missed your answer...

> +			if (unlikely(res & (~0ull << 60))) {
> +				/* We're close to possible overflow. */
> +				unsigned long long tmp;
> +
> +				if (check_mul_overflow(res, base, &tmp) ||
> +				    check_add_overflow(tmp, val, &res)) {
> +					res = ULLONG_MAX;
> +					rv |= KSTRTOX_OVERFLOW;
> +				}
> +			} else {
> +				res = res * base + val;
> +			}
>  		}

-- 
With Best Regards,
Andy Shevchenko


