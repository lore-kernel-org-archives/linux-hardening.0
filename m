Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED3C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7F961179
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 06:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhIOG0M (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhIOG0M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Sep 2021 02:26:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B7C061575
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 23:24:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso4149901pji.4
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vuCBzZ9zBNkDaxH2jJ5BbxSUdPvdCFa3DgGVw8Quh9c=;
        b=IpmZwGI6942DHOxFv4kJ7/ue70Xwg9Fxnip6YLfFQPIuFyzEmqBIOrejRsyoBdc3T3
         7izvZK7izFkZvO5GMB4G91KuvPLwBiJz9HEJFir1sAUOXbUiVwLvlk4Mfi1XNyR8KGhm
         8/xUEOOiVMFrofVh9igVKLlLMjqdtqdE8GUsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuCBzZ9zBNkDaxH2jJ5BbxSUdPvdCFa3DgGVw8Quh9c=;
        b=2qdWqIwewPxRe5j5zu0GlpCF2S6c/yUM71WaQ4JuV57WsaZ8x6J2mFKFbtQuEWw2F1
         VGo+13/uOdZ2kyg6VOmijiUhpvWcrVrXBjwaU8C1AFzq8pV1NZ/kcyNcFkZwwDpcU/OS
         SQUbL771clqJrUYVqhKLBrT47R1MZLJW8VjPHE7/16Bfj12Kl8o7MLkkOP8ZaVzQtUst
         xDOlQINfhCxgUGcvLXS4Gi8igUEtbrry9u+x/yONTJtBZVC7lgheUNm5keMQPITBcmu8
         RpXlGCgNYF+1VN2Q1p/2mXo2Fv7L+o+doSr2L7OOM8Y6mvbOrJ5LixmYnPgttzrD8vVG
         XzWg==
X-Gm-Message-State: AOAM532vUhPfSsHrzfRP/5Qfw1uMFuG+ddANbBmXMBiFBV0DTz/V6zTH
        dcyfdV20rI+iD4/4AuYK3XDBZA==
X-Google-Smtp-Source: ABdhPJyqrx7hBPKHGCo043/ShbjXHrI4bHbybJD44p09EnDBCs7/tS6xWCcaVY6oVAmwcLuJuE8VTQ==
X-Received: by 2002:a17:90b:1e06:: with SMTP id pg6mr6657056pjb.238.1631687093555;
        Tue, 14 Sep 2021 23:24:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm13559568pgk.57.2021.09.14.23.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 23:24:52 -0700 (PDT)
Date:   Tue, 14 Sep 2021 23:24:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
Message-ID: <202109142257.7BAE8074@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com>
 <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
 <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
 <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 03:31:14PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 14, 2021 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > >
> > > I kind of prefer the existing convention that has explicit guards on
> > > specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> > > CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> > > which configs may introduce which flags that are problematic. This
> > > patch is ok as is, but it kind of makes this Makefile more
> > > inconsistent.  I would prefer we had the explicit checks.

Can you explain your reasoning a bit more? It seems like redundant
open-coded logic to me, but I do see this idiom repeated in the kernel.
And/or maybe I've misunderstood you?

It seems like it's better to have a single variable (like in the proposed
patch: CC_FLAGS_CFI) that has all the details internal -- no tests needed.

i.e.: instead of this in many places:

ifdef CONFIG_FEATURE
PURGATORY_CFLAGS_REMOVE	+= -feature-flag
endif

do this once:

CC_FEATURE_CFLAGS	:= -feature-flag
...
KBUILD_CFLAGS		+= $(CC_FEATURE_CFLAGS)

and only repeat a single line in for targets:

CFLAGS_REMOVE_target.o	+= $(CC_FEATURE_CFLAGS)

> >
> > The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
> > way, but I don't have a strong preference here.
> 
> mmm...DISABLE_STACKLEAK_PLUGIN adds to PURGATORY_CFLAGS. This patch
> adds to PURGATORY_CFLAGS_REMOVE.

CFI is "simple" in that regard; its options can just be left off. This
isn't true for some weirder stuff. Stack protector is a good one, in
that just removing the options may not disable it depending on distro
patches (which may turn it on by default), so both target_CFLAGS and
target_REMOVE are needed there.

(In the case of the plugins, yes, I think they could be rearranged to
use the target_REMOVE method, but I have a memory of REMOVE not working
there for some weird thing? Hmm.)

-- 
Kees Cook
