Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38712BF007
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890631; cv=none; b=O1kIDsB6OfJElIC4T0py17fMQXCELTcRPiBhDa1gok8JudK+OPA7jffSyGtXDsXeW+EK3pp1D/ETUSrWBL0RSupeNkse0PVonorTkV+rziKn45RWWyRM9mZWvtlIx0ZxP27Kr+uFEPqSbUKYZP75SIsUExe3hACceZN0Cs0Enzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890631; c=relaxed/simple;
	bh=G8yuWrEYpVrIsHpxVJJwEWfdjiUbQvOcgiMTWTA8G7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuA0vi+zpdDcazC+L35zRS69lDS94k0iR6x3fNliujRbwc0N19mFYuqLwmO1t3p61C9d+hjnOU1zLGzwOAog3dOzDYVvP9MfyjYf4sQIgcokjmm2DBSNKnm4RPjQlNRntktmn6ESFU6SzEHH7CkY+5x22pIuxUBJ1oz5uri5GV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQm5tPOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQm5tPOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F742C4CEED;
	Fri, 22 Aug 2025 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890630;
	bh=G8yuWrEYpVrIsHpxVJJwEWfdjiUbQvOcgiMTWTA8G7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQm5tPOh9NYAOU6/AU+D2D3dGtl7EPUgT9Be1vpIvWGYjKfxEAcghrwGQXKf5rLkG
	 7JRJIHkfxMdjnPQfNVYAdkrQLkXBJCwkFispU+VcQ3crlCXipOrA92IZJixN6RxiIV
	 RSV21UOxKcvleKF2BSihQc3fU0Pvgno0IF2xxu7QwbQtceRcRkhcm9n0Wa0RHHCWQ0
	 Svh4aW5+1yw0Hrz525cdkordQS+o/DZurSPu8oRWjCaezb9YyeTuHNOiPdTgZY1ijL
	 oYfVb5hUWeO1eKbukCApqYCS7JHmhCClEPdjS/GLyVaoS2czlItPOBksuPF6fFTT6H
	 LzKL3lYVgiOng==
Date: Fri, 22 Aug 2025 12:23:50 -0700
From: Kees Cook <kees@kernel.org>
To: Richard Biener <rguenther@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202508221203.9069FDC389@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
 <202508211207.57A1A3BCE7@keescook>
 <79s6550s-155r-8q0r-n5o8-72nnq03sr8p3@fhfr.qr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79s6550s-155r-8q0r-n5o8-72nnq03sr8p3@fhfr.qr>

On Fri, Aug 22, 2025 at 08:53:27AM +0200, Richard Biener wrote:
> Thanks for the write-up.  So I wonder whether a more general solution
> would be to detach "hash value" computation and assignment and leave
> that to external tooling that could do better than non-LTO can and
> the compiler working with attributed function types instead?  Say
> 
> void __attribute__((cfi_hash("voidvoidbutonlykind1"))) foo (void);

Yeah, having a way to choose different hashes was part of Joao's thesis.
Additionally, using a function attribute to salt a given function's hash
had been on the KCFI TODO list for a few years and just got implemented
in Clang last week:
https://clang.llvm.org/docs/AttributeReference.html#cfi-salt

I intend to get that implemented too, but I wanted to get the core KCFI
landed first.

> that decouples the way to arrive at the hashes from the instrumentation.
> You could then of course have compiler assisted auto-attribution
> based on function types.  So implementation-wise I'd try to separate
> both?  Oh, and somehow it reminds me of vtable verification?
> 
> That said, how's the collision rate on the kernel side?

The salting (and Joao's work) are designed specifically for dealing with
collisions; you can see the frequency graph in here:
https://security.googleblog.com/2018/10/posted-by-sami-tolvanen-staff-software.html
In the Android Linux kernel, indirect calls:
- 55% have <= 5 targets
- 7% have > 100 targets

Breaking up that long 7% tail has been the goal with either LTO analysis
to split up the groups or manual annotation (i.e. hash salt).

> What's the usual exploitation of overwriting a call function pointer?
> That is, what's a good useful function to target?  I'd guess a
> hypothetical setuid (int)?  Somehow it feels like a more academic
> thing, with other attack vectors being much more accessible?

For forward edge, it's usually calling a series of useful targets. Calling
into functions to disable SMAP/SMEP, turn off SELinux, setuid, etc. Each
of these specific cases have been hardened over the years (no non-inline
MSR manipulation, SELinux permissive knob removed, credential creation
doesn't take a default arg, etc).

What we've seen after the addition of CFI (and other hardening) in Linux
was a greater push by attackers toward the less "low-hanging fruit" of
"data only" attacks (e.g. write to the page tables, etc). Jann Horn has
a particularly sobering write-up about this via memory allocators:
https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-Kees

-- 
Kees Cook
