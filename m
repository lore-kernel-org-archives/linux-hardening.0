Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCABCC433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 02:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844BA64FDB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 02:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCECZJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhCECZJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 21:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614911108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4R2mdJt2nLRLbz7IdMX2IliZJZEhrxvBLP7j70N01s=;
        b=SFzIfMe74jVwqAbs9BTnjDS8PSbZTT8FZyZFlyeAspKZbp+L7YBlqQ8DLgSvWU56HRAHEK
        vcldOf9qYllUr42xpRtbcgmcNdaAfigOsBRlnC1XVnpWMQ9EgtxGPvWwSNwjL85yKA5faE
        uHiSLXV8hv7BmkYvfog9kGwZOedBHR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-kN50u5fwNvaVmlKtmzoUng-1; Thu, 04 Mar 2021 21:25:06 -0500
X-MC-Unique: kN50u5fwNvaVmlKtmzoUng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED37380006E;
        Fri,  5 Mar 2021 02:25:04 +0000 (UTC)
Received: from treble (ovpn-113-161.rdu2.redhat.com [10.10.113.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E615C1A1;
        Fri,  5 Mar 2021 02:25:03 +0000 (UTC)
Date:   Thu, 4 Mar 2021 20:25:00 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
Message-ID: <20210305022500.cyi3cfwgt2t6mona@treble>
References: <20210304113708.215121-1-masahiroy@kernel.org>
 <202103041518.22EB819E@keescook>
 <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 04, 2021 at 03:37:14PM -0800, Linus Torvalds wrote:
> On Thu, Mar 4, 2021 at 3:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This seems fine to me, but I want to make sure Josh has somewhere to
> > actually go with this. Josh, does this get you any closer?

No, this doesn't seem to help me at all.

> > It sounds like the plugins need to move to another location for
> > packaged kernels?
> 
> Well, it might be worth extending the stuff that gets installed with
> /lib/modules/<kernel-version>/ with enough information and
> infrastruvcture to then build any external modules.

The gcc plugins live in scripts/, which get installed by "make
modules_install" already.  So the plugins' source and makefiles are in
/lib/modules/<kernel-version>/build/scripts/gcc-plugins.

So everything needed for building the plugins is already there.  We just
need the kernel makefiles to rebuild the plugins locally, when building
an external module.

-- 
Josh

