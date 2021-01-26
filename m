Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2673C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 04:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA792070C
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 04:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhA0EtQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 23:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390084AbhA0APE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Jan 2021 19:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611706417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUzFQG64yqGa/8ahfKwuvvtiCy8mmgeGisnMAQFkYkU=;
        b=GTunh/xh3Fn3NGz2lAKZHlPV1u1P+w+Bw+wIaV5+kW62sE5u2Z2aFizlrLVtMDEjDSUtDp
        6djwBmI4+R01QfAOwo5A19fDsR1z3Bv+Q4W9r8gA12sy6EU9Qmcp3Wz9m9UOeDiZxcde1U
        eFsUA+iUUdnFVjlMzOAJgJDvdGlo8EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-DqrecdCmNo-vpsIFIAnlHQ-1; Tue, 26 Jan 2021 18:32:53 -0500
X-MC-Unique: DqrecdCmNo-vpsIFIAnlHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30752802B40;
        Tue, 26 Jan 2021 23:32:52 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10AB810013C1;
        Tue, 26 Jan 2021 23:32:50 +0000 (UTC)
Date:   Tue, 26 Jan 2021 17:32:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <20210126233249.ewgdsiazdwbzykqj@treble>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <202101251401.F18409FDD1@keescook>
 <20210125221953.wng3gk3qc32eahil@treble>
 <202101260955.F83D191B@keescook>
 <20210126184316.hpcy6gqp5vsq6ckq@treble>
 <202101261459.C90E9F97D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202101261459.C90E9F97D@keescook>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 26, 2021 at 02:59:57PM -0800, Kees Cook wrote:
> On Tue, Jan 26, 2021 at 12:43:16PM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 26, 2021 at 09:56:10AM -0800, Kees Cook wrote:
> > > On Mon, Jan 25, 2021 at 04:19:53PM -0600, Josh Poimboeuf wrote:
> > > > On Mon, Jan 25, 2021 at 02:03:07PM -0800, Kees Cook wrote:
> > > > > On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> > > > > > When a GCC version mismatch is detected, print a warning and disable the
> > > > > > plugin.  The only exception is the RANDSTRUCT plugin which needs all
> > > > > > code to see the same struct layouts.  In that case print an error.
> > > > > 
> > > > > I prefer this patch as-is: only randstruct needs a hard failure. The
> > > > > others likely work (in fact, randstruct likely works too).
> > > > 
> > > > I'm curious about this last statement, why would randstruct likely work?
> > > > 
> > > > Even struct module has '__randomize_layout', wouldn't basic module init
> > > > go splat?
> > > 
> > > No; the seed is part of the generate includes -- you'll get the same
> > > layout with the same seed.
> > 
> > Right, but don't you need the plugin enabled to make use of that seed,
> > so the structs get interpreted properly by the module?  Or am I
> > completely misunderstanding how this plugin works?
> 
> Having the plugin enabled or not is part of the Kconfig ... you can't
> build anything if you change Kconfig. I feel like I'm missing
> something...

I guess we crossed wires somehow.  Backing up :-)

The patch disables plugins when there's a GCC mismatch in the OOT module
build, with the exception of RANDSTRUCT, for which it just errors out.

When you said "randstruct likely works too" I thought you meant that
RANDSTRUCT would likely work even if it were disabled in the OOT module
build (i.e. if we removed the RANDSTRUCT special case from the patch).

Or did you mean something else?  Like using RANDSTRUCT with a different
version of GCC would likely work?

(I'm definitely not proposing we allow GCC mismatches for plugins, as I
was told that plugins can break from one build to the next).

-- 
Josh

