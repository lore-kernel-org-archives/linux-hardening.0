Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3934BA35
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139310; cv=none; b=MzbUjHbzJx0ie53dV+xG7xxB5Rq9ZIcMbh5qTH/S0AmXslqEiJV9tpHMuufPUtRs24KSDTsuw1E6UzSk+BVFMamyUPwhd3qCn3hdK+R0o5OjvTa0RQY6CXXkyZQTLFSyCZO2oeJU1QTln1rmgKHMpK3QqdYlRJMOasoZesyfGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139310; c=relaxed/simple;
	bh=tf8qcOLWFJ3ub0QBr2nVAZfU6juUV89SaHHYZIcTTsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4r+m9FGjRdd1SPgB1Goq/oFwJCqNK3qEqQ+E22aSZXhgK5F6K+TAenkcl1BnkPZuBCDh2JiACOx9mHxOkYjmj1g4FNO4Xcx7MyLx6scbEv4dY3g56nqc7p5aDBpKzQgSRcm6eDl+CziaZsYtxnh8WTNewIx0K1RoV0KI1pQfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZzyheHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZzyheHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA607C4CEE7;
	Wed, 17 Sep 2025 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758139310;
	bh=tf8qcOLWFJ3ub0QBr2nVAZfU6juUV89SaHHYZIcTTsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZzyheHpebIGOcAMzyLsAwDa6xAcXlc2AipgHNlAsgFUZidn6EjSldf0lu69Dj9oE
	 KaeJWsz3kun4E+Xc7TW9YUS1ym1toVh64Jraeewnu4xrqFavqD9caHITve5s4ayshQ
	 PgE3JIr4tcbiPrivFaHsA0vQ40PhR+LAATR7hXIUD1Z17BZ6dSQ49frMVNEa0bbK7H
	 8SpGOMY+0WoxJlTBmmv9nB6euU0qoKBBfzzTu4tcfRx7M4pIm/Z45rmQh2Tv0k6Wdh
	 kRKxn+0cltADfGjCaSWHoIDlwXgKmoKpp3zOO1qzonhuiN4Fa8yZOycQoeTHK2L2Ei
	 l9BfPpn+y2SwA==
Date: Wed, 17 Sep 2025 13:01:49 -0700
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
Subject: Re: [PATCH v3 4/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202509171251.BA32F4B@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-4-kees@kernel.org>
 <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com>

On Sat, Sep 13, 2025 at 04:43:29PM -0700, Andrew Pinski wrote:
> On Sat, Sep 13, 2025 at 4:28 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Implement AArch64-specific KCFI backend.
> >
> > - Trap debugging through ESR (Exception Syndrome Register) encoding
> >   in BRK instruction immediate values.
> >
> > - Scratch register allocation using w16/w17 (x16/x17) following
> >   AArch64 procedure call standard for intra-procedure-call registers.
> 
> How does this interact with BTI and sibcalls?

BTI and KCFI are complementary. BTI uses passes to insert insns at entry
points and at call-return sites. Like x86's CET "endbr" stuff, KCFI is
providing finer granularity checking for forward-edge.

Sibcalls are handled normally and there's no change to their
construction beyond the KCFI sequence using jmp instead of call.

> Since for indirect
> calls, x17 is already used for the address.
> Why do you need/want to use a fixed register here for the load/compare
> anyways? Why can't you use any free register?

I spent a bunch of time trying to understand the register allocator,
and the bottom line is that the register allocator won't give me a
scratch register if we hit register pressure because it (correctly) sees
that while it can do a spill, it can't do a reload since the insn is a
"CALL". As such, I have to do register lifetime management internally
to the KCFI insn sequence.

For aarch32, I've done this by using ip (r12) by default, but if it's
used as the target register, I switch to r3, and do a spill/reload only
if r3 is used as a call argument. Since r3 is already in the clobber list
due to the call, the register allocator is already doing a spill/reload
of r3 when it is live.

For aarch64 w16 and w17 are universally on the clobber list (even for
sibcalls), so I'm free to use them internally. But "proving" this to
answer your question led me to find where that clobber is happening,
which means I can drop the redundant clobber I was adding in this patch.

> > +  /* Add KCFI clobbers for indirect calls.  */
> > +  if (kcfi_type_rtx)
> > +    {
> > +      rtx usage = CALL_INSN_FUNCTION_USAGE (call_insn);
> > +      /* Add X16 and X17 clobbers for AArch64 KCFI scratch registers.  */
> > +      clobber_reg (&usage, gen_rtx_REG (DImode, 16));
> > +      clobber_reg (&usage, gen_rtx_REG (DImode, 17));
> > +      CALL_INSN_FUNCTION_USAGE (call_insn) = usage;
> > +    }

i.e. I've dropped the above.

> > +
> >    /* Check whether the call requires a change to PSTATE.SM.  We can't
> >       emit the instructions to change PSTATE.SM yet, since they involve
> >       a change in vector length and a change in instruction set, which
> 
> Also how does this interact with SME calls?

Based on what I've been able to find, there's no conflict: the KCFI
typeid is tied strictly to the function type and doesn't take the SME
attributes into account. So this appears to be fine.

-Kees

-- 
Kees Cook
