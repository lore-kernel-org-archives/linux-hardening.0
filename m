Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD61EB5CE
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684314; cv=none; b=NsiaBuSUL839c5FcCwCsexPkD2VIJtAhRQS4d+rNg7AzzdF3bEOOOlWusS7Gz01oxmSJr5erXsDoR7zJ1H2IrVuhV8Ly59tlAXEsNFrw3xSZSmCo1AMkqyZHGir2UVuwUFnOuD94fyyC85rESvTsnRQw1hW8WIssIly+4ir3XmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684314; c=relaxed/simple;
	bh=uIhWj+LRHpDIZtq6R0C4+7rQLH17LX0l+LTrExo9ZH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmljpORdSz6JTi5fyvlKU+o9sfkLAR5iu4vdabiXkTE/NnZjeJS2uA5yXbYy0Fz6b0oPBWSME4bv7xDEgmTOqvtWIMjKEHY/IB3M4wWcrGr08xX4PI03w6+G+uAhqFclUn580pDd1d9eMyNdIVgwRFE13uGjMd3MyAPk6ydtoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktuMamIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktuMamIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29136C4CEF1;
	Fri, 21 Nov 2025 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763684314;
	bh=uIhWj+LRHpDIZtq6R0C4+7rQLH17LX0l+LTrExo9ZH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktuMamIXihGiL/1rdxiMcllMYJBwVwbzgkDUad9/FXhoNyjwhOqyvXn7vHWkiDNu1
	 f0/AzuEmlXwXQ0HWwue16M0NiBv93aTo0JJTNSKX/giirzFLtZ/OO+c5SM00lDoKYI
	 tQdydb/xPGaKpqEZXYEdtpZdyqPKSfQHhUj3RHRI22MXtKuqS4zeFsVeLOt02glrIE
	 ubTfDKZ8hCCfr5A97ETJqIBtHeKvu0pY+SlwzZodWSPGeUGbTXX+LdY2UkrhF1l6y6
	 Ob2eeCGQIiXAyyjuFXLNoX4JLZn9FiNcM+7PHAaSE6fhNlS3L1Uzn+F/NWnwKLDnjZ
	 xs5WHCjp7JJmA==
Date: Thu, 20 Nov 2025 16:18:33 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202511201606.079192C85@keescook>
References: <20251120222105.us.687-kees@kernel.org>
 <20251120222113.3318463-5-kees@kernel.org>
 <CALvbMcCx+N=P+AkpTbwQBanDTRWi+VsouoxyMLPEfOfEmNZaow@mail.gmail.com>
 <CALvbMcBmEi8bv2dAo2nj=6hTQSaH_-ym2VbAkx__j6XQ+w6eeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcBmEi8bv2dAo2nj=6hTQSaH_-ym2VbAkx__j6XQ+w6eeA@mail.gmail.com>

On Thu, Nov 20, 2025 at 03:10:41PM -0800, Andrew Pinski wrote:
> On Thu, Nov 20, 2025 at 2:57 PM Andrew Pinski
> <andrew.pinski@oss.qualcomm.com> wrote:
> > Also I am still trying to figure out and understand the interaction
> > between x16 and x17 in some cases.
> > Because I thought indirect calls/jumps will be using x16/x17 for those
> > to support BTI.
> 
> Oh yes:
> (define_register_constraint "Ucr"
>     "aarch64_harden_sls_blr_p () ? STUB_REGS : GENERAL_REGS"
>   "@internal Registers to be used for an indirect call.
>    This is usually the general registers, but when we are hardening against
>    Straight Line Speculation we disallow x16, x17, and x30 so we can use
>    indirection stubs.  These indirection stubs cannot use the above registers
>    since they will be reached by a BL that may have to go through a linker
>    veneer.")
> 
> But you don't change Ucr so in theory x16/x17 could be used for call_value_insn.
> (I can't get that one using x16/x17 right now).
> 
> Oh and sibcall_insn uses Ucs which is defined as:
> (define_register_constraint "Ucs" "TAILCALL_ADDR_REGS"
>   "@internal Registers suitable for an indirect tail call")
> TAILCALL_ADDR_REGS is a register class which just contains x16/x17.

Hm, I will need to study this more closely. I wonder if both kcfi and sls
hardening end up being self-contained users of the scratch registers? I'll
double check that my kernel test builds have SLS hardening enabled. (And
I'll likely need to add some aarch64-specific sibcall tests with/without
SLS hardening to see the resulting asm.)

> I don't see a testcase for indirect sibcall either.
> 
> ```
> typedef void (*fptr)(void);
> void f(fptr a)
> {
>   a();
> }
> ```
> Is a testcase for the indirect sibcall case.

I did include basic tests for a variety of sibcalls in the patch that
added the general tests; see gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
(though I named it "tail calls"), and the fptr test includes an argument
(the comment is x86-specific, but it should be a valid test for all archs):

+/* Indirect call through function pointer parameter.  */
+int test_param_indirect_call(func_ptr_t handler, int x) {
+    /* This is an indirect call that should be converted to tail call:
+       Without -fno-optimize-sibling-calls should become "jmp *%rdi"
+       With -fno-optimize-sibling-calls should be "call *%rdi"  */
+    return handler(x);
+}

-Kees

-- 
Kees Cook
