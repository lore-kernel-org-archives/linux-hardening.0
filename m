Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585910;
	b=Eb/4zuzsX70zsSvgmt0IugvIjDStBpzEO5b7TYChXXMUxBdKtruILZZZJygbRU5pJ3JP
	 din8Z6ii4co/c4wm+98MmWoFTPaslu87cO1K3xnCqvy/4wny8TCkD7qmUpw2TUL0xrUp1
	 612+N86oKLnJ4K+dAhNAYd1DVyp6lhDWzsBuHkUmBDwDZwvlmKGww4GylqouAGt9LZ+t5
	 VXTmpF88yOTORXU4qywdEvtrbCv1gI5lL0JeyVzbs7Jc8HXBlIUEVBgPgEMkIi/52sbaL
	 Lqamyes18qCRbaC+FsYwzFdk9CfW1/tQezNGgltclEIKYptN6WsvOfr88KcaUvwqi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585910;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=IVLcbYP/2x3oBnpc+H1o/8ltgHKpDztlu290S6AWpgM=;
	b=VPoUYjvKTJBckDdW529nC4ATqI1ojUlk6eW4y/auD2VfaMlvacoXN8O7wF1HFWrxA0J7
	 QVFXpna79M3buIfPIo/NLcu66tNhq6RKzFejc3QMbA3VxjyzVhBgADT1KbpS88oEb55JU
	 nO36ULY+JWtTbNU09eqbm7HfuvRX6nS3DygVCFuxwgsk/1Vbi6dp1+GSmS+oLeIOzTH0e
	 rPD4UPm/39WZ3YoSSUo9MniGYLst6C1uB3H/Auq318t7YJGKFQOPtkR8MXYGoN5d1NT0j
	 PmKsP+z4OXa9Dv/edSulibTwOtSH9VX3XnMGnTAJ0nSEq/hPXPyXXd8/K17hEaIiHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LgVHqffz;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE0607622F;
	Fri, 13 Nov 2026 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BE0607622F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LgVHqffz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794585911; x=1826121911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q0GrhDF9dKKz0trawfb8B0WQoN6GkTsGfDPTz328eEE=;
  b=LgVHqffzqxZctUMA+C0JN7DC9ZfqrL2wNbL46QXXNsSce6NDwPaqWq8G
   SM5sv2mNOXwqBbRzNoIyWMqSfbO//T6fVzzE4j69NB7yaS4gXPZUY0DjJ
   uwCs0G9c9PkhnaT6omUME/8s2tzwOVdu/rmXzQ6t1DZotrP02yebUOHVq
   0Ok6rte8KLm7m4wDh5HSTslbDy84AULHcw9rzI8O415Ane1lk761RffZl
   M2JfS7IozW6oFQyoUqS4taXAOW+KlNG4v1UiVsOJdw1/brBgQFILZmRe3
   fpnCfQWL/Q18a4Uvs9n2coRywralp/PcYafgPqFAj72iojZpjFv55R9rK
   Q==;
X-CSE-ConnectionGUID: a1MdIGeGRXifsBTi8LZUFQ==
X-CSE-MsgGUID: 6jUDb+pjQ0amfYyA8TAf4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3384331"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3384331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:05:10 -0800
X-CSE-ConnectionGUID: 8eiFSIRjQtuNpialV6sFrw==
X-CSE-MsgGUID: yIUirK27Rtq8n6s7LLz7GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8772630"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:05:02 -0800
Date: Fri, 13 Nov 2026 18:05:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Len Brown <lenb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avc1LK0_Deeh0zZo@ashevche-desk.local>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
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
In-Reply-To: <avcrlaWDlBVAHpnj@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:39:34PM +0100, Alejandro Colomar wrote:
> > On Fri, Nov 13, 2026 at 03:59:46PM +0100, Alejandro Colomar wrote:
> > > > On Fri, Nov 13, 2026 at 02:11:17PM +0100, Alejandro Colomar wrote:

...

> > > > >  static inline bool strstarts(const char *str, const char *prefix)
> > > > >  {
> > > > > -	return strncmp(str, prefix, strlen(prefix)) == 0;
> > > > > +	return strprefix(str, prefix);
> > > > >  }
> > > > 
> > > > There is no sense to keep strstarts() at this point.
> > > 
> > > I agree.  Actually, it seems my guess that strprefix() would be
> > > optimized out was wrong, because the kernel builds with
> > > -fno-delete-null-pointer-checks and other flags that prevent this
> > > optimization.
> > > 
> > > > Can it be simply redefinition?
> > > 
> > > I was thinking that we could just do a simple search and replace
> > > s/strstarts/strends/, prepending !! in some cases if needed.
> > > 
> > > By 'redefinition', do you mean making strstarts() return a pointer
> > > instead of a bool?  A problem with strstarts() is again the function
> > > name: it doesn't seem to naturally fit with a function that returns a
> > > pointer to the position.  It also doesn't clarify whether it searches
> > > for a string, or for a list of characters (like for example strspn(3)).
> > 
> > We have str_has_*() for that?
> 
> I don't fully understand.  str_has_prefix() --which is the only
> str_has_*() function, BTW-- is meant to be the same as strprefix(),
> except for using an offset instead of a pointer.

You argued that strstarts() versus strprefix() is a naming problem,
I answered that str_has_*() is for that kind of ops to solve naming issue.
So, semantically str_has_*() should be like a boolean checker (or behave close
to it, which it does).

> -  strstarts():
> 	It could be improved by returning a boolean-like pointer,
> 	instead of a bool, but:
> 
> 	-  We may need to fix some callers, since some of them might
> 	   need an explicit conversion with !!.  It'd be risky to change
> 	   the implementation without first verifying that.

How many cases do we have that needs special attention? Can you run spatch to
grep those?

> 	   To avoid that risk, I prefer adding a new API, and
> 	   deprecating strstarts() for new code.  Over time, I could
> 	   slowly migrate users from strstarts() to strprefix().

I believe this is unneeded step which may last for a few releases without even
guarantee that it will be finished. In such a case I would like to see a branch
with full conversion done before you start sending per-subsystem pieces out.

> 	-  The name isn't ideal, since "starts" doesn't specify whether
> 	   it looks for a string that starts with a given prefix, or if
> 	   it looks for a string that starts with any of the given
> 	   characters.
> 
> 	   That is, by the name, I wouldn't be able to know whether
> 	   strstarts implements
> 
> 		bool strstarts(const char *s, const char *xxx)
> 		{
> 			return strspn(s, xxx);
> 		}
> 	   or
> 		bool strstarts(const char *s, const char *xxx)
> 		{
> 			return strprefix(s, xxx);
> 		}

I didn't get this. We should not really need an implementation details of
the API beneath. Documentation what should be read before use. Do we have
documentation for strstarts()? Is it clear? Maybe that what should be addressed
first?

> -  strends():
> 	Same as with strstarts() but from the end.
> 
> -  str_has_prefix():
> 	It was an attempt at strprefix(), but with a problematic
> 	approach.  It's frozen because of trace code.
> 
> -  strprefix()/strsuffix():
> 	I'd add them to slowly replace strstarts()/strends().

See above about "slowly"...

> > > I prefer replacing strstarts()/strends() with strprefix()/strsuffix().
> > > 
> > > But if you prefer changing strstarts() to return a pointer, I'm also
> > > okay-ish with it.  It's not a perfect name, but I can live with it.
> > > 
> > > > However, after looking at the uses in the kernel, I prefer
> > > > to see the strprefix() be not implemented at all, just optimization against
> > > > strstarts()/strends() if required can be performed.
> > > 
> > > I don't understand this last sentence.
> > 
> > It's basically repeats the idea of having only one pair out of two.
> 
> Ok.
> 
> > With this series will be
> > 
> > str_has_previx()
> > strstarts()
> > strends()
> > strprefix()
> > // potentially strsuffix()
> 
> Yes.  I'd like to replace strstarts()/strends() with
> strprefix()/strsuffix(), but prefer to do that slowly, to avoid
> introducing bugs due to missing explicit conversions to bool.
> 
> Should I add notes that the strstarts()/strends() APIs are deprecated?

Isn't Steven against that? I already forgot his points. Keeping them
just as aliases to strprefix()/strsuffix() perhaps the good start
(see below).

> > To me seems too many for the similar task. I understand that trace user is
> > special one, but does it use strstarts()/strends()?
> 
> I didn't find any uses:
> 
> 	$ git ls-files | grep kernel/trace/ | xargs grep strstarts
> 	$ git ls-files | grep kernel/trace/ | xargs grep strends
> 
> > Despite on naming I think we just good to have only str_has*() and one of
> > strprefix()/strsuffix(), strstarts()/strends().
> 
> In the long term, I agree.  But I think the transition should be
> careful.  What do you think?

Yes, it should take a few phases, first one perhaps to align strstarts() to not
rely on the returned value to be boolean.

In parallel with that, your current series can also be considered. Then
similar, if even required, to be done against strends(). And one more phase
is to replace strstarts()/strends() with strprefix()/strsuffix() all over
the kernel.

-- 
With Best Regards,
Andy Shevchenko


