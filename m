Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DBC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A4760E0B
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhHZXq5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbhHZXq4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 19:46:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299DC061757
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 16:46:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k78so5894644ybf.10
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJVh8U7H1D0AP9Coqw4pJN8m0+s+/ZBxKNZaTaJtBCs=;
        b=Xqhk5PzMZ8HwiFHy1j3KgSqIUsuesqOgAYxTqG+gg3IKh74p9Lc0qmnQIbPJPadJAH
         s+1b84DrufWYCarVbavP9HYs1l8Mf23WhxGnhLc5NHwM1aZV3QxyitPT6qcUoWO8cAsJ
         IkFkpkg8zh6EAkS0DtVSs8zlXq/GYP0uYYWtAX0RSYArNp3r1FHd21C4QeZib06amuht
         bOvIKFCoa21xDnN85hwIw/+lTqhUzpz5fGCFdVf93eqjXTNqP/lgPmC1vAKcQ295+tq0
         DnNFCGq44tKL6Z3R8VloEQWQffjm59guTFxGbEtXxMX0D+WvRsZpfEQmQT9BtOZkTgzz
         hypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJVh8U7H1D0AP9Coqw4pJN8m0+s+/ZBxKNZaTaJtBCs=;
        b=H6k5Wys27NQplNuuj/vtn0hTbQBLswjv3bx7hiEA+040epxc1C+e8WgdECCVVqzAIx
         jdnIZqy0tsZkEEinFt4oF9STy1WoiwRt6hDA/z/DPtB0I235k6ULcRbAUM347laBs1hr
         w3BaFX4lFnvR8cxE4WC8uHFsO8vzzpbPGP7LUyWl29ENnYwRPxZGj3CkkE9/qD85Qofg
         FEBMxV4DN+8eAyfzl4LCT8i/RIK6pNRqdPFaOwo63qljd6C/X0Fy6X2Fk4vSPRFiQeXh
         GLAd+yE28z/4iq72RfJlLPnW174bVEZUmU03gSJXwVZkhSTqlF5n+Uj5P00ZozNIhBeW
         +p7g==
X-Gm-Message-State: AOAM532dg0vrnsLGBExpCw9cE6d7d+A++T3oPL/AMA/QqeEgm9dEtixq
        28Ki4LGvNnskZl42baopwxyuqSh2iQbBVUWZQzr7bA==
X-Google-Smtp-Source: ABdhPJxAOEGBwm8gjuZ5VtjQ9bngsTCVz4sLCbftexa9Obb7SZdCWz6S38c+wzpRgFDk6IG6atpQjye9P0dszmTioTg=
X-Received: by 2002:a25:1b09:: with SMTP id b9mr1576338ybb.293.1630021567153;
 Thu, 26 Aug 2021 16:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com> <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
 <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com> <959b3e65-97c9-4e00-87c5-f4a31c6739de@www.fastmail.com>
In-Reply-To: <959b3e65-97c9-4e00-87c5-f4a31c6739de@www.fastmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 26 Aug 2021 16:45:56 -0700
Message-ID: <CABCJKud4auwY50rO0UzH721eRyyvJ8+43+Xt9vcLgw-SMYtHEw@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] x86: Use an opaque type for functions not
 callable from C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 26, 2021 at 4:24 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Thu, Aug 26, 2021, at 3:11 PM, Sami Tolvanen wrote:
> > On Thu, Aug 26, 2021 at 9:54 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > > > The kernel has several assembly functions that are not directly callable
> > > > from C. Use an opaque type for these function prototypes to make misuse
> > > > harder, and to avoid the need to annotate references to these functions
> > > > for Clang's Control-Flow Integrity (CFI).
> > >
> > > You have:
> > >
> > > typedef const u8 *asm_func_t;
> > >
> > > This is IMO a bit confusing.  asm_func_t like this is an *address* of a
> > > function, not a function.
> > >
> > > To be fair, C is obnoxious, but I think this will lead to more confusion
> > > than is idea.  For example:
> > >
> > > > -extern void __fentry__(void);
> > > > +DECLARE_ASM_FUNC_SYMBOL(__fentry__);
> > >
> > > Okay, __fentry__ is the name of a symbol, and the expression __fentry__
> > > is a pointer (or an array that decays to a pointer, thanks C), which is
> > > at least somewhat sensible.  But:
> > >
> > > > -extern void (*paravirt_iret)(void);
> > > > +extern asm_func_t paravirt_iret;
> > >
> > > Now paravirt_iret is a global variable that points to an asm func.  I
> > > bet people will read this wrong and, worse, type it wrong.
> > >
> > > I think that there a couple ways to change this that would be a bit nicer.
> > >
> > > 1. typedef const u8 asm_func_t[];
> > >
> > > This is almost nice, but asm_func_t will still be accepted as a function
> > > argument, and the automatic decay rules will probably be confusing.
> > >
> > > 2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.
> > >
> > > 3. Use an incomplete struct:
> > >
> > > struct asm_func;
> > >
> > > typedef struct asm_func asm_func;
> > >
> > > extern asm_func some_func;
> > >
> > > void *get_ptr(void)
> > > {
> > >     return &some_func;
> > > }
> > >
> > > No macros required, and I think it's quite hard to misuse this by
> > > accident.  asm_func can't be passed as an argument or used as a variable
> > > because it has incomplete type, and there are no arrays so the decay
> > > rules aren't in effect.
> >
> > I considered using an incomplete struct, but that would require an
> > explicit '&' when we take the address of these symbols, which I
> > thought would be unnecessary churn. Unless you strongly prefer this
> > one, I'll go with option 2 and rename asm_func_t to asm_func_ptr in
> > v3.
> >
>
> Do you have a sense for how many occurrences there are that would need an &?

Quick grepping suggests there are ~80 occurrences in arch/x86. ~40 of
these are in kernel/idt.c.

Sami
