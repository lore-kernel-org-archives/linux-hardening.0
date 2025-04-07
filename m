Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CEA18309C;
	Mon,  7 Apr 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033930; cv=none; b=IFcpxG+eWWYxM8mtcK+C3iAnsRu33bXDmz0EsXOqHPRNqr5rrxReH/3DkJ3wBL7K3EN0Gv1ZBwu2+QA42z9kCYhKYPINaHrRnUhGgq65uEt3V8hRDb7trNXY0QZ4JO0xkSBJWo6s1nxXe0rCu1V+FfCFbwsPDklU13u7sQRXcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033930; c=relaxed/simple;
	bh=JpeI9vriRtv2DjOqwHihDLl9tMT7YLcgOCKI9J1Omns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEJtbIZ5ibmDBryc+FN3NGEHUGCDXaTOlGBNKEfo658y/dpdppIimITBX0JdCVpXDjU0sPXHpcI68J9LfWthZOV97hRAyEjuPGBrXl85SpnLX7EogfhtaH04ssPqacywppjA7JqfOJF3qrXoQPzSl3AC1JGSkPGG0El7eFaiN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ReJRBB2MR5OXhXLA8x+a4Q==
X-CSE-MsgGUID: 1fc9QvgmSKiiXYyWrDPxKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56790791"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56790791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:52:07 -0700
X-CSE-ConnectionGUID: uoCY2xx5Q/GA4CpjPPFKGw==
X-CSE-MsgGUID: EIIXqd23R9+QGQ13AGBJEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="165163893"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:52:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1mtO-0000000A5MX-39rp;
	Mon, 07 Apr 2025 16:52:02 +0300
Date: Mon, 7 Apr 2025 16:52:02 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 2/2] lib/string: Improve str_has_prefix() performance
Message-ID: <Z_PYgrzKs6juRh8e@smile.fi.intel.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-2-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-imp_str_perf-v1-2-ed95d52964a4@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 09:15:05PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> str_has_prefix() is frequently invoked to return length of the prefix
> string if a string has another string as prefix, but its performance
> is degraded by the strlen() loop contained.
> 
> Improve its performance by eliminating the strlen() loop.

NAK.

-- 
With Best Regards,
Andy Shevchenko


