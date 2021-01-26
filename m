Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE8C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 10:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0334E2064B
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 10:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313281AbhAZXBp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 18:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393395AbhAZRs5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Jan 2021 12:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611683250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLtZhIl7orO56MT5FcvC4puD6EhsLgMtbBTl1Sh9rT4=;
        b=J+Ro/2b4rNQNkjoHcsPA7deImjss+3X9XfSrzvHNmEyIYePpYD1uPya/3CJ/EbAjDdEdok
        Ib/chyPsmj86HhbBZ5L2xIxV+n8p0sTfltSMTEEGgijPEtuzeQsh8w8S8mTkMPvTvf64W0
        3s6LollnY7QR5GCt+4i2FkCmeuhh6rk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-lbm2hKtvMSinQ6prG5XRQg-1; Tue, 26 Jan 2021 12:47:26 -0500
X-MC-Unique: lbm2hKtvMSinQ6prG5XRQg-1
Received: by mail-wr1-f70.google.com with SMTP id v7so11538636wra.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Jan 2021 09:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLtZhIl7orO56MT5FcvC4puD6EhsLgMtbBTl1Sh9rT4=;
        b=e9TfvApTPbFk5ppP7knO8I6sSnT2O6AYBhzkwYVJToWtkXTEIDyHb/xmoWQtCWvytZ
         2lN8/pFcAeSXbgevkVylTOxhWqbUoz6waj2s2pSB35cEe9/IQYTteD+yniyrX2wlHbzx
         dDbt1cd4dQ53ml5/+iiQ1UoW26jlOWLmYXJz7CUuf4Irplm6nodkiZTr2/EdMFMWOR5J
         i1+EeVNjPbwGt+5ZXe4SOyMjiwpLic+Xhri6YAuC5pNXJe/Rf8bSdir4wpOz7JBCTHgp
         t+CC2VCbzDS4OVovMPmnZZAtJ0+w7BTICu0ZRUYh0Pgpv7+34pymG9Pyopgfp5jQ5j5K
         4Jbg==
X-Gm-Message-State: AOAM5327SZ1g6/i9/e2iNbfVVyezUlGcwURCf9mOjlufqYOUqCgF2ydL
        QXxRwyD/mf3N86xnBdQkq/M59/H18XghDmDQ2l9duds00dwxn+8hqmXJpyPPuQObVU+b4esARGu
        YZA7SQcf0kVY0EadZSHbP0X0rixEwC/FL2XL4V6OjiM1i
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr7484833wrd.33.1611683245139;
        Tue, 26 Jan 2021 09:47:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhd+iinKcflKNYA9Dx5KommJVvFrT+60OnG5/sGYPVn+fLyB1sTBsc/zurV6mdURylsrCX/29OYiu+hF8Lt+8=
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr7484806wrd.33.1611683244863;
 Tue, 26 Jan 2021 09:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125220757.vxdsf6sttpy46cq7@treble> <YA/PLdX5m9f4v+Yl@kroah.com>
 <CAFbkSA0m1pqmXh29j6wJ9fG05yC72T1kNC0QU3rF7Oh2NoMwYQ@mail.gmail.com>
 <YBAeYaDReAc9VscA@kroah.com> <20210126145155.kcfbnzfqg5qugvcl@treble>
 <YBAyGU7H8E98xKng@hirez.programming.kicks-ass.net> <20210126154651.itfrnhwfistia3ss@treble>
 <YBA9r13+1uuyDYuR@hirez.programming.kicks-ass.net> <CAFbkSA1CibJ6sp+LPLy3hpchLLH2B5__Lk31TLeVThXi5eZV7Q@mail.gmail.com>
 <20210126161934.z6sng4irl5teonvj@treble> <YBBML2eB/IXcTvcn@kroah.com>
In-Reply-To: <YBBML2eB/IXcTvcn@kroah.com>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Tue, 26 Jan 2021 11:47:13 -0600
Message-ID: <CAFbkSA2do8hyh8hwyA5f+GTstcv561UePu-msxPuKXN3+No_Rg@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Greg KH <greg@kroah.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jforbes@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 26, 2021 at 11:07 AM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jan 26, 2021 at 10:19:34AM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 10:15:52AM -0600, Justin Forbes wrote:
> > > On Tue, Jan 26, 2021 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Jan 26, 2021 at 09:46:51AM -0600, Josh Poimboeuf wrote:
> > > > > On Tue, Jan 26, 2021 at 04:15:37PM +0100, Peter Zijlstra wrote:
> > > > > > On Tue, Jan 26, 2021 at 08:51:55AM -0600, Josh Poimboeuf wrote:
> > > > > > > User space mixes compiler versions all the time.  The C ABI is stable.
> > > > > > >
> > > > > > > What specifically is the harder issue you're referring to?
> > > > > >
> > > > > > I don't think the C ABI captures nearly enough. Imagine trying to mix a
> > > > > > compiler with and without asm-goto support (ok, we fail to build without
> > > > > > by now, but just imagine).
> > > > > >
> > > > > > No C ABI violated, but having that GCC extention vs not having it
> > > > > > radically changes the kernel ABI.
> > > > > >
> > > > > > I think I'm with Greg here, just don't do it.
> > > > >
> > > > > Ok, thank you for an actual example.  asm goto is a good one.
> > > > >
> > > > > But it's not a cut-and-dry issue.  Otherwise how could modversions
> > > > > possibly work?
> > > > >
> > > > > So yes, we should enforce GCC versions, but I still haven't seen a
> > > > > reason it should be more than just "same compiler and *major* version".
> > > >
> > > > Why bother? rebuilding the kernel and all modules is a matter of 10
> > > > minutes at most on a decently beefy build box.
> > > >
> > > > What actual problem are we trying to solve here?
> > >
> > > This is true for those of us used to working with source and building
> > > by hand. For users who want everything packaged, rebuilding a kernel
> > > package for install is considerably longer, and for distros providing
> > > builds for multiple arches, we are looking at a couple of hours at
> > > best.  From a Fedora standpoint, I am perfectly fine with it failing
> > > if someone tries to build a module on gcc10 when the kernel was built
> > > with gcc11.  It's tedious when the kernel was built with gcc11
> > > yesterday, and a new gcc11 build today means that kernel needs to be
> > > rebuilt.
> >
> > Right.  It's a problem for distro users.  The compiler and kernel are in
> > separate packages, with separate release cadences.  The latest compiler
> > version may not exactly match what was used to build the latest kernel.
>
> Given that distros _should_ be updating their kernel faster than the
> compiler updates, what's the real issue here?  You build a kernel, and
> all external modules, at the same time.  If you want to build them at
> different times, you make your build system ensure they were the same
> compiler so that you are "bug compatible".
>
> And yes, it might be a pain if gcc11 gets updated every other day, but
> as someone living with a "rolling-distro" you get used to it, otherwise
> you just "pin" the build tools and keep that from happening.
>
> This isn't a new thing, we've been doing this for decades, why is this
> surprising?

We definitely build considerably more kernels than toolchains. From a
rawhide standpoint though, a number of testers are willing to test RC
releases, but are not willing to run debug kernels, so they installed
rc4 yesterday, but will not install today's snapshot.  I will build
3-5 new kernels before they update to rc5.  We have been doing things
this way for over a decade. It has never been a problem until we
turned on CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.  Suddenly I am
getting complaints.

