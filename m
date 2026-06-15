Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D03382F0;
	Mon, 15 Jun 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535754; cv=none; b=Y48W6GlZWdFVlv8+T1gtIW3Hi3oFV6/ZTBEDCPcvl0BTgTOBvGfct1I/fPxJf5A0AVf0NBqUoQ9Xq+S4eWtHyFbRqG/G1gTunbUfAgxI/gPHrfCKYPR1Nz6Ma6XSCMhczaaYx8dwxcseIWkzlGppR7KxFGHihsJupMrTSn01e+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535754; c=relaxed/simple;
	bh=0V2c8bYvVAVZidoqbYW1iMLPdWLq1fTB69wtnPUKKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shAKpdd17ICDFUwnFfD8TfmT7xD9/1by/3LZfgRM7buQQ3CiX7zs5BZeRKzPl2RlEiJZwmHZXhQddsCeiO8eK9srwrH9MnPp1VMNb6i/1k7p3j54am7HlCQa/w1oaQenCQM6D11u6D4AA/kjyqw8ggfvPO9eBrMN5Tz9CIHdusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0S54tek; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0S54tek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781535754; x=1813071754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0V2c8bYvVAVZidoqbYW1iMLPdWLq1fTB69wtnPUKKZk=;
  b=T0S54tek3OK0usSKnV0CDurETJH+fFps0chRZON/i5UNZ+d0YyIzhL5/
   2KfXMmYjhEO88ZCjAXZ9/VunqbdCk3bLFi+ErdzaHNz4iIlyM29hWF+x2
   wEIzs1e5utlPcbS/KAbOaq1SnXE0bjfL1RefRIZrmelPlUt+9sbuO1asu
   irptVo6Qa3ytctMtv1F+pcMfM4J8mB9btAkQxBV/xkASCVWz7GkLWllmm
   MFAZKJKYTc79KETdfqaIQT3Gv5Nrcc7RkzpZn1Dz93TQSDfMTDMdyej8l
   6MHvs8evCiIBONPl515W0w1UGYWtraOxNrX4DI9ULbwBCQyytTVpGmMSh
   A==;
X-CSE-ConnectionGUID: AzRQO6d7RUu1j8qbcHlUtA==
X-CSE-MsgGUID: 9TMq5k9zQuKCv1RY7aMv6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="81413871"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="81413871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:02:14 -0700
X-CSE-ConnectionGUID: dft0cxxhR2GTkAVnWTt3BQ==
X-CSE-MsgGUID: j/rtbC5IRzq1oxvXQbC1sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="244595682"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:02:10 -0700
Date: Mon, 15 Jun 2026 18:02:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dan Carpenter <error27@gmail.com>, Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefano Zacchiroli <zack@upsilon.cc>,
	Steven Rostedt <rostedt@goodmis.org>,
	Laura Abbott <labbott@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Wenwen Wang <wenwen@cs.uga.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, Dawei Feng <dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3] Documentation/process: Add Researcher Guidelines
Message-ID: <ajAT8Kahu3feEOC8@ashevche-desk.local>
References: <20220304181418.1692016-1-keescook@chromium.org>
 <ahgaOigklcDCYvRp@stanley.mountain>
 <ajACprp9UJp2JSJM@black.igk.intel.com>
 <875x3j3l5x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x3j3l5x.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 08:58:34AM -0600, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > On Thu, May 28, 2026 at 01:34:34PM +0300, Dan Carpenter wrote:
> >> On Fri, Mar 04, 2022 at 10:14:18AM -0800, Kees Cook wrote:

...

> >> > +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
> >> > +  11.2 show no new warnings, and LeakMagic no longer warns about this
> >> > +  code path. As we don't have a FooBar device to test with, no runtime
> >> > +  testing was able to be performed.
> >> 
> >> People have started sending commit messages in this exact template and
> >> normally I would ask them resend with the meta commentary from this
> >> paragraph below the --- cut off line.
> >> 
> >> Do we really want this "Compile tested only" stuff in the permanent git
> >> log?
> >
> > +1 here, can we rather avoid flooding commit messages with the meta, that
> > anyways is available in lore.kernel.org archives?
> 
> Perhaps somebody should send a patch correcting the wording to how they
> think it should be...?

Perhaps Dan as native speaker can do it better or others who were involved in
this?

-- 
With Best Regards,
Andy Shevchenko


