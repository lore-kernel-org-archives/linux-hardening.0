Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E9419FBE
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239907; cv=none; b=HglG//OosNmv0QpWUVnL9ut5uR3ocGwRm2wE2v5UiUyuNdbtVWvNK5CCMO2lxrK6OswdlVkkHuiJevQZDknCVqpHZGXD6Fkm0EPiIczc5BrwrTmjEZI4z2H9fC+1dyebrtvhDpuVkNvXOHtb7qoP+bCIu2TMz/EDx/qa+XUariI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239907; c=relaxed/simple;
	bh=Bhu2uapcjjCS2hQDun65SSmI7hee53RbiELHGh8w+v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dapb9yjoEx6ynEuIg3jNriRWEjxwPRsvZK6RpY2obbiIlck4QtyKOx8BPYD0OhSuq0I1Gp9Hr4NYM9pevX4KNDrLUx7sKShBQ7aHyp0I0Ad4lrPhLwC2GvuFF47FMnXRSKCFlApRWywuU28KBgSEnxHJulfXcAUisYDaV3eKUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMpU4ey5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMpU4ey5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AF51F000FF;
	Mon,  5 Oct 2026 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239905;
	bh=wNWJWgmViHDiOoH4De29+OQ98Oh1OCsBApNbFhTo+Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aMpU4ey5kJLsTZyL3BfeZYdxhr/HI7H6seAjUEioEjByXu493V+3lq09dWjklZ/fn
	 HFxP9jkFnUXg/mzL1k0D6k/edvC5pMHQtHWcfe8fbvClgIVb6gNX/0yVY9K/cqOPEP
	 t4tQ+RUkqQxaG9W0/VuH+wu9x1QuN/UOVRSLxsoKVUUu15M9iRClHXlyI/lfMup3Md
	 ksQWJpegGDLeuhzpfyhfE741Vvx6vuW5kgXfjw6Z/gh9bSkoj6nCvMcM/TMeUOUSmV
	 1MbK/ab+ObmUfcIp69/x9EDC0TG1KWGgoSrfCpG+/IeGyx9rgbp4Y4Ss31CThTrQf2
	 2yM9yq6bGXPgA==
Date: Mon, 5 Oct 2026 15:38:25 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
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
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v16 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <20261005221221.ca9a3d-kees@kernel.org>
References: <20260902164928.stay.466-kees@kernel.org>
 <20260902164935.1390773-4-kees@kernel.org>
 <asOBQfGfzUOX4uFq@tucnak>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asOBQfGfzUOX4uFq@tucnak>

On Mon, Oct 05, 2026 at 12:51:45PM +0200, Jakub Jelinek wrote:
> What is reason to use movl + addl instead of just cmpl?
> I mean,
> int foo (int *p) { return *p == 0x12345678; }
> is compiled into
> 	cmpl	$305419896, (%rdi)
> so I wonder why you can't just compare -4(%r11) with
> a 32-bit immediate.
> Are you trying to avoid the immediate to be present in the insn
> sequence, so that nothing can do an indirect call to the insn after this
> compare?

Right, though there are actually a couple reasons. And Peter, please
keep me honest here if I've forgotten something...

First is to keep the resulting live register contents free of
the hash value itself so it can't be used for register content
re-use/exfiltration/side-channels[0]. (While the emitted binary for KCFI
has "known" hashes, Linux mutates all hash locations on x86_64 with a
per-boot random value. This is another use of the trap annotation section:
all KCFI call sites are known, and similarly all KCFI targets are known,
so Linux XORs them all. And let me tell you how much fun it was to debug
THAT[1] when I messed up making the targets visible correctly.)

Second is to avoid always injecting a valid target into the insn sequence,
but this is less important because lots of modern hardware will have
IBT active, so it wouldn't actually be a usable entry point.

And then, pragmatically, it's what Linux expects there. The kernel's
KCFI FineIBT implementation[2] and the trap handlers[3] both expect
exactly that sequence of bytes today.

The commit log kind of hints at part of this, but you make a good point
that it is not really well spelled out. Should I improve the commit
log or the comments? It seems lengthy for a code comment, but it's less
discoverable in the commit log.

-Kees

[0] https://lore.kernel.org/lkml/656a965d6241d3a697180cc4d05ada2b@overdrivepizza.com/
[1] https://lore.kernel.org/lkml/20250904034656.3670313-5-kees@kernel.org/
[2] https://elixir.bootlin.com/linux/v7.3-rc2/source/arch/x86/kernel/alternative.c#L1316
[3] https://elixir.bootlin.com/linux/v7.3-rc2/source/arch/x86/include/asm/cfi.h#L47

-- 
Kees Cook
