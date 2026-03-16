Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81763A2577;
	Mon, 16 Mar 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678621; cv=none; b=daaytDGWsWvW+aRBULuRD+6kcuBlDC5OkCgk5Cnl0FZ79PUYx7q6Bh7YcC6RyNH0JzlAEnkoc1x0wZkllxGGn9tCP5RIEQJMWyPpQ1qQ+2ldcjp292/NZ1rHCXpNxwLcBmECACcYNRsCZGREb9gA38zk2jeZMBq29M8ZkeuSzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678621; c=relaxed/simple;
	bh=jPXJSvPYfSKMPdWwH5mDzXGaceYsztnVvebKopSPCLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq5Nx3EScX+pBeECya+bkqJiCCjI7YkCa2XX+MFnDIbAbuMdbozA8Vm97HqQv6hpvw8lQ7rtDF3o9zDiICc725tK9alJtRjDR1lK8AMLpqTiGx4NIwUJRtBnZlqqwKHZQ4KPW8PkiJhZWGir69ZKw+3ev4I36wWP0gF5sbcdHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwW5dsbw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwW5dsbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773678620; x=1805214620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jPXJSvPYfSKMPdWwH5mDzXGaceYsztnVvebKopSPCLg=;
  b=YwW5dsbwG7rG/cIuJnRIQDs3eyQg9SBlJs65NDRa2NpnxR9fmNAiQ/sm
   Y5vKhgC6617MI3lkhcwZ88DqhKUXgEnTJeMEJ8I0Si1Y809aDJ/DNvvkv
   OdKC5M6B4bPUqMh8XpFDcsMHFtSPdaQnK1lBoPaeaXq7T0ajQ/VM9DSEt
   DK8IHU22lyzEsoefMq8HEMeEd9SYiCSC6+R2qoQrAMmD3t2Q/hEgms9a8
   fS6FnLUZtt4O7Ny4jy7hIix+c+nbNfJutcqf5GX2wEbBCHV8jncaQfo31
   EZ7pC7fDAwnpHM7Z9QdyydDaHJfW2x/kh4p6BRyaAlPyAP3Uux6xcb5iB
   g==;
X-CSE-ConnectionGUID: A7HenRkCTge3FwQdpTxozA==
X-CSE-MsgGUID: LlXRUd6+Q2Wz6WA1Z7JMiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74404937"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74404937"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:30:20 -0700
X-CSE-ConnectionGUID: BtPomCc1RISpHVufHuWVRQ==
X-CSE-MsgGUID: j9GzLZ3TQeqawjcty9j+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259865752"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:30:18 -0700
Date: Mon, 16 Mar 2026 18:30:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Josh Law <objecting@objecting.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
Message-ID: <abgwF-yT_FtLTgQ3@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316161728.84485-1-objecting@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 04:17:28PM +0000, Josh Law wrote:
> BUG_ON() in a library function is too harsh -- it panics the kernel
> when a caller passes a dest string whose length already meets or
> exceeds count. This is a caller bug, not a reason to bring down the
> entire system.
> 
> Replace with WARN_ON_ONCE() and a safe early return. The return value
> of count signals truncation to the caller, consistent with strlcat
> semantics (return >= count means the output was truncated).
> 
> This follows the guidance in include/asm-generic/bug.h which
> explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
> there's really no way out."

First of all, this doesn't really change much, especially if one uses
panic_on_oops.

Second, the entire function is kinda deprecated, it's better just to drop it.

$ git grep -lw strlcat | wc -l
142

(In reality it's less as tools and implementation are not users of it)

Third, if the caller is that problematic this may lead to the serious
(security) issues.

Based on that, NAK.

-- 
With Best Regards,
Andy Shevchenko


