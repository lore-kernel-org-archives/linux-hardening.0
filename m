Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9433C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A234613C1
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhDPWOn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:14:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235377AbhDPWOm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:14:42 -0400
Received: from zn.tnic (p200300ec2f0cc500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4988D1EC047C;
        Sat, 17 Apr 2021 00:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618611256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JIXRbZ9jZSmDqImsBeHy13rD+N8TDEMwdfms+ef02FI=;
        b=ZOuI4CnKuzTIQ5Yfi0zvWowFUbXXR+T8uPfI8ydDN4Tybr2g83e0n9E2GeuQ6nFCs0LaJ8
        8/NXnCWBQz9r+wilJ0saoGbtiOy+nl2ffPtJaGzDWRk+UAwDQpndOBc8AFMot680ecZ5b+
        Kfi0/oPL2Sec0zuTHUdU29nisNasQbw=
Date:   Sat, 17 Apr 2021 00:14:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <20210416221414.GF22348@zn.tnic>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
> On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > > __nocfi only disables CFI checking in a function, the compiler still
> > > changes function addresses to point to the CFI jump table, which is
> > > why we need function_nocfi().
> >
> > So call it __func_addr() or get_function_addr() or so, so that at least
> > it is clear what this does.
> >
> 
> This seems backwards to me.  If I do:
> 
> extern void foo(some signature);
> 
> then I would, perhaps naively, expect foo to be the actual symbol that

I'm just reading the patch:

... The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({                                           \
+       void *addr;                                                     \
+       asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=r" (addr));    \
+       addr;

so it does a rip-relative load into a reg which ends up with the function
address.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
