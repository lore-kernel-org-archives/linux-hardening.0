Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533EC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiEPQjk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiEPQjj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:39:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8D3AA4D
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:39:38 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso159724887b3.9
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJ1mj/6AEbnCZ4HPughZpfwPoxjL4U+12a8eW3KN+cU=;
        b=BrUCwqzxN2mNfk/ExieimQ9XkZd769u40ZXKgP3WMEJSnoidxk7l4mgPgX8TQLEUf+
         mHoGRcO4qbZrF3SZvjLddv1SFfTTPb/Qdm7F/4Iww+SxqXQBztROLAuEfJN/v/B1VpYQ
         Ow8ybjFEWj00m3V7QA+mRR5vUigRQPZszrSAj3T8lfAbC2/FCRo96LSLXzVjjdgvWDsV
         Yfs6cGR6w4Xbfm8W5Mf6h60V4gzbxVxbjBnQXmEnogjmm/VFkWUOQpgtI8/qriceckOr
         RaOqb/nWuFQtgqtCf0NnQumcR5ga8ZlkjY+sc2wBUohWGR5PrpBBo67IOdsHmRMHYVWj
         3kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJ1mj/6AEbnCZ4HPughZpfwPoxjL4U+12a8eW3KN+cU=;
        b=IRL+t/j0n5tibgsPBHN5fpM5g2mF9Cgw996Av8I5CFqzm4am1xhQ8krvI8nzeuOLM0
         QfgxZc0Vtss/Usp0k0v0oKvCcF1yKb8c3dOK3EpxxAVyHt/v9D5EClhkCThgi+kX29OR
         VGmERlIAUWKiO1saapILrzGumIXYwIs3O0GErInSKamQzSUn3f2sIzShltZdK8O7RdNZ
         VnjuKEetjZSGBXhANOyfmphJlOzg73d6Q5Hl+89sHGJZjxHiCXVkF8PTw7yvll9iFJ7u
         SEa/ZvgMTXB2fH8XhcLx484v9T+3NyXcKpn9BB3yTT1epNgDTqh+yURAos8X4cVbH2So
         Ky/A==
X-Gm-Message-State: AOAM531uMlq1D5Rgz1WtddCxRyS9/ehqluLPNVQpccWzfNRBuwn+gagN
        S0MerqqGOnkxLKR7BVfJXide4YCsNQ4tsv0DtBsk/w==
X-Google-Smtp-Source: ABdhPJzQJa1N5l2z5xfrd+zcTG6blvNDsfHVm9LuNqqXVzDY9SqhLJ1LbDtJEHO1K6Zz6VnIidKyyWBgtD0CkopkxGA=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr11033942ywb.305.1652719177966; Mon, 16
 May 2022 09:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
In-Reply-To: <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:39:02 -0700
Message-ID: <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 1:32 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Sami Tolvanen
> > Sent: 13 May 2022 21:22
> >
> > With CONFIG_CFI_CLANG, the compiler injects a type preamble
> > immediately before each function and a check to validate the target
> > function type before indirect calls:
> >
> >   ; type preamble
> >   __cfi_function:
> >     int3
> >     int3
> >     mov <id>, %eax
>
> Interesting - since this code can't be executed there is no
> point adding an instruction 'prefix' to the 32bit constant.

The reason to embed the type into an instruction is to avoid the need
to special case objtool's instruction decoder.

> >     int3
> >     int3
> >   function:
> >     ...
> >   ; indirect call check
> >     cmpl    <id>, -6(%r11)
> >     je      .Ltmp1
> >     ud2
> >   .Ltmp1:
> >     call    __x86_indirect_thunk_r11
> >
> > Define the __CFI_TYPE helper macro for manual type annotations in
> > assembly code, add error handling for the CFI ud2 traps, and allow
> > CONFIG_CFI_CLANG to be selected on x86_64.
> >
> ...
> > +
> > +     /*
> > +      * The compiler generates the following instruction sequence
> > +      * for indirect call checks:
> > +      *
> > +      *   cmpl    <id>, -6(%reg)     ; 7 bytes
>
> If the <id> is between -128 and 127 then an 8bit constant
> (sign extended) might be used.
> Possibly the compiler forces the assembler to generate the
> long form.
>
> There could also be a REX prefix.
> That will break any code that tries to use %reg.

The compiler always generates this specific instruction sequence.

> > +      *   je      .Ltmp1             ; 2 bytes
> > +      *   ud2                        ; <- addr
> > +      *   .Ltmp1:
> > +      *
> > +      * Both the type and the target address can be decoded from the
> > +      * cmpl instruction.
> > +      */
> > +     if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 9, MAX_INSN_SIZE))
> > +             return;
> > +     if (insn_decode_kernel(&insn, buffer))
> > +             return;
> > +     if (insn.opcode.value != 0x81 || X86_MODRM_REG(insn.modrm.value) != 7)
> > +             return;
>
> Since you are looking for a very specific opcode why bother
> calling insn_decode_kernel() - just check for the required (masked)
> byte values.

Because I need to decode both the immediate value and the register
from that instruction.

> > +
> > +     *type = insn.immediate.value;
> > +
> > +     offset = insn_get_modrm_rm_off(&insn, regs);
>
> Given the expected instruction, isn't that -6 ??

No, this is the register offset.

> > +     if (offset < 0)
> > +             return;
> > +
> > +     *target = *(unsigned long *)((void *)regs + offset);
>
> WTF is that calculating??

It's reading the register value from pt_regs.

Sami
