Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28BC433DB
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD50F650E5
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 20:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCIUbl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhCIUbV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Mar 2021 15:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615321881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJH37FcuPBgLxDtxXkuiJ03SpmFTOQU/XyNz2Bopfjs=;
        b=a/Ee02QI/MtrK6jqlx9FWO8D1hmf8qBgyHTze/Ud4zwpk0UxskxJLQUI0iRxe8Aybz0KSG
        mIyKdMc3yonetY4FLsEv38uOf4IwqfKzTms88xMXAJyqKn75s8fs9BxG7c0xOIETEh/E1i
        M+EyGwERZBKHdacVdh6RUBSSl8XwUXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-t2jrNTylPCWlsBIXUNUJ_Q-1; Tue, 09 Mar 2021 15:31:17 -0500
X-MC-Unique: t2jrNTylPCWlsBIXUNUJ_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439581842144;
        Tue,  9 Mar 2021 20:31:15 +0000 (UTC)
Received: from treble (ovpn-117-215.rdu2.redhat.com [10.10.117.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB8C10013C1;
        Tue,  9 Mar 2021 20:31:12 +0000 (UTC)
Date:   Tue, 9 Mar 2021 14:31:09 -0600
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
Message-ID: <20210309203109.2fhyf5naazgjjnch@treble>
References: <20210304113708.215121-1-masahiroy@kernel.org>
 <202103041518.22EB819E@keescook>
 <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
 <20210305022500.cyi3cfwgt2t6mona@treble>
 <20210306012815.nfmquoln65vq6yq7@treble>
 <CAK7LNAR7E4Ud9MPy3q5VOab4EFMumr5GMHqyv=H970+gPTBrFg@mail.gmail.com>
 <20210306025059.z6dn6mi7mxyufkr2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210306025059.z6dn6mi7mxyufkr2@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 08:50:59PM -0600, Josh Poimboeuf wrote:
> > Is this a bad coding contest?
> > 
> > I am not asking you to add ugly ifeq or whatever
> > hacks to say "this worked for me".
> > 
> > Please feel free to do this in the fedora kernel,
> > but do not send it to upstream.
> > 
> > Sorry, I really do not want to see hacks like this any more.

Masahiro,

Ping.  Do you have a better approach for building GCC plugins in the
external module directory?

-- 
Josh

