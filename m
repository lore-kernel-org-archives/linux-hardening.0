Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0561EA84;
	Wed,  4 Feb 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216170; cv=none; b=jugZKAOVTXF6PbpqpUhHYfiHVM1RR9Elr8CU9bvSzAS4vDaiFTrrhhegyfxLmrUf7TfrkuHKqNKcJxiI2M/fKTnYLkY6c2YLR8mx/1LgTOWPyG1tqMW0Bk/tmDQMnslr9WXPfAiTGopJEp17YB1HYLDezN+COEAKHGQCMDsGt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216170; c=relaxed/simple;
	bh=avXb7RubNXn8oyAvpnHqYHsu6rrMmJLIcdSIm9ejpeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlefhwvhKsRcbmthGH/ojeq/sb4f9+QIolzEmo2P6yVMDctT4J49vqDbiTsOdS68F1hKMABtfcpBFCfmAnJbqGILVPTvWUv1KCLI1ev7309wZFC3Yd1orxQuIc1SaQrYFEoyXcqLI4mWAq7iALdUPxEs4dxpjzIWKABDn07CTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJWPGMY/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJWPGMY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770216170; x=1801752170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avXb7RubNXn8oyAvpnHqYHsu6rrMmJLIcdSIm9ejpeM=;
  b=SJWPGMY/G3gd3YC/Sgn3Dz4yyHgKxkv7+JlP61KDy/bDjqd1luhEYv5t
   UNb0b1LNcyDVNGV5ROE9m+WfSZr1jDQZn1QOLtmq4cmW6qmiy4g+mZ6b/
   y8R4LMujX4GH9JWxDnpSjcyP56pAdnfKO1L70k7TNCwxz4MAdTH7OcG+I
   lM+sko/Oac1TfJrj79MHf+Rc3MATsOH43Obqmnmj0uNKxHlTPYOIHDaJO
   2p37cN6iz5tu2F8enATGIO2zoiDJVWlRLurFFYHZuq/3KlJs9TvptpK/3
   80Xco5rnHNovO/MNAEr2KMQuWeTW7X9UwHQC/HTuDlIKo06AAnGFz8Ne2
   A==;
X-CSE-ConnectionGUID: TeDDvemiQs+KG4kWWwZprQ==
X-CSE-MsgGUID: qHdslg99RVGpbiVqXvW/dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75257258"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="75257258"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:42:50 -0800
X-CSE-ConnectionGUID: 3pgGXlxnStK5bJN8WiYQgQ==
X-CSE-MsgGUID: pQ60nnuTSiuiTHZrY4gZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214673482"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:42:48 -0800
Date: Wed, 4 Feb 2026 16:42:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] lib: fix memparse() to handle overflow
Message-ID: <aYNa5ZBcA_pJqS7Y@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204135717.941256-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 04:57:14PM +0300, Dmitry Antipov wrote:
> Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> capable to handle overflow, adjust 'memparse()' to handle overflow
> (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> use 'check_shl_overflow()' to catch an overflow possibly caused
> by processing size suffix and denote it with ULLONG_MAX as well.

Do we have already test cases to cover this?

...

> unsigned long long memparse(const char *ptr, char **retptr)
>  {
>  	char *endptr;	/* local pointer to end of parsed string */

>  

Shouldn't be an empty line in the definition block.

> +	unsigned int shl = 0;
>  	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);

and it would be better to preserve reversed xmas tree order (to some extent).

	char *endptr;	/* local pointer to end of parsed string */
	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);
	unsigned int shl = 0;

> +	/* Consume valid suffix even in case of overflow. */
>  	switch (*endptr) {
>  	case 'E':
>  	case 'e':
> -		ret <<= 10;
> +		shl += 10;
>  		fallthrough;
>  	case 'P':
>  	case 'p':
> -		ret <<= 10;
> +		shl += 10;
>  		fallthrough;
>  	case 'T':
>  	case 't':
> -		ret <<= 10;
> +		shl += 10;
>  		fallthrough;
>  	case 'G':
>  	case 'g':
> -		ret <<= 10;
> +		shl += 10;
>  		fallthrough;
>  	case 'M':
>  	case 'm':
> -		ret <<= 10;
> +		shl += 10;
>  		fallthrough;
>  	case 'K':
>  	case 'k':
> -		ret <<= 10;
> +		shl += 10;
>  		endptr++;
>  		fallthrough;
>  	default:
>  		break;
>  	}

> +	/* If no overflow, apply suffix if any. */
> +	if (likely(ret != ULLONG_MAX) && shl) {

Do we need to check for shl? Yes, it will be an additional check below,
but do we care?

> +		unsigned long long val;

> +		ret = (unlikely(check_shl_overflow(ret, shl, &val))
> +		       ? ULLONG_MAX : val);

Unneeded parentheses, and ? should be on the previous line.
With that said, I prefer to see the regular conditional instead:

		ret = check_shl_overflow(...);
		if (unlikely(ret))
			ret = ...
		else
			ret = val;

> +	}
> +
>  	if (retptr)
>  		*retptr = endptr;

-- 
With Best Regards,
Andy Shevchenko


