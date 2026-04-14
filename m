Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA578F26;
	Tue, 14 Apr 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151166; cv=none; b=R/FJyvqEIGNWFNJHZjgOcrQbs68IxhecO/UdquJGhOxmfWbTKckXBTf5+sZ6p+u00Xz7eHrz2cHleuMY2op+4qtRpzFntrXzhDrl4H3a1izwgU5z0lLXJglDZaI/7o0Ns4XSASa6UqCpTuTaEqVSuLPJI+rw8WdjjX2ay8opGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151166; c=relaxed/simple;
	bh=rPGmaE1xqOgLUeSHPd8fc+sxOLh2iVIIDmWEDlwbN4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmSsNYY8iN0GP7HGrt7p0UoWozxhHauMYR7EirwqI9oCML55VDhdm+Tn0refG34m5RcUstEad5eqHcVg7U419QPfltO1de9ZqIpzKybu5JT92I/rzdtNmJhXD0twoe2UO3e4N1GRPXuXN+Si473YCBoJLZfmozG2SKVDoj3tICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3lBTpYQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3lBTpYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776151164; x=1807687164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rPGmaE1xqOgLUeSHPd8fc+sxOLh2iVIIDmWEDlwbN4c=;
  b=B3lBTpYQNemZ3OMy7bZn/QQLinRO+Vu7ScnNuloTBNn5PQGoiRPY8qRR
   7EUQj8lOGNB6+d2jn17fuKaOkOn4zWJnvo4RElR+tZkZWdwTQowd/mTWP
   V9ZwpjKU3QFN9GQLGk1xQIDKt/bGc3GfOxBprtb6h4RTGhmMvDFmKfKJd
   W82ACPkwmpWj82SzOn9uKC9W1ilWqIm0Kk4Hd8gbgJ+as7GLSICsnIOLK
   tA58G9GNL40LvV3R5rw4xPfw2nvTqYLsAuhD0/BOWUiqP1Y1m//5UXBHq
   iKfp1aNpV5Vm1xV6uuCyx8dIt7Xe9H1T19tMsPoeGmZvgGO46jN1teX0g
   g==;
X-CSE-ConnectionGUID: AWy2oXfcRemFoo0w1h2M4w==
X-CSE-MsgGUID: D546ZSzcQEKruf3Jd8imOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87403328"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87403328"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:19:24 -0700
X-CSE-ConnectionGUID: yDtTyHdyTQmFXZbJ3bjvGg==
X-CSE-MsgGUID: NPpzxYHOThyhdMtsInFhEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227354373"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:19:22 -0700
Date: Tue, 14 Apr 2026 10:19:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: fix string_get_size() unit promotion
 after rounding
Message-ID: <ad3qeKiW1jIKHOMi@ashevche-desk.local>
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
 <adUaTrU_DZuK1Kd8@ashevche-desk.local>
 <CANAAWH+ihOpBVB5_Q4gxLs0_zO=pHb-kF53UXE-pqg1U9E9OKw@mail.gmail.com>
 <adayT_7xAtOLiVlq@ashevche-desk.local>
 <CANAAWHKDBoi1x=MpAyU5bQ88=ZOOrkaJNziyhcK9Ei7c8oNSHg@mail.gmail.com>
 <CANAAWHKZXbFAr7=DRCrS46GDsWi88Q=v883RQrgF4+EScksP=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAAWHKZXbFAr7=DRCrS46GDsWi88Q=v883RQrgF4+EScksP=w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

First of all, do not top-post!

Second, I just realised now that the discussion was done in private emails, do
not do this. Please, answer again with all what was discussed to the public
mailing lists as this message does.

On Fri, Apr 10, 2026 at 09:11:59PM +0545, Shuvam Pandey wrote:
> I think the open question is whether string_get_size() is intended to
> round across a unit boundary at all.
> There seem to be two possible interpretations:
> 
> 1. Keep the current 3-significant figure rounding, and if that rounding
> carries to the unit divisor, renormalize into the next unit. That is
> what my patch does.
> 
> 2. Treat the unit boundary as hard, so values below 1.00 MiB / 1.00 MB
> stay below that threshold and are not rounded across it.
> 
> If (2) is the intended behavior, then this is broader than the
> carry-renormalization case and my patch is not the right fix.
> 
> Which behavior should string_get_size() implement here, or am I
> missing a third intended behavior?
> 
> On Thu, Apr 9, 2026 at 1:55 AM Shuvam Pandey <shuvampandey1@gmail.com>
> wrote:
> 
> > I checked the additional base 10 values as well.
> >
> > For blk_size = 1, the current code gives:
> >
> > 999999:
> >
> > STRING_UNITS_10: before 1000 kB, after 1.00 MB
> >
> > 1000000:
> >
> > STRING_UNITS_10: before 1.00 MB, after 1.00 MB
> >
> > 1000001:
> >
> > STRING_UNITS_10: before 1.00 MB, after 1.00 MB
> >
> > 1048575:
> >
> > STRING_UNITS_2: before 1024 KiB, after 1.00 MiB
> >
> > 1048576:
> >
> > STRING_UNITS_2: before 1.00 MiB, after 1.00 MiB
> >
> > 1048577:
> >
> > STRING_UNITS_2: before 1.00 MiB, after 1.00 MiB
> >
> > So this patch only changes the carry-to-divisor cases, where the current
> > code rounds the value up but still prints it in the old unit.
> >
> > That said, I think your point about the broader semantics is valid.
> >
> > string_get_size() has long rounded to 3 significant figures, and my
> > change only makes that existing behavior consistent after a carry. If
> > intended behavior is instead that values like 1048575 should stay
> > below 1.00 MiB, then the real issue is not just the missing promotion
> > here, but the rounding policy itself.
> >
> > So I think the patch is correct for the current implementation, but it
> > may not be the right fix if the intended behavior near unit boundaries
> > is supposed to be different.
> >
> > I'll take another look at the expected behavior around these boundary
> > cases and follow up once I've re-evaluated that.
> >
> > On Thu, Apr 9, 2026 at 1:38 AM Andy Shevchenko <
> > andriy.shevchenko@intel.com> wrote:
> >
> >> On Tue, Apr 07, 2026 at 08:48:59PM +0545, Shuvam Pandey wrote:
> >> > For blk_size = 1:
> >> >
> >> > 1048575:
> >> >   STRING_UNITS_10: before 1.05 MB, after 1.05 MB
> >> >   STRING_UNITS_2:  before 1024 KiB, after 1.00 MiB
> >> >
> >> > 1048576:
> >> >   STRING_UNITS_10: before 1.05 MB, after 1.05 MB
> >> >   STRING_UNITS_2:  before 1.00 MiB, after 1.00 MiB
> >> >
> >> > 1048577:
> >> >   STRING_UNITS_10: before 1.05 MB, after 1.05 MB
> >> >   STRING_UNITS_2:  before 1.00 MiB, after 1.00 MiB
> >> >
> >> > Likewise around 2 MiB:
> >> >
> >> > 2097151:
> >> >   STRING_UNITS_10: before 2.10 MB, after 2.10 MB
> >> >   STRING_UNITS_2:  before 2.00 MiB, after 2.00 MiB
> >> >
> >> > 2097152:
> >> >   STRING_UNITS_10: before 2.10 MB, after 2.10 MB
> >> >   STRING_UNITS_2:  before 2.00 MiB, after 2.00 MiB
> >> >
> >> > 2097153:
> >> >   STRING_UNITS_10: before 2.10 MB, after 2.10 MB
> >> >   STRING_UNITS_2:  before 2.00 MiB, after 2.00 MiB
> >> >
> >> > So the change only affects the carry-to-divisor case itself; values that
> >> > are already in the next unit stay unchanged.
> >> >
> >> > I also rechecked the neighboring value 1048574, and it changes from 1024
> >> > KiB to 1.00 MiB as well. I can add coverage for 1048574..1048577 in v2
> >> if
> >> > you think that would be useful.
> >>
> >> Also with base 10 for 999999 1000000 1000001...
> >>
> >> I'm trying to understand the current behaviour better and the logic of
> >> your
> >> change. But looking at the above I think your patch doesn't improve the
> >> case.
> >> And might even be another bug in the current code. I mean, do we have to
> >> round
> >> the numbers? 1048575 and lower are not equal 1.00 MiB strictly speaking.
> >> It's rather 0.999 MiB.
> >>
> >> > On Tue, Apr 7, 2026 at 8:38 PM Andy Shevchenko <
> >> andriy.shevchenko@intel.com>
> >> > wrote:
> >> >
> >> > > On Tue, Apr 07, 2026 at 08:18:06PM +0545, Shuvam Pandey wrote:
> >> > > > string_get_size() rounds the fractional part before formatting the
> >> > > > result. If that carry pushes the integer part to the unit divisor,
> >> the
> >> > > > value is still printed in the old unit.
> >> > > >
> >> > > > This yields outputs like "1000 kB" for 999500 bytes and "1024 KiB"
> >> for
> >> > > > 1048064 bytes instead of promoting them to the next unit.
> >> > >
> >> > > What does it print for 1048575, 1048576, 1048577 respectively?
> >> > > (before and after your patch)
> >> > >
> >> > > All the same for numbers around 2MiB.
> >> > >
> >> > > > Renormalize the value after the carry so it is promoted before
> >> > > > formatting. Add KUnit coverage for the decimal and binary boundary
> >> > > > cases.

-- 
With Best Regards,
Andy Shevchenko


