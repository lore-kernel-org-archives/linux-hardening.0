Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFA155300;
	Mon,  7 Apr 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033789; cv=none; b=uwIsmFKwdKPd89ezeVFKiyOoGUrrXTV9yPAebQGlcuZYv3I753xokSvDXlz1xZ/omzGrv//LDrk5GG0K7LgOr4EBGCnvneF2lx05VfoMcwveB2VzHhW9A+VqHzlmcCHhvbFnYFhSOnBQB9j+2nPqP95nCZNSC5v5mmVo3GllfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033789; c=relaxed/simple;
	bh=Y62MtBKta0EINFNJ3r78BHlzMhPNgs3rUJDCKb+FgZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/ZEDlZ+RwhJyGCbr1fm2YB7bmPIN0m6G37ONQDStVLmcCugdN4bxwP5a++zy+IisNh5x8qvxN3amHACEvN7lIUTxm4uSeOJ1jLogvtsxDspB04J3E23RcvnUkGNSpuAtQQhqKwt+9VGux+BqULidVb931wPyzvHhCq6soUQ3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: wBn6C8UASKqwvH2vuAiR7A==
X-CSE-MsgGUID: 3nQHrfY/SLCFgx8srLbprQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49271461"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49271461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:49:48 -0700
X-CSE-ConnectionGUID: i2Ab6tdYRzChRGaW91xFCQ==
X-CSE-MsgGUID: WVMsX6NuTCOd/sYF4AdXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128490090"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:49:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1mr8-0000000A5KZ-3VrL;
	Mon, 07 Apr 2025 16:49:42 +0300
Date: Mon, 7 Apr 2025 16:49:42 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 0/2] lib/string: Improve performance for both strstarts()
 and str_has_prefix()
Message-ID: <Z_PX9j43i35gOMDf@smile.fi.intel.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 09:15:03PM +0800, Zijun Hu wrote:

No information?!
Please, add the performance tests (link to them?) and results here at bare
minimum.

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

-- 
With Best Regards,
Andy Shevchenko


