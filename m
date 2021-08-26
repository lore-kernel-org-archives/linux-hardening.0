Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F24CC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D160FE6
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbhHZLpH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbhHZLpH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 07:45:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890EC061757;
        Thu, 26 Aug 2021 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ixme4eya8uKU3GwfzladWeg6jmlS1N//eOJS8ymFAuM=; b=QfF6wngcX8dhFj/tUGusotEiRZ
        vzYSmRjccXynK9aGkPa2kdyLZvybGFagDMvBd3KyvVHuxFtw0Jrr6lVI0l4RULzRQaFjxg7qTsGsR
        B1W5NQ8DnkPtRCILgjDumKOowwF7hZ8tVuBLdGv1pXiHwk0EvSeUJsKhaHBK5ULeHuzVZItR4Mesf
        qPcObI/yd9G2umm1pPLiLaV8MniqnIQVPXeR7R8YiMaYbzDq1XipZKQnpMpD0TlU7qHAcC5yA0ox1
        FHclGy6MYEckDR+pqV/aWgOmS2EXZAQorvIiCqTQlo7c/3MNI9NGBX/PXwCm4Lul2afUoTLnFZtq6
        mlvvEr8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJDnd-00DBC6-Ms; Thu, 26 Aug 2021 11:44:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AEEC3004B2;
        Thu, 26 Aug 2021 13:43:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFC6A2C6DE545; Thu, 26 Aug 2021 13:43:59 +0200 (CEST)
Date:   Thu, 26 Aug 2021 13:43:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
Message-ID: <YSd+f9aY3kpdUo4r@hirez.programming.kicks-ass.net>
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210824194652.GB17784@worktop.programming.kicks-ass.net>
 <CABCJKud6JBk0QP0aSqM3ptRqbZLfKpfsHNF0RcTq4L-rbc7+uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKud6JBk0QP0aSqM3ptRqbZLfKpfsHNF0RcTq4L-rbc7+uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 25, 2021 at 08:49:36AM -0700, Sami Tolvanen wrote:
> On Tue, Aug 24, 2021 at 12:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 23, 2021 at 10:13:04AM -0700, Sami Tolvanen wrote:
> > > This series adds support for Clang's Control-Flow Integrity (CFI)
> > > checking to x86_64. With CFI, the compiler injects a runtime
> > > check before each indirect function call to ensure the target is
> > > a valid function with the correct static type. This restricts
> > > possible call targets and makes it more difficult for an attacker
> > > to exploit bugs that allow the modification of stored function
> > > pointers. For more details, see:
> >
> > If I understand this right; tp_stub_func() in kernel/tracepoint.c
> > violates this (as would much of the HAVE_STATIC_CALL=n code, luckily
> > that is not a valid x86_64 configuration).
> >
> > Specifically, we assign &tp_stub_func to tracepoint_func::func, but that
> > function pointer is only ever indirectly called when cast to the
> > tracepoint prototype:
> >
> >   ((void(*)(void *, proto))(it_func))(__data, args);
> >
> > (see DEFINE_TRACE_FN() in linux/tracepoint.h)
> >
> > This means the indirect function type and the target function type
> > mismatch, resulting in that runtime check you added to trigger.
> 
> Thanks for pointing this out. Yes, that would clearly trip CFI.
> 
> Any concerns about just writing a magic value to the slot instead of
> pointing it to a stub function, and checking for it before the call?

Performance :-) that compare is going to be useless roughly 100% of the
time.

> > Hitting tp_stub_func() at runtime is exceedingly rare, but possible.
> >
> > I realize this is strictly UB per C, but realistically any CDECL ABI
> > requires that any function with arbitrary signature:
> >
> >   void foo(...)
> >   {
> >   }
> >
> > translates to the exact same code. Specifically on x86-64, the super
> > impressive:
> >
> > foo:
> >         RET
> >
> > And as such this works just fine. Except now you wrecked it.
> 
> Sure. Another option is to disable CFI for the functions that perform
> the call, but I would rather avoid that whenever possible.

Is there no means of teaching the compiler about these magical
functions? There's only two possible stubs:

  void foo(...)
  {
  }

and

  unsigned long bar(...)
  {
	return 0;
  }

Both exist in the kernel. We can easily give them a special function
attribute to call them out.
