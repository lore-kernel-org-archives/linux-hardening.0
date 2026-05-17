Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451EF9C0;
	Sun, 17 May 2026 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997425; cv=none; b=TToTlMPBPuwQ3qBSNsi5O/Nx8SRg7gGIuQE3fv7e6DI+p0qadGT84s+HLyfdHX1PLTfz/KSnXf2E9/oBOcNNUrpua1LvYqhwONmlIMhauD5ScquzVt2EggEMZFzaSsNrP/HSCYME82WDpAqVo0V0MdFnd5NkgG3mUZRPPsZ8YRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997425; c=relaxed/simple;
	bh=hteFXO5X5R59fbyPRSbcVK6W/SZ0avg+lOa56gMYPgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOPZj5M6Fql+LVTdXOcLpX4aXrup+vzLmsDbZZz10QlIqQ57AfgEV2ZhJMqB3KXzrCV3YgEOJFeKs/R0hm6bAKGt5za/dtTDHzk0u1NEHg22noACxACpIUZYk9esSYWSG34VKXP9u1nYhDpFrOH83VXWwv4bdENGckwS9FABMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUa8xwLR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUa8xwLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778997423; x=1810533423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hteFXO5X5R59fbyPRSbcVK6W/SZ0avg+lOa56gMYPgo=;
  b=FUa8xwLRmjJHjx+NQBzv4XRzTzsNStUmziFIJGMd2LYmwebTHp/66WVV
   YCOIR3JCcIjlddqycWMjfB6G3z1kwI7IR69Ogn5P7pfDeQxAKvKUVrgZl
   dXVZM3RnKsI9Jjjo6EsZ1giOvu5e5VVJqEPijEcfj/i8R3R8Y0pbUCh+e
   0zG+m9HVf5Po68oYpUD6j7BlPcM38yKOJgFFk7+UCw3c/BlMEVHc9Vae3
   rHKEpztuTMDQyR5WYIFGblIKSoW+lWlkvt1e7tLFVYCxY5MpFHUNR3azY
   40EXY6KVuytGqCvBLsciw1V0hMk9kIvJ53dhaTJ1pPvAhKU4eUQxmIMsq
   Q==;
X-CSE-ConnectionGUID: bQ/1plgkQfac/DwPGH3fng==
X-CSE-MsgGUID: KnfofjRGQaCibGlQKq08Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90467632"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90467632"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 22:57:02 -0700
X-CSE-ConnectionGUID: 0qjLjaYqQMCh3jYnMgeZAw==
X-CSE-MsgGUID: PF0o2ZaaREKTnrE10hPaDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="234863236"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 22:57:00 -0700
Date: Sun, 17 May 2026 08:56:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: use min in sized_strscpy
Message-ID: <aglYqscnZ2cGzXUC@ashevche-desk.local>
References: <20260514165601.527883-3-thorsten.blum@linux.dev>
 <CAHp75VfQNkqEYsO4Uup0c-uiYuVyAWit=tmCz2BsYLp-sjXsZw@mail.gmail.com>
 <agc3DrODtyc2rF27@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agc3DrODtyc2rF27@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 05:09:02PM +0200, Thorsten Blum wrote:
> On Fri, May 15, 2026 at 09:45:08AM +0300, Andy Shevchenko wrote:
> > On Thu, May 14, 2026 at 7:56 PM Thorsten Blum <thorsten.blum@linux.dev> wrote:

...

> > > -       if ((long)src & (sizeof(long) - 1)) {
> > > -               size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
> > > -               if (limit < max)
> > > -                       max = limit;
> > > -       }
> > > +       if ((long)src & (sizeof(long) - 1))
> > > +               max = min(PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)), max);
> > 
> > Side note: Isn't simply
> >                max = min(PAGE_SIZE - offset_in_page(src), max);
> > 
> > ? (One will need to include linux/mm.h for this, though.)
> 
> I thought about it, but wasn't sure if pulling in all of linux/mm.h into
> lib/string.c is worth it.
> 
> > Moreover there are plenty of duplications to count the size in the
> > first page and even the similar min() as in
> >   fs/iomap/buffered-io.c:869
> >   arch/s390/kvm/gaccess.c:976
> > and many more...
> > 
> > Perhaps a new macro with a good (famous last words!) naming?
> 
> How about adding
> 
> #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> #define bytes_to_page_end(p)	(PAGE_SIZE - offset_in_page(p))
> 
> to a new header, e.g. include/linux/page_helpers.h? There are about 50+
> direct replacements and possibly more.

I checked existing linux/page*.h and have no better naming, so all looks
like a good idea to me. Because there are more (existing!) users of mm.h
just for offset_in_page().


-- 
With Best Regards,
Andy Shevchenko


