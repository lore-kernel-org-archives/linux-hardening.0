Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEEC4332F
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 18:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBFF60E78
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 18:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJ3S6D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 30 Oct 2021 14:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhJ3S6D (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 30 Oct 2021 14:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7D2F60F0F;
        Sat, 30 Oct 2021 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635620132;
        bh=qtn9JW4jhxyuPAJNQ5NoqqWfwKbfafsp+GixB38x3i8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O8FagHUZakbiUhExqOFAUdpYLah6tRqRSfskqQ7q4TCiiVaEiz6s9ZpTnQ3Jva8ks
         HACyto+ICAZMPH682d2LtBrv9oajQjoQ3LfF+MRiHpg+1tpxG5RtN4+/hP5KOx+Aq2
         zo0kIkSxXy9K910s3dU22MWz3/wnzos1Dllyc3dApI1Qcn+sbNQLtbBQp0oBvBOk0O
         2PSJBFuatdFtMmIUZoLvrcZC7p5fpJ1asidJT693OAHgHJwjui4Y7sIr067k64/EVt
         bVfzMXB9Scm8u7jSmFzExn+qpF1c5IefGcSEzxa6c7HqTmGp/al9FXWC3Xn1eX90yL
         Ik9RJl8vXbxgw==
Received: by mail-oi1-f181.google.com with SMTP id g125so18482199oif.9;
        Sat, 30 Oct 2021 11:55:32 -0700 (PDT)
X-Gm-Message-State: AOAM532AQ548+SMeRSWrLH9VTueytwrijSpiJuvZkOxLLJUXaW/OW2yX
        QB1lE/ocIxpfDZUfYDJWDZ8W77Vq/IJfYIRo0e4=
X-Google-Smtp-Source: ABdhPJyTAT1X8xnCAWwkU+17oqm3OttK6VQk0EGhcp4oLGNhaGkj/SbzM2MBH85ZIZQ7uVeM3qTXNJZrANUvtOZcTo8=
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr18863439oib.47.1635620131981;
 Sat, 30 Oct 2021 11:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com> <20211030180249.GU174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211030180249.GU174703@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 30 Oct 2021 20:55:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
Message-ID: <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 30 Oct 2021 at 20:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Oct 30, 2021 at 07:19:53PM +0200, Ard Biesheuvel wrote:
> > I just realized that arm64 has the exact same problem, which is not
> > being addressed by my v5 of the static call support patch.
>
> Yeah, it would.
>
> > As it turns out, the v11 Clang that I have been testing with is broken
> > wrt BTI landing pads, and omits them from the jump table entries.
> > Clang 12+ adds them properly, which means that both the jump table
> > entry and the static call trampoline may start with BTI C + direct
> > branch, and we also need additional checks to disambiguate.
>
> I'm not sure, why would the static_call trampoline need a BTI C ? The
> whole point of static_call() is to be a direct call, we should never
> have an indirect call to the trampoline, that would defeat the whole
> purpose.

This might happen when the distance between the caller and the
trampoline is more than 128 MB, in which case we emit a veneer that
uses an indirect call as well. So we definitely need the landing pad
in the trampoline.
