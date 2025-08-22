Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160802E1F15
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845611; cv=none; b=fPiRizT41WvSTSV9GGZykwPFS59lZ3JMwoCWhZ2QtM8wHcqE9LgLnWtC1vwfYldmy49+ZjoDaaZMaV/vZ+NEl5sUz1WpsDu3M0NtRvl+73LRr8TEC7fikyLekD/z51E+EMo8QF1PmrYqcOO6zeH+dcySwdtVCrbO64SwMA7NovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845611; c=relaxed/simple;
	bh=THweuQt3ll3g5lqHCFzVX9giI5hg8ue3NFed3svoXGU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a9sF1p7fbzB9riD5xJkJC1E80vI0wZm81mRYPeTTAZWO3EYz4grphHo3oWfXhc2BxYFpCmDd2AIUPHqjydfFgSGHo0NdOsY/ulqINlxrBF74xCS8yTe9kQx9F6UWYTt6KkuyGFeWblJaWPgWjUpObOTx85GWb2XqYhWQ0IkqcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O3+nWxQN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IuISdEwW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O3+nWxQN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IuISdEwW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O3+nWxQN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IuISdEwW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O3+nWxQN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IuISdEwW"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0262D2239F;
	Fri, 22 Aug 2025 06:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755845608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERi65gTP550jQWTFUUXcNoUkBKi0gY4O0Cf3Hq1r3sg=;
	b=O3+nWxQN8GVu6PBCXQR/Dxj/glEJ1i7vEmrMwd8UPdqHMyEhcwblLbCPJpHucB6dDKU0Uy
	tUrqV4x8+UuXCgMpW9lnRc4efch/p13fhmvl2UbLWhemMlgy+r851RNtYnb0ZwpUpvPHVP
	StG8CrM2MJ0X6HDrIIBpaM5+bsfz/NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755845608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERi65gTP550jQWTFUUXcNoUkBKi0gY4O0Cf3Hq1r3sg=;
	b=IuISdEwWD7aXh7uQs2txc7/KGPlR/mg8F6t3pxJBFcv7evQ1c6sPlnmGCG3/5MKSBW5Nmu
	OCoPqYy3BCNmBZAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755845608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERi65gTP550jQWTFUUXcNoUkBKi0gY4O0Cf3Hq1r3sg=;
	b=O3+nWxQN8GVu6PBCXQR/Dxj/glEJ1i7vEmrMwd8UPdqHMyEhcwblLbCPJpHucB6dDKU0Uy
	tUrqV4x8+UuXCgMpW9lnRc4efch/p13fhmvl2UbLWhemMlgy+r851RNtYnb0ZwpUpvPHVP
	StG8CrM2MJ0X6HDrIIBpaM5+bsfz/NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755845608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERi65gTP550jQWTFUUXcNoUkBKi0gY4O0Cf3Hq1r3sg=;
	b=IuISdEwWD7aXh7uQs2txc7/KGPlR/mg8F6t3pxJBFcv7evQ1c6sPlnmGCG3/5MKSBW5Nmu
	OCoPqYy3BCNmBZAw==
Date: Fri, 22 Aug 2025 08:53:27 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Kees Cook <kees@kernel.org>
cc: Peter Zijlstra <peterz@infradead.org>, 
    Andrew Pinski <andrew.pinski@oss.qualcomm.com>, 
    Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org, 
    Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>, 
    Richard Earnshaw <richard.earnshaw@arm.com>, 
    Richard Sandiford <richard.sandiford@arm.com>, 
    Marcus Shawcroft <marcus.shawcroft@arm.com>, 
    Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>, 
    Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>, 
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
In-Reply-To: <202508211207.57A1A3BCE7@keescook>
Message-ID: <79s6550s-155r-8q0r-n5o8-72nnq03sr8p3@fhfr.qr>
References: <20250821064202.work.893-kees@kernel.org> <20250821072708.3109244-3-kees@kernel.org> <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com> <20250821091220.GM4067720@noisy.programming.kicks-ass.net> <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
 <202508211207.57A1A3BCE7@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,oss.qualcomm.com,oracle.com,gcc.gnu.org,redhat.com,ucw.cz,arm.com,gmail.com,dabbelt.com,sifive.com,vger.kernel.org];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RL8y3m6pz8udumc8k65cwet)]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Thu, 21 Aug 2025, Kees Cook wrote:

> On Thu, Aug 21, 2025 at 01:01:37PM +0200, Richard Biener wrote:
> > On Thu, 21 Aug 2025, Peter Zijlstra wrote:
> > 
> > > On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > > 
> > > > > +/* Compute KCFI type ID for a function declaration or function type
> > > > > (internal) */
> > > > > +static uint32_t
> > > > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > > > +{
> > > > > +  if (!fntype_or_fndecl)
> > > > > +    return 0;
> > > > > +
> > > > > +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> > > > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > > > >
> > > > 
> > > > Now I am curious why this needs to be a mangled function name? Since the
> > > > function in C the symbol is just its name.
> > > > Is there documentation that says the hash needs to be based on all of the
> > > > function arguments types?
> > > 
> > > The whole point of kCFI is to limit the targets of indirect calls to
> > > functions of the same signature. The actual function name is immaterial.
> > 
> > What's the attack vector and how does kCFI achieve mitigating it?
> 
> To add some more detail to Peter's answer, the attack vector is dealing
> with stored function pointers (generally on the heap, but potentially
> also the stack), that can be changed by attacker-controlled writes (via
> buffer overflows or use-after-free writes). The idea being that instead
> of being able to call anywhere through an indirect call site that uses a
> manipulated pointer, now the attacker is limited to a subset of "matching"
> destinations. (KCFI depends on a system already enforcing W^X memory in
> the sense that if an attacker can construct an executable region, they
> could write whatever hash they want into in addition to whatever code.)
> 
> The general CFI ideas for this are discussed here, but focuses more on a
> CFG analysis to construct valid call destinations, which tends to require
> LTO, etc:
> https://users.soe.ucsc.edu/~abadi/Papers/cfi-tissec-revised.pdf
> 
> Later refinement for using jump tables (constructed via CFG analysis
> during LTO) was proposed here:
> https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-tice.pdf
> Linux used the above implementation from 2018 to 2022:
> https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html
> but the corner cases for target addresses not being the actual functions
> (i.e. pointing into the jump table) was a continual source of problems,
> and generating the jump tables required full LTO, which had its own set
> of problems.
> 
> Looking at function prototypes as the source of call validity was
> presented here, though still relied on LTO:
> https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf
> 
> The KCFI approach built on the function-prototype idea, but avoided
> needing LTO, and could be further updated to deal with CPU errata
> (retpolines, etc):
> https://lpc.events/event/16/contributions/1315/
> This has been working very well now for 3 years, but has been limited to
> only Linux built with Clang (e.g. Linux kernel CFI, first LLVM-CFI and now
> KCFI, has been deployed on all Android phones and all Chrome OS devices
> since 2018.)
> 
> I have been trying to find someone to work on KCFI in GCC since 2018,
> (see my annual arm-waving at the Linux Plumbers conference Toolchain
> track) and other than Dan Li who took a stab at it for aarch64 in 2023,
> no one has stepped up to do it, so I thought I'd finally try tackling
> it. :)

Thanks for the write-up.  So I wonder whether a more general solution
would be to detach "hash value" computation and assignment and leave
that to external tooling that could do better than non-LTO can and
the compiler working with attributed function types instead?  Say

void __attribute__((cfi_hash("voidvoidbutonlykind1"))) foo (void);

that decouples the way to arrive at the hashes from the instrumentation.
You could then of course have compiler assisted auto-attribution
based on function types.  So implementation-wise I'd try to separate
both?  Oh, and somehow it reminds me of vtable verification?

That said, how's the collision rate on the kernel side?

What's the usual exploitation of overwriting a call function pointer?
That is, what's a good useful function to target?  I'd guess a
hypothetical setuid (int)?  Somehow it feels like a more academic
thing, with other attack vectors being much more accessible?

Richard.
