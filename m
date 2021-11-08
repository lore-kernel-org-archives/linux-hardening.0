Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E23C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 13:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE3B61284
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 13:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhKHNEP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237857AbhKHNEO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 08:04:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFF061207;
        Mon,  8 Nov 2021 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636376490;
        bh=1jc0fqx+O7P3W5EzIlHxWcUrWtz1kD3moB8iaoHU7Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGOq63fNsqKNvSso040+FGHWJ+LffAc3B+hxjRF6aVeHFBUG7Tcah3YH/QYoLZ4sn
         bomW1EyYUNfLKxV+QrDYpkYZXwAw8milG3lQbxEeKfhdA5fh0wPUkyS3XTD7VkbLQF
         ypg+bBOgJbedjLFgT2gko/x3AhLpIXUgIKdMkPoU=
Date:   Mon, 8 Nov 2021 14:01:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     andy@kernel.org, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy
 and strscpy
Message-ID: <YYkfqH5wK3K/XaGQ@kroah.com>
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <YYkWb4GQAAtZJNsT@kroah.com>
 <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 08, 2021 at 06:15:54PM +0530, Ajay Garg wrote:
> Hi Greg,
> 
> Thanks for your time.
> 
> >
> > Wait, why?  We have recently added new string copy functions to resolve
> > the type of issues you have pointed out.  The kernel is not yet
> > converted to use them, so why add yet-another-function that also is not
> > used?
> 
> Greg, would request your couple of minutes more, in suggesting a
> concrete way forward, by working through an example as below.
> 
> 
> In the file fs/kernfs/dir.c, there is a statement
> 
>         return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> 
> Here, there is no information of how long kn->name might be, so there
> is a definite chance of overflow happening. Thus, accordingly, strlcpy
> is used, to bound copying of upto buflen bytes. Of course, buf
> (destination-buffer) is safe from any overflow now.

We "know" that kn->name will not overflow here based on the callers of
this function, right?  I can not find any caller that passes in a buffer
that would overflow, or am I missing a callpath somewhere?

> However, iffff strlen(kn->name) is greater than (buflen - 1), then
> strlcpy would return a different value than the number of bytes
> actually copied. Since there is no check, this (wrong) return value
> will be propagated to the clients down the stack.

But in the existing kernel, can that happen today?  I can't find any
caller that would be using this in that manner.

And that's what matters.  Not the theoretical callers in the possible
future, but the in-kernel users of the functions today.

If these calls are wrong, then they should be fixed, but adding another
string function to the heap of ones we have should only be done after
considering the ones that we currently have, why they were added, and
why existing code has not yet been converted to use them.

thanks,

greg k-h
