Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C741C84A6;
	Wed,  4 Feb 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215486; cv=none; b=g2x0GoItnAPVmAqxsyRXdK7je1MTAlIoT8R9O+BkOS+6NPWSzD17BTb81OvqNBCJdC8urGv759X2p/n2mzfffLiO7/76FkhFjzYe36nOKAnxvsOTfHS+FpnR58h64+tIoZzu4v6KunTCzL2/xqxQyGd0Rx8HGU9wkNSRi3M1UPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215486; c=relaxed/simple;
	bh=pQI/tnBgUHZrd+CR+8JkNAOA0TQgQ8sWP/QQDyRYZWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NukxrSMrl1Np72+7CjwX1crkfnUdvlfLbVewafslVViur53jv/EGDd2Z9Mva6WwnAdrQcxDKCyd11L3/tMlf232FqZ5/WXC1QTDU9ZBWgDVtekql8/6HtLnmXrrqe0yX8ZRywDOYcHIZ2/WanfwUuNyKJcB5tq0IntAcsTOvMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGQwzJos; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGQwzJos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770215485; x=1801751485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQI/tnBgUHZrd+CR+8JkNAOA0TQgQ8sWP/QQDyRYZWg=;
  b=nGQwzJosnNbqa9NgbY9p4B3X1/aWNhgwBlgJt3jbj5MTC73Zpw0mOmE3
   u8mtRZjXUFOE0sHuFzX5UAN6SIcHFEIHq8+mJ7SNyaUR5oSDt5vq9RYOL
   vqMctUGmrRFVv5X4l0kubs4wnlXT+YMPqdbsOGyUIgJV3OHW+SZicC8Wp
   ZNQsq77SvxoYGXFk8qZtUuMB3O3H8GVJllo7I4ZoRLd78MhI5LvPmfckW
   gsp7GVuW1N67P7L2WE6ja/K1JSxaNDcbFeSCH1AtgxOKx+Y6l+T4gew/i
   GT+GaD1C2otyzzRCD+2hV85pvv97EStQfXwjqHQJyptPpWInqtPCrAXUS
   g==;
X-CSE-ConnectionGUID: sW8pt+5FSFCeI45NtmanwA==
X-CSE-MsgGUID: u1jAKaj5SD24As5FHMoOGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71495897"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71495897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:31:25 -0800
X-CSE-ConnectionGUID: X8JJFQtXT6OELAO6kA96Kg==
X-CSE-MsgGUID: D+EzNsuzSwmIXten7Mui0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210212831"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:31:23 -0800
Date: Wed, 4 Feb 2026 16:31:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYNYOaiSfXFFe6Jc@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204135717.941256-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 04:57:13PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', adjust native integer arithmetic
> with near-to-overflow branch where 'check_mul_overflow()' and
> 'check_add_overflow()' are used to check whether an intermediate
> result goes out of range, and denote such a case with ULLONG_MAX,
> thus making the function more similar to standard C library's
> 'strtoull()'. Adjust comment to kernel-doc style as well.

...

>  		/*
> -		 * Check for overflow only if we are within range of
> -		 * it in the max base we support (16)
> +		 * Accumulate result if no overflow detected.
> +		 * Otherwise just consume valid characters.
>  		 */
> -		if (unlikely(res & (~0ull << 60))) {
> -			if (res > div_u64(ULLONG_MAX - val, base))
> -				rv |= KSTRTOX_OVERFLOW;
> +		if (likely(res != ULLONG_MAX)) {
> +			if (unlikely(res & (~0ull << 60))) {
> +				/* We're close to possible overflow. */
> +				if (check_mul_overflow(res, base, &tmp) ||
> +				    check_add_overflow(tmp, val, &res)) {
> +					res = ULLONG_MAX;
> +					rv |= KSTRTOX_OVERFLOW;
> +				}
> +			} else {
> +				res = res * base + val;
> +			}
>  		}
> -		res = res * base + val;
>  		rv++;
>  		s++;

In case you would need a v6, we can leave some of the lines untouched if we
switch to for-loop instead of while, but it might make the for-loop quite long.

I'm okay with the current version, up to you to experiment and choose.

-- 
With Best Regards,
Andy Shevchenko


