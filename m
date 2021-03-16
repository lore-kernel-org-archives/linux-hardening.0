Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AAFC433E6
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C3664F91
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 07:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCPHY5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Mar 2021 03:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhCPHYz (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Mar 2021 03:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02CD364F91;
        Tue, 16 Mar 2021 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615879494;
        bh=8uUDAW08JUiZFZ6RLHXQ4tv6CD+Mof+kNjKmo7xGysQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fu9N3c2Xdt+OkZcZjfn4Yrm4YjiyMGSf1mi/i74GYOsj5bJ2/FDKsAPWq8JxFnvoj
         XOYEz2YkSBwczRBFMBwAhhBKQSczmGI82SNR2alFxYXXvEtQx8NIvjuajyPdBQru8I
         mWwdw7YcJ0mzKblwP8D+/6G1rcfI1o6wsWSeojF8=
Date:   Tue, 16 Mar 2021 08:24:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFBdQmT64c+2uBRI@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103151336.78360DB34D@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 15, 2021 at 01:43:59PM -0700, Kees Cook wrote:
> On Mon, Mar 15, 2021 at 06:33:10PM +0000, Al Viro wrote:
> > On Mon, Mar 15, 2021 at 10:48:51AM -0700, Kees Cook wrote:
> > > The sysfs interface to seq_file continues to be rather fragile, as seen
> > > with some recent exploits[1]. Move the seq_file buffer to the vmap area
> > > (while retaining the accounting flag), since it has guard pages that
> > > will catch and stop linear overflows. This seems justified given that
> > > seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> > > larger allocation, has allocations are normally short lived, and is not
> > > normally on a performance critical path.
> > 
> > You are attacking the wrong part of it.  Is there any reason for having
> > seq_get_buf() public in the first place?
> 
> Completely agreed. seq_get_buf() should be totally ripped out.
> Unfortunately, this is going to be a long road because of sysfs's ATTR
> stuff, there are something like 5000 callers, and the entire API was
> designed to avoid refactoring all those callers from
> sysfs_kf_seq_show().

What is wrong with the sysfs ATTR stuff?  That should make it so that we
do not have to change any caller for any specific change like this, why
can't sysfs or kernfs handle it automatically?

> However, since I also need to entirely rewrite the sysfs vs kobj APIs[1]
> for CFI, I'm working on a plan to fix it all at once, but based on my
> experience refactoring the timer struct, it's going to be a very painful
> and long road.

Oh yeah, that fun.  I don't think it's going to be as hard as you think,
as the underlying code is doing the "right thing" here, so this feels
like a problem in the CFI implementation more than anything else.

So what can I do today in sysfs to help fix the seq_get_buf() stuff?
What should it use instead?

thanks,

greg k-h
