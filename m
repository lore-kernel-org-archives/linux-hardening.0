Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777381422CE
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688813; cv=none; b=F077kuWPSR+HekdiQEVLBvRaku4SOMcwHlL6eKiEjd+OJoztxUAXvNTid/9vfBqLswXQcdYTj7gr1G6kYGWiwRwvQeTJea//UMVRkK4AqjJHLsDZ7zGx59eUrUwd6dH7sZeqGW/NhSAqz0WueGBlnW6569/F6JzlkW6D7Lk3AVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688813; c=relaxed/simple;
	bh=ndqDakJeUVibqBthQj6MLhOYHID5w0Dp0CWxFqOMqyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1NMS35HzD2MkSQ2sWB9SJg7+pa+VejLwQq5bqpC7aXiiTSb4kM2JwW8wA/PGH8kMtScnBb4sprPPcwTZCvc9bYBR7tcdqbGkcBd1gSkK5vAKiWPaJa0EYg1Z5dcdcOQRvdl9sLXxgfpsCbMs4Duad3ZT2jgCTAxC+MV5L8iArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5Lzob+T; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5Lzob+T"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-81022501a12so946132241.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720688810; x=1721293610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehnNMNXfvb4vki4ExU1sjmRzfNAU6K60o3BlICJME1k=;
        b=h5Lzob+TDQLhCuqtJr1FMQf1BR/dtd7ejdJBBiaoLmP9b3jVT/SQ20hhX7jFgma0YU
         oWUr/fmR6avU1dsSH9Pdqp5dhybJVdpH2ZkGbNg+RnDMrmTwrHPlcKMNwLS6MtiNP8AB
         ZafqHdlG+/8NmuWWmy8Fy/r9WY/SYfE355tGD5tp0tlI1T2nPvhhUN0p6Z2eev+jBfBq
         MItsy94PO8+Hic5i5VS4VRzHKn6orWkT+X7hnmw76e+iMq9NSv1vUxNlXQ9iJ37t0YXo
         aLCYiw4udzXVnDB+wzEWpbrXbrqxKl/v/8VyozY8I+MRAGFgbywMvBhay9Kz/QGc9T/p
         o2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688810; x=1721293610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehnNMNXfvb4vki4ExU1sjmRzfNAU6K60o3BlICJME1k=;
        b=LsAr7eHDtsKhlBr+ab9oyDKPFgDgH7kNq196TCJSQkFhloDo3tkur5Gk6LP+fW/X82
         ddmjMrD8KwojHgt/RCfewapKtXT4HFRnrKacadcUkmlNpQCllf9UhH4ld6achjhm1CPS
         y922mqMyCv32lY26kODX5dsvzGSyl7Wv4AlY1pAHvnMtUNeOa/RBakcaP5LRbpKaDidz
         HYNM4DcLQw61rD7Kd5j+IshQcqh0KFWOMw6hrZuRcb9uUAQj1EWXQbHgjICr/2Y0nksh
         IEHjfFPmpV84zPrtf9NXXQJ+tL1EPWmDRw3BnDGFCwvr2PckAtWPVMo5a4RT1xfzCcuB
         XFlw==
X-Forwarded-Encrypted: i=1; AJvYcCWi3WwUsSwYP9ACilOXBIYBzmVzOjh+tIOnXeqH9ig1dKvr3dWhQUHwGk0lRX8U2MZ8iFI2S1TxEy22irNlGP4QH2emzfYqD8Ecww96sWKA
X-Gm-Message-State: AOJu0YwgZ3iZ91CcrqVs9kfeWIE4LYaq0HHKk6zLEsADbM+Q6GWFU/ZO
	yBu4vWV+YAz+s2mT2YPIpe3CjEb/rKX4tpomR4aVC8FjbbSG34xif0yphhH07C6oXomtodXbD6k
	Noz5e9Pe+PTv5oU/6gqI6zoZAsaYdyZ4zOlDD
X-Google-Smtp-Source: AGHT+IEzZXxlgACZZ2LkFBwiR1DKvLCA9FwFFgt9xwq1LOgCBOB03gm4IqBFDxgiH5jjg/c9tVlvGnhMo1yOb3sPchQ=
X-Received: by 2002:a05:6102:3e02:b0:48f:968b:1714 with SMTP id
 ada2fe7eead31-491119541f8mr377121137.11.1720688810066; Thu, 11 Jul 2024
 02:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710203250.238782-1-gatlin.newhouse@gmail.com> <20240711081031.GB4587@noisy.programming.kicks-ass.net>
In-Reply-To: <20240711081031.GB4587@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Jul 2024 11:06:12 +0200
Message-ID: <CANpmjNObEzShHvw19EAntPvCYJbqezKBq+pB=mkd7j3sXDEE7A@mail.gmail.com>
Subject: Re: [PATCH v4] x86/traps: Enable UBSAN traps on x86
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Pengfei Xu <pengfei.xu@intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Changbin Du <changbin.du@huawei.com>, Xin Li <xin3.li@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, t.p.northover@gmail.com, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 10, 2024 at 08:32:38PM +0000, Gatlin Newhouse wrote:
> > Currently ARM architectures extract which specific sanitizer
> > has caused a trap via encoded data in the trap instruction.
> > Clang on x86 currently encodes the same data in ud1 instructions
> > but the x86 handle_bug() and is_valid_bugaddr() functions
> > currently only look at ud2s.
> >
> > Bring x86 to parity with arm64, similar to commit 25b84002afb9
> > ("arm64: Support Clang UBSAN trap codes for better reporting").
> > Enable the reporting of UBSAN sanitizer detail on x86 architectures
> > compiled with clang when CONFIG_UBSAN_TRAP=y.
>
> Can we please get some actual words on what code clang will generate for
> this? This doesn't even refer to the clang commit.
>
> How am I supposed to know if the below patch matches what clang will
> generate etc..

I got curious what the history of this is - I think it was introduced
in https://github.com/llvm/llvm-project/commit/c5978f42ec8e9, which
was reviewed here: https://reviews.llvm.org/D89959

But besides that, there's very little documentation. Either Gatlin or
one of the other LLVM folks might have more background, but we might
be out of luck if that 1 commit is all there is.

[+Cc Tim, author of the LLVM commit]

> > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > index a3ec87d198ac..ccd573d58edb 100644
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -13,6 +13,17 @@
> >  #define INSN_UD2     0x0b0f
> >  #define LEN_UD2              2
> >
> > +/*
> > + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> > + */
> > +#define INSN_ASOP    0x67
>
> I asked, but did not receive answer, *WHY* does clang add this silly
> prefix? AFAICT this is entirely spurious and things would be simpler if
> we don't have to deal with it.
>
> > +#define OPCODE_PREFIX        0x0f
>
> This is *NOT* a prefix, it is an escape, please see the SDM Vol 2
> Chapter 'Instruction Format'. That ASOP thing above is a prefix.
>
> > +#define OPCODE_UD1   0xb9
> > +#define OPCODE_UD2   0x0b
>
> These are second byte opcodes. The actual (single byte opcodes) of those
> value exist and are something entirely different (0xB0+r is MOV, and
> 0x0B is OR).
>
> > +#define BUG_NONE     0xffff
> > +#define BUG_UD1              0xfffe
> > +#define BUG_UD2              0xfffd
>
> These are return codes and not related to the defines above and as such
> should be separated from them with some whitespace.
>
> > +
> >  #ifdef CONFIG_GENERIC_BUG
> >
> >  #ifdef CONFIG_X86_32
> > diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
> > new file mode 100644
> > index 000000000000..ac2080984e83
> > --- /dev/null
> > +++ b/arch/x86/include/asm/ubsan.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_UBSAN_H
> > +#define _ASM_X86_UBSAN_H
> > +
> > +/*
> > + * Clang Undefined Behavior Sanitizer trap mode support.
> > + */
> > +#include <linux/bug.h>
> > +#include <linux/ubsan.h>
> > +#include <asm/ptrace.h>
> > +
> > +/*
> > + * UBSAN uses the EAX register to encode its type in the ModRM byte.
>
> This is a claim, but I have nothing to verify this against. I mean, I
> could go trawl through the clang sources, but this really should be part
> of the changelog to explain the clang code generation.
>
> > + */
> > +#define UBSAN_REG    0x40
>
> This is a ModRM byte, not a REG. The REG encoded therein is 0.
>
> > +
> > +#ifdef CONFIG_UBSAN_TRAP
> > +void handle_ubsan_failure(struct pt_regs *regs, u16 insn);
> > +#else
> > +static inline void handle_ubsan_failure(struct pt_regs *regs, u16 insn) { return; }
> > +#endif /* CONFIG_UBSAN_TRAP */
> > +
> > +#endif /* _ASM_X86_UBSAN_H */
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 74077694da7d..fe1d9db27500 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -145,6 +145,7 @@ obj-$(CONFIG_UNWINDER_GUESS)              += unwind_guess.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)                += sev.o
> >
> >  obj-$(CONFIG_CFI_CLANG)                      += cfi.o
> > +obj-$(CONFIG_UBSAN_TRAP)             += ubsan.o
> >
> >  obj-$(CONFIG_CALL_THUNKS)            += callthunks.o
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 4fa0b17e5043..b6664016622a 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -67,6 +67,7 @@
> >  #include <asm/vdso.h>
> >  #include <asm/tdx.h>
> >  #include <asm/cfi.h>
> > +#include <asm/ubsan.h>
> >
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -91,6 +92,45 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
> >       return *(unsigned short *)addr == INSN_UD2;
> >  }
> >
> > +/*
> > + * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
> > + * If it's a UD1, get the ModRM byte to pass along to UBSan.
> > + */
> > +__always_inline int decode_bug(unsigned long addr, u32 *imm)
> > +{
> > +     u8 v;
> > +
> > +     if (addr < TASK_SIZE_MAX)
> > +             return BUG_NONE;
> > +
> > +     v = *(u8 *)(addr++);
> > +     if (v == INSN_ASOP)
> > +             v = *(u8 *)(addr++);
> > +     if (v != OPCODE_PREFIX)
> > +             return BUG_NONE;
> > +
> > +     v = *(u8 *)(addr++);
> > +     if (v == OPCODE_UD2)
> > +             return BUG_UD2;
> > +     if (v != OPCODE_UD1)
> > +             return BUG_NONE;
> > +
> > +     v = *(u8 *)(addr++);
> > +     if (X86_MODRM_RM(v) == 4)
> > +             addr++;
> > +
> > +     *imm = 0;
> > +     if (X86_MODRM_MOD(v) == 1)
> > +             *imm = *(u8 *)addr;
> > +     else if (X86_MODRM_MOD(v) == 2)
> > +             *imm = *(u32 *)addr;
> > +     else
> > +             WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
> > +
> > +     return BUG_UD1;
> > +}
> > +
> > +
> >  static nokprobe_inline int
> >  do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
> >                 struct pt_regs *regs, long error_code)
> > @@ -216,6 +256,8 @@ static inline void handle_invalid_op(struct pt_regs *regs)
> >  static noinstr bool handle_bug(struct pt_regs *regs)
> >  {
> >       bool handled = false;
> > +     int ud_type;
> > +     u32 imm;
> >
> >       /*
> >        * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
> > @@ -223,7 +265,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
> >        * irqentry_enter().
> >        */
> >       kmsan_unpoison_entry_regs(regs);
> > -     if (!is_valid_bugaddr(regs->ip))
> > +     ud_type = decode_bug(regs->ip, &imm);
> > +     if (ud_type == BUG_NONE)
> >               return handled;
> >
> >       /*
> > @@ -236,10 +279,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
> >        */
> >       if (regs->flags & X86_EFLAGS_IF)
> >               raw_local_irq_enable();
> > -     if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > -         handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > -             regs->ip += LEN_UD2;
> > -             handled = true;
> > +     if (ud_type == BUG_UD2) {
> > +             if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > +                 handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > +                     regs->ip += LEN_UD2;
> > +                     handled = true;
> > +             }
> > +     } else {
> > +             handle_ubsan_failure(regs, imm);
> >       }
> >       if (regs->flags & X86_EFLAGS_IF)
> >               raw_local_irq_disable();
> > diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> > new file mode 100644
> > index 000000000000..c90e337a1b6a
> > --- /dev/null
> > +++ b/arch/x86/kernel/ubsan.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Clang Undefined Behavior Sanitizer trap mode support.
> > + */
> > +#include <linux/bug.h>
> > +#include <linux/string.h>
> > +#include <linux/printk.h>
> > +#include <linux/ubsan.h>
> > +#include <asm/ptrace.h>
> > +#include <asm/ubsan.h>
> > +
> > +/*
> > + * Checks for the information embedded in the UD1 trap instruction
> > + * for the UB Sanitizer in order to pass along debugging output.
> > + */
> > +void handle_ubsan_failure(struct pt_regs *regs, u16 type)
> > +{
> > +     if ((type & 0xFF) == UBSAN_REG)
> > +             type >>= 8;
>
> This makes no sense, we've consumed the ModRM byte ealier, this should
> really only ever get the immediate.
>
> > +     pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> > +}
> > --
> > 2.25.1
> >
