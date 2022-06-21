Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35DFC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Jun 2022 19:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352715AbiFUTFn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiFUTFn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Jun 2022 15:05:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543EF20F43
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 12:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14C74B81ACD
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 19:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67892C3411C;
        Tue, 21 Jun 2022 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655838339;
        bh=B+6pXgvL/P+nJjxdSFvaYl//rv5G6UT+7tvcRGKJokI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAx9Se/s0hi8TyhCqRilxbgq5uCFCrPN08Emfg+IaShv2MwKZ3YQvWMEClZx6yup0
         FUBCUo1t+3cpdIuQWRZbeowq6xVubSIyy0+Ha2evw4gzI1IXdebjQ7Mm707nEbnTy/
         0H7riVncFd1LArNOZIlXMMz8ecM9cmBjqIKzhs4o=
Date:   Tue, 21 Jun 2022 21:05:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        linux-hardening@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: replacing memcpy() calls with direct assignment
Message-ID: <YrIWgNQkBXkMnKCz@kroah.com>
References: <202206211109.A819E8118@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206211109.A819E8118@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 21, 2022 at 11:37:10AM -0700, Kees Cook wrote:
> Hello Coccinelle gurus! :)
> 
> I recently spent way too long looking at a weird bug in Clang that I
> eventually worked around by just replacing a memcpy() with a direct
> assignment. It really was very mechanical, and seems like it might be a
> common code pattern in the kernel. Swapping these would make the code
> much more readable, I think. Here's the example:
> 
> 
> https://lore.kernel.org/linux-hardening/20220616052312.292861-1-keescook@chromium.org/
> 
> -		memcpy(&host_image->image_section_info[i],
> -		       &fw_image->fw_section_info[i],
> -		       sizeof(struct fw_section_info_st));
> +		host_image->image_section_info[i] = fw_image->fw_section_info[i];

Ick, that hids the fact that you are doing a potentially huge memory
copy here.

And would it also prevent the compiler from using our optimized memcpy()
function and replacing it with whatever it wanted to use instead?

What clang bug does this fix such that it warrants us hiding this
information away from the developers?

thanks,

greg k-h
