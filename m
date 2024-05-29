Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4115B990
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007462; cv=none; b=YlD1oWq+XT59GeN8eGQsByvAWAPkeXuxbDxoqYx2J7ve8JBnopDkfG7JMbDYgAVKK2miN2t0IGoujGn5ngALEWbocajw8c+2baOsZjmUXmuHIIzrI9LoTFbVpaewtoRlGeCWfGewopGGnZnZBZX1D7ydX83Ulg6imjRpzGOiP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007462; c=relaxed/simple;
	bh=xLHwHLiHwsZx+FhZZLfeHLdBEMSp5gCenfiAHTRJLOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5mTK6P9EAjUi5rHGJML5hDT2rZ09DeA1DK2+koNDEZvZ446BTIGoBH8v+xuDkLBW2xU+ZWm2IqgOxxgvtf+hH9f6sHY7jSZ/qZvdCErM0oA4F3nzlvjJzt80dRILzxA+1g7rrwv6jKQxmimt8MZqQ4zmcysEv1efWsxdO5+mho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmvkvasI; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmvkvasI"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4e966657346so16651e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717007459; x=1717612259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbCogX4lIMiJS1kYrrISzNNe/fzp3T/RrkQJx2fP6us=;
        b=FmvkvasIb7QIU5//bM7TVQP68+pNWyHsxsan1yckeGsciYJ5cKoDYuv6HeF5kHOV/K
         +LCdoB5w0MD5hOboBA1tXftwbhD/5vVvcM69Zk4fUbUm3jroZ+0hPtZnEVj2becnpj2V
         9aJDjP7pgQZk0EZvXL0fEeO0UStrovc8jppv5MzfSaCAp+H9dOXrBmj6eFZosK0v8dU6
         VMGGIT2rXsr7h9hDowBYe63yikLQR4+jmARISScPX8s0+YACIjkJutagcREDcS5ZPRzP
         arRAHa7XNkAeVaXy6lzaFiXnJIA5FIxRLO3QmMk3DJTeHVy43vgZ9fByswXLZyONiz+S
         Swdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007459; x=1717612259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbCogX4lIMiJS1kYrrISzNNe/fzp3T/RrkQJx2fP6us=;
        b=tgmsJmUHyhQ44I6ADRE3+Pdi8FXk+zHbkUE7zStxu+7pX+8YyxkKiCIDtNhJ/rg4/h
         xBI6L8naYiNGlx0EX/D4mm1dvmuxBo0RRxrDLjn3UuMrAL3oUcTDqLWwZqvSt7DuM75I
         VKttue2GW1AKLwp8d88jMbod5eLcD2g6TyZdNhUqqRe1vVqTS8vg801sUbOXQzEuBvg2
         lbqzX91cQDvhr9JZBJEbtnaV/aBiY3pHmIIsHIBq+CACC2GNQzibXlRWP8PPBY83v2TR
         huqYq3RzjRsnOigrqTmBeMrNP88/o4yL5XSiOgLdU8n28RSBuKcr39T3NVX/OVS90sUX
         25kw==
X-Forwarded-Encrypted: i=1; AJvYcCWs1oNLTfM2G4iRvncQWUbhZc+NMpAo9TYVqCq6Lig6XoWI94m3UVB6uSfMSBZ4qLCAKTNm5qmQK+iOog23iUYkHbXyYHRH+fXO0hMC4dIH
X-Gm-Message-State: AOJu0YzHZj5r2Tm9pd/6ZtSxZkrlFC7l+4K4e6ZMOKOA97m71rRKu4e8
	/eaFK11U8cFm0CQbkXKFIgSNYvqfO1REO019mKYF1mLYR0Nx/TvDfTj60B5HedQL5bRs1BYatzd
	iP46yVbGVI6oJGkj0znwnnLEMclKnP4wbPFQs
X-Google-Smtp-Source: AGHT+IGtZHprsq6fYM3tx1dScCSyP3wPP1H6jiiJYrOGEM1B4J1TT4TyWpCHTA4j0Wg1/LCu7lkpj4ZpsvaVNOZD1A8=
X-Received: by 2002:a05:6122:168e:b0:4df:261c:fc0c with SMTP id
 71dfb90a1353d-4e4f02e650cmr15206852e0c.13.1717007459290; Wed, 29 May 2024
 11:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
 <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com> <2j6nkzn2tfdwdqhoal5o56ds2hqg2sqk5diolv23l5nzteypzh@fi53ovwjjl3w>
In-Reply-To: <2j6nkzn2tfdwdqhoal5o56ds2hqg2sqk5diolv23l5nzteypzh@fi53ovwjjl3w>
From: Marco Elver <elver@google.com>
Date: Wed, 29 May 2024 20:30:20 +0200
Message-ID: <CANpmjNM4pFHYRqmBLi0qUm8K2SroYWg7NFjreHffHvk0WW95kA@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 20:17, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
>
> On Wed, May 29, 2024 at 09:25:21AM UTC, Marco Elver wrote:
> > On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > [...]
> > >         if (regs->flags & X86_EFLAGS_IF)
> > >                 raw_local_irq_enable();
> > > -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > -               regs->ip += LEN_UD2;
> > > -               handled = true;
> > > +
> > > +       if (insn == INSN_UD2) {
> > > +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > +                       regs->ip += LEN_UD2;
> > > +                       handled = true;
> > > +               }
> > > +       } else {
> > > +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> >
> > handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?
> >
> > > +                       if (insn == INSN_REX)
> > > +                               regs->ip += LEN_REX;
> > > +                       regs->ip += LEN_UD1;
> > > +                       handled = true;
> > > +               }
> > >         }
> > >         if (regs->flags & X86_EFLAGS_IF)
> > >                 raw_local_irq_disable();
> > > diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> > > new file mode 100644
> > > index 000000000000..6cae11f4fe23
> > > --- /dev/null
> > > +++ b/arch/x86/kernel/ubsan.c
> > > @@ -0,0 +1,32 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Clang Undefined Behavior Sanitizer trap mode support.
> > > + */
> > > +#include <linux/bug.h>
> > > +#include <linux/string.h>
> > > +#include <linux/printk.h>
> > > +#include <linux/ubsan.h>
> > > +#include <asm/ptrace.h>
> > > +#include <asm/ubsan.h>
> > > +
> > > +/*
> > > + * Checks for the information embedded in the UD1 trap instruction
> > > + * for the UB Sanitizer in order to pass along debugging output.
> > > + */
> > > +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> > > +{
> > > +       u32 type = 0;
> > > +
> > > +       if (insn == INSN_REX) {
> > > +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> > > +               if ((type & 0xFF) == 0x40)
> > > +                       type = (type >> 8) & 0xFF;
> > > +       } else {
> > > +               type = (*(u16 *)(regs->ip + LEN_UD1));
> > > +               if ((type & 0xFF) == 0x40)
> > > +                       type = (type >> 8) & 0xFF;
> > > +       }
> > > +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> > > +
> > > +       return BUG_TRAP_TYPE_NONE;
> > > +}
> >
> > Shouldn't this return BUG_TRAP_TYPE_WARN?
>
> So as far as I understand, UBSAN trap mode never warns. Perhaps it does on
> arm64, although it calls die() so I am unsure. Maybe the condition in
> handle_bug() should be rewritten in the case of UBSAN ud1s? Do you have any
> suggestions?

AFAIK on arm64 it's basically a kernel OOPS.

The main thing I just wanted to point out though is that your newly added branch

> if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {

will never be taken, because I don't see where handle_ubsan_failure()
returns BUG_TRAP_TYPE_WARN.

That means 'handled' will be false, and the code in exc_invalid_op
will proceed to call handle_invalid_op() which is probably not what
you intended - i.e. it's definitely not BUG_TRAP_TYPE_NONE, but one of
TYPE_WARN of TYPE_BUG.

Did you test it and you got the behaviour you expected?
