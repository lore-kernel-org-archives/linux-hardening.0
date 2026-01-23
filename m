Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9531547EE
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184636; cv=none; b=Fof+u94N64mQ7JSeJMWMNR2k5VstWIq2oRQlB3ZEGAAVLT0+b4M3GvyRRRN4QFSwRP4kZR5AX85G+caJkShM1yfhsmczHUDsoP3IhPrpah5sZAStgFNt//Ta2BjYCoACqrXzVMt5h1lGuULNUh/m34XgcCri9eyicBsJ/Bb9X7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184636; c=relaxed/simple;
	bh=/Uhf0xBqBdhr09X0YUpPIXMNmicwGsQXrnECq2dRAd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy/CdWzNRE1nEklnPNGz8m2Tajj7l8mHGBq4kYoaXau+oFVeH3pO7l+H79EhDiK81l8sdk6uwC0p+Ppfu49xcEqKoZBhlI4Ypj94KzMS4aDdj3kAFJQlQLQD028jjWUVjlYEsG5eDccG2JBOhZ0CE89LII3Rhvm0o88ZqIhCoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYM9HQCL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYM9HQCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769184634; x=1800720634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Uhf0xBqBdhr09X0YUpPIXMNmicwGsQXrnECq2dRAd8=;
  b=HYM9HQCLmn9m/CLlLa5Swg6fJO28KS+s4QJR/Dgj+G7OZIPnKDOkrvvl
   r8Xp4EZPbQihcFicmuTm+m7Veu9eL55csLoL8Hv86gos/m0YP8hDMWubw
   Nkept0rJpySnemMprUgZv4Zq1FPFa8CzGMxPFsld8Y3OFNT9HiepFHoP6
   OvEAtjOAaUu9mnKjDdv/DlctiRGgwNMoajeKQsDP44pXydRS+3EzYIxH8
   4lY7MVBHuT+zcRTYnGoOWeaQzA4TjNeMRoQVT9BIvn6MvXVYfmGEMrezL
   FYwQAUPWHnjKMvq8IGixZsnwf/UGcx8xFKZHaVaQmfQZFteiPKlBIv7l/
   g==;
X-CSE-ConnectionGUID: VjcnPbe7RWC/5/BrM3CMXA==
X-CSE-MsgGUID: 5Kh9emVEROqnahzhYhzXbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="69458308"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69458308"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:10:34 -0800
X-CSE-ConnectionGUID: gMykF9D2SZqr9QMP2nxv8g==
X-CSE-MsgGUID: ixbICJDEQNmX/eO+/SOxCg==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:10:32 -0800
Date: Fri, 23 Jan 2026 18:10:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/cmdline_kunit: add test case for memparse()
Message-ID: <aXOddnWjwJxlVRIg@smile.fi.intel.com>
References: <20260123114647.1606335-1-dmantipov@yandex.ru>
 <20260123114647.1606335-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123114647.1606335-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 02:46:46PM +0300, Dmitry Antipov wrote:
> Better late than never, now there is a long-awaited basic
> test for 'memparse()' which is provided by cmdline.c.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Thanks!

Do not forget to carry on the tags, if needed.

...

>  #include <linux/kernel.h>
>  #include <linux/random.h>
>  #include <linux/string.h>
> +#include <linux/sizes.h>

Preserve the order, sizes.h before string.h.

...

> +static const struct cmdline_test_memparse_entry testdata[] = {
> +	{ "0",			"",	0ULL },
> +	{ "1",			"",	1ULL },
> +	{ "a",			"a",	0ULL },
> +	{ "0xb",		"",	11ULL },
> +	{ "0xz",		"x",	0ULL },
> +	{ "1234",		"",	1234ULL },
> +	{ "04567",		"",	2423ULL },
> +	{ "0x9876",		"",	39030LL },
> +	{ "05678",		"8",	375ULL },
> +	{ "0xabcdefz",		"z",	11259375ULL },
> +	{ "0cdba",		"c",	0ULL },
> +	{ "4K",			"",	SZ_4K },
> +	{ "0x10k@0xaaaabbbb",	"@",	SZ_16K },
> +	{ "32M",		"",	SZ_32M },
> +	{ "067m:foo",		":",	55 * SZ_1M },
> +	{ "2G;bar=baz",		";",	SZ_2G },
> +	{ "07gz",		"z",	7ULL * SZ_1G },
> +	{ "3T+data",		"+",	3 * SZ_1T },
> +	{ "04t,ro",		",",	SZ_4T },
> +	{ "012p",		"",	11258999068426240ULL },
> +	{ "7P,sync",		",",	7881299347898368ULL },
> +	{ "0x2e",		"",	46ULL },
> +	{ "2E and more",	" ",	2305843009213693952ULL },

Seems like one more tab for the above to make the parameters on their columns
nicely.

> +	{ "18446744073709551615", "",	ULLONG_MAX },
> +	{ "18446744073709551616", "",	ULLONG_MAX },
> +	{ "569202370375329612767", "",	ULLONG_MAX },
> +};

-- 
With Best Regards,
Andy Shevchenko


