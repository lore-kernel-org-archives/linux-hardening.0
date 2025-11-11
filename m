Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E313A3F7;
	Tue, 11 Nov 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861458; cv=none; b=IQti+Ivw10visDbXwU+hG6YsYOcYeM8u75EtGQybo0waWJix1XSDROFy5PsB9161j6Wxg1/kL4MGJAsniFRvEbLiI/rCjQ/WjrlPfqxeQehgxjJvhzbuVmORMYdfpLC8/p7BfqrQpLy2a4aNfQ0tvTyolDEIisBHeaakmUUNEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861458; c=relaxed/simple;
	bh=8hgo0SAlxDhqel27kLJFUy/dCtq9ThidmmkRD+8hvR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzYIR22dkuFZ21ULDTUVA+DExB/OWtQpz457Exg64fVDgXxXn/RNYPqB3G97VYjdZN4nHb/0U+jT4nZkv5MYKwu6xlA6mXwchiett6xmglubRsEcbo8EXS9zlGr2nGnCcwjxX4rZD4XBmSad1QMIxG4F6dI6P6rwPe36mikxO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZU72NPK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZU72NPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762861456; x=1794397456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8hgo0SAlxDhqel27kLJFUy/dCtq9ThidmmkRD+8hvR4=;
  b=LZU72NPKF9J647HtlyNU1v8zTRgdqKmgM2a6wLW5SaFKi4GPiB9P1Inx
   rPT+yOnRdnnRTlgcENUxHg8l0oWOOeGKoxA1+lWbEL1jGfLSDFt49zKrl
   8HfW8XVlRwXk23SqpHke/Kpjftlvd/FHd0B3GtG6+w6mfIosDYEbS0zHz
   feoj1VKjJ7atr3JdfJp4iFitBzokh5jl/GLEFDTYp7TVUJUinTvAblOuz
   j3yC4LLOAeXoscAZsKBeOX+gGIydb3r6C9/LNw8CqaCS1MsUQKm1a+3Rx
   5m7aCt29eIxcIICAkrByojJaGA/RJBcKsAZK5z4RinClF6K8WriHOznQY
   w==;
X-CSE-ConnectionGUID: aYo+lPBbRbSh00FMgsZ4pw==
X-CSE-MsgGUID: Di1vNDxHR3yAht1prPDCYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64804535"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64804535"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:42:40 -0800
X-CSE-ConnectionGUID: eSASJ1xXSnGDKl/SB9RQ5w==
X-CSE-MsgGUID: yynfhYt5TZ2P13SXesI9FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188261875"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 11 Nov 2025 03:42:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 607B896; Tue, 11 Nov 2025 12:42:36 +0100 (CET)
Date: Tue, 11 Nov 2025 12:42:36 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aRMhLEs9NpGexL7B@black.igk.intel.com>
References: <20251010030348.it.784-kees@kernel.org>
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 05, 2025 at 02:03:59PM +0100, Daniel Gomez wrote:
> On 10/10/2025 05.06, Kees Cook wrote:
> >  v2:
> >  - use static_assert instead of _Static_assert
> >  - add Hans's Reviewed-by's
> >  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
> > 
> > Hi!
> > 
> > A long time ago we had an issue with embedded NUL bytes in MODULE_INFO
> > strings[1]. While this stands out pretty strongly when you look at the
> > code, and we can't do anything about a binary module that just plain lies,
> > we never actually implemented the trivial compile-time check needed to
> > detect it.
> > 
> > Add this check (and fix 2 instances of needless trailing semicolons that
> > this change exposed).
> > 
> > Note that these patches were produced as part of another LLM exercise.
> > This time I wanted to try "what happens if I ask an LLM to go read
> > a specific LWN article and write a patch based on a discussion?" It
> > pretty effortlessly chose and implemented a suggested solution, tested
> > the change, and fixed new build warnings in the process.
> > 
> > Since this was a relatively short session, here's an overview of the
> > prompts involved as I guided it through a clean change and tried to see
> > how it would reason about static_assert vs _Static_assert. (It wanted
> > to use what was most common, not what was the current style -- we may
> > want to update the comment above the static_assert macro to suggest
> > using _Static_assert directly these days...)
> > 
> >   I want to fix a weakness in the module info strings. Read about it
> >   here: https://lwn.net/Articles/82305/
> > 
> >   Since it's only "info" that we need to check, can you reduce the checks
> >   to just that instead of all the other stuff?
> > 
> >   I think the change to the comment is redundent, and that should be
> >   in a commit log instead. Let's just keep the change to the static assert.
> > 
> >   Is "static_assert" the idiomatic way to use a static assert in this
> >   code base? I've seen _Static_assert used sometimes.
> > 
> >   What's the difference between the two?
> > 
> >   Does Linux use C11 by default now?
> > 
> >   Then let's not use the wrapper any more.
> > 
> >   Do an "allmodconfig all -s" build to verify this works for all modules
> >   in the kernel.
> > 
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > [1] https://lwn.net/Articles/82305/
> > 
> > Kees Cook (3):
> >   media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
> >   media: radio: si470x: Fix DRIVER_AUTHOR macro definition
> >   module: Add compile-time check for embedded NUL characters
> > 
> >  include/linux/moduleparam.h                   |  3 +++
> >  drivers/media/radio/si470x/radio-si470x-i2c.c |  2 +-
> >  drivers/media/usb/dvb-usb-v2/lmedm04.c        | 12 ++++++------
> >  3 files changed, 10 insertions(+), 7 deletions(-)
> > 
> 
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> 
> I have also tested a build of v6.18-rc3 + patches using allmodconfig:
> 
> Tested-by: Daniel Gomez <da.gomez@samsung.com>

Folks, are you aware that this change blown up the sparse?
Now there is a "bad constant expression" to each MODULE_*() macro line.

Nice that Uwe is in the Cc list, so IIRC he is Debian maintainer for sparse
and perhaps has an influence to it to some extent.

-- 
With Best Regards,
Andy Shevchenko


