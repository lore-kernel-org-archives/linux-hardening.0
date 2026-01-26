Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE721344057
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445686; cv=none; b=TDmnw/LmDuAVHb418SBRLCh1rtsrOhnq8pMWqfAhvNhsv0RU0TMbciGLKUyjuJNi02+1/F9yX+LeNWX7eQqh5LFZV1Z8LZrxepzycX9CH/FbR5qhX7xZkTvAwTdIBt65nN+gyJFl8Sc6d2Si7cB6Cqx7XnnlWUpMNOOHvkOx9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445686; c=relaxed/simple;
	bh=8wnDyUZ0iuPcc59L0Q3fD5CRKUFiJIyrU1sktYsQcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7e6XEz5Y5nLdmxPxU7XAdvEkqyNWFodswnEakeQlu8NWdQaAmTFxaz5kgH8zP+9xvPKoVn5CKaCk/Ymx7F23X66fS8DfZ06rWvkuFp48dFAZO43Dx30mxjdOFqNpUMLeCyRyCb8PQXkPDR4jx9U2dsLasDyDQBtgT6zUlBAWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJulvHfu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJulvHfu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769445685; x=1800981685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wnDyUZ0iuPcc59L0Q3fD5CRKUFiJIyrU1sktYsQcmc=;
  b=OJulvHfuf3jpTtP4WdmNTTpwCVdQLXwgSJPcJcaMI5Xls+8llP4sEgZP
   CsUhT+m3YCKhRW328R7BkhlsVefY+uO+YrhFFtv7Ra5sN0jT1/TiIwriC
   AKyJJ6PcP2orde9kqD0B6cjX7nknAdDxQyfraqBGHrFGGQBjuqfdyRo38
   hUudSs9sdQ9wKbXfYs8xDKv3Fun5lxnydX6QPZ/luwH04CDE9sngY7DU+
   YM+/AiAMziJw1r/Mh0dVyzgP+26LmXL9VROUTtl8wZu+0myM0aDX5MvkV
   ZHXGj3BQcFO9qJRE5nEKDN7YDtCYOAZmNfKfMtJAISCjP5PoS/4JFPBng
   Q==;
X-CSE-ConnectionGUID: l4QuJjylSWSFqu3vreQhMg==
X-CSE-MsgGUID: 5h215tkrQBORXtB7KGr+Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70531027"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70531027"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:41:22 -0800
X-CSE-ConnectionGUID: kf/hFJ94So2F7ehH16MiaA==
X-CSE-MsgGUID: L83/j8/dQ6eRazB7D2i9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207782621"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:41:20 -0800
Date: Mon, 26 Jan 2026 18:41:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/3] lib/cmdline_kunit: add test case for memparse()
Message-ID: <aXeZLTs_rvEAMT2_@smile.fi.intel.com>
References: <20260126162059.357467-1-dmantipov@yandex.ru>
 <20260126162059.357467-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162059.357467-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 07:20:58PM +0300, Dmitry Antipov wrote:
> Better late than never, now there is a long-awaited basic
> test for 'memparse()' which is provided by cmdline.c.

...

> +static const struct cmdline_test_memparse_entry testdata[] = {
> +	{ "0",				"",	0ULL },
> +	{ "1",				"",	1ULL },
> +	{ "a",				"a",	0ULL },
> +	{ "0xb",			"",	11ULL },
> +	{ "0xz",			"x",	0ULL },
> +	{ "1234",			"",	1234ULL },
> +	{ "04567",			"",	2423ULL },
> +	{ "0x9876",			"",	39030LL },
> +	{ "05678",			"8",	375ULL },
> +	{ "0xabcdefz",			"z",	11259375ULL },
> +	{ "0cdba",			"c",	0ULL },
> +	{ "4K",				"",	SZ_4K },
> +	{ "0x10k@0xaaaabbbb",		"@",	SZ_16K },
> +	{ "32M",			"",	SZ_32M },
> +	{ "067m:foo",			":",	55 * SZ_1M },
> +	{ "2G;bar=baz",			";",	SZ_2G },
> +	{ "07gz",			"z",	7ULL * SZ_1G },
> +	{ "3T+data",			"+",	3 * SZ_1T },
> +	{ "04t,ro",			",",	SZ_4T },
> +	{ "012p",			"",	11258999068426240ULL },
> +	{ "7P,sync",			",",	7881299347898368ULL },
> +	{ "0x2e",			"",	46ULL },
> +	{ "2E and more",		" ",	2305843009213693952ULL },

> +	{ "18446744073709551615", 	"",	ULLONG_MAX },
> +	{ "18446744073709551616", 	"",	ULLONG_MAX },
> +	{ "569202370375329612767", 	"",	ULLONG_MAX },

There are spaces left after first value in these three lines.

> +};

-- 
With Best Regards,
Andy Shevchenko


