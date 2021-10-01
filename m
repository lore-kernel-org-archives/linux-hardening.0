Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9091C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64BD610A3
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhJAUKo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJAUKn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Oct 2021 16:10:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD5C06177E
        for <linux-hardening@vger.kernel.org>; Fri,  1 Oct 2021 13:08:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v10so22952741ybq.7
        for <linux-hardening@vger.kernel.org>; Fri, 01 Oct 2021 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKG27X/tAaz6ZgSm5PLct1wo5H6VtWzGqhVRfSbCJeM=;
        b=K/EZX9fC9ZUuzFI6jrZypY1zTFUDt/PU70tLbqJHmQR1qUSX74ZaJgv2NcYZgAKyxp
         IGav/zFpLLCH001ejV1vMObkwX0wGHb+UKwQ6kSvjtnd8WWRAXyBC1NiC7MxyV9iJvcy
         rsCUB4L+pz5p17cwq7H2NsYsiU2vmQlHJ0Tcrq5gjSQbM8w8xZKBMin7C5Qzc1rpXYdz
         HKHH+DsRMvAYh8BOZSJFRxikufOUyCDSOOapRM7+NoJRPhev7XGLUTfGVqW8HkZcf0k2
         gZEuAouaG/VT/oHp5nPOEqDTxWb+ThYNaiR0o6i8VOaeFBhsVrUATAE4tcbhHOnazbOp
         7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKG27X/tAaz6ZgSm5PLct1wo5H6VtWzGqhVRfSbCJeM=;
        b=7Pa++rvgnNJxfXziIztovl8/zYqEg4i+4mJSiDh472p3MtiPmH8daD4GdcgpbbLsIX
         COU6fnWQg8mHfJMz8t49zAinjfSEe28N7bZkTEHVgUQHIFBEg1cFTMQxnCCj7j06uEh5
         I0l2UnKDlCi5clxjisTg8E3GWkUen+Y9nDYfKW2StPaYlCWeLqbOQ2/JYtpvRJEizGvt
         Yy8RHa11Ln539KV+w7p2zC8X3etOXWMu4wiG1Ed2nQp2ad//uu0GhtpS0ETtzj6FQ3oI
         HWE2SOXcTBF/dbZMJxJyuTeFA6SUdjHABihdI+ZI1CjkBEOpFPbHvQ5AT/Qi0kKS0d7U
         3Jpw==
X-Gm-Message-State: AOAM531OX+b2JRyIY2k9dkA2+u+HA8qEhGyd+RHVSMkaggwJhSupLzis
        zdbOLAM+qLgTFMkwx2M9Ra/D6LCWxgR/aCbKYhJurg==
X-Google-Smtp-Source: ABdhPJwOtf4LpoL1TJ/IJSfZorBhBurQK2kH41u3Fyo5ujc2AgTfHjWisxqRuQ+5FkxK3/PBitfSFea2DlJ3i0S6fX4=
X-Received: by 2002:a25:e6d0:: with SMTP id d199mr8208144ybh.527.1633118938474;
 Fri, 01 Oct 2021 13:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-6-samitolvanen@google.com> <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
In-Reply-To: <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Oct 2021 13:08:47 -0700
Message-ID: <CABCJKue1dDYe9aL0ExU8NMORxJN-7qhF=D+=sSKr0d2Quhb3YA@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:51 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > If allocate_probes fails, func_remove replaces the old function
> > with a pointer to tp_stub_func, which is called using a mismatching
> > function pointer that will always trip indirect call checks with
> > CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> > tp_stub_func to allow it to pass CFI checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  kernel/tracepoint.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 64ea283f2f86..58acc7d86c3f 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
>
> looking at 4+5/15 together, I wonder if this TU should explicitly
> include linux/cfi.h?

Good point. Currently cfi.h is included in module.h, but including it
explicitly makes this less likely to break in future. I'll add an
explicit include in v5. Thanks for taking a look!

Sami
