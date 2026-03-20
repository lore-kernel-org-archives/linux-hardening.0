Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C43F881F;
	Fri, 20 Mar 2026 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035556; cv=none; b=bExGQ/cujydRxvmZk2QVtHnl51rpgzgUvK9u0/GP5g4RjsKFk2PpJB0a006M8o9+QL6V/bpYaa59HM9sLNHCegYemwsCoNr6xpINwxKL7vJK6TStlFUjvcCfajxEViHSmrRF/15JYsnj3T0oquwEql4bJGXzaMZHdXl/Sbn1m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035556; c=relaxed/simple;
	bh=5mo1XkSavc8Gc5sYpj7fqZ4Rs23xLuUd5eKxuaZmw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj/sva2G1gEh+TA7gj2aOjepnyhXswhwX0/GiluGqBWwJucPn8NT5q2voEvNuItlh4NFlygAEdBYZM3XNBRXOcxHfse4F4sfi9NWIqIzWxiPvmsZcpQO08xtLU4gip8JSwRAkKDh4pqm/hTOwG2s8FmxYWC+0hl7cHttCuL1+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYjlga3n; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYjlga3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774035555; x=1805571555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mo1XkSavc8Gc5sYpj7fqZ4Rs23xLuUd5eKxuaZmw9M=;
  b=JYjlga3niY2DMmNtA7WIsyoRtCV2P/aZ7EYBvEifqBY2x9LwcP6CH+9s
   72E+HtYkRFp6NHALNEadpAryL+xpb9YAtN5Hvx4Bow6LKlTnGkp61p8iY
   x3+aaQ19ON7MswTyG8N9/XMm00SSFpFRgPy11tNKxjzE0SRIvwl8PNrjC
   vYlMoq2rqPsu+0ZeHHWKWmcyULiTg4VxWWAsFcMYnhW3W9asE7OGhMQOk
   TDK82Cfuk6+U7yQ6XU1bwNFB4TrV5TNqBkEWDjjPQkIz7hSr/VdbTwesj
   GmJfr6ZMk6Qnrxykrh60sacYfd1JIqvYBLjrmYtZP+xyOTz9zHfIjHrPf
   g==;
X-CSE-ConnectionGUID: b/0X8yVsQ8+nMJ7ZrCViaQ==
X-CSE-MsgGUID: w0JJbY1iS3Ki2Y8mAaKfBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79035967"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="79035967"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:39:14 -0700
X-CSE-ConnectionGUID: Vfx8FmPsRn+OcTOaqXZbsw==
X-CSE-MsgGUID: J6DjMfzGRsGi7j30jWnoEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223599892"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:39:12 -0700
Date: Fri, 20 Mar 2026 21:39:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josh Law <objecting@objecting.org>
Cc: Kees Cook <kees@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <ab2iXmvgJID3bAmg@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603201216.3CD33C4@keescook>
 <ab2fNTeawayVvjZv@ashevche-desk.local>
 <308B1431-EEA5-4114-9587-A553CCE75A22@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308B1431-EEA5-4114-9587-A553CCE75A22@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 07:31:54PM +0000, Josh Law wrote:
> 
> 
> >Thank you for confirming, this is basically the message to Josh to find
> >users and start converting them and kill strlcat() eventually. Josh, as
> >you see it will be well appreciated!
> 
> Thank you! But the only reason I'm not doing it is because if I submit all of
> the patches, let's say, 50 gets merged (including strings.c) and like 50
> don't, then 50 will have a nonexistent/slow API because they chose to not
> merge my patch

Huh?! Even if you do 50%, it will still be appreciated as it's not a job that
has to be done in one cycle. Also we expect to have a constructive feedback
from the maintainers. Killing an old and confusing API is a good justification
and it will be rare maintainer even thinking to tell against. The feedback
may be given to the implementation and how to improve or adjust, but believe
close to 0 maintainers will say a word against dropping strlcat().

-- 
With Best Regards,
Andy Shevchenko


