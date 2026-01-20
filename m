Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207D3AEF53
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942482; cv=none; b=ctda+thX++DjoP1kUiEMpcSyPEOTV6uqzYJRUUiikiUcHGAv0ZM0yL+Jo7L4ZqZ7eDFB1AIIray9Ui6rGzqXgzvmPgqO8k0sChrpsWdXS8X4QCxxzv8cdQ5uTj2/1dS4b2kArK0Oju/zh8oGAhAAiMUMAibn8cr5u1e2VZSo4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942482; c=relaxed/simple;
	bh=edHKtT+qbSbcejGeeaSAlk8Hr8IADYpjt5HEGAcTgG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY7a9SRhM8nZ3t6JIzKyrMJ2TrzX3KxAURfwFJ3GOHG+eZbYSoGR3zL7YXhfx43btEUPfeD7SmVdJnIK6q/184vX09dxiDofuKiQQycGfdOUOhn9dhg5Im/ttRAvw1YJIwLoeYgYHTjJzrnJiHzgGLzx0okebpZ6zNNzFfNX/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhPI5raO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhPI5raO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F7C2BCB2
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768942482;
	bh=edHKtT+qbSbcejGeeaSAlk8Hr8IADYpjt5HEGAcTgG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BhPI5raOkEq1ITeUxSpv8PVCAofaF3JhCVroscGohdSvdIAQrfTQUcOpIkq61lgF0
	 jzUGSTMNUMNIC+9UIJMlRDDZYcOkL07LJlHQ3aB3N3aQLWfQ88z17fW6UUDXlyEQ5f
	 1niP8TQDoQQyDAb8TKcJYWvDsdO5Grd1NGuM4f9ejyOenaxayOyqZZY2luc/BpzG7Z
	 onRAtCjBPIjjEmB63Far2LY9z4KUQRJ6ekILrci4z/716WBTlyydVu++nkFCv0t9SL
	 QFragcdc+FefKBT0bcXauSLW3x1lixV+TJ63hI7HPkp2JurYNXXhNqDAZzk1SEu3UJ
	 ntMl8CmnUHWwA==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso5132527a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 12:54:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX5y9bImSkQDe1e5IY2LsIr5FT0wZejIq3JAxPKRJsqCqXohfJ8NSroPx4JwrPQLWC2mFND9fBTT0yRVvDezo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZVN/qGWncXXcPMqQWVDCE/8VOoguYA5Sbr+XSqOWuRPXl/SK
	2ZsKvy/C3gheoA9zEM+xR1r8utOnsws/KcCZHRm2yeSYIs11CrnsWkxb1kNsNuI7ln2WcM6l0C6
	e74FlSPYvfQLUv967UVGXSGOkDP6bD8k=
X-Received: by 2002:a17:90b:2741:b0:340:bde5:c9e8 with SMTP id
 98e67ed59e1d1-352c407a374mr2154031a91.22.1768942481739; Tue, 20 Jan 2026
 12:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-31-ardb@kernel.org>
 <aW-1mv3OU-GcRyAQ@google.com> <20260120194358.1bd909fa@pumpkin>
In-Reply-To: <20260120194358.1bd909fa@pumpkin>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 Jan 2026 21:54:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEW4yZqHAu_cm=ZVMwah-MO+ZZeBtHSO=_UcaSFkY49iQ@mail.gmail.com>
X-Gm-Features: AZwV_QiySO9q6ni52SjDGIyw-8dD6WtHBxaL_ZGb5Vl_EsH69vIYIR_LrRX46Sw
Message-ID: <CAMj1kXEW4yZqHAu_cm=ZVMwah-MO+ZZeBtHSO=_UcaSFkY49iQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 10/19] x86/kvm: Use RIP-relative addressing
To: David Laight <david.laight.linux@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 20:44, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Tue, 20 Jan 2026 09:04:26 -0800
> Sean Christopherson <seanjc@google.com> wrote:
>
> > On Thu, Jan 08, 2026, Ard Biesheuvel wrote:
> > > Replace absolute references in inline asm with RIP-relative ones, to
> > > avoid the need for relocation fixups at boot time. This is a
> > > prerequisite for PIE linking, which only permits 64-bit wide
> > > loader-visible absolute references.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/kernel/kvm.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > index df78ddee0abb..1a0335f328e1 100644
> > > --- a/arch/x86/kernel/kvm.c
> > > +++ b/arch/x86/kernel/kvm.c
> > > @@ -807,8 +807,9 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
> > >   * restoring to/from the stack.
> > >   */
> > >  #define PV_VCPU_PREEMPTED_ASM                                                   \
> > > - "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"                                   \
> > > - "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
> > > + "0:leaq 0b(%rip), %rax\n\t"                                                    \
> >
> > Please use something other than '0' for the label, it took me forever (and looking
> > at disassembly) to realize "0b" was just a backwards label and not some fancy
> > syntax I didn't know.
>
> I remember taking a while to grok that as well.
>
> Can't you just use . as in:
>         leaq    .(%rip), %rax
>

How would the other two instructions referring to '0b' in their
immediates refer to '.' in that case?
