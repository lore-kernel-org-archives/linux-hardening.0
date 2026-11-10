Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329392;
	b=UDebyCUX9oM9QRddU5GZaAwURsBubWEHeRRhu8jJDSSJ22DTiqprbHHDmrGs69VFvY2x
	 fn1OAQE8zJnqf2nlVdM9Gisu6/eCEk2f7fey2d5OSsiUowaU+ZxuQOAh8euCOJd1cqf5G
	 R9JTJIkr3+nLwlMXg4Iv6cyPAqnD71HEHxfFSh02TF8bxBFFWjaGfRRiqxGrnh77zgy5W
	 EhMuX6SYKoi+e7DdNjocOZzV1Ywzm5MJ6MTHoluqQhRf/xgGOa3T6M3e+97iI9YstNMXl
	 ymrSqLOIQWzu2MpEZ8auOaqu68BF03YJEz2gJeld4inswDpIQ0R6WuPNvn4sHTpLOnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329392;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=N26Uk1NkuKePon1mqO4zlHCcQyVbLRJYKFZf4bc0oHo=;
	b=m+pRv8wxTzeSBwp2SNfU9ryy0g6iWw6fO6O5wBMO8sMslvjF7BJV+SWQc82k3z6kL6CL
	 VJLmq6B3EkX9+FLEDRXSIPSjG6fKk5JAL2yLBRfpoJP8KHqgXjQrj538z0sXvn2G4AaE6
	 JxroRfGir3DKOV4GD/Cz+r1oS5TcSqIwXVNFwl/vJ/jDbQz735DW+asXbFS/FFB/IJUJ8
	 RR3dCVGGkFDASlj2P44yjQqn99zM98wvobS+ACRyvLgDc67b77vj78QoBgIKLN4OZCF0X
	 OOx3Z7+qte1TVs4z9K2eObA4tWgDyMNRQEvcUiH6i5XmglpGByf2ONNT1r8QVMNiiug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wn2ZSEZB;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43242606A31C;
	Tue, 10 Nov 2026 16:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43242606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wn2ZSEZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794329392; x=1825865392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MVq+GLrDjvX7XOBix1Tlg4+fDQBae2i9R/65kTAv+U=;
  b=Wn2ZSEZBPWuO2rJOYeYPgsc6oVstR6Cio9xcV0YVjiZOJHjqcWYMpRe3
   jXXYnS+4n2WahROUIFU/Pq763dgVvFoLKyHiNQ5acscMml0gTqA8D+sp7
   pRJ6tPeqsoCnXCF5cxhKDhqrvuhv+y00nhxXw+nY2bidow/m4BjlMZGq5
   35N3n1+e3q63pPvMBuBg0q0uukRNvbepGmBZHIHJbCWnxjq9Yhr/YDN0w
   rDa7JagadIudc+7tRY3FSGoS/GWgx9n/iXwDXTWPdu/iQiFrGGUkhToIU
   PCqjAKonwIXT6KGFBNEpCHJbMYQzk21edrzTWZ/s5wet0n2yBkl1Fobv8
   A==;
X-CSE-ConnectionGUID: RX3GToWwQhyqWSzCoayjJg==
X-CSE-MsgGUID: xYGvmuDwSCqsgua7nOlnGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2953152"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2953152"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:49:51 -0800
X-CSE-ConnectionGUID: Sp0lt0UURUCUT5YJZfRSWw==
X-CSE-MsgGUID: 3lJ6EDzTTB6NhhqplwbXpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8536994"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:49:47 -0800
Date: Tue, 10 Nov 2026 18:49:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	jorge.lopez2@hp.com, hansg@kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
Message-ID: <avNLKe2X6ulRFnUR@ashevche-desk.local>
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 05:41:50PM +0100, Andy Shevchenko wrote:
> Export strnchrnul() for users that may be compiled as modules.
> 
> Reported-by: Armin Wolf <W_Armin@gmx.de>
> Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
> Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Assumed to go via PDx86 where the first (wow!) module user wants to use it.

Actually with the given Fixes tag it may go usual way to next -rcX.
So, whatever appropriate the respective maintainers think...


-- 
With Best Regards,
Andy Shevchenko


