Return-Path: <SRS0=3XZ1=ID=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A8AC433E6
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82643650AC
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCETZI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhCETZC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 14:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614972302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHhwSQdvm/AMR5+muTOUK1a1247C3GIQ6OGcuOywmzA=;
        b=Xi4/hqmmbuK6Bm2WNKof8znpgnJYfusBEGTNayeQ3sSs4AjdCMw/3bxrT/r/VQyi7FskMD
        FtCsqthUt2yxxItYalewOVCLsNgF1QOHn/TsK0zG81UN7gEtvnMnIUapkIv+/dHgrBTD6u
        getcf4ylKJs5mSCnNZRxRM5IYlDXN50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-fbbbPXyzMW6nCb7A7k5trQ-1; Fri, 05 Mar 2021 14:25:00 -0500
X-MC-Unique: fbbbPXyzMW6nCb7A7k5trQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E6C0800FF0;
        Fri,  5 Mar 2021 19:24:58 +0000 (UTC)
Received: from treble (ovpn-116-51.rdu2.redhat.com [10.10.116.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C4C25D6B1;
        Fri,  5 Mar 2021 19:24:53 +0000 (UTC)
Date:   Fri, 5 Mar 2021 13:24:51 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external
 modules
Message-ID: <20210305192451.xx6bm7t24amutukg@treble>
References: <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
 <20210128205207.awdbh4bmx56pxxjl@treble>
 <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
 <CAHk-=wh+3PWi2NuoQ0hbSyLpOHjaBWKcgX6N7+PfPkXzNAfMwA@mail.gmail.com>
 <20210128213409.qxnclchjyq6v23up@treble>
 <CAHk-=wgjwhDy-y4mQh34L+2aF=n6BjzHdqAW2=8wri5x7O04pA@mail.gmail.com>
 <20210128220803.fixcmuv4ceq5m7dy@treble>
 <CAK7LNARE3KO-kqdsXAbt9d9+3EqqutYd6iNki_rU2-Q9GkakbA@mail.gmail.com>
 <20210201211322.t2rxmvnrystc2ky7@treble>
 <CAK7LNARHoTnZ3gAvHgnYB4n-wYuboxC10A6zURh1ODGhxWd2yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARHoTnZ3gAvHgnYB4n-wYuboxC10A6zURh1ODGhxWd2yA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Mar 06, 2021 at 01:28:22AM +0900, Masahiro Yamada wrote:
> > +orig_name   := $(if $(CONFIG_CC_IS_GCC),GCC,CLANG)
> > +orig_minor  := $(shell expr $(if $(CONFIG_CC_IS_GCC),$(CONFIG_GCC_VERSION),$(CONFIG_CLANG_VERSION)) / 100)
> > +cur_namever := $(shell $(srctree)/scripts/cc-version.sh $(CC))
> > +cur_name    := $(word 1,$(cur_namever))
> > +cur_minor   := $(shell expr $(word 2,$(cur_namever)) / 100)
> 
> These are still calculated by 'make M=... clean' or 'make M=... help'.
> Using '=' assignment solves it, but the code is still ugly.
> 
> 
> I attached my alternative implementation.

Thanks for the attached patch, yours looks much cleaner.  Looks like it
warns on *any* mismatch, rather than just a major.minor mismatch.  But
that's ok with me.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

