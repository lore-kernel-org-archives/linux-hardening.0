Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE28BEE
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138676; cv=none; b=RCaSAIgtrM3fSMnu9OtV6nFDzfDMaIGv0N1v4MsSM7GQvQ9MDHIs/x8pFm2ZE5xqRl5A6vG2W/cXT1E8s/r60H83AaGpXND4fW7VXYaCNljfK0LmgrqolmKS4LfibcNJk1kR4jOGeyTKKl2rppgdK8TlXQBzRZXSRHWmi2sGlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138676; c=relaxed/simple;
	bh=uLwMffjF4wzc/Y3kyxuCYBVTSWT4ervND3M++fZ2PnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyajs2h1+1fVr4cklmQuH7iArQ6IaGRdNELwW1YjfYGzsrQqUc5fUGl81EybcVdHKNXWpiya8GinRhFxIN+H1fC5H3fMbdJ9jR2IbIQwzcFGoRgQheXHvvEM34fspJLkFAj9i4AxesBVS7RCmPqzi2UzIfVlFYYyIiWwSHrYXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYtGT/E7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYtGT/E7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC61FC4CEE7;
	Wed, 17 Sep 2025 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758138675;
	bh=uLwMffjF4wzc/Y3kyxuCYBVTSWT4ervND3M++fZ2PnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYtGT/E7XKfdpQl1v8DqHeqH60GuQUZsbiAoxnxmsYFKRLPhKYr5Fgo2Y6cb/D9Vl
	 uxvNsarvdswTONBnLxOSsWkELMNxPYhxI3PSkpz7jQ5KqssFQq63faRx6kdJuvVuCz
	 +aoxAzNzf8ZF/Utll9kOsEkQlSFKrURC/67nL07Qy7TNw5QJQjpsDIHc9UAMSqUHCn
	 0G9lpyv64Bjtwsj829bPzknecJcFibVvnskvg8pp+N1ORu/ESIl+Bn8LFN0g69/uQ4
	 9uf58ddUpFUC7PgEBEhM3OHzpB5S1O0JlWp1p6eQY75T4F6uK2pzyPsBszlQOC5aob
	 /8S+BxuGJHwoQ==
Date: Wed, 17 Sep 2025 12:51:15 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 7/7] kcfi: Add regression test suite
Message-ID: <202509171249.0ED683BBA@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-7-kees@kernel.org>
 <CALvbMcBv-vbJahUH_j+vxhsNnydbO7__RP1S2tg93HgUiTDv+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcBv-vbJahUH_j+vxhsNnydbO7__RP1S2tg93HgUiTDv+w@mail.gmail.com>

On Sat, Sep 13, 2025 at 04:51:21PM -0700, Andrew Pinski wrote:
> On Sat, Sep 13, 2025 at 4:36 PM Kees Cook <kees@kernel.org> wrote:
> > +/* Should have KCFI instrumentation for all indirect calls.  */
> > +
> > +/* x86_64: Complete KCFI check sequence should be present.  */
> > +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r1[01]d\n\taddl\t[^,]+, %r1[01]d\n\tje\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tud2} { target x86_64-*-* } } } */
> > +
> > +/* AArch64: Complete KCFI check sequence should be present.  */
> > +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-[0-9]+\]\n\tmov\tw17, #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t(\.Lkcfi_call[0-9]+)\n\.Lkcfi_trap[0-9]+:\n\tbrk\t#[0-9]+\n\1:\n\tblr\tx[0-9]+} { target aarch64*-*-* } } } */
> > +
> > +/* ARM 32-bit: Complete KCFI check sequence should be present with stack
> > +   spilling.  */
> > +/* { dg-final { scan-assembler {push\t\{r0, r1\}\n\tldr\tr0, \[r[0-9]+, #-[0-9]+\]\n\tmovw\tr1, #[0-9]+\n\tmovt\tr1, #[0-9]+\n\tcmp\tr0, r1\n\tpop\t\{r0, r1\}\n\tbeq\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tudf\t#[0-9]+\n\.Lkcfi_call[0-9]+:\n\tblx\tr[0-9]+} { target arm32 } } } */
> > +
> > +/* RISC-V: Complete KCFI check sequence should be present.  */
> > +/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tebreak} { target riscv*-*-* } } } */
> > +
> > +/* Should have trap section with entries.  */
> > +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
> > +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
> > +
> > +/* AArch64 should NOT have trap section (uses brk immediate instead) */
> > +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
> > +
> > +/* ARM 32-bit should NOT have trap section (uses udf immediate instead) */
> > +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target arm32 } } } */
> 
> 
> I think it would be better to use check-function-bodies here rather
> than scan-assembler for the sequences. Maybe each target should have
> its own testcase rather than putting it all in one source.
> Plus I think the target testcase should be part of the target patch
> rather than its own patch to make it easier to review both things
> together. Because while I was reviewing the aarch64 part I was
> thinking where are the testcases for the aarch64 specific changes.

Ah yeah, that works. I spent some time scratching my head over how to
have it not drop labels, but I've gotten a bunch of these converted now.
Some constructs I left, especially "scan-assembler-not" tests for v4.
It's significantly more readable now! Thanks! :)

-Kees

-- 
Kees Cook
