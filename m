Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF3CC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jul 2022 00:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiGZAKg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiGZAKg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Jul 2022 20:10:36 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE112183E
        for <linux-hardening@vger.kernel.org>; Mon, 25 Jul 2022 17:10:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 75so22767814ybf.4
        for <linux-hardening@vger.kernel.org>; Mon, 25 Jul 2022 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jEuccm+13frSO13F4UbCDTaTKUna0j27ZhD3kYwCOE=;
        b=JG1XFgHmFM4OuFOHTn6dJ+pnT7DBjuTnLLajlNshh/FVuAMf/Vcgwwn8szGEZ8KruF
         vQpvV4fPl3wu0AFGuxR+056dIMgw+zWIjX+TffF1DhBaJaFOpdAzRIYDtTKCvoAKjdXj
         BzVxedIfh40R8VC6K5GWDkdtNRHXbf4k18N/yLNjoKQr4hzcCeJg2x+w1GqNya2gnj8o
         FfyymnsCfk/iOTTbIXvP24Vt9k2ZpvlqeM2z9LgEMTllqAJj6kzzaqUVsrhi57Yt/BRw
         x+1HgIa1RKXKE4fimavD8OUII7AuSQOc4PYz6QCzHTzBlw7Phkl4GzrXs0dMWoCEs+LM
         hZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jEuccm+13frSO13F4UbCDTaTKUna0j27ZhD3kYwCOE=;
        b=DG74T/kDiF5BPSI3ckoaS633J2fLN4zPn+kKF8EhMpi0YLVyykk0ERia54jdKxCg9y
         ZIln+kiHqHBMP0smJj4TQPzYvgVp6/j1yCTajs+n99J3+QFNYAf+5mbPjF+6UUnRgLF1
         tpActJqHP9T/cMvG4T1xZNf3bpH6+qOX8PXWXWLZhsReJl/IN+q7o+bNe60/oRDF8+QX
         rO0XMN2ChnKKgyb07IOjLp/JNB0rSGvh7wJraM1DP0Vwt3nckFLUfOTx3rS5+bS+VNq3
         ot+Tm7DX79u6eyrsah9mQBduQk60mu0swbUkYv+d4tyU9fr3MuC3KIzpS2ehywIHgKk3
         xudQ==
X-Gm-Message-State: AJIora9noJWypC2Q+9GxNZC8aQkNMspbtBPPxB9XUCA7emp4IDFE2/8q
        +5oZIrAqEnQzWsSuTlolhkWJtyONZPI/FLlJnYe6dA==
X-Google-Smtp-Source: AGRyM1vcor1AoZoF/hJYr87qRlJIfLAt0f7iGROesAM925P5MkdFlgqOJv1cHjTmmUDBGaoOCe+/7SUZgR29WPcH5Y0=
X-Received: by 2002:a5b:cc6:0:b0:66e:45c6:2a25 with SMTP id
 e6-20020a5b0cc6000000b0066e45c62a25mr11454535ybr.304.1658794233835; Mon, 25
 Jul 2022 17:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-21-samitolvanen@google.com> <YtvZvYHC1BKzEz1p@worktop.programming.kicks-ass.net>
In-Reply-To: <YtvZvYHC1BKzEz1p@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 25 Jul 2022 17:09:57 -0700
Message-ID: <CABCJKucWbN15tH=zJ7HFeNnOPB3v7S=2=oL3pmp89OHOM2=oYw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 20/20] x86: Add support for CONFIG_CFI_CLANG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Jul 23, 2022 at 4:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 10, 2022 at 04:35:13PM -0700, Sami Tolvanen wrote:
>
> > +#ifdef CONFIG_CFI_CLANG
> > +#define __CFI_TYPE(name)                                     \
> > +     .fill 7, 1, 0xCC ASM_NL                                 \
> > +     SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)        \
> > +     int3 ASM_NL                                             \
> > +     int3 ASM_NL                                             \
> > +     mov __kcfi_typeid_##name, %eax ASM_NL                   \
> > +     int3 ASM_NL                                             \
> > +     int3 ASM_NL                                             \
> > +     SYM_FUNC_END(__cfi_##name)
> > +#endif
>
> Like said on IRC yesterday, this doesn't generate the right mov
> encoding.
>
>         .byte 0xb8 ; .long __kcfi_typeid_##name ;               \
>
> works. Your LLVM tree already has the ZExt patch you gave me yesterday
> to fix up the linker fallout from this change.

Indeed, I updated my kernel tree and confirmed that this fixes the
issue. Thanks for pointing it out.

Sami
