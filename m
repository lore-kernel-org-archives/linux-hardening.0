Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61980607;
	Tue, 11 Jun 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137573; cv=none; b=XwR1iljKS03PCDCjlvF7tJm8mYfta/QuRNc/s21Ho8XvOTAdSgcXqs+2X9Z46KrRQ7hiWdBI0/TfCH37ae/mSeStZl44Txt+3Z2JL61F6S0x2ytatb913wVvRYpUZc8vymfSzZ3RuC8TUW++3/OJQXWJUQtGCQstUq/03ZlvJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137573; c=relaxed/simple;
	bh=JMTFgY1cI+CthfUehxwtujjdODCqPHwELag77EPhroQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaZTu3fS7zdTfGRg6dezi6uxPAv2q28BD1qwFB35c4LSMf739GoMfTWD2pz+5APOp1O/eU877L3R3JfXfdVQ6x0XnQuTOHamq7P1RLURRBOB66qMTwRve75lwkrJMhGZBQ/E9GY6u4HkMNeiptr3xGI5SnpcRU+pqALCHGpdfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwLnkTKy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwLnkTKy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f44b594deeso51305345ad.2;
        Tue, 11 Jun 2024 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718137571; x=1718742371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiuNTA4whcExw8Dugs1FyNFiaWA9GU3jWb1r5NfBRAE=;
        b=mwLnkTKy3fVDnDbOOJFS685XlQ/LfcDjpulcGFJag+bozWTn/yk13QP+XCTOgoGe7L
         Ke54KcsVffFDOTx2au7fOAgsLWyEA4X+621qkyBrLm7zC2LSq+PJnit5ZVNwE+UfI39a
         s8pfLXH1weBMGE+YegQdNlkePq8jWB213j9I1Q7tszLAmil1fByLETJDzxQVL0OLhE3E
         B+Hc9PEnqYN/UCauxDfemflJ7OJcVI5d1zt3Q1M+B7QnQJbeEojaMYnoFy7fNmV6nMm8
         +MPVD6qJctdpvI2LIih5OgyoreqC1pGxEjX6stOfWBwDSwl6pcrndLF7ZK5LVIM35AzZ
         P6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137571; x=1718742371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiuNTA4whcExw8Dugs1FyNFiaWA9GU3jWb1r5NfBRAE=;
        b=XWeT/ZpUib8c+Jcmo3MNM+NUlx3bj96tT5l0KjKqeAwZnqLNIwpShqN0xCyteEOMql
         MnAyWnjc0nlbRNaFDfjDuPvRDRwG/TUK6O1o6UnxB/Ud4aWX8KVq/4r9GuR9f0RpMye6
         kdERGjPdfAeJKrPZ8epBP7doVG0bTmyg0MEsSUBIClXX6uhZhCPMneVLtIM2GOIV1PTf
         IKGZnvmH+Xsa27juyxfafRerH7RIgkMeitYdLoUc/5vl0LE02dsrvm4cTpECRG4WNxBi
         WMGkrpjz4KDSPhZzj79GqY7EJcJ3448LwBVp2IAOtlzNs4fdJ1xfo0BraMybV5R5qSIU
         5u2A==
X-Forwarded-Encrypted: i=1; AJvYcCUQM/QoliXkybGqF6eXiu98dpa4L++5EJWRGjZ476b0Dve3xsboOrPnrxJVobcYGA4swE5j/jm3IEWaMbBw+mp0sc1mkTE7uql4ce7V4ZxZA0OQEvgYqLuVAN8sXKY9s4+k5O/mehosG26rUdDs
X-Gm-Message-State: AOJu0Yw/MvuYr4xmsZOb1gysPf8uGK1aVIvvrOM0c69RaYxGAHpKN6WY
	Wit0FSymr+G8LTdD5YKiIkZKuAOohEOFhIpcePFH1RjiOYa9fHU9
X-Google-Smtp-Source: AGHT+IHRUebSOuRjYylz+iYw16FfFlE7lh1Z9+3AMBtz4Z/gYW5lDsZSM5550YCv4ScVk5JKJrZ6mQ==
X-Received: by 2002:a17:903:1212:b0:1f6:6dc9:615c with SMTP id d9443c01a7336-1f6d02f4e65mr152389785ad.35.1718137571295;
        Tue, 11 Jun 2024 13:26:11 -0700 (PDT)
Received: from Gatlins-MacBook-Pro.local ([131.252.49.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72d450697sm20488005ad.168.2024.06.11.13.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:26:10 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:26:09 -0700
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Baoquan He <bhe@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
Message-ID: <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
 <878qzm6m2m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qzm6m2m.ffs@tglx>

On Mon, Jun 03, 2024 at 06:13:53PM UTC, Thomas Gleixner wrote:
> On Sat, Jun 01 2024 at 03:10, Gatlin Newhouse wrote:
> 
> > Bring x86 to parity with arm64, similar to commit 25b84002afb9
> > ("arm64: Support Clang UBSAN trap codes for better reporting").
> > Enable the output of UBSAN type information on x86 architectures
> > compiled with clang when CONFIG_UBSAN_TRAP=y. Currently ARM
> > architectures output which specific sanitizer caused the trap,
> > via the encoded data in the trap instruction. Clang on x86
> > currently encodes the same data in ud1 instructions but the x86
> > handle_bug() and is_valid_bugaddr() functions currently only look
> > at ud2s.
> 
> Please structure your change log properly instead of one paragraph of
> unstructured word salad. See:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
>   
> > +/*
> > + * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
> > + */
> >  __always_inline int is_valid_bugaddr(unsigned long addr)
> >  {
> >  	if (addr < TASK_SIZE_MAX)
> > @@ -88,7 +92,13 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
> >  	 * We got #UD, if the text isn't readable we'd have gotten
> >  	 * a different exception.
> >  	 */
> > -	return *(unsigned short *)addr == INSN_UD2;
> > +	if (*(u16 *)addr == INSN_UD2)
> > +		return INSN_UD2;
> > +	if (*(u16 *)addr == INSN_UD1)
> > +		return INSN_UD1;
> > +	if (*(u8 *)addr == INSN_ASOP && *(u16 *)(addr + 1) == INSN_UD1)
> 
> 	s/1/LEN_ASOP/ ?
> 
> > +		return INSN_ASOP;
> > +	return 0;
> 
> I'm not really a fan of the reuse of the INSN defines here. Especially
> not about INSN_ASOP. Also 0 is just lame.
> 
> Neither does the function name make sense anymore. is_valid_bugaddr() is
> clearly telling that it's a boolean check (despite the return value
> being int for hysterical raisins). But now you turn it into a
> non-boolean integer which returns a instruction encoding. That's
> hideous. Programming should result in obvious code and that should be
> pretty obvious to people who create tools to validate code.
> 
> Also all UBSAN cares about is the actual failure type and not the
> instruction itself:
> 
> #define INSN_UD_MASK		0xFFFF
> #define INSN_ASOP_MASK		0x00FF
> 
> #define BUG_UD_NONE		0xFFFF
> #define BUG_UD2			0xFFFE
> 
> __always_inline u16 get_ud_type(unsigned long addr)
> {
> 	u16 insn;
> 
> 	if (addr < TASK_SIZE_MAX)
>         	return BUD_UD_NONE;
> 
>         insn = *(u16 *)addr;
>         if ((insn & INSN_UD_MASK) == INSN_UD2)
>         	return BUG_UD2;
> 
> 	if ((insn & INSN_ASOP_MASK) == INSN_ASOP)
>         	insn = *(u16 *)(++addr);
> 
> 	// UBSAN encodes the failure type in the two bytes after UD1
>         if ((insn & INSN_UD_MASK) == INSN_UD1)
>         	return *(u16 *)(addr + LEN_UD1);
> 
> 	return BUG_UD_NONE;
> }
> 
> No?

Thanks for the feedback.

It seems that is_valid_bugaddr() needs to be implemented on all architectures
and the function get_ud_type() replaces it here. So how should the patch handle
is_valid_bugaddr()? Should the function remain as-is in traps.c despite no
longer being used?

> 
> >  static nokprobe_inline int
> > @@ -216,6 +226,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
> >  static noinstr bool handle_bug(struct pt_regs *regs)
> >  {
> >  	bool handled = false;
> > +	int insn;
> >  
> >  	/*
> >  	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
> > @@ -223,7 +234,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
> >  	 * irqentry_enter().
> >  	 */
> >  	kmsan_unpoison_entry_regs(regs);
> > -	if (!is_valid_bugaddr(regs->ip))
> > +	insn = is_valid_bugaddr(regs->ip);
> > +	if (insn == 0)
> 
> Sigh.
> 
> But with the above sanitized (pun intended) this becomes obvious by
> itself:
> 
>         ud_type = get_ud_type(regs->ip);
>         if (ud_type == BUG_UD_NONE)
>         	return false;
> 
> See?
> 
> >  		return handled;
> >  
> >  	/*
> > @@ -236,10 +248,15 @@ static noinstr bool handle_bug(struct pt_regs *regs)
> >  	 */
> >  	if (regs->flags & X86_EFLAGS_IF)
> >  		raw_local_irq_enable();
> > -	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > -	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > -		regs->ip += LEN_UD2;
> > -		handled = true;
> > +
> > +	if (insn == INSN_UD2) {
> > +		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > +		handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> 
> Please indent the second condition properly:
> 
>        if (a ||
>            b) {
> 
> I know you just added another tab, but when touching code, then please
> do it right.
> 
> > +			regs->ip += LEN_UD2;
> > +			handled = true;
> 
> > +/*
> > + * Checks for the information embedded in the UD1 trap instruction
> > + * for the UB Sanitizer in order to pass along debugging output.
> > + */
> > +void handle_ubsan_failure(struct pt_regs *regs, int insn)
> > +{
> > +	u32 type = 0;
> 
> Pointless initialization.
> 
> > +	if (insn == INSN_ASOP) {
> > +		type = (*(u16 *)(regs->ip + LEN_ASOP + LEN_UD1));
> > +		if ((type & 0xFF) == 0x40)
> 
> No magic constants please. What does 0x40 mean?
> 
> > +			type = (type >> 8) & 0xFF;
> 
> That mask is pointless as u16 is zero extended when assigned to u32, but
> why not using u16 in the first place to make it clear?
> 
> > +	} else {
> > +		type = (*(u16 *)(regs->ip + LEN_UD1));
> > +		if ((type & 0xFF) == 0x40)
> > +			type = (type >> 8) & 0xFF;
> > +	}
> 
> Copy & pasta rules!
> 
> 	unsigned long addr = regs->ip + LEN_UD1;
> 	u16 type;
> 
>         type = insn == INSN_UD1 ? *(u16 *)addr : *(u16 *)(addr + LEN_ASOP);
> 
> 	if ((type & 0xFF) == UBSAN_MAGICALLY_USE_2ND_BYTE)
> 		type >>= 8;
> 	pr_crit("%s\n", report_ubsan_failure(regs, type));
> 
> I don't see the point for printing regs->ip as this is followed by a
> stack trace anyway, but I don't have a strong opinion about it either.
> 
> Though with the above get_ud_type() variant this becomes even simpler:
> 
> void handle_ubsan_failure(struct pt_regs *regs, u16 type)
> {
> 	if ((type & 0xFF) == UBSAN_MAGICALLY_USE_2ND_BYTE)
> 		type >>= 8;
> 	pr_crit("%s\n", report_ubsan_failure(regs, type));
> }
> 
> Thanks,
> 
>         tglx
