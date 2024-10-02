Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397A1D0E3A;
	Wed,  2 Oct 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878297; cv=none; b=ievfEySPOb8l3ss8GPLRh4dxrwFH5MkCnaFo1UL7QJSSmvmd0m6GvW2W/bOwlvd8IwILHrxTOx8i73KsJ+mWVMdT0O9dka327RhlNX9Np0C6lHe9Rg893+d5+e/Y6knyuZOoaLNv6qVShUSiJcEVFQRaUialmAJY9i0kyovOdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878297; c=relaxed/simple;
	bh=EtOUAr9Y/81o8bMeICHMZyLKIgsRhG13I+i+P1KINB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glxcv1Tvo69CG0BlLB29ByO8PaN/sKam0FlX2Pgpydpmo7Rb9QDXm/oBeTk+k3R66rNyUJKedLIGbs7W4shsIq3RKyccsfcD0lXGyjafJi+7jReVRVtxBoLftc1f9v4CykZDY8g0rh1cSLHWVWu+YrN4SEe+Jionaca84uZruFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: n6jeB9LETrCvIoUeC7sDeQ==
X-CSE-MsgGUID: V1bSAP0PRQG+AAveJRfwNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26932433"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26932433"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:11:36 -0700
X-CSE-ConnectionGUID: RN952sEVQmGPuLE4BX47fw==
X-CSE-MsgGUID: ZaTsfCDeR6CN+/IpmZMCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="73689617"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:11:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sw04h-0000000FhAM-3zWw;
	Wed, 02 Oct 2024 17:11:31 +0300
Date: Wed, 2 Oct 2024 17:11:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: linux@treblig.org
Cc: kees@kernel.org, akpm@linux-foundation.org, pmladek@suse.com,
	rostedt@goodmis.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
References: <20241002012125.405368-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002012125.405368-1-linux@treblig.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 02:21:25AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> bprintf is unused.  Remove it.

bprintf()

> It was added in
> commit 4370aa4aa753 ("vsprintf: add binary printf")
> 
> but as far as I can see was never used, unlike the other
> two functions in that patch.

Please, rewrap these lines to use more room on each line.

...

I am not familiar with tricks in BPF or ftrace code where this actually might
be implicitly called via a macro, but brief grep gives nothing that might point
to that. Hence, with the amended commit message

Reviewed-by: Andy Shevchenko <andy@kernel.org>

P.S. I hope we may rely in CIs to report issues soon, if any.

-- 
With Best Regards,
Andy Shevchenko


