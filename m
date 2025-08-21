Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A116F0FE
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806254; cv=none; b=XM1chaQUHuUwX/gjWviuuVeK03xsdKn14kHprcuqSQiEEXr7wYNN0XhOQHn5DPaubQ+y1e2iqDghKBCNVzrwitU23ApM2aS2AhzzitkN2Jpsa35t+YwFFF15iAcIEQEab+SIQxIcjibjRCXowgCici+diJjogJHCbUQftNF1C3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806254; c=relaxed/simple;
	bh=G8FZ2fa9bvDBkFp5w4W18+EnMYDxkVWMTgHvV89nlS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltzFNmNF8VDXdIRm23GEzyCkmTReF+fmfxTl1iJEexGATeTwhQaSoB07kGwTZQ2UIxSKUqFHycul4afDTcb5n2hlG6Nah7jw0DfBBEod18W2H0IhQMgH+1tAR3d3ETvBslxgQh3NloJUdIXjGnNdZ40WtN7KWm/7sBDTlx+OMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOKTh0WN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOKTh0WN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C136C4CEEB;
	Thu, 21 Aug 2025 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755806254;
	bh=G8FZ2fa9bvDBkFp5w4W18+EnMYDxkVWMTgHvV89nlS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOKTh0WN4LufAJ5mjqU+WYu4fFQNJLE1McUojnET0K3xs6kmseYedwyqhuYF0/Jsd
	 qoWzN8GQQE03qidyPO+GBmmpZfoHDFq+CwTGHPOKWlkepOvdn90JqbDFoj2JDIm4lp
	 DllIRY5Zyya7xcuGgn+OAzntOicg/Sz+bHjTnoQUVd/jtpTLZez34qpn8EtV+Cnw6S
	 r0XQlBllzCt874IU9lOyHspK5k7FpFghEBA4M6HnbRBaedydL0uBhWv08ZocBZBi5b
	 ojy/4av+NDBc2MbhEZ8KZQBVJ5gYMvB/tbDfNNtDNhQw312q0N8cgG8hNNpwqMTU6/
	 p5VIQjvCHO7kA==
Date: Thu, 21 Aug 2025 12:57:33 -0700
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
Message-ID: <202508211207.57A1A3BCE7@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>

On Thu, Aug 21, 2025 at 01:01:37PM +0200, Richard Biener wrote:
> On Thu, 21 Aug 2025, Peter Zijlstra wrote:
> 
> > On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > 
> > > > +/* Compute KCFI type ID for a function declaration or function type
> > > > (internal) */
> > > > +static uint32_t
> > > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > > +{
> > > > +  if (!fntype_or_fndecl)
> > > > +    return 0;
> > > > +
> > > > +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> > > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > > >
> > > 
> > > Now I am curious why this needs to be a mangled function name? Since the
> > > function in C the symbol is just its name.
> > > Is there documentation that says the hash needs to be based on all of the
> > > function arguments types?
> > 
> > The whole point of kCFI is to limit the targets of indirect calls to
> > functions of the same signature. The actual function name is immaterial.
> 
> What's the attack vector and how does kCFI achieve mitigating it?

To add some more detail to Peter's answer, the attack vector is dealing
with stored function pointers (generally on the heap, but potentially
also the stack), that can be changed by attacker-controlled writes (via
buffer overflows or use-after-free writes). The idea being that instead
of being able to call anywhere through an indirect call site that uses a
manipulated pointer, now the attacker is limited to a subset of "matching"
destinations. (KCFI depends on a system already enforcing W^X memory in
the sense that if an attacker can construct an executable region, they
could write whatever hash they want into in addition to whatever code.)

The general CFI ideas for this are discussed here, but focuses more on a
CFG analysis to construct valid call destinations, which tends to require
LTO, etc:
https://users.soe.ucsc.edu/~abadi/Papers/cfi-tissec-revised.pdf

Later refinement for using jump tables (constructed via CFG analysis
during LTO) was proposed here:
https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-tice.pdf
Linux used the above implementation from 2018 to 2022:
https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html
but the corner cases for target addresses not being the actual functions
(i.e. pointing into the jump table) was a continual source of problems,
and generating the jump tables required full LTO, which had its own set
of problems.

Looking at function prototypes as the source of call validity was
presented here, though still relied on LTO:
https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf

The KCFI approach built on the function-prototype idea, but avoided
needing LTO, and could be further updated to deal with CPU errata
(retpolines, etc):
https://lpc.events/event/16/contributions/1315/
This has been working very well now for 3 years, but has been limited to
only Linux built with Clang (e.g. Linux kernel CFI, first LLVM-CFI and now
KCFI, has been deployed on all Android phones and all Chrome OS devices
since 2018.)

I have been trying to find someone to work on KCFI in GCC since 2018,
(see my annual arm-waving at the Linux Plumbers conference Toolchain
track) and other than Dan Li who took a stab at it for aarch64 in 2023,
no one has stepped up to do it, so I thought I'd finally try tackling
it. :)

-Kees

-- 
Kees Cook
