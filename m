Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCF5C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988DC60F25
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 19:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhH3T6u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhH3T6t (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 15:58:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C39C06175F
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 12:57:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a93so30542897ybi.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4eWYvLXqtDCW55gS9rY1AWkuU5oblAvUHBbE8tFwPM=;
        b=OGS3yhWXTyzWkpkWUMNaVxVTFC+AJsJpa1DFA/leGUMaTbpMJCmekJnDQQ4LplT57V
         jqNNZXj6JX7NOfeLnm+uT5dA0mLCg8pwGj1o0mYZdsP9Quvy5T5hSYvF5qmD9jfroMs2
         qPasNy6wNFNrWWLGUhw/SxSku/7Jy8no4SwyhhtopI+m/AyfB/hgwTGCjSSgtwhu2a7+
         FKUpLNZNgZ/Q5M1oSQsCFw3Sk4FXFmxqPBLJj7j9sNKn1/KD2yYZ732zInXTsWT7lC0T
         FYlAc0L7oTnv1eOt77XImOLWiEKn6m2ZSntrQB+KftmGlZJfZO07ewXz/XnvAxEUIHzY
         vDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4eWYvLXqtDCW55gS9rY1AWkuU5oblAvUHBbE8tFwPM=;
        b=USJwKbl3DruLjOhQC0E91NoiqODaxIJTXgziLvlyUpbLDyW+XDEvL3mhtvTc1Dy3Wd
         MrBw1HiM1Vy/1Z4A/qM4+11Oxb52M+gzWvdm0r9mAMzY9bSjoemI5LWUhRtOP6WteJCi
         DN6kPTCpTTe+IbKuDPQfs7wgc4QKlEkY2HwXp+4QTtIy/g2pIBgL6lPpqNI7SbEdWr3O
         UISRICczY0QL33tlfhoM/sDzhLm+xBSbAGqGGWL7/pI+s3lh6dt5Of+bWwW8LHLxaYdx
         EklHzZW3i7eAh8EauK7qj+AW62wZqlip8xAj+XN6D1EEhAb7LVsusHJ+9wVINjw/Ls40
         SV+w==
X-Gm-Message-State: AOAM532KFbgew3g33a736GZt8QbMICNZ5v+4nvskRwpc8gyYss4teyR5
        U8jCYrRp9TS4/N0wtakL3FthIZRqT44JsC/0QXlMiQ==
X-Google-Smtp-Source: ABdhPJzfPVC/aqfGdEcBrN11+dQpuqIHr6C0XzX81vMefCFwtWvmVxyFoBlwpKAw7HaWmKsQxG3hWFuvfK71fynvpXY=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr24784014ybt.47.1630353474553;
 Mon, 30 Aug 2021 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-9-samitolvanen@google.com> <e33bdfc8-6de9-0e91-eec6-39e6aca61758@kernel.org>
In-Reply-To: <e33bdfc8-6de9-0e91-eec6-39e6aca61758@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Aug 2021 12:57:43 -0700
Message-ID: <CABCJKufsdcfdSQ4JMx1dw1HXgqk4rtqGRoHMUdK6r5cxzrEg3Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] x86/extable: Do not mark exception callback as CFI
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Thu, Aug 26, 2021 at 9:56 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > The exception table entries are constructed out of a relative offset
> > and point to the actual function, not the CFI table entry. For now,
> > just mark the caller as not checking CFI
>
> Does this *mark* the caller as not checking CFI or does it actually make
> the caller stop checking CFI?  What are the semantics of a __nocfi function?

__nocfi disables CFI checking in the function, so in this case,
fixup_exception can make an indirect call anywhere.

> > The failure is most visible
> > at boot with CONFIG_DEBUG_RODATA_TEST=y.
>
> What's the failure?
>
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/mm/extable.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> > index e1664e9f969c..d150d4d12d53 100644
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
> >               return EX_HANDLER_OTHER;
> >  }
> >
> > +__nocfi
> >  int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
> >                   unsigned long fault_addr)
> >  {
> >
>
>
> This at least needs a comment explaining what's going on.  But maybe it
> could be fixed better by either having the extable entry resolve to the
> magic CFI table entry (can this be done?) or by marking the actual
> indirect call or the type of the variable through which the call is done
> as being a non-CFI call.

We can avoid the __nocfi here by marking the handlers __cficanonical.
This attribute tells the compiler to rename the function and point the
original name to the CFI jump table, which allows addresses taken in
assembly code to also pass CFI checking. I'll change this in v3.

Sami
