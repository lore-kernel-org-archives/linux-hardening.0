Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF71C433DB
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ED064F51
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbhCDAvf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388019AbhCCUZl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Mar 2021 15:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614803054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwI88JLj7QwwzS9i8kbM1M0H9+uT2FNL+09oqgaBSK0=;
        b=NoHdbGu3S8rKNcTFfTG+CwyTDZQWUzAsbHuc3nrGyInn1sjEYXcHr64JdGOSKu4BOS8qsL
        afSyOHu3cG1cK+yU9IjLeVbc9HgoViFwu1g51FJ8GIWEOz5amk4QgMTrtViHNZkjjWhGBN
        sA1gStWhewbaHJaEwdvy25fDOC0VsI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-3Pelhp7PNJaKh_HeYk6c6Q-1; Wed, 03 Mar 2021 15:24:13 -0500
X-MC-Unique: 3Pelhp7PNJaKh_HeYk6c6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E805A91295;
        Wed,  3 Mar 2021 20:24:11 +0000 (UTC)
Received: from treble (ovpn-114-218.rdu2.redhat.com [10.10.114.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66B4C60BFA;
        Wed,  3 Mar 2021 20:24:09 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:24:06 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <20210303202406.bxgdx5a25j6wc43b@treble>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble>
 <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble>
 <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
 <20210303193806.oovupl4ubtkkyiih@treble>
 <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 03, 2021 at 11:57:33AM -0800, Linus Torvalds wrote:
> On Wed, Mar 3, 2021 at 11:38 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > But in the meantime, making the plugins depend on the gcc version some
> > > way is certainly better than not doing so.
> >
> > So currently, the plugins already so that.  They require the GCC version
> > to be exact.  If there's a mismatch, then it fails the OOT module build.
> 
> That's not my experience.
> 
> Yes, the build fails, but it fails not by _rebuilding_, but by failing
> with an error.

Um, that's what I said.  It does not rebuild.  It fails with an error.

The *proposal* is to rebuild the plugin -- which Masahiro nacked because
he claims GCC mismatches aren't supported for OOT builds (plugin or
not).

Your nack is for a different reason: GCC plugins are second-class
citizens.  Fair enough...

-- 
Josh

