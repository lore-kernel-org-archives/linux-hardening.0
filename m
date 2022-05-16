Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F98C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbiEPQFY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiEPQFW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:05:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646C33E11
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:05:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2fee010f509so42717437b3.11
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH8gn2feqHbJT1VIR+CqAKz2Vm1OI4IAH3XiEx/1r0M=;
        b=hxtlRvOYZfHTAJg87WazheoK+1Jp+3wCYPv/qQPT0w3Xc4g1MVT1EAxaMJwHK/p+C5
         n195YFtxr4dxqu/Ys7B5KxlCbsy5yIzGJs9tu7jy7SNu1kZ2JX9oLdZBYQUPptmKqazj
         KBMYT+1WYxUqZpoWveDxLGR/M5mOnI6k4zzkfRDzYsS9KUKHLC0FQoQAKI53lhQb6EYD
         VcFQ2h3buNKerCfHxbL/MfYeLCG/XK25UGojTz62VrxqXP9lPEUYxJksD81vTAtuacJC
         OBrXFPw3moxQx+QrTme3d7VCEv4n4HJA5S3h3SDkHHYHLdwCbsqQdCPnYLdqZ9KUhBvu
         +hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH8gn2feqHbJT1VIR+CqAKz2Vm1OI4IAH3XiEx/1r0M=;
        b=oVvUWi/ViMazris2eP2NOELetMOOK7qkHLouI9MqNbLmDDHaXx5xD7zqCdEBqpDQ1t
         ce5RFWtqxlhZDC1kCI9uk4+32IuRr2PEOiUSUk7dn71YlISLVa8+TMlO95bYehAQcxpZ
         2SrD37aberNIxxy1DXYInneaceKkxrH9H12cyy0oDjsbn4UT8deg9Gbk7KMIQT7O5BRE
         8UBJ4M15JGbQOydbIdSZRK/YFUID4DaETvdhgx9jXInIVxtvLoi0T7Kwy0EltSgw4UqT
         1DuNMmsC7P5Km8T+bgSE/hIji6pS6Le6EbZQa55DaYWW9cOVu6OBBhIHm/7+TaMknPUx
         CCFQ==
X-Gm-Message-State: AOAM532lhmmMeksq5du0FLPLhBv/oss7heFaYPNelGAXVpQl9HVT8IAw
        x1b++fszsTwFcBQ2S+ffHH0dVl7XDLNPcoRIXRU8Zg==
X-Google-Smtp-Source: ABdhPJxkNuFXhIjn2K2LehjJwRBe1s4mUIoU6C5Borv7+HLjg5MoQxKsHWIgoJh9hK6EYijZjjwv/zmdLvdC5pna+W0=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10858246ywb.305.1652717120280; Mon, 16
 May 2022 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-8-samitolvanen@google.com> <202205141447.E3B5A29@keescook>
In-Reply-To: <202205141447.E3B5A29@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:04:44 -0700
Message-ID: <CABCJKudrY2b4ZXUaXOmKEB-LG192u2PSfsT-=Vc1bcg3QwY6aw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/21] cfi: Add type helper macros
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Sat, May 14, 2022 at 2:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:45PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, assembly functions called indirectly
> > from C code must be annotated with type identifiers to pass CFI
> > checking. The compiler emits a __kcfi_typeid_<function> symbol for
> > each address-taken function declaration in C, which contains the
> > expected type identifier. Add typed versions of SYM_FUNC_START and
> > SYM_FUNC_START_ALIAS, which emit the type identifier before the
> > function.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> And the reason to not make this change universally (i.e. directly in
> SYM_FUNC_START) is to minimize how many of these symbol annotations get
> emitted? (And to more directly indicate which asm is called indirectly?)

The reason not to add this to SYM_FUNC_START is that the compiler
doesn't emit the type symbols for all functions. It currently emits
them for all address-taken function declarations in each translation
unit. We could potentially further limit this by emitting them only
for function declarations with a specific attribute, for example, but
that's something we can optimize later.

> What happens if an asm function is called indirectly and it doesn't have
> this annotation?

It will fail the CFI check.

> (Is this case detectable at compile-time?)

It's not. I'll update the commit message in the next version to
clarify these points.

Sami
