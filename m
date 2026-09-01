Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DA3DA7E4
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275638; cv=none; b=gUV1i4iR/maB07IhSXYgPBgGx+oPV5XyibRoR758i43ZHgc080jjxmXaSHkeLP1PxJSqDNSSNB/DCbHfxaFBmWiNA+iqZolXS6Vdl0QxL8cjqiRLKPNRkvnviQDR/QgIhnNjtB5fKK5mFXJLaECV+GcuBAAiJPpBLxhSf4dEOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275638; c=relaxed/simple;
	bh=nK6FlW3g45sKJd+aIPw8dI6/B0rZvMxgX9mQz8Xfn3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crZZITB+S4D5G/thbPkjN05/bzp7DXe2tx0tRW/69sfrx7b+1TXhaFJzg6ODMXu7gvxJBD8KS1Q3j3B8kp3BUCMG2kOpgTvjZH0DbW3R282SCoZ/8b9fvQ5bsRHFf0KwC8rblg9lygrCojVyJr1Byz9qEYQRwLfvm8OGA03RC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H+5iwdpX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H+5iwdpX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723A01756;
	Tue,  1 Sep 2026 08:13:52 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799573F8C6;
	Tue,  1 Sep 2026 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788275636; bh=nK6FlW3g45sKJd+aIPw8dI6/B0rZvMxgX9mQz8Xfn3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+5iwdpXKE4XGF6oml+V8KINgoiIOTA0gGYvkNv480Kxz2sYmXaEkDplZlH2zNGpr
	 RLvw1oLRdESqbsuKP+J87oJljXJ3jByvuFKCoSuqzFqZLgESfiMXpQOjwDN10x5/WO
	 ZoJuX0clb4c5zpgPHzG1VKsrkZVNf0z3+OPivamU=
Date: Tue, 1 Sep 2026 20:43:52 +0530
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
Message-ID: <apbrsPTPPfo9Mi6R@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <apbo8Yr5C-6c0XXr@a079125.arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbo8Yr5C-6c0XXr@a079125.arm.com>

Kindly please ignore this, sent the reply again by mistake.

On Tue, Sep 01, 2026 at 08:32:13PM +0530, Linu Cherian wrote:
> Hi Kevin,
> 
> On Tue, Aug 18, 2026 at 03:08:42PM +0100, Kevin Brodsky wrote:
> > [Sending during the merge window in case reviewers have spare
> > cycles; I'm not aiming to have this series merged in v7.3.]
> > 
> > This is a proposal to leverage protection keys (pkeys) to harden
> > critical kernel data, by making it mostly read-only. The series includes
> > a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
> > as well as a page table hardening feature based on that framework,
> > "kpkeys_hardened_pgtables". Both are implemented on arm64 as a proof of
> > concept, but they are designed to be compatible with any architecture
> > that supports pkeys.
> > 
> > The proposed approach is a typical use of pkeys: the data to protect is
> > mapped with a given pkey P, and the pkey register is initially
> > configured to grant read-only access to P. Where the protected data
> > needs to be written to, the pkey register is temporarily switched to
> > grant write access to P on the current CPU.
> > 
> > The key fact this approach relies on is that the target data is
> > only written to via a limited and well-defined API. This makes it
> > possible to explicitly switch the pkey register where needed, without
> > introducing excessively invasive changes, and only for a small amount of
> > trusted code.
> > 
> > Page tables are chosen as an initial target because of their especially
> > critical nature - a single write may result in arbitrary pages becoming
> > accessible to any context (including userspace). In order to keep the
> > series digestible for reviewers, this version focuses on functionality
> > rather than performance, making it most suitable as a debug feature. The
> > key trade-off is the requirement to PTE-map the linear map - see section
> > "Protected page table allocation" for details.
> > 
> > This series has similarities with the "PKS write protected page tables"
> > series posted by Rick Edgecombe a few years ago [1] but it is not
> > specific to x86/PKS - the approach is meant to be generic.
> > 
> > This proposal (as of RFC v5) was presented at Linux Security Summit
> > Europe 2025 [2].
> > 
> > [Table of contents]
> > 
> > * kpkeys
> >   - pkey register management
> > 
> > * kpkeys_hardened_pgtables
> >   - Protected page table allocation
> >   - kpkeys context switching
> >   - Performance
> >   - Limitations
> > 
> > * This series
> >   - Branches
> > 
> > * Threat model
> > 
> > * Further use-cases
> > 
> > * Open questions
> > 
> > kpkeys
> > ======
> > 
> > The use of pkeys involves two separate mechanisms: assigning a pkey to
> > pages, and defining the pkeys -> permissions mapping via the pkey
> > register. This is implemented through the following interface:
> > 
> > - Pages are assigned a pkey in the linear map using set_memory_pkey().
> >   This is sufficient for this series, but it is also plausible for
> >   higher-level allocators to support marking allocations with a given
> >   pkey.
> > 
> > - The pkey register is configured based on a *kpkeys context*. kpkeys
> >   contexts are represented as simple integers that correspond to a given
> >   configuration, for instance:
> > 
> >   KPKEYS_CTX_DEFAULT:
> >         RW access to KPKEYS_PKEY_DEFAULT
> >         RO access to any other KPKEYS_PKEY_*
> > 
> >   KPKEYS_CTX_<FEAT>:
> >         RW access to KPKEYS_PKEY_DEFAULT
> >         RW access to KPKEYS_PKEY_<FEAT>
> >         RO access to any other KPKEYS_PKEY_*
> > 
> >   Only pkeys that are managed by the kpkeys framework are impacted;
> >   permissions for other pkeys are left unchanged (this allows for other
> >   schemes using pkeys to be used in parallel, and arch-specific use of
> >   certain pkeys).
> 
> - Adding some basic details on what a scheme and context is quite helpful.
> 
> - Giving some hints (may be an example) on how multiple schemes and multiple contexts
>   play together would be quite helpful.
> 
> May be adding a documentation covering these aspects would be helpful as
> well.
> 
> My understanding is that pkeys are being partitioned across different
> contexts. But then the introduction of the term "scheme" looks bit confusing to me.
> 
> > 
> >   The current kpkeys context is changed by calling
> >   kpkeys_enter_context(), which will set the pkey register
> >   accordingly and return the original state. A
> 
> ..snip
> 
> > Open questions
> > ==============
> > 
> > A few aspects in this RFC that are debatable and/or worth discussing:
> > 
> > - There is currently no restriction on how kpkeys contexts map to pkeys
> >   permissions. A typical approach is to allocate one pkey per context and
> >   make it writable in that context only. As the number of contexts
> 
> Probably to avoid the assumption, may be we can we have something like
> below
> 
> For a pkey P, we could define
> PKEY_P_PERM_CTXT_OTHERS  //permission for pkey p in other contexts
> PKEY_P_PERM_CTXT_SELF    //permission for pkey p in self context
> 
> With the assumption of one pkey mapped for every context,
> the permission for the default context would look something like,
> 
> PKEY_DEF_PERM_CTXT_SELF << PKEY_DEF_PKEY_SHIFT |
> PKEY_CT0_PERM_CTXT_OTHERS << PKEY_CT0_PKEY_SHIFT |
> PKEY_CT1_PERM_CTXT_OTHERS << PKEY_CT1_PKEY_SHIFT |
> ...(for all valid contexts)
> 
> where,
> Permission key, PKEY_DEF is associated with context DEFAULT,
> Permission key, PKEY_CT0 is associated with context CT0,
> Permission key, PKEY_CT1 is associated with context CT1
> 
> 
> >   increases, we may however run out of pkeys, especially on arm64 (just
> >   8 pkeys with POE). Depending on the use-cases, it may be acceptable to
> >   use the same pkey for the data associated to multiple contexts.
> > 
> 
> Lets say two contexts A and B, use the same pkey P as their permission matches.
> But then, when we enter context A, permission for pkey P gets
> relaxed, then that would relax permission for pages associated with
> context B as well which is unintended ?
> 
> As the hardware supports 16 pkeys, should we consider removing the limit
> of 8 pkeys so that we can have unique pkeys for each context ?
> 
> --
> Linu Cherian
> 
