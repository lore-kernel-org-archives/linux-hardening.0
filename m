Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50603C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3966137D
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhDPWiS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPWiP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:38:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DDEC061756
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:37:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w6so4731405pfc.8
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NDhS9ea/Ghy92VBWAgivjVBpdpN6nWgmnBRq9q7wlPI=;
        b=D8UkrwRL94aleXQSNpyGSiYhqv/HLOAHwV5Ki9OjU8tDlDV2mvmiEPsCX7g46fNsKP
         13Cjxc9eXQo7iZcFwO+hiZCkUp7SvAnf2ZEP2ye+dUsmgDNFEpLdEgFk8QAwdhfbF9jB
         QzyvzX7nISRqZelsff9tB0CnX9wLJPmVHM7A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NDhS9ea/Ghy92VBWAgivjVBpdpN6nWgmnBRq9q7wlPI=;
        b=lReru8lfhyB9e58HKBBOYNhhXFCp6qh5qRnLbC+qrne751yP3RtvbzhfBCvYhqEVDh
         OICxuH+I2reoLSicyNheNse9VClMt1Qaytr3D3Kk6CXIgZyLOfUdDk0DdfRMSAI3ikZE
         x4r/fn+xPWLatVYlLP19cUMWiLAXwMRx5KplPc7u28ufCUpC43aD+KL8znvpJc3YhOiy
         kwxVBxdXSi1nffx4cCMf/5UR/fC0mFXgsFKu8eItLqnIfJ0vH1bd0gsCUzFPNomkLIFW
         VgCHMpkeHZY9QwNEiJzbETYci5wDYNmNj6FBeJuUv1lX9+SxP95E9dIMcQbbGirmw1BG
         UKgw==
X-Gm-Message-State: AOAM531JZPdzkrzzpAZCDkw2F7A/GPjhn0FPcgVKUBCCbO9G49siwV79
        +OBkFVQiY7LOsntVb64LxEvITOS7A/Ujcw==
X-Google-Smtp-Source: ABdhPJyLPR+dwiUvHFg0+P777OMbFma5qhQIoK2X34lCfZk57mmU7EZkViqoUPbRixjENrAKVezlGA==
X-Received: by 2002:aa7:8486:0:b029:250:f6fc:ae93 with SMTP id u6-20020aa784860000b0290250f6fcae93mr9648698pfn.39.1618612669362;
        Fri, 16 Apr 2021 15:37:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h21sm2461475pfh.130.2021.04.16.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:37:48 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:37:47 -0700
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
Message-ID: <202104161529.D9F98DA994@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <20210416221414.GF22348@zn.tnic>
 <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 03:20:17PM -0700, Andy Lutomirski wrote:
> But obviously there is code that needs real function pointers.  How
> about making this a first-class feature, or at least hacking around it
> more cleanly.  For example, what does this do:
> 
> char entry_whatever[];
> wrmsrl(..., (unsigned long)entry_whatever);

This is just casting. It'll still resolve to the jump table entry.

> or, alternatively,
> 
> extern void func() __attribute__((nocfi));

__nocfi says func() should not perform checking of correct jump table
membership for indirect calls.

But we don't want a global marking for a function to be ignored by CFI;
we don't want functions to escape CFI -- we want specific _users_ to
either not check CFI for indirect calls (__nocfi) or we want specific
passed addresses to avoid going through the jump table
(function_nocfi()).

So, instead of a cast, a wrapper is used to bypass instrumentation in
the very few cases its needed.

(Note that such a wrapper is no-op without CFI enabled.)

-- 
Kees Cook
