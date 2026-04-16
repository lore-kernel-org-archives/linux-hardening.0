Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B938C402;
	Thu, 16 Apr 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325738; cv=none; b=b+vmUqqLcgjNfrr+YCLaGfgMbNnbwfXDOF6K8GSVr9Sd1BnYV0BjJHvL88tQFwsJBnzv6Fhuwp5ai3nBqPZxMz4UJmEi4d8zpL3OD4IRH2beWuv7Sk54YsTwAX0Zx0Dm9klv6JK6K7KMKY2UDhxcOWTeCY79r8NsYxbFtcSRNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325738; c=relaxed/simple;
	bh=tQkUEZUx9d6HdjXWqQ38KZT5w/og4tfGlbhyaD/jvsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ5Et9qylveHi2Xqd3M6pPFAl414P9FsuZjR5R7QwldqHyZ8K28lzYYxfp8ZWO3lnQz3CVmYrxTugi3SCyFCpfUS/eFlz+B1s7nluY0xGwF5f5TjL+uu8V+E0tXdnfGVyEMpZCyY5BiRQKontHscIZ8I6TajAnsvD8XhMuFJfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRRvKFIk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRRvKFIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776325736; x=1807861736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQkUEZUx9d6HdjXWqQ38KZT5w/og4tfGlbhyaD/jvsc=;
  b=lRRvKFIkrqpccb2skYlo3FJh7poWuZTEuzY31kGeNq+2q9C39jdNUYbW
   rsX9PSxvngI/JvCHjcJutxrZww6Sbn5QLYdqVJXYZF2J9sSLlaeOFzssr
   ZTTHmdC0OhClQNqj6ihfC0C4palYDHBUuNCOJDVknf6YKxM+TjlM62luZ
   1EB+U9c6LCQkbXNRPZLAhE2l0ZD4SoiDV/CMNPZVxxBakfvxTBOtFhbVk
   LzqlKGiiMr5nTicWyJULXr8lvWwj4HN+oEJb3KRbW3aotudG5Inx7mKfj
   DlpKwVUW30NHlxJ1suzKVh+i3L7FNOKFcraPlAzrObzmrE5dHfMchsgvq
   g==;
X-CSE-ConnectionGUID: E12yyCwxQFGFsd1F2wunhQ==
X-CSE-MsgGUID: SxgRJRXZRG6bjAWPkzYlJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77291935"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77291935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:48:56 -0700
X-CSE-ConnectionGUID: o1oV2mttQXuGw9TAOakYkg==
X-CSE-MsgGUID: cgoIPRzHSTanlRyffGNJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="226329966"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:48:54 -0700
Date: Thu, 16 Apr 2026 10:48:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <aeCUY_BH3s9b8qKG@ashevche-desk.local>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
 <ad-j4eGpltrb-WQj@ashevche-desk.local>
 <ad-vKhbh4KNV87gu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-vKhbh4KNV87gu@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 05:30:50PM +0200, Thorsten Blum wrote:
> On Wed, Apr 15, 2026 at 05:42:41PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> > > kasprintf_strarray() returns an array of N strings and kfree_strarray()
> > > also frees N entries.  However, kasprintf_strarray() currently allocates
> > > N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> > > 
> > > Also update the kernel-doc for @n.
> > 
> > Have you checked all current users that they do not rely on the NULL terminated
> > array?
> 
> Yes, I've checked all call sites, and none of them rely on the NULL
> terminator. Specifically, I checked:
> 
>   drivers/gpio/gpio-mockup.c
> 
> which uses PROPERTY_ENTRY_STRING_ARRAY_LEN(), and
> 
>   drivers/pinctrl/bcm/pinctrl-bcm4908.c
>   drivers/pinctrl/intel/pinctrl-intel-platform.c
>   drivers/pinctrl/meson/pinctrl-amlogic-a4.c
>   drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
>   drivers/pinctrl/pinctrl-at91.c
>   drivers/pinctrl/pinctrl-rockchip.c
>   drivers/pinctrl/pinctrl-st.c
> 
> all of which use the size N to iterate over the returned array.

Thanks for confirming.

> Also, kfree_strarray() explicitly takes the number of entries N,
> indicating that callers are expected to keep track of it.

Still we might have an API that requires a NULL terminated arrays (when it
doesn't take size), which a caller wants to use.

> > Note, that was done on purpose that once allocated it can allow user
> > to drop the track of the number of strings and rely on NULL terminator.
> > I.o.w.  the number of strings may be just a local variable somewhere
> > where kasprintf_strarray() is called.
> > 
> > I tend to NAK this change, rather you can update kernel-doc to explain
> > why it's done this way (see above).

Given pros and cons, and what David said I'm still not sure that this is
going to be a beneficial patch. I leave it Kees and Andrew to decide.

-- 
With Best Regards,
Andy Shevchenko


