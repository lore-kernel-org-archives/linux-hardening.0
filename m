Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167B2877FE
	for <linux-hardening@vger.kernel.org>; Tue,  3 Feb 2026 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161652; cv=none; b=jsreicFw7Pgl/Dv5GcYhSJRjcPQsKNRORpiB2PgliqYQ51B9HIMrtBaqgC86Kdt9QnJkabwYKQL0jmU0Y0wO0oZawddqORAYxzQkUdb1jQ4GbQZU0+rKYHFGmDb9XEGNXytBhNOKa4AwCM0XRwnTcDwAj1cpmXzy3HWJ+3asmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161652; c=relaxed/simple;
	bh=rK7uWQmhECcp1K6HCbCsXpGtsQY4rr9eI6bQD0MQMKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk1NKIcchAmufCKITGzbgSTK/t53Wx+FhbZ1NJKOHeqF03S5mLvMHb8qivMqkgWXwZwdY/+BgQhDLSYnPg4gthUfdqF9ZLKe9JZ8zAg+W/6qqtx9UFSbjaoRvYgYxJ3h9w9S0ZoylhtOe4BjVYI7KiNestUjzrXv5NpiRGvP5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWdBpRmJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWdBpRmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770161651; x=1801697651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rK7uWQmhECcp1K6HCbCsXpGtsQY4rr9eI6bQD0MQMKI=;
  b=YWdBpRmJwBTW2BjkAwanUXGpWwMUoJh1iUNrpjAkRc9qFSKGQ42Sc61y
   6RVJ+EmfWFC/tNOizwKcIfCwe6gv0oHQZHUST6KznxhUGShcQjh0vjAgE
   +SMFrcX0i7YajLSPv3AKv102+0CnrQ3ZYiPAWql1s16JENc5ncP6np6oN
   IzxM/xCsBC5OxmGO2TKnlVwPniBbU6q/1yxBW1fTRjlnMsjVWeUPAniwQ
   0tzkiojz1uAshHDexD6zXb4UWlNcgmnavmfq3xo9en2B0mi928HlJBPag
   HMIgjzFywfYKvqODUvxeZjJ1a+hwWKetZ1I7pL032/dvwcYZPeGJ8ByfQ
   Q==;
X-CSE-ConnectionGUID: V+FkNzXiQbqUSNCyBcl5TA==
X-CSE-MsgGUID: tDLEjHAwSXWvks93lczimg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75196788"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="75196788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:34:11 -0800
X-CSE-ConnectionGUID: UF7SQYA/SUWe20cB2UFeHw==
X-CSE-MsgGUID: 79psHvdrS6GjEC7ccLBqnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209650112"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:34:09 -0800
Date: Wed, 4 Feb 2026 01:34:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/4] lib: add more string to 64-bit integer conversion
 overflow tests
Message-ID: <aYKF7of-i6H0wEuK@smile.fi.intel.com>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
 <20260202115451.290173-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202115451.290173-3-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 02:54:49PM +0300, Dmitry Antipov wrote:
> Add a few more string to 64-bit integer conversion tests to
> check whether 'kstrtoull()', 'kstrtoll()', 'kstrtou64()' and
> 'kstrtos64()' can handle overflows reported by
> '_parse_integer_limit()'.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


