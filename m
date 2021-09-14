Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A7C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92D060FED
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhINUeE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhINUeE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 16:34:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F0C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:32:46 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id s16so960595ybe.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfCs5ZOjiQwn8561ZlGnTqyiRoY51Z30liszO8UxNQY=;
        b=bcaWNiUmkwe6O+wIIy65AytawNojw83SBP2fQAkZFCKkQ5m+UNFh0SVKHeD9Tm1HWZ
         uszQabEJWi/OVKkhLwFZ/uNCVq8TzahJNZw9ppPmCbAEUQB2vDg3TQVBX9DdqWtpVwCF
         gTqrSnuoKk/jMCmAa9FJQJQ+DNoRoZMNeCPDGnYOUSHcRVOraJl7ATFALh7PSCmA3wWu
         NyvyLzKhIiCtq3ajsnqBaDoPgUtHKvvedNtdzWc675nYfwyakomLkU6Nte03hO+q+vrZ
         Foy8xooQQ7u9C47j5IHKWFwNSvWfimfm9OxmHEyF22wdToYgkTjWQI+RyNUPqPZj2DWx
         cj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfCs5ZOjiQwn8561ZlGnTqyiRoY51Z30liszO8UxNQY=;
        b=ogJCDvbWI4j8CX+Vl+/yydMaizB0PAD/eLsZ9TDg20lOR3qheqdjKRQKeInWr0A8Jb
         EwtX3lfN/VVaTRcnPbyyKjfvgkreIhI5QUAjuVqbdVp91t/jsm9RgbEhxQHq9U3hMya6
         /TLIPjaYgcyEYDfWQWNB9Atwo+rB8a7WCM5nPb/kgZfEg3I+b+5AE1uxrxa8M5Tmuk7C
         npmG1tBGfsqBwXWdlmlUmhRCkUWlUVHrg6uoPLW40yosMTm9jDpWIcf58+o2FOSSCRwk
         Gxs7f2plv4BbVdesOX38qgggAQm4ELBQL7PT5FlIhIYvjplOmVcqKsott/ohfbqlyCXn
         FpUQ==
X-Gm-Message-State: AOAM531XZDK2lRbrpy+kY45/b66AVyoI7jSP7jAbBOGQLZRpg/e9ea5U
        JiNoA5rpQMMuS+90QUF/1cBz2I5mg+s0XA29TGl1Nw==
X-Google-Smtp-Source: ABdhPJxIvcMD+L8IGnxkRjwWdcD9kMSbk077KA22bPLKMcWA4LzDlbScguPptlpzJDanrJWpmENcGDtAzzfrX1U2RdM=
X-Received: by 2002:a25:2142:: with SMTP id h63mr1475940ybh.70.1631651565763;
 Tue, 14 Sep 2021 13:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-5-samitolvanen@google.com> <CAKwvOdnTeTLcrjPy5QcshSLr0Cc2uj7_hTt70j37eEBZzxr=PA@mail.gmail.com>
In-Reply-To: <CAKwvOdnTeTLcrjPy5QcshSLr0Cc2uj7_hTt70j37eEBZzxr=PA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:32:34 -0700
Message-ID: <CABCJKuc1LNPfO=RBDpOahGBgc7TF1L4D_ujhbrNfFWJaExsjpQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> > which defines a stub function that immediately returns and when
> > defined in the core kernel, always passes indirect call checking
> > with CONFIG_CFI_CLANG. Note that this macro should only be used when
> > a stub cannot be called using the correct function type.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
> >  include/linux/cfi.h               | 14 ++++++++++++++
> >  kernel/cfi.c                      | 24 +++++++++++++++++++++++-
> >  3 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index f2984af2b85b..5b77284f7221 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -407,6 +407,16 @@
> >         KEEP(*(.static_call_tramp_key))                                 \
> >         __stop_static_call_tramp_key = .;
> >
> > +#ifdef CONFIG_CFI_CLANG
> > +#define CFI_EXCLUDED_DATA                                              \
> > +       . = ALIGN(8);                                                   \
> > +       __start_cfi_excluded = .;                                       \
> > +       KEEP(*(.cfi_excluded_stubs))                                    \
> > +       __stop_cfi_excluded = .;
> > +#else
> > +#define CFI_EXCLUDED_DATA
> > +#endif
> > +
> >  /*
> >   * Allow architectures to handle ro_after_init data on their
> >   * own by defining an empty RO_AFTER_INIT_DATA.
> > @@ -430,6 +440,7 @@
> >                 __start_rodata = .;                                     \
> >                 *(.rodata) *(.rodata.*)                                 \
> >                 SCHED_DATA                                              \
> > +               CFI_EXCLUDED_DATA                                       \
> >                 RO_AFTER_INIT_DATA      /* Read only after init */      \
> >                 . = ALIGN(8);                                           \
> >                 __start___tracepoints_ptrs = .;                         \
> > diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> > index 879744aaa6e0..9ebf67a0d421 100644
> > --- a/include/linux/cfi.h
> > +++ b/include/linux/cfi.h
> > @@ -20,6 +20,18 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
> >  #define __CFI_ADDRESSABLE(fn, __attr) \
> >         const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
> >
> > +/*
> > + * Defines a stub function that returns immediately, and when defined and
> > + * referenced in the core kernel, always passes CFI checking. This should
> > + * be used only for stubs that cannot be called using the correct function
> > + * pointer type, which should be rare.
> > + */
> > +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> > +       void fn(void) { return; } \
> > +       const void *__cfi_excl_ ## fn __visible \
> > +               __attribute__((__section__(".cfi_excluded_stubs"))) \
>
> Can we use __section from include/linux/compiler_attributes.h here
> rather than open coding the function attribute?

Sure. I'll change this in v4.

Sami
