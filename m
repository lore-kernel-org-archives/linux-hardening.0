Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76491C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiFMUbo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351266AbiFMU34 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 16:29:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4631901
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 12:20:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so10412242lfa.6
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0O/0DmbRs+7MXOg+g7dkZYD+/tIewscyvV6ESK7mhQ=;
        b=HOdkBVIWNqU056KIzOpAxtJ+hARPtbhKZh0UFqk2E42MCGc4NI0bbNvqot9YBdek/u
         Aw3Ph3Cy725yYM58fI5EBjLaXvJ3IZA7sMs4+BRmmqE0M72v9SbnlbC8Djtl9NZNb8CU
         H7xn5l0SUfo734b7nIBfFERs63lfF0xmfxBcgkMDR5XHhk1OpUfJdlbEbqovlOtM5bwf
         703+UIJV5z9RrG9/Bi4GYdrekq9nxUWi4WJ77/+tLe180iF3OiNNIn/RGyj+dRjI2oiz
         zU6XL7qBEOCef7JP8Y46wJZV9HCALTmVCCDqgkpsePw0O7mAQ4gHyYbPjTspGXPI7MHe
         T/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0O/0DmbRs+7MXOg+g7dkZYD+/tIewscyvV6ESK7mhQ=;
        b=OQohVpZ2OhiUFEyNm5pZmmFCBIbtN8z4O63RN7tjeLtDNw+giiQIY/U3WeyyIsCvEl
         Tb4AlIlPpX9SlcUCrebBA6YUy+6rZ1zOo/5JIEC/JtwzkKVPn8RdI4CLn/7WajoDCywR
         tp38dbG7x8rLnwYpVA24RLgHAtbV5wfkv26yO97YWls5B3K7YwwEcIzYj2BvuNlxoDB+
         7uNc/PFtk6BpDt8ffHD55MtNYsPmFXlD/0DIy6Ysjj6J69o2Ql7IxRoYcJArYt/uv9lg
         +MOgxa7dKrih0qVAyjqJTFDeQXAD1mVBfWqLg4oGO/YP5MAlE/d1bBew193IJ8gCIXB9
         3vGQ==
X-Gm-Message-State: AJIora9x94WKIXK4pMVX2XVgNEWwDnctb2gWzVC1H9fD/t0tAWmcQ+Qa
        9aZdp46gKc9+2Hx1Wre/i/Y1QAZM01p+6gHRuDZR
X-Google-Smtp-Source: AGRyM1slaJnALPt1IdrnDQHmZ2dLpXWUN5aXU49HeMYiktjUgFM+PsAcD+NIJ/T25pitBW8x0Gqc0SCI0hzcZ0fBI0A=
X-Received: by 2002:a05:6512:524:b0:479:898:fd3c with SMTP id
 o4-20020a056512052400b004790898fd3cmr773787lfc.252.1655148003935; Mon, 13 Jun
 2022 12:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-17-samitolvanen@google.com> <CAKwvOdm1Abmu+NQ82ZLgX3O5g4vYPni23A9c4FJ+xeSYVwPtJw@mail.gmail.com>
In-Reply-To: <CAKwvOdm1Abmu+NQ82ZLgX3O5g4vYPni23A9c4FJ+xeSYVwPtJw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 13 Jun 2022 12:19:52 -0700
Message-ID: <CAGG=3QUt0mCA_Db93kuNkEMFGvO9AJUA4h9wxnVxvUn2Q1Mvqw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 16/20] kallsyms: Drop CONFIG_CFI_CLANG workarounds
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 10, 2022 at 4:40 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jun 10, 2022 at 4:35 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > With -fsanitize=kcfi, the compiler no longer renames static
> > functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
> > up the ThinLTO hash from the function names.
>
> Good riddance!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
Much clapping!

-bw

> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  kernel/kallsyms.c | 17 -----------------
> >  1 file changed, 17 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index fbdf8d3279ac..2fbb94817e02 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -179,7 +179,6 @@ static bool cleanup_symbol_name(char *s)
> >          * character in an identifier in C. Suffixes observed:
> >          * - foo.llvm.[0-9a-f]+
> >          * - foo.[0-9a-f]+
> > -        * - foo.[0-9a-f]+.cfi_jt
> >          */
> >         res = strchr(s, '.');
> >         if (res) {
> > @@ -187,22 +186,6 @@ static bool cleanup_symbol_name(char *s)
> >                 return true;
> >         }
> >
> > -       if (!IS_ENABLED(CONFIG_CFI_CLANG) ||
> > -           !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
> > -           CONFIG_CLANG_VERSION >= 130000)
> > -               return false;
> > -
> > -       /*
> > -        * Prior to LLVM 13, the following suffixes were observed when thinLTO
> > -        * and CFI are both enabled:
> > -        * - foo$[0-9]+
> > -        */
> > -       res = strrchr(s, '$');
> > -       if (res) {
> > -               *res = '\0';
> > -               return true;
> > -       }
> > -
> >         return false;
> >  }
> >
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
