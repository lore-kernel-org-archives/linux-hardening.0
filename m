Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C961E7C18
	for <linux-hardening@vger.kernel.org>; Tue,  3 Feb 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162444; cv=none; b=tedt4x847uspxv/U8kx6RhhHE89wdVwdbuRA7I9FiKv6sQ0a0sL/SksmMaSRPYdkocGXXdqk75ga3cvTO3GcvOqK2vAheszoPF68fW4CzcZmCDYqHvf4YEMPh8Ne4RFjBzmsGKq9ylpMlbQOMZLgnJAHKhenYhcaslCMKH8IYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162444; c=relaxed/simple;
	bh=KbwnxWFw1sXmb38NwNTw783TyXF7XSVlEwUvWsHeXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idMk+H6ix8xTWsFUV5WJNTvx6U0QV1rMsxcXQsjykOMdajRdCVL126uXtTFJ+EGuT5aNGx05EOZnJG4zfpBWS5oXKF/INGiQg9NKYyS88ukctjbUr9yYi6jJKhYD347Tb69webrvCLXXqBYRdBHhk+Q2yY0ANpPlhtgH1577lCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YElHavuC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YElHavuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770162443; x=1801698443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KbwnxWFw1sXmb38NwNTw783TyXF7XSVlEwUvWsHeXhE=;
  b=YElHavuCYFwEf/BfZZ/biFOhGzImnP9otUe+r0637Q+PIe1OdJ2C4qU9
   q7lo+axuL+1wOC89XMWFltrhvvaDneQPPedOA2OCkm+n50Ij/MSHhti5P
   TYk+oZtW0d+HTE93r+6LYVLNyac/rg1WEPyEZ3vaS4dC7Onhxko/Sbly2
   8y+8LMpMavIhp3nv9TuhGs2u4iInefldIXzd2N9az/JAS8fKfI13KKYcC
   x2QHnI6lT+UBNAysah/q+CM1hBGLpexxJ1A+w7fJ46GqSlWts5wjJV8Jm
   rNHJR3SWrJP3T56th9t91DgIldIMXsoGuFia8PJmcu8cDwEGj28CuiJ4s
   w==;
X-CSE-ConnectionGUID: ZsmcBAgPTQW5Ad0APsLugQ==
X-CSE-MsgGUID: yPdtUnvxQrKyuCx+Ns3Y8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74965546"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="74965546"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:47:22 -0800
X-CSE-ConnectionGUID: 1DpmqHosRRuOYxXlhdLykQ==
X-CSE-MsgGUID: kF13rWmKQGa+0jO6T1eJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209277954"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:47:20 -0800
Date: Wed, 4 Feb 2026 01:47:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYKJBZRwQe3llJlW@smile.fi.intel.com>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
 <20260202115451.290173-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202115451.290173-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 02:54:48PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', adjust native integer arithmetic
> with near-to-overflow branch where 'check_mul_overflow()' and
> 'check_add_overflow()' are used to check whether an intermediate
> result goes out of range, and denote such a case with ULLONG_MAX,
> thus making the function more similar to standard C library's
> 'strtoull()'. Adjust comment to kernel-doc style as well.

This version is good enough, we may consider further optimisations later on.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

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
> +			} else
> +				res = res * base + val;

Formally this should be } else { ... }, but I'm not going to insist.

>  		}
> -		res = res * base + val;
>  		rv++;
>  		s++;

-- 
With Best Regards,
Andy Shevchenko


