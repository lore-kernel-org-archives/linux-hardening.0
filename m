Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB5167D94
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967562; cv=none; b=imCVB/epUflsgoDf0KReQO8sPQJJoINUBba4o4YkbkrPlujHqHrtNte9rZJU6EOND7NDswXoMTZPnHsDrojW9eu2BmDLlp1vBwL2ENUMMrPFJ6jeOd1QM578v4gg/NUPHbl3rL2cOI5Kg2E1maRGCjv2asRlTt2UfUP7sY6YR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967562; c=relaxed/simple;
	bh=ZEVr1l/zLyARsxNs4P1butY5hWf3rmFo/maylE+sV1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgugjIHpaqCKDzO65MEcIBcfdhCGeM/lC1wDvWWya5myTIPlYw8Rqj1uJ+FauSnDjjIOqpbjUUbySXQ5ffXtroys3aZpxx6KiQVmZAsHfrEtYABnNkSvu3Q3X+GkE3UKWouD4sZ1yA2YeArEKZuvcSFwYnlHbPeLFg5zf6MUZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuB82S6W; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuB82S6W"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48ba45f624eso70031137.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716967560; x=1717572360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nWzvmzN7ijIbCBaVTu7XEGtPfeKO3l3ACHDt/WVaHXI=;
        b=LuB82S6WQmX44POw5vy077+mYh3OFYpuPrUd48BRtutR+Fv41w1B1iTjjWm9ifBLGE
         BkNWDaRBxaRY9uvPcMACM7CB8wvcmenkrHVkP+PB/UrfvfvcGynn43/w3IEqLYV4ZTPE
         GFpnPRcjiddqBbZtS01emkha/YOZUK6IkdxWwcxwMR39sRqNILsndHEjqyzyYvYmfvxA
         XqD3+mZzQGUAdt3ezRk9IOsQbYIc0eStARi2FOGIARCsWlhT8yqbDz+7V6hyLPFmMY3I
         F7SE0FTzjEqmum0pL9TYnTw0nU8LE7sl0IgStUgHmzdaXSlxpuow4ZxIHIjdSigsE3UJ
         NJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967560; x=1717572360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWzvmzN7ijIbCBaVTu7XEGtPfeKO3l3ACHDt/WVaHXI=;
        b=P4Ca1JCPhOp8VWudu3QiJkYhOuL6TwzwVMEoK41W3ybINZhjHfbNDPkdlyf7YhCxD4
         n5rxpSRsjZsJgsA4bB7ZVz8cYO/WOL79s9dgVe/ExgoUPqOfbs7CHRleYP1JFRpCpLTo
         VbQoqimhNu/SmzyD/e0kpAI7ReeZJ8hjS1zRBz4SAVSN1nihRH00g2kjKH98WP0IXZvR
         tp2ZvnQ4mBD/9qhlfQk5cFgAmfa1um17AUg5xZgKlVLv3QzOyPEL1D0I+bdIUq0hr2E+
         VXabJSnTC6PoVsr5vIPTiyfqRGAqmIMkeLRgkvUR4THh9V886es6OvRgDT2cGmMHjjaL
         BIcg==
X-Forwarded-Encrypted: i=1; AJvYcCWDkZE0YjCbK2wuo3sfkoXiuska84CdsCkFIsDurNtp6i47aggQi+bkWYTAy8So1Lh6EKUn7Bl53WWkIcrzmwi87CZL3LH5PGcFGtFUNe7F
X-Gm-Message-State: AOJu0YwbIMLzt46yhCjGvhclF0HrHqFo4TChzmphsSuyY/FJ038/LvZC
	t5ZoLZguCk2jS000Ij/i6wrTPChEGqlpozniMBT8vNiAktVtNUPSH4rcb8HbsQAo5h/ZF6a6thx
	GbL42BI7+aziKLF/gPqS19bi3tNZKkCmsjalW
X-Google-Smtp-Source: AGHT+IFkhX+U8E/UmnrduSNww5O5l+Jhyabcq43rO3oLokyOCkCQOrAis9BA94QiL3EC3pI8usLyYmJe1k/GKdnaMP4=
X-Received: by 2002:a67:f4c7:0:b0:47c:2c84:4321 with SMTP id
 ada2fe7eead31-48a38575d3cmr13715697137.16.1716967560033; Wed, 29 May 2024
 00:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
In-Reply-To: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 29 May 2024 09:25:21 +0200
Message-ID: <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com>
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

On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
[...]
>         if (regs->flags & X86_EFLAGS_IF)
>                 raw_local_irq_enable();
> -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -               regs->ip += LEN_UD2;
> -               handled = true;
> +
> +       if (insn == INSN_UD2) {
> +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +                       regs->ip += LEN_UD2;
> +                       handled = true;
> +               }
> +       } else {
> +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {

handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?

> +                       if (insn == INSN_REX)
> +                               regs->ip += LEN_REX;
> +                       regs->ip += LEN_UD1;
> +                       handled = true;
> +               }
>         }
>         if (regs->flags & X86_EFLAGS_IF)
>                 raw_local_irq_disable();
> diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> new file mode 100644
> index 000000000000..6cae11f4fe23
> --- /dev/null
> +++ b/arch/x86/kernel/ubsan.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clang Undefined Behavior Sanitizer trap mode support.
> + */
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/printk.h>
> +#include <linux/ubsan.h>
> +#include <asm/ptrace.h>
> +#include <asm/ubsan.h>
> +
> +/*
> + * Checks for the information embedded in the UD1 trap instruction
> + * for the UB Sanitizer in order to pass along debugging output.
> + */
> +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> +{
> +       u32 type = 0;
> +
> +       if (insn == INSN_REX) {
> +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> +               if ((type & 0xFF) == 0x40)
> +                       type = (type >> 8) & 0xFF;
> +       } else {
> +               type = (*(u16 *)(regs->ip + LEN_UD1));
> +               if ((type & 0xFF) == 0x40)
> +                       type = (type >> 8) & 0xFF;
> +       }
> +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> +
> +       return BUG_TRAP_TYPE_NONE;
> +}

Shouldn't this return BUG_TRAP_TYPE_WARN?
