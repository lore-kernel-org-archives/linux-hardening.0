Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0FC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758F16120C
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhJFDbp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237173AbhJFDbo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633490992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Py+JZnh73iO8dfi3ucj0KCUA94S2WthHSRpjsAjnr5s=;
        b=iFmmsPlU2ltQ51ye3w8FiUBlnW5LmLP2XNG5AXru/EW8TIkV0fYb0IlwBbgfIeYZATaHaM
        y+l7g9Ba40Dgxwu9+09zzsV/HJ7WvP3zkkMXOjt2IHwACeAOiSvHSG0YY5uulUVwPAK/E2
        ZP1tikmJBus8yyYLWEN8pzNrLlJ6pDw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-T6VHo6vQMmuw-pURbVGn6g-1; Tue, 05 Oct 2021 23:29:50 -0400
X-MC-Unique: T6VHo6vQMmuw-pURbVGn6g-1
Received: by mail-oo1-f71.google.com with SMTP id b3-20020a4a9bc3000000b002b66bb6c794so874748ook.20
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Py+JZnh73iO8dfi3ucj0KCUA94S2WthHSRpjsAjnr5s=;
        b=CTO00qjD1rQ3jfWQNIQ2YzVuUnXb37FQ+Lfb8QDcHLLfe4c5RThaGSDLhAhAcZ5skh
         6oCHUcbavrZbW3qtw9mbr8g97H7yriwpv2sWcrhUlTe51+Uq0vY4mq0dv1eJc5W3CuDi
         QlSMVBLTUoNVadT8dQYZ+tdI8ea6F3q2hqUJ1xG9PDoARpOXgq4jJAPvxDmlzGG1H+zI
         msN8xU+QLBySIYoZZmQcOGhN92olXfff5/4zXTg/BPxSGAEzg4nQ/dKWzUvU01fCn9+V
         0D30W1jtDylhk5n6xIjdEEoHHzRSLvlwscdiLrjFOC3azjtePXx1JQmseW6CAama/jSw
         OJfQ==
X-Gm-Message-State: AOAM531zbQVjDDXohro2IysVpOUo9nmUQWn3zyZnL/Zty1qggMw3Kmtu
        19DK24Ou2GCHiC4StMPo6k13/+WHVQa42IcRiWvM+ybUpur32WDgm8zXzSe0j0rQr9VRYP6KTC2
        UwqeLMQJn49RtGXHvmCjdwgcytU4y
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr17609235otp.143.1633490989298;
        Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2vFAYge4anWPhwrb90uw13BuOS6xxF266F6ouThw1f6/Zl32C6XLGYYQ1vnCKVEYNl3IbZA==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr17609222otp.143.1633490989040;
        Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bb39sm2950182oib.28.2021.10.05.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:29:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:29:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006032945.axlqh3vehgar6adr@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20210930180531.1190642-7-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler changes function references to point
> to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/ftrace.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 832e65f06754..67de28464aeb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
>  extern int ftrace_update_ftrace_func(ftrace_func_t func);
>  extern void ftrace_caller(void);
>  extern void ftrace_regs_caller(void);
> -extern void ftrace_call(void);
> -extern void ftrace_regs_call(void);
> -extern void mcount_call(void);
> +
> +DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
> +DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
> +DECLARE_ASM_FUNC_SYMBOL(mcount_call);

I'm thinking DECLARE_ASM_FUNC_SYMBOL needs a better name. It's not clear
from reading it why some asm symbols need the macro and others don't.

I guess it means "an asm text symbol which isn't callable from C code
(not including alternatives)"?

DECLARE_UNCALLED_SYMBOL() maybe?

-- 
Josh

