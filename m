Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861FC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A71360231
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhHZWMz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhHZWMz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 18:12:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E0C0613C1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 15:12:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e129so8744955yba.5
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVcnpfqelprXusUWBTWhyR8bc4iZP7g4UmNmH8P05EA=;
        b=BT//sK3myuCW8lgwmsOHhvwUxIJfXLFEKePfUAWbYHLIatYx2C16orwd+hbH3uT5ng
         FaypAAk0NOC3mC8eQ7eaB0/bN8ofS7rLoUIVzH/FXa0c8YL1A0gqQSU46sJT4XwZLlNH
         pEPRWFHuzA+rCzOBWOE/niM3h9O4fBzwVRL2BTxYH+sGO+uDOO5C+TgaHsMslfXw24hm
         h3XDeMCeykretEj/KTin5kHRHf73Er8x8rJGWhcShpLuTpWioFjTvjABhZEBXoh0qtAL
         ZPhupjbwUH/acPwRWGtY1yW2/rxwrwqEgOmAPIwNzEJ+WjBwwlYm9tphCMEpFB+yd4MJ
         WUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVcnpfqelprXusUWBTWhyR8bc4iZP7g4UmNmH8P05EA=;
        b=Km+YW3bzPBeArnGNBQmfyFLHifPecZfC0ogD4mhE1FM4BVqcbVcjGtUqvrPn9jOb4G
         KK/Z3AyRf3aboo3b5IFc1/8xHw+4Bd3z2ANUhtK3wwp/p7Cj7drOMrzXBsZLvnlbYeQG
         En6OdBcpQnQ/x77bWi0nQG3Z5ivGgCbuE0RlsH//9pzHrLTjQLg9qpRZP5VDmnnGeHO9
         h6b3u00JkciG7Ufk0mF7Of9j2m/tdEjh22s/LoiQp9g+jYPurLXh6/8+xzUsYARGoGCQ
         q419hgKk9tc+V76AQZ7iNWz7Yh12Flpj+QmCl114ArddUy+M4KR6zLJEVBqswkceR6qK
         cX5A==
X-Gm-Message-State: AOAM531sThNC59bP7WiyO/N3gS23tdAv958fotjzB3hdV/CftYF9st10
        acWOhgFMCWGUVQMPikqVyLGWfyxscDqnYqELLYg0lg==
X-Google-Smtp-Source: ABdhPJzFNa4m0CjHi6tDz1iU7f3R5QbXIyBk3vmKYkduAEw6zEWFRwqLA0nP9aCQ9mBTSYF4sxFVr3+b5nGFCYLaXqY=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr1199603ybb.476.1630015926488;
 Thu, 26 Aug 2021 15:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com> <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
In-Reply-To: <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 26 Aug 2021 15:11:55 -0700
Message-ID: <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] x86: Use an opaque type for functions not
 callable from C
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

On Thu, Aug 26, 2021 at 9:54 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > The kernel has several assembly functions that are not directly callable
> > from C. Use an opaque type for these function prototypes to make misuse
> > harder, and to avoid the need to annotate references to these functions
> > for Clang's Control-Flow Integrity (CFI).
>
> You have:
>
> typedef const u8 *asm_func_t;
>
> This is IMO a bit confusing.  asm_func_t like this is an *address* of a
> function, not a function.
>
> To be fair, C is obnoxious, but I think this will lead to more confusion
> than is idea.  For example:
>
> > -extern void __fentry__(void);
> > +DECLARE_ASM_FUNC_SYMBOL(__fentry__);
>
> Okay, __fentry__ is the name of a symbol, and the expression __fentry__
> is a pointer (or an array that decays to a pointer, thanks C), which is
> at least somewhat sensible.  But:
>
> > -extern void (*paravirt_iret)(void);
> > +extern asm_func_t paravirt_iret;
>
> Now paravirt_iret is a global variable that points to an asm func.  I
> bet people will read this wrong and, worse, type it wrong.
>
> I think that there a couple ways to change this that would be a bit nicer.
>
> 1. typedef const u8 asm_func_t[];
>
> This is almost nice, but asm_func_t will still be accepted as a function
> argument, and the automatic decay rules will probably be confusing.
>
> 2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.
>
> 3. Use an incomplete struct:
>
> struct asm_func;
>
> typedef struct asm_func asm_func;
>
> extern asm_func some_func;
>
> void *get_ptr(void)
> {
>     return &some_func;
> }
>
> No macros required, and I think it's quite hard to misuse this by
> accident.  asm_func can't be passed as an argument or used as a variable
> because it has incomplete type, and there are no arrays so the decay
> rules aren't in effect.

I considered using an incomplete struct, but that would require an
explicit '&' when we take the address of these symbols, which I
thought would be unnecessary churn. Unless you strongly prefer this
one, I'll go with option 2 and rename asm_func_t to asm_func_ptr in
v3.

Sami
