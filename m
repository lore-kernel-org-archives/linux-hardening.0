Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED4C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 21:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E02C61057
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJTWBr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhJTWBr (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 18:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F030E611CB;
        Wed, 20 Oct 2021 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634767172;
        bh=p/FrOCkd3lRrm2AfwEqVbzWLSKdO/oVRmjDk7ncCiIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYND7Su80MFf6on5xybMBeQ3xq3iEPl3QFGuUPqq886JJm9kANRaq5nIg7JyfWyhj
         IujPCDxkdoDXx9DQcX5UAPJAcLl0ufZJW/j6XvlYEdY5nXqTxepLwwq0XXNsMXkTLx
         lnWr7zmXqnhNYPne9hBhBO+qSEkm9iHcv7mMm7RMaRsgcElkyLW3MdiAwxos0Oyxk1
         DB86QqE6CDENE7xjacxOWji28VLhavIhqiiAZqVQVhCiJai3HwS+EZqiXJ9Yju5iYr
         nPzzLq7pSSXxWOKC3DSheXU3bukzE6mJXQleTLgM6Fq62SzHDS5a0iW7Ol5pOSWtCW
         Xqz3gVZeNkFcA==
Date:   Wed, 20 Oct 2021 14:59:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
Message-ID: <YXCRPsNl2Vlgd7ct@archlinux-ax161>
References: <20211020200039.170424-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020200039.170424-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 20, 2021 at 01:00:39PM -0700, Kees Cook wrote:
> When Clang is using the hwaddress sanitizer, it sets __SANITIZE_ADDRESS__
> explicitly:
> 
>  #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
>  /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
>  #define __SANITIZE_ADDRESS__
>  #endif
> 
> Once hwaddress sanitizer was added to GCC, however, a separate define
> was created, __SANITIZE_HWADDRESS__. The kernel is expecting to find
> __SANITIZE_ADDRESS__ in either case, though, and the existing string
> macros break on supported architectures:
> 
>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
>           !defined(__SANITIZE_ADDRESS__)
> 
> where as other architectures (like arm32) have no idea about hwaddress
> sanitizer and just check for __SANITIZE_ADDRESS__:
> 
>  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> 
> This would lead to compiler foritfy self-test warnings when building
> with CONFIG_KASAN_SW_TAGS=y:
> 
> warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
> warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
> ...
> 
> Sort this out by also defining __SANITIZE_ADDRESS__ in GCC under the
> hwaddress sanitizer.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> I'm intending to take this via my overflow series, since that is what introduces
> the compile-test regression tests (which found this legitimate bug). :)
> 
> -Kees
> ---
>  include/linux/compiler-gcc.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 6f24eb8c5dda..ccbbd31b3aae 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -121,6 +121,14 @@
>  #define __no_sanitize_coverage
>  #endif
>  
> +/*
> + * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel,
> + * matching the defines used by Clang.
> + */
> +#ifdef __SANITIZE_HWADDRESS__
> +#define __SANITIZE_ADDRESS__
> +#endif
> +
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> -- 
> 2.30.2
> 
