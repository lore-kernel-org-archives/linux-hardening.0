Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0B33DED5
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572232; cv=none; b=Tg+BcIr6QRA8hD643K+9+xxuQX+x6zglIENHTN7D90PADIsgKHfz1cpWZsFGmXR1pSZHEo0Iz3/11HeUgPq5u0xXIekuAKINq9dT5dMUrCn4EBg5NA+0MRgWLuNMhxmDDE3e4gUjaPq4rlQ4sVQO1gRhgysnH3wpAr72EvY/lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572232; c=relaxed/simple;
	bh=cSLK/AmERqOQkwmxHvV3fWQaVPlJCRrSGe1odDeKqi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kalEzmFv1JTiCwKkqCMKNZP3zcUePaTLJOnbuwnZay3fVYLE6RUTsapts2Wdm7KuZ4NuNnwvtWBtqY8FpXmstS4QmdYVrtRxnJLGdTsQRte4g6c5sgbV6eiMUTmFpibT7rzGJ/xPtnMnyci8wGNuVZSi7pv2FQbWOEQ9tv679S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u71r1l9v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u71r1l9v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZW4QLduKaLBjiIqjgzK1kiw6S7DzybC6JirzE7iAFo=; b=u71r1l9vJmIvIuop427EViNEIW
	0yQB0VP6BoI2+ng1VRYAwM8LpmA9ki/IqtH413OlxxsQMgp9MgpvtFSacX2F7XLMwIXkyN62XbWZG
	bLgRp6efqS+HyLZ57ppORy52VGxWEP2tSjywyZPI5wKI9tgK4UcjDpYgzEtrZ/cry8fLpWv/Ml+5v
	djKOtg6JaWWH/jDSBXQ8ODHGPBdsJgehxMCz4dHOc4VRuQ6B1/XBiSwaku4423XMrnqgIxn06R9/W
	oqN05AoZhemI7TpDjZtJrU5jIX75B3OmaA8jRn3ormzZXV4ESoseG9RVMcnRYZcYIxidDvzmCMqZn
	zIVFf/Tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMhsa-00000009OKa-2juC;
	Tue, 12 May 2026 07:50:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B6993007E1; Tue, 12 May 2026 09:50:11 +0200 (CEST)
Date: Tue, 12 May 2026 09:50:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Uros Bizjak <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v11 0/7] Introduce Kernel Control Flow Integrity ABI
 [PR107048]
Message-ID: <20260512075011.GU3126523@noisy.programming.kicks-ass.net>
References: <20260511194847.faster.180-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511194847.faster.180-kees@kernel.org>

On Mon, May 11, 2026 at 12:48:44PM -0700, Kees Cook wrote:
> Hi,
> 
> This series implements[1][2] the Linux Kernel Control Flow Integrity
> ABI, which provides a function prototype based forward edge control flow
> integrity protection by instrumenting every indirect call to check for
> a hash value before the target function address. If the hash at the call
> site and the hash at the target do not match, execution will trap.
> 
> I was asked to wait to resend this series until gcc 16 released, which
> it has now. I'm hoping we can land the front-, middle-, and back-ends
> for aarch64 and x86_64. I'd really like to get this in a position where
> more people can test with GCC snapshots, etc. Since I don't have commit
> access, who is the right person to commit this?
> 
> Thanks!
> 
> -Kees
> 
> Changes since v10[3]:
> 
> - Rebase to latest.
> - Update tests to aarch64 brk instruction immediate printing in hex.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
> [2] https://github.com/KSPP/linux/issues/369
> [3] https://lore.kernel.org/linux-hardening/20260107200301.better.465-kees@kernel.org/
> 
> Kees Cook (7):
>   typeinfo: Introduce KCFI typeinfo mangling API
>   kcfi: Add core Kernel Control Flow Integrity infrastructure
>   kcfi: Add regression test suite
>   x86: Add x86_64 Kernel Control Flow Integrity implementation
>   aarch64: Add AArch64 Kernel Control Flow Integrity implementation
>   arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
>   riscv: Add RISC-V Kernel Control Flow Integrity implementation

Thanks for continuing to push this Kees!
