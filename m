Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCE32ED21;
	Mon, 24 Nov 2025 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021002; cv=none; b=OQjb3V/UbijLUIoH44piutld0KYk4BQmskdBDiIMiAgW6hHrr8J8TM97XLq2gFCFojj9kBYdSJ2FtVZiby4DKLsWtMk+bGTVIuH6q2VevrLEVjxMC7nSevSGrzquEI9xV6bhBePqeMrri/gT2LaSVevdtsex9JIM/BKl06a0nJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021002; c=relaxed/simple;
	bh=RXREYcS3eD9QLzWOuycj1YtfjQVIS/r94kQe1cH/yZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNXyaBHuvrRHVy7gNrDspO+BSsyypUYZaC6aUzftKKGOwpMEvQFvy5tJCu47/w4DT0+Ke7zhVYf2zN4kJXSWwKtynKvv8p7n2xNDu+spD1BIvScUBfCftpDLr+Z/XYKpF7SRBReDSH/RnlS/uPesdC/DZJlb0lXCzrFSAvXO+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg3mWYHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg3mWYHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1119C4CEF1;
	Mon, 24 Nov 2025 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021000;
	bh=RXREYcS3eD9QLzWOuycj1YtfjQVIS/r94kQe1cH/yZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg3mWYHUHm+9sQe0h0IVVvf46zbWO/OKPf1vaPwDN2Re0d81XGYko10tNsXGhBJr3
	 4gZWIMWKu+2AhwVzSsVRrl8PKBSmz5mCqQR6dvytAXHUzKJuZy8Tb2R7b91w+015H0
	 LdwPoXWiJgl/t4YPGdLx2cBcb2FplZ/rM5i1yq/S3cF5cbqW63qKXbaNxxLKpMd7s5
	 cAsfJkUm4oR1MRGYCOsyip4ZPMP96+6VEJoV8rDWJhcnR5akI1ol/v9o/THTGoBHqj
	 QjAxOZg0kJW2wJClUpjBtMm9oqVSwupJO1crsUY4BBZlSNl5W0Fac1tkIfu1CIc/BU
	 fgbiBfdDHsAgA==
Date: Mon, 24 Nov 2025 13:50:00 -0800
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
Message-ID: <202511241347.AF6790AFB@keescook>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <aSTKLsRNiEKtDqPI@casper.infradead.org>
 <202511241317.516BDE7B@keescook>
 <aSTRsIUPeT5EC5An@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSTRsIUPeT5EC5An@casper.infradead.org>

On Mon, Nov 24, 2025 at 09:44:16PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 24, 2025 at 01:20:21PM -0800, Kees Cook wrote:
> > Yes, -Wconversion (W=3) is mind-blowingly noisy, unfortunately.
> 
> This third one is interesting.
> 
> include/linux/jump_label.h:126:44: error: conversion to ‘long unsigned int’ from ‘s32’ {aka ‘int’} may change the sign of the result [-Werror=sign-conversion]
>   126 |         return (unsigned long)&entry->code + entry->code;
> 
> static inline unsigned long jump_entry_code(const struct jump_entry *entry)
> {
>         return (unsigned long)&entry->code + entry->code;
> }
> 
> The warning is ... not the best phrased, but in terms of divining the
> programmer's intent, I genuinely don't know if this code is supposed
> to zero-extend or sign-extend the s32 to unsigned long.  I know what it
> *does*, but I don't know if it was *supposed to do that*.

This is my core frustration with C: we have SO many things where we have
ambiguous intent. Yes, C may do exactly 1 thing with a given construct,
but it isn't clear that the author's intent matches what actually
happens.

> So I wuold be
> in favour of enabling this warning ... if we have a small army of people
> on tap to get the kernel to build.  There's 374 lines of errors to fix
> from the header files included by scripts/mod/devicetable-offsets.s alone.

I'm for it, but that is a LONG road. I have so many other hills to die
on first. ;)

-- 
Kees Cook
