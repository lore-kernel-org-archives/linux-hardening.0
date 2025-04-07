Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4C1F868F;
	Mon,  7 Apr 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036761; cv=none; b=DFUTa6jRPbGVqVKCbCtmyKrPEM4dZTFO8LUgjUGbwFxbrVB7g71DuiWFIvLXc+o2IL0vyFtqAZqiYRFoNc85HdAgDT66s1KpIcP9l+VDCIn50MhsBtugcrcsYqFMf3PhJxacZ5C8r4j3eNylVjviyMxp5TfG8sn2VXiT4IpY6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036761; c=relaxed/simple;
	bh=GquslFdgsQsLxWzetJBMJ9BKmQLpDKrFvBuIQ7DSt/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAbOE99Z1PyXzzBJ/xGW9bPZcm52Dgp6gO3xi2s+IfCHDbV9fYCkxh8P6PlHfW+QMtmNDagGjVyWqOM/ifqEZt/LWifqD2nJZj6sZlv7+k+tLnv4/S+xPkAXjgGDZkoaY4H2AOr/i38+QFlvSJeJkqFBRItRk+SvrEtnOIXbZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: RV+2rmrSSjWSn1Ja/+0wbw==
X-CSE-MsgGUID: BBS/yyV9SsSpiaIDTEtTCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="67900530"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="67900530"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:39:19 -0700
X-CSE-ConnectionGUID: 9lEW051sQ/qbMwwB62YX/A==
X-CSE-MsgGUID: Jz530ykrQtupD9RiAf/qcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128504855"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:39:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1nd4-0000000A67q-1O48;
	Mon, 07 Apr 2025 17:39:14 +0300
Date: Mon, 7 Apr 2025 17:39:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
Message-ID: <Z_PjksaIc0B2AQhs@smile.fi.intel.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
 <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
 <0e603b02-b272-4bcc-8b86-1a3dca9477d7@icloud.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e603b02-b272-4bcc-8b86-1a3dca9477d7@icloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 10:33:34PM +0800, Zijun Hu wrote:
> On 2025/4/7 21:51, Andy Shevchenko wrote:
> > First of all, this function is supposed to be run against constant string literals.
> 
> for strstarts(s, "prefix"), strlen("prefix") should *NOT* be compile
> time constant. it is a loop and unavoidable to have strlen("prefix")
> iterations.

What do you mean by that? Compiler uses __builtin_strlen() and it *IS*
a compile-time constant. Just check it.

> > Second, this commit message has zero proofs to tell if there is actual performance
> > downgrage even in the case when prefix is not a constant string literal.
> 
> for either constant string or non constant string. this patch
> eliminating a loop which have strlen()iterations. i feel it is obvious
> it can improve performance.

No, it's not.

-- 
With Best Regards,
Andy Shevchenko


