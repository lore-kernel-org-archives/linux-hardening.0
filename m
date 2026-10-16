Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3330C359;
	Fri, 16 Oct 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123053; cv=none; b=sUXx2CRT+vkJJspjiLa7n56W3z0eWBXIZ5EEGv/NvUyp6PyMra40sy1xbGUUIcyp7RrnbgC9NXcZti9b8El332Hc0d6VIwz1xQ1Al7lzeI8eeM9KvSm8mc3v9MRPoLOuL6GE9EU/JOusQrVX23Uj5/qv9lORhQlKHrUZB4PCFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123053; c=relaxed/simple;
	bh=nr+2Ba/wperxrB0oPnvRIv6ziasoepMJ6kBz6i1UOM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZli7U4YIGwaCDBhc9NSutAlk1jY4hqdMUedrFsP3dRzCuMrMDyX/Ng1Hpr7Gx0PQhGzBM5Ah+3F4ETnmCxTETWSJqOQgD2JxWCFR/AUasq6Im+VpR5aSwaDbQ8/0OvEQpi+0ryzFG6wS10wsTdQAt1ZgsPD4/fkcqVdRV8wTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n1mO5ZXH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n1mO5ZXH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580FB14BF;
	Thu, 15 Oct 2026 20:57:26 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7E303F673;
	Thu, 15 Oct 2026 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792123049; bh=nr+2Ba/wperxrB0oPnvRIv6ziasoepMJ6kBz6i1UOM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1mO5ZXHj64DVV9mh+/Muwc2p+1XILKpQ0uALrqw2Llxill/F821gw8aaTJHv7L4E
	 8r4DppLWdfkcJte2yYja7cjjsnWb1RPEdrbEidDg7uTR+ZDzUr3fxIrfyBqR1mC9Ru
	 pLRex3uB4/qqK8+GZz138MbPz6Cp+kuicURpklks=
Date: Fri, 16 Oct 2026 09:27:26 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Iurii Trukhin <yuri@trukhin.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit
 and 52-bit VA
Message-ID: <4udh7nwi3is7xb4jhgsznyrm6w7i4hk5oeteqzzpswapi76ppk@65y3efxvo2bb>
References: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>
 <atEAtHiHh0eeVPn3@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEAtHiHh0eeVPn3@arm.com>

On Thu, Oct 15, 2026 at 05:35:00PM +0100, Catalin Marinas wrote:
> On Wed, Oct 14, 2026 at 10:23:35PM -0700, Iurii Trukhin wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cab741a695f5..7bca47269dd5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -313,6 +313,14 @@ config ARCH_MMAP_RND_BITS_MAX
> >  	default 16 if ARM64_16K_PAGES
> >  	default 18
> > 
> > +# default to 1 TiB (5 bits below ARCH_MMAP_RND_BITS_MAX) on 48-bit and
> > +# 52-bit VA; smaller VA sizes fall back to ARCH_MMAP_RND_BITS_MIN in
> > +# arch/Kconfig
> > +config ARCH_MMAP_RND_BITS
> > +	default 24 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
> > +	default 26 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
> > +	default 28 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
> 
> This looks fine but I was wondering what ARCH_MMAP_RND_BITS_DEFAULT (and
> the compat equivalent) is for. It turns out that an int always evaluates
> to 'n', so not taken into account. It might be worth removing them
> altogether as a separate patch. No-one seems to be using them.

I had the same observation looking into v7.3-rc7 but seems like that option
is already being removed via the following patch, already in next-20261015.

commit 8cdae75cebe06b8abea9cd3402442d47cf50b485
Author: Julian Braha <julianbraha@gmail.com>
Date:   Mon Aug 31 00:00:16 2026 +0100

    arch/Kconfig: fix dead conditions by removing dead options

    These two 'int' options:

    ARCH_MMAP_RND_BITS_DEFAULT
    ARCH_MMAP_RND_COMPAT_BITS_DEFAULT

[---snip---]

https://lore.kernel.org/all/20260830230016.2730093-1-julianbraha@gmail.com/

> 
> -- 
> Catalin
