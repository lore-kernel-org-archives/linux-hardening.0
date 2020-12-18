Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA6C3526B
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Dec 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF6323B7F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Dec 2020 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLRRzr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgLRRzq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Dec 2020 12:55:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E2C0617A7
        for <linux-hardening@vger.kernel.org>; Fri, 18 Dec 2020 09:55:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m12so7547187lfo.7
        for <linux-hardening@vger.kernel.org>; Fri, 18 Dec 2020 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b10g2p9lft/UmhtwJiz67G2XWjBhcNCBTJqBJz2XXw0=;
        b=DFvI9G2QV3GE6hgNxpKnSdceMlfY8WGRpcxo+yQ4bfAwz8eIGMGMHsoj9gAEDOrQv6
         TR4eRr4EBep4U+bfNin6wuLs2YX0MMYGnkBgaf8mc+rWarMYW/hA0MQ4J0x08fQM1TSY
         TPdckUkPTHZxUwHmFBA6zpCqxeqf5+bvxnLLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b10g2p9lft/UmhtwJiz67G2XWjBhcNCBTJqBJz2XXw0=;
        b=mQEBNF7MJpeRjdMMYfvqQqZ8gXEmwfzpcgPw+tk/+XLcHsTDsGDt6M55DEE4Bk2s3D
         TAtKijkCJWQS4Ng1fgKVn9VsQeLXn/JNQhpnrD5ZydyjTDChQVfjU2DNHprKlArqol3O
         BmX9hwg9l3Y3Esir0N8kuE0354QUyqyo175YEY/6/v1NMy59IktCazVGgcA7gSxYBAeR
         EbssxTGWLzL0YWrzUVNaQoUJ8fk2QLTUfULDstEzyLrIYKgiOu1tmUMNJg3CiX8EavUQ
         l63Tx4X4p3fe+XLmkNp+8vki0ud6fRcoKwwFX/58cD9zbJfkyl7HlTCLGMkF9GtyvrhF
         Caxw==
X-Gm-Message-State: AOAM530kgtRQ2KFsu337sx84Lgp7C2HkL+gbSNZOkO6tEIzGdPbcbvTe
        B0C1FD6ctXmk48XFYXDOF29glvZhWkC+5Q==
X-Google-Smtp-Source: ABdhPJyWVxLTxzCY6LaAYlJg7SlT2iG+cXydV0qqFzFAI6SbX9VjpBrfvRwc4i8jxt07oQLGGHksvg==
X-Received: by 2002:a2e:a364:: with SMTP id i4mr2227465ljn.426.1608314104141;
        Fri, 18 Dec 2020 09:55:04 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 14sm1000416lfq.221.2020.12.18.09.55.02
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 09:55:02 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m12so7546880lfo.7
        for <linux-hardening@vger.kernel.org>; Fri, 18 Dec 2020 09:55:02 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr2380283ljj.220.1608314101731;
 Fri, 18 Dec 2020 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201218075758eucas1p1605768803a5c9edce4fbe54b3e3b859a@eucas1p1.samsung.com>
 <20201203125700.161354-1-masahiroy@kernel.org> <b9b17126-9af5-2f73-526e-91bb9fd27f71@samsung.com>
 <CAK7LNART2qQBY7Vc8rhMiXS_Fwty7qpWjwwfPrUegTb-gjy6sA@mail.gmail.com>
 <9f959875-1a30-b1a1-b626-3805e24a6df3@samsung.com> <e5b06d9a-9b24-2440-e0c2-8bf7095eccd9@nvidia.com>
 <25030057-86b1-5619-25fd-acfa0728b850@samsung.com> <4ab4f62f-8b37-01e1-f81c-270155b13a51@nvidia.com>
 <7e691a61-bf4b-0594-8d6d-36d62a5def0b@nvidia.com>
In-Reply-To: <7e691a61-bf4b-0594-8d6d-36d62a5def0b@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 09:54:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com>
Message-ID: <CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 18, 2020 at 7:33 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> However, if you are saying that this is a problem/bug with our builders,
> then of course we will have to get this fixed.

This seems to be a package dependency problem with the gcc plugins -
they clearly want libgmp, but apparently the package hasn't specified
that dependency.

If this turns out to be a big problem, I guess we can't simplify the
plugin check after all.

We historically just disabled gcc-plugins if that header didn't build,
which obviously meant that it "worked" for people, but it also means
that clearly the coverage can't have been as good as it could/should
be.

So if it's as simple as just installing the GNU multiprecision
libraries ("gmp-devel" on most rpm-based systems, "libgmp-dev" on most
debian systems), then I think that's the right thing to do. You'll get
a working build again, and equally importantly, your build servers
will actually do a better job of covering the different build options.

                     Linus
