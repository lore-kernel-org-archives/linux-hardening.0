Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C8336EC9;
	Tue, 10 Feb 2026 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709902; cv=none; b=V5ox1MAtzo9oPGBSSsfNQ9DHzYXwUwazgHM6auFz1M9uJvxnXcI6uW9Az8QiBDJroPvklRJu++N6s871NtDSBzL1rVcqyMi5nCyXr0Cdqk8n2gK8O+ariNGuVmhZS1aOmolw251ExV5wK2I9YWvqJPSiLNmMjoxEk94j3VG02tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709902; c=relaxed/simple;
	bh=WFpMt7VUUocXJVe2C41oUjETCKfJtZ+sk1aSXtn9JLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEaJKaf19yWt6nizdw6u8izEMVMU/tFZ1w0zqUgSXW4l+GWc2VR6XZSOOpx6nlfscgLRZ8x6YX2KXc1tZ8zRuPCDJ6Y+KRSd8fxb5E0edzV6CeavgyDwbg6piGUGpcyYvMb45gEKQ9tTFpL1FXgQTRWoMFpfIHNfjgS/wcUU+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcPekwGg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcPekwGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770709902; x=1802245902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFpMt7VUUocXJVe2C41oUjETCKfJtZ+sk1aSXtn9JLc=;
  b=RcPekwGg+kSGafiZTTebjQYDgbpQYqlADwTYjkD3eWPCFs1eEfu/0WjM
   e1TPah9cSOFR9upbZO/ez8iDRzxdSOIVz4XtzZCpjGZG0KoGFKrElqOGr
   +PjaSKdafQHjjqbVl51V+EUzBbB9RrkESV9VsEHfi/G3Bsg/LlJMffzZq
   9Rzw3+pWdQK9KruE7C70nlCPQAgNa1MVToOpR0SrnoypkscocNwDZq0TL
   2USDbcDpWe95DXwBlPvlnBaNHFOFwpQfVwvZu4+obfVyIBnO2WuLjloH2
   1rDSKJbPzuUZnhKCDlhSBk5XQ6l8QonAf5JLCKl4/CQHeH+sNrJkyr+F9
   g==;
X-CSE-ConnectionGUID: zizPcHSaQF6X5ND9p1zGTw==
X-CSE-MsgGUID: UR6GXcEESYa5nRSVCEMY/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83269187"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83269187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:51:41 -0800
X-CSE-ConnectionGUID: Vvzt8HDZQVyMP021qI9phA==
X-CSE-MsgGUID: OvD1mGJmRkCMDqPNmDRkvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211918286"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:51:38 -0800
Date: Tue, 10 Feb 2026 09:51:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] lib: fix memparse() to handle overflow
Message-ID: <aYrjiNg8hag9KK5i@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
 <20260209164757.433932-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209164757.433932-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 07:47:54PM +0300, Dmitry Antipov wrote:
> Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> capable to handle overflow, adjust 'memparse()' to handle overflow
> (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> use 'check_shl_overflow()' to catch an overflow possibly caused
> by processing size suffix and denote it with ULLONG_MAX as well.

...

>  unsigned long long memparse(const char *ptr, char **retptr)
>  {
>  	char *endptr;	/* local pointer to end of parsed string */
> -
>  	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);
> +	unsigned int shl = 0;
>  
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

> +	if (shl) {
> +		/* Valid suffix without preceding number. */
> +		if (unlikely(ptr == endptr - 1)) {

I believe this can be optimised with the endptr++ moved somewhere here.
I have not yet a clear picture in my mind, just gut feelings, so please
try to think about it. With that we won't need endptr--.

> +			endptr--;

> +			ret = 0;

Wouldn't ret be already 0 here?

> +		}
> +		/* Apply suffix if no overflow. */
> +		else if (likely(ret != ULLONG_MAX)) {

Should be (style)

		/* Apply suffix if no overflow. */
		} else if (likely(ret != ULLONG_MAX)) {

> +			unsigned long long val;
> +
> +			if (unlikely(check_shl_overflow(ret, shl, &val)))
> +				ret = ULLONG_MAX;
> +			else
> +				ret = val;
> +		}
> +	}

Strictly speaking this is an ABI breakage. I dunno how many (broken) strings
will stop working after this check.

-- 
With Best Regards,
Andy Shevchenko


