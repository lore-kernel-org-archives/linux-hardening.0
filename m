Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFA3672B0;
	Thu, 17 Sep 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631117; cv=none; b=Tu7j9/vl/fM7wjpDHIOhrqPDFQayJou2dw4/5WYuoxKX+vSBF3MBqZMhotAUtwekUYRldE3nbwLBzno9vMaPeUoSr8+p076grX4Br55xEHqf0r5j6q2s916kVOATi/o0Fj2q+1CgWYP4f9Q7tBjoLubbKgZpe5seWhopf6wnsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631117; c=relaxed/simple;
	bh=yxXs/5upLVRiZeiiU3wEU2csymFpxR8CxT9Zx0PBcSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhsd0kVBRGR1JfBggAuO3FwvwItbNg+EenK6bPegpxtkGpYFH3VPa6P4hL2N5leFt+ANAP0OWNWBa0W0++MLM18LoDQnIvxEf2G8zCgR9UwKGr/ShHh3wgfcy9YZgfGjnfEPctyA2kppcvsD0PSUvCo25wcD1fJwLqqjEmEpBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAfr7rz3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAfr7rz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789631115; x=1821167115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxXs/5upLVRiZeiiU3wEU2csymFpxR8CxT9Zx0PBcSs=;
  b=lAfr7rz3JSMVHgmjKyzAP2cQF1qdiz/3OcKIA2bew7qQUrx0W3i8aqPK
   Eov88/gGnd98zGjZFmeMrVe5anBGVamwdMCfueFlBC43YlXUbxP+LCPtN
   eFh/cNicPFf9PMkDYQ3Cd43mda4N4QPTdpG0V6a225wQ1QMeIIHnezFC2
   wvQRV7WMr+A7+sugbLRwhegIi+3plibPZFKB7DfV528nCSY1YgP2581Fz
   5gJhg1BxxOSERHQcuuw4MPDhuaXsT8qGBKuY1LuMwFIfrtxc6Q5R3jX6h
   Ytf4K4YGVW//zLpia1k5JBY1g/RphzO+9o39fJ17ZW+Rk3eQfHimv6721
   A==;
X-CSE-ConnectionGUID: bcEGuOzUQuWZ7FLk8JRhFQ==
X-CSE-MsgGUID: kaggoXaRTLassMH/PIFJ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93852586"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93852586"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:45:15 -0700
X-CSE-ConnectionGUID: a040Mew8R12WV5mPMRYNNg==
X-CSE-MsgGUID: fsS0DV0rRyWCq11PxPjDug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297124859"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:45:13 -0700
Date: Thu, 17 Sep 2026 10:45:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/5] lib/string_helpers: use full destination buffer in
 string_unescape()
Message-ID: <aquahuZKdB1haZrN@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:38:09PM +0200, Jonas Rebmann wrote:
> Although all of the available sequences expand to exactly one byte, the
> current implementation decrements the remaining bytes in the destination
> buffer twice, effectively shortening it by one byte per each unescaped
> character.
> 
> The extra decrement is only needed in the one case where a single loop
> iteration produces two output bytes: when the sequence turns out not to
> be a valid escape sequence, the previously skipped backslash has to be
> emitted before the character is copied verbatim.
> 
> Add a kunit regression-test that unescapes into a barely long enough 3
> buffer.

Can you add a simple example here with the hexdump to show the point?
Yes, reading the code helps, but the above commit message is a bit
unclear (at least to me).

> Fixes: 16c7fa05829e ("lib/string_helpers: introduce generic string_unescape")
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

...

> +	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
> +	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);

Still wondering if we can incorporate this into the "combined" loop?

-- 
With Best Regards,
Andy Shevchenko


