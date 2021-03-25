Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAEAC433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Mar 2021 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C139C61A27
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Mar 2021 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhCYXSS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Mar 2021 19:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhCYXSQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Mar 2021 19:18:16 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ED6C061760
        for <linux-hardening@vger.kernel.org>; Thu, 25 Mar 2021 16:18:12 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id h5so1065137uaw.0
        for <linux-hardening@vger.kernel.org>; Thu, 25 Mar 2021 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Yk9NlOmGKofkdfMA6+3ywtQqOEAPVMOAz3hdr7uXvE=;
        b=vA7OWbbKWkumvZyucEZbcqeuCLfEdVpEWrKxOGx3P4tN9R3u/6w/09xaucaXo3fP1z
         MQIYpOTb4zLWU/hQWjL9CBjSTPJO+KxQfG7Dx96rt5gAiLXhhKoC7ABFmLukh4KXeZ9Z
         aRhWqpdYN7r23J9Vzze5A3lqpbSCfVHcu6YBrOLJtfWDQkdTihrZonOMBhhW48YWR/dn
         IhljM1ItzoydJs5ao4S1mTCZ7s+gfiMgil1ViPnShV6stP0PH7QJBHHaKatW8sJcx0wz
         u0NvJkbimko9Onpbq3gHaKn863Ymdx5cM9MeIfPQ4d7sEby86nkv+ILpbiaNaR5znvcq
         qbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Yk9NlOmGKofkdfMA6+3ywtQqOEAPVMOAz3hdr7uXvE=;
        b=YLLGLOlSW5gaPMsYfbylJRqL28M5o7Go6dZz/GN5sMX6KL+0TrMhfj8V2/L73b3ph2
         R3NtVvMzrUXZSjc1nCI5RiZTJfGWeipY/BaCwNbFglofoMyJTFdcyNbTpwz8pr878Cmi
         PplXKzHuHksizsjPQFkHNe0bIy1Pixj9ZPxviDGq5/YbDYblKYFVtGle3FS/GzhEt8Hl
         f1nYNLEayP4k+Hlo7SoNwPeP3IhGqsTcFBFS3nD4DGgrDRzsme6yqTatgduisw2RtGDo
         poD/wCuAZTF9K8vt4QtYfeBvitw5NGDn1vE3KIPRGwldcCM69Fweny171w6uku5DVW+K
         EO+g==
X-Gm-Message-State: AOAM530xEezcinJ1/jkQ8264GdoxX/1EvefB5WWhqzSdbTOLar/4Obrr
        QN4FTF9ALleCPej17wxfEehSPh67k3chDw9lNVcI2w==
X-Google-Smtp-Source: ABdhPJz3XLagVW8QroqFjxvACNVUH9zZ8ltjPZndhuIyfpInOl3OzeWY/yBVOo6wjOyV8x+RouyyGoOtWVCwXW8GueI=
X-Received: by 2002:ab0:b14:: with SMTP id b20mr6273790uak.52.1616714291094;
 Thu, 25 Mar 2021 16:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com> <20210324071357.GB2639075@infradead.org>
 <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com> <20210325101655.GB36570@C02TD0UTHF1T.local>
In-Reply-To: <20210325101655.GB36570@C02TD0UTHF1T.local>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 25 Mar 2021 16:17:59 -0700
Message-ID: <CABCJKuf+TxeDsy9B9DM2g-U7uwNu-yxSjARfPe_oeCY2fySvTA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function macros
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 25, 2021 at 3:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Mar 24, 2021 at 08:54:18AM -0700, Sami Tolvanen wrote:
> > On Wed, Mar 24, 2021 at 12:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> > > > With CONFIG_CFI_CLANG, the compiler replaces function addresses
> > > > in instrumented C code with jump table addresses. This means that
> > > > __pa_symbol(function) returns the physical address of the jump table
> > > > entry instead of the actual function, which may not work as the jump
> > > > table code will immediately jump to a virtual address that may not be
> > > > mapped.
> > > >
> > > > To avoid this address space confusion, this change adds generic
> > > > definitions for __va_function and __pa_function, which architectures
> > > > that support CFI can override. The typical implementation of the
> > > > __va_function macro would use inline assembly to take the function
> > > > address, which avoids compiler instrumentation.
> > >
> > > I think these helper are sensible, but shouldn't they have somewhat
> > > less arcane names and proper documentation?
> >
> > Good point, I'll add comments in the next version. I thought
> > __pa_function would be a fairly straightforward replacement for
> > __pa_symbol, but I'm fine with renaming these. Any suggestions for
> > less arcane names?
>
> I think dropping 'nocfi' into the name would be clear enough. I think
> that given the usual fun with {symbol,module,virt}->phys conversions
> it's not worth having the __pa_* form, and we can leave the phys
> conversion to the caller that knows where the function lives.
>
> How about we just add `function_nocfi()` ?
>
> Callers can then do `__pa_symbol(function_nocfi(foo))` and similar.

Sounds reasonable. I'll drop __pa_function() and rename
__va_function() to function_nocfi() in the next version.

Sami
