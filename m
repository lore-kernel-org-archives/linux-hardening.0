Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12291A23B0;
	Fri, 10 Jan 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528300; cv=none; b=VCVVE+PdScRX3DX8A96JF1a05U0mQYGk5SLp8PGPv6bnDaduE5AQXDC/E340w5tQTWpQjQeTJbNiRpovBM+x98XtNzZPxIfdzC1wgLBwITw9OzPyf5AWsQE6ONduAbiP4yqzRBZobQNkJomYisvL89ETsr7hFC/cduyLlEa9YhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528300; c=relaxed/simple;
	bh=9a1nnH9UZlNRsxazdTDqR6DwNW6mqEZRbenFXRwduAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6J2kwEjszb88flh6FyolghsDtzD/eGQHqKmQF7Ryi83H3x4vHmu5k+4z8rlG/nxd8O/fQQVB0wUSLwkF5Qi6rB16tX2xiiYDYMiEjm1uhgtr5EeyJ9JWGkOBkSoLBzpF3rqYdSgL9ai/gmep4+qJHamu9ZJKhs/E6IeuqIwKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igwAKscI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igwAKscI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D7BC4CED6;
	Fri, 10 Jan 2025 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736528300;
	bh=9a1nnH9UZlNRsxazdTDqR6DwNW6mqEZRbenFXRwduAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igwAKscIkK3rPwpM6LwIB7HSekZTV8X4frkknAmoox4DkBPEBTaxyGFpQt1sGXwz7
	 Z5y5R/0y/XLDI3SqzfhnZXfAaNOQJNN+AaUJIC9ofHhjE/pKle8ewZPUFLM2mB7PBd
	 c2K7MrV94wwVT0+ukl3qhflU8g6iO3/X4yEkJ4kBrBJ6uphDx4FGyFFQGoGQZOquot
	 9UwT62vtKeqanfFmvW2EaLmZ4x46gYYkNBDiAV0kU23DFw8FRzFF/4tvab15U1+SEa
	 Q6YT4s29+xR2gIKNcdqlUZ6qxZwjZC6De5CBnwPVFnnN//O0+BBw1x2FZxjE/ESUE/
	 7KKvdgi+GzH1Q==
Date: Fri, 10 Jan 2025 08:58:16 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [linus:master] [fortify] 239d87327d: vm-scalability.throughput
 17.3% improvement
Message-ID: <202501100853.CC2A15B6D@keescook>
References: <202501091405.a1fcb1ed-lkp@intel.com>
 <202501090850.F23EBEBC5B@keescook>
 <202501091236.E3EDA2188@keescook>
 <pep7tppcmd77ejaa47bhajc3uoy2q2n3cladgc4btdri4mth65@dqjulq2hx4l2>
 <202501091256.4F3B2E8@keescook>
 <CAGudoHHymwdk9ChLK=JcPtRD8BSTRDG9B78yOzcRoBGWFzumng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHymwdk9ChLK=JcPtRD8BSTRDG9B78yOzcRoBGWFzumng@mail.gmail.com>

On Thu, Jan 09, 2025 at 11:01:47PM +0100, Mateusz Guzik wrote:
> On Thu, Jan 9, 2025 at 10:12 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 09:52:31PM +0100, Mateusz Guzik wrote:
> > > On Thu, Jan 09, 2025 at 12:38:04PM -0800, Kees Cook wrote:
> > > > On Thu, Jan 09, 2025 at 08:51:44AM -0800, Kees Cook wrote:
> > > > > On Thu, Jan 09, 2025 at 02:57:58PM +0800, kernel test robot wrote:
> > > > > > kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:
> > > > > >
> > > > > > commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > >
> > > > > Well that is unexpected. There should be no binary output difference
> > > > > with that patch. I will investigate...
> > > >
> > > > It looks like hiding the size value from GCC has the side-effect of
> > > > breaking memcpy inlining in many places. I would expect this to make
> > > > things _slower_, though. O_o
> >
> > I think it's disabling value-range-based inlining, I'm trying to
> > construct some tests...
> >
> > > This depends on what was emitted in place and what CPU is executing it.
> > >
> > > Notably if gcc elected to emit rep movs{q,b}, the CPU at hand does
> > > not have FSRM and the size is low enough, then such code can indeed be
> > > slower than suffering a call to memcpy (which does not issue rep mov).
> > >
> > > I had seen gcc go to great pains to align a buffer for rep movsq even
> > > when it was guaranteed to not be necessary for example.
> > >
> > > Can you disasm an example affected spot?
> >
> > I tried to find the most self-contained example I could, and I ended up
> > with:
> >
> > static void ipv6_rpl_addr_decompress(struct in6_addr *dst,
> >                                      const struct in6_addr *daddr,
> >                                      const void *post, unsigned char pfx)
> > {
> >         memcpy(dst, daddr, pfx);
> >         memcpy(&dst->s6_addr[pfx], post, IPV6_PFXTAIL_LEN(pfx));
> > }
> >
> 
> Well I did what I should have from the get go and took the liberty of
> looking at the profile.
> 
>          %stddev     %change         %stddev
>              \          |                \
> [snip]
>       0.00            +6.5        6.54 ± 66%
> perf-profile.calltrace.cycles-pp.memcpy_orig.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev
> 
> Disassembling copy_page_from_iter_atomic *prior* to the change indeed
> reveals rep movsq as I suspected (second to last instruction):
> 
> <+919>:   mov    (%rax),%rdx
> <+922>:   lea    0x8(%rsi),%rdi
> <+926>:   and    $0xfffffffffffffff8,%rdi
> <+930>:   mov    %rdx,(%rsi)
> <+933>:   mov    %r8d,%edx
> <+936>:   mov    -0x8(%rax,%rdx,1),%rcx
> <+941>:   mov    %rcx,-0x8(%rsi,%rdx,1)
> <+946>:   sub    %rdi,%rsi
> <+949>:   mov    %rsi,%rdx
> <+952>:   sub    %rsi,%rax
> <+955>:   lea    (%r8,%rdx,1),%ecx
> <+959>:   mov    %rax,%rsi
> <+962>:   shr    $0x3,%ecx
> <+965>:   rep movsq %ds:(%rsi),%es:(%rdi)
> <+968>:   jmp    0xffffffff819157c5 <copy_page_from_iter_atomic+869>
> 
> With the reported patch this is a call to memcpy.
> 
> This is the guy:
> static __always_inline
> size_t memcpy_from_iter(void *iter_from, size_t progress,
>                         size_t len, void *to, void *priv2)
> {
>         memcpy(to + progress, iter_from, len);
>         return 0;
> }

Thanks for looking at this case!

> 
> I don't know what the specific bench is doing, I'm assuming passed
> values were low enough that the overhead of spinning up rep movsq took
> over.
> 
> gcc should retain the ability to optimize this, except it needs to be
> convinced to not emit rep movsq for variable sizes (and instead call
> memcpy).
> 
> For user memory access there is a bunch of hackery to inline rep mov
> for CPUs where it does not suck for small sizes (see
> rep_movs_alternative). Someone(tm) should port it over to memcpy
> handling as well.
> 
> The expected state would be that for sizes known at compilation time
> it rolls with movs as needed (no rep), otherwise emits the magic rep
> movs/memcpy invocation, except for when it would be tail-called.
> 
> In your ipv6_rpl_addr_decompress example gcc went a little crazy,
> which I mentioned does happen. However, most of the time it is doing a
> good job instead and a now generated call to memcpy should make things
> slower. I presume these spots are merely not being benchmarked here.
> Note that going from inline movs (no rep) to a call to memcpy which
> does movs (again no rep) comes with a "mere" function call overhead,
> which is a different beast than spinning up rep movs on CPUs without
> FSRM.
> 
> That is to say, contrary to the report above, I believe the change is
> in fact a regression which just so happened to make things faster for
> a specific case. The unintended speed up can be achieved without
> regressing anything else by taming the craziness.

How do we best make sense of the perf report? Even in the iter case
above, it looks like a perf improvement?

The fortify change lets GCC still inline compile-time-constant sizes, so
that's good. But it seems to force all the "in a given range" cases into
calls.

> Reading the commit log I don't know what the way out is, perhaps you
> could rope in some gcc folk to ask? Screwing with optimization to not
> see a warning is definitely not the best option.

Yeah, if we do need to revert this, I'm going to need another way to
silence the GCC value-range checker for memcpy...

-- 
Kees Cook
