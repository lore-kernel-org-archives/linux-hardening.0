Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26794C43462
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF41B613CD
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbhDPVWG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbhDPVV6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0AC061343;
        Fri, 16 Apr 2021 14:19:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0A971EC0350;
        Fri, 16 Apr 2021 23:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618607937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UpcmZbbbGFBVK0S1XUfHo8fVMPRezkHQLhMcfuuypro=;
        b=qAv9ARPZvIpQqfteUj6uo33p2q1+OadyW3CgQJBw25mwdgfW9aPA7gahgdfij9hpCVVUts
        f7+RB/BjTsep91KMvLCVs1AOwHFqMGMBmIaqY1GQIFrRSi0Dr64l7XHnZwjt9Y5CGG+H8/
        BONKf4EVmuqDh1xHeYmwz2NxIdc6UFo=
Date:   Fri, 16 Apr 2021 23:18:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <20210416211855.GD22348@zn.tnic>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416203844.3803177-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:34PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> instrumented C code with jump table addresses. This change implements
> the function_nocfi() macro, which returns the actual function address
> instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/include/asm/page.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 7555b48803a8..5499a05c44fc 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -71,6 +71,20 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>  extern bool __virt_addr_valid(unsigned long kaddr);
>  #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
>  
> +#ifdef CONFIG_CFI_CLANG

Almost every patch is talking about this magical config symbol but it
is nowhere to be found. How do I disable it, is there a Kconfig entry
somewhere, etc, etc?

> +/*
> + * With CONFIG_CFI_CLANG, the compiler replaces function address
> + * references with the address of the function's CFI jump table
> + * entry. The function_nocfi macro always returns the address of the
> + * actual function instead.
> + */
> +#define function_nocfi(x) ({						\
> +	void *addr;							\
> +	asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=r" (addr));	\
> +	addr;								\
> +})

Also, eww.

It seems all these newfangled things we get, mean obfuscating code even
more. What's wrong with using __nocfi instead? That's nicely out of the
way so slap that in front of functions.

Also, did you even build this on, say, 32-bit allmodconfig?

Oh well.

In file included from ./include/linux/ftrace.h:22:0,
                 from ./include/linux/init_task.h:9,
                 from init/init_task.c:2:
./include/linux/ftrace.h: In function ‘ftrace_init_nop’:
./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of function ‘function_nocfi’ [-Werror=implicit-function-declaration]
 # define MCOUNT_ADDR  ((unsigned long)(function_nocfi(__fentry__)))
                                        ^
./include/linux/ftrace.h:671:35: note: in expansion of macro ‘MCOUNT_ADDR’
  return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
                                   ^~~~~~~~~~~
In file included from ./include/linux/ftrace.h:22:0,
                 from ./include/linux/perf_event.h:49,
                 from ./include/linux/trace_events.h:10,
                 from ./include/trace/syscall.h:7,
                 from ./include/linux/syscalls.h:85,
                 from init/main.c:21:
./include/linux/ftrace.h: In function ‘ftrace_init_nop’:
./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of function ‘function_nocfi’ [-Werror=implicit-function-declaration]
 # define MCOUNT_ADDR  ((unsigned long)(function_nocfi(__fentry__)))
                                        ^
./include/linux/ftrace.h:671:35: note: in expansion of macro ‘MCOUNT_ADDR’
  return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
                                   ^~~~~~~~~~~
In file included from ./include/linux/ftrace.h:22:0,
                 from ./include/linux/perf_event.h:49,
                 from ./include/linux/trace_events.h:10,
                 from ./include/trace/syscall.h:7,
                 from ./include/linux/syscalls.h:85,
                 from init/initramfs.c:10:
./include/linux/ftrace.h: In function ‘ftrace_init_nop’:
./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of function ‘function_nocfi’ [-Werror=implicit-function-declaration]
 # define MCOUNT_ADDR  ((unsigned long)(function_nocfi(__fentry__)))
                                        ^
./include/linux/ftrace.h:671:35: note: in expansion of macro ‘MCOUNT_ADDR’
  return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
                                   ^~~~~~~~~~~
In file included from ./include/linux/ftrace.h:22:0,
                 from ./include/linux/perf_event.h:49,
                 from arch/x86/events/core.c:15:
./include/linux/ftrace.h: In function ‘ftrace_init_nop’:
./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of function ‘function_nocfi’ [-Werror=implicit-function-declaration]
 # define MCOUNT_ADDR  ((unsigned long)(function_nocfi(__fentry__)))
...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
