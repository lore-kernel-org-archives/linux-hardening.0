Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FB3B2AA;
	Wed, 15 Apr 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264167; cv=none; b=QdDpqPNF8qsNd85j3dTbhRat7BeSM2W0mvXgZonlGi3k1zVY2xFFpe3utMfob+7YXlh5K50mNa/5pjpFFarOeN01L98BxouoHKLBf223TUnAN3NpI9F6ACbhd4DYablGTKvD8e/n+RtyXM64Ti38x7H9KNt3+omlhf6ZyngQ9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264167; c=relaxed/simple;
	bh=E83nbcTV42M9soctRWSjHMAiZ/i8aJsi9B6vQHHtrQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEqxM0eVGJRKCdjIVqwWma1kt1MTTj2P7kBywG8FN+97jmZM043ZOmYUA8kS8T+4VTxzRMXv/ghxjEuLPRYcMs43+wc3oewqKb1sOWMbum8uudKFEpN59Jw1cK6BNyRiijJUGqmGwjPlToF/GSXCsLdYBgkCYHRcRVsR0MP6vR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm8CRbkl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm8CRbkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776264166; x=1807800166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E83nbcTV42M9soctRWSjHMAiZ/i8aJsi9B6vQHHtrQA=;
  b=Bm8CRbklV0ZrtwEHldZHz/zivQJLqrRfcrFq2krYh/Qem+sLtJEl+1Pt
   jb/Zt8MvHYM577oShB+DSfmPul4/3c7JTIGynxgOPC9UFBXRhBHYqCEHH
   PmK6ow8lJfeni5nf0erlpXPkyM8SUlDN1J5avrVeFflFL8MVW5pTzZ1TM
   H/CqaoRstX4l5zXSg4V39lHYwL1+tOsTxTLAT9oZogA/gySBefmGpJmOD
   ZbEE16L6NAc8VT3NZ0j9T0xBkdb0MZ3+kWPuV7/QHSffVCl06gvv+Ym7A
   +5hDe24G4dIkAvNkOZbc39QrKhfixnAYFttkvdnURfQEOcdF+gUfYZX9M
   A==;
X-CSE-ConnectionGUID: u43bJ8X3S9CKMleE9JXbQQ==
X-CSE-MsgGUID: uBtgWPJeQwKRnhNf8rUBRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81117195"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="81117195"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:42:46 -0700
X-CSE-ConnectionGUID: /Tc9fpfWTK6rzRsrRx4nZw==
X-CSE-MsgGUID: y+IipJzVRL2znN+btqf6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253672074"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:42:43 -0700
Date: Wed, 15 Apr 2026 17:42:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <ad-j4eGpltrb-WQj@ashevche-desk.local>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415122542.370926-4-thorsten.blum@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> kasprintf_strarray() returns an array of N strings and kfree_strarray()
> also frees N entries.  However, kasprintf_strarray() currently allocates
> N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> 
> Also update the kernel-doc for @n.

Have you checked all current users that they do not rely on the NULL terminated
array?

Note, that was done on purpose that once allocated it can allow user
to drop the track of the number of strings and rely on NULL terminator.
I.o.w.  the number of strings may be just a local variable somewhere
where kasprintf_strarray() is called.

I tend to NAK this change, rather you can update kernel-doc to explain
why it's done this way (see above).

-- 
With Best Regards,
Andy Shevchenko


