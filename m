Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5AFC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2BB61004
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 23:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhJTXtv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 19:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJTXtt (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 19:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04E6861004;
        Wed, 20 Oct 2021 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634773654;
        bh=9d545R9PWdQWgRdbw7W5tcMHp9oZBeg+DHAnlfPE+vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyPiwW446bj302JCDkfG8CtZMG4oK07102wrPx+eQKBBQ2PDQV+ylFJYdPL9OtRPn
         IFuCrr8/h5BRVvP9Gf6leTiOAmalzBdAS5u+qb3UQ3WroX4GQpAvpQorfSPYN9m34J
         YUR6gtb7wF/5Yj+OyBaufc2uyPxyMUpgQ2liiwY6s0JVHvPachAfuUYhz62yRVhIsW
         eLU3jPlodt9HbDxx+u8g0012MIdtYSCJnQkeszpYQT7eDzti3V7Nj2rDQjIIPZfhET
         ftM+Lexlzin2QZgOp7eanyTJSsNhB7LCIQBgV8TQ5c50UglTH26MmQ1nbI0qKuiuLd
         GAOnbQnEhCU9Q==
Date:   Wed, 20 Oct 2021 18:52:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
Message-ID: <20211020235214.GA1346969@embeddedor>
References: <20210925143455.21221-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925143455.21221-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 25, 2021 at 04:34:55PM +0200, Len Baker wrote:
> Although using literals for size calculation in allocator arguments may
> be harmless due to compiler warnings in case of overflows, it is better
> to refactor the code to avoid the use of open-coded arithmetic.
> 
> So, clarify the preferred way in these cases.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>

This looks good to me.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> Changelog v1 -> v2
>  - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>"
>    (Joe Perches).
> 
> Changelog v2 -> v3
>  - Reword the sentence to comunicate better (Jonathan Corbet).
> 
> The previous version can be found here [1].
> 
> [1] https://lore.kernel.org/linux-hardening/20210829144716.2931-1-len.baker@gmx.com/
> 
>  Documentation/process/deprecated.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 8ced754a5a0f..388cb19f5dbb 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -59,8 +59,9 @@ risk of them overflowing. This could lead to values wrapping around and a
>  smaller allocation being made than the caller was expecting. Using those
>  allocations could lead to linear overflows of heap memory and other
>  misbehaviors. (One exception to this is literal values where the compiler
> -can warn if they might overflow. Though using literals for arguments as
> -suggested below is also harmless.)
> +can warn if they might overflow. However, the preferred way in these
> +cases is to refactor the code as suggested below to avoid the open-coded
> +arithmetic.)
> 
>  For example, do not use ``count * size`` as an argument, as in::
> 
> --
> 2.25.1
> 
