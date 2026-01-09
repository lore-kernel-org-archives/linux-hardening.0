Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8785357A50
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950521; cv=none; b=hgoCuIk42noTTYdlEds31TWGuqSUFXcmn7uY8+5XZ674yDpwhBV9TkP+EG4SI7PVUup+NYaf1K+EruIoX1sl6RpPAI7FzBuafiDffY0sOq1EgX6rJ2FcyVwQRd9S5ne0FN2r37xz6Op5ePBmQuxCCM5AAxjaZq+jhlbR983wttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950521; c=relaxed/simple;
	bh=BfammgutHkAleeTe5+j/9vtNmlrE0g2LPvXZDmEa1vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urClD84GYtRzSJ2SMswOc/hlx2+v2/al+DDz9Dhfo7ITT9FNcZc7noGnl2WBQqydDCoGmbTNvv+hxYqCyZnbaYSkmZYo5UmvLbY9nY56G42XqJa+hS3RD5WdrPBX9YHl4v/xff0UntltZrZK1IPFppw79tc7bB5teyYFUwGGhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSyj97/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSyj97/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE0C16AAE
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767950521;
	bh=BfammgutHkAleeTe5+j/9vtNmlrE0g2LPvXZDmEa1vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oSyj97/tawFyhC7/pamE6OZ2BibUTW1RzbCcsAiANiEAOS2pmaM1A4cZlRQppusQ2
	 JzOabf6KgDX3efPZaciYtYtMGKbalq3b2cvyqo7RxyzN9+u3nrKCgxoP5Fw16BASeA
	 rK8DI9GMOBylquNE1hGy8aonM14kJvCh83ca2ygr7m6yxZ5awgKjFNicfKEdRIk/OR
	 KtGXx1MEuLIfcKO7ZnhPkW5+3STRXKHwsV21FwnZH4nSaCO3/NPy8u4brIQDj7sxkt
	 L4ItijuwI2cUqJBj0KqqBrzNwjNlGzihYTGzei8x+M7DNbtl0kcqJj2jfh3hQPbtK1
	 ISBR27C8u6xgw==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34f63ad6f51so1454315a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 01:22:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnZUBaeZHa+nC6fw/tc3O5aKh/x2lHbeex/smhRSamTgV4VaHOPwm6NaEjBryq+sxlUjfGivwgbLz2YYPzrRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1k3OR0DGazNOMNmCY2RwtkiOITRTXkjzm87eiRA2iO26fBFw5
	FQeOiB2TuKdTM540KH+LZmtxYRdl0kp9d4zu947e33nTUsatTcYY1MGnlJdeJnkSUU93kbQtcaA
	uYwzgAcznAyHmge5OEjN7bFMndmHQqOI=
X-Google-Smtp-Source: AGHT+IH9ca6ppS5maHZDAsr49ugvJlcB+3MlS0UJI986JTi2KwPjkV994Ytw7mry5x69YSnqyj3oBkuPflAPO0ghQyw=
X-Received: by 2002:a17:90b:264a:b0:341:315:f4ed with SMTP id
 98e67ed59e1d1-34f68b68176mr8028463a91.10.1767950520860; Fri, 09 Jan 2026
 01:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
In-Reply-To: <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Jan 2026 10:21:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>
X-Gm-Features: AQt7F2rNgMTTHHGYZYY_Av3OOuW4AAfSKNJJwBhyV4uNJlxeKG3ZpFSmdo9faj8
Message-ID: <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 01:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2026-01-08 01:25, Ard Biesheuvel wrote:
> > This series is a follow-up to a series I sent a bit more than a year
> > ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
> > for further hardening measures, such as fg-kaslr [1], as well as further
> > harmonization of the boot protocols between architectures [2].
>
> Kristin Accardi had fg-kasrl running without that, didn't she?
>

Yes, as a proof of concept. But it is tied to the x86 approach of
performing runtime relocations based on build time relocation data,
which is problematic now that linkers have started to perform
relaxations, as these cannot always be translated 1:1. For instance,
we already have a latent bug in the x86 relocs tool, which ignores
GOTPCREL relocations on the basis that the relocation is relative.
However, this is only true for Clang/lld, which does not update the
static relocation tables after performing relaxations. ld.bfd does
attempt to keep those tables in sync, and so a GOTPCREL relocation
should be flagged as a bug when encountered, because it means there is
a GOT slot somewhere with no relocation associated with it.

One could argue that this example is just a Clang bug, but it is very
difficult to make that case with the toolchain developers, given that
--emit-relocs (which is what tells the linker to emit the relocations
that it received as input) has no specification, and some linker
relaxations are not representable as static relocations to begin with
(but to be fair, that currently mostly affects other architectures,
but there is no reason this could never happen on x86)

Doing fgkaslr properly (IMHO) means supporting things like live patch
and debug seamlessly, and in a portable manner. Toolchain support is
critical, and securing that for a one-off x86 implementation rather
than one that can be used across architectures and other bare-metal
projects is going to be difficult.

> From your footnotes, it looks like what you are *really* asking for is to
> pessimize x86 code to benefit other architectures. That isn't inherently
> wrong, but stating it as you have above is dishonest.
>

I was hoping to save the ad-hominems for later in the thread, when
things *really* heat up.

The point is not to benefit other architectures. The point is to
implement something once, and deploy it on all architectures in the
same way. ELF is the greatest common denominator across the entire
ecosystem, and so using idiomatic ELF to describe how to load the
image and how to move it around in the virtual address space is on
obvious choice.

> > The main sticking point is the fact that PIE linking on x86_64 requires
> > PIE codegen, and that was shot down before on the basis that
> > a) GOTs in fully linked binaries are stupid
> > b) the code size increase would be prohibitive
> > c) the performance would suffer.
> >
> > This series implements PIE codegen without permitting the use of GOT
> > slots. The code size increase is between 0.2% (clang) and 0.5% (gcc),
> > and I could not identify any performance regressions (using hackbench)
> > on various different micro-architectures that I tried it on.
> > (Suggestions for other benchmarks/test cases are welcome)
>
> Could you show some examples of how the code changes?
>

Taking the address of a symbol (same code size)

   0: 48 c7 c0 00 00 00 00 mov    $0x0,%rax
3: R_X86_64_32S sym


   7: 48 8d 05 00 00 00 00 lea    0x0(%rip),%rax        # 0xe
a: R_X86_64_PC32


Loading a global variable from memory (one byte shorter in PIC)

   e: 48 8b 04 25 00 00 00 mov    0x0,%rax
  15: 00
12: R_X86_64_32S sym


  16: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 0x1d
19: R_X86_64_PC32 sym-0x4


Indexing a global array (3 bytes longer in PIC, needs an additional
GPR if source and destination are the same)

  1d: 48 8b 04 c5 00 00 00 mov    0x0(,%rax,8),%rax
  24: 00
21: R_X86_64_32S array


  25: 48 8d 15 00 00 00 00 lea    0x0(%rip),%rdx        # 0x2c
28: R_X86_64_PC32 array-0x4
  2c: 48 8b 04 c2          mov    (%rdx,%rax,8),%rax


Pushing the address of a symbol to the stack ((3 bytes longer in PIC,
needs an additional GPR)

  30: 68 00 00 00 00        push   $0x0
31: R_X86_64_32S sym


  35: 48 8d 05 00 00 00 00 lea    0x0(%rip),%rax        # 0x3c
38: R_X86_64_PC32 sym-0x4
  3c: 50                    push   %rax


Jump tables look completely different, but the table itself is only
half the size. Even for non-PIC, jump tables are problematic for
objtool, and so these need to be annotated by the compiler. I have
some unfinished Clang patches that implement this, which I hope to get
back to soon.

The asm patches in the series should give a good impression of how the
code changes.


> >
> > [1] There have been a few attempts at landing fine grained KASLR for
> > x86, but the main problem is that it was tied to the x86 relocation
> > format, which deviates from how fully linked relocatable ELF binaries
> > are generally constructed (using PIE). Implementing fgkaslr in the ELF
> > domain would make it suitable for other architectures too, as well as
> > other use cases (bare metal or hosted) where no dynamic linking is
> > performed (firmware, hypervisors). In order to implement this properly,
> > i.e., with debugging support etc, it needs support from the tooling
> > side. (Fine grained KASLR in combination with execute-only code mappings
> > makes it extremely difficult for an attacker to subvert the control flow
> > in the kernel in a way that can be meaningfully exploited).
> >
> > [2] EFI zboot is already used by various architectures that have no
> > decompressor stage at all (arm64, RISC-V, LoongArch), and this format
> > can be combined with an ELF payload too. EFI zboot accommodates non-EFI
> > boot chains by describing the size, offset, payload type and compression
> > type in its header, so that it can be extracted and booted by other
> > means.
>
> The bzImage format already have that for all practical purposes. We *really*
> don't want to introduce a new binary format for the x86 kernel. A bunch of
> such attempts have been done in the past, and it is nothing but a mess that
> breaks things, because now you are encouraging different bootloaders to
> support a non-overlapping set of binary formats.
>
> STRONG NAK on that one.
>

I think it should be feasible to implement a hybrid bzImage/EFI zboot
format. There is already prior art in loaders that decompress the ELF
payload directly (Xen).

Given that a x86_64 bootloader running in long mode needs to do very
little beyond loading the ELF at some arbitrary 2M aligned offset and
calling the entrypoint with a struct bootparams in %RDI, most of the
logic in the decompressor is really only needed when booting in 32-bit
mode.

So I think there is value in having a generic boot format that can be
consumed by EFI directly, or by a generic ELF vmlinux loader (library)
that understands the EFI zboot format and knows how to extract the ELF
payload. I'd strongly prefer only a single idiom for describing the
relocations in the image.

On other architectures (i.e., without decompressor), EFI zboot would
be a prerequisite for fgkaslr, but it is up to the platform to decide
whether to boot via EFI or load the ELF and apply the relocations. On
x86_64, the same tooling would work seamlessly, but the decompressor
could apply the relocations itself as well.
