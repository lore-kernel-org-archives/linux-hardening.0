Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC9C433E9
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Mar 2021 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA864DCC
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Mar 2021 08:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCMIy3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 Mar 2021 03:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhCMIyZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 Mar 2021 03:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854D164F18;
        Sat, 13 Mar 2021 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615625665;
        bh=sY82OmhyeTVt+rmWnctmosWs3YKi5+djuGVMlXHeWD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvnvXOeAJ1QkK+8jqwJl2KUclrmhKLISPsciGwDa8j4hVvmb8T9B4fHn7qEF+2eJf
         3bI2L6PYVEnO0oKwC9IEZWCzv+99MTxWb2JefNmohBuy63+SkYuujni5Y/dMoTtPuS
         bvJcU4DJYFJ1pX9EHuqrpMO6oezRt/O0yxeeU60Y=
Date:   Sat, 13 Mar 2021 09:54:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YEx9vSlbRY/SArbW@kroah.com>
References: <20210312205558.2947488-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312205558.2947488-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 12, 2021 at 12:55:58PM -0800, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile, as seen
> with some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that
> will catch and stop linear overflows. This seems justified given that
> seq_file already uses kvmalloc(), that allocations are normally short
> lived, and that they are not normally performance critical.
> 
> [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/seq_file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index cb11a34fb871..ad78577d4c2c 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -32,7 +32,7 @@ static void seq_set_overflow(struct seq_file *m)
>  
>  static void *seq_buf_alloc(unsigned long size)
>  {
> -	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> +	return __vmalloc(size, GFP_KERNEL_ACCOUNT);

Maybe a small comment here like:
	/* use vmalloc as it has good bounds checking */
so we know why this is being used instead of kmalloc() or anything else?

Other than that, no objection from me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
