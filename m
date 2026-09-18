Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80A397942;
	Fri, 18 Sep 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713251; cv=none; b=lbuuISqOdH5NDes734DkQPzriTRuLG6H8Op5Zjp6p71V5TJBt08QOupZepgF0pd78vdC63GigESI8+FO1wDFqkK/Wl2pO0JTJyVOywT1IQPQtLReJmfGKLvSvKziSkyYKj3BpfBSxxV0xKwQvG5b1aFOHvGwbkGEF6zjH/wtL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713251; c=relaxed/simple;
	bh=rUujryF2iB0lJ3blGjVqeYJLcuB3dM844Pc7VuljCJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFk9PW2WSweZa6quxQ46LtqS4NslI8a1i847QQDJ5viAsbNfYpvenD4X3xAVREOqGjDAb0AlyFlNhkF6IigPWRVsXEFJm8ePkEvqXzQawjSsfwXwqAndlb/1Ydm5JkcrPOsv3vnKQo8YHYTr0gEdComcX9GmmFEL9M2iDefxCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgOKUZ6V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgOKUZ6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789713248; x=1821249248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUujryF2iB0lJ3blGjVqeYJLcuB3dM844Pc7VuljCJA=;
  b=AgOKUZ6VDBVlQiBNY+hdhxmdIFFxoy7EVElQEuHfOOIjhGU9xMJDu3U6
   DNGIIGNgBmGQFfD39188upXHGx0ZKC9n79WVZ0kM1cmK70GkNvJVGvIBU
   KwtZ5t0fdiU5do7PIUR8h/8GEtzwBA+3XBVt0/xbzMYolEb+7eeN1e+7t
   I4IbbTH3WR6jzLemclXWxF61lyGLPnJhJPNCLdpA3uSvweuS5Bs2IcRYQ
   qRdisuurf2kVwaF1T9tLv/yuEfqjP57BizOMTlZqBooEcop1mtFl1R2uA
   uFVmKEYu4K0KO4K9UMckqvPFEf/ghA3H0pSwyhNTFlqZwtitONRaL16fr
   w==;
X-CSE-ConnectionGUID: XMx8OmcWRT6Tkg/igwLuNg==
X-CSE-MsgGUID: 6puTXz+WQSC9T/XzeSNP6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90062433"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90062433"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:34:07 -0700
X-CSE-ConnectionGUID: 9I1tD5X3R8qgpVKUIogg3w==
X-CSE-MsgGUID: 0rjRQy3RT+WQACat3fMVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2462825"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:34:02 -0700
Date: Fri, 18 Sep 2026 09:33:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/5] lib/string_helpers: use full destination buffer in
 string_unescape()
Message-ID: <aqzbVLNAXGnSM_9R@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
 <aquahuZKdB1haZrN@ashevche-desk.local>
 <ae3d04de-b12b-454d-93f7-31ce912f6f8c@pengutronix.de>
 <aqvdyIsM_TV4OC4W@ashevche-desk.local>
 <ecabfbfd-ead5-49a5-841b-eb532dbaab6f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecabfbfd-ead5-49a5-841b-eb532dbaab6f@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 05:47:30PM +0200, Jonas Rebmann wrote:
> On 2026-09-17 14:32, Andy Shevchenko wrote:
> > On Thu, Sep 17, 2026 at 11:02:52AM +0200, Jonas Rebmann wrote:
> > > On 2026-09-17 09:45, Andy Shevchenko wrote:
> > > > On Wed, Sep 16, 2026 at 07:38:09PM +0200, Jonas Rebmann wrote:

...

> > > > > +	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
> > > > > +	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
> > > > 
> > > > Still wondering if we can incorporate this into the "combined" loop?
> > > 
> > > Both these tests really only fail without my fixes because the
> > > destination buffer is short, barely fitting the result.
> > > 
> > > With a buffer length of 4 it yields "A\", for 5 "AA" and for 6 "AAB",
> > > a bug because "AAB" would fit the 4 byte buffer too.
> > 
> > So, we need to extend the current loop to pass the buffer length like -5, -4,
> > -3, -2, -1, 0, +1 from the expected length and check that it's cut correctly
> > along with no garbage at the end. It will help all test cases, and not just
> > a single one or a couple.
> 
> I suppose I could for v2 rewrite test_string_unescape_combined() to test
> each case individually instead of concatenating all strings. So we'd be
> invoking string_unescape() once per possible flag combination and repeat
> that for the inplace test.

We can add a flag in the testing structure and have the second loop over it
to run test individually. We should not reduce the existing test coverage
(the concatenated strings are for the reason: other flags should have no
 effect on the non-matched pieces).

> struct test_string gets the extra field regarding destination buffer
> size. However we'd need to skip the inplace test in the 'short buffer'
> scenarios. Therefore I suppose we just pass the destination buffer size,
> not an offset. If that size field is zero than the test can run either
> inplace or with any large enough destination buffer. For nonzero values,
> inplace tests are skipped.

Perhaps this will work. I haven't checked it with the code. So, make a v2
and we get another round of review.

-- 
With Best Regards,
Andy Shevchenko


