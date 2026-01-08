Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3B48C8C5;
	Thu,  8 Jan 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868965; cv=none; b=t74QYXa3q2HbtPX9Ch5PGxJaQT975+ZITqXK37HWi6iKJWSlbXtpaFnf5JfcRDrLspdWQNMEqaZxOtxQGfqBA8uT1A6sR92oZB9xQqGKebp16SEp2dmpmNkRTfUgFLo61C7MIZ5BgcmEAsLH4c+mrceIDTx4xUcYe5FlAzZjEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868965; c=relaxed/simple;
	bh=YE+fJOggtKeC8He6gvH0To9NXKv9XCHhGejA/xXHexk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYIgo4U4GeHVCc+o7PKz+JAvOnq2OFf5BEKskMp8sG8lI2YRqj8/LvEi6wN9Dr6rvGzZ3QrcF0C3BzyRlMcV7V2OOi+dJstaNGA017Xgs6JMyCa6Ma+dAujvhi2fjTyWEhR0pwqSA8d0dc41ROt6w7dZ773doUOOyJSlXmwU+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWbmbXx4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWbmbXx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767868959; x=1799404959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YE+fJOggtKeC8He6gvH0To9NXKv9XCHhGejA/xXHexk=;
  b=iWbmbXx4ato5zWbvsTtt6dcEYtl9r/ZFzCo6iqZyz2E46BtS69TQsaOJ
   y2mWPsirDc3xWMHlbW2/U9MgZhH2xP8UFf7LYKzIMh6Y2JL673IXdhYD9
   xA5Wy9DBuj47gERUFgMqEPKSdX9fy+DWCoZXYKzcTBGQB3hfsN51bIk5Z
   TiObEPCKO2cpEslwwR3aFpKtYaAchUObEY+mqY7O/jYhkRa5bWJkSCIjI
   13zX9o3q/tvPXP7GMFf1a7gb4jh5KxXHwOW8mVOs5RVsiHvs5jMNPsLWc
   VluMbjSM7s43x8CDbFGpt0/UlqJWQleiXXjK0FqRJMuJ6Aggs98zkI/Ia
   Q==;
X-CSE-ConnectionGUID: hQgjCduaR8avx9I+lb9fBg==
X-CSE-MsgGUID: bbysSs13QsSvL+ZwN8rsaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86833500"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="86833500"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:42:36 -0800
X-CSE-ConnectionGUID: 1p9UCShzRuixjZqE82rezw==
X-CSE-MsgGUID: WUX+b205Tyq/v9Xv/z1m2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233883284"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:42:31 -0800
Date: Thu, 8 Jan 2026 12:42:29 +0200
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
Message-ID: <aV-KFRDNicUdta3i@smile.fi.intel.com>
References: <20260107023517.46840-1-jiangfeng@kylinos.cn>
 <20260107023517.46840-3-jiangfeng@kylinos.cn>
 <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
 <b419c6db-0f3f-4666-8f7c-156f7eda2b5b@kylinos.cn>
 <aV9cQ2QMA-jwFNUO@smile.fi.intel.com>
 <e02320c8-eff2-44af-a66c-a3c7ca9ca0ea@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e02320c8-eff2-44af-a66c-a3c7ca9ca0ea@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 06:00:21PM +0800, Feng Jiang wrote:
> On 2026/1/8 15:26, Andy Shevchenko wrote:
> > On Thu, Jan 08, 2026 at 02:53:58PM +0800, Feng Jiang wrote:
> >> On 2026/1/7 19:56, Andy Shevchenko wrote:
> >>> On Wed, Jan 7, 2026 at 4:35 AM Feng Jiang <jiangfeng@kylinos.cn> wrote:

...

> >>>> Add a KUnit test for strnlen() to verify correctness across
> >>>> different string lengths and memory alignments.
> >>>
> >>> Same comment as per patch 1 (it would probably require to call for
> >>> arch_strnlen() or something like this).
> >>
> >> Thanks, makes sense.
> >>
> >> I'll add the performance benchmarking (random filling + timing) in V2.
> >>
> >> Since string functions are typically exported directly by each architecture
> >> without an arch_ prefix, I'll introduce a generic_strnlen() (based on
> >> lib/string.c) within the test for comparison.
> > 
> > Probably you want to make the existing one to have that name and use it inside
> > the test and in the fallback wrapper. We don't want to have duplicate code, it
> > is bad from maintenance perspective.
> 
> Thanks for the suggestions!
> 
> To avoid code duplication, I'll rename the generic implementation in lib/string.c
> to __generic_strnlen() and keep the original strnlen() as a wrapper. Then I'll use
> the generic one in the KUnit test for comparison.
> 
> Does this approach look good to you?

To me, yes. To others, we will know later on when you send a new version.

-- 
With Best Regards,
Andy Shevchenko


