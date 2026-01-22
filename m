Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6036923E
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082048; cv=none; b=jj71REekE9+mPdM9H2FNPtKmpU77xc0nZyurLfmvhnzrrrqS5LQ/S80mDA/ZzW3wTu02dKr7lsMsK/IigZoxLd4NzykD2JWaFDjqw/KiKAoX3GYEqKij0daXBtvwap6WyzQ1Q8ip+TYpIpfKu9CsDceTodo7RPDiAo9LMdf8L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082048; c=relaxed/simple;
	bh=Y7A6p470722DQ+UJJOcthyXRANBxSzulgIPZBtvABTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShB4AtAsGsWGeTylwtzV+U2Hqk/Cuki9JUGTvUdO6Nx9lec2LhaxLppdBE0AvYNHG/SOhSnrdjybSp0K2nEIyFTao+DUsLMcGRkTBGyO9oNGMudZi1MpDGThJDqbxAZLd1dlLIxqp5PPf0k+AGaHhjErBDRceZQGUWpakvG/YP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEAMEky0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEAMEky0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769082047; x=1800618047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7A6p470722DQ+UJJOcthyXRANBxSzulgIPZBtvABTc=;
  b=QEAMEky0VM9jnTTdmnTlla+HqG8FJotDcZLnK7GgJcF4y78z5o8A9Lpo
   tnJZmQUA8HXV3sI1ujILAKdbdkz5WPUgK4DCDyG3husa7JJmyrHIluLg5
   +ew4hRuFW1hPZHbI07XQOcabHiG0Baotnz6vkUY8FT955xdCKySZ6hrL+
   mEC9e7hqQnXh/6LlXz7Zzg0f48mEypFSL1ZbBexvGMvtJW68S/Yi2aTlq
   3C7aGO5JxawIE3tmcHBbD40XBa5PO9sJ7pq3kUux0SdmQzLD32VFTr5Sg
   nXl/s1zDjRZc13RHg2sheae2XMtwYt6wHK02r7+noyAZFeWNOVHkILK1P
   w==;
X-CSE-ConnectionGUID: fzMRZ5UMQW6r71vY2oHDPQ==
X-CSE-MsgGUID: ixWqzeLoTdOBHbZ3xgbFGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70413495"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70413495"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:40:46 -0800
X-CSE-ConnectionGUID: fdq63MQqSYm7tNEHfdigdQ==
X-CSE-MsgGUID: q2RKDuxmQJeckQFzw74nrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211570304"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:40:44 -0800
Date: Thu, 22 Jan 2026 13:40:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] lib/cmdline: adjust a few comments to fix kernel-doc
 -Wreturn warnings
Message-ID: <aXIMuWZ7y7c1Jjs2@smile.fi.intel.com>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
 <20260122111254.1111811-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122111254.1111811-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 02:12:54PM +0300, Dmitry Antipov wrote:
> Fix 'get_option()', 'memparse()' and 'parse_option_str()' comments
> to match the commonly used style as suggested by kernel-doc -Wreturn.

So, I gave you a tag for this change in the other series and it's dropped.
Why?

-- 
With Best Regards,
Andy Shevchenko


