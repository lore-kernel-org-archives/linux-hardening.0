Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE5C43334
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Jun 2022 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352338AbiFUUnQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiFUUnQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Jun 2022 16:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D71EC79
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 13:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E606183C
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 20:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA7CC3411C;
        Tue, 21 Jun 2022 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655844194;
        bh=GWKVBEsO/tXbxNMLHJdAPxHkivjxvNSe4GewFieE1kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAJJhUfArX3IzZyRr7R5noH2U8NeDYW1WmP7KGUfD2s5SyDbASZkm6F4O28GHZwFD
         ExVenUCt2wRcjV4OdQwY8LmU63Ctq1NBzg3ESPlIyueSi3DTK+6dmp4dF1q4tgsT4c
         /q79XQofKLWAtttEWCgRlKg2tNdEQ2bYCVn0rn24=
Date:   Tue, 21 Jun 2022 22:43:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        linux-hardening@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: replacing memcpy() calls with direct assignment
Message-ID: <YrItX5hVSdK6FCjv@kroah.com>
References: <202206211109.A819E8118@keescook>
 <YrIWgNQkBXkMnKCz@kroah.com>
 <202206211327.F8936F0783@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206211327.F8936F0783@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 21, 2022 at 01:31:13PM -0700, Kees Cook wrote:
> On Tue, Jun 21, 2022 at 09:05:36PM +0200, Greg KH wrote:
> > On Tue, Jun 21, 2022 at 11:37:10AM -0700, Kees Cook wrote:
> > > Hello Coccinelle gurus! :)
> > > 
> > > I recently spent way too long looking at a weird bug in Clang that I
> > > eventually worked around by just replacing a memcpy() with a direct
> > > assignment. It really was very mechanical, and seems like it might be a
> > > common code pattern in the kernel. Swapping these would make the code
> > > much more readable, I think. Here's the example:
> > > 
> > > 
> > > https://lore.kernel.org/linux-hardening/20220616052312.292861-1-keescook@chromium.org/
> > > 
> > > -		memcpy(&host_image->image_section_info[i],
> > > -		       &fw_image->fw_section_info[i],
> > > -		       sizeof(struct fw_section_info_st));
> > > +		host_image->image_section_info[i] = fw_image->fw_section_info[i];
> > 
> > Ick, that hids the fact that you are doing a potentially huge memory
> > copy here.
> > 
> > And would it also prevent the compiler from using our optimized memcpy()
> > function and replacing it with whatever it wanted to use instead?
> 
> What? Uh, quite the reverse, in fact. The compiler is MUCH better about
> doing those kinds of optimizations. The commit log details that there's
> no binary difference, in fact, with this change.

Ah, so we are telling gcc to use our memcpy() implementations then,
otherwise it could use floating point for built-in things like this
without us knowing it.

So it's not an optimization either way.

> > What clang bug does this fix such that it warrants us hiding this
> > information away from the developers?
> 
> Hiding? This makes the code significantly more clear. Doing an assignment
> makes it clear they're the same type, etc, etc. Obscuring all that with
> a memcpy() makes no sense.

Doing a huge memory copy with a simple '=' assignment does have the
potential to hide things.  Yes, memory copies are so fast it's not even
funny these days, but it's like our use of typedef, we don't use it
because it makes it easier to hide what is really happening.

So do we want to hide this type of thing?  I vote no, but hey, this
isn't the part of the kernel that I maintain :)

thanks,

greg k-h
