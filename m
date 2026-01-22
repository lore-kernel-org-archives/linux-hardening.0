Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA747350A16
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082410; cv=none; b=gARWU1BSzg57orZZqUdlb2hZa/2n60NYjaXLUnLHVBvf3lnCurts4Zbd2qe5z3C5bot3SEp4WaDn2xLvmt5f3+v16ROdWcRR6Go0gl4fj/DB4EVfUrW5o8NoTEDXoCSbNwCfFeWZKyCP/k4/CPWVQI1Fl589tqiOfNl3xtf7WDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082410; c=relaxed/simple;
	bh=Z24VrwgeOQ3DSwEe/Pm/0lWQg7gsCjQuLmDqCMs7jn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoIkXfUXTBOIk8vTZn87//STzXFupx017aFWC/b7g4xH00ob0AQ38uxaV+sufCOWkxQJp2oDFrZi3eFHspUHXhUskgVnHz0OaYN8EMk6kOvwhUd1oGQ8logFu8hjXVND4WdmhSLqbQc27TywyhQZQ5zVn0mcEdTzzrAEONLCsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H25uKguD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H25uKguD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769082409; x=1800618409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z24VrwgeOQ3DSwEe/Pm/0lWQg7gsCjQuLmDqCMs7jn8=;
  b=H25uKguDP9AFnQL4gjaNZpo2HME/nvh7xYsFmvI9zF3nJ6+Dud9S9sxS
   KOrzgR8Cxp1QnCmFCGkXuTxm/m2w2LvgKLCRw0j99K9bSC8M2I7dn7qk2
   6FnCgLTEkCJVMHgRZky0VUmSU2cdVkr9sEFszyLkETSCglvZ2w7JtlvUm
   cpNqo398lnZ5+5kCFwTdr5NKgxqcoco+3CMP8vrekaewVrMln1BZWSiGq
   i8QGqpINI+nBxt+qHf9IglL+B+UKU6lKaMXktfWyLm7zCGgRyGBxmP+0g
   m8Jts9AB+hdTUhf2YllmrHfzbbhlx6rKf4qxfYU67DhF+8InPuHMHqdzq
   Q==;
X-CSE-ConnectionGUID: xQDhw+riQUiH0tONPG0wxg==
X-CSE-MsgGUID: Ebz0UohtSOuHGQy8+WiPhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70376946"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70376946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:46:48 -0800
X-CSE-ConnectionGUID: wqYUXtmZS3qu2kKwOLyQgw==
X-CSE-MsgGUID: CrlwRLYCToavOI7/Hz+1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="205964131"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:46:46 -0800
Date: Thu, 22 Jan 2026 13:46:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/cmdline_kunit: add test case for memparse()
Message-ID: <aXIOJEqV_ctVRrok@smile.fi.intel.com>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
 <20260122111254.1111811-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122111254.1111811-2-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 02:12:53PM +0300, Dmitry Antipov wrote:
> Better late than never, now there is a long-awaited basic
> test for 'memparse()' which is provided by cmdline.c.

Thank you for this! Really appreciate!

See a couple of nit-picks below.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
assuming they will be amended.

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

> +	{ "4K",			"",	4096ULL },
> +	{ "0x10k@0xaaaabbbb",	"@",	16384ULL },
> +	{ "32M",		"",	33554432ULL },

These can utilize constants from sizes.h.

> +	{ "067m:foo",		":",	57671680ULL },

> +	{ "2G;bar=baz",		";",	2147483648ULL },

Ditto.

> +	{ "07gz",		"z",	7516192768ULL },
> +	{ "3T+data",		"+",	3298534883328ULL },

> +	{ "04t,ro",		",",	4398046511104ULL },

Ditto. (However I don't remember the maximum available there.)

> +	{ "012p",		"",	11258999068426240ULL },
> +	{ "7P,sync",		",",	7881299347898368ULL },
> +	{ "0x2e",		"",	46ULL },
> +	{ "2E and more",	" ",	2305843009213693952ULL },
> +	{ "18446744073709551615", "",	18446744073709551615ULL },

> +	{ "18446744073709551616", "",	0ULL }

Leave trailing comma as it's not a terminator.

Can we also have one with more than 20 decimal digits?

> +};

-- 
With Best Regards,
Andy Shevchenko


