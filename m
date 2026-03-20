Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C253FD12F;
	Fri, 20 Mar 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035579; cv=none; b=qXAF0vzX5Xz5DloUPycUD06nVgd74aknSGLYRhBiv0hHdCrZijLHo/dC4sLiPsRJgLrWjYMsodP/s0f4yCxaq2CyVK8dmkm1WZSvzcyQWbK6xHwb0vquzcdBm+sd5yil/C2I3kCi3knFIGgg1l4jt5xz4iLhvIToGeVnJufvb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035579; c=relaxed/simple;
	bh=vdZnRm/9xp1ezGkDtjRjdUhZKUetr/nh4nzFXdSOK1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX1f9unfJBB2WeRJjVwZzP8dRfNhMf5Nh1nEP6b2vwICboDJTp0HAOOHueG8G2vhVyuNfRgx2kbBta1bF1mKY7ac2AXPFi/7G7y7QLtjhG4FC6Cx5JuhkwtgzCQ9ZzlE8IpB8QP2kGnz2TL90kSUjQhRN9cx0/tAB1gbD71hsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0WLQvd5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0WLQvd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774035579; x=1805571579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdZnRm/9xp1ezGkDtjRjdUhZKUetr/nh4nzFXdSOK1I=;
  b=X0WLQvd5/QurOV0+iDzq71XGSpAGHCOGkUAgQc8gyG4cG0j8VbOe8zMt
   OD7DerkM20mq1Qr+SkMeBpBT6BKx52ddqIKkCjaLR17tsjcKki0ubEtM0
   Z8mbgZVvPO+Q2UMQ59UQQtuXvKV92xg9TjrxkdiOgLva3bVu+Ts4CsX6g
   Iv+UKbg4RHZroBU8rBoPkRmtOHERFPja63z7fBD6dxOfSUx0tX/Uyavo1
   nKWOyCRCibtUfFWACAJ0koiR1jvq6a9DPyittm14MSo9LQCI6FKwbsLIx
   ToJeuR2DphsrjituX9fArUo1XZmIH2J7glQ0U5/Tzu80WylnkxZCbC/OU
   w==;
X-CSE-ConnectionGUID: EIlunr8uQgeRS+pP/Rt1fA==
X-CSE-MsgGUID: ZSKlD3ApTBeKeMhcATESsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79035988"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="79035988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:39:38 -0700
X-CSE-ConnectionGUID: 0JZHhr6OR82U39Cm7ZwMgA==
X-CSE-MsgGUID: 5LjUqmiqQLm6wQM9b4z0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223599950"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:39:35 -0700
Date: Fri, 20 Mar 2026 21:39:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Josh Law <objecting@objecting.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <ab2idYsOFxPfEIYY@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603201216.3CD33C4@keescook>
 <ab2fNTeawayVvjZv@ashevche-desk.local>
 <202603201230.74BBFFABAD@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603201230.74BBFFABAD@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 12:34:42PM -0700, Kees Cook wrote:
> On Fri, Mar 20, 2026 at 09:25:41PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 20, 2026 at 12:17:54PM -0700, Kees Cook wrote:
> > > On Mon, Mar 16, 2026 at 06:01:58PM +0100, Andy Shevchenko wrote:
> > > > strlcpy() and strlcat() are confusing APIs and the former one already gone
> > > > from the kernel. In preparation to kill strlcat() replace it with the better
> > > > alternative.
> > > 
> > > Yes please. There are a few places I looked at in the past that might
> > > benefit from being changed to seq_buf or similar (where snprintf doesn't
> > > cut it), but otherwise the removal of strlcat should be straight forward
> > > and would be well appreciated. :)
> > 
> > Thank you for confirming, this is basically the message to Josh to find
> > users and start converting them and kill strlcat() eventually. Josh, as
> > you see it will be well appreciated!
> 
> As an example of a seq_buf user, see block/partitions/core.c:
> 
> static struct parsed_partitions *check_partition(struct gendisk *hd)
> {
> 	...
>         state->pp_buf = (char *)__get_free_page(GFP_KERNEL);
> 	...
>         state->pp_buf[0] = '\0';
> 	...
>         snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
> 	...
>         while (!res && check_part[i]) {
> 		...
>                 res = check_part[i++](state);
> ...
> 
> All the partition handlers then use strlcat to append more details,
> and it's totally unbounded. The correct thing would be to build a
> seq_buf to attach to state instead of the pp_buf, and the handlers would
> use seq_buf functions to append their info, etc etc.

Indeed. Thanks for sharing the ideas!

-- 
With Best Regards,
Andy Shevchenko


