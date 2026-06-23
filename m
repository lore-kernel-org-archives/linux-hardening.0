Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B493ACEED;
	Tue, 23 Jun 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248102; cv=none; b=W0LjRY4gQrVaWlZEiREduKj5vrCam7wGdRFddCFW7P8nTitzv+y4boIYH2KKeCfVnLl4IQVhxH6FKAKqB0/CFOhq6kAR3nos9wDyoTSPsFa/16eVU0UZuByN9Krem0WWrxoXUhbhKTkSVYW87+Dqkpkz9PxFJBM3cXagQ9xgFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248102; c=relaxed/simple;
	bh=syc5F6QF04n8Vnrj27QvpnaH5FHCJQvzFfNY8blpyHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvoG/qwhth9nzzTBl5FH/XGba7VR61DqxDx8R1/fytNjlMSm1rJtRsz3mRl5EsDQuuYea024GEUC5vCEf0EOcCPmcFxs26aI2Tv4OtGR/nB23qEq6IKZO2JQAu90439mursAH0V0ezlTewkav3KYvPLVUIj4kTYvACaGeoZj3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yw8PBTbz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw8PBTbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782248101; x=1813784101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=syc5F6QF04n8Vnrj27QvpnaH5FHCJQvzFfNY8blpyHg=;
  b=Yw8PBTbzNMBJCTPa/WvuDw+IbS/vBsPhRh1AZFlIT8ebtZTLwQ81TUYE
   TNiqBSSOLQUyqgRO6Am6iBSGgB/bynohpGLBaXg6Fw8XU/u9De8ASHRb3
   V0NBVGDPryniURdtHEB72kDZE3dFCe27VE/K96iCd6jh9eo43CG65gV+Q
   PMtBzeVQ5hB+c4yWOKfLSyNBBvOHMwxedDLVERopqPEH27pbMRdUnLDc4
   kZeBwlWveg5LjbJYImTFfYmElXo+aoA66KrR04sJRj+e0OoBVqkdOTdbu
   wyjFgLdsymMm1ShGcsehOS8Enn8iPlEybB1P8qtwVafPrh22ccqdwYsJy
   Q==;
X-CSE-ConnectionGUID: 6v8+RkOSQp+M+klQjkKOng==
X-CSE-MsgGUID: zKewsJyvQeK3t5r1QYn3Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105796344"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="105796344"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:55:01 -0700
X-CSE-ConnectionGUID: 93Ojt0DUTySYIJjUQ1z7ew==
X-CSE-MsgGUID: RaXgjiQSSGiWNLQfwRMujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="251554098"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:54:57 -0700
Date: Tue, 23 Jun 2026 23:54:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Joern Engel <joern@logfs.org>, Pekka Enberg <penberg@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: fix memchr_inv() for large ranges
Message-ID: <ajrynyaEVnTNEN13@ashevche-desk.local>
References: <20260621121133.16460-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621121133.16460-1-include@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 21, 2026 at 12:11:33PM +0000, Bradley Morgan wrote:
> memchr_inv() takes a size_t length but counts 8 byte words in an
> unsigned int. At 32GiB that count wraps, so the scan can quietly miss
> most of the range.

Wow! Is it real life use case?

> Use size_t for the word count.

...

> @@ -837,7 +837,8 @@ void *memchr_inv(const void *start, int c, size_t bytes)
>  {
>  	u8 value = c;
>  	u64 value64;
> -	unsigned int words, prefix;
> +	size_t words;
> +	unsigned int prefix;

Perhaps move towards reversed xmas tree while at it?

	unsigned int prefix;
	size_t words;
	u8 value = c;
	u64 value64;

(same lines touched, no extra).

>  	if (bytes <= 16)
>  		return check_bytes8(start, value, bytes);

-- 
With Best Regards,
Andy Shevchenko


