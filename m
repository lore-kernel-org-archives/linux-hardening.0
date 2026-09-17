Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E114388878;
	Thu, 17 Sep 2026 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632293; cv=none; b=QXNo4NbQkui9PFPwXHnHX6F4690/Q2KzjfrmAOYWZ/9bbOPHoKd77vdd3B2DankAJfaaAT9cKkWZ6nLUqC8t02npa3Mo406u9Hn0Kty3/Qio1lPzqExkoLWsKrQg5dSd27oAweDCRv4PU5dS7+k5hhWsT6zXSZLC6V47PO5wi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632293; c=relaxed/simple;
	bh=ZakSworF3b8jW7lQweEFXuAAZdxo/4SEjVDDfFiOzLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN0EHDKhPElyT1+tgHaoMrbR/aTPo5WGq2ytaKNVoj50EokuyXZ81vi30h46hTjHpBdPg78NCQ2pUdzAeggv8jkZud2v9v3U0Dznl+L2UhCIXVnZ3GV/TRx08v/U9O6wKEGjwxxFiHlCP4QmEpDIfKzpkWP2TKSbMrvH5wLQoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f20dqGsC; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f20dqGsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789632290; x=1821168290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZakSworF3b8jW7lQweEFXuAAZdxo/4SEjVDDfFiOzLc=;
  b=f20dqGsCG3geNw0hGXu2MelaBx+0xdLIzdeF/Wq9RyQ01MOBOp9iGgXt
   ldXIqZYiI7l01y73ovUWwjgsW6Lwt1WovyFbP6YtMDayrUs+sIlT8RCjf
   ZwoOpQnC8oTEcaAEnALYoG2bumovWa6qAlTme8VVTxpofIOCL3ffwmPqS
   qLHXRkGzbigol0E0bDb6Li9vPEqlPk+niA5hbrnY+m1slVNaSXkr4+lz3
   MJfJzEwcyTBTeYYNZJN5OfH2h0BcQ9GQ1Cfx6awwAHo7yOE2todc9fqM+
   QUJSqiWY6nk4osQxC5xfRbrfpNlDPbIuCBPeqJCY19lPkdxFESNXS+Lw8
   A==;
X-CSE-ConnectionGUID: igU5dFA7TCOiqriJM0Emjw==
X-CSE-MsgGUID: jZ2lXq4ORRC64dswGsxJ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="536901"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="536901"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:04:48 -0700
X-CSE-ConnectionGUID: fUDMFHp6QwWcfURGQwGgLg==
X-CSE-MsgGUID: 8eiTUaR9STaFQt16ktJN7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269954554"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:04:46 -0700
Date: Thu, 17 Sep 2026 11:04:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 5/5] lib/string_helpers: fix counting of remaining bytes
 in string_unescape()
Message-ID: <aqufHDWKoR1gdg8U@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-5-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-string_unescape-v1-5-7f8bd986fa33@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:38:10PM +0200, Jonas Rebmann wrote:
> All of the available sequences expand to exactly one byte, the size
> check in the loop condition is sufficient for the case of an escaped
> character too.
> 
> Otherwise, an escape sequence that should be unescaped to the last
> character before terminating with null in the destination buffer will be
> output as backslash instead of the escaped character.
> 
> The only exception is when encountering a backslash that turns out to
> not start a valid escape sequence and both the backslash and the
> character following are handled in one iteration. Move the check there.
> 
> Add a kunit regression-test that unescapes a character to right in front
> of the null terminator of the destination buffer.

Without examples (and the respective hexdumps) it's hard to get.
I re-read the code and see no issues there. The size > 1 check is for the \\
and \0 at the end of the destination buffer.

So, if the sequence is not recognized it means that it's separate \\ in the
stream and has to be copied as is.

-- 
With Best Regards,
Andy Shevchenko


