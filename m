Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CEC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924F0610A7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhDPW7O (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhDPW7O (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:59:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D6C061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:58:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f29so20153721pgm.8
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7lKTje1FDbH8RC7t09nAcBS4GmeuzNtZ7eozWrilT3U=;
        b=OWzu2kaneOwwkRYo5fAB4MRjdtsJxb+E3WuMAC3HKUNaVJ3zElOlkj/eOpA2wRthZZ
         9+QUU05/xyu8+kADt0VsFbcTwdbJSHVF+YZtTaeZsfymTDh7xb25juaGU2qwZW1yN5Tm
         ey5WkMYCxN3lzdVuvWzCZIIQI+O1zfUm6exSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7lKTje1FDbH8RC7t09nAcBS4GmeuzNtZ7eozWrilT3U=;
        b=VhCKviX3XpBYSPVF/pUhEF+Fewq+ZRJ7AZFkE2A3S76X7qc5JgwGulvx99PqWnmWTn
         zKVTxUGuqboRqQ4bv2ylpg1lSqenmi9k343nv4669SCvjEsd3hFnlWuwB4+d20216R7Q
         MDp7oFjBOKnDp4FdB0Nu4OoafC4JZQA0Cayrluk6aVXPxx0anMgY0E0UJJrJ5G0Zdhez
         hx1b4HxB64O+QJ9SJFaIYeYOg4UkU8wFika+uXhyqv9f7Lxp3241dO89jEh3+1Dk1wAY
         jSucSvAgAVIQsnWJtK0QtXNpkzOpLuDfcCt3VXYburS4awLLR6p0E+Dd+/1VkbN0dSpr
         MgpQ==
X-Gm-Message-State: AOAM532kuiJbEyQe611hoMeJJyU1307rmnQjGaE91aTHXVwim5/15bys
        Eghy1dHTG6U0wx3k3BqM4lfw1A==
X-Google-Smtp-Source: ABdhPJzSfO2Vk1k71sr02ZQADRtuiUiz5smbdOc6kS2fC8g4QXRq+RmVUOkGjLwRyQMykD6dJXTUJQ==
X-Received: by 2002:a62:2b03:0:b029:241:d147:2a79 with SMTP id r3-20020a622b030000b0290241d1472a79mr9690722pfr.53.1618613928357;
        Fri, 16 Apr 2021 15:58:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm2534086pff.214.2021.04.16.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:58:47 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:58:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <202104161555.B8C1E193@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
 <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 03:52:44PM -0700, Andy Lutomirski wrote:
> > > char entry_whatever[];
> > > wrmsrl(..., (unsigned long)entry_whatever);
> >
> > This is just casting. It'll still resolve to the jump table entry.
> 
> How?  As far as clang is concerned, entry_whatever isn't a function at
> all.  What jump table entry?

Whoops, sorry, I misread the [] as (). I thought you were just showing
an arbitrary function declaration, but I see what you mean now.

I am digesting the rest of your email now... :)

-- 
Kees Cook
