Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62238E5C5;
	Wed, 25 Feb 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011954; cv=none; b=nFe0gO6Re9H0FtI5ck5HAOkx6eC/cUMbmdDw+mM9KQOjeFSjKanXtF6kDKeWwz55jwcpLNQOOSEJemYKkyF4NenMdFLkvqnKWaZE3zmUZCSDJgcVBaZxxyygefJXqYRVuTswj65R3fa1KjejR1a8lbfC5dPkzeAUjFMlbBo87+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011954; c=relaxed/simple;
	bh=HVUwgqRM/eO1JAZ2oCPN+pOSpky+jR+BDC2Uzx0lbX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD+WNjg/F4SUNXRJxWgehKP2AtN9FZSI7mPh52eOiT3zTn9Rl0AMyO+RFa/r7gyNI70/Axg5TepLtmFzJMvBiMSD35Fi8hfTCB5kNYvcSoWDeBj2ljkGXI9xlsXxguII1doHS311QYB5fbILXTFkW6Wp9463rc/x+9dwgVMD1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkkohYoW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkkohYoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772011952; x=1803547952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVUwgqRM/eO1JAZ2oCPN+pOSpky+jR+BDC2Uzx0lbX4=;
  b=MkkohYoWJZ1g+Qx1vKA3gUdo2FAapW5OrXJv6SG0Rv/EpC50a/5Im6qu
   OGz3S1Td+TTLacXUyIu3nBfsoN2jCvSC6dbJs3wug8u4UbzSzVcr0oPEz
   LYROOx4KaAzwlXRi5LiKGVR4FehC8YJm6RWoLwzLCgj3rphJ0A8Z4FFj0
   9J2hoT8h91canndTEfz84Kyb2W9fKmDlCT4XXtvtmUmzo0A7NsfcXC4qW
   0lIV4oNjkGS1l+tDaO5ye5tZ3LHqrMi7m/TP1lATlq5IhBLXkZOUZE1RG
   jB+QJA3LqVMhutA006awyd2EIMhw2h2+OkNkRr/GvNbn0gq0Ewu+4+mO2
   w==;
X-CSE-ConnectionGUID: JOcx7XJXTG2VsjniL0HVBw==
X-CSE-MsgGUID: QwxZY8lDQxS54KbOyogCyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72951835"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72951835"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:32:32 -0800
X-CSE-ConnectionGUID: kmUaOzYWTJyu3CXH+qaK1w==
X-CSE-MsgGUID: gkwLkIDMQi6fmTVF+rjoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239184874"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:32:30 -0800
Date: Wed, 25 Feb 2026 11:32:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fuad Tabba <tabba@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
Message-ID: <aZ7BrBJqg3kUGZgh@smile.fi.intel.com>
References: <20260224170427.2296592-1-tabba@google.com>
 <202602241302.75B565883@keescook>
 <CA+EHjTzCFAecmjkX5iYJ99GqCsJhT6T5ONCSFMDh=khNG6MzTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzCFAecmjkX5iYJ99GqCsJhT6T5ONCSFMDh=khNG6MzTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 08:08:34AM +0000, Fuad Tabba wrote:
> On Tue, 24 Feb 2026 at 21:07, Kees Cook <kees@kernel.org> wrote:
> > On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> > > sized_strscpy() performs word-at-a-time writes to the destination
> > > buffer. If the destination buffer is not aligned to unsigned long,
> > > direct assignment causes UBSAN misaligned-access errors.
> >
> > Is this via CONFIG_UBSAN_ALIGNMENT=y ? Note this in the Kconfig:
> >
> >           Enabling this option on architectures that support unaligned
> >           accesses may produce a lot of false positives.
> >
> > which architecture are you checking this on?
> 
> This is with CONFIG_UBSAN_ALIGNMENT=y on arm64. Although the
> architecture supports unaligned accesses, I was running the UBSAN
> checks (including the alignment ones) the other day while debugging an
> unrelated issue. That said, the alignment checks ensure C standard
> compliance and prevent the compiler from optimizing unaligned UB casts
> into alignment-strict instructions (like ldp/stp or vector
> instructions on arm64, which cause hardware faults).
> 
> > > Use put_unaligned() to safely write the words to the destination.
> >
> > Also, I thought the word-at-a-time work in sized_strscpy() was
> > specifically to take advantage of aligned word writes? This doesn't seem
> > like the right solution, and I think we're already disabling the
> > unaligned access by using "max=0" in the earlier checks.
> 
> The max=0 check is heavily guarded. Both x86 and arm64 select
> CONFIG_DCACHE_WORD_ACCESS, bypassing it:
> 
> #ifndef CONFIG_DCACHE_WORD_ACCESS
> // ... alignment checks that set max = 0 ...
> #endif
> 
> I also noticed that the read path already expects and handles
> unaligned addresses. If you look at load_unaligned_zeropad() (called
> above the write), it explicitly loads an unaligned word and handles
> potential page-crossing faults. The write path lacked the equivalent
> put_unaligned() wrapper, leaving it exposed to UB.

Probably it needs to be reworked differently to provide write_at_a_time()
helper?

> I checked the disassembly on both x86 and aarch64: put_unaligned()
> (via __builtin_memcpy) compiles to the same instructions (mov and
> str), preserving the optimization while making the code UBSAN-clean.

You need to check this on _all_ supported architectures with all possible
related configuration option combinations.

> > I think the bug may be that you got CONFIG_UBSAN_ALIGNMENT enabled for
> > an arch that doesn't suffer from unaligned access problems. :) We should
> > fix the Kconfig!
> 
> Does that reasoning make sense for keeping the fix here rather than in
> the Kconfig?

-- 
With Best Regards,
Andy Shevchenko


