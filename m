Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490F1E7660;
	Mon, 16 Mar 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680026; cv=none; b=V//a5ZSvzAlH8eeotxAsiyb0Y2tJHPVYmC/brcIW+MyFBFibbOq6uOdrkceM16CdW9I1QbMeg6uCS8iYHesDyxkY753CjNQ2CF0oK+m7Xvmo4vcb1IV9XJsE9AZi2Iv0Y/fR5ISXoP9cjermupo04TyQrDxzc1L1z4ahfQ4MMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680026; c=relaxed/simple;
	bh=KEqZZnA8NMf336jXT3UPzAIZmUE2F/bbnZplwBeXS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bil213TsbmUO7+KreOyv4aMahgg5kexM/WolzUcnGqKWmrfzbt+DY0i9+5/1sRS5AnWC6HZ9W459nYuz7g2M7iL+RkamX1BYsup8JpDJPpDNt1iP21Ob1ZlllalPjDEdnNZh7kWKl14KmopMkOOQVD5HAeUOq52QzKLuc5oMXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOEfIulg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOEfIulg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773680025; x=1805216025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEqZZnA8NMf336jXT3UPzAIZmUE2F/bbnZplwBeXS4k=;
  b=lOEfIulg+O3buWaB0kr6SSx9+Dczio0uoSfIUJlaAMebi+SDxLtYUR3M
   9iYOqEPHihxZRfqD5ts8F/5RAp94MdxZnHfPyuq5f0a/MGlZYVAZwQLQ0
   j1ZoIiHkWEgpIOcKjqmuM+mvc0JXxKCYC6sWnHtJ8+O2ICyzDp7Y575Rh
   pgIXVdyUf9XfLvNXdUbQ5XkB1rOdo4tuvNNp9YRQAlT3zu9NvYggH4MCG
   5iQbTzaWK2P5nGmaxEbhbEVMNBWGm6i7U98+xRJEVYBfQ8kRWukphF2om
   wJLHcpiE8em+dnjupt9D6VG+gW+NcHYjGj/7xjW4cHITqd7wlKniyGk6I
   Q==;
X-CSE-ConnectionGUID: NhHvJ+5bS0aGvbi1/5erXg==
X-CSE-MsgGUID: asmyUuH5RV6jKt+lDmhyig==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86180872"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86180872"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:53:45 -0700
X-CSE-ConnectionGUID: yTQ+jQlyRtiH6OV/A8KfzQ==
X-CSE-MsgGUID: PxD4loqWTMShlqfURvWj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221219132"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:53:43 -0700
Date: Mon, 16 Mar 2026 18:53:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Josh Law <objecting@objecting.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: rewrite strlcat() to use sized_strscpy()
Message-ID: <abg1laKmwpw-762f@ashevche-desk.local>
References: <20260316164939.89349-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316164939.89349-1-objecting@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 04:49:39PM +0000, Josh Law wrote:
> Replace the hand-rolled copy logic and BUG_ON() in strlcat() with a
> call to sized_strscpy(). This removes the kernel panic on caller
> misuse (dsize >= count) and instead returns a truncation indicator
> consistent with BSD strlcat semantics.
> 
> strlcat() is deprecated and callers should be converted to strscpy()
> or similar bounded interfaces.

I mentioned something different, id est converting users.
This function will go when ~130 or so users gone.

So, I don't see a need to touch this function (implementation) at all.

-- 
With Best Regards,
Andy Shevchenko


