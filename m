Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9AC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5450B61052
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhJ0MyZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhJ0MyZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 08:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A5C061570;
        Wed, 27 Oct 2021 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cgkvcdwq0dJTP6ir5a7HxudmZPEOWaKKsMrUIHRFI/o=; b=og3HchErpvnTFHKZlelb9+dlvq
        8ru+KFjDxKagLEYcb5toOiS1A84QArMCc7LwLJOekz0CPZm1sIlbDt5AiMedG9k8OjqwxnikmOW0a
        vpDBzYunxz51QUU+4Jzzh3St53MewLvV6rsqC2o4D8B7w0bjHWKeJa3nafRLrdub8lhEn5Qf2rSUE
        ac133ljKr5WuUTzLLt0X7sQSPcUY0wewP+o6ZgIntI3Pgm72i84DOrr2LVwcWAq68ddvMutW1dvYH
        SJDA6flr6cV7yl3J+EBS0sHE6O89v9tNOXGgnqUqsqTpQpmvLUlz1kOVQIWnLduvDOMKDpLW8E63A
        s+PKQECg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfiMQ-0003D7-0b; Wed, 27 Oct 2021 12:49:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566C598629C; Wed, 27 Oct 2021 14:48:52 +0200 (CEST)
Date:   Wed, 27 Oct 2021 14:48:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211027124852.GK174703@worktop.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 02:22:27PM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:

> > > Should not this jump-table thingy get converted to an actual function
> > > address somewhere around arch_static_call_transform() ? This also seems
> > > relevant for arm64 (which already has CLANG_CFI supported) given:
> > >
> > >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> >
> > Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
> >
> 
> Sadly, that only works on symbol names, so we cannot use it to strip
> CFI-ness from void *func arguments passed into the static call API,
> unfortunately.

Right, and while mostly static_call_update() is used, whcih is a macro
and could possibly be used to wrap this, we very much rely on
__static_call_update() also working without that wrapper and then we're
up a creek without no paddles.

