Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402F2040BD;
	Mon, 24 Feb 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425104; cv=none; b=Vou+VXcYHdsGp/FsNPoeJhDJMw8Dpz/Fe1bQYG9Itq3B7RDXJ6CzvrtrT+M1DGWq2dYvBK7bgIYAgoFUTud8VACu061gk1f8ECH2BoSCItOsiEaVrKRklkfwDB8kHo6m+AvIQoQGXx4gimOTXUTlaRmEFzcahRVxvAAfgQlgEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425104; c=relaxed/simple;
	bh=fjHcvZgvhTSj5FFdxPdTk8Lrdzdg91sRk6S1mMi4Ecg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Mz71WDJWLYmKmw5pyoHPoQVzVN1XLcGL+ybaPG6VS97lLecIWt6NLvvN2UP2PfH01RVesnUmgaIU4rqWI9AwxCiiLUzqkcTWLvOCOazwejmhvgG7yUMZ60yN0136SErkPWii6a6xUlO436oRWsBNDPdr4SaND1Ww5Ykzq8uXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+Un/Jtp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+Un/Jtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA8C4CED6;
	Mon, 24 Feb 2025 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740425104;
	bh=fjHcvZgvhTSj5FFdxPdTk8Lrdzdg91sRk6S1mMi4Ecg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+Un/Jtp4PMYsu31G/MB+IssTm4ML0IcZHZJuXJZ5gat79fHEjhseokSxoMn37u0U
	 cMPJlHQMu8vpQYUwr0zcFhE6jye6ox9AkoXfGZ3dUjfbfSrD+fJARvD/f+qm8Xlb76
	 a5aYZdqadSKVP4kxOcxwV8hlPfqxbzKQ1sSgyNGydW6Ati8FarqauaHK2JQOQp8aXk
	 zYe0vy9lg4Wmb9q9Y3PfEVrgN3RZYIjySk2LixWgwOQy905Gx8aMN5yprecw3WGPJC
	 /a/X3AgCfNuYpwq5lV/adtEbh+ExsuBrI/1fuQqNEhYH9YHowmOjBpSG0VBv3xVppI
	 75gxhF8ZQzOzQ==
Date: Mon, 24 Feb 2025 11:25:00 -0800
From: Kees Cook <kees@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <202502241123.D398A24@keescook>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>

On Mon, Feb 24, 2025 at 11:10:22AM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 11:03 AM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > > On Mon, Feb 24, 2025 at 10:21 AM Dave Hansen <dave.hansen@intel.com> wrote:
> > > >
> > > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > > +/*
> > > > > + * mseal of userspace process's system mappings.
> > > > > + */
> > > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > > +#else
> > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > > +#endif
> > > >
> > > > This ends up looking pretty wonky in practice:
> > > >
> > > > > +     vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > > +     vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > > >
> > > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> > > > other ones.
> > > >
> > > > Would it really hurt to have
> > > >
> > > >  #ifdef CONFIG_64BIT
> > > >  /* VM is sealed, in vm_flags */
> > > >  #define VM_SEALED       _BITUL(63)
> > > > +#else
> > > > +#define VM_SEALED       VM_NONE
> > > >  #endif
> > > >
> > > > ?
> > > >
> > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > > the build. This is intentional. Any 32-bit code trying to use the
> > > sealing function or the VM_SEALED flag will immediately fail
> > > compilation. This makes it easier to identify incorrect usage.
> > >
> >
> > The reason that two #defines are needed is because you can have mseal
> > enabled while not sealing system mappings, so for this to be clean we
> > need two defines.
> >
> > However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opinion.
> > Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
> >
> How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?
> 
> The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so it
> might take longer for the new reader to understand what it is.

I think to address Dave's concern, it should start with "VM_". We use
"SEAL" already with VM_SEALED, so the "M" in "MSEAL" may be redundant,
and to clarify the system mapping, how avout VM_SEAL_SYSMAP  ? That
capture's, hopefully, Dave, Liam, and your thoughts about the naming?

-- 
Kees Cook
