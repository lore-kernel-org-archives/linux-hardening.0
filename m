Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB751C433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DD02067C
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 16:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbhAZQRe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391123AbhAZQRc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Jan 2021 11:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611677766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPH6A9X8PrEZD2nbv28DbEJKiNaS6b1xe01NHgW9Weg=;
        b=L6AtRDLMOL+WFJwtEbew0O69CaYxo4PgwhZbDCvMy90vrkz4RyGvkiZ8aY+yUEtFqrd/ck
        mDOByYwHvp8vTxigLXV43+/BFyjyp7Ppk0N4vEU1eYEBrUduMaVwGDH4d1KV2FgTGuU1K0
        9N+IKMrODqQ6+Um2Mi0I4kNmpl+20DM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-HwI0TrwJMu2A-w4j79DjqA-1; Tue, 26 Jan 2021 11:16:04 -0500
X-MC-Unique: HwI0TrwJMu2A-w4j79DjqA-1
Received: by mail-wr1-f71.google.com with SMTP id l13so11354857wrq.7
        for <linux-hardening@vger.kernel.org>; Tue, 26 Jan 2021 08:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPH6A9X8PrEZD2nbv28DbEJKiNaS6b1xe01NHgW9Weg=;
        b=LA0Vsz+wS94M/goyQ1eDpyaALLLkKWDhLvSvtIRJFEjb+FJjsMQAL4t+Dtah0RH8FX
         LzW9gO8WNhfJkhDkoywuFhZo3IWNrkL6srurBx81cQIxmbs2IUjcvQciJ/12jpnBHWTI
         K+jzI+ye76Yy+zNaOfAlBFjMwwz2iOqX1JPdcWlcmi8QfbtmSMezIC3rAjAwddng7nvb
         Rwt/Ec2U3Omilej+1yG7K2F4DKxmbuxojySb++zbDB4cespAiYjAfZxSJNRQtxtaDpH/
         lU7yngRECuRw1uAX9xb//6U6R3IJSFSLdY1vxWm9CstW/v5hnnbsnBFPXN5ZXDk2Nr75
         96Kg==
X-Gm-Message-State: AOAM532atJCtiUUo8/O7hO62cQYOmNt9lpF2Cm07Ibu067Io5duWtrfY
        3ICwZb7JwGCXe0Ho0qHX8TVXmw6HjywJhONx7CvTztS1GaHB99OtsCyi/yszrJ8HOre0NEmCuDU
        spD8U3uy1qsId5rnzkg5LnedmJ/nVXXOv9Pexi9U/YYkk
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr489660wmj.0.1611677763775;
        Tue, 26 Jan 2021 08:16:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFESzJuwOJNgjJnH36tGe1tHaJp46z4ljyXHLxa09sKPjBIoL1bzS4hAc8cAzE4Dsvp0+tYX1jQNuM0msvQIY=
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr489637wmj.0.1611677763530;
 Tue, 26 Jan 2021 08:16:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAS=uOi=8xJU=NiKnXQW2iCazbErg_TX0gL9oayBiDffiA@mail.gmail.com>
 <20210125212755.jfwlqogpcarmxdgt@treble> <CAK7LNAS+EG9doX3qUmu4M3=mRNmdybSv4180Xnuubiwmsq0Agw@mail.gmail.com>
 <20210125220757.vxdsf6sttpy46cq7@treble> <YA/PLdX5m9f4v+Yl@kroah.com>
 <CAFbkSA0m1pqmXh29j6wJ9fG05yC72T1kNC0QU3rF7Oh2NoMwYQ@mail.gmail.com>
 <YBAeYaDReAc9VscA@kroah.com> <20210126145155.kcfbnzfqg5qugvcl@treble>
 <YBAyGU7H8E98xKng@hirez.programming.kicks-ass.net> <20210126154651.itfrnhwfistia3ss@treble>
 <YBA9r13+1uuyDYuR@hirez.programming.kicks-ass.net>
In-Reply-To: <YBA9r13+1uuyDYuR@hirez.programming.kicks-ass.net>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Tue, 26 Jan 2021 10:15:52 -0600
Message-ID: <CAFbkSA1CibJ6sp+LPLy3hpchLLH2B5__Lk31TLeVThXi5eZV7Q@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Greg KH <greg@kroah.com>,
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

On Tue, Jan 26, 2021 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 26, 2021 at 09:46:51AM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 04:15:37PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 26, 2021 at 08:51:55AM -0600, Josh Poimboeuf wrote:
> > > > User space mixes compiler versions all the time.  The C ABI is stable.
> > > >
> > > > What specifically is the harder issue you're referring to?
> > >
> > > I don't think the C ABI captures nearly enough. Imagine trying to mix a
> > > compiler with and without asm-goto support (ok, we fail to build without
> > > by now, but just imagine).
> > >
> > > No C ABI violated, but having that GCC extention vs not having it
> > > radically changes the kernel ABI.
> > >
> > > I think I'm with Greg here, just don't do it.
> >
> > Ok, thank you for an actual example.  asm goto is a good one.
> >
> > But it's not a cut-and-dry issue.  Otherwise how could modversions
> > possibly work?
> >
> > So yes, we should enforce GCC versions, but I still haven't seen a
> > reason it should be more than just "same compiler and *major* version".
>
> Why bother? rebuilding the kernel and all modules is a matter of 10
> minutes at most on a decently beefy build box.
>
> What actual problem are we trying to solve here?



This is true for those of us used to working with source and building
by hand. For users who want everything packaged, rebuilding a kernel
package for install is considerably longer, and for distros providing
builds for multiple arches, we are looking at a couple of hours at
best.  From a Fedora standpoint, I am perfectly fine with it failing
if someone tries to build a module on gcc10 when the kernel was built
with gcc11.  It's tedious when the kernel was built with gcc11
yesterday, and a new gcc11 build today means that kernel needs to be
rebuilt.

