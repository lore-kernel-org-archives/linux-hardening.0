Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71D436351;
	Thu,  5 Feb 2026 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307400; cv=none; b=aGj35Bbs/kOWy+NZnWTHBlJ+LjPwMqQZssAmdSxHuFj7S1d/+NLbppD93GtSYJGjn1V2n1Vk09Nr2FkX2mSVMg/gL1E1jYZ9zYBWEVZUjhuCLD4+3kCxfco1eawBUT1ZFV6DJVtxBfTZJCRlhYXBC3xZ//HIPiMRqFVCrAZobM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307400; c=relaxed/simple;
	bh=Mpy3Yc1LPEG7LZoLYjipVhJ1HiWe35W8DtlZXiWyHjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAPodveveelcQ94mr7gjTaT9AWYYALjGw+SWcBUdYeLtYSwAW9/V01K6hfG49it1q2vCNGwaYXvwcYpYyyvU9dD6CnhuJMz+3Chgh/iA1ClKxqJWunSrfJyOGH9HrhJGfuFqn3IHnjf8jDT+L7ZrUyXhhh8yOl3/+FPXyJiXSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EezSUHCb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EezSUHCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770307401; x=1801843401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mpy3Yc1LPEG7LZoLYjipVhJ1HiWe35W8DtlZXiWyHjw=;
  b=EezSUHCbIdFYre8O23vddUPT/z172LVB8dOcHwkF4yW9IyQ0/31oCkUl
   o8BFUQq7ox4tlGu54YKoa+GBL9Hdja3NV3JyUX47TACGjzZHVnspCR7Nx
   DP4gd7RpAe6P9K+YGwVN5shj3cKFJ9tFqBfPX0lapfcxHQALUH1YWIPMs
   ZEX5CdgTNrNYTRBDS2/ITp0otHQ2AGS5HQWtOVkVUpS1T8WcWSS+mDfRK
   +IK2nCjjfwdVeSJM9vAkVqo2CJGokkPCVBTz91NcMX7G5xy29Op0LjKCM
   4FsGeK8Gxnj3J+JCKq7TBm51KNpZ6AMbQJBBwIQ9y/4sD1nlujAo0+Q1b
   A==;
X-CSE-ConnectionGUID: tACXGC/XQ/yT5hHW0XYGOg==
X-CSE-MsgGUID: gVvWCvioQgSofYiFf9NCKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71406295"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71406295"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:03:11 -0800
X-CSE-ConnectionGUID: hxYU5VbvQ2CM/3yilFnByQ==
X-CSE-MsgGUID: 0rQFnxeQQYWCOLzcDiKYMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215064144"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:03:06 -0800
Date: Thu, 5 Feb 2026 18:03:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aYS_OGzRU8Usp7Jr@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
 <20260204135717.941256-2-dmantipov@yandex.ru>
 <aYNYOaiSfXFFe6Jc@smile.fi.intel.com>
 <c49751e8971a77c9847baad442ea7800e9d6e03f.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49751e8971a77c9847baad442ea7800e9d6e03f.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 12:04:14PM +0300, Dmitry Antipov wrote:
> On Wed, 2026-02-04 at 16:31 +0200, Andy Shevchenko wrote:
> 
> > In case you would need a v6, we can leave some of the lines untouched if we
> > switch to for-loop instead of while, but it might make the for-loop quite long.
> 
> Hmm...the for-loop might be:
> 
> for (res = 0, rv = 0; max_chars--; rv++, s++) {

res = 0 should be left outside, it's not part of the for-loop iterators.

>         ...
> }
> 
> and it makes _parse_integer_limit() a few lines shorter.

Yes, but more disruption on the code, so there are pros and cons,
but if you decide to go with it in v6, I won't object.

-- 
With Best Regards,
Andy Shevchenko


