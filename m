Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831937;
	b=Iy/wHPKjiAji28S7u3WnR0OT5tIOecsHJXm+D3rqi9UjmbZWVrW/+1vGXRQqmHqiL3WV
	 GJVZXlX2Tg6FY2QV3EJ6+Z01z5x9Yc4fIjrUW+KR7BTBWrZTlw07VfAdcB6moJr5/MuTD
	 95Yam0nqSRUnozPxj0g6eCabun4+TvFZ8VD1NCDvsQ+yfddkQ89FmOnWAzUCpBGVsMdgK
	 yOejIhnd4uUYDMe7GDG+9/8gaplC3t2qoGZwU0un5GLChhBeSBdnKqd/hIgqfL/zipwk1
	 9Qv3l/jAVMzB1zHfJwhWZ0TQuVSVRuLYi30nhF144nRpYdZHvguDg3cmPhNFZptbWOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831937;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+8w/J9Gdivkd13JwOaDvoi6W1ckf704FUqhnYO3KMI4=;
	b=qUgw5cdx5/8Z9yIN0Z5dJOvX6kqLmzqYJRswhxBOCwGpsET6lKERtLgZQ0B/LBRTSxS/
	 /zRJUtxa9h9ftfx3Cu6AsKMYm13tB+r+Yqg2FBxjkjPPvF3oTp7ZRfpQS5QYa7M3ym7KM
	 8/yXOjPwKAWER4rbrB+O8661G4KCM3GAMkCoG6fhQYTxN+BUrn82pLK9O1YHr8y8R2x1h
	 7qdNC4jkLgiVrip0I7jm9p11xz37bekcH8pvT95q0AJkpa9GaGXFtlbWEFV24VAjvtO3g
	 Lf6DETxv4ZyxzSg9y3b5YRHbSAYnr5rKaCal/eS1wb/zkJ70SXS6gf+jJ3W837velVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En6ua1dC;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B768606A32A
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B768606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En6ua1dC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794831936; x=1826367936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIX1V3jFTH6wL5Ej2EafEYZJpgYYbslWUit/1DzS7sc=;
  b=En6ua1dCc7dGF2YjZ89PV0V3Afa2f8pvSbwbwBNQSUIMpzVgg+LeUAdN
   aTpsMsPoprjl1Sgc7Us0/qUIMUtZ4o6U8xPfjfHVl7xRmg3enmrzIBbt2
   gcx9fQDyUsosQoeGvBMY7YNcurOtoZT44fdeoVzCjhukGHhJz0erlRTOp
   cZh9AdRPSHPtp0gwSrBW5rviDMiFgtDBTLmFLG9kqVkj28Ya/Q0IKDATD
   sckP/hmZeDCjMy16kxO3/oSk7Tkn8LIQ0rNyJmSlgtnnVJDk21HiPAdYV
   +YWbZAd+qQGlFuj78TkybYnwFbLsWuv1pxuZ988KU0I/h33urt4Z6HeHV
   g==;
X-CSE-ConnectionGUID: 7GVWmA8MSP6013F9DTi0kw==
X-CSE-MsgGUID: JMsbeP5bR7Ss5sO9J2xV3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3444548"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3444548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:25:35 -0800
X-CSE-ConnectionGUID: sO9cvv26RTOLGtG8FjCWIg==
X-CSE-MsgGUID: vIcgKvnFS1+f65EYABHwzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9534946"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:25:31 -0800
Date: Mon, 16 Nov 2026 14:25:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/4] treewide: Use streq(3) instead of unnecessary
 uses of strncmp(3)
Message-ID: <avr2OGrm9hHG05lU@ashevche-desk.local>
References: <cover.1794767906.git.alx@kernel.org>
 <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
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
In-Reply-To: <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 07:46:24PM +0100, Alejandro Colomar wrote:
> Uses of strncmp(foo,"bar",sizeof("bar")) are really the same as
> strcmp(foo,"bar").  There's no good reason to use strncmp(3).
> 
> This code seems to have been confused, and probably thought using
> strncmp(3) was somehow safer than strcmp(3), but it is not.
> 
> Let's rewrite with streq(3), which makes it more readable.
> This patch is not changing the behavior of the existing code.
> 
> These cases were found with the following script:
> 
> 	$ git grep -E 'strncmp\([^,]*, [^,]*, sizeof.*[A-Z"]' \
> 	| grep -v -- '- 1';

...

>  arch/m68k/sun3/prom/console.c                  | 6 +++---

I hope you compile-tested this at least. IIRC PROM is early boot stage on m68k
and PPC.

-- 
With Best Regards,
Andy Shevchenko


