Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726321;
	b=FAZvVvXCvKD4fuTkxHvOeh5nR/pYEFXsQIcuilatLyL2IJEs6poBaJ/u5VaU2Y1OxVBG
	 MvXiQdnzv5MzCmtYN4zYn722bun6Y038c37awfjC4OodIYwfYO0Lg4wlMagiEa1j6ceeF
	 /iZY+4BcqkPyyCxQoHG6glOF3/whgTMSknC7dBFRe4i/7tMOMT+RWBAKGf9p/3dBNd9RN
	 q84c+0EbV4gyf+jJhgKI8GBAXRZNYoz8TEGSo0e7an+1J8SEllGyS8C1JbfqpDpRXIHI4
	 NIY7MQL36GRC9vPawsUBJ95q152f4VjUa1O7GbkMA0Z1nNdPTBPlRlnqKwP7CPr1uyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726321;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=JjWlp+miqoJ7wyTAdGhB8oXuZTBsLDEK1DFhO4ullGo=;
	b=nkvBVlu809vTQXMSbJgE3pC+NmawkBJ6AM834mEqFVPAGXbLuYKNy5u8Cc2sRRAlZQyO
	 HfMcVKFadAD6yqEhFnaXVsJ1iNR1v0PFmJOkiUcNPZSdRcSCfcoNgrzTwdTQYUYFQvI+0
	 9GhMELVAAGGmO2mi/+NWrPICkWvqVjfCuW+CZVN3Km6Dl+FmX77+R7dWW2RtaWhgxCG4Z
	 6Zc53gaqJ0F85Q06jvlbvtecU0FgO4k5PhkEFgYbvxow9Q67tPk9brnyVEnHP48XnvrGV
	 P+OjW4+AjDpSG8Y5AX8H2fL25m3L2OqERCl/aeQeZKsgpD82ZhqtDcRPAXJTtsexuhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYEs9FIM;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC9606A329
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 20:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FC9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYEs9FIM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795726321; x=1827262321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ehiv0xRrzrXMAvjrtZDjh9Tfp15N9EDErzGEDvSADs0=;
  b=DYEs9FIM04nUSRt3DnElMop3t4TRSJCo51nGnagbcxVU0lPHUEbYiug0
   hgKt37wv/lVo3orQ1nud1pKwTW81M8CVPZ3xsV4h2hmVFxGzmNUi/umVV
   +WhmPMF448gu97mxXr3Re0I9NnW9q4281le8RZjhUW+DQQaRIdeuAOvWz
   6Me1KDhWeM1h79bq8nxGH+id31oIYFeQoQcGBv2pYKPgcBu9UlKxne+Uy
   yRqPweX7n93KDv6fiBPEnzo2DWYYjAdR5ftXA8RC/MP/GgAwjtslfG9+0
   CPHSL4dNth1XwPOMqUWZQYvxK/YK9UfRapRy6nIJow1d/UI06dIkl09BG
   Q==;
X-CSE-ConnectionGUID: Ks3ccrw0Tciwzztt0oEXVA==
X-CSE-MsgGUID: Fb556z2JRCenxghsZTLpMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4550045"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4550045"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:52:01 -0800
X-CSE-ConnectionGUID: QovgFGHbRBinNnxXtvyOQw==
X-CSE-MsgGUID: wF6QBJfNR6u1E09s3JUO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12252404"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:52:00 -0800
Date: Thu, 26 Nov 2026 22:51:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awib7UleD4RO4K9v@ashevche-desk.local>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
 <awhOK6BFK6Rj0ytu@ashevche-desk.local>
 <awhWDGMVswTMHjzo@devuan>
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
In-Reply-To: <awhWDGMVswTMHjzo@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 04:55:07PM +0100, Alejandro Colomar wrote:
> > On Wed, Nov 25, 2026 at 07:26:38PM +0100, Alejandro Colomar wrote:
> > > This pointer is derived from other const pointers.
> > 
> > Constification almost always is a good thing, if this builds and works as
> > expected,
> 
> Yup, I built it as part of a larger branch.  I didn't run the tests,
> but this should be a compile-time-only thing, so I don't think it's
> necessary.

Running kunit test is so-o easy! Just run

./tools/testing/kunit/kunit.py run string

It will fail if compilation fails, so it's 2-in-1.

-- 
With Best Regards,
Andy Shevchenko


