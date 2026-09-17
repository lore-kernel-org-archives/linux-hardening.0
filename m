Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD334A386C;
	Thu, 17 Sep 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647489; cv=none; b=mhv1f4kSASVck3XgzX2Rwq6mVzcpKwgal8+ec4J8Dwp8Cj9C5Vzfcc1cZlLyuTc04RpO9GUIzVY3yvUA+778YBPmo61qBKUO0iqVVrVfJrRiOgVSmPLyfEcT1POjqeFZqVLgP7c6KbsQiruSuDBHNkA08O2A0aXm+eJFsdCckZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647489; c=relaxed/simple;
	bh=wRkFRnQINsIrBIFpLGZ+2WGpiscqWrK5kh4MGKkfLAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eohHeUg6vDFkTbTmX2DC3V+ZGjDNulPhzBgjIEaq+NrP/2IIaXupmbvWDHrQPAGgtblsehC/fg2pc93C3DpI1DdiGKTlL/Jv3m9cLPB2i26QjC1FbwKH9aYgVpTw6CdcIXhjxVihf0/gv2y263b/ekbzSHRucJkInD91XlIpmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXVIGbV6; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXVIGbV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789647479; x=1821183479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wRkFRnQINsIrBIFpLGZ+2WGpiscqWrK5kh4MGKkfLAQ=;
  b=eXVIGbV6BPrk6+VIHjmkuJuuHaVYNGDbnJEMaOE6Ym5fQs2HuPferTC9
   Tx8IM1qxXu1mhV6cWGRjdKGNWUB5D89mauSBTG0tHs8WYE7KNSRP6pqzn
   9sC+SUNZDoHNwGUyua+BoIfrdfqmCJWvh4cWYs7qL1wl00H6qZ0A82jbI
   HL3iNfyrtNelMjeFrjrNfjaov5kxI50THp+uTAv2mXGzGnuYuDvMmMUhe
   eFRsO7hPUxYX8ASe495xNdt2NePrUnEDUXbc+PCRKnw36HkPkOYpCCdXS
   NnTCFDei3iTdIQLEHAkZQdrOkNnQOd0XJeCr7U4ct6i6yZU+XWc+ZnBrV
   w==;
X-CSE-ConnectionGUID: pycBaEFcTZKFU1oLUS8XKA==
X-CSE-MsgGUID: aqI02/9UTjSNE42kBseaYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="567542"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="567542"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:17:55 -0700
X-CSE-ConnectionGUID: HvDjrdsDQpWveBzbgrTYZw==
X-CSE-MsgGUID: dr1HhSx8TJKHRSvnG7UaTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297246366"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:17:53 -0700
Date: Thu, 17 Sep 2026 15:17:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/5] lib/tests: string_helpers: introduce
 test_string_unescape_one
Message-ID: <aqvabt4J6jNM0ytX@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
 <aquVCG4NwM1ezLLm@ashevche-desk.local>
 <7ad3889a-d9f9-426c-916f-3900d2c4ab8a@pengutronix.de>
 <aquuHKFFN7tGKbCf@ashevche-desk.local>
 <1b101eed-29b3-43ee-9cf8-cfc38a5df05d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b101eed-29b3-43ee-9cf8-cfc38a5df05d@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 11:56:32AM +0200, Jonas Rebmann wrote:
> On 2026-09-17 11:08, Andy Shevchenko wrote:
> > On Thu, Sep 17, 2026 at 10:58:27AM +0200, Jonas Rebmann wrote:
> > > On 2026-09-17 09:21, Andy Shevchenko wrote:
> > > > On Wed, Sep 16, 2026 at 07:38:08PM +0200, Jonas Rebmann wrote:

...

> > > > > Add some tests for corner cases which already pass.
> > > > 
> > > > So, this is two-in-one patch change. Needs a split, but I'm not sure why
> > > > we even need this. Can't your case be incorporated into the existing
> > > > "combined" variant?
> > > 
> > > They can not be incorporated into the combined variant because that
> > > makes it impossible to control the size of the destination buffer. This
> > > can not be fixed because the idea of the combined test is that all test
> > > strings are combined into one buffer. The bugs fixed in this series only
> > > occur when the destination buffer is limited.
> > 
> > We may modify the loop to provide the length of the destination buffer to be
> > exactly what we expect, no?
> 
> The problem with test_string_unescape_combined is this array crudely
> named "strings":

I don't see the name is a big issue here, but okay, we can rename it.

> static const struct test_string strings[] = {
> 	{
> 		.in = "\\f\\ \\n\\r\\t\\v",
> 		.out = "\f\\ \n\r\t\v",
> 		.flags = UNESCAPE_SPACE,
> 	},
> 
> 	...
> 
> it is not as one may expect a list of the individual tests which
> string_unescape is subjected to.
> 
> Instead all of the in strings are concatenated and then string_unescape
> is called on that for each possible set of flags:
> 
> string_unescape(\f\ \n\r\t\v\40\1\387\0064\05\040\8a\110\777\xv\xa\x2c\xD\x6f2\h\\\"\a\e\, out_real, 256, flags)

Yes.

> So there is no way how extending "strings" could test the code paths I
> want to test.

This is an open source, we can modify the loop to take the length into account.
Any string piece can be added to the end of it (just be located at the end of
the array. Also note, the combination of flags gives better coverage.

I'm not sure we need individual test cases in that sense. We may also add
something like printf() cases do, id est testing the result for all shortened
output buffers.

-- 
With Best Regards,
Andy Shevchenko


