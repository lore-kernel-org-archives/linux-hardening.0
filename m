Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B1C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C179360F58
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhINTqT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhINTqT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:46:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65571C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:45:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f129so266850pgc.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40ZURQJupNlRJgwd5eFMDDAoOIJDnuXt7LSY56o8kS4=;
        b=lzKqvUMMu5rxZiqj9wuiEEqTywKGvVrRs/BoshVydiH6sBPIGfWkXRSzVTGM3rvCS2
         PAWNn8aqesPB4rxY0bXzkl7M1Ur32qcvhxqZYkIzSbrGQY7CJc1+59ig8uJED2rsTjGU
         fgPULrNelKVe1v2UbHUgYjnLPZhiru0ekHUt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40ZURQJupNlRJgwd5eFMDDAoOIJDnuXt7LSY56o8kS4=;
        b=3LAoEg1chuM8UaGqdPXRsltNmy5q07mtClL7LAAmtQDks/J249bL0GxnB17DDKb5+N
         8Z0zIVeCmbsKYawNi1IXwIpS1SPNo86plFyqY1SrIOphiSsCxTczQgPFRnTK/IIE08OS
         ZPtSt+bcWkBILRqxaAUDrgFbcCk1gEHUf/weGZTTQCFpA8Gr/jP8wy5vF7wib3JXwhmz
         O/Zgtl0E6Tpfsb5yRhlSIJCNRJFFoUy+KtwfL7cp/aKWVB3H7za/qdecgQQtQnDULNxz
         8RIoOVI+Skb2tFg3ecgSpiuPPZyyhzKZ2ceWFwM4iv91Mry13MPptSao5j720M1yO2bw
         zCdA==
X-Gm-Message-State: AOAM5307NFYsJbQq5q3LJ+IjBhLrB4d/I7/L5SqF0dpJhG5SoM0V6og/
        2j1QBXs1TruDqN6aFdfPFiMyug==
X-Google-Smtp-Source: ABdhPJwZC1UnAqusCV/aN1WgfFeau94VOV/0JXpAw24GnrE0f07TEv5EJbkRuymd8go+0OU8PPvHYg==
X-Received: by 2002:aa7:8426:0:b0:438:3550:f190 with SMTP id q6-20020aa78426000000b004383550f190mr6376014pfn.19.1631648700830;
        Tue, 14 Sep 2021 12:45:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm4983537pfv.201.2021.09.14.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:45:00 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:44:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 14/16] x86, cpu: Use LTO for cpu.c with CFI
Message-ID: <202109141240.6928C1498B@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:43PM -0700, Sami Tolvanen wrote:
> Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
> indirect call failures. CFI requires Clang >= 13, which doesn't have the
> stack protector inlining bug.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/power/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
> index 379777572bc9..a0532851fed7 100644
> --- a/arch/x86/power/Makefile
> +++ b/arch/x86/power/Makefile
> @@ -4,9 +4,11 @@
>  # itself be stack-protected
>  CFLAGS_cpu.o	:= -fno-stack-protector
>  
> +ifndef CONFIG_CFI_CLANG
>  # Clang may incorrectly inline functions with stack protector enabled into
>  # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
>  CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
> +endif

This seems weird -- it's tangential that CONFIG_CFI_CLANG is only on
Clang >= 13, but it does seem better than adding a $(shell) to test the
Clang version. So:

Reviewed-by: Kees Cook <keescook@chromium.org>

>  
>  obj-$(CONFIG_PM_SLEEP)		+= cpu.o
>  obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
> -- 
> 2.33.0.309.g3052b89438-goog
> 

-- 
Kees Cook
