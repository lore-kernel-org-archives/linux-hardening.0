Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF4C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1602060C51
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhINUkR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhINUkQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 16:40:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23369C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:38:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k65so761752yba.13
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tUhNAmB3jtMO0gp42EJpLQiu+VFBOkyW3SAAAq7Es0=;
        b=ftQuNUD3jSMSRh+XpHL49k409YunHBWy9hHpn+/k1fcL23TkgzbaS2M0+HoL4ePXZu
         LeDLpHnwHELMtbsje5OTNxaLk4EQOfqjauF7rF91GpSqz5paiaK1m3WXq1O7tTCdAZfm
         R9CyNECt+ve4IZQfeST4Shya0qXZhVoxAn2m8a6b+qp9XtkesagMoggau0GLTSJsJx2Q
         TpsMLZg80u57cBeTOabol4bH7ckl2SCpcqwiENrgbSstlxs0O6qpDShP8tuzE5qubZVE
         jlZVE3+Fmp88+7WN5RY01JXSQBA0aA2HNlofJntmCx6xJdfgyRJie7t3DRoRPHVz8UDj
         J5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tUhNAmB3jtMO0gp42EJpLQiu+VFBOkyW3SAAAq7Es0=;
        b=Gvy+38yXJeTjlZaUq2CO+VhAs5zEBXU4VhTQ1rnbG/sGRaL2vm8Fncm2YSY0K/a/LC
         NJZkaWV/whyBBvA1GXr/VrO5gOx+pCkciMG1V8Bfgdp9al0gF2y/sAZ3Dr0/kLW7QcrC
         bEVlYVWKNRrcXVrU5aMKJmX6GGCL2pdrbxC7DYNl96QOb3YIL/sHmsFNV+A8EyIa6uMK
         V6kgmUK8krc7iMtZaxTSuAHGIavg9CZ/OMqJCRO2Kve1z8WFNiPqxGCKukVIvIKLphBQ
         kNra+D3irwNsxoa01Q5DLdNDz/Xw+hJhMjt+Mekcgoj0617iAevbd8Oipsa0cixvFEtW
         L8bA==
X-Gm-Message-State: AOAM531OQDjXG38ru9xobgaUqP2EBjfK0sJ4+WWqmUziFL75MzjTZdM9
        pM5GAjoOLyg7qwSsTqZ1+DvBslL7D9tpJzELejsCzQ==
X-Google-Smtp-Source: ABdhPJzPGpq4cEKMF4OI2L0ct9rNcXmPLf9No4wBpBUk+cU2MWdf5maRpDo0f37bCEkina5qzEhBylM9KOgNPQY9OZw=
X-Received: by 2002:a25:eb0b:: with SMTP id d11mr1361200ybs.101.1631651938181;
 Tue, 14 Sep 2021 13:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-11-samitolvanen@google.com> <202109141235.BE65491A4@keescook>
In-Reply-To: <202109141235.BE65491A4@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:38:47 -0700
Message-ID: <CABCJKufuv_zNEu1=X+xnUYF6WmFU=ZjSCa0QzDJdUvFSD5gx0A@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] x86/extable: Mark handlers __cficanonical
To:     Kees Cook <keescook@chromium.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 14, 2021 at 12:10:39PM -0700, Sami Tolvanen wrote:
> > Exception tables are populated in assembly code, but the handlers are
> > called in fixup_exception, which trips indirect call checking with
> > CONFIG_CFI_CLANG. Mark the handlers __cficanonical to allow addresses
> > taken in assembly to pass CFI checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/mm/extable.c | 64 ++++++++++++++++++++++++-------------------
> >  1 file changed, 36 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> > index e1664e9f969c..d16912dcbb4e 100644
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -24,16 +24,18 @@ ex_fixup_handler(const struct exception_table_entry *x)
> >       return (ex_handler_t)((unsigned long)&x->handler + x->handler);
> >  }
> >
> > -__visible bool ex_handler_default(const struct exception_table_entry *fixup,
> > -                               struct pt_regs *regs, int trapnr,
> > -                               unsigned long error_code,
> > -                               unsigned long fault_addr)
> > +__visible __cficanonical
> > +bool ex_handler_default(const struct exception_table_entry *fixup,
> > +                     struct pt_regs *regs, int trapnr,
> > +                     unsigned long error_code,
> > +                     unsigned long fault_addr)
> >  {
> >       regs->ip = ex_fixup_addr(fixup);
> >       return true;
> >  }
> >  EXPORT_SYMBOL(ex_handler_default);
> >
> > +__visible __cficanonical
> >  __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
>
> Double __visible here, but with that fixed:

Ah, thanks for noticing that. I'll fix it in the next version.

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I would note that given Linus's recent comments on attribute locations,
> it does seem that __cficanonical is more a function behavior attribute
> than a storage class... I'm not really sure:
> https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com

__visible is not really a storage class either, but I thought it would
make sense to keep these attributes together. I can certainly move
them if anyone has strong feelings about the location.

Sami
