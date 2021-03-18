Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDEC433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6B264F10
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 17:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCRR6B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230164AbhCRR5a (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616090249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0q5WdWmdiO1vxhUtqzchuFaJDrkVXDNMZnS+MwXgTY=;
        b=GQ9bf4lF7U3VT/6xwTQQD1Dik3JeuVhIS/a/F8Hn/MnqNo+XgdATGkDOAbDwzyPOcOLICB
        TTNOAUvP8NXn7qKCYxtiFWsGVZmHcy/cjidtnjFSytjqyd0AokACTiQ7RCIaTuESsBFKD1
        KRfT4Dzcpb3mfC4HfON6c9rN8aHYKhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-pp2toMmBOMieT5Z5SFgnrw-1; Thu, 18 Mar 2021 13:57:28 -0400
X-MC-Unique: pp2toMmBOMieT5Z5SFgnrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F9C8190A7AB;
        Thu, 18 Mar 2021 17:57:26 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5A825B4A6;
        Thu, 18 Mar 2021 17:57:23 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:57:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Eigler <fche@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
Message-ID: <20210318175721.basitauxxboywjsx@treble>
References: <20210304113708.215121-1-masahiroy@kernel.org>
 <202103041518.22EB819E@keescook>
 <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
 <20210305022500.cyi3cfwgt2t6mona@treble>
 <20210306012815.nfmquoln65vq6yq7@treble>
 <CAK7LNAR7E4Ud9MPy3q5VOab4EFMumr5GMHqyv=H970+gPTBrFg@mail.gmail.com>
 <20210306025059.z6dn6mi7mxyufkr2@treble>
 <20210309203109.2fhyf5naazgjjnch@treble>
 <CAK7LNAQDbhzi5s8iaqVSV82v8n-+0a=XB3-8wg=Nu41XyRETvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQDbhzi5s8iaqVSV82v8n-+0a=XB3-8wg=Nu41XyRETvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 10, 2021 at 10:44:46PM +0900, Masahiro Yamada wrote:
> > Masahiro,
> >
> > Ping.  Do you have a better approach for building GCC plugins in the
> > external module directory?
> 
> 
> I am not sure if building GCC plugins in the external module directory
> is the right approach.

I'm certainly open to any better ideas that would allow GCC plugins to
be enabled in distro kernel builds.

-- 
Josh

