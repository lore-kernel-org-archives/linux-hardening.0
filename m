Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47C2F852
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801979; cv=none; b=fWTO5obDc5OIk3ZtbnIRl8ivQMNhQJXEitjWdVsMJxPWIB+dU2YFK/ad2rpPKQI5UKuA3kvWVfwVV1dDZLnIlIypmX0bXKubkErDGUM353l2ArW5hDyK8cmFktDQySJW+2h+ikZvKjAJFi1AyGpKEgaP7HEmmHZIUd3PxjA3sLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801979; c=relaxed/simple;
	bh=yvYHp5hLBn/tPt07IO4/uD5pq16GvUv0m3PYtA1A0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrdEflTh6O69Y8bY0mrvSOFJkPx5RKBslif16NMXgZ1kTuGb3bG7VmESnzG6OoVP0BBSJeBZtCJKi1gAEw8EIF3/oK3S02PG3z0/rCtD6nNrvRxuqqH+CWaFJNeeyN5S9xVxBCOlWJj3ljUhcSm09OJkpka271HuFq2aYIvz7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmHyOcYl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmHyOcYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEA7C4CEEB;
	Thu, 21 Aug 2025 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801978;
	bh=yvYHp5hLBn/tPt07IO4/uD5pq16GvUv0m3PYtA1A0+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmHyOcYlNf8duYyE9Vu9RpXqca9JeR26YfmiKRBvHl1GeJmBuspNR+579rl97pnfk
	 ji+CMi1CR+e8/HQSJq+Avt7P1h8q/OQqDYitymVLSuEfRB2eVKQwWJXpalbHL92S86
	 2JXDR+31sCbMOG8wXzo17bg3I/RlkU4FTFxKTJc26Sf79Ekhw4XWid0vSOapMy1sYh
	 mnM1C4bpSoCwQSXr2NUd3jfFafuh8+MPvsjjzPCF3ELheymY6njr9WkYBG7JTDtScS
	 tzVG3QlOjwQ7Difwb88XOozp+eIYhUkWNGRZqnOrF9nh12OgXW9KwLEF1CwEWwWb1p
	 FWAcJ5cUj0o0Q==
Date: Thu, 21 Aug 2025 11:46:17 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <202508210916.71079E4BA8@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
 <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821092935.GN4067720@noisy.programming.kicks-ass.net>

On Thu, Aug 21, 2025 at 11:29:35AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 21, 2025 at 12:26:37AM -0700, Kees Cook wrote:
> > Implement x86_64-specific KCFI backend:
> > 
> > - Function preamble generation with type IDs positioned at -(4+prefix_nops)
> >   offset from function entry point.
> > 
> > - 16-byte alignment of KCFI preambles using calculated prefix NOPs:
> >   aligned(prefix_nops + 5, 16) to maintain cache lines.
> > 
> > - Type-id hash avoids generating ENDBR instruction in type IDs
> >   (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).
> > 
> > - On-demand scratch register allocation strategy (r11 as needed).
> >   The clobbers are available both early and late.
> > 
> > - Atomic bundled KCFI check + call/branch sequences using UNSPECV_KCFI
> >   to prevent optimizer separation and maintain security properties.
> > 
> > - Uses the .kcfi_traps section for debugger/runtime metadata.
> > 
> > Assembly Code Pattern layout required by Linux kernel:
> >   movl $inverse_type_id, %r10d  ; Load expected type (0 - hash)
> >   addl offset(%target), %r10d   ; Add stored type ID from preamble
> >   je .Lpass                     ; Branch if types match (sum == 0)
> >   .Ltrap: ud2                   ; Undefined instruction trap on mismatch
> >   .Lpass: call/jmp *%target     ; Execute validated indirect transfer
> > 
> > The initialization of the kcfi callbacks in ix86_option_override()
> > seems like a hack. I couldn't find a better place to do this.
> > 
> > Build and run tested on x86_64 Linux kernel with various CPU errata
> > handling alternatives and FineIBT.
> 
> I'm a little confused, does this force r11 to be the indirect call
> register like clang does? The code seems to suggest it is possible it
> uses another register.
> 
> The current kernel FineIBT code hard assumes r11 for now.

Oh, it looked like it wasn't always r11. Does clang force the call
register to be r11? I only do that here if the call expression isn't a
register (similar to -mindirect-branch-register). Looking at the retpoline
implementation, I see __x86_indirect_thunk_* being generated for all the
general registers. Hm, but in looking now I see all the hard-coded r11 use
in the fineibt alternatives. I wonder if my boot testing is somehow not
triggering the FineIBT alternatives patching? I will investigate more...

-- 
Kees Cook
