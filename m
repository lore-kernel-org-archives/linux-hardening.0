Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFD6C4338F
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 13:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C1C60295
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 13:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhHGNJw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 7 Aug 2021 09:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232280AbhHGNJp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 7 Aug 2021 09:09:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BEC260C3F;
        Sat,  7 Aug 2021 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628341768;
        bh=M1NlPbkkt7h2WNDhrKrWWrTf+36pzRbqHlS0F6pG4gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYbFSfIGHZC9L/jIwxS0M4D1msdh0BAlLnSeuvh77yjfiyLXF8LZS2JlQZydtBaBo
         qpAZ8hM5iITt8zipeeBPWcc32Z8Ffc5z6zAaa4BtVgnDwVwnrIcusK22jm6RqpqUQQ
         ggpz+29WQ8cx6qmq7zMrdqStm2MZaJe+PY4Ne104=
Date:   Sat, 7 Aug 2021 15:09:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        lkml@metux.net, purplewall1206 <wangzc5514@163.com>
Subject: Re: [PATCH RFC]  v3 struct const ops pointers member hardening
Message-ID: <YQ6GBQfRMRSLHZAC@kroah.com>
References: <20210807125858.778488-1-wzc@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807125858.778488-1-wzc@smail.nju.edu.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Aug 07, 2021 at 08:58:59PM +0800, Wang Zi-cheng wrote:
> From: purplewall1206 <wangzc5514@163.com>
> 
> Signed-off-by: purplewall1206 <wangzc5514@163.com>


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
