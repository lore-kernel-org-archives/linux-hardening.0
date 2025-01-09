Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12B1FECB1;
	Thu,  9 Jan 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457155; cv=none; b=ZbWHnYLg3BnsYFRHrBqD5pch4Y0SlvZN3pK+EuhVmbnr0J0eAK6F214Z649l5RseAnB88Q84VTSmE+LiOBE14bwRRqVUgfAOnzTUhLM6PoUdggTIGJfHhT/WaA/gX0mPVg00H8V+YkWtD472kw8G3F8Hj8AKGLyI74VzK/afIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457155; c=relaxed/simple;
	bh=2W+dUNKkKMMQ8zFhR4t08D9bDWzND+JlcWiDdE8D5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX1Y0jNe4lHhtOoagp/TNqzrglIpiP7otF+uSgoPYpeA/R+iUzaH6lWJpyFYmU3eIFlY+Fz4v9rg5HqnjH1YPvXLryLp5Bq2OWuVSJGLM/JVY+a9Xxz5jejxnbtCoOVxOnUjH2qO/6sb9NLz+qhj1c/JzMHY/0dLaIX82Lg0bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coy+s83S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coy+s83S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E28C4CED2;
	Thu,  9 Jan 2025 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457154;
	bh=2W+dUNKkKMMQ8zFhR4t08D9bDWzND+JlcWiDdE8D5T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coy+s83SIDwxqghqyaNzIEQv4iV5UouNhq3x6DZfx1U73sPJuXyqSvfrkqtufS5Zr
	 Rvs20yYxgBI2Ed/LNFSemy7qdoGdLovgirnDH9hPvSf1EclVgIUuRD1oML3Ac6DdcE
	 iF9PYNF1/AjlnPqUkk5fbfwl3kWmlDmuzrH/jzMmeOdhOrWso8IKVXL5Jq+g3WP8Ik
	 9kS98NFcjdtzc/Mg90saNJGLocSSLvz+6Bsm0GZ5TApN6nWDOjnJZ09eiBQ6kVV908
	 wV4pRlIvsRRlvTMT/kklGZhJgmY5PuZAjwlM01kd2p0I+NH5DahglJdIcdVhb2A2v+
	 0cFN64guu0AsQ==
Date: Thu, 9 Jan 2025 13:12:30 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [linus:master] [fortify]  239d87327d:  vm-scalability.throughput
 17.3% improvement
Message-ID: <202501091256.4F3B2E8@keescook>
References: <202501091405.a1fcb1ed-lkp@intel.com>
 <202501090850.F23EBEBC5B@keescook>
 <202501091236.E3EDA2188@keescook>
 <pep7tppcmd77ejaa47bhajc3uoy2q2n3cladgc4btdri4mth65@dqjulq2hx4l2>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pep7tppcmd77ejaa47bhajc3uoy2q2n3cladgc4btdri4mth65@dqjulq2hx4l2>

On Thu, Jan 09, 2025 at 09:52:31PM +0100, Mateusz Guzik wrote:
> On Thu, Jan 09, 2025 at 12:38:04PM -0800, Kees Cook wrote:
> > On Thu, Jan 09, 2025 at 08:51:44AM -0800, Kees Cook wrote:
> > > On Thu, Jan 09, 2025 at 02:57:58PM +0800, kernel test robot wrote:
> > > > kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:
> > > > 
> > > > commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Well that is unexpected. There should be no binary output difference
> > > with that patch. I will investigate...
> > 
> > It looks like hiding the size value from GCC has the side-effect of
> > breaking memcpy inlining in many places. I would expect this to make
> > things _slower_, though. O_o

I think it's disabling value-range-based inlining, I'm trying to
construct some tests...

> This depends on what was emitted in place and what CPU is executing it.
> 
> Notably if gcc elected to emit rep movs{q,b}, the CPU at hand does
> not have FSRM and the size is low enough, then such code can indeed be
> slower than suffering a call to memcpy (which does not issue rep mov).
> 
> I had seen gcc go to great pains to align a buffer for rep movsq even
> when it was guaranteed to not be necessary for example.
> 
> Can you disasm an example affected spot?

I tried to find the most self-contained example I could, and I ended up
with:

static void ipv6_rpl_addr_decompress(struct in6_addr *dst,
                                     const struct in6_addr *daddr,
                                     const void *post, unsigned char pfx)
{
        memcpy(dst, daddr, pfx);
        memcpy(&dst->s6_addr[pfx], post, IPV6_PFXTAIL_LEN(pfx));
}

Before 239d87327dcd ("fortify: Hide run-time copy size from value range
tracking"), the assembler is:

ffffffff8209f0e0 <ipv6_rpl_addr_decompress>:
ffffffff8209f0e0:       e8 5b 62 fe fe          call   ffffffff81085340 <__fentry__>
ffffffff8209f0e5:       0f b6 c1                movzbl %cl,%eax
ffffffff8209f0e8:       49 89 d0                mov    %rdx,%r8
ffffffff8209f0eb:       83 f8 08                cmp    $0x8,%eax
ffffffff8209f0ee:       73 24                   jae    ffffffff8209f114 <ipv6_rpl_addr_decompress+0x34>
ffffffff8209f0f0:       a8 04                   test   $0x4,%al
ffffffff8209f0f2:       75 64                   jne    ffffffff8209f158 <ipv6_rpl_addr_decompress+0x78>
ffffffff8209f0f4:       85 c0                   test   %eax,%eax
ffffffff8209f0f6:       74 09                   je     ffffffff8209f101 <ipv6_rpl_addr_decompress+0x21>
ffffffff8209f0f8:       0f b6 16                movzbl (%rsi),%edx
ffffffff8209f0fb:       88 17                   mov    %dl,(%rdi)
ffffffff8209f0fd:       a8 02                   test   $0x2,%al
ffffffff8209f0ff:       75 65                   jne    ffffffff8209f166 <ipv6_rpl_addr_decompress+0x86>
ffffffff8209f101:       ba 10 00 00 00          mov    $0x10,%edx
ffffffff8209f106:       48 01 c7                add    %rax,%rdi
ffffffff8209f109:       4c 89 c6                mov    %r8,%rsi
ffffffff8209f10c:       48 29 c2                sub    %rax,%rdx
ffffffff8209f10f:       e9 bc 33 21 00          jmp    ffffffff822b24d0 <__memcpy>
ffffffff8209f114:       48 8b 16                mov    (%rsi),%rdx
ffffffff8209f117:       4c 8d 4f 08             lea    0x8(%rdi),%r9
ffffffff8209f11b:       49 83 e1 f8             and    $0xfffffffffffffff8,%r9
ffffffff8209f11f:       48 89 17                mov    %rdx,(%rdi)
ffffffff8209f122:       48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
ffffffff8209f127:       48 89 54 07 f8          mov    %rdx,-0x8(%rdi,%rax,1)
ffffffff8209f12c:       48 89 fa                mov    %rdi,%rdx
ffffffff8209f12f:       4c 29 ca                sub    %r9,%rdx
ffffffff8209f132:       48 29 d6                sub    %rdx,%rsi
ffffffff8209f135:       01 c2                   add    %eax,%edx
ffffffff8209f137:       83 e2 f8                and    $0xfffffff8,%edx
ffffffff8209f13a:       83 fa 08                cmp    $0x8,%edx
ffffffff8209f13d:       72 c2                   jb     ffffffff8209f101 <ipv6_rpl_addr_decompress+0x21>
ffffffff8209f13f:       83 e2 f8                and    $0xfffffff8,%edx
ffffffff8209f142:       31 c9                   xor    %ecx,%ecx
ffffffff8209f144:       41 89 ca                mov    %ecx,%r10d
ffffffff8209f147:       83 c1 08                add    $0x8,%ecx
ffffffff8209f14a:       4e 8b 1c 16             mov    (%rsi,%r10,1),%r11
ffffffff8209f14e:       4f 89 1c 11             mov    %r11,(%r9,%r10,1)
ffffffff8209f152:       39 d1                   cmp    %edx,%ecx
ffffffff8209f154:       72 ee                   jb     ffffffff8209f144 <ipv6_rpl_addr_decompress+0x64>
ffffffff8209f156:       eb a9                   jmp    ffffffff8209f101 <ipv6_rpl_addr_decompress+0x21>
ffffffff8209f158:       8b 16                   mov    (%rsi),%edx
ffffffff8209f15a:       89 17                   mov    %edx,(%rdi)
ffffffff8209f15c:       8b 54 06 fc             mov    -0x4(%rsi,%rax,1),%edx
ffffffff8209f160:       89 54 07 fc             mov    %edx,-0x4(%rdi,%rax,1)
ffffffff8209f164:       eb 9b                   jmp    ffffffff8209f101 <ipv6_rpl_addr_decompress+0x21>
ffffffff8209f166:       0f b7 54 06 fe          movzwl -0x2(%rsi,%rax,1),%edx
ffffffff8209f16b:       66 89 54 07 fe          mov    %dx,-0x2(%rdi,%rax,1)
ffffffff8209f170:       eb 8f                   jmp    ffffffff8209f101 <ipv6_rpl_addr_decompress+0x21>

With the size hidden, it becomes:

ffffffff82096260 <ipv6_rpl_addr_decompress>:
ffffffff82096260:       e8 db e0 fe fe          call   ffffffff81084340 <__fentry__>
ffffffff82096265:       55                      push   %rbp
ffffffff82096266:       0f b6 e9                movzbl %cl,%ebp
ffffffff82096269:       53                      push   %rbx
ffffffff8209626a:       48 89 d3                mov    %rdx,%rbx
ffffffff8209626d:       48 89 ea                mov    %rbp,%rdx
ffffffff82096270:       e8 9b 0a 21 00          call   ffffffff822a6d10 <__memcpy>
ffffffff82096275:       ba 10 00 00 00          mov    $0x10,%edx
ffffffff8209627a:       48 89 de                mov    %rbx,%rsi
ffffffff8209627d:       5b                      pop    %rbx
ffffffff8209627e:       48 89 c7                mov    %rax,%rdi
ffffffff82096281:       48 29 ea                sub    %rbp,%rdx
ffffffff82096284:       48 01 ef                add    %rbp,%rdi
ffffffff82096287:       5d                      pop    %rbp
ffffffff82096288:       e9 83 0a 21 00          jmp    ffffffff822a6d10 <__memcpy>
ffffffff8209628d:       0f 1f 00                nopl   (%rax)

In the former, it looks like it is calculating how many 8, 4, and single
byte copy loops to perform for the first memcpy, since it knows the value
range must be [0..255]. In both cases the second memcpy is tail-called.

> Gcc has a bunch of magic switches to tell it what to emit in line, the
> thing to do is to convince it to roll with a bunch of mov (not rep mov)
> for sizes small enough(tm). What constitutes small enough depends on the
> uarch.

I found -mmemcpy-strategy:
https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#index-mmemcpy-strategy_003dstrategy

But I don't see where to find the algs, and it seems like the above asm
is being produced when GCC thinks a value is in a certain range (rather
than compile-time known), which would make sense as far as what the
commit did: removed visibility into value ranges.

-Kees

-- 
Kees Cook
