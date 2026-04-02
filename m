Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F130F7F8;
	Thu,  2 Apr 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146168; cv=none; b=HeimTx6R/MXunu2Q48uWYhe6muhuNhR21yU0kwa3zb2ri3Zg3CqUueRCEQ1hoJEMDV28DOd0zaZQl1zv3nTPh9ILNP8fJ0tOi2LZb5ugVDqdRabsFsJ1HaAnDEJdK3FZsShHVjcWFJWKi2LZQpRUv2hMzcChOeYzlwnVfxWeabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146168; c=relaxed/simple;
	bh=ENqcqlwsijEUI2JZyTQw+q8xylUM+Tq3LtcmnqpFXsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzr1vXtBb2ngxI1jX0H2YKLfP55WtAk2JRxOldeZVecMHwSXp0zU9b+dLcWOxnjK3JQSgEeb5Igs5k3IHaSF7PqXNkgWN+meYnbuMvVqZ5yBwvx0WuXW6dOdOa5rNCYwhQ91ktBnlKYexMtVYqzAtWgL+GP2HkuOKG1yQKd4zcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll3JaM6Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll3JaM6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146166; x=1806682166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ENqcqlwsijEUI2JZyTQw+q8xylUM+Tq3LtcmnqpFXsc=;
  b=ll3JaM6QGpiSQV013rSBg9qx6ibo7G45dmxmoVI+Lo/IYhJJSw0m2G1r
   P9KU6J7D+guciS43+7X9NdeO/A2WzfUpejWQj7qPWl3UZJ9f/UIHbKzOP
   t19lcaQJBU1R7hcDJbsQg2xpQ52MH22W/SopVpZpC3eWr3024kN4PuetM
   0jBTp6vvSs6diGsRCwmaZ7JcSiqB7R2KGzhlaswsM/Y9puavM15vcyuuv
   a2/RssEUTtS4VLxr3uWb8si5AVKtCabACWqdflciqxa0l7ta3EdKvenH0
   FAyM5wDGdJnytJJAxPjcU6RyZJ9/dFyJj3Mvw6wq/2d6b4S7psQlS7mKN
   g==;
X-CSE-ConnectionGUID: Us/4RG5lTyOkgHfn7Pf0pw==
X-CSE-MsgGUID: epc8DtCwRYqDqycDASat3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76326872"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76326872"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:09:25 -0700
X-CSE-ConnectionGUID: qxbEoKBoSI6q5Kz22fdW2g==
X-CSE-MsgGUID: noXLK0jKRoyZA19T6WSFFA==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:09:23 -0700
Date: Thu, 2 Apr 2026 19:09:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
Message-ID: <ac6UsaCCJQjFtpLA@ashevche-desk.local>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
 <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
 <aZXDSbyH8tWmTPPL@smile.fi.intel.com>
 <4ece2ada3067d3668fc380d3dcf807ff73073c21.camel@yandex.ru>
 <ac4pM6kHVI8cK1Xb@ashevche-desk.local>
 <20260402090030.b5a03939994b3b426ea37032@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402090030.b5a03939994b3b426ea37032@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 09:00:30AM -0700, Andrew Morton wrote:
> On Thu, 2 Apr 2026 11:30:43 +0300 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > >   lib/cmdline_kunit: add test case for memparse()
> > > > > >   lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
> > > > > 
> > > > > Any chance to move forward with this?
> > > > 
> > > > I think it's a grace period due to ongoing merge window.
> > > > Also we need more input on the first patch from others,
> > > > perhaps Kees and Andrew can take a look when they will be
> > > > less busy.
> > > 
> > > The same question again...
> > 
> > I'm not sure why. The patches are in Linux Next for several days already.
> > $ git tag --contains b85c7e022e1c # the last one
> > next-20260401
> > 
> > Yet it needs to be merged into nomm-stable (if I understood the process right).
> 
> Yes, these are on track for the upcoming merge window.
> 
> However I believe the riscv32 build breakage remains unresolved?
> 
> https://lore.kernel.org/all/202603041925.KLKqpK6N-lkp@intel.com/T/#u

I haven't heard any move of that. Ard proposed a fix/workaround. Nobody seems care.
So I think leaving it as is is also okay as risc-v people simply do not care.
Alternatively we may apply one of the suggested approaches: disabling EFI for 32-bit
or a patch that enables shift from a GCC library — in-kernel copy of it.

-- 
With Best Regards,
Andy Shevchenko


