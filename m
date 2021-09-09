Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC68C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A0E610FF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhIIQDV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhIIQDV (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 12:03:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 674C061101;
        Thu,  9 Sep 2021 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631203331;
        bh=URsvhsIa9xPYpIpkYJ19dcffnMkB3oAaPNGfxCk4ylo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuGdhFhUMQ6BoKrVC0Uy9i8uFEwK1ANlmF7oUmVVyDxKu5/MhBLnGDn5lgZOyMdyQ
         S6T8K71i5+yurrj+cnTIQJXeldGA6CYX6eQbq8xvNaxHyqXBjkwAMYAH+xE7cZlCVo
         rZiNZgt8KYk8EQuFZSmCxGAgVnlIhPPijbYAq61A=
Date:   Thu, 9 Sep 2021 18:02:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Message-ID: <YTowAX7szcAP7ItU@kroah.com>
References: <20210901233406.2571643-1-keescook@chromium.org>
 <202109090848.129A49E8BD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109090848.129A49E8BD@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 09, 2021 at 08:49:57AM -0700, Kees Cook wrote:
> On Wed, Sep 01, 2021 at 04:34:06PM -0700, Kees Cook wrote:
> > Using generated/compile.h triggered a full LKDTM rebuild with every
> > build. Avoid this by using the exported strings instead.
> > 
> > Fixes: b8661450bc7f ("lkdtm: Add kernel version to failure hints")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Hi Greg,
> 
> Your bot said "please wait, the merge window is open", but it'd be really
> nice to get this into -rc1 to avoid annoying people doing rebuilds...
> 
> :)

I'm not supposed to be adding new patches to my tree during this period
of time in the merge window.

I can't see a rebuild locally here without this patch attached, so how
much of a problem is it right now?

And isn't -rc2 ok?

thanks,

greg k-h
