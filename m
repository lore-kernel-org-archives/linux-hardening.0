Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C1CC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2C610C8
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhJ1RPB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhJ1RPB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 13:15:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD6C061570
        for <linux-hardening@vger.kernel.org>; Thu, 28 Oct 2021 10:12:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so4910814plf.4
        for <linux-hardening@vger.kernel.org>; Thu, 28 Oct 2021 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rO/KgEXipkEFOtV4OljWjPnSu+OCWKZ6S7e5cXWpGdM=;
        b=E+RG2Kp0XaxbrDAcplrk34cq6KscFnOuOWhh/IkBSKWtdOinzE93sAQ1jQyxH/lA/4
         Q2aT7OrT1pS4rg1kbOSuna2v1KXwjnCl8++TiRBHXYdzDrpAEXb3zsHCwUh7X1nb5N9m
         hMyi0/Aky7uDavjOvj+pE5pxSTI6zOml2jflw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rO/KgEXipkEFOtV4OljWjPnSu+OCWKZ6S7e5cXWpGdM=;
        b=1Hd9Q+x4lD/WEZc8jm0etGnrY0pyC8N9aRKy+khjFFVnl4oqVw3Tdy6rlMgkO6Q+0U
         SGFymjaZb6Zw/BJ0lgm3g2tQbMnBuul0Jdi0H8jlcc8Mxlxk+GBV7Kf44uEw8MDQM6aQ
         zvg+lv5w5bsLHJRtzA1HEk2Nbq+dFLvMummqGVq6tA6NcBtbeSV9pbcp1Z6iTW2aT5IU
         Lq/clIaRWE4VvisT5GBByM4/RKqlacz5CZJ4grf4bUH8b/UaMoTwUaDjQ6ZWD6NU6XiE
         lobWw6Bocsa4E92OFLCR6zQcH565zV4oS9SYhjCY/06x2O5VmliuhbvyfzfJqnCZWnE4
         iUHw==
X-Gm-Message-State: AOAM531GCNyNQp/vFAT2WbaBrYcSHCCdkvlTAtEiW4IqW2bp+cNyFZzv
        oyTkqNOS0FINF4XfuYTBSlGPIA==
X-Google-Smtp-Source: ABdhPJz2IlT/T5zcy7GPPvlNfwi+mGi3/Sy+uWSNXOXjgOfRpr76rQQGzqDrofGNv/AmHNFYqJ+VWw==
X-Received: by 2002:a17:90a:5b0c:: with SMTP id o12mr14075957pji.11.1635441153641;
        Thu, 28 Oct 2021 10:12:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm7799796pjo.44.2021.10.28.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:12:33 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:12:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202110280958.22E5F74@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
 <202110271430.2A3980217@keescook>
 <YXqE82jQh4S79uVL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXqE82jQh4S79uVL@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 28, 2021 at 01:09:39PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 27, 2021 at 03:27:59PM -0700, Kees Cook wrote:
> 
> > Right -- though wouldn't just adding __ro_after_init do the same?
> > 
> > DEFINE_STATIC_CALL(static_call_name, func_a) __ro_after_init;
> 
> That breaks modules (and your jump_label patch doing the same is
> similarly broken).

Well that's no fun. :) I'd like to understand this better so I can fix
it!

> 
> When a module is loaded that uses the static_call(), it needs to
> register it's .static_call_sites range with the static_call_key which
> requires modifying it.

Reading static_call_add_module() leaves me with even more questions. ;)

It looks like module static calls need to write to kernel text? I don't
understand. Is this when a module is using an non-module key for a call
site? And in that case, this happens:

                key |= s_key & STATIC_CALL_SITE_FLAGS;

Where "key" is not in the module?

And the flags can be:

#define STATIC_CALL_SITE_TAIL 1UL       /* tail call */
#define STATIC_CALL_SITE_INIT 2UL       /* init section */

But aren't these per-site attributes? Why are they stored per-key?

                        if (!init && static_call_is_init(site))
                                continue;

			...

                        arch_static_call_transform(site_addr, NULL, func,
                                                   static_call_is_tail(site));


-- 
Kees Cook
