Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29D35B128
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960589; cv=none; b=foJPUfh2YfjzntZj8Ni1ayqrZI8wgM0aJSGMR7CXefpGQG5fUlsdFAznFNP2MiZqFbD1ccwRAWD180Rrn812KVESsF6OF+pAAxHzTGb14ZPSMc4J/3XA3mFFarwQaN6QWWXAwClXF820dlQYsfoHyFvZWhonwegyONe3/Ck9AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960589; c=relaxed/simple;
	bh=XJOKJVck39dcQRvw08JjSgOICDzlh+duJ4Z8hEe3zaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4e9qoP+24aLG4RksZS4EPBU4kUgszWp3Q3zuluLQnsToA2nwaMqDGX+97cj8JeKyyGE4WkVnyf0vW2vpnEudjpKvRdPRmLUDgECkBe4T0xmvbhSH6Uy7rbLS3vzczxjGPkwKzMoVwvQnMk2tOCL+9Jp+ggrpCwOJb08YLU8dqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCqFU0KC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCqFU0KC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6193BC19421
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767960589;
	bh=XJOKJVck39dcQRvw08JjSgOICDzlh+duJ4Z8hEe3zaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YCqFU0KC35uxRkV1C/7qgDswcY/u2IE9S2rv7j71qPjMxHEaSuDdnN38f5fYh45QX
	 nejjyIxnR9hvzLNIYB96u7N+Yn46jsAcVkwEck53PPO+GRx7m3bbDIkyTbTUXiMsn/
	 g8ItfHbd8n1hg1Ce4+dWE2xtNbIjU0Hh2RtmHzm0PtCa1kX9OMNmKtJlyO9GYs2YCY
	 ZxtZfQAOsmYeys1xyfbjlUZi+dkccMPUxVCAWgtDFsp/eJVd+f5n1kI4xEkU+SYqQh
	 lGRBoSiei3xpMld7uUHQtBTEtTHX1QAfi3mK0vm76BRE3tU+cWZP477erEpmdTwNs8
	 su5muqPTd/RVQ==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2710227a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 04:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUzJSVTLnVLCl0rFKl8beRTAIz3PXfymBkbY9pDrATHSjzU0pI7BhnSC1ujauvAyTjO3dv+nFXdQ8kP/kGqB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FZq+bZe4ew4zSD67nfv10eCCOfIm3lh/1lQOTdovaiArWqMv
	XZKkDZM5No0pLoWscEDh3e1/GfpuszIWDG39V294IwixL/0hwyjfnjcP8QmRiQJC3rb1rwT6pNn
	7lhDvc5aQj+9qLfIkcNBGc9nYgH1i/I0=
X-Google-Smtp-Source: AGHT+IGhQf5ypgb4SjYtsZf0x0t+vivvaF4NhUaBilRgeBZrRp4T6LX+p2i993nG7Qjf9VI1xL4dTIQWFR/SKE/k2HA=
X-Received: by 2002:a17:90b:4f88:b0:34c:cb3c:f536 with SMTP id
 98e67ed59e1d1-34f68ceac3dmr8610745a91.36.1767960588936; Fri, 09 Jan 2026
 04:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
 <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
 <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com> <CAMzpN2iJ8QFuDq+Sov81X103x7q_-ueoO-nJwEjnF3GpKf2W0g@mail.gmail.com>
In-Reply-To: <CAMzpN2iJ8QFuDq+Sov81X103x7q_-ueoO-nJwEjnF3GpKf2W0g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Jan 2026 13:09:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHzdG9mypXYRDxACrO0ZoScT8x1Cz+cxcKcAvSeNrET4g@mail.gmail.com>
X-Gm-Features: AZwV_QipondERX1ly2n9_dXPnR58iowCpvfSv8Ar2kIgUIbdPk4VAWU0uCFfMTw
Message-ID: <CAMj1kXHzdG9mypXYRDxACrO0ZoScT8x1Cz+cxcKcAvSeNrET4g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 at 12:46, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 2:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Fri, 9 Jan 2026 at 06:01, Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > >
> > > > Use ordinary RIP-relative references to make the code compatible wi=
th
> > > > running the linker in PIE mode.
> > > >
> > > > Note that wakeup_long64() runs in the kernel's ordinary virtual map=
ping
> > > > so there is no need to record the address of .Lresume_point in a gl=
obal
> > > > variable. And fix the comment while at it.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
> > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acp=
i/wakeup_64.S
> > > > index 04f561f75e99..15233a4e1c95 100644
> > > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > > @@ -14,7 +14,7 @@
> > > >
> > > >  .code64
> > > >         /*
> > > > -        * Hooray, we are in Long 64-bit mode (but still running in=
 low memory)
> > > > +        * Hooray, we are in Long 64-bit mode
> > > >          */
> > > >  SYM_FUNC_START(wakeup_long64)
> > > >         ANNOTATE_NOENDBR
> > > > @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
> > > >         movq    saved_rsi(%rip), %rsi
> > > >         movq    saved_rbp(%rip), %rbp
> > > >
> > > > -       movq    saved_rip(%rip), %rax
> > > > +       leaq    .Lresume_point(%rip), %rax
> > > >         ANNOTATE_RETPOLINE_SAFE
> > > >         jmp     *%rax
> > >
> > > If this is already running on the virtual mapping, this can simply be
> > > changed to a direct jump.
> > >
> >
> > Indeed, but I couldn't figure out how to do so without making objtool u=
nhappy.
>
> I replaced it with a simple "jmp .Lresume_point" and objtool seemed
> fine with it on a defconfig build.  What error did you see?

arch/x86/kernel/acpi/wakeup_64.o: warning: objtool: wakeup_long64()
falls through to next function do_suspend_lowlevel()
