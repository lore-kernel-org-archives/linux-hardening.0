Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4FF9EF;
	Mon,  3 Jun 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431239; cv=none; b=nD31sSjUN/iVhSu+Li8+Wd5lLmZClQVHxM8JZm7zfpiV1EL6goiqo5oWzuFJnvS317lKkc32yK/6cuCMRcKeSwESK97UT1ZONIbMbbH78SWtCJzAzDpHZQ9nVWQEUHCxkrmIe/fbPsK/vilQwVlZZmR5OuzDqu2xdfbomTutHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431239; c=relaxed/simple;
	bh=/Nbr+owWYREElZ+Q0mbfwVbveFRjO/m10UrMZYRRH8s=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqxlwkPQRfPB/OqA7pk9JOEFHZHYriEVw3yfjve/+dcWb7yLzf6I57rPIY+5jTgUaC24730kpLHsvfhv1WFMtfzw1p60eWM5qNw+u83gIFQ1v8BZ9KVrkPQJd5uPFlQmDHlGATZfkYGjCPXDFyKNGw3FSc/TroRoRkysDeCv4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jtIS63tC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=me2lGRgz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jtIS63tC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="me2lGRgz"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717431233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCBBZJLHh7XXomoDX6GxiwpPupsy6ADT629bR0qasGs=;
	b=jtIS63tCYfjWvRU2Igs6e0UiizUnhuCkfFZs3qPlIHqtVqv1P2rvMXYBDu6Ho4ip2ZJiIs
	QQrKBiytMw7j3yAMyee/qzLdmx0rNLosIMUbpnSKhOCwpmZCbIRX6xravFOxE/LpfzmM4Y
	nVI+FwbEQ8bXE0EbKpcMDBDl0uJku8JxpFg+CB54Tk0h05oW8UostXsaqlqRopamZwyPMi
	SuJQOlRGbSJIELdLuGNTICffRgkvnxuMXzUgrD85EzMfwdYhu56+Nq8G+/x5YRg6tDSFgo
	cFkX5cuiDnFsBeRWAeKYDtk5XvcgbGA862p2FvGlTiXCyxaQKkTD56dGhIGCdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717431233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCBBZJLHh7XXomoDX6GxiwpPupsy6ADT629bR0qasGs=;
	b=me2lGRgztqsDfCutkLB/uTn+8yycRq2sYAB3UNAJXjHf2Mj3i961nVH4l7zjVaer9RHxe2
	tiaYHkoHLSmsmrBg==
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Marco Elver
 <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey
 Ryabinin <ryabinin.a.a@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Gatlin Newhouse
 <gatlin.newhouse@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Baoquan He <bhe@redhat.com>,
 Changbin Du <changbin.du@huawei.com>, Pengfei Xu <pengfei.xu@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>, Uros Bizjak
 <ubizjak@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
In-Reply-To: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
Date: Mon, 03 Jun 2024 18:13:53 +0200
Message-ID: <878qzm6m2m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 01 2024 at 03:10, Gatlin Newhouse wrote:

> Bring x86 to parity with arm64, similar to commit 25b84002afb9
> ("arm64: Support Clang UBSAN trap codes for better reporting").
> Enable the output of UBSAN type information on x86 architectures
> compiled with clang when CONFIG_UBSAN_TRAP=y. Currently ARM
> architectures output which specific sanitizer caused the trap,
> via the encoded data in the trap instruction. Clang on x86
> currently encodes the same data in ud1 instructions but the x86
> handle_bug() and is_valid_bugaddr() functions currently only look
> at ud2s.

Please structure your change log properly instead of one paragraph of
unstructured word salad. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
  
> +/*
> + * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
> + */
>  __always_inline int is_valid_bugaddr(unsigned long addr)
>  {
>  	if (addr < TASK_SIZE_MAX)
> @@ -88,7 +92,13 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
>  	 * We got #UD, if the text isn't readable we'd have gotten
>  	 * a different exception.
>  	 */
> -	return *(unsigned short *)addr == INSN_UD2;
> +	if (*(u16 *)addr == INSN_UD2)
> +		return INSN_UD2;
> +	if (*(u16 *)addr == INSN_UD1)
> +		return INSN_UD1;
> +	if (*(u8 *)addr == INSN_ASOP && *(u16 *)(addr + 1) == INSN_UD1)

	s/1/LEN_ASOP/ ?

> +		return INSN_ASOP;
> +	return 0;

I'm not really a fan of the reuse of the INSN defines here. Especially
not about INSN_ASOP. Also 0 is just lame.

Neither does the function name make sense anymore. is_valid_bugaddr() is
clearly telling that it's a boolean check (despite the return value
being int for hysterical raisins). But now you turn it into a
non-boolean integer which returns a instruction encoding. That's
hideous. Programming should result in obvious code and that should be
pretty obvious to people who create tools to validate code.

Also all UBSAN cares about is the actual failure type and not the
instruction itself:

#define INSN_UD_MASK		0xFFFF
#define INSN_ASOP_MASK		0x00FF

#define BUG_UD_NONE		0xFFFF
#define BUG_UD2			0xFFFE

__always_inline u16 get_ud_type(unsigned long addr)
{
	u16 insn;

	if (addr < TASK_SIZE_MAX)
        	return BUD_UD_NONE;

        insn = *(u16 *)addr;
        if ((insn & INSN_UD_MASK) == INSN_UD2)
        	return BUG_UD2;

	if ((insn & INSN_ASOP_MASK) == INSN_ASOP)
        	insn = *(u16 *)(++addr);

	// UBSAN encodes the failure type in the two bytes after UD1
        if ((insn & INSN_UD_MASK) == INSN_UD1)
        	return *(u16 *)(addr + LEN_UD1);

	return BUG_UD_NONE;
}

No?

>  static nokprobe_inline int
> @@ -216,6 +226,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>  static noinstr bool handle_bug(struct pt_regs *regs)
>  {
>  	bool handled = false;
> +	int insn;
>  
>  	/*
>  	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
> @@ -223,7 +234,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  	 * irqentry_enter().
>  	 */
>  	kmsan_unpoison_entry_regs(regs);
> -	if (!is_valid_bugaddr(regs->ip))
> +	insn = is_valid_bugaddr(regs->ip);
> +	if (insn == 0)

Sigh.

But with the above sanitized (pun intended) this becomes obvious by
itself:

        ud_type = get_ud_type(regs->ip);
        if (ud_type == BUG_UD_NONE)
        	return false;

See?

>  		return handled;
>  
>  	/*
> @@ -236,10 +248,15 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  	 */
>  	if (regs->flags & X86_EFLAGS_IF)
>  		raw_local_irq_enable();
> -	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -		regs->ip += LEN_UD2;
> -		handled = true;
> +
> +	if (insn == INSN_UD2) {
> +		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> +		handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {

Please indent the second condition properly:

       if (a ||
           b) {

I know you just added another tab, but when touching code, then please
do it right.

> +			regs->ip += LEN_UD2;
> +			handled = true;

> +/*
> + * Checks for the information embedded in the UD1 trap instruction
> + * for the UB Sanitizer in order to pass along debugging output.
> + */
> +void handle_ubsan_failure(struct pt_regs *regs, int insn)
> +{
> +	u32 type = 0;

Pointless initialization.

> +	if (insn == INSN_ASOP) {
> +		type = (*(u16 *)(regs->ip + LEN_ASOP + LEN_UD1));
> +		if ((type & 0xFF) == 0x40)

No magic constants please. What does 0x40 mean?

> +			type = (type >> 8) & 0xFF;

That mask is pointless as u16 is zero extended when assigned to u32, but
why not using u16 in the first place to make it clear?

> +	} else {
> +		type = (*(u16 *)(regs->ip + LEN_UD1));
> +		if ((type & 0xFF) == 0x40)
> +			type = (type >> 8) & 0xFF;
> +	}

Copy & pasta rules!

	unsigned long addr = regs->ip + LEN_UD1;
	u16 type;

        type = insn == INSN_UD1 ? *(u16 *)addr : *(u16 *)(addr + LEN_ASOP);

	if ((type & 0xFF) == UBSAN_MAGICALLY_USE_2ND_BYTE)
		type >>= 8;
	pr_crit("%s\n", report_ubsan_failure(regs, type));

I don't see the point for printing regs->ip as this is followed by a
stack trace anyway, but I don't have a strong opinion about it either.

Though with the above get_ud_type() variant this becomes even simpler:

void handle_ubsan_failure(struct pt_regs *regs, u16 type)
{
	if ((type & 0xFF) == UBSAN_MAGICALLY_USE_2ND_BYTE)
		type >>= 8;
	pr_crit("%s\n", report_ubsan_failure(regs, type));
}

Thanks,

        tglx
