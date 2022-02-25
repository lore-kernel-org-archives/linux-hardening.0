Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78250C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Feb 2022 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiBYVAV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiBYVAU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Feb 2022 16:00:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CAB51E7F
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 12:59:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so5882574pjw.5
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 12:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fql4x3ovzVJy60LLROu61UmkOqqfZk4efC7nY269RYY=;
        b=iyJ8cdcMw6QQVVazrzlSy9h1aEZAY3Rkb/ll+q4jeCBq5asrG/dWw5lYoQplhVEs15
         MysenF/BH44K7JCXXm92wlr+S1CojKxCv5xJrJ1n7llFJx0clDXnMue9km97Z7OoPy/9
         /2hxBDfkkN706m/0pUrholl6F7mKJWK923HhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fql4x3ovzVJy60LLROu61UmkOqqfZk4efC7nY269RYY=;
        b=oySngEurRdB+hqY6bXtP6fGfVc7t9MsksrPrAyxK8QBRGUocLp23P4g9yIInShDosT
         gbSV7yrKvfoggy71CirP1XeFoQDp/qICRBszQIXDR5amfIf6yr1LtvST+PeEfjiFOYYm
         yFJexZgJgUT49D33/LHwCr2hccqeSVRfbUwe9KhxFWhzrVbe7TXfXRSAavl6NzOMSw+0
         a4wWd5vERXj6bzgAD7AIBU6b6qjEMsdDSj8HvvrywH5slqNQGQAnCY+Hn+A59PCQY9cD
         TskeupaEtqOlRd64prLGy4dN7FkORV/EhRRg93/vQGspHY8DLjHJx4mqIttLvgV6ispN
         x8mA==
X-Gm-Message-State: AOAM532RL/tQqiD1z1U00e8Gu9ROZOf9RI5WCB9amvCejxaK3duenIOM
        T330719q9GmMuWNmHmOLy5qLYw==
X-Google-Smtp-Source: ABdhPJy6gzigvV5ZMzn93/w/UhgMAifdcjjoAEXZz8/X7hRTMcFiMGHkU7gBwUXxlrKbQuWbwgIGCg==
X-Received: by 2002:a17:902:b488:b0:14e:e9f3:24a2 with SMTP id y8-20020a170902b48800b0014ee9f324a2mr9103669plr.72.1645822786686;
        Fri, 25 Feb 2022 12:59:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt8-20020a17090b354800b001bc509e0085sm9573094pjb.21.2022.02.25.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:59:46 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:59:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Message-ID: <202202251258.DB0F403B@keescook>
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 25, 2022 at 09:47:19PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 25, 2022 at 4:24 AM Dan Li <ashimida@linux.alibaba.com> wrote:
> >
> > +         - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
> > +         - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)
> 
> Maybe Clang: and GCC: instead of the parenthesis?
> 
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> > +#endif
> 
> Since both compilers have it, and I guess the `#ifdef` condition would
> work for both, could this be moved into `compiler_types.h` where the
> empty `__noscs` definition is, and remove the one from
> `compiler-clang.h`?

I thought about that too, but I think it's less simple due to the
__has_feature vs CONFIG differences, etc:
https://lore.kernel.org/lkml/202202251243.1E38256F9@keescook/

But maybe __has_feature doesn't really matter here?

-- 
Kees Cook
