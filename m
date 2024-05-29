Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADA15F403
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717025560; cv=none; b=QPqCq5b4pTWUqAlQHhVo4+vqXM12VXAII4G5YZvktT0GWfMVsw9hBWj+6s4gaickGWdhK+kmdZe66MqXrqhCAo7Z3uwRpZing88ZYVx6G7aldxhMWSzktsW/+wWbjrlbZOJbijOQyy7RKBQBflt3+pNvNA9J5P7gQkKS6JupfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717025560; c=relaxed/simple;
	bh=/0SdF5uqE6gzTTXQWDfWuqijnmeHpXTwYnsb4nK5NfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJJjU+5H3IS3f+JaaCgGmSeOwSHYyArl3AYDVjV2OvgjItVShjvnpHYzoLcLZ/Xmj31BSfB2P+gNKiYNNcv0kbL67xFdki7lOmOdAW+eDnVPuHpBvJ1rsgAEvpDY+ueE3sky8I88aHwiC/LYq+r8fbFbF+a/8FLazqzjkgMz/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a58uEDwL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a58uEDwL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f32448e8fbso2504415ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717025558; x=1717630358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cucV7qOoOPIUrj3G8eYL6EQD/QmFAva7FNUzBgHa+iQ=;
        b=a58uEDwLj6REAZQa20YQi97Tz1B2GRbcFDP/P7su90S4EqShgZUSsGnDpWXuvxVelJ
         0uNpL+p1Fjb33y70olYS5Ia/pJfDGUGVOzjAnTSK25hQHQZ08j4oqyn4guNk0hpJNLCd
         Vyt6vuUxoMwKoJH0WuQxPPoE6FOt4X13ARtsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717025558; x=1717630358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cucV7qOoOPIUrj3G8eYL6EQD/QmFAva7FNUzBgHa+iQ=;
        b=CMLBomT/c1JGGx7GoL/DltY2RB9OQ+vx9wP/JfL6MQ+yTWTTUfyFDNYrsnTt12QAE9
         9IlQJs6TtPMdXrE0C0kz6P6is9wEm4zdSIECfDasdgOkIgxRq9vm+eWMXhfMjsUrL67l
         q0Wfnjo3RYKEB936EVzwOUAIu7qdhf2m80/tSDzkXqX7BeYEqyswaCCTs5+Uh1/Q+kRT
         fh10bvGWGplZgVkdCU1NUNxm8JQuJfNOr6QsMfmHIZmoBnzOdIJYeIA2oukwv2EkIoMw
         4YBrhZIhdrFjsT1uTx1o49YbTiY/6/9FKm9ub7rt5gDPiTBdpsQMiOrGybGAv5z4SOcS
         P/9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zs2LWxwCw30hKs+JMCTFgL6yD/hCz2GnYMb0zzmOqYqOQZ8d9z8MgEJgZh2tFVb7V0S5Sp5X4WBeJSRMuLBhLivg/LurmC9mxsvRs0/A
X-Gm-Message-State: AOJu0Ywz0iUrni4rJPOpM8XSbekL6bZr6p0CgYgLQlfKjuHLp1QnPvPs
	mC+6vW4RyCNS8RVNh9kpzjBd8aVXzxC3e2THrD0V57kerqu62EOv735BwQTlHQ==
X-Google-Smtp-Source: AGHT+IGrZufDO7aDrD5XQN2/A2YMhT+Y9cL7VGKbNsy++FzDVwe+PKFjUp+fb94aTS54ZMP8pq2noA==
X-Received: by 2002:a17:902:d2c1:b0:1f3:903:5c9a with SMTP id d9443c01a7336-1f619936a85mr5241125ad.58.1717025558317;
        Wed, 29 May 2024 16:32:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99d23asm108088905ad.208.2024.05.29.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:32:37 -0700 (PDT)
Date: Wed, 29 May 2024 16:32:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Marco Elver <elver@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
Message-ID: <202405291631.79BB8BF@keescook>
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
 <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com>
 <2j6nkzn2tfdwdqhoal5o56ds2hqg2sqk5diolv23l5nzteypzh@fi53ovwjjl3w>
 <CANpmjNM4pFHYRqmBLi0qUm8K2SroYWg7NFjreHffHvk0WW95kA@mail.gmail.com>
 <57vgoje4bmrckwqtwnletukcnlvjpj2yp3cjlkym4bfw66a57a@w35yjzcurcis>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57vgoje4bmrckwqtwnletukcnlvjpj2yp3cjlkym4bfw66a57a@w35yjzcurcis>

On Wed, May 29, 2024 at 01:36:39PM -0700, Gatlin Newhouse wrote:
> On Wed, May 29, 2024 at 08:30:20PM UTC, Marco Elver wrote:
> > On Wed, 29 May 2024 at 20:17, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 09:25:21AM UTC, Marco Elver wrote:
> > > > On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > > > [...]
> > > > >         if (regs->flags & X86_EFLAGS_IF)
> > > > >                 raw_local_irq_enable();
> > > > > -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > > -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > > -               regs->ip += LEN_UD2;
> > > > > -               handled = true;
> > > > > +
> > > > > +       if (insn == INSN_UD2) {
> > > > > +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > > +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > > +                       regs->ip += LEN_UD2;
> > > > > +                       handled = true;
> > > > > +               }
> > > > > +       } else {
> > > > > +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> > > >
> > > > handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?
> > > >
> > > > > +                       if (insn == INSN_REX)
> > > > > +                               regs->ip += LEN_REX;
> > > > > +                       regs->ip += LEN_UD1;
> > > > > +                       handled = true;
> > > > > +               }
> > > > >         }
> > > > >         if (regs->flags & X86_EFLAGS_IF)
> > > > >                 raw_local_irq_disable();
> > > > > diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> > > > > new file mode 100644
> > > > > index 000000000000..6cae11f4fe23
> > > > > --- /dev/null
> > > > > +++ b/arch/x86/kernel/ubsan.c
> > > > > @@ -0,0 +1,32 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Clang Undefined Behavior Sanitizer trap mode support.
> > > > > + */
> > > > > +#include <linux/bug.h>
> > > > > +#include <linux/string.h>
> > > > > +#include <linux/printk.h>
> > > > > +#include <linux/ubsan.h>
> > > > > +#include <asm/ptrace.h>
> > > > > +#include <asm/ubsan.h>
> > > > > +
> > > > > +/*
> > > > > + * Checks for the information embedded in the UD1 trap instruction
> > > > > + * for the UB Sanitizer in order to pass along debugging output.
> > > > > + */
> > > > > +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> > > > > +{
> > > > > +       u32 type = 0;
> > > > > +
> > > > > +       if (insn == INSN_REX) {
> > > > > +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> > > > > +               if ((type & 0xFF) == 0x40)
> > > > > +                       type = (type >> 8) & 0xFF;
> > > > > +       } else {
> > > > > +               type = (*(u16 *)(regs->ip + LEN_UD1));
> > > > > +               if ((type & 0xFF) == 0x40)
> > > > > +                       type = (type >> 8) & 0xFF;
> > > > > +       }
> > > > > +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> > > > > +
> > > > > +       return BUG_TRAP_TYPE_NONE;
> > > > > +}
> > > >
> > > > Shouldn't this return BUG_TRAP_TYPE_WARN?
> > >
> > > So as far as I understand, UBSAN trap mode never warns. Perhaps it does on
> > > arm64, although it calls die() so I am unsure. Maybe the condition in
> > > handle_bug() should be rewritten in the case of UBSAN ud1s? Do you have any
> > > suggestions?
> > 
> > AFAIK on arm64 it's basically a kernel OOPS.
> > 
> > The main thing I just wanted to point out though is that your newly added branch
> > 
> > > if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> > 
> > will never be taken, because I don't see where handle_ubsan_failure()
> > returns BUG_TRAP_TYPE_WARN.
> >
> 
> Initially I wrote this with some symmetry to the KCFI checks nearby, but I
> was unsure if this would be considered handled or not.

Yeah, that seemed like the right "style" to me too. Perhaps, since it
can never warn, we could just rewrite it so it's a void function avoid
the checking, etc.

-- 
Kees Cook
