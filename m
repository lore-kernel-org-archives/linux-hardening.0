Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C543D4E5
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985815; cv=none; b=uPhFsF1t1wwCUe+4ZAzZ8d8Jb+Mxfqxq3VUv/Yx4iusdXZWdsK92HCGFwoAvIgOUqrpijWPtdVW9r7W9nG81vLRKVsmZMzl4sV9PPe1PZWAnPVxUvQSkTv6GdgwdX03315OSmfvcRJIEEgvREDfgJiLUXfvcjXS6K9y7fYFL+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985815; c=relaxed/simple;
	bh=+pQy/3MkF3Sz7y/IdmUPm49NUJ2k//aIcvleF7aQ288=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS9vD4qo91Z0gQNzJd/iZxywD8mDXRlAGzGXPuGSXTA1nTNh0CMKmq2Ux5OQficbEmgnbWZ5IbBBPBQJ0Kv2ooBV2bPHY8wydewjoZozeckh+A/XB76iAIvZCxAClYOOrToObzetmg4bk5DNjlDFfUB9k47qlatp+akhDVK3mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlRoeA4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlRoeA4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E4C2BCB0
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768985815;
	bh=+pQy/3MkF3Sz7y/IdmUPm49NUJ2k//aIcvleF7aQ288=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AlRoeA4eGRPONyrBeoSByb7HbmbE67ChxpedFqIVpC9JbAENmcDVQQtIWbIA7faAI
	 dVFIhRBj+vf7R4uFbla+/cX0l7DbfspfUu/Omw02LxYhniw10w8u0Gf8/eyuzLy1Z6
	 X/WA9vCgw/TggH5POkO+o0/w6R/A6vwuQMmINjIOyIXRq+cpk5vgq0wKv9oC4sfCnK
	 WfiCADsAKZoBXEDaynaJ44GORGEswmC71HJY+qk1Tkwl14BkdUMuCk7ZH2R28VNHtv
	 ywb+s8k3i7liZELAPDeMD5s/Gk/Qz+rrX1Jl07G2TODoGBynUVdd4Rt8fmo73SrFQ+
	 +/5pNkkMnfNlg==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so4813237a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 00:56:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU63uVFqjI7FI9yQrg8dAPLZKQjQC9JKOSx40Pv74QnY85mvRQYo1f9IUz9systEHZ4KzmezvpSTK9aHavf7yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDsbRlS2BuQarJeJd3JeRSAXP3IA1hb5CSDv3k0004huFYYxe
	zIt5SRnUnQyUdX5oChJIoT2Bt33KdoWxgA6JNMupTVYlF6ur/4b106g/0LZBcfQzU6DfGCz/B51
	a1FDFVSmowzOraAIuqAIrMsww4zw75p0=
X-Received: by 2002:a17:90b:38d2:b0:347:5ddd:b2d1 with SMTP id
 98e67ed59e1d1-352c40aa8ddmr3712134a91.27.1768985814670; Wed, 21 Jan 2026
 00:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
 <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>
 <202601141003.852D0771D@keescook> <19f51dd5-c729-4977-880e-ff23ef01bca5@zytor.com>
In-Reply-To: <19f51dd5-c729-4977-880e-ff23ef01bca5@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 Jan 2026 09:56:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVXjMWaBsBPc-R_yZmZYm0VwxnDrw5kW7HUqvOMZJG_g@mail.gmail.com>
X-Gm-Features: AZwV_Qjl5qO2sAExjv731DxVsAamLHvLTjBfmsOYByux3tJZXAThcpyTApHSczY
Message-ID: <CAMj1kXEVXjMWaBsBPc-R_yZmZYm0VwxnDrw5kW7HUqvOMZJG_g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 21:46, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2026-01-14 10:16, Kees Cook wrote:
> > On Fri, Jan 09, 2026 at 10:21:49AM +0100, Ard Biesheuvel wrote:
> >> On Fri, 9 Jan 2026 at 01:37, H. Peter Anvin <hpa@zytor.com> wrote:
> >>>
> >>> On 2026-01-08 01:25, Ard Biesheuvel wrote:
> >>>> This series is a follow-up to a series I sent a bit more than a year
> >>>> ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
> >>>> for further hardening measures, such as fg-kaslr [1], as well as further
> >>>> harmonization of the boot protocols between architectures [2].
> >>>
> >>> Kristin Accardi had fg-kasrl running without that, didn't she?
> >
> > I understand "such as fg-kaslr" to have been just a terse way of saying
> > "such as a complete multi-architectural fg-kaslr"
> >
> >> Yes, as a proof of concept. But it is tied to the x86 approach of
> >> performing runtime relocations based on build time relocation data,
> >> which is problematic now that linkers have started to perform
> >> relaxations, as these cannot always be translated 1:1. For instance,
> >> we already have a latent bug in the x86 relocs tool, which ignores
> >> GOTPCREL relocations on the basis that the relocation is relative.
> >> However, this is only true for Clang/lld, which does not update the
> >> static relocation tables after performing relaxations. ld.bfd does
> >> attempt to keep those tables in sync, and so a GOTPCREL relocation
> >> should be flagged as a bug when encountered, because it means there is
> >> a GOT slot somewhere with no relocation associated with it.
> >
> > Another historical bit of context is that one of the main reasons
> > Kristen's fg-kaslr got stuck was the linker support needed for (the 65k
> > worth of) section pass-through. That never got resolved, and the solutions
> > either required huge linker files (that tickled performance flaws in the
> > linkers) that resulted in 10 minute linking times, or to disable all the
> > orphan section handling, which was a regression in our sanity checking
> > and bug-finding.
> >
> > So, getting a well-behaved fg-kaslr still needs toolchain support,
> > and getting there is going to need further design work. As far as PIE,
> > this just makes the fg-kaslr toolchain work easier (fewer special cases),
> > along with all the other benefits of moving to PIE.
> >
>
> As I *explicitly* stated earlier, there isn't anything inherently wrong with
> putting a small onus on x86 in order to make the general Linux code better --
> but please, be honest about it *so we know what the actual tradeoffs are*.
>

It is not just about the general Linux code. The x86 fgkaslr
implementation was never merged because the toolchain side needs
changes. And convincing the toolchain maintainers to take our changes
is difficult if we keep using relocation tables that are not fit for
purpose to perform runtime fixups on code that was built using the
'kernel' code model, which is explicitly position dependent.

> For x86, we really do want to maintain the kernel memory model, which allows
> us to directly reference symbols in complex address expressions and to
> directly jump across modules.

AIUI, those complex address expressions are mostly indexed loads from
global arrays, which do get slightly less efficient, but not in a way
that was noticeable in any benchmarking I did (or LKP for that matter,
which generally sniffs out any performance regressions). This includes
jump tables, but as I already explained, RIP-relative jump tables have
an upside too, given that the table itself is only half the size.

The ability to directly jump across modules is not affected at all by
these changes.

> This means the "PIE" will need to be different
> from the way PIE works in user space, which is in part designed to avoid
> needing to dirty readonly pages, which would inhibit sharing -- which is
> explicitly NOT a concern for the kernel.
>

This is already implemented in this series: no GOT entries are
permitted, and text relocations are allowed.

> So that is one thing that the toolchain needs to be able to do.
>

It already can, and this series makes use of it.

Note that the size of the relocation table taken from an allmodconfig
bzImage drops from 7.3 M to 2.4 M (defconfig goes from 800k to 45k),
so there is a minor intrinsic benefit to these changes as well. But it
is mostly about moving away from bespoke tooling and formats that are
becoming more of a maintenance burden as the number of supported
toolchains and languages increases.

> I fully expect that we will continue to need to have some kinds of overrides
> for specific symbols, too, because there aren't any really sane ways to
> express them to the toolchain; this especially applies to linker-script and
> some assembly symbols. For example, the real-mode code (which uses the reloc
> tool as well) has to support segment and segbase-relative relocations, which
> are something that ELF simply has no concept of.
>

The real mode trampoline is not affected at all by these changes,
given that it is built as a separate executable. Using a bespoke
relocation format there is fine, because it is internal ABI.

> I have a lot more of an issue with trying to change the x86 boot protocol,
> simply because the way booting works in x86 has been incredibly successful;
> yes, the bzImage file format is ugly as ****, but that is a direct result of
> 34 years of continuous backwards compatibility. One of the reasons we have
> been able to do that is that we have *explicitly* rejected other boot models,
> such as Grub's self-declared Multiboot "standard" (which they have had to
> revise multiple times by now) and the early Xen boot model of booting vmlinux
> directly. We have added *many* capabilities to bzImage as needed, and it has
> turned out to be quite flexible in the end.
>
> That, in turn, has been possible exactly *because* the Linux kernel provides a
> "prekernel". I don't even really like calling it the "decompressor" anymore;
> it really has developed far beyond that.
>

The decompressor is needed when booting the 64-bit kernel from a boot
loader that calls it in 32-bit mode.

When entering in long mode, with all memory mapped 1:1 (or at least,
the kernel image itself, and all assets in memory that the bootloader
exposes to the kernel), the decompressor does nothing useful, and all
the problems it solves (by doing demand paging etc) only exist because
it created them in the first place.

SEV-SNP confidential compute made an even bigger mess of this, because
it can trigger #VC exceptions too, which also need to be handled.

Note that the EFI stub does not bother with the decompressor anymore,
and unpacks and boots vmlinux directly. This was needed because the
decompressor fundamentally relies on memory that is both writable and
executable (as it moves its own executable image around in memory),
which is difficult to reconcile with recent PC firmware
implementations that are pedantic about mapping memory RWX.

But actually, I am not proposing to get rid of bzImage. I am proposing
to make it more transparent so generic bootloader components can be
constructed that consume the ELF directly.
