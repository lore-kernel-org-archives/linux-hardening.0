Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8DC4320A
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Aug 2021 23:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E38660F11
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Aug 2021 23:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhHQXG4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhHQXGz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Aug 2021 19:06:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE7C0613C1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 16:06:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t1so247283pgv.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaKngo/8ZlHEBLj1jP+O4Z1mFHVZKSSIVUM++5l/+Wc=;
        b=GOFWORu6dqeDyo4EV0Bd0ftRATs+16ZBsiTn/fjack3xMIiJ0UE1ebo9OpFG5USjZJ
         D9IsdhsxioZFpPVcNJO4HxeU4pZHGmhlLSYSHTPewKYf+nJFZrhRez2ZCDUuTyMRUYv8
         2BZQ+mPVmLANeeXFy2VVSEs0rrZ5zhx1uRjMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaKngo/8ZlHEBLj1jP+O4Z1mFHVZKSSIVUM++5l/+Wc=;
        b=NUq311zVRx9ec8n4D3BwC4cxCWdhAjNH91mgxIGF8VF5oUJttBZD2iw3HL4v4dEtbm
         SlpKLnPNtPpqaZx2m0/lsYzmuKPFCPVz4gcHr2pw6eK3mlgigoTtvlwv7T3N8/FYDT0p
         tLqpcZ3hJQ56vG9+y5ll9Wsdp4updJtzLZBjxbUAEKXnka0XrovmlxSV84ZGtLJs2237
         rwWzWYlOgZI1UaKqVqF4d0cAH/jtRjOQlPwRcfoSABWlBsYwDXJnAPveWdrNWavIYXPH
         7EduskulF8RQLTRvT1R3ZeyXGrSqD05b8RgOP2wFHD3R4FiOi6oFyis46bDLYYHoaOEv
         TX3g==
X-Gm-Message-State: AOAM533FD+aHMYKKvSSx2YBXFkwkFdzmQkoZXbk6ut7i/ar4kitwZk/F
        G3DANvcN8Me+BtFs5BOx+SL6JQ==
X-Google-Smtp-Source: ABdhPJyimgmHWWwYaT/as4tuJK2E43MkAZUqYwuum/lfPnSmuPUZCp4CYiCFRpWsc3wGOiCUlA3v4w==
X-Received: by 2002:a62:864b:0:b029:3c7:7197:59fc with SMTP id x72-20020a62864b0000b02903c7719759fcmr5970693pfd.59.1629241581351;
        Tue, 17 Aug 2021 16:06:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i20sm3958076pfq.35.2021.08.17.16.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 16:06:20 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:06:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Enable -Wimplicit-fallthrough for clang 14.0.0+
Message-ID: <202108171602.159EB2C7EA@keescook>
References: <20210817005624.1455428-1-nathan@kernel.org>
 <80fa539a-b767-76ed-dafa-4d8d1a6b063e@kernel.org>
 <CAHk-=wgFXOf9OUh3+vmWjhp1PC47RVsUkL0NszBxSWhbGzx4tw@mail.gmail.com>
 <5c856f36-69a7-e274-f72a-c3aef195adeb@kernel.org>
 <202108171056.EDCE562@keescook>
 <3f28b45e-e725-8b75-042a-d34d90c56361@kernel.org>
 <CAK7LNAQFgYgavTP2ZG9Y16XBVdPuJ98J_Ty1OrQy1GXHq6JjQQ@mail.gmail.com>
 <71d76c41-7f9b-6d60-ba4f-0cd84596b457@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d76c41-7f9b-6d60-ba4f-0cd84596b457@embeddedor.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 04:33:25PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 8/17/21 16:17, Masahiro Yamada wrote:
> > On Wed, Aug 18, 2021 at 3:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On 8/17/2021 11:03 AM, Kees Cook wrote:
> >>> On Mon, Aug 16, 2021 at 09:55:28PM -0700, Nathan Chancellor wrote:
> >>>> If you/Gustavo would prefer, I can upgrade that check to
> >>>>
> >>>> ifneq ($(call cc-option, -Wunreachable-code-fallthrough),)
> >>>>
> >>>> I was just trying to save a call to the compiler, as that is more expensive
> >>>> than a shell test call.
> >>>
> >>> I prefer the option test -- this means no changes are needed on the
> >>> kernel build side if it ever finds itself backported to earlier versions
> >>> (and it handles the current case of "14" not meaning "absolute latest").
> >>>
> >>> More specifically, I think you want this (untested):
> >>
> >> That should work but since -Wunreachable-code-fallthrough is off by
> >> default, I did not really see a reason to include it in KBUILD_CFLAGS. I
> >> do not have a strong opinion though, your version is smaller than mine
> >> is so we can just go with that. I'll defer to Gustavo on it since he has
> >> put in all of the work cleaning up the warnings.
> > 
> > 
> > 
> > https://github.com/llvm/llvm-project/commit/9ed4a94d6451046a51ef393cd62f00710820a7e8
> > 
> >    did two things:
> > 
> >  (1) Change the -Wimplicit-fallthrough behavior so that it fits
> >       to our use in the kernel
> > 
> >  (2) Add a new option -Wunreachable-code-fallthrough
> >       that works like the previous -Wimplicit-fallthrough of
> >       Clang <= 13.0.0
> > 
> > 
> > They are separate things.
> > 
> > Checking the presence of -Wunreachable-code-fallthrough
> > does not make sense since we are only interested in (1) here.
> > 
> > So, checking the Clang version is sensible and matches
> > the explanation in the comment block.

I thought one of the problems (which is quickly draining away) that
needed to be solved here is that some Clang trunk builds (that report
as version 14) don't yet have support for -Wunreachable-code-fallthrough
since they aren't new enough.

> > # Warn about unmarked fall-throughs in switch statement.
> > # Clang prior to 14.0.0 warned on unreachable fallthroughs with
> > # -Wimplicit-fallthrough, which is unacceptable due to IS_ENABLED().
> > # https://bugs.llvm.org/show_bug.cgi?id=51094
> > ifeq ($(firstword $(sort $(CONFIG_CLANG_VERSION) 140000)),140000)
> > KBUILD_CFLAGS += -Wimplicit-fallthrough
> > endif
> > 
> > The $(sort ...) is alphabetical sort, not numeric sort.
> > It works for us because the minimum Clang version is 10.0.1
> > (that is CONFIG_CLANG_VERSION is always 6-digit)
> > 
> > It will break when Clang version 100.0.0 is released.
> > 
> > But, before that, we will raise the minimum supported clang version,
> > and this conditional will go away.

If a version test is preferred, cool; this is a nice trick. :)

> I like this. :)
> 
> I'm going to make the 0-day robot test it in my tree, first.

Sounds good to me!

-- 
Kees Cook
