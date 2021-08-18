Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75013C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AF661076
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhHROCE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhHROCE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 10:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C192861076;
        Wed, 18 Aug 2021 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629295289;
        bh=n0bqvjFk9Fcyf5vG4qnh6fvg/zu6w3/aSDrjvp3f4ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnhjQ5zpBint+sjjMGZejnqN9eQgjtWpg+ZzgZYqRxdf9fWkFqRJW10fEQKDrhi2q
         sfsmeE19aJI9Qcg3ibbIIVHaaX7dr+CzHSBE2AQR3f7Sg4q2eClWyRbnwjujQc/lRa
         4sDRCDcNt6oXEOE3/4mCvKsMpADWnJ0pS2qmj18k=
Date:   Wed, 18 Aug 2021 16:01:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/heap: Avoid __alloc_size hint warning
Message-ID: <YR0StuqeKm1vbaM5@kroah.com>
References: <20210818044540.1601664-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818044540.1601664-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 09:45:40PM -0700, Kees Cook wrote:
> Once __alloc_size hints have been added, the compiler will
> (correctly!) see this as an overflow. We are, however, trying to test
> for this condition, so work around it with a volatile int.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/heap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 3d9aae5821a0..e59fcbe00ae0 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -12,6 +12,8 @@ static struct kmem_cache *double_free_cache;
>  static struct kmem_cache *a_cache;
>  static struct kmem_cache *b_cache;
>  
> +static volatile int __offset = 1;

Perhaps a comment here as to why volatile is ok to use?  That feels like
it is a hack around the compiler of today, what happens tomorrow when
newer versions decide to ignore volatile as it "knows" no one ever
changes it?

thanks,

greg k-h
