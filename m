Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E933C433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 02:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511F564F53
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCECtt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhCECtt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 21:49:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4151C06175F
        for <linux-hardening@vger.kernel.org>; Thu,  4 Mar 2021 18:49:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u4so916005ljh.6
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 18:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAKwe7K3kMQANtJjPdLsYeGF7HM5Z9arIs0zPPnm5iE=;
        b=EvEdNgOWOy1LcQaL2gw46k9qbKeV/7H2LcXkYbpwNwDp8xdsQIVuHdbSydTS19raO1
         DwZeef2Mp8pIepnzktZQ9OqZQTngM5gKi0piP0D6+XmFoq8bRqaTenltpLrA78EXLNBZ
         IxakX67rKVQI+ezgtRyBETC7bIYS+8LOU6qU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAKwe7K3kMQANtJjPdLsYeGF7HM5Z9arIs0zPPnm5iE=;
        b=CB+T7FfD0KfDu3fEy/w9ayuUZlDmy3qNonHT0niMaMIW31V83qlr7NjuIUhIJEbTcA
         IYYEEkag0DgS5do0//FJraDEtlVmAMl1ZpmtGOaymOhhWsl0zWd3H2wPcwV+fVWEgWHX
         65ROWu0sS7k5s1RBLayusUV4yd/gtKuvDTdJbNqolCfUaqefXcSExOwDfOAG1JFhjBG8
         fMnICGqJ8T0+y7K/dQe5Vy9UL1zZy8U1u7Epn90V+4gdCkIHZ3/3/80SiVuACX+34acZ
         RxRPMc/bpfH4lv8UaEN+0fra3hpQexrlgMS5yxOCbtSppB5rR41lwM2byorunxe+mCcW
         IXgw==
X-Gm-Message-State: AOAM531JUsfpHsMLMryfDFpmAfy8te+4+M/rAue4bNNmJ1poP4Wq0sMX
        il0o0EGm7EijSg/TY2UUY9yUoX1KtO80Xw==
X-Google-Smtp-Source: ABdhPJx8e+9/3gnRgZOijtJOrYiVb/52N5AR5c0zRzRgC3lpfLhSnvg4aj1HKztEuSKizpJCf3317Q==
X-Received: by 2002:a05:651c:8e:: with SMTP id 14mr3973935ljq.322.1614912585304;
        Thu, 04 Mar 2021 18:49:45 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y186sm127263lfc.304.2021.03.04.18.49.43
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 18:49:44 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id f1so1120502lfu.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 18:49:43 -0800 (PST)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr89476lfb.421.1614912583650;
 Thu, 04 Mar 2021 18:49:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
 <20210303193806.oovupl4ubtkkyiih@treble> <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
 <20210303202406.bxgdx5a25j6wc43b@treble> <CAHk-=wi9J3mM8y+aH9e=HRo95giK4BRyyasayAimB0gdvbvDsQ@mail.gmail.com>
 <20210303214534.guyoxcwrgxgcqzy4@treble> <CAK7LNAQaAgg+mVSw_U3_FuuqcqJNnonyhVD1M-ezv71Y+dyAww@mail.gmail.com>
 <20210304150812.rzya7ewmerwhe4m4@treble> <CAK7LNAR0kNJ=DLuvRzRG+-rgMfcrSOZu8Mn6JBJ5do7TzJWLcA@mail.gmail.com>
 <CAHk-=wiT3FGuKuqLniBN2T_PZwD0GH4kf3XNCzq2tfChqn0+SQ@mail.gmail.com> <20210305024140.fv4i4ujreem2w7sw@treble>
In-Reply-To: <20210305024140.fv4i4ujreem2w7sw@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 18:49:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whT4g=a-YzF9qXPTd5d1DN98x_9N8RWLdeiwg7gMTky+A@mail.gmail.com>
Message-ID: <CAHk-=whT4g=a-YzF9qXPTd5d1DN98x_9N8RWLdeiwg7gMTky+A@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 4, 2021 at 6:41 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> This thread is making me dizzy, but I think the patch you NAK'ed from me
> was different.  It just added an error on GCC mismatch with external
> modules:
>
>   https://lkml.kernel.org/r/fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com
>
> though I think you were ok with downgrading it to a warning.

Right you are. So that was about the external module thing, which is
obviously incidentally an issue here with the plugin behavior too, but
different.

My inbox is kind of a modern-day Colossal Cave adventure: "You are in
a maze of twisty email threads, all similar but with different hidden
details".

               Linus
