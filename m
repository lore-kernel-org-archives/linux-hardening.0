Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B19C54EBE
	for <linux-hardening@archiver.kernel.org>; Tue, 10 Jan 2023 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjAJUi1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 10 Jan 2023 15:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjAJUiZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 10 Jan 2023 15:38:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF248808
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jan 2023 12:38:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso13058373pjl.2
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jan 2023 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=adAxM/tdxethfCc9kWsVP4uZeaLxTRj54+QnNFBkUNY=;
        b=q6L5OgUTT+UTRnL01un1afM9agRNUadY7z3gcTMkTail3+Qhky05OYeoYhqXQYg/2V
         oNM0bJF76X8c1a11DiRZwcxUUHYL3WCdBjquE+qsCek2XUUM0gXKs5jgYWAsvJKFOq3s
         2lnuRusHfIRnNbb9jdGjYhKOTOw50LK1/BLu87Zi/Mpo+hASVtgSMMzyjjmxYUTFskob
         p27WyREJ+flNoKcGO2HMB4eNUNOHlrLrKCJ+wJHvQBcRyydwzjIxEbXRXn1ARZZEyQGa
         CjT+HPcFde0Kq8RXE0OBr1Oysi/okt8jgq4il6jxujPqUwEvyhWt1lPGGK2sbFlYhhn8
         ZxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adAxM/tdxethfCc9kWsVP4uZeaLxTRj54+QnNFBkUNY=;
        b=7KRx/+5eDssfXzbu0wMoo5biArC2morEee3LVdRg8eVaPeAfIQhEjfg0H6nySuwLvP
         Fj7lGgTaQiEVspdpDcgp2mb6lsgPJiWKLVbW3HyNMyrG5WYV2gAzhj7yh9WIBUyYDcrY
         HnTDvpGInLYRD10jQuEd7qiqyCLf6FXZf7T5smmoZNQ0yHev3E7oLww1odTLT55WXdKh
         4esW219+XDNGj10e2GaXI51G7uWLs6wko5+wdXV1K7CyrKZI1IdL/QHceV3EXEIigyZt
         E27IV8j4xxotbA+b+LvxQQ8/MoM5h/yjXr4zyHGRBPTmtWujAQptxGKD+GUc1MvWPeqj
         FFMQ==
X-Gm-Message-State: AFqh2kpvhPIB3oriw1IqWdQzDlgw8GfM+v8J/ovt0c7tub4vwDh9AvfK
        a9JTZ8sN2QQOo2/3SVOnmu9aoX42kY8j/yR93Ta9SA==
X-Google-Smtp-Source: AMrXdXsEsCNJ48Atas4Y6eD6ioPdCdz81nx9K6hMDwJwBy/FjZKLO3qICbX1P4jlmpWAughD783FHgYsDQpRu2d1nFw=
X-Received: by 2002:a17:90b:4b4c:b0:219:6be1:7ff2 with SMTP id
 mi12-20020a17090b4b4c00b002196be17ff2mr6404270pjb.79.1673383103232; Tue, 10
 Jan 2023 12:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20230107040203.never.112-kees@kernel.org> <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
 <ae952aa5-f113-8786-6fe4-60e5fa0ced2b@suse.cz>
In-Reply-To: <ae952aa5-f113-8786-6fe4-60e5fa0ced2b@suse.cz>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 10 Jan 2023 12:38:11 -0800
Message-ID: <CAGS_qxrOVhXQaxqKknS2CJpHeCWHaMshvdJNdzeN6+KxQmY_uA@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 9, 2023 at 11:51 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> +Cc rest of kunit from MAINTAINERS
>
> On 1/7/23 11:55, Geert Uytterhoeven wrote:
> > Hi Kees,
> >
> > On Sat, Jan 7, 2023 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
> >> Since the long memcpy tests may stall a system for tens of seconds
> >> in virtualized architecture environments, split those tests off under
> >> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.

<snip>

> >>
> >> -static void init_large(struct kunit *test)
> >> +static int init_large(struct kunit *test)
> >>  {
> >> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> >> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> >
> > So I can't make the slower tests available for when I need them,
> > but not run them by default?
>
> Indeed it seems weird to tie this to a config option without runtime override.
>
> > I guess that's why you made MEMCPY_SLOW_KUNIT_TEST tristate originally,
> > to have a separate module with the slow tests?
>
> On the other hand I can imagine requiring a separate module for slow tests
> would lead to more churn - IIUC there would need to be two files instead of
> memcpy_kunit.c, possibly a duplicated boilerplate code (or another shared .c
> file).
>
> So the idea is to have a generic way to mark some tests as slow and a way to
> opt-in/opt-out for those when running the tests. Maybe KUnit folks already
> have such mechanism or have an idea how to implement that.

There is no mechanism atm, and we'd still need to figure it out so
it'll be a while.
So I think a patch like this makes sense in the short-term.

This is definitely something we've always thought would be useful eventually.
See this TODO which has been there since day 1 ;)
https://elixir.bootlin.com/linux/latest/source/lib/kunit/try-catch.c#L36

It just felt like it would be premature to come up with something when
basically all the tests up until now ran ~instantly.

Throwing out some rough implementation ideas:
I was thinking the granularity for these timeout annotations would be
at the suite-level.
If we go with that, then I guess the intended flow is to group slow
tests into their own suite and mark them as such.

Then maybe we'd have some runtime way of disabling/enabling "long"
tests, like a cmdline opt.
E.g. you'd pass `kunit.max_test_size=30` to exclude tests longer than
30 seconds.

Daniel
