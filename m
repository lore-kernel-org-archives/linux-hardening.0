Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263793;
	b=ykrV5v8js5kOrtEEHcq1Fv10ueJtEhkpR92BXWwVJ4JKcmxDfNskQMzsBT8fNhDGxZHC
	 475QeGVLTFgtxfqo7WhylTaZAQYIkzV6YjcTyQCTODFSQdx3KNkrTeZ6hHIM6uKE+V6xT
	 K1lFzJQKHYUIxbHt6BEj1IEAmaWl2d3Wp4K9vVYy2ZA5oTtMtTkokXI0ebHBaEbwsI1xw
	 vZ4R8Dj93OEOrmwjBpoSw89OC5abhxVXj639dEmrdP9kRE6ZuKTWqAl2mB9PLfqLGL3b8
	 I2GMpP02cde8CmSlTRHFGwIewfq4sBUhsuEA31NLEGzq9RkWTlsstXaI1mpDpB6FOFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263793;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RAD7j9whtlVxi4idGzxZNOOQo3aSRCIudDY3EkMacks=;
	b=h1N4Oj36Soa9scINYriD4/+/3Y5w2C9nqtatYuAM/+jZdBzkISynQ6C8Keswc2wZDTHj
	 bBDd/hlqdT+WU1T6sw54gpqskbLi9Rj6L7VtPE9Ye538iCc3fj/8Blai3P+RqX0Ka707P
	 aKyjYOCu/H8mjYY3Hezq4IFWlcvLSd9/txbhMa9o1DCb5A8KnmXqHuXCZTT1w9dGuIKp7
	 +1OQs6NfA4wyk+YwoDRl8Ihs/1jVGNpjFrY5tGlYyk3bEFqjvODwxso0qdFRnrTDYLMVe
	 E7CJotgDmAao77zafJMo9sYbbVXibum+2wbHIV2Niruh27mIb98v6uA1Njvjjr5OjdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bly0HD4a;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69689606A325;
	Mon,  9 Nov 2026 22:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69689606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bly0HD4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794263793; x=1825799793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qoEBEYWCz9dH5MiLs3jExw8OGhdQVJnuSBEorHHTbAQ=;
  b=bly0HD4aJEyDtMu7hSRADCJmNcsB58G31IXeggR8ja2ohPRmY4UN0ybQ
   8i8YdJ7FFGBi7Ar5bXgSv/7vGsuFGwqw1iPZeDcQjc8gKmZJPHIi8cZI1
   doZBBvHGDkTBAwlFjIOtyfkv9SjEs/pk4iYF+W+IuniXcLdmwvvdYE0Zw
   QleqXpVxcQFdFALLG9IHsbwVpXFHQshiwLlUJ6N6JW2TvS2Hek1uAL+xf
   ya186Q6cye4T9rYT65sFmg+d0USfb08MHrAcgAZ6NvHw8K6R2OFeJadn/
   mtM1vTXALrhFznKP+RwRvKufwKgqiSPM07zN2egnjtlNV0NTscBhqAXwV
   A==;
X-CSE-ConnectionGUID: Rprrm0S6SSSc43dV3t9CuA==
X-CSE-MsgGUID: C1FIyUsBSZGSPZx8k5czvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3012003"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3012003"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:36:32 -0800
X-CSE-ConnectionGUID: VmjHkxDAT6SPVaN2PnVDmA==
X-CSE-MsgGUID: rqdczbCuRKSkmkeXwVwD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8125082"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:36:25 -0800
Date: Tue, 10 Nov 2026 00:36:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>, andy@kernel.org,
	bartosz.golaszewski@oss.qualcomm.com, brgl@kernel.org,
	dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com,
	driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl,
	joe@perches.com, johan@kernel.org, kees@kernel.org,
	laurent.pinchart@ideasonboard.com, lenb@kernel.org,
	linusw@kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, namhyung@kernel.org,
	rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org,
	sakari.ailus@linux.intel.com, saravanak@kernel.org,
	schwab@linux-m68k.org,
	Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avJK54xRN9_Sta3k@ashevche-desk.local>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
 <au7TvMP0YhW2e_oM@debian>
 <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>
 <avBglVuXPjbKnWwl@debian>
 <avBikocxPXRos_GF@debian>
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
In-Reply-To: <avBikocxPXRos_GF@debian>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 12:54:33PM +0100, Alejandro Colomar wrote:
> > Date: 2026-11-08 12:49:08+0100
> > From: Alejandro Colomar <alx@kernel.org>
> >
> > Hi Maciej,
> > 
> > > Date: 2026-11-08 11:05:51+0000
> > > From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> > >
> > > On Sat, 7 Nov 2026, Alejandro Colomar wrote:
> > > 
> > > > Hi Maciej,
> > > > 
> > > > > Date: 2026-11-07 02:44:23+0000
> > > > > From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> > > > >
> > > > > On Thu, 5 Nov 2026, Alejandro Colomar wrote:
> > > > > 
> > > > > > Do you think strafterprefix() would be better?  Do you have any other
> > > > > > suggestions?
> > > > > 
> > > > >  FWIW strsuffix() seems an obvious choice to me.  After all what the API 
> > > > > does is request the string's suffix beyond the specified leading part.
> > > > 
> > > > Actually, strsuffix() is something else:
> > > > 
> > > > 	char *
> > > > 	strsuffix_(const char *str, const char *suffix)
> > > > 	{
> > > > 		ptrdiff_t  off;
> > > > 
> > > > 		off = strlen(str) - strlen(suffix);
> > > > 		if (off < 0)
> > > > 			return NULL;
> > > > 
> > > > 		if (!streq(str + off, suffix))
> > > > 			return NULL;
> > > > 
> > > > 		return str + off;
> > > > 	}
> > > > 
> > > > It finds the start of a suffix in a string.  That is:
> > > > 
> > > > 	strcmp(strsuffix("foobar", "bar"), "bar") == 0;
> > > 
> > >  Hmm, I'd have called that strskipto().  If that's not possible for some 
> > > reason (I can't see it used in Linux), then strskip() or strskipover() 
> > > could be used for this API.
> 
> Another issue with the name strskipto() is that the name doesn't make it
> clear whether the second argument is a string, or a list of characters.
> 
> That is, would strskipto() something similar to strpbrk(3)?
> It's not clear from the name.  From strprefix() and strsuffix(), the
> meaning of the second argument is clear from the function name.

On this bikeshedding thread I'm with Alejandro.

> > strsuffix() exists in many projects, and in all of them it seems to have
> > these semantics (or very similar ones).
> > 
> > Just look at a Debian code search of those names.
> > 
> > The strprefix() and strsuffix() pair of functions are widely
> > implemented, and while the exact details of the return value differ
> > slightly (some return just a boolean, others return a pointer that can
> > be used as a boolean too), the overall semantics of them are quite
> > consistent.  strsuffix() has less drift than strprefix().
> > 
> > If we added strsuffix() here with the semantics commonly attributed to
> > strprefix(), and then had strskipto() with the semantics commonly
> > attributed to strsuffix(), I'd expect programmers to eventually get
> > confused and use the wrong one. 

-- 
With Best Regards,
Andy Shevchenko


