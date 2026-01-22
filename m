Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0B3806DC
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095559; cv=none; b=RV5cwgEsGUkbLPVbEmJOAdZZ8BtnTULKn/lQaoQBjqTlpNTh4ApdjO6AMsiE3foX34M+uuzAs3lQVTltUL6wtfv6HvYTmyUquUCJg+BDOXsSBkcQrZZXQ2yJYzSY6uaC4KJYTt+SjiPEbm5Ube3aGp22C37Ock+fOYmHAFz4jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095559; c=relaxed/simple;
	bh=eKPwvPNY8vakivBPuHPReOdJJbXa+BqZwEtelFW7Mkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnvx+pXFqYs9WPW8BE3QeyXolpPqVhJzJRcEx0Su4D0MyukFufYSkQ34tcjl2EGjO0wDNxtimk9DJU1ryqGnXgXh6F81SxjoTEdnPxZf0X6t5VFVhseNDWjsjm2u3Gwg5zHdmkSGiCshwhFUHp2ho19D+5JUGJikD5giFxP72BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqhpuFWE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqhpuFWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769095557; x=1800631557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eKPwvPNY8vakivBPuHPReOdJJbXa+BqZwEtelFW7Mkw=;
  b=PqhpuFWEHOO8+NLvsXltWmn+QD7T5RlKxDEAGl5piaeSmK24SXly7ADU
   7S7d8R0tz4NGv3O2yJYnhXdoqAzHCeRHGIMi0F+qrxD6cBLi8FRgjiF4s
   hieuRTx2eIFLJEuyFm69jxdhbhyafnz6fAj3rb+BicO8pm7c37DWtay/D
   tNdonQ1MX2VvpHyifxa7Q5DbpoE/8RS+DM4IsM6idzV5VDXCvNb+wKXlp
   8Ac3uRyxOQmMPmhiR+Xa3EJDC8zaHdYcH8YP3b6yy/Mo+2gn2Cq0R5Eao
   tMjKCh3SgXpmiSQbqFEbgsDJC/iU6sjbi6RowD0Bw/5WbEene9woLaBRP
   Q==;
X-CSE-ConnectionGUID: sX46DCO2Qv2YX8h2Q5Gd5w==
X-CSE-MsgGUID: lcy3+mlgQGWnVH3ZdDMYtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70060923"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70060923"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:25:55 -0800
X-CSE-ConnectionGUID: slBKehvGS/6c3uydhKKmCw==
X-CSE-MsgGUID: 3BtykkvVQLSuoTBje36tCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206359083"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:25:53 -0800
Date: Thu, 22 Jan 2026 17:25:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/cmdline_kunit: add test case for memparse()
Message-ID: <aXJBf5mYUOFCli1P@smile.fi.intel.com>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
 <20260122111254.1111811-2-dmantipov@yandex.ru>
 <aXIOJEqV_ctVRrok@smile.fi.intel.com>
 <533de75be777940d591ea23a41d595c212667baa.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533de75be777940d591ea23a41d595c212667baa.camel@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 06:00:43PM +0300, Dmitry Antipov wrote:
> On Thu, 2026-01-22 at 13:46 +0200, Andy Shevchenko wrote:
> 
> > Can we also have one with more than 20 decimal digits?
> 
> Hmmm... running simple userspace test,
> 
> strtoull("569202370375329612767", ...)
> 
> returns ULLONG_MAX (and sets errno to -ERANGE), but
> 
> memparse("569202370375329612767", ...)
> 
> seems blindly overflows to -2646695909666487329.
> 
> I'm strongly suspecting that 'memparse()' should be carefully
> tweaked to use 'kstrtoull()' instead of 'simple_strtoull()'.

It will require an intermediate buffer which your series is exactly against,
right? It's better to actually create a safe wrapper on top of
simple_strtoull().

The points are the following:
If there is a decimal base, we need to count leading 0:s.
Then add a check for how many characters were actually processed.

Partially something similar is done here:
drivers/crypto/intel/qat/qat_common/qat_uclo.c:206

-- 
With Best Regards,
Andy Shevchenko


