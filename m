Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6567336EE3;
	Tue, 10 Feb 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709999; cv=none; b=VfIwiqCQeu4O0vtTS/gQgE+oEDmGJQWuZS83f7HWCpPwmP7I2MPXvQ9UyR/YwqfJr2/SjrGWrST9p6F6+UyTyt+W/ztnYdvTNdn5R54zFDBUoH3cfn8k6DU7olFyCYQ8Kbo5JtcBBIOrqT6MQwpFijRJ42lV+T+iFkjUMzWh/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709999; c=relaxed/simple;
	bh=BTMNyZxhssFOeOmOSXM19R61SAT2DZVAcwMhp1xTxCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIbc1CgG9YgmDtAHs/Ca4eh1uYjDmwKnw/J+BhK9/lWvHusbO3+RbLZCeBKrzVcyJjUq1dFzOahVsVzIMqLljuXRE6PX6cvT/swtviWmjUgp5JdQEn8gYmrm3cv5U/LNyuQW1k9UDc6QYaw33jaX/RqJWGW3sW9i2yWZgZqUW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQ+0l/Gn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQ+0l/Gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770709998; x=1802245998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BTMNyZxhssFOeOmOSXM19R61SAT2DZVAcwMhp1xTxCc=;
  b=GQ+0l/GnZ1O5J55zGwkq+vvoa86ZxZjMhnJqMO2OpVD9OUpqVagauixT
   niRlBHp4WHrVmyKAAbXNLzNP/Qtw9gJ1JfZ8TwYFaa1mzvPTvMEf1fSyA
   Yx+qIrPxI9zFxpyWvki3d3opzJHrvxHvvpJRffjea8vqlVNmNc/gE+bX5
   wC9dBbkfxfQE6N1L9AAhEWcRxQJJG6jMrsUUCI+i1fY8We3rv5zDyWiGu
   rX0s7Jj4OzpeSjzUKCaNowsOwnm4lphspeZuBZOqEzb3wOXR/bXMLszuX
   TRYFXTxdt19fNG8dwLjezJ5PVP2q4KoYusz2YpAmePQqmx+lOupK9/lif
   g==;
X-CSE-ConnectionGUID: c7OqKyenQkmch1WEBQ3r5w==
X-CSE-MsgGUID: Az0/sZtJRjiNvKLF66yTLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74435487"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="74435487"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:53:18 -0800
X-CSE-ConnectionGUID: VLipOaEsTFOQBRHjGZx7zQ==
X-CSE-MsgGUID: zT2rD4CeSs2xjXf00zaxtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211680171"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:53:16 -0800
Date: Tue, 10 Feb 2026 09:53:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] lib and lib/cmdline enhancements
Message-ID: <aYrj6iPBFCEOIyix@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209164757.433932-1-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 07:47:52PM +0300, Dmitry Antipov wrote:
> Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
> overflows, extend string to 64-bit integer conversion tests, add
> KUnit-based test for 'memparse()' and fix kernel-doc glitches
> found in lib/cmdline.c.

Thanks for the update!

I have some minor comments per patch 1, and one main Q in patch 2 about ABI.

-- 
With Best Regards,
Andy Shevchenko


