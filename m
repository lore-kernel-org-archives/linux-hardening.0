Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4EC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9983260041
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 11:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1LOn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LOn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 07:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D2C061570;
        Thu, 28 Oct 2021 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N7GZ22gb+iGao7JNthfhMzqUFJ1nHCbCiKPouEv2QCE=; b=uNQphv4X1bK24WiK/EUb2sc1Ne
        HL0dtPCjNqlc3UAfHG3D3Djn9F66Zh1WlD5+wgguWUHBmtdIRxW2TWe8cltP3lXclj/GKV7AtWIWI
        7zJAsFhlpPsxGNzdZnSVjE6mUmBsl71qoFuektruFPCHZXqIXw2TAi+4AAf6CD26MgIN0YHEcEt9m
        R+G/Zr2/CtzLdNxT93UGDUQ1dhF0gl+XmGIYEHJDJmzGnynEUqVEMe8e/jaDMmvB7Jn0f0iWlYZKC
        ZR5qrUnGUc/r9lwPZdHLkv7+ODh93R9EG6a49w7nitY8fFFavnc2Abe4a6A7FR8GVaHzgis3hzQy9
        dhF6OxFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg3Hx-000ilK-VV; Thu, 28 Oct 2021 11:10:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92F8430022C;
        Thu, 28 Oct 2021 13:09:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5622C20D903DE; Thu, 28 Oct 2021 13:09:39 +0200 (CEST)
Date:   Thu, 28 Oct 2021 13:09:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <YXqE82jQh4S79uVL@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
 <202110271430.2A3980217@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110271430.2A3980217@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 03:27:59PM -0700, Kees Cook wrote:

> Right -- though wouldn't just adding __ro_after_init do the same?
> 
> DEFINE_STATIC_CALL(static_call_name, func_a) __ro_after_init;

That breaks modules (and your jump_label patch doing the same is
similarly broken).

When a module is loaded that uses the static_call(), it needs to
register it's .static_call_sites range with the static_call_key which
requires modifying it.
