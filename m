Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52186333741
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160904; cv=none; b=FybGOk9WANRJ5WlFbn9fdsWT3UOuhVW0EZwDMjvEwotYEnVXJ87M4LehOQMfRSIt3HRRFgi7AtQ1I/V5hPePzVzHs1EAktCc1Nu7MPsRAIprgxwr2Zntt/gwAbYqdHzc1nyHYE+uoDEUorTADE+XAzQb+VsUAAofApBszkIXNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160904; c=relaxed/simple;
	bh=fLT2EnEOZfpm8EzKAKOlUT2BhTU3S2q1hsrHd6TCiNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjQ4guI6kh8pjb0Ce9nL42IwniKVoGW7vz8pk5pPpVmIgJml42xcNIqMrHusF24ufvB/syuChc89WglR4x/TbOUWHCZqZ69qmImwOo9n5s3UcuvKyTSTFVtpWUmBSt9DyROmR9FkYxZ20mJSMsbk0C0Dp9ORcsE2Ax2kcZkshdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spdOELfR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spdOELfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF5C4CEE7;
	Wed, 22 Oct 2025 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160903;
	bh=fLT2EnEOZfpm8EzKAKOlUT2BhTU3S2q1hsrHd6TCiNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spdOELfRGRiXXA8ryQbd1NfJOTcwr1XQ4EOc6vP7ss6TjlhVifrYqAgIDPth/qAy1
	 4CLPtv0BwjObXFYSv7WUROG1OS/kAaET9M5xvaheTPhpgzqiVjICo4X4ed7zOfjSdn
	 r9wjCaTUf0RMzwNgTpQepdYcDeWbz7fQTHbf/9tmrsQ7Iu2DahLexhAS1F6Kca99Us
	 QKU6jTozc8wKDvB0rCCq0AaZYGoOEvrXULAHEBwTxr3YDs9bE7VikuORwlwIh9A09C
	 teDjlWnslI6PruuzLG50UlEWcFsC+HdHF0OrsQl7sf3eLmTZQfXshKTCE1NTzeRyS/
	 puaefEeQDpJTg==
Date: Wed, 22 Oct 2025 12:21:43 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v5 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202510221216.EA5EBB1@keescook>
References: <20251022181345.do.256-kees@kernel.org>
 <20251022182243.72085-5-kees@kernel.org>
 <CALvbMcA-MwhBd4y0+im5+xw8_sw3ut68fudwLoY6-nX5gmh0WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcA-MwhBd4y0+im5+xw8_sw3ut68fudwLoY6-nX5gmh0WA@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:14:32PM -0700, Andrew Pinski wrote:
> On Wed, Oct 22, 2025 at 11:27 AM Kees Cook <kees@kernel.org> wrote:
> >
> > Implement AArch64-specific KCFI backend.
> >
> > - Trap debugging through ESR (Exception Syndrome Register) encoding
> >   in BRK instruction immediate values.
> >
> > - Scratch register allocation using w16/w17 (x16/x17) following
> >   AArch64 procedure call standard for intra-procedure-call registers,
> >   which already makes x16/x17 available through existing clobbers.
> >
> > - Incompatible with -ffixed-x16 or -ffixed-x17.
> 
> Can you explain why?
> The documentation for `-ffixed-` says this:
> ```
> -ffixed-reg
> Treat the register named reg as a fixed register; generated code
> should never refer to it (except perhaps as a stack pointer, frame
> pointer or in some other fixed role).
> ```
> In this case it is a `in some other fixed role`. Or is the problem you
> are using the allocator to figure out which is free?
> In the case of indirect tail calls, x17/x16 is always used for the
> pointer (since r9-5291-g901e66e03e1cd8).
> Which is the register class TAILCALL_ADDR_REGS.
> I think it is compatible with doing -ffixed-x17 (or -ffixed-x16)
> because it is a "fixed role" at this point.
> Though If both are supplied GCC will fall over anyways (will file a
> bug about that in a few minutes).

This was done based on feedback from the riscv patch in v2:
https://lore.kernel.org/linux-hardening/dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com/

Jeff's interpretation of -ffixed-reg seemed to imply "GCC should not touch
this register", which seemed sensible to me from the perspective of the
"generated code should never refer to it" bit. How that interacts with
the "except perhaps as ... some other fixed role" is totally unclear to
me.

Shall I drop all of the -ffixed-reg logic for all backends?

-Kees

-- 
Kees Cook
