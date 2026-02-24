Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE83217733;
	Tue, 24 Feb 2026 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953713; cv=none; b=lMrjpuEWwL1bBq9izVbA40lQnsVep1+tSHdF2lP4lzxNgplwa3iG+QkrwxtoH0OJsaJwWgcKxGbipjZph6lFG/Yk8IaV7gAdrG6PDMjl85bxCxh2NZfPa0lF1x7mXF/Ui0inJTuLe3+U+2HsO0Qr4NxvrmPet5VdPaQPVPHjGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953713; c=relaxed/simple;
	bh=YF9fco3oo89bvvudl1slsgHlw84HK8gWjvH1WgsYTWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZImiMVN9eO4P+gPQMpvZGy2pJhVuDgvxOlWCRnkIjqu0IivkGutDE/I8Iz2oAH+eqju8RuIBiPDs4TKnF9T1MDVz9AtMCPkxR2eYRmEhDvtANyFjniYuGRbnP+nyqEamSbzUJKdRczQlckAbtuEksS0bCP9ohgMGak5hL5p/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHPvdpGK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHPvdpGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771953713; x=1803489713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YF9fco3oo89bvvudl1slsgHlw84HK8gWjvH1WgsYTWY=;
  b=NHPvdpGKvrQH1JvZkmVttLsInvvpF7x0/9JdvmgDH6bFWo/bUWv4iBGz
   OT8Xs554jCXp/KtI7qOH6BM7PORDQoqhhnNBHvluo8VfmeEW+MmZWHpO/
   ZgZ4ImYuSH8vZ3hR0RcscDxZFZ3/LLrGKaTaXpiksRAxKAMaA8YJBvrKL
   DUGb7XUvlK63i9t4WFnUdZwAYCsSxZKpjBlDOG/E9iDOQzefBq9F2f8o+
   1p6wybxGCY9flhBCXEkEIRM1SplmAaa3WhXOAFZXc540TyK0HDFsSG6/c
   cLrMBW0t1bHobR2PJKU/xUY3rQDyq+ZYgoUzSUqACq5nvj9UcLqGJIBud
   Q==;
X-CSE-ConnectionGUID: 4efrIGn7SBi8t1OvqDAErQ==
X-CSE-MsgGUID: DDTOd6YFQOW8vGoM4boCTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90395315"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="90395315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:21:52 -0800
X-CSE-ConnectionGUID: xHu1Z72QRPi8f8Jdtmee/Q==
X-CSE-MsgGUID: yep161rfTe2l77RoHGlPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="253719835"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:21:50 -0800
Date: Tue, 24 Feb 2026 19:21:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fuad Tabba <tabba@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
Message-ID: <aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
References: <20260224170427.2296592-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224170427.2296592-1-tabba@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> sized_strscpy() performs word-at-a-time writes to the destination
> buffer. If the destination buffer is not aligned to unsigned long,
> direct assignment causes UBSAN misaligned-access errors.
> 
> Use put_unaligned() to safely write the words to the destination.

Have you measured the performance impact?
Have you read the comment near to

        if (IS_ENABLED(CONFIG_KMSAN))

?

-- 
With Best Regards,
Andy Shevchenko


