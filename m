Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD82EA15C;
	Tue, 13 Jan 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293232; cv=none; b=ndSYwusmkH6GxxeT4UaO6x6tE0EdGhOBSmdlwpubIAheTyHE7e1Cllf3v84fYIwjuWkTRM48MeJzgOMXdcSElnQxO6AtcSoAbZOSqsIeeCDEmlmvuaXxaECq7L1uHlS9jFK2Orp1caxF9iApu57AN7/a6wpbHFgwqLRZ5mc2csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293232; c=relaxed/simple;
	bh=RfLPpuK/xE7+cwBI1b9GZkSf4/NJpfjShFhEo3OgYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADEvQ8SfEkcKmjNcGiKUUDNvkR03LuKbXdfckfjZv0erdwmHbtYviZ12hjh+V1dXZMiijc4K/77rxguKb9R/O/NCEmLKsxXSnruogq7RHuWwr912JsIpjKU69SIj3H/v/gUSp2o+48gQuoAQNEsISGpV8kqGD6+Hjz+8r3w10r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcxnHLM2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcxnHLM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768293231; x=1799829231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RfLPpuK/xE7+cwBI1b9GZkSf4/NJpfjShFhEo3OgYHY=;
  b=BcxnHLM2ca3wwzlmoq7ktXW/OZ8uuz09HVIXKzmLO823LlIyict+5BZf
   11ZH+arN5jjg/DRa8EF5k10H9aTbagXRTeEe+CZrVjrV6YzkimL5B7Yp4
   uBlCRQ/C9fcW8Vs5sisnwjwclVA5wfI86RdUt3P5cOhZDesXYETNUwuOL
   i+XCTkXqxH+BTAHA+enXq8vzRuphXTPxUmvQyrVtGi0qGxazBDIcmQd7A
   RqJ12MDn83DeJFKLuLFcW9oPv2RwuaF513HtwwXn7UG3MSVbjE974uGrn
   35/Nrv6GjCgZVteLYnj4XWxbkMy/HtYaheBo22r+cmeZmlplG6ytEQ7MQ
   A==;
X-CSE-ConnectionGUID: Mel3aQxiQq+TaeVH49fhkg==
X-CSE-MsgGUID: IucZfwK7T2yZ0j1AuVny/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69626325"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69626325"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:33:43 -0800
X-CSE-ConnectionGUID: W9lBRYe6R0SBLa8X6E4qkw==
X-CSE-MsgGUID: /AZrUJsHQ9+3DfAOZclyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="209156424"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:33:39 -0800
Date: Tue, 13 Jan 2026 10:33:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
Message-ID: <aWYDYRVmad6k14fZ@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-2-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:27:35PM +0800, Feng Jiang wrote:
> To support performance benchmarking in KUnit tests, extract the
> generic C implementation of strlen() into a standalone function
> __generic_strlen(). This allows tests to compare architecture-optimized
> versions against the generic baseline without duplicating code.

...

> +size_t strlen(const char *s)
> +{
> +	return __generic_strlen(s);
> +}
>  EXPORT_SYMBOL(strlen);

There is no point anymore to have this as an exported function, right? So it can
be moved to string.h as static inline.

-- 
With Best Regards,
Andy Shevchenko


