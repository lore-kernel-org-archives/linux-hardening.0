Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB86C433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 15:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9CD64DF9
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 15:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhA1Pq7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231171AbhA1Pq5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Jan 2021 10:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611848731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09LXds/Zxz5H0i6zfTq/PPnlg97L2PXNuCtxy/T8lJk=;
        b=BaSocti5wC30MDCOW8V86QE9FS3LadgIiOTfRUlXrUpQeZ46N/VLvCcqaYu5FCkdY1BF7l
        5yMBt20K+a9kl2Jwp6sYVNxC4tqc5zR/Z++ruSGseIpaESFBuSddo7gqfV/KAllpgoq0Ko
        4SC2O/sb8QWxFvuq8GTPCkBdwJYPflE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-gT9KizAzMAaOex-HWs0sKw-1; Thu, 28 Jan 2021 10:45:28 -0500
X-MC-Unique: gT9KizAzMAaOex-HWs0sKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E2AD8143E5;
        Thu, 28 Jan 2021 15:45:26 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6738319635;
        Thu, 28 Jan 2021 15:45:25 +0000 (UTC)
Date:   Thu, 28 Jan 2021 09:45:23 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <20210128154523.7tdq4gop4tne5xhd@treble>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210127180215.GA1745339@infradead.org>
 <20210127183856.moe3p5pxw6bbtunk@treble>
 <20210127184327.GA1755516@infradead.org>
 <20210127185113.c3est2vssf5tlyyq@treble>
 <20210128142952.GA2041496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128142952.GA2041496@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 28, 2021 at 02:29:52PM +0000, Christoph Hellwig wrote:
> On Wed, Jan 27, 2021 at 12:51:13PM -0600, Josh Poimboeuf wrote:
> > Is this a joke?  I've never met anybody who builds OOT modules as a
> > development aid...
> 
> I'm pretty sure you've met me before.

Yes, but I don't recall this topic coming up :-)

> > On the other hand I know of several very popular distros (some paid,
> > some not) who rely on allowing users/partners to build OOT modules as
> > part of their ecosystem.  To say it's not supported is a farce.
> 
> This is not a farce.  The kernel only supports infrastructure for the
> kernel itself, not for any external consumers.  If you have a business
> model that relies on something else you should think hard if you are in
> the right business.

Thanks for letting me know.  I'll send the memo to the billions of
affected devices.

-- 
Josh

