Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46571C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C116121F
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 20:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhJEVAs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEVAs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 17:00:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1475CC061749;
        Tue,  5 Oct 2021 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UMuqJT4iXiHYRgVAi78sdHDL2h6KmuJDdgcgv9Tgm/s=; b=g9OV3u9Fam7+1ydBxINsS9GV42
        qEfU0QFicyhP73fgnZ3K1d0ui7pqUO1m4abIHKdGGFC1wIMK0KyVIEU1tdwjI2cWrwtjjvYh7ysPU
        AoYYk7fw8i9T8Dtjc1VdAsRfsFGN8/MftIIMKKb2VZk9M9eRqSpEq+3yNNR0y+FLACKjk7bCpmUB1
        u5CVFGUce/8/ATRTly4ugQXZue/Zi0FyzbjSzAQnwKZAR9e5OF03oB/nqIdiRatrJFzTrGZCtY50S
        R+AmfTy7ftAtKFDq8DaJ2XG3+gdDD/kktr0jeqhGrfOpbjUX5b+A8krE2Y3ahnDIaMIEQQuZjMm7b
        Sj+ZkJbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXrTw-000GjN-RO; Tue, 05 Oct 2021 20:56:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9E8C981AAA; Tue,  5 Oct 2021 22:56:12 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:56:12 +0200
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
Message-ID: <20211005205612.GF174703@worktop.programming.kicks-ass.net>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com>
 <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
 <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
 <20211005065923.GH4323@worktop.programming.kicks-ass.net>
 <CABCJKud1Gm0ouROKLAw9t03qbs+_EASky053=SqijPJahqogng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKud1Gm0ouROKLAw9t03qbs+_EASky053=SqijPJahqogng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 05, 2021 at 01:29:02PM -0700, Sami Tolvanen wrote:
> On Mon, Oct 4, 2021 at 11:59 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > For x86_64 it should indeed never get called, however if you plan on
> > supporting i386 then you need the annotation. Also, it might get called
> > on arm64 which is about to grow basic HAVE_STATIC_CALL support.
> 
> Good point. I read through the latest arm64 static call proposal and
> while it can fall back to an indirect call, it doesn't look like that
> would cause issues with CFI.

Because that call is outside of compiler control? Same will be true for
any HAVE_STATIC_CALL implementation I suppose. The trampoline will be
outside of compiler control.
