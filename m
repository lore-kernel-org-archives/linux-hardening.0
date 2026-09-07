Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0747604E
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783556; cv=none; b=n6x3VAKFYANnXMMp0TosbJxyJJ6PyOs1xdUuanw2hDV/ovA8w3Z7GOem2LwjfK4fA7enbAf57g1Qaqvbtd44jv2adGK2zzLlRsGKkA3aqXPTJWURVldR6i3AQdL2d/VQ1BQ3pmL8mc2isag51iB6N8xwsJ27YacBvlTGxzCvkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783556; c=relaxed/simple;
	bh=PoxmoZZTOhcE6CEga/lO9FXzLDRYEFsrRYQWv6jH4IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdTEsA93Ln2C6L9oKdpAeLV8YbnoINmVSzghY1bnRaBp2Ic+PZSN4s2ZgNBnbu5CnIEbR9Zfp8P0q6uoVZOH+n+86V6xyLz0DKZWJA8vRq2hK9kT0NmdhjhAmHpnRIAUJUukgwa0bL6dnI+yBslIxgvI8CUxQ2/U5dMk9VQSMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jZtqBqkj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jZtqBqkj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E75F1476;
	Mon,  7 Sep 2026 05:19:09 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B683F7D8;
	Mon,  7 Sep 2026 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788783553; bh=PoxmoZZTOhcE6CEga/lO9FXzLDRYEFsrRYQWv6jH4IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZtqBqkj3kWFKvNGbyHLWMPvyN0cEDClPlkqsGw4chhgal9iTQXY5hVzOV9lN7rif
	 CjV90NANP1wV0RJgDpJfH1r3NO3VAzZTRcwefsHApE5L3MSEz9AXCT8pJL/QBbZ1lJ
	 mF0CGL8A0r8/NYeRFUlvx06lB4/ue+RZSTt44NEA=
Date: Mon, 7 Sep 2026 17:49:09 +0530
From: Linu Cherian <linu.cherian@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v9 00/25] pkeys-based page table hardening
Message-ID: <ap6rvQJbO8DH57v8@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <apbgDNjQPLBdsUe0@a079125.arm.com>
 <43382882-0e7b-4255-9c34-99cec5b0bbbc@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43382882-0e7b-4255-9c34-99cec5b0bbbc@arm.com>

On Thu, Sep 03, 2026 at 06:47:50PM +0200, Kevin Brodsky wrote:
> On 01/09/2026 16:24, Linu Cherian wrote:
> > Hi Kevin,
> >
> > On Tue, Aug 18, 2026 at 03:08:42PM +0100, Kevin Brodsky wrote:
> >> [Sending during the merge window in case reviewers have spare
> >> cycles; I'm not aiming to have this series merged in v7.3.]
> >>
> >> This is a proposal to leverage protection keys (pkeys) to harden
> >> critical kernel data, by making it mostly read-only. The series includes
> >> a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
> >> as well as a page table hardening feature based on that framework,
> >> "kpkeys_hardened_pgtables". Both are implemented on arm64 as a proof of
> >> concept, but they are designed to be compatible with any architecture
> >> that supports pkeys.
> >>
> >> The proposed approach is a typical use of pkeys: the data to protect is
> >> mapped with a given pkey P, and the pkey register is initially
> >> configured to grant read-only access to P. Where the protected data
> >> needs to be written to, the pkey register is temporarily switched to
> >> grant write access to P on the current CPU.
> >>
> >> The key fact this approach relies on is that the target data is
> >> only written to via a limited and well-defined API. This makes it
> >> possible to explicitly switch the pkey register where needed, without
> >> introducing excessively invasive changes, and only for a small amount of
> >> trusted code.
> >>
> >> Page tables are chosen as an initial target because of their especially
> >> critical nature - a single write may result in arbitrary pages becoming
> >> accessible to any context (including userspace). In order to keep the
> >> series digestible for reviewers, this version focuses on functionality
> >> rather than performance, making it most suitable as a debug feature. The
> >> key trade-off is the requirement to PTE-map the linear map - see section
> >> "Protected page table allocation" for details.
> >>
> >> This series has similarities with the "PKS write protected page tables"
> >> series posted by Rick Edgecombe a few years ago [1] but it is not
> >> specific to x86/PKS - the approach is meant to be generic.
> >>
> >> This proposal (as of RFC v5) was presented at Linux Security Summit
> >> Europe 2025 [2].
> >>
> >> [Table of contents]
> >>
> >> * kpkeys
> >>   - pkey register management
> >>
> >> * kpkeys_hardened_pgtables
> >>   - Protected page table allocation
> >>   - kpkeys context switching
> >>   - Performance
> >>   - Limitations
> >>
> >> * This series
> >>   - Branches
> >>
> >> * Threat model
> >>
> >> * Further use-cases
> >>
> >> * Open questions
> >>
> >> kpkeys
> >> ======
> >>
> >> The use of pkeys involves two separate mechanisms: assigning a pkey to
> >> pages, and defining the pkeys -> permissions mapping via the pkey
> >> register. This is implemented through the following interface:
> >>
> >> - Pages are assigned a pkey in the linear map using set_memory_pkey().
> >>   This is sufficient for this series, but it is also plausible for
> >>   higher-level allocators to support marking allocations with a given
> >>   pkey.
> >>
> >> - The pkey register is configured based on a *kpkeys context*. kpkeys
> >>   contexts are represented as simple integers that correspond to a given
> >>   configuration, for instance:
> >>
> >>   KPKEYS_CTX_DEFAULT:
> >>         RW access to KPKEYS_PKEY_DEFAULT
> >>         RO access to any other KPKEYS_PKEY_*
> >>
> >>   KPKEYS_CTX_<FEAT>:
> >>         RW access to KPKEYS_PKEY_DEFAULT
> >>         RW access to KPKEYS_PKEY_<FEAT>
> >>         RO access to any other KPKEYS_PKEY_*
> >>
> >>   Only pkeys that are managed by the kpkeys framework are impacted;
> >>   permissions for other pkeys are left unchanged (this allows for other
> >>   schemes using pkeys to be used in parallel, and arch-specific use of
> >>   certain pkeys).
> >
> > - Adding some basic details on what a scheme and context is quite helpful.
> >
> >  - Giving some hints (may be an example) on how multiple schemes and multiple contexts
> >   play together would be quite helpful.
> 
> "scheme" doesn't mean anything precise, it's only the notion that pkeys
> that aren't reserved for kpkeys (i.e. anything but 0 or 1 in this
> series) may be used for other purposes. Happy to reword if you have a
> suggestion.

Got it. IMHO, adding two definitions towards the start would make it easier to follow.

kpkeys: Set of pkeys reserved and managed by the kpkeys framework.
        Pkeys outside this set are left untouched.

kpkeys context: A permission state that defines the permissions for each pkey owned by
 	kpkeys

Or something better.

> 
> "kpkeys context" is what is described above this paragraph, it's really
> just a set of permissions for the managed pkeys. Transitioning between
> context is described below.

Its clear to me now.

> 
> > Adding a documentation that covers these aspects would be much
> > appreciated.
> 
> For sure, I am planning to have a documentation patch in a subsequent
> version.
> 

That would be great.


> > My understanding is that pkeys are being partitioned across different
> > contexts. But then the introduction of the term "scheme" looks bit confusing to me.
> 
> I wouldn't say pkeys are partitioned across contexts. Every context has
> a set of permissions for all the pkeys managed by kpkeys. Any other pkey
> is ignored (permissions left unchanged) by this framework.

Ack.


> 
> >>   The current kpkeys context is changed by calling
> >>   kpkeys_enter_context(), which will set the pkey register
> >>   accordingly and return the original state. A
> >>   subsequent call to kpkeys_leave_context() restores the original
> >>   state (and thus the original kpkeys context). The numeric value of
> >>   KPKEYS_CTX_* (kpkeys context) is purely symbolic and thus generic,
> >>   however each architecture is free to define non-default pkeys
> >>   values (KPKEYS_PKEY_*).
> >>
> > ..snip
> >
> >> Open questions
> >> ==============
> >>
> >> A few aspects in this RFC that are debatable and/or worth discussing:
> >>
> >> - There is currently no restriction on how kpkeys contexts map to pkeys
> >>   permissions. A typical approach is to allocate one pkey per context and
> >>   make it writable in that context only. As the number of contexts
> > Probably to avoid the assumption, may be we can we have something like
> > below 
> >
> > For a pkey P, we could define
> > PKEY_P_PERM_CTXT_OTHERS	 //permission for pkey p in other contexts
> > PKEY_P_PERM_CTXT_SELF	 //permission for pkey p in self context
> >
> > With the assumption of one pkey mapped for every context,
> > the permission for the default context would look something like,
> >
> > PKEY_DEF_PERM_CTXT_SELF << PKEY_DEF_PKEY_SHIFT |
> > PKEY_CT0_PERM_CTXT_OTHERS << PKEY_CT0_PKEY_SHIFT | 
> > PKEY_CT1_PERM_CTXT_OTHERS << PKEY_CT1_PKEY_SHIFT |
> > ...(for all valid contexts)
> >
> > where,
> > Permission key, PKEY_DEF is associated with context DEFAULT,
> > Permission key, PKEY_CT0 is associated with context CT0,
> > Permission key, PKEY_CT1 is associated with context CT1
> 
> This adds assumptions rather than avoiding them. *Typically* when adding
> a context you'd allocate a pkey that's only writable by this context,
> but it doesn't have to be this way.

Okay agree. Then may be something like

Define permissions:

For default context,
KPKEYS_CTX_DEFAULT_PERM_PKEY_DEF
KPKEYS_CTX_DEFAULT_PERM_PKEY_CT0

For CT0 context,
KPKEYS_CTX_CT0_PERM_PKEY_DEF
KPKEYS_CTX_CT0_PERM_PKEY_CT0

Define POR_EL1:

For default context,
KPKEYS_POR_EL1_DEFAULT

For CT0 context,
KPKEYS_POR_EL1_CT0

Finally,
#define POR_EL1_INIT KPKEYS_POR_EL1_DEFAULT

Probably using something similar would make the idea of kpkeys context 
more evident in the code as well ?

> 
> The configuration space is more easily understood by considering the
> other use-cases we've investigated (struct cred protection and eBPF
> isolation, linked further down). For instance, for cred protection, we
> had KPKEYS_LVL_UNRESTRICTED with write access to all pkeys, and for eBPF
> isolation, we need a level that is less privileged and therefore does
> *not* have write access to pkey 0.
> 
> >>   increases, we may however run out of pkeys, especially on arm64 (just
> >>   8 pkeys with POE). Depending on the use-cases, it may be acceptable to
> >>   use the same pkey for the data associated to multiple contexts.
> > Lets say two contexts A and B, use the same pkey P as their permission matches.
> > But then, when we enter context A, permission for pkey P gets
> > relaxed, then that would relax permission for pages associated with
> > context B as well which is unintended ?
> 
> That may be exactly what is intended, it all depends on the use-case. C1
> may have a private pkey P1, and C2 P2, and then P3 that is shared by C1
> and C2 (writable by both)

Got it. With each context defining permissions for each pkey owned by
kpkeys makes sense. 

Also do we need to assume that nesting of different contexts is not valid ?
For example,
Default context:
	enter CTX 0
		enter CTX 1
		leave CTX 1
	leave CTX 0
Default context:
  
> > As the hardware supports 16 pkeys, should we consider removing the limit
> > of 8 pkeys so that we can have unique pkeys for each context ?
> 
> FEAT_S1POE only supports 4-bit pkeys when using 128-bit page tables.

Ack.

--
Linu Cherian
