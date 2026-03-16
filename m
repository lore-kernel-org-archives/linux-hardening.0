Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A738E5D1;
	Mon, 16 Mar 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679397; cv=none; b=bp8vrqX8nMxMF1xfk9iEjxSzo+F0WdJoTFjyGRE9ZahxN+4ulIiwUjGfpgF5kHlIR7E509aSJplTkx/HR1mD29UMga4Y++GNOvwr1XDYfI2zGmwvg5gkn/CQbQ4JJUdt2VSnG+CmmZU9I6LkJ4U8UrEmXBAHF4+2R0oYXS5u/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679397; c=relaxed/simple;
	bh=1dIhBB8pMRUDueKa9gpviYTOGi54LYsi7prXqqHhLJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geZHbT+Y1N4IU9+/0VdtpJldN/5waL4JdyQbfP3Nqkd69anvQBxfK9f4VE3N4vSooHXr/xkHaLYBiqXbYelAfT9lZGtgpcAbzbmXMc1vw0LBmJY2+px3LMIYsnG4su4xB4hX8OAw0I2EFtmX3VENiiGE5WvSWH7zXGaAnF5f+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8JGFqrx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8JGFqrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773679396; x=1805215396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1dIhBB8pMRUDueKa9gpviYTOGi54LYsi7prXqqHhLJs=;
  b=E8JGFqrx5JNnV3Zy5Cj+v4hEzTfxfHusAJ9a2KAk4YX+3P8Uqqt2vG++
   PGN46XXLJInz8XpSVFrsN3EeUYMJ5CMOPLfaEI4wRjIJvIXi2eFsQdl47
   LkenvS3KysMWYFED5G4LD33CRO8EZk8N6cUchlljdlTdMnOUfTVxUFvfv
   uBQFj04Xg/lqE9VxPyLRhrwejLNV5KnJwVQr5etRdXi+mA0IcOz6qcqmW
   365Cmy8cMBIRlOX8d+nxrNrbo1rHDIEdVWNVM2Tjs043UGCEfUbQAJTrA
   94OjDc3Xs5gozve4dBbDrKfDmNeY6yhxUWv7AK29n5hDu9sOyuaWisSn7
   Q==;
X-CSE-ConnectionGUID: YAc9q+8jRHS3R7vN7bXcLg==
X-CSE-MsgGUID: K+DDFieIRiicLmieH3mwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74591603"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74591603"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:43:16 -0700
X-CSE-ConnectionGUID: D1GjeyZLRPy8nNg7bIR2vw==
X-CSE-MsgGUID: qHGmst6ARe6mEHMUBGjvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226651089"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:43:14 -0700
Date: Mon, 16 Mar 2026 18:43:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Josh Law <objecting@objecting.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
Message-ID: <abgzILD0L2sdvAFZ@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org>
 <abgwF-yT_FtLTgQ3@ashevche-desk.local>
 <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 04:36:40PM +0000, Josh Law wrote:
> On 16 March 2026 16:30:15 GMT, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Mar 16, 2026 at 04:17:28PM +0000, Josh Law wrote:
> >> BUG_ON() in a library function is too harsh -- it panics the kernel
> >> when a caller passes a dest string whose length already meets or
> >> exceeds count. This is a caller bug, not a reason to bring down the
> >> entire system.
> >> 
> >> Replace with WARN_ON_ONCE() and a safe early return. The return value
> >> of count signals truncation to the caller, consistent with strlcat
> >> semantics (return >= count means the output was truncated).
> >> 
> >> This follows the guidance in include/asm-generic/bug.h which
> >> explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
> >> there's really no way out."
> >
> >First of all, this doesn't really change much, especially if one uses
> >panic_on_oops.
> >
> >Second, the entire function is kinda deprecated, it's better just to drop it.
> >
> >$ git grep -lw strlcat | wc -l
> >142
> >
> >(In reality it's less as tools and implementation are not users of it)
> >
> >Third, if the caller is that problematic this may lead to the serious
> >(security) issues.
> >
> >Based on that, NAK.
> 
> Hmm, good call, but how would I implement that? BUG_ON seems a bit too harsh
> for a library function.

Drop the function. Start from converting users to strscpy() or similar
(we have a few for different cases) and then drop strlcat() all for good.

-- 
With Best Regards,
Andy Shevchenko


