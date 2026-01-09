Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A00334C24
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960634; cv=none; b=GWMUmJa60bP4JrDBg9tKIx4YQQdzu0kxs0Z7COMgHqVuCD/vVpovBWSJevTSydAJMov/733WqJflStcwBmsz0NeHG2X+avFLQX/pvAcm1dsrZaoWXfJm13m7Zz7LKJ6MF4OBhK/MbdYE2exbRLV0F+BlRQT+s52AboMPyy7q9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960634; c=relaxed/simple;
	bh=OwJmWB2wZFFhMAl9OqLvskCJSkOc8Dz76+9TuUGaR20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avcVXxtOdQv/zvHxbGrqok9dFJvV8xwAutjL/FlQNNCUCxbrk+Int1I0GWtYmXb7IU9nbjozKywdRet/VSIxFIwW/Nz46PxOFeZvExzqk2C07valzjyqfxVzcTjHCTMdYg/Hr4s4ORELVLYv40bL5l+ktj2mncrnC+uKfKqptf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQuE8K4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQuE8K4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502DC19424
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767960634;
	bh=OwJmWB2wZFFhMAl9OqLvskCJSkOc8Dz76+9TuUGaR20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQuE8K4NmwtatKYz7seoe/J8DuWGOdP6luYJ6c8pWL4bCQ3wj55TUt5bfvqS6jt/I
	 hbzj9nRHHEHTk1QfHopH/C0Qpm0bmszIhVrMFhgFiIlmHDs3tn1aY4jhEbtDbrLgCj
	 JewjnjpZV9vS/lhcwTgWcCGfMT/wJBmX5iokjidWioiQOOCGOiIgaunYPMIb6A4y+D
	 cOt3BP8/TsylbysdzX20lr1donrRYmzVgQ6OKZexAwVKJeZzwnIfYj34s3YAsV7QLo
	 jphxUtDVnR3ZyICoKHA1DbjKGojvGeStBf6NPTkjMsRoK3KSUCD3pTKx81BuHgcMY3
	 wYw2hlD881PMA==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so3444972a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 04:10:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuid0kxryNs+46okD37Lih+piRwPt7vUZSipDvm5d+6jUwjr3eGwkzJP6wdwnRm8iwymRtzmivtuC/7x6TLwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSfB01Jaf4zYV9BYlbumKQJprtGCqM4ywOOvmP5zup/xkqFfo
	oNKiBkQMW/J/GOWgo/IJDjftgRD25zhO2f4f7IwXNr35vPcAyBuES8kGou2f+bP16O8XgEz7BZw
	w7NPv0QLiNMHVbtgRwS5FsvDUGx3Eqt8=
X-Google-Smtp-Source: AGHT+IEVYH5QPnSUdaMNOJHsqxGhLkfQewEOmPFAfeKQzhDrWLEl0JP/QjuaJFuAG/HjZj7QwRCqrGByhIfihfe+LbQ=
X-Received: by 2002:a17:90b:4e:b0:330:82b1:ef76 with SMTP id
 98e67ed59e1d1-34f68c62a25mr8036588a91.28.1767960634049; Fri, 09 Jan 2026
 04:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
 <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
 <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
 <CAMzpN2iJ8QFuDq+Sov81X103x7q_-ueoO-nJwEjnF3GpKf2W0g@mail.gmail.com> <CAMj1kXHzdG9mypXYRDxACrO0ZoScT8x1Cz+cxcKcAvSeNrET4g@mail.gmail.com>
In-Reply-To: <CAMj1kXHzdG9mypXYRDxACrO0ZoScT8x1Cz+cxcKcAvSeNrET4g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Jan 2026 13:10:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE59iJd-GGq4w0oZ99Lf7MswdOUSf11UASrqqWUUwW+zg@mail.gmail.com>
X-Gm-Features: AZwV_QiVjvhBxa_D8_ueCeEFlVTwIXFkYJTiYufmd81Y7yBzjw37sVjrmmDw7ws
Message-ID: <CAMj1kXE59iJd-GGq4w0oZ99Lf7MswdOUSf11UASrqqWUUwW+zg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 at 13:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 9 Jan 2026 at 12:46, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Fri, Jan 9, 2026 at 2:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > >
> > > On Fri, 9 Jan 2026 at 06:01, Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > > > >
> > > > > Use ordinary RIP-relative references to make the code compatible =
with
> > > > > running the linker in PIE mode.
> > > > >
> > > > > Note that wakeup_long64() runs in the kernel's ordinary virtual m=
apping
> > > > > so there is no need to record the address of .Lresume_point in a =
global
> > > > > variable. And fix the comment while at it.
> > > > >
> > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > ---
> > > > >  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
> > > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/a=
cpi/wakeup_64.S
> > > > > index 04f561f75e99..15233a4e1c95 100644
> > > > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > > > @@ -14,7 +14,7 @@
> > > > >
> > > > >  .code64
> > > > >         /*
> > > > > -        * Hooray, we are in Long 64-bit mode (but still running =
in low memory)
> > > > > +        * Hooray, we are in Long 64-bit mode
> > > > >          */
> > > > >  SYM_FUNC_START(wakeup_long64)
> > > > >         ANNOTATE_NOENDBR
> > > > > @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
> > > > >         movq    saved_rsi(%rip), %rsi
> > > > >         movq    saved_rbp(%rip), %rbp
> > > > >
> > > > > -       movq    saved_rip(%rip), %rax
> > > > > +       leaq    .Lresume_point(%rip), %rax
> > > > >         ANNOTATE_RETPOLINE_SAFE
> > > > >         jmp     *%rax
> > > >
> > > > If this is already running on the virtual mapping, this can simply =
be
> > > > changed to a direct jump.
> > > >
> > >
> > > Indeed, but I couldn't figure out how to do so without making objtool=
 unhappy.
> >
> > I replaced it with a simple "jmp .Lresume_point" and objtool seemed
> > fine with it on a defconfig build.  What error did you see?
>
> arch/x86/kernel/acpi/wakeup_64.o: warning: objtool: wakeup_long64()
> falls through to next function do_suspend_lowlevel()

Note that this is x86_64_defconfig with CONFIG_X86_KERNEL_IBT disabled.
