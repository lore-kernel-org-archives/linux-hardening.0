Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_SECURITY,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A7C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3076137D
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhDPW1Y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDPW1X (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:27:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3BC061574;
        Fri, 16 Apr 2021 15:26:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618612016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIMPFgWu4IqnP0nhiSA/nCdAulGUPJoqWG9L6Or5pk0=;
        b=bqRX0z1gwdEJaXLPYjJxyNOSYSnzHEMlXmiunIMoL64R0UBM6BjjRR8AThpNU31INBvWUA
        7V/zcmny4sDB9wwAzU8+IeUU7GsMAJTHYi2Q3Ewg1Y9fSmxokd4CjBrgGbR0A7pQrF5NUB
        dFSooyr6tL5EScMowSPzhc1LVnjedtZH4bytgcPb0Q59GfTjp/blR8Ic4mGOD7R5I7qM3S
        Psfhs0pZ6IbkiY0Wwp52kWF/zTLv7OpY2AURJZbcVQwHTPtsJmj4cyZlNe/xfr4rB/7xG9
        QRup/zOHKX5pvLqy0BWFNNLEDaxxzU5/hPHVyQBy+6AiDlqSSCCiV44h9ahQ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618612016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIMPFgWu4IqnP0nhiSA/nCdAulGUPJoqWG9L6Or5pk0=;
        b=A2StUduRfI+iimoCoHtRfwRfQKrj+FbVYD64CdnovAT2R/5kNqRRfERaW6P1hRq15092Fz
        bS87wCWSDscU0ZDQ==
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 06/15] x86: Avoid CFI jump tables in IDT and entry points
In-Reply-To: <20210416203844.3803177-7-samitolvanen@google.com>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-7-samitolvanen@google.com>
Date:   Sat, 17 Apr 2021 00:26:56 +0200
Message-ID: <87im4luaq7.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 13:38, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses in C
> code with jump table addresses.

Fine.

> To avoid referring to jump tables in entry code with PTI,

What has this to do with PTI?

> disable CFI for IDT and paravirt code, and use function_nocfi() to
> prevent jump table addresses from being added to the IDT or system
> call entry points.

How does this changelog make sense for anyone not familiar with the
matter at hand?

Where is the analysis why excluding 

> +CFLAGS_REMOVE_idt.o		:= $(CC_FLAGS_CFI)
> +CFLAGS_REMOVE_paravirt.o	:= $(CC_FLAGS_CFI)

all of idt.c and paravirt.c is correct and how that is going to be
correct in the future?

These files are excluded from CFI, so I can add whatever I want to them
and circumvent the purpose of CFI, right?

Brilliant plan that. But I know, sekurity ...

Thanks,

        tglx
