Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF52557C;
	Mon,  7 Apr 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033914; cv=none; b=KGQWLiyAzu1CkRyhsxFjYUZ/slQ/zvI0qHLvleu5tNkTAWVIVGiHUjefZRSK/tFLuNpvjcQY8Ao6NZr2TsH+5KtowWmJ7dKuD1AGAgsCoUVPnxpl9uOZVbO2jAA0oSGCRoTPj0KCRZbwLUd1yuWwHcdnLssZLdHYJwwaGm+L6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033914; c=relaxed/simple;
	bh=PPIQYAeBKUlvtxrAfxFt9yFob+lD2STyfVTRqOvrOPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGtkU+rCfk/PL9YMFZHRj12pao8T2xfi390rilMG22yrMjmBZ1ldRM0WCoXfn9QZlhWQ/mBYQSU8hfGYXn2GRnACv4kAsjzSsM6+7iOWdoPviLBW6ZpT1UxHsxy7La8D7m+kNZaC0gC5DqAeRclE2q/gK4y5k+2WvPN+mAXKTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ODk2lpyfRfmHKCx6c76unA==
X-CSE-MsgGUID: 7N9ksF+7Q/eFJSQwdKtZIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56788428"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56788428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:51:53 -0700
X-CSE-ConnectionGUID: k1uHHD5nR3OpkIGLjw7FBg==
X-CSE-MsgGUID: 8En2L+grQKGpRaxpsMaKlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="151152735"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:51:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1mtA-0000000A5MJ-0yv5;
	Mon, 07 Apr 2025 16:51:48 +0300
Date: Mon, 7 Apr 2025 16:51:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
Message-ID: <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 09:15:04PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> strstarts() is frequently invoked to test if a string has another string
> as prefix, but its performance is degraded by the strlen() loop contained.
> 
> Improve its performance by eliminating the strlen() loop.

NAK.

First of all, this function is supposed to be run against constant string literals.
Second, this commit message has zero proofs to tell if there is actual performance
downgrage even in the case when prefix is not a constant string literal.

-- 
With Best Regards,
Andy Shevchenko


