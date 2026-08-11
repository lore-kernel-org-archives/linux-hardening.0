Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAE3B058E;
	Tue, 11 Aug 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445608; cv=none; b=vFNFHLit9DLAUThRPN+VkYmzpj1//l/h39K66CRlyoU0fMONTjnL7ofQuS0nLwv+8swYYQVeR+9a1F+evR6/Nai1hoxWt6KRbME5piqyUhxF7aD6ZTh2Uda6prmg/bOLYX0yMSbuMz498ukWfhHIjk1ztxNk9Qb30pNlo+2NGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445608; c=relaxed/simple;
	bh=uor4YsfmKk0Ew9XFzwt0MAWAPyxWQJ8gWx6gYrWkL7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usac2XGgiVISxQBtrZ5Hh/T5L5Bv5U9mQkC7Cwb0KRMRc4iE3w3Dq/K8uoxNSycKdKn/Q5jNWJGKbQiTQBWWJ6s7TmTt3mL5AhN1E7G5xns2pkqsGiP+7KtrgccLJ93NjWNxmHVgK6Whdf6DqwkTWjqYCM84nH/MW8PSDc8yBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbEli28r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbEli28r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786445607; x=1817981607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uor4YsfmKk0Ew9XFzwt0MAWAPyxWQJ8gWx6gYrWkL7U=;
  b=cbEli28ryc8iP1/z0AS5+paU5Z0b2yIbMpYU3XmFpVpDOUAMCGg5r/9a
   xLzQqRfbwAGvQSgc/s/ORBTlQb6VEh2YnD2g+4T7cG9yQdVsXz1JXvQFD
   yzUAtZCUsbsaF77iRrMcD01J78BmipOBk5Pd9Pw2LLJzfQFiCPoTekhVo
   hP5t7HUy6liLEroH16X9qgJryLiM3RycHS6Ot2vC2UHWQ06OPKxo0cOkz
   cSbsBhiBGmjYRMe+rtG70J2vCpZitA9fTfcNcq5n4LoXf+3BK5LTZ1Rjy
   x7E4P+L7mCoPfWBoEOgOeHLpHKGA7DVVchRqTTdiFstNK+99goPTo23/2
   w==;
X-CSE-ConnectionGUID: BAx+XKz/QAC4Raxw9TeEkg==
X-CSE-MsgGUID: 1DjLd/xWTGuY8QTgV3U5Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98120734"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98120734"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:53:26 -0700
X-CSE-ConnectionGUID: VULC+6WPS9mUPN+kgvpt+A==
X-CSE-MsgGUID: bVvroFSmRMCJ8sMfvXavEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="268467459"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:53:24 -0700
Date: Tue, 11 Aug 2026 13:53:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] string: Introduce __free(kfree_const)
Message-ID: <anr_ItiTKL3pjJH-@ashevche-desk.local>
References: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
 <CAGXv+5EKtcEy29oy=8Qah=1=PXXMds3BvR08u7DQ656FB2u95Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EKtcEy29oy=8Qah=1=PXXMds3BvR08u7DQ656FB2u95Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 06:42:51PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 11, 2026 at 3:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> Matches what we already have for kfree(), so
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks!

I think you can incorporate this to (will be) your mini-series. But let's hear
from Kees and others if he is okay with the idea.

-- 
With Best Regards,
Andy Shevchenko


