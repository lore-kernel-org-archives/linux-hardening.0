Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD71B94F;
	Fri, 28 Jun 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597917; cv=none; b=Whnwlk3ZJwvvehtUOFMyqPBCXG51lweyk5UUiTC+zrqjGlEhXQxZSoftTPEOedStwRg5bzC1IwMUjZJQ0ECOOFFYhkEnJn7JbHnnNGO15DK+l5QaAt6tjjW9EFf96tkIE4yMgPlm3Wvye7G/Y6euqSqmxxe/rP7+8b3WFZQtkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597917; c=relaxed/simple;
	bh=mx/8AeXGv5la/SJKW47Hnq1sxQpaD4PV9moJu0IkY9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOF+QuKIWHYUk8QVd8LZeLMtBBdvZfqwXLyMD70SOhgxOPzmzYg2PT2ER2tLWmoipc8Bg/Kts3n94ojGYNIgv0vXXhyiMuP0QojYSSxB/a2ZL2TCOliwhoR6AemxJvajt0anptq7YSC8W1DZZbh/YbS4im8zPnVfLpyNfE1ZYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F5de3Ybp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5de3Ybp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dSrkPPHv57iagKOJvURV1RqHc0rOI3RdmSfKvjD0uAk=; b=F5de3YbpRIjcEh2iBGH8wgpDfZ
	9mJQ+NFg4OmtDICFKWKVp9789hpyMVAulmI7ZeXi5WjABsnCTs1kdIh/wyUtgaFv2uO/uLYPyWqL6
	+qgFJU8q9ahyVE3H46jvDykISEduUuCXRXhSBl0ZofhENpyKTTcbN3VRX+SgXAPdNnobWp1+J5Ja9
	Dnv6I2Fzg2J7qGubn2gERdzsSilfhWwe41YyXrbEMYjNrXuQQLcVyv1e3pUHkVvq5ANoN/Y5lZyl9
	8ea/RsWZXZKIF95au3hDMh5hADW+vGUSFO1oCpCnzfsTtwUBN0odqN3Lkkruc9+7A/yzlJWzJwgb0
	20s6/0uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNFxj-000000094Vb-431B;
	Fri, 28 Jun 2024 18:04:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28A44300400; Fri, 28 Jun 2024 20:04:41 +0200 (CEST)
Date: Fri, 28 Jun 2024 20:04:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] x86/traps: Enable UBSAN traps on x86
Message-ID: <20240628180441.GJ31592@noisy.programming.kicks-ass.net>
References: <20240625032509.4155839-1-gatlin.newhouse@gmail.com>
 <20240625093719.GW31592@noisy.programming.kicks-ass.net>
 <202406261205.E2435C68@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406261205.E2435C68@keescook>

On Wed, Jun 26, 2024 at 12:07:52PM -0700, Kees Cook wrote:
> On Tue, Jun 25, 2024 at 11:37:19AM +0200, Peter Zijlstra wrote:
> > Also, wouldn't it be saner to write this something like:
> > 
> > __always_inline int decode_bug(unsigned long addr, u32 *imm)
> > {
> > 	u8 v;
> > 
> > 	if (addr < TASK_SIZE)
> > 		return BUG_NONE;
> > 
> > 	v = *(u8 *)(addr++);
> > 	if (v == 0x67)
> > 		v = *(u8 *)(addr++);
> > 	if (v != 0x0f)
> > 		return BUG_NONE;
> > 	v = *(u8 *)(addr++);
> > 	if (v == 0x0b)
> > 		return BUG_UD2;
> > 	if (v != 0xb9)
> > 		return BUG_NONE;
> > 

Looks like I lost:

	v = *(u8 *)(addr++);
> > 	if (X86_MODRM_RM(v) == 4)
> > 		addr++; /* consume SiB */
> > 
> > 	*imm = 0;
> > 	if (X86_MODRM_MOD(v) == 1)
> > 		*imm = *(u8 *)addr;
> > 	if (X86_MORRM_MOD(v) == 2)
> > 		*imm = *(u32 *)addr;
> > 
> > 	// WARN on MOD(v)==3 ??
> > 
> > 	return BUG_UD1;
> > }
> 
> Thanks for the example! (I think it should use macros instead of
> open-coded "0x67", "0x0f", etc, but yeah.)

Yeah, I didn't feel like hunting down pre-existing defines for all of
them, but yeah.

> > Why does the thing emit the asop prefix at all through? afaict it
> > doesn't affect the immediate you want to get at. And if it does this
> > prefix, should we worry about other prefixes? Ideally we'd not accept
> > any prefixes.
> 
> AFAICT it's because it's a small immediate? For an x86_64 build, this is
> how Clang is generating the UD1.

So the disp8 immediate comes from MOD==1, MOD==2 has a disp32. What the
prefix does is change the size of the memory being referenced from 32bit
to 16bit iirc, but since UD does not actually perform the load, this is
entirely superfluous afaict.

It might be good to figure out *why* clang thinks it needs this.

A REX prefix is far more likely to be useful (upper 8 destination
register for instance).

Anyway, it seems to basically boil down to needing a fairly complete
instruction decoder without being able the use the normal one :/
