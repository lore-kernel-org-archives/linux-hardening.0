Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9AC433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B3C64DA1
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhA1U0W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhA1UZq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Jan 2021 15:25:46 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADDAC06174A
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 12:25:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t8so7905046ljk.10
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tACUR/LflNb3xiypGIJAOB6qg90kRzu1Bn+isppjuU=;
        b=Z0wOnR+xWLEEYZyJtmF4cIaKTBfBVVe1eeYhMK7xw537F0yzoHCspxlEXjdVuTdK0G
         joZeBK9AflS4N3Vv3DI2P9WSeG9IFXDCJSlQ2a0zsffUznIcHhMevwVEhYdoBUBL29S2
         wnPDvU9qQiBA4rJIkIBFyJ9BVUzB/oe2EmzfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tACUR/LflNb3xiypGIJAOB6qg90kRzu1Bn+isppjuU=;
        b=h5M1oqncEAAAS26gLlGutx/PBRh1DKXYJGf+NsmBIkJd+bqPwCJ2mgYcCPumgdOY8S
         pkguQVjp5PqJ9iRWnROJdYvjjdg4fCh680oqdfOY9Q7n6lPBhr1wvXvgowmum2SNsSCV
         0vJbZtxiZ7iBbgxH+xhjXTilr22iKjntsG90ObPpXD/bM73ghUl6UJV9NHqofhKtgQsH
         UwnwLr1Kw4PahRQnAeoRYDHzqZ/lywIM8oO//fNygIvb1Wyj5SoVmmqdaAmGjS2PaAZt
         y3j3FFEcZs9FYacvriCf0FWRqQuVv46eYIjHgpAijDPMUwxdrTOBJF3pAnlibD0nFWbe
         vuCw==
X-Gm-Message-State: AOAM5324QVUnEjuHWrYuQp4VX/FX8fKdHM8ZzuURfpRKQGZ8qfkWL3im
        lzfjfumDhuQNUFBKlwExo6At31tVZorjDw==
X-Google-Smtp-Source: ABdhPJwOPWd66/SRgRH7OK3i8wk8A3oeHNd3XLoXOJnGEa9dnq9c2qkKvRdXQ6BaeC1MjZrlZjFydA==
X-Received: by 2002:a2e:bc0c:: with SMTP id b12mr544554ljf.201.1611865504097;
        Thu, 28 Jan 2021 12:25:04 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x24sm1785879lfu.206.2021.01.28.12.25.02
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 12:25:03 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id v24so9343430lfr.7
        for <linux-hardening@vger.kernel.org>; Thu, 28 Jan 2021 12:25:02 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr379911lfu.40.1611865502453;
 Thu, 28 Jan 2021 12:25:02 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
In-Reply-To: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 12:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
Message-ID: <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 28, 2021 at 12:08 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Add a check for compiler mismatch, but only check the major version.

I think this is wrong for multiple reasons.

The most fundamental reason is that it's pointless and doesn't
actually do what you claim it does.

Just doing a "make oldconfig" will reset the CONFIG_xyz_VERSION to
whatever is installed, and now your check doesn't actually do
anything, since you're not actually checking what the kernel was
compiled with!

So I think that check is pointless and entirely misleading. It doesn't
do what you want it to do, and what you claim it does.

I'm not convinced about the whole magic vs minor argument either. The
whole "new compiler features" thing is a red herring - even if you do
have new compiler features, that in itself has very little to do with
whether the resulting object files are compatible or not.

So I say NAK, on the basis that the patch is nonsensical, tests the
wrong thing, and doesn't really have a technical reason for it.

             Linus
