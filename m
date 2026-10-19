Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A64E431D;
	Mon, 19 Oct 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409125; cv=none; b=rnaUw3zjVcRBS9felTmOzl57FcajmhL/BfnM8vCFWHxyDfbXNgi4QOseb9jSR+kgTHlSet1jaTwL9NQcmwhv+JOtKNSu1WrVKCqDsK9TH1WhVLO++g9DxXQiCQuUsNkSDbc/PmBHeiQzhhZ10Xl2q+oG/9HUTlTNBP3B8+ohPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409125; c=relaxed/simple;
	bh=0gNuqo2cgAsbms3eFvJswnU0BvijebIYuGyJin7RK3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myAiF5G9pTG/CsWvrG0Gowi4kD4W/q76xLq3Wp9eP3D0Yymmak8gSXpLLlW+rgZ6GWZUNF8Jy0q9xKDWv005PYVk5V355uKFDDRsz80Ld9mVO6Rq2fL3WOEKc9VPgCk1uPn/fAHysQCPuiNEJqjvThoHiR8toAxAcMSnBBhNgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU2RA1p8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU2RA1p8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409123; x=1823945123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gNuqo2cgAsbms3eFvJswnU0BvijebIYuGyJin7RK3I=;
  b=AU2RA1p83UuazANtrG8aZfMTVPC+7IS6mFKsrYnla6mnXzOLH7Yobfry
   VKCxhuO5TNS4jdSRZFfQsZKz41zKuDVMd4dqAcEB3W799Hf2UpW/seCNM
   pmG8uUNSTcpmU3vBJAEcYesg7pk6S+8uaqbfXCgpPAg1eDFIg+CGjMMgk
   +nqSobiuOkP72geAqGzNPcB1GdWn7kVBFdLBnudXfImOtEkYu4YMzSeUW
   8GHzqREnedGffHwm7ur7vHOJ3mnzXLWtU96lMEJ8D648uhEX++8P0qEMT
   eHwIzFwatiVlho7LBmH+pMQROaRB5GcGEGCBePIbMrSiGiFe4kI2i2y7N
   A==;
X-CSE-ConnectionGUID: oK4b5zXnR7Gq67nCBiirew==
X-CSE-MsgGUID: Jn+FLAVcR9G16xHJ8qhHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="992041"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="992041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:25:22 -0700
X-CSE-ConnectionGUID: z2S3QKg/QXywNIOnT3l9ig==
X-CSE-MsgGUID: eicaZJaISYmEqHjVRuE7Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2402157"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:25:20 -0700
Date: Mon, 19 Oct 2026 14:25:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Collingbourne <peter@pcc.me.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] string: copy byte by byte in sized_strscpy() under
 KASAN
Message-ID: <atX-HWSd9WdZ8Qr4@ashevche-desk.local>
References: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
 <atX9yfR7XwaIo457@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atX9yfR7XwaIo457@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 02:23:58PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 19, 2026 at 09:59:01AM +0800, Qiliang Yuan wrote:

...

> > -	if (IS_ENABLED(CONFIG_KMSAN))
> > +	if (IS_ENABLED(CONFIG_KMSAN) || IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> >  		max = 0;
> 
> Logically better to have them grouped by SANitizer:
> 
> 	if (IS_ENABLED(CONFIG_KASAN_GENERIC) || IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> 	    IS_ENABLED(CONFIG_KMSAN))

Or other way around (I think it will be shorter)

	if (IS_ENABLED(CONFIG_KMSAN) ||
	    IS_ENABLED(CONFIG_KASAN_GENERIC) || IS_ENABLED(CONFIG_KASAN_SW_TAGS))

-- 
With Best Regards,
Andy Shevchenko


