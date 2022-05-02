Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6EFC43217
	for <linux-hardening@archiver.kernel.org>; Mon,  2 May 2022 15:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiEBPZh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 2 May 2022 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385800AbiEBPYH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 2 May 2022 11:24:07 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A312088
        for <linux-hardening@vger.kernel.org>; Mon,  2 May 2022 08:20:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i38so26523968ybj.13
        for <linux-hardening@vger.kernel.org>; Mon, 02 May 2022 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG2N1KHd1YR2ZF1sjkCgsuS94s3wv0dEZ2AS2biKRuc=;
        b=nCCr/m44vAOB3fWxcTwSvULnXuiNVu4xAEa/q8PX0e8wp//HRJ3pAwZlfI8oXQakqb
         PBNA5VrluDTvJXwHjjEqKVrz+t1ZAhOuAy0UZ/lpPuIF5TfAQhvGp0eP9kDlGthADP7B
         jQS2jgmlIf2O2YIMWFKayiS6OkGnXXTuI6mSozGLIgWSqWTudoL0mragtOrIMycv0iNu
         cZvbiKKjzeuQMjCAHgd1ar9MSdep3a1AilDwleb2gMChOjj8zJLFVuMg4VeHUCWQC8gh
         4i9wU09zBuZyOBMRAX6+2An3+4aqYMkmsLVezmWAt06zT2xLERXvPiNYHUXkJ6I1taeF
         kDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG2N1KHd1YR2ZF1sjkCgsuS94s3wv0dEZ2AS2biKRuc=;
        b=amufW0xiPQ6zCHFsneHN1bUIVhZUdgCtWFtxlxYxqP5OACgVkGdk0EQd+jmuMv1Nnc
         FjsQOXK+d5bwaJz5cTDGOXZB6o3Py+4sKUbcsbw81oSkDFuVzKOoSilU+X5ZxysXNwWK
         H1LzeJz+x0S2PusWePlaOs9BOWoNPE/lXoKPmX+JmvoSCQCikVevMUZvwm6tOMV+W9Rs
         ga+9pbhP56VL9WAwMoiwF8TRnp0HCfWAGPBQkRelpS6lt3WsjM+XMrgcZOQu4kWpNo4E
         a6rEmd9IYxpIYpM0esaGx3k9HjejXGz4s/5mo4Y30q6MEbxBkoRXdLj4mOGgUf6F5lEE
         L2Rg==
X-Gm-Message-State: AOAM532VWrx/ppG2wJtT6FOAGhEVCAMyqxffRlU1A4iDJa4wSOmi2kGr
        qe8wUXIV4H3AEHMaH3l+xGEV4X6WW9twzg5dQ1hFtA==
X-Google-Smtp-Source: ABdhPJzqk8+IJH8fkyTp0bTuIuMWgJsHqUrnpAZSbYcMmkZ/+21K1dsNoH6iUg94I0Y7z6gpiKYrRf3BnqDN09p5vbs=
X-Received: by 2002:a25:3455:0:b0:648:44db:51e0 with SMTP id
 b82-20020a253455000000b0064844db51e0mr10124096yba.314.1651504838091; Mon, 02
 May 2022 08:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-22-samitolvanen@google.com> <Ym0ASy87mE3r3EVE@hirez.programming.kicks-ass.net>
In-Reply-To: <Ym0ASy87mE3r3EVE@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 May 2022 08:20:05 -0700
Message-ID: <CABCJKucK39XnVPA=EhLSJ+vcgVLCSgnGzLrRy9tZSM2jzZtUBg@mail.gmail.com>
Subject: Re: [RFC PATCH 21/21] x86: Add support for CONFIG_CFI_CLANG
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

On Sat, Apr 30, 2022 at 2:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 29, 2022 at 01:36:44PM -0700, Sami Tolvanen wrote:
> > -     if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
> > +     if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > +         report_cfi(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
>
> This way you'll first get a BUG splat and then tack on the CFI thing.

The CFI ud2 isn't in the bug table, which means find_bug returns
BUG_TRAP_TYPE_NONE and report_bug bails out before printing out
anything.

Sami
