Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3150389E07;
	Thu, 17 Sep 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629525; cv=none; b=rXMrKHv0Dyy95F9VXl4fjaAxowoJuACKyavWR/H1r/pJS/DN69VJHMrj58aM5MOgSmV+W421ZTsctPrzE9YNmDGkkb3jK02gVgOncEtEGbVjF38p2bAsyKiEa6QsyinZLlgTGFhbedpHYXUkHXtFGjHxbq7Z/KZzv/n9IFa6jxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629525; c=relaxed/simple;
	bh=2Q4AvzzwNsliB0nEHtb8HTiNCAA4cpOjcTAT9ArCO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B99ryr88q6D4dts5QwwTyTmsHeu/W9FpmA1LdSENoBCGKyZ6InkRd5ezRA9eg/34teaTyJ6BQxeR4IbMTT/qDaxlZKjzPCK3y1JMbZuyfm2LS1PzRdOR5lLMjTdmVSQAl02fCAwQbOtVpDwgK7On17bepShafN37jVn0FD9mVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4xEzcUL; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4xEzcUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629523; x=1821165523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Q4AvzzwNsliB0nEHtb8HTiNCAA4cpOjcTAT9ArCO3g=;
  b=l4xEzcULrZd77OKoXWLLePTX9Np5VfHvAAo28BuY0HklVdhGEhxxYuoF
   svy2AqsfdOKGf13+o1rXJzWDq1f2YUoT/g680UJPZLHrLe8J1Xe2DGniz
   ZB5CqtWipsv3+Al/rYuxG7cc/JmRW0ua5so5GpVzHb8GvaKgUUBEa/hud
   +CozBvQLxzTltyA+lr+jpm/5D4MXJN+bJqjKpnOVpVjUrib1cdSsnQNJ7
   XDv3rlM0dQz3w737fTnrWYFFI7JaUWLt1iO8gVkSFtV6ivlH3/B3nyl88
   JorTEsVZCtOfOHKL6HRt9YtyXBp1kQ7nSvxoOTx/7PIh3l8vVA9VbukdC
   g==;
X-CSE-ConnectionGUID: hd5Tl3oZRdGDdtQgn8YWEQ==
X-CSE-MsgGUID: Q2L12+wTSNuXgxPR1C9aeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="529812"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="529812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:18:43 -0700
X-CSE-ConnectionGUID: olq41PMxQtW5WYC/cw6Ybw==
X-CSE-MsgGUID: H6jDLjHmR1SS/xCm/cBfPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267396588"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:18:41 -0700
Date: Thu, 17 Sep 2026 10:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 2/5] lib/tests: string_helpers: drop unused parameters
Message-ID: <aquUT9FgY_Ep_4E4@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-2-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-string_unescape-v1-2-7f8bd986fa33@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:38:07PM +0200, Jonas Rebmann wrote:
> Drop the unused parameters from test_string_check_buf() to improve
> readability.

We need to find a way how to use them in the error messages. This is a
regression in fb57550fcbd8 ("string: Convert helpers selftest to KUnit")
that drops them.

-- 
With Best Regards,
Andy Shevchenko


