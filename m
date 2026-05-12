Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208F368D4F
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574948; cv=none; b=p+N3tabW+bJ03i2B7N0Wk4kY+FNgL+eBvhCSAO6IUOYAcymMRVOKjnRVz+zBSpsQMQUn7MhFo6KBz9xa/0am47aprtuavFhkxnp1UkMUN9iyvJKMC1fTMb1xFeuymLEreSr0ebBiuDt6x/4rAf5h+jmkC7W4x7TIuglyCqCCrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574948; c=relaxed/simple;
	bh=JzBOcA3PKYwy9SeBJ70gVuseWZeF4yLuocxV42W8Axc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbpeu/G5YtaWbzLY3sbXMRoXppsk7AHFUngJnH5lLFF3unWE12dBqohG7k63Nb29HzhuOjev/Xgbrko4ArbMnvPH3ka1ejCrN4vtT30CaQ0wBiSPy5h2z4JmowXiYzUr6RoGZRiLo6i255TQMDWy9m8oXbvBVAGGqxB5m0OCehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lisxHuLR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lisxHuLR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fmYKEHuvW/cMiHRbqJzG2gPaH5Z4KmX0axF0WYUYsuA=; b=lisxHuLRpCR7JnkjWrsa5TlDJ3
	OguU7WgklNGkytquSR8XClaiREjx4fan3dW+YKsoYy9IdRXTiV2itF30xkkme0EQftY4mHIat+DiK
	dtSDMEEVGBycAkcIyoIRxT8eHz75vSsnsZJICVc2SM3R40/hDx3reDy57GMTmYZ8SB2HHXqsr3fES
	Z6D0NtrfxsGo3vfDASzOgSoLin9NATO30cQm4AZzZ63lJxHlCVnbK0VbLO95+oCU4lM6CSs9sCLvC
	9WWYNrqMzI2AT1G1VJ86N5WMf+EfeVRiS1khrRqxxxKiSyFpyIl+pK0loCYW9y6vv0YTQNt2gDiU9
	GYj5wyhg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMiaM-0000000E77y-3IXa;
	Tue, 12 May 2026 08:35:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BD21300882; Tue, 12 May 2026 10:35:25 +0200 (CEST)
Date: Tue, 12 May 2026 10:35:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Uros Bizjak <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v11 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <20260512083525.GV3126523@noisy.programming.kicks-ass.net>
References: <20260511194847.faster.180-kees@kernel.org>
 <20260511194902.701280-1-kees@kernel.org>
 <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>
 <202605111337.62C81472F5@keescook>
 <e367e0ceadbaabcbdeed786db2cbc3c946e7d639.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e367e0ceadbaabcbdeed786db2cbc3c946e7d639.camel@tugraz.at>

On Tue, May 12, 2026 at 10:13:42AM +0200, Martin Uecker wrote:
> Am Montag, dem 11.05.2026 um 13:41 -0700 schrieb Kees Cook:
> > On Mon, May 11, 2026 at 10:08:06PM +0200, Martin Uecker wrote:
> > > Am Montag, dem 11.05.2026 um 12:48 -0700 schrieb Kees Cook:
> > > > To support the KCFI typeid and future type-based allocators, which need
> > > > to convert unique types into unique 32-bit values, add a mangling system
> > > > based on the Itanium C++ mangling ABI, adapted for C types. Introduce
> > > > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> > > > testing and debugging (to see the human-readable mangling form). Add
> > > > tests for typeinfo validation and error handling.
> > > > 
> > > > This ABI needs to match what is used by LLVM Rust (which matches the Clang
> > > > ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
> > > > Instead of inventing a new ABI, all use the existing Itanium C++ mangling
> > > > which matches KCFI's needs.
> > > > 
> > > > An important aspect of the C++ typeinfo behavior that is retained here
> > > > is that typedefs are treated as pass-through except when the underlying
> > > > type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
> > > > distinction between those typedefs and typedefs used to provide _aliases_
> > > > (u8, uint16_t).
> > > > 
> > > > In the future, an additional "strict mode" builtin helper pair could
> > > > also be added to follow strict ISO C type equivalency instead of the
> > > > existing typeinfo used here, but that is out of scope for this patch.
> > > 
> > > Note that ISO C would require *less* strict rules, so the current
> > > mangling would reject compliant code.
> > > 
> > > These ABI issues were recently discussed also on the rust side.
> > > 
> > > I now worry that it might actually be a mistake to enshrine
> > > the wrong rules into the ABI, creating language interoperability
> > > issues which might then plague us for years.
> > 
> > Well, this matches what we've already created (and have been using for
> > years) on the Clang side. I'm happy to rename this to whatever you want
> > to avoid confusion, but I don't really want to change the rules of this
> > ABI. I'd rather get it working as-is, and then if we want to make
> > mangling changes, do that simultaneously between GCC and Clang.
> > 
> > And this is totally do-able, e.g. I've already created the transition
> > path on the Clang side for changing the hashing algo. For KCFI, we don't
> > need to worry about cross-ABI-version compatibility: the kernel is built
> > as one binary, effectively. We just need to worry about GCC/Clang
> > compatibilities given the Rust side of things.
> 
> I think with the generic names (__builtin_typeinfo_hash) users would
> start to use this for all kinds of things (because it is useful more
> genrally!) and then run quickly into trouble.
> 
> So I think one should either have less generic names, or probably better,
> some kind of ABI argument. An ideally, we would then provide a
> standard-compliant and future-proof mode out-of-the-box (I can help
> with this). If the kernel then opts into a stricter mode this would
> not be problematic.

From the kernel PoV, GCC has been lagging behind horribly on this, and
the sooner this gets merged the better. If Kees were to rename these
intrinsics to __builtin_kcfi_*(), to make them really specific and free
up the namespace for the more generic one that should be good enough,
no?
