Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6861C433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9447A23109
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 12:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbhAZMqo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391668AbhAZMq0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Jan 2021 07:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611665098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNJERmT7Vuz6QxflZTnA+auIcqBlbQ/3RdflYOHk/Tk=;
        b=ITlDy8fEY8yrxCCmqQq5zel1zkmrbCy8mlKTSWoyJ26O/DQp40o2f5uVNV+iUp0A7H733H
        GBkVmZSE4JjqzqbBPN3uhtcxQiKrENcbYPPSV58erinhwymwAeKHWUhDl42BZEnvOf9uwU
        epwNoU3ndf2ruv53QCnkHrgWBbBoWWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ouzJ84xqNai4UVWoCtjABQ-1; Tue, 26 Jan 2021 07:44:56 -0500
X-MC-Unique: ouzJ84xqNai4UVWoCtjABQ-1
Received: by mail-wr1-f71.google.com with SMTP id z9so4290206wro.11
        for <linux-hardening@vger.kernel.org>; Tue, 26 Jan 2021 04:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNJERmT7Vuz6QxflZTnA+auIcqBlbQ/3RdflYOHk/Tk=;
        b=Rg3bxyQbl9DwxDph5r9i40LSd/e3ghVGetmXgTLpqeDnOHJ+sQhvBziybB6Xj87Q2Z
         upebCH6S5fwdyjMqStkDJtoJzc6ALeh5V5ACE1yxrdQO0H4PZKldwthdKuRUIl9W0+RE
         LOPentHJYWZo3rDWJEB3skUEiX1yRqYE5Hv+f5GDBlC4nRBwau3sqKu8HMtw+mTi782c
         ElDu5iLMT3YuHyXMJdotDOZQ2uMdBAEioW4Yif06vHCSNvMaF++RwrjMqtp+RL5+v1ed
         G8xqdJPXdjPbHoWdyRupboBsxHQtx3tFOBe+/7QeMW9Rb7oGwMFJGC/3Ik6V5XoPUKu7
         75VA==
X-Gm-Message-State: AOAM531asTQ+zFkGORW6T3ZuxCngbeDaUDZvWEkhasFNznkwVr+2QNEl
        A04gv910d4biytEpS3ATE9EZCfARiYyUuWa4YcAB2p0V/eN7fS6ClTbRhm/miQi5UK/DL+Ac6OO
        3+WuDe2Utgc5hwmIAQ6H6UvmaszVz44i746I39JeGGyHx
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr6052884wrd.33.1611665095173;
        Tue, 26 Jan 2021 04:44:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwidMAkaJwMIbKsfh4oZmDF/v+rGyEjI2VgDeYGU4BuvgYrjHrnFErK1GdiavCeAFABamnHBsxDCBqo39sR5jg=
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr6052870wrd.33.1611665095013;
 Tue, 26 Jan 2021 04:44:55 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <CAK7LNAS=uOi=8xJU=NiKnXQW2iCazbErg_TX0gL9oayBiDffiA@mail.gmail.com>
 <20210125212755.jfwlqogpcarmxdgt@treble> <CAK7LNAS+EG9doX3qUmu4M3=mRNmdybSv4180Xnuubiwmsq0Agw@mail.gmail.com>
 <20210125220757.vxdsf6sttpy46cq7@treble> <YA/PLdX5m9f4v+Yl@kroah.com>
In-Reply-To: <YA/PLdX5m9f4v+Yl@kroah.com>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Tue, 26 Jan 2021 06:44:44 -0600
Message-ID: <CAFbkSA0m1pqmXh29j6wJ9fG05yC72T1kNC0QU3rF7Oh2NoMwYQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Greg KH <greg@kroah.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jforbes@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 26, 2021 at 2:21 AM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jan 25, 2021 at 04:07:57PM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 06:44:35AM +0900, Masahiro Yamada wrote:
> > > > > If people use a different compiler, they must be
> > > > > prepared for any possible problem.
> > > > >
> > > > > Using different compiler flags for in-tree and out-of-tree
> > > > > is even more dangerous.
> > > > >
> > > > > For example, CONFIG_GCC_PLUGIN_RANDSTRUCT is enabled
> > > > > for in-tree build, and then disabled for out-of-tree modules,
> > > > > the struct layout will mismatch, won't it?
> > > >
> > > > If you read the patch you'll notice that it handles that case, when it's
> > > > caused by GCC mismatch.
> > > >
> > > > However, as alluded to in the [1] footnote, it doesn't handle the case
> > > > where the OOT build system doesn't have gcc-plugin-devel installed.
> > > > Then CONFIG_GCC_PLUGIN_RANDSTRUCT gets silently disabled and the build
> > > > succeeds!  That happens even without a GCC mismatch.
> > >
> > >
> > > Ah, sorry.
> > >
> > > I responded too early before reading the patch fully.
> > >
> > > But, I do not like to make RANDSTRUCT a special case.
> > >
> > > I'd rather want to stop building for any plugin.
> >
> > Other than RANDSTRUCT there doesn't seem to be any problem with
> > disabling them (and printing a warning) in the OOT build.  Why not give
> > users that option?  It's harmless, and will make distro's (and their
> > users') lives easier.
> >
> > Either GCC mismatch is ok, or it's not.  Let's not half-enforce it.
>
> As I said earlier, it's not ok, we can not support it at all.
>

Support and enforce are 2 completely different things.  To shed a bit
more light on this, the real issue that prompted this was breaking CI
systems.  As we enabled gcc plugins in Fedora, and the toolchain folks
went through 3 different snapshots of gcc 11 in a week. Any CI process
that built an out of tree module failed. I don't think this is nearly
as much of a concern for stable distros, as it is for CI in
development cycles.

Justin

