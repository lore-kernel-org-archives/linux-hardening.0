Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0961B960;
	Wed, 29 May 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015004; cv=none; b=uFUgvJ2XEXcGIt+mFzvcpV4tZtw+pjHC5OrApBxstHgzmauQoUKPFBnDRizwzE3v3OsQUtl5mRn5fNpf6NNTMAmrxHIg4GipFqjPN/M7Bt/kpWBK20UpuvguNXTweXnLbn5VPfy23IhbTI1drMpWBcFJcdNITEoq15CMnMuGavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015004; c=relaxed/simple;
	bh=KAuwmpAQlvgKVAuhQljiF3gBQKzQXSKUp3q7GZNgyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDFrBKynUVmiodS5gS3DcCDqRjo1p5FRj/4n+2TXV6lzgPkKpq4QavYWGXU1znxQRfhCzlSkT+Uki2kDEc57ASZeIV5QWFsx37u3U3+R6g53Zzb+HAt8maEfvs1tKWOEiuQPeD9trFF/zD00xPhPpHMVpuyMSEfNHjCoYwoPIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQqn8HrJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQqn8HrJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d0dso1633685ad.1;
        Wed, 29 May 2024 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717015002; x=1717619802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsDD1NAPFioHO4gLv1AtQFDU2NR/QOFSQPXZbsUyXIQ=;
        b=hQqn8HrJK04qSpdvyWYymLBpVSatbJ+nu+z3lC2FIW/XjZRpMRwszziyA4cpieiz6u
         k9evo/5N0omgpREvU/w3Xu5/gExMajk4tT+37+9/e9D4Nu73y9V/ob3eNplitG+Irl+n
         MA1G2QsRxBvedCdJHXFm1bByc/9M6IqTKQGXG+EwpuYN/2hMVWFRY17R9gy3awkfOwJI
         KsSs9Nwp+Ywz88eL8FUcusCV4NAasqkierHZ9Qppyo5VTktLmXs9DQo3gZQ2Z0FBoEr+
         fA+TXtM3TpTHc76qXA37nV9Gn+sTAtkHSpvDOjOfnKVvPpCFUiLpPMCFjibgPKEE4pSs
         T9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015002; x=1717619802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsDD1NAPFioHO4gLv1AtQFDU2NR/QOFSQPXZbsUyXIQ=;
        b=cjug+sf4QgfwLmvkGqV/JOdlh12DCv33MrThpnMAo9Bpop+tK2PgDq82WqnONB0KD7
         8+wUmSrJxojkodmh7umaYRnBBEsqQydXN9tQLj54ZVaS0BmjnjLLN+0hlK5M+hKU3xH/
         y9zY2NvfqHk4fySChBXapNabRIe14f4nqxFCWX+8VzRYvlUR/OCmVuwI+/R/BFJHq3HL
         0ssTGmOXZTf3VW/Sa4KSYSPMc0GfKGQgfhQT2TzkYyFa+KuNVwDPjZM3VCpsfYb/ob2N
         4G1ZXJ92mupqeD5sEykeGgYqqNHKTF/eIGoi+pzVEuyK0E0M3YUACVS/DulqYQDhNt8G
         cyuw==
X-Forwarded-Encrypted: i=1; AJvYcCVpUppc0np4EhmU5hBvF/BEcORMS5aH5BiGsSAO4ESHHCIgFx0U0jc+VVgbvKUGOhVL+A4mvPtheqqx9+2dU0r71F8LFfrgXjtURIO1OWZFiGl23P16+b61A6nBBWDI/9+owhFH4jMOUhPiTKS6
X-Gm-Message-State: AOJu0YyWmDJcO0pwTO/JyxNqUi5Im3mVZ6uynyu8GfR+O5KaLYILST2O
	CTM1Phd01c6WpcH4AzI9+xRXdk1AXwQ11HLTv6sgW9l+wq2Svv3j
X-Google-Smtp-Source: AGHT+IFzfRiiqI8oIBnyBDHVNzQy3TKrU+G1kSritJ5B25V5oeLzSgd4JGxkvl7xiz1uHMCm0UlTbw==
X-Received: by 2002:a17:903:8c3:b0:1f2:f986:595d with SMTP id d9443c01a7336-1f61a4dd759mr1743215ad.66.1717015001980;
        Wed, 29 May 2024 13:36:41 -0700 (PDT)
Received: from Gatlins-MacBook-Pro.local ([131.252.143.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75e579sm103603725ad.35.2024.05.29.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:36:41 -0700 (PDT)
Date: Wed, 29 May 2024 13:36:39 -0700
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
Message-ID: <57vgoje4bmrckwqtwnletukcnlvjpj2yp3cjlkym4bfw66a57a@w35yjzcurcis>
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
 <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com>
 <2j6nkzn2tfdwdqhoal5o56ds2hqg2sqk5diolv23l5nzteypzh@fi53ovwjjl3w>
 <CANpmjNM4pFHYRqmBLi0qUm8K2SroYWg7NFjreHffHvk0WW95kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM4pFHYRqmBLi0qUm8K2SroYWg7NFjreHffHvk0WW95kA@mail.gmail.com>

On Wed, May 29, 2024 at 08:30:20PM UTC, Marco Elver wrote:
> On Wed, 29 May 2024 at 20:17, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> >
> > On Wed, May 29, 2024 at 09:25:21AM UTC, Marco Elver wrote:
> > > On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > > [...]
> > > >         if (regs->flags & X86_EFLAGS_IF)
> > > >                 raw_local_irq_enable();
> > > > -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > -               regs->ip += LEN_UD2;
> > > > -               handled = true;
> > > > +
> > > > +       if (insn == INSN_UD2) {
> > > > +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > +                       regs->ip += LEN_UD2;
> > > > +                       handled = true;
> > > > +               }
> > > > +       } else {
> > > > +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> > >
> > > handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?
> > >
> > > > +                       if (insn == INSN_REX)
> > > > +                               regs->ip += LEN_REX;
> > > > +                       regs->ip += LEN_UD1;
> > > > +                       handled = true;
> > > > +               }
> > > >         }
> > > >         if (regs->flags & X86_EFLAGS_IF)
> > > >                 raw_local_irq_disable();
> > > > diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> > > > new file mode 100644
> > > > index 000000000000..6cae11f4fe23
> > > > --- /dev/null
> > > > +++ b/arch/x86/kernel/ubsan.c
> > > > @@ -0,0 +1,32 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Clang Undefined Behavior Sanitizer trap mode support.
> > > > + */
> > > > +#include <linux/bug.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/printk.h>
> > > > +#include <linux/ubsan.h>
> > > > +#include <asm/ptrace.h>
> > > > +#include <asm/ubsan.h>
> > > > +
> > > > +/*
> > > > + * Checks for the information embedded in the UD1 trap instruction
> > > > + * for the UB Sanitizer in order to pass along debugging output.
> > > > + */
> > > > +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> > > > +{
> > > > +       u32 type = 0;
> > > > +
> > > > +       if (insn == INSN_REX) {
> > > > +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> > > > +               if ((type & 0xFF) == 0x40)
> > > > +                       type = (type >> 8) & 0xFF;
> > > > +       } else {
> > > > +               type = (*(u16 *)(regs->ip + LEN_UD1));
> > > > +               if ((type & 0xFF) == 0x40)
> > > > +                       type = (type >> 8) & 0xFF;
> > > > +       }
> > > > +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> > > > +
> > > > +       return BUG_TRAP_TYPE_NONE;
> > > > +}
> > >
> > > Shouldn't this return BUG_TRAP_TYPE_WARN?
> >
> > So as far as I understand, UBSAN trap mode never warns. Perhaps it does on
> > arm64, although it calls die() so I am unsure. Maybe the condition in
> > handle_bug() should be rewritten in the case of UBSAN ud1s? Do you have any
> > suggestions?
> 
> AFAIK on arm64 it's basically a kernel OOPS.
> 
> The main thing I just wanted to point out though is that your newly added branch
> 
> > if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> 
> will never be taken, because I don't see where handle_ubsan_failure()
> returns BUG_TRAP_TYPE_WARN.
>

Initially I wrote this with some symmetry to the KCFI checks nearby, but I
was unsure if this would be considered handled or not.

> 
> That means 'handled' will be false, and the code in exc_invalid_op
> will proceed to call handle_invalid_op() which is probably not what
> you intended - i.e. it's definitely not BUG_TRAP_TYPE_NONE, but one of
> TYPE_WARN of TYPE_BUG.
>

This remains a question to me as to whether it should be considered handled
or not. Which is why I'm happy to change this branch which is never taken to
something else that still outputs the UBSAN type information before calling
handle_invalid_op().

> 
> Did you test it and you got the behaviour you expected?
>

Testing with LKDTM provided the output I expected. The UBSAN type information
along with file and offsets are output before an illegal op and trace.
