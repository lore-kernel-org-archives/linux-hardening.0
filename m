Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0963451C1
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445881; cv=none; b=ACsEYnApp34gIYn7AUs+i0UQNUGr4p1R3jgNqhjMDF/sM+JcQHtUUB4MU2FL5JlE+nYqFrrWaZlDw7kUJUrtZp4/PyWO6j5dq+gB8AGTyTx0hMIpo0kZdKkBC4vd7YlkA6Qo31DF0eoI+9hfIWOSp9XFw88TFhtKa9n9+PtRDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445881; c=relaxed/simple;
	bh=FRAaqRGx7aNP3Yq7q6OpyeBomYQxL/v5lJkG+SpccIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSa5XVo5wQmgmxk+CMTju/Gu/aDMeoJl3HelM9wik8xC+/OLr8wPs1SoUhGwK4h0be62yi4N863sPoaCbeg5u7mSp4AyGAA9/jWOjDLQ/zfjQehKYicmZNlE0Nt4B/zXcYt10MVZ1sSe2hiFK1jSt8sU9CnmuPUTwi2wWg164Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWzl0rub; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWzl0rub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769445878; x=1800981878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRAaqRGx7aNP3Yq7q6OpyeBomYQxL/v5lJkG+SpccIg=;
  b=DWzl0rubM73/MUd35x1PfzrrX+sNf+mGqkzGxx2ANUaw27yYe36LsFp8
   dQhuzPC555A6FrZeqplCOmTNo1Ecji47MSY1V8MefNEe4qspCtXSAIKYh
   8tk7eHnZLQBQ0gerMIu/ioJsR/LCJtHnjTicVTsPOdoITAknWUPwZYGCW
   G3+3MBKYcIeGWfDb6Ej+HKFTgE9AqWB81tK3C4faJAxxJpYdI4TTnR+VA
   XaVNdYoAjcsWFUsIs9fv3ZetjeyjDvblGoODmUScLu2SMC9ggyOn/dBbv
   aPiTxsIfIauDzFPNrjpy9WYkQic2/1k1dr/A5ExHrmZaY787f/pOE/rJx
   A==;
X-CSE-ConnectionGUID: Sr6i9hEbQ0aWZS4IQNCLjQ==
X-CSE-MsgGUID: YrHh+5ZZQSedEfy3zzGr3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="69824193"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="69824193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:44:37 -0800
X-CSE-ConnectionGUID: T119CrgrRc2iVH35SUiMYQ==
X-CSE-MsgGUID: 4VhPv8aHSOqxFuLcydFmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212707747"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:44:35 -0800
Date: Mon, 26 Jan 2026 18:44:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/3] lib and lib/cmdline enhancements
Message-ID: <aXeZ8Wx3YGBe666p@smile.fi.intel.com>
References: <20260126162059.357467-1-dmantipov@yandex.ru>
 <aXeZo2PJlXEuPjIZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeZo2PJlXEuPjIZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 06:43:19PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 07:20:56PM +0300, Dmitry Antipov wrote:
> > Adjust '_parse_integer_limit()' to not ignore overflows, add KUnit-based
> > test for 'memparse()' and fix kernel-doc glitches found in lib/cmdline.c.
> 
> Shouldn't we also add test cases to lib/test-kstrtox.c?

Actually I think some of what you added for memparse(), should be moved to
test-kstrtox.c as they test the beneath implementation rather than memparse()
added code.

-- 
With Best Regards,
Andy Shevchenko


