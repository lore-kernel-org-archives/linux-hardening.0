Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4AFC4332B
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BDA20724
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 19:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbhAZFvy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:51:54 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:23744 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbhAZBzI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Jan 2021 20:55:08 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 10Q1s0YE007298;
        Tue, 26 Jan 2021 10:54:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 10Q1s0YE007298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611626040;
        bh=oagMBAQOcxiRZ10Xc720/BqDn/zB60BP15C0zBwRb4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zI91evfU1dQERp5iU3LtP62wJx77tUr8nmioJzfKCIUdXRqdNGY50QKTCfHsXDczC
         TLHadaES9+8s70Z0DNoxPGz9jadiJZaOwZNh9GyPPKS1GpBKQH52m4WtdOta1EYkNS
         xkgJT3MwbzyJz28JMiLxavtq5Ui2SI9gMfZUK20ox55+HQ2tI2dDeGAnyovQvNHyzQ
         gPeuJxmoE0CMK9wplQfJlTmC7VDnsWHie7kJuJyl6A0yaPb2gG9Ptp5pnhfMHG3mCY
         evGg1fma2gtyWqFdxLUs11ySnYLw0heiBoezBfZtrWRZJ/67pc6dTdx3dM8Ia+U1Pf
         rD5WSVxjOXnmA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id gx1so873911pjb.1;
        Mon, 25 Jan 2021 17:54:00 -0800 (PST)
X-Gm-Message-State: AOAM532h1dvsVcTA77q1OLt8DJK7e/lG0YiRxWL0xeq8RHxoPai0g854
        wqn0EJuaDhF1ghU7CM6JupEEwhtBF1woeeY8fiY=
X-Google-Smtp-Source: ABdhPJwJ9KkvPgY3Ko2Vqz35MecJG3zqwoeNOStkvrhv8bzGg2t1HOBt5xq4IYHIoiGkCQq+U+0aGZ43TJHANLrpCg0=
X-Received: by 2002:a17:90a:5403:: with SMTP id z3mr3328264pjh.198.1611626039493;
 Mon, 25 Jan 2021 17:53:59 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <202101251401.F18409FDD1@keescook>
In-Reply-To: <202101251401.F18409FDD1@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jan 2021 10:53:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOf=B_j5o=L=BL+vz_JK_d3QYUuHg8h+3SP6qOyYD86A@mail.gmail.com>
Message-ID: <CAK7LNASOf=B_j5o=L=BL+vz_JK_d3QYUuHg8h+3SP6qOyYD86A@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 26, 2021 at 7:03 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> > When a GCC version mismatch is detected, print a warning and disable the
> > plugin.  The only exception is the RANDSTRUCT plugin which needs all
> > code to see the same struct layouts.  In that case print an error.
>
> I prefer this patch as-is: only randstruct needs a hard failure. The
> others likely work (in fact, randstruct likely works too).
>
> Masahiro, are you suggesting to be a hard-failure for all plugins?

Yes.

I want to require
"I swear to use the same compiler version for external modules"
when you enable GCC plugins.




config CC_VERSION_CHECK_FOR_EXTERNAL_MODULES
        bool "Check the compiler version before building external modules"
        help
           If this option is enabled, the compiler version is checked
           before building external modules. This ensures the same
           compiler is used for the kernel and external modules.


config GCC_PLUGINS
        ...
        depends on CC_VERSION_CHECK_FOR_EXTERNAL_MODULES



In Makefile, check the version for out-of-tree modules
if CONFIG_CC_VERSION_CHECK_FOR_EXTERNAL_MODULES.




There is no difference in the fact that
you cannot use a different compiler for external modules
if CONFIG_GCC_PLUGINS=y.




We started with the assumption that modules must be compiled
by the same compiler as the kernel was.
https://lore.kernel.org/patchwork/patch/836247/#1031547

Now that the compiler capability is evaluated in Kconfig,
this is a harder requirement.

In reality, a different compiler might be used,
and, this requirement might be loosened, but
the same compiler should be required for CONFIG_GCC_PLUGINS.




-- 
Best Regards
Masahiro Yamada
