Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125F1C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiEPQXs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343555AbiEPQXp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:23:45 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212143916B
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:23:41 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id o130so12362378ybc.8
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERjwmtSwvtVHtjgKKrj51QITRMtiXOwM9nhQLiVd6Qw=;
        b=D2PkgRKQorhhMLfA50Vta7y243fAZrW8KjFSfJgXuoxoY7Roku7dzqIT55zMFdTaoY
         UsUeABkzI22CGW1iz0zoxCQ8s24xouyi8YUScAMNzyr5YKny5OcXe6agiIFIwTpW5Nzi
         ozJmDJANdoQRk+dn2jm0/E1AlwSGuYOC4N91ay6nnHYRm+pRFkR7gRin988rpe0BgwUv
         5jwXPhl1M6zD86C0DBMQBlByJT0SUOLsV/wem+fyZodqCvVORQ5lRKT1w7252TRac/Qt
         g+IvdCDXGUrxNJ4DxKJcmBotHia1/j0q0POhueECAShhTHaciRJ4ePAsfLL1Bshlxnpy
         64fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERjwmtSwvtVHtjgKKrj51QITRMtiXOwM9nhQLiVd6Qw=;
        b=0EBUJwiOlbPfTkp5N01wwGLAChUTDM8EEm1ImECcssP7CGO7+Z51AlIzi4e21kPNkH
         kafLzhXkKqx9AwpGgYn3x06h0xLG8d1u97L/9jIJuHgUC89qDvgl6L/aYGUhpVz1IFkh
         xmWh69b0u0GYDAOemJD108qcawyeEWNalsgiK0hYY0uhSho0JzpMn0vJvvYIKPICfilH
         wUZcBcDy4+E31pgB6i69Wo2zFSL0tOZ3uz7MpTFpAyKQgPRMxZsekepel72iTd5Z3Mnw
         7uAC+mSZUVSpgRRmbe+uQVS3kAmOk4+pyUcWsCv0BjAzg1Qvi1JSuhAKBsxMZbXNWyre
         fBBw==
X-Gm-Message-State: AOAM530UgqcBPkWPZdv/cuj91wasBDOqyskVVlUJF2AQ6c+AAuTq5obG
        yLXGxqU9I2ktkdVvadlsN75Bgp6Ep5LrY+d8rqMZ5A==
X-Google-Smtp-Source: ABdhPJy9ywAWL5gwqhVJcxT2xyXE+zDlxvIbmhC/msSHL7l1+Zgw6DLzU8wW0P921hCtPb1fOAj1qLMG3ti/Qhcn4WQ=
X-Received: by 2002:a25:b5c8:0:b0:64b:9bbd:9c94 with SMTP id
 d8-20020a25b5c8000000b0064b9bbd9c94mr15680808ybg.35.1652718220941; Mon, 16
 May 2022 09:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-8-samitolvanen@google.com> <202205141447.E3B5A29@keescook>
 <9bd2db3e-2955-66ba-574e-7976bdd95a8e@rasmusvillemoes.dk>
In-Reply-To: <9bd2db3e-2955-66ba-574e-7976bdd95a8e@rasmusvillemoes.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:23:05 -0700
Message-ID: <CABCJKucuTGRtWrk80Xe1Km8u-P+QxZ5xdjxz6iDP6ZtdmqkPpA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/21] cfi: Add type helper macros
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 5:28 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 14/05/2022 23.49, Kees Cook wrote:
> > On Fri, May 13, 2022 at 01:21:45PM -0700, Sami Tolvanen wrote:
> >> With CONFIG_CFI_CLANG, assembly functions called indirectly
> >> from C code must be annotated with type identifiers to pass CFI
> >> checking. The compiler emits a __kcfi_typeid_<function> symbol for
> >> each address-taken function declaration in C, which contains the
> >> expected type identifier. Add typed versions of SYM_FUNC_START and
> >> SYM_FUNC_START_ALIAS, which emit the type identifier before the
> >> function.
> >>
> >> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > And the reason to not make this change universally (i.e. directly in
> > SYM_FUNC_START) is to minimize how many of these symbol annotations get
> > emitted? (And to more directly indicate which asm is called indirectly?)
> >
> > What happens if an asm function is called indirectly and it doesn't have
> > this annotation?
>
> Presumably that's a fail.
>
> I'm also interested in how this works at the asm/linker level. I assume
> that the .o file generated from the asm input has
> __kcfi_typeid_<function> as an undefined symbol; the compiler emits that
> symbol as an absolute one upon taking the address of <function>, and the
> linker then has the info it needs to patch things up.

Correct. The generated code looks like this:

00000000000003f7 <__cfi_blowfish_dec_blk>:
     3f7:       cc                      int3
     3f8:       cc                      int3
     3f9:       8b 04 25 00 00 00 00    mov    0x0,%eax
                        3fc: R_X86_64_32S       __kcfi_typeid_blowfish_dec_blk
     400:       cc                      int3
     401:       cc                      int3

0000000000000402 <blowfish_dec_blk>:

And the symbol table in the file that takes the address has this:

    45: ffffffffef478db5     0 NOTYPE  WEAK   DEFAULT  ABS
__kcfi_typeid_blowfish_dec_blk

> But what then happens if we have some function implemented in assembly
> which for whatever .config reason never has its address taken in any .c
> translation unit that gets linked in? Does the __kcfi_typeid_<function>
> symbol silently resolve to 0, or does the link fail?

It will fail to link in that case.

> I can't really imagine the compiler emitting __kcfi_typeid_<function>
> symbols for each and every function it sees merely declared in some header.

The compiler emits these only for address-taken declarations.

> Two different .c files both taking the address of <function> should of
> course emit the same value for __kcfi_typeid_<function>. Is there any
> sanity check anywhere that that's actually the case?

Not at the moment. I suppose we could warn about mismatches in the
linker though.

> Can we please have some objdump/readelf output from some .o files
> involved here?

Sure, I'll add examples to the commit message.

Sami
