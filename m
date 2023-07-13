Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501DEEB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jul 2023 07:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjGMHAo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjGMHAV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jul 2023 03:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161C2684
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 00:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4017619E0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 07:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DDC433C7;
        Thu, 13 Jul 2023 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689231619;
        bh=rF9cHIOZQLcJU2HZRLV5oZ9L+fOUHrgy7qmVrg+tuYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3ZVKDDnYdK1ZBq214iOh5XCIt12i1s1xd2hbfr8i17Bh9A9w2upIkz+HOtkwdDzn
         pxk9M7WoyvQbUYuk+9DZuw8pTRxGnyy7aT+AJSb35GVh/uj4Rg5ySWPnfyvaTkTa6A
         rQv2MNVZ+YiZHICDUbXygxEFpliSvu4H+d9La+K2+U2vNM4aJozKnCuGpQLmj64/rE
         PqF4UKYXoka/rcjro2PhT9MduGtst37xxYmeR9X7M19557VPEL1B7skwSGl8Mfuuml
         G8xgBuR+LM53wWx96yPocfB45xGIjPBuw46jSfx3UvPenfXvhhbyGtd1W9tcC+DFox
         Ys3985VBOdaGw==
Date:   Thu, 13 Jul 2023 00:00:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v3 2/2] pstore: Replace crypto API compression with
 zlib_deflate library calls
Message-ID: <20230713070017.GB2199@sol.localdomain>
References: <20230712162332.2670437-1-ardb@kernel.org>
 <20230712162332.2670437-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712162332.2670437-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 12, 2023 at 06:23:32PM +0200, Ard Biesheuvel wrote:
> Pstore supports compression using a variety of algorithms exposed by the
> crypto API. This uses the deprecated comp (as opposed to scomp/acomp)
> API, and so we should stop using that, and either move to the new API,
> or switch to a different approach entirely.
> 
> Given that we only compress ASCII text in pstore, and considering that
> this happens when the system is likely to be in an unstable state, the
> flexibility that the complex crypto API provides does not outweigh its
> impact on the risk that we might encounter additional problems when
> trying to commit the kernel log contents to the pstore backend.
> 
> So let's switch [back] to the zlib deflate library API, and remove all
> the complexity that really has no place in a low-level diagnostic
> facility. Note that, while more modern compression algorithms have been
> added to the kernel in recent years, the code size of zlib deflate is
> substantially smaller than, e.g., zstd, while its performance in terms
> of compression ratio is comparable for ASCII text, and speed is deemed
> irrelevant in this context.
> 
> Note that this means that compressed pstore records may no longer be
> accessible after a kernel upgrade, but this has never been part of the
> contract. (The choice of compression algorithm is not stored in the
> pstore records either)
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/pstore/Kconfig    | 100 ++------------
>  fs/pstore/platform.c | 136 +++++++++++++-------
>  2 files changed, 97 insertions(+), 139 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
