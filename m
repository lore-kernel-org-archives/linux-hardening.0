Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DD279DCA;
	Thu,  8 Jan 2026 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767857231; cv=none; b=I9TogjEkBgPLO7Mt5ieNAJmnVudGthNW7LdPorLfgl2MAlFNYduX51LwbWwDmg1LCCy3XBajNBA8y1QMyZlDxt1wGApJyb3SEDzVXlQpDmgHzgntNb4r2jt/gOnPYrFSCZpZWumbc4UjT25C0bxLTfbMoUx/YbQLibisKLQ+uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767857231; c=relaxed/simple;
	bh=ezvxUHWQBwSHLY7nprbyc8zfDEUzlsl6pwpslP0nMw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALaRG2RDuEjCKSkHcT8PPn174rmSC5BJrGhmjZgbJrXzM/PSet1RB6nEjJsifsyjZ5mnw5R4fE+zE6TM1BPCUOByPO7sQnVXw4jpMmkwmQy0tHIzeJf9Phea7KoVCe9/z1ImRwpTWBqDvOsuPwNE/lVLaUJvoHhO12ICw3JZzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPUCxfUA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPUCxfUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767857229; x=1799393229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ezvxUHWQBwSHLY7nprbyc8zfDEUzlsl6pwpslP0nMw8=;
  b=RPUCxfUANm4Jrz3ar0VZytZCXSuSkIDX2hSBzdETCqPJzalx9tBtxFUz
   83B8g3MCCwKKkiqD7nvbk8qVdyccay0JTEUd7CBnQdb1rvxZTPyefy228
   Spi2OlTpB2INt3Bx6Oj2YCXr1GTq5veHs6bZ4jgvdXLgam8OnwlPxWcAN
   mGT+fLpqLklvXhX+C8aV3zT9s8uzk5SDdO6I7wADVmiLVKwc08+AgwnF8
   HMffbLPuL3VqaxURMXe2d8flKDuJl+wGLNpsz46Uoe4WLEnroHn5ozmix
   gy/uVVo70REnyhnFeZC8DRQPGh/Hti+Ruf6AQWd15wWUpVWPqRcK50iLv
   Q==;
X-CSE-ConnectionGUID: T+0fL42xQEWe+noyvVrdwA==
X-CSE-MsgGUID: ZcWrnDsvRuyhyq2bl39iaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="72866335"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="72866335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:27:06 -0800
X-CSE-ConnectionGUID: TqqKpd65Q9GsbikxeX6Zhw==
X-CSE-MsgGUID: R6aR2w4qSyyuCRBBKN3grg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="208199114"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:27:01 -0800
Date: Thu, 8 Jan 2026 09:26:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, Jason@zx2c4.com,
	conor.dooley@microchip.com, samuel.holland@sifive.com,
	charlie@rivosinc.com, ajones@ventanamicro.com, nathan@kernel.org,
	linus.walleij@linaro.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/5] lib/string_kunit: add test case for strnlen
Message-ID: <aV9cQ2QMA-jwFNUO@smile.fi.intel.com>
References: <20260107023517.46840-1-jiangfeng@kylinos.cn>
 <20260107023517.46840-3-jiangfeng@kylinos.cn>
 <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
 <b419c6db-0f3f-4666-8f7c-156f7eda2b5b@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b419c6db-0f3f-4666-8f7c-156f7eda2b5b@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 02:53:58PM +0800, Feng Jiang wrote:
> On 2026/1/7 19:56, Andy Shevchenko wrote:
> > On Wed, Jan 7, 2026 at 4:35 AM Feng Jiang <jiangfeng@kylinos.cn> wrote:

...

> >> Add a KUnit test for strnlen() to verify correctness across
> >> different string lengths and memory alignments.
> > 
> > Same comment as per patch 1 (it would probably require to call for
> > arch_strnlen() or something like this).
> 
> Thanks, makes sense.
> 
> I'll add the performance benchmarking (random filling + timing) in V2.
> 
> Since string functions are typically exported directly by each architecture
> without an arch_ prefix, I'll introduce a generic_strnlen() (based on
> lib/string.c) within the test for comparison.

Probably you want to make the existing one to have that name and use it inside
the test and in the fallback wrapper. We don't want to have duplicate code, it
is bad from maintenance perspective.

-- 
With Best Regards,
Andy Shevchenko


