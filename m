Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C2258CE5
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938243; cv=none; b=TiDY1tkx7Tb7vt0b3kCe60IiCjfhKRIGEokL9N5elyF+SDmN2FZt1ytrPPuoce8Djq0ZYYcueyb7fYHEbpXoMbhdqT4BAvLmihCr22/OifGqRAXM7w78W4jMsIFKeJhl+RNNN9xElLOjbwBDk7Lejbo7YY8opL06ADYIvHtDbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938243; c=relaxed/simple;
	bh=JgjTnujfrBhe/Ps1PuqoxmcIaMtomlyDCA9ajnJbYDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nyfb9FObRclyjv5DnD5dNqwyZGHu7zhTZn3+nQndZak7HMGRS5CDY/agPjuVxPTSiKsjZ1EJkmdZOISdjzqCGIPR5Rt5J/4Q3RcxaVta1q5gaXDnirt3WwuDMp/Sn/jMzXPPst4ckvZY70ZJ/tDTF7tnYSTY3j2BxSrSOG4PKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRDkbPFk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRDkbPFk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so67558735e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 11:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938240; x=1769543040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HPaZyfDYzZkfqScznlO4mTkVB0pmDABf186eHWGTdE=;
        b=mRDkbPFkeaW6dSHxFf7R4Pl700HF6u2AJhmn7WcV70ByyWMN4SpFEni45ChgJuuVY0
         7923jENzpAbSxlE66yLWuSATtqOxQWQgyMNg2LFg2wRKiyNI3oFUFxWfE4FzCLfM3D6B
         3PwqEzrR40neEjjthYodPUXs1rLjcV53AaXxQ6WOE3UjBg3nSqn3p5PGviQx6e/ozqMw
         vU452HT5sjTWTe/EJEZtR6KvrRzLkvGKzBe41Y2GMltp1QcScDwt/ayczCRQDRzdvRMG
         YW4iLOGHORRoB7ov9ZZeTpZ8NldS2GdDURUImqqWwzufAu6K/I3w73DoPDZzNpu6clmf
         cuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938240; x=1769543040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HPaZyfDYzZkfqScznlO4mTkVB0pmDABf186eHWGTdE=;
        b=fJFmJXLDe4euX1/0D8DUw2/FQjgOH/thuk5kNf22fv5VH8IuK7SC/Ir5QYZb4H0YJK
         xrHv/sc11SSg0AB0f0jVzKcM09Q5OBCQSxz9au4lktMMmwddHGikD16LA8tVniazOWi/
         hqf64EoEEuvFhJkkBarIt+kFfgD0Y1D7MZlZm2adjPlz8etqWK7rW2ueYQpnacbbpQ2O
         KTIvqEFJ+0MYMjrI+rw227YXqZzJVFs8MK90Tk8q9w1zd3+yOeDN3+d+gy7uzcGyr1p3
         Q1V8f14DspmtVBe78faLgmytxzS8cSBNBUweE4APP+p7r1pXKlLSIY7p7ZAkqhkK2TOR
         WGdg==
X-Forwarded-Encrypted: i=1; AJvYcCUmOX4fFtlRqUTgYEa9lbRR+i8eFoXOxdcf8Ao+hhBt5uO9wEFIwHroAdrdQcGCHRwUNticjEKzSGxnIoUYx4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkoggrhcy7rJMq1x6MdKhte7Ilxp/MznlA2f0DtFqscutaVDE
	C3z93h9yONkKY2WH4wX+gFbCIIQbslPFcQPIsOuYa/R3GrXGGdG9fSpH
X-Gm-Gg: AY/fxX7csUrWQ6tS2VFO2v4nGXExfRCZ2vr2gjrGtoZzm+FUYtLBT8wMzCwKxm65QLZ
	HNZApvtGUFXsorn3KmNCaau50aYX5XAu/UoNp9CndkdJsFToZzl6gKw9Eub42DEAHqW1CAPdTWU
	9ulpkK9yb7Z5WhV+XksZLjl9CiYzzHT/hwc3pnA9QCX+ySpfHLOfeWdop6RA8NRx6W4+q1T9vkZ
	5dKZAqQIyteVq6qyHy1KjoWV3NxzFj/ZnvkQy80xR9BDGHVFPQ3S2J4S44EGaOFIzScxiebzsON
	LNstJgYloe7CsAlM3L92Hpyiz1nAcQwR0r+H18dqYt9wsDSUe1e5yDsu3q2GS+wRU1ztzU9ItL4
	SSZAjHNu+/BRRF3jxNpHdOoBJ4D0zEurDQnuhhPLN8Zfjg5vsQhkAziIWWNV3alzdk69PbMzgEy
	BdZm0hQcVauFxVFMhiDzLewzxuuL5/P+XYj66IU9q47msf/eoPJTSM
X-Received: by 2002:a05:600c:8011:b0:47e:dddc:3369 with SMTP id 5b1f17b1804b1-4803e801e7dmr41628015e9.35.1768938239676;
        Tue, 20 Jan 2026 11:43:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae723sm4398574f8f.41.2026.01.20.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:43:59 -0800 (PST)
Date: Tue, 20 Jan 2026 19:43:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, Brian Gerst
 <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 10/19] x86/kvm: Use RIP-relative addressing
Message-ID: <20260120194358.1bd909fa@pumpkin>
In-Reply-To: <aW-1mv3OU-GcRyAQ@google.com>
References: <20260108092526.28586-21-ardb@kernel.org>
	<20260108092526.28586-31-ardb@kernel.org>
	<aW-1mv3OU-GcRyAQ@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 09:04:26 -0800
Sean Christopherson <seanjc@google.com> wrote:

> On Thu, Jan 08, 2026, Ard Biesheuvel wrote:
> > Replace absolute references in inline asm with RIP-relative ones, to
> > avoid the need for relocation fixups at boot time. This is a
> > prerequisite for PIE linking, which only permits 64-bit wide
> > loader-visible absolute references.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/kvm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index df78ddee0abb..1a0335f328e1 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -807,8 +807,9 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
> >   * restoring to/from the stack.
> >   */
> >  #define PV_VCPU_PREEMPTED_ASM						     \
> > - "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
> > - "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
> > + "0:leaq 0b(%rip), %rax\n\t"						     \  
> 
> Please use something other than '0' for the label, it took me forever (and looking
> at disassembly) to realize "0b" was just a backwards label and not some fancy
> syntax I didn't know.

I remember taking a while to grok that as well.

Can't you just use . as in:
	leaq	.(%rip), %rax

shame the assembler doesn't understand:
	movq	%rip, %rax
(maybe it does...)

	David
