Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FF3D3480
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946423; cv=none; b=eFiDIYOwxZSpgvAnVsCtz3O/XF5Mr1D4uoGyuPvuQprOI6MLk1C29GkmGYSErsN5LitIWpCi6Uops+y2oCI0dGLvr4M+uSZqtUDsXfilNlZDt4s7FrhOSQIOiuCKWcya5M6DmWAdBPeN2WtukY8+VxCm4Ypewi8omKsutyX1Ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946423; c=relaxed/simple;
	bh=ZvOxSMtkLIO/ibQMLeUPV9J0RjOmTPpEkH5acVvX9Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXaDbp/CCNskLZwB2jdVgSTzQrpCTmZRySG9bT/vWjLawbYeXwVxIrD9yPb4wijP+XyKorz0NUmSR6dAHZu0Bnn3BvMYSmhQvHD3lVjVIptMGoSd7aO2soVBRcRyDCV7KMRtRamYEYAHQ2/6PC304TGlBWMMO213lyItX+2Auzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD1I9BSv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD1I9BSv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801c314c84so38368545e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768946418; x=1769551218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYraRXOuYGBxOoaAf8Gw+lLx3L7fFVpnuw34HtGkPw=;
        b=GD1I9BSvt1URL4L9jce2nfbi6TjZCjYAJmivLHidzPGjed2ut7LFk/zCJVYN/SIiBH
         Y1ZESpEiKkQULXP+UANBQR1/plDAJqGEIo/RCsnpsVyEtBX0szS1u+yI9GDUp5MW/h9X
         xM2NGVFqKUgLZBV+l0Q/lgQEHQfSuwxyUZdF/4K7T82J0ZqfLUXZsktn68GcH8FzyHuM
         eEC89KB6p8aqfW53nNmWSzo6lQDNRBs8WCWYKAmKXykNRjL07QtH4U4EQxb2VtdL9yhS
         CKOuxSrSkKXfFH+L/UG4pSRDKd7A1R09HdVmj1kYuXGwk2ZwdyesA20C9O3lRn7QyiWr
         FV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768946418; x=1769551218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVYraRXOuYGBxOoaAf8Gw+lLx3L7fFVpnuw34HtGkPw=;
        b=hWnAEvbWexUQX3N4dOQ5R4ms4almB2hWJjCRQiiDRBQ2yjad9Qd7WfpOdY6WP66wZs
         ORyOqBe6iJemEVsmj5LnRhhvP2y77ljJS3FmGdAsqsHDqncSd63dZmrk+VOs+Ef5P4Vq
         ZcSf/j275KyH/OfAnHitpVENLY4+GiO1Qj/J8nbdZCcfja8JC3elIO5zB/nCn5AhWad7
         9zVib28sCE9XTKvLgfXQq9OZHzeYSd0/3f1aKdScjz3qVRqFCJymYdjbLGeaB9AvTh6i
         tFJJburaWpzFoSv4J8XMnZS3jTPGDI0y4NjdBe19NPImSI2CM9BV/BTNfa6JbpGlCySY
         s1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9AbQESt760Xqi9wwwONAzQDgI6cY9LXhj0t1p/plIKmH8WD3Khz3/TX0XMO+eu20AA58UPl+s2taKx/+DiBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfggKG25rZX+j499zojPFtH9WHf+XGhgoSmsowZeEbdgqc2Tqj
	eCkZVMIqCUOulHB1by9H3bZ6HdrRN9cF/Jmu8wV7Kp5UZFvPuxxT2ty/
X-Gm-Gg: AY/fxX7rmUehqGXs0vfQF+O+P62BubkM79C7dmbD61W4HocKx0/KxMacQ3fRSF6EPqv
	SI9IQmOYMCEOAj/LuGLBzQhTHP3KRCx29Zn85MWqusSVY08kC2FwNvjeZxeIuz6I8VNKZCoxTHr
	GNqyauspZJbXYBdb6sYZgGfxPGqOyO0+8gpYP0841lFUPEsU3dC4fLUMbE6nVjuOVQ1NfukeKqn
	mI884ajxkP2cuqH5I5MDN4v9xbXnEkhgTfqn5SxYQhor/hP1yH1jQSBXJV0eg5ZlK2YEHudSEsy
	sBCXuIBjRXvJwGwhBHWSENNROFLZKNbeHs6owuc35Utjvdli/ABy9prLbPjH3gVoi+9HYMl5X0s
	9w4PP/uq1eEc7Logr2gv8C7IXfyj6vzSry8ib5sG+jKg+YBe7ndodhMIzBIagNPBeZEftTQFR/g
	tVA7Nl3dm7uFYhIj2lIsHDOsJcMu9PhKf5InIZF2gPncjAwj8tFxxr
X-Received: by 2002:a05:600c:638d:b0:47e:e78a:c833 with SMTP id 5b1f17b1804b1-4801e34cfdfmr228930345e9.32.1768946418205;
        Tue, 20 Jan 2026 14:00:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c1e016sm2119345e9.8.2026.01.20.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:00:17 -0800 (PST)
Date: Tue, 20 Jan 2026 22:00:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, Brian Gerst
 <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 10/19] x86/kvm: Use RIP-relative addressing
Message-ID: <20260120220016.241766b2@pumpkin>
In-Reply-To: <CAMj1kXEW4yZqHAu_cm=ZVMwah-MO+ZZeBtHSO=_UcaSFkY49iQ@mail.gmail.com>
References: <20260108092526.28586-21-ardb@kernel.org>
	<20260108092526.28586-31-ardb@kernel.org>
	<aW-1mv3OU-GcRyAQ@google.com>
	<20260120194358.1bd909fa@pumpkin>
	<CAMj1kXEW4yZqHAu_cm=ZVMwah-MO+ZZeBtHSO=_UcaSFkY49iQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 21:54:30 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 20 Jan 2026 at 20:44, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 20 Jan 2026 09:04:26 -0800
> > Sean Christopherson <seanjc@google.com> wrote:
> >  
> > > On Thu, Jan 08, 2026, Ard Biesheuvel wrote:  
> > > > Replace absolute references in inline asm with RIP-relative ones, to
> > > > avoid the need for relocation fixups at boot time. This is a
> > > > prerequisite for PIE linking, which only permits 64-bit wide
> > > > loader-visible absolute references.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/kernel/kvm.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > > index df78ddee0abb..1a0335f328e1 100644
> > > > --- a/arch/x86/kernel/kvm.c
> > > > +++ b/arch/x86/kernel/kvm.c
> > > > @@ -807,8 +807,9 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
> > > >   * restoring to/from the stack.
> > > >   */
> > > >  #define PV_VCPU_PREEMPTED_ASM                                                   \
> > > > - "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"                                   \
> > > > - "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
> > > > + "0:leaq 0b(%rip), %rax\n\t"                                                    \  
> > >
> > > Please use something other than '0' for the label, it took me forever (and looking
> > > at disassembly) to realize "0b" was just a backwards label and not some fancy
> > > syntax I didn't know.  
> >
> > I remember taking a while to grok that as well.
> >
> > Can't you just use . as in:
> >         leaq    .(%rip), %rax
> >  
> 
> How would the other two instructions referring to '0b' in their
> immediates refer to '.' in that case?

I'd forgotten about those, not in the quoted bit of patch :-(

Traditionally (going back to MACRO-11) numeric labels would start at 10
and go up in 10s, TECO had a nice macro to renumber them.
(Showing my age again)

	David
