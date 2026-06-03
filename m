Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE53769F9;
	Wed,  3 Jun 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472597; cv=none; b=u9i3dtFxf16SfCnbGwAO2L3ZhihtK+thPQ593CP9ixmMHoYblcjFMWLZleGx7ji6fSSIuhEx5h9AY7XvdflRdzIm3htFlPhtMc+VpeW//G4o6AQj1FqVY0syQSkl8sa4q28S5r6P5xLgHM6gi+xnitw/xgb2RC1ollpQwtam7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472597; c=relaxed/simple;
	bh=6h3lH+5ByUAkFiammymSyFzWThp9nOcipBln8oHRkzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADlZskTiBO3f6JovS8vYOzOykkP+6wyv8HYwNWbo2h6CUkA6GWW1lAVftqym+v1HDAjtUsporh/YFpiPfYNFu8poLQKgaSLUD+7qajsQNXOoGi/fTDLa7s5OuAVlTjRENxhG5wIGTma9dkAxOJV+RiFPzG4IP1CGQuAaFNoy80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6KsQFqL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6KsQFqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780472595; x=1812008595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6h3lH+5ByUAkFiammymSyFzWThp9nOcipBln8oHRkzI=;
  b=D6KsQFqLoDYgKnuzYOcFwB7p2gbtSPndEF46tlqrlDgDYjBJbKe08uzQ
   ME5CaMNYlPwM2lMCXJmV4eLbX/wb6B7dHp48ybwqkelc/upsKYLkMzFZi
   /2aZ7zzsFO4+QQX6V9Z94s4HhEDYT5WoD4S0JAsVKfTnwL/MO9uvElcUr
   d7wHZ8QuZ2MJxJW8oKvPVfg8c+RV9Ve13h96LYeMDAML3qa/hMlgjcRXS
   LaM7z9kIf3deoAhukHUZzcpkMNYfLbWY/tJB9qPAkIomjw1mbWUfWawly
   kZHRb6jjJ674YIBvddasTugYAPyu9uTzR/So0f+OLMzkvRjTvGBRvFfSX
   Q==;
X-CSE-ConnectionGUID: vKtE9iumSSmYRuf+XPYElw==
X-CSE-MsgGUID: mjtRZG0ASLysRMbZfju6Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106721710"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="106721710"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:43:15 -0700
X-CSE-ConnectionGUID: yMsbg1W4Swu0S5/AeY+Wdg==
X-CSE-MsgGUID: zVB+PfDTRR6bDkYFmfZ/uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248464462"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:43:13 -0700
Date: Wed, 3 Jun 2026 10:43:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] string: Add missing Return sections
Message-ID: <ah_bDg7tr6iDpDWA@ashevche-desk.local>
References: <20260603071648.106679-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603071648.106679-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 09:15:52AM +0200, Andy Shevchenko wrote:
> The kernel-doc unfortunately can't catch some corner cases. Hence
> the commit 645b9ad2dc6b ("string: Add missing kernel-doc return descriptions")
> missed that. On top there is no consistency in use of Return/Returns.
> Address both problems here. Choose Returns over Return as it will be
> less invasive change.
> 
> Fixes: 645b9ad2dc6b ("string: Add missing kernel-doc return descriptions")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Cc'ed to the Documentation and kernel-doc people to point out on this
> kernel-doc corner cases. It didn't complain on the macros that return
> a value. Also it would be nice to have file level consistency on
> the naming of the same type of sections, e.g., Returns vs. Return.
> 
> Kees, feel free to drop Fixes whilst applying in case you think it not
> worth it. The commit message still has a pointer.

...

>   * Helper for __sysfs_match_string(). Calculates the size of @a automatically.

Oh, and it should spell @_a in the above... (however it's not quite related it
seems okay to address while at it). Kees, can you also fix that? Or would you
like to see a v2 or a separate change for that?

> + * Returns:
> + * The index of the matching string in the array or negative error code
> + * otherwise.

-- 
With Best Regards,
Andy Shevchenko


