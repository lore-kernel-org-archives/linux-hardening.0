Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018782F3C26
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767945568; cv=none; b=ZcLYgzknmztLmHanlCNLNCWchgCLcfgUGexc0ORnZvIQoCLmoI6NZ8RWaSwllPrNOwb2kO1PBUDtcHsH9JpP802tNcJxRpKn7GgxUCK6O5DGvo4PSAN20pw8HKUQ1+tCsPwdMH5qE+9TyK62HJVoctmD7IJiT+YyYoXYsc95Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767945568; c=relaxed/simple;
	bh=AVzETINKz9rzqStIm1jv1CSX03JBq7Y1VYZzqdC6N+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJgmGlJ51+x28wlIaTlqLnx51aahIz7lkL6Hg/BmpXygMYtRt42DhlUkfxstY5usHI6zeCr2qq9RcPUm1QptQveXcpFj0aFIdDLlp8HujLuvBKvxm+qIoYaSJ5KlY4vXdPyBCXHyKbM7+H8k7LevimPUIj/iHSOROT10PLHM8/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5r/jWtQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5r/jWtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD646C2BCB0
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767945567;
	bh=AVzETINKz9rzqStIm1jv1CSX03JBq7Y1VYZzqdC6N+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r5r/jWtQ2Y3FvRyvIgMoaMJZsB5Aqi3PRtgcyUvZRMadSRFlIoWgYyIlJdfXtGGoq
	 KRT59NlBniZ7lUQfF49WmuBJrg9rGHSA9GUWyuhhHMoxiWX+sGA3BhcpRm/Yigf7+q
	 Akaa882bA/3w/p2jssXFmgSMwHJ5YnTLOqm0enupYFFiL9nC4BS5idc/0f0dUimjw+
	 GgM2vv6yv1J02A0KPdnPcxJxazegkcDbdBvTiyhWusyzzewK4bVnNW60y74CuwXrBS
	 g5eSpVQeJuzJDw8fUTtUl/GoIa4mPX847rLEcbaVIV3iA/KYT5ijsV6h/5524iNxQu
	 udrmU/I/LGldA==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c565c3673so1355307a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 23:59:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPRl9LciNNt/RRXwd51ye86bMD3S30VuZb6bsVQ2eVtd5Y/Uk0Z5IPhUoD9dFCqOBxt0g/AZUKCwPg4BwsUC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgc2W44CyZseAUV1hP0bSSiDOG3/LbGFVYKTr1GB+rTq1hg1jP
	KnfzooJZuBphPgdSz2gyhC3HXZIRGQo2QftiSEurIlpgPehkifjIyscoD4lUwkNpkn+Jtw5eX93
	ZrYRYBpVwqsYt5Mg9ohhaDE48nESGaqs=
X-Google-Smtp-Source: AGHT+IGH6wv4nHxLjW4/SjaUwsmRuiygMZwuC1p8Gbr/90w4reThGJ7gn6/2mS8cICmAZB6OCq3OSVDO9qno8WEATq8=
X-Received: by 2002:a17:90b:1e0c:b0:34c:ab9b:837c with SMTP id
 98e67ed59e1d1-34f5f72fd3emr12248788a91.0.1767945567128; Thu, 08 Jan 2026
 23:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
 <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
In-Reply-To: <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Jan 2026 08:59:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
X-Gm-Features: AQt7F2rZLmgEpBWElwmuRDJ494BeI2O9GZjn-OaMEJAkgDjm8V9vFwfOFIsZA5o
Message-ID: <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 at 06:01, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > Use ordinary RIP-relative references to make the code compatible with
> > running the linker in PIE mode.
> >
> > Note that wakeup_long64() runs in the kernel's ordinary virtual mapping
> > so there is no need to record the address of .Lresume_point in a global
> > variable. And fix the comment while at it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wa=
keup_64.S
> > index 04f561f75e99..15233a4e1c95 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -14,7 +14,7 @@
> >
> >  .code64
> >         /*
> > -        * Hooray, we are in Long 64-bit mode (but still running in low=
 memory)
> > +        * Hooray, we are in Long 64-bit mode
> >          */
> >  SYM_FUNC_START(wakeup_long64)
> >         ANNOTATE_NOENDBR
> > @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
> >         movq    saved_rsi(%rip), %rsi
> >         movq    saved_rbp(%rip), %rbp
> >
> > -       movq    saved_rip(%rip), %rax
> > +       leaq    .Lresume_point(%rip), %rax
> >         ANNOTATE_RETPOLINE_SAFE
> >         jmp     *%rax
>
> If this is already running on the virtual mapping, this can simply be
> changed to a direct jump.
>

Indeed, but I couldn't figure out how to do so without making objtool unhap=
py.
