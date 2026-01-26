Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288233B6FD
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445560; cv=none; b=P46JoDw1DzdkFl4xE61Fh7jSeQB3lzfb0llD3fy07BU1jttwLevPd+q9IL6DAglI7aPOaiCyPC45KAaI4PrCCS/h0MD1ROhAmjSFeHdY5f0Fti0HkjKjW9CrxAWwW4QiJ4xXE/VI86MgAPedJrS+8soL5AGAidmUk2qQWxVNwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445560; c=relaxed/simple;
	bh=RYLM3lt9xeMHUKbEsg+msftPAR6dC6I6uCUgqP0jxyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE0gLBHNnn998pSt8DtqtIip7VbyoALF3emQgE/JYk8NnrEiEFd62NavzmyJbW/eMcX5HCrbVAAfB+NzSb5oABy5w5BCu51QNKC+TtoM27jYzN3ag9zqsopfb5yfF5oWVrq1v2y56yuk1D8Xxd8y3uEISy6bo/61+PnCTdGzq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHihyQti; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHihyQti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769445558; x=1800981558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYLM3lt9xeMHUKbEsg+msftPAR6dC6I6uCUgqP0jxyo=;
  b=WHihyQtiBYiDvFDAps/MExhWSyKXguTFzf3VMfWNHu6ZHZbqLCfQjo03
   vtS8/+A19tRC3OwDjb7JLolzhT0sazJvMB3r3iWyAkbPa0UnxMJtNlc0Y
   NKXySRlySeXMEXVcS4XloYtQt5po353WJAgQY67/dR/Ow9cF+UTdKsTMn
   RJhGisYXLRgQGH+mnVvH15d33vbTDLKSkZU5NhPzaWIcrYSXhvdctMHc9
   T1DBfhN0YNH4vdzZLq9AbX/HS5OQk+7sFD8PeRRPbQUCJiHDDroCtVinN
   wnbq90+3kj+R5CUhrJj8g+F7x0W1aL/41rak51kTgtz5847Ey1OV9xM9m
   w==;
X-CSE-ConnectionGUID: l0HWzt35RI+XisUcp0dUtA==
X-CSE-MsgGUID: 18kS6fprR/iQjrhR8LBvrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80926519"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="80926519"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:39:17 -0800
X-CSE-ConnectionGUID: gLOUzqhkS+mJNklyGm9p3Q==
X-CSE-MsgGUID: FYZpJraXSJau+QAAVFNgfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="211818766"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:39:16 -0800
Date: Mon, 26 Jan 2026 18:39:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/3] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aXeYsUlxibMuYflx@smile.fi.intel.com>
References: <20260126162059.357467-1-dmantipov@yandex.ru>
 <20260126162059.357467-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162059.357467-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 07:20:57PM +0300, Dmitry Antipov wrote:
> In '_parse_integer_limit()', replace native integer arithmetic with
> 'check_mul_overflow()' and 'check_add_overflow()' to check whether
> an intermediate result goes out of range, and denote such a case
> with ULLONG_MAX, thus making the function more similar to standard
> C library's 'strtoull()'. Adjust comment to kernel-doc style as well.

...

> -		if (unlikely(res & (~0ull << 60))) {
> -			if (res > div_u64(ULLONG_MAX - val, base))

Interestingly, but the original check was made to improve performance. We don't
need to worry about overflow unless we close to it. It also has a hint to the
compiler to take branch as a slow path.

> +		if (res != ULLONG_MAX) {
> +			/*
> +			 * tmp = res * base;
> +			 * if (overflow)
> +			 *	res = ULLONG_MAX;
> +			 * else {
> +			 *	res = tmp + val;
> +			 *	if (overflow)
> +			 *		res = ULLONG_MAX;
> +			 * }
> +			 */

This looks like a left over. Use plain English to explain what's going on
here. But I think this should be only done for the last a couple of iterations
only.

> +			if (check_mul_overflow(res, base, &tmp) ||
> +			    check_add_overflow(tmp, val, &res)) {
> +				res = ULLONG_MAX;
>  				rv |= KSTRTOX_OVERFLOW;
> +			}
>  		}
> -		res = res * base + val;
>  		rv++;
>  		s++;
>  	}

-- 
With Best Regards,
Andy Shevchenko


