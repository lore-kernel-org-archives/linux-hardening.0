Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61775C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C322613B5
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhJEHB1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJEHB1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 03:01:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D8C061745;
        Mon,  4 Oct 2021 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ilnRYqTFf8fyFuSzqW3O0n0QWAQ9g8mOenxw49e75Rg=; b=CMv16MhF/Am98MlSq+aU712wBL
        Pyz9j6zAixVPnrG/UmZbLboI969n1FF9339/KDL0c9zWrk9r8NSUOEkld8IIssJk5hjXNBq83IqsK
        PLrx66+Zpc5r58Gi1ZSpR3MV/4YmdoExnqF91dsK7do5qcuLJx3T8MJTJ6K9GoWz0EqUSGLOuMQl8
        IuO17vFEw78Qnv+wMgHM+LP7Z/z8qQPGjHJXdqN7UuyfKkdUoDPK2U02MnWJqvVnhzgNvtsgTzr+D
        4wNbQ6TOMEugO8sUEFg1KG1ph17Zzv8S0/Lti3ldMiwnUq9YYG2w82K2g6F+Bit2jMYnW2nVhIfNg
        3plpBQtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXeQ7-0080Dg-EX; Tue, 05 Oct 2021 06:59:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8258E9811EE; Tue,  5 Oct 2021 08:59:23 +0200 (CEST)
Date:   Tue, 5 Oct 2021 08:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
Message-ID: <20211005065923.GH4323@worktop.programming.kicks-ass.net>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com>
 <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
 <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 04, 2021 at 12:10:46PM -0700, Sami Tolvanen wrote:
> On Mon, Oct 4, 2021 at 6:50 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Why DEFINE_CFI_IMMEDIATE_RETURN_STUB() vs __no_cfi attribute that we can
> > stick on the relvant functions?
> 
> To avoid accidentally creating useful gadgets for attackers. For
> example, while excluding an empty stub isn't necessarily ideal,
> allowing calls to a function that always returns zero would be worse.

I was afraid you'd say something like that...

> > Because I've got at least one more variant for you :-) See
> > kernel/static_call.c:__static_call_return0
> 
> Does __static_call_return0 ever get called indirectly on architectures
> that support static calls? If it's always patched into a direct call,
> the type mismatch isn't an issue.

For x86_64 it should indeed never get called, however if you plan on
supporting i386 then you need the annotation. Also, it might get called
on arm64 which is about to grow basic HAVE_STATIC_CALL support.

(and just in case you care about CFI on PPC32, they too grew basic
static_call support)
