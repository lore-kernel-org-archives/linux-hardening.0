Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77311C07E9D
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 00:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIXARm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiIXARl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 20:17:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D7EE653;
        Fri, 23 Sep 2022 17:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80E0F6168D;
        Sat, 24 Sep 2022 00:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E716CC433C1;
        Sat, 24 Sep 2022 00:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663978658;
        bh=RglP0sjMnOR1hc6TIJCoeMPAc2wN4kSJ67XF1tAfF2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vImghcZU/hJ17HG3yO/PDlLHqL5acbajdtbhZJRSEAjL6+lt2+ct+TwM2UBv5Z5D1
         Rg4PAaZSpJpcGsPxqA+lFYu921g2cs0C4sfQWAGgQvTdZ5KWYX/suyGCwNNiPQIud3
         dIx68JfffpnO+z1kO41X4hp6/XDqsEkxOnccZkpNsCjz1OnVQvaJ+enVaf0Che5Lyx
         CN1xj+2Q6Mn2ZC+CHcvlSjYwMlG9QsGM4RqIVlcgH2hiswGlAv6nVAQpdd0BEcJeRc
         /fz3835kh0ghHquMft/qpKPnAEQjo+ThguXySuQ9/42WyY1zy7R4NmDnfWZBIdj4oM
         7nmqSDXmC8vZg==
Date:   Fri, 23 Sep 2022 19:17:31 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Introduce __access_*() function
 attribute
Message-ID: <Yy5MmwVWD7IxCQi2@work>
References: <20220923235424.3303486-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923235424.3303486-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 23, 2022 at 04:54:24PM -0700, Kees Cook wrote:
> Added in GCC 10.1, the "access" function attribute to mark pointer
> arguments for how they are expected to be accessed in a given function.
> Both their access type (read/write, read-only, or write-only) and bounds
> are specified. While it is legal to provide only the pointer argument
> position and access type, design the kernel macros to require also the
> bounds (element count) argument position: if a function has no bounds
> argument, refactor the code to include one.
> 
> These can be used multiple times. For example:
> 
> __access_wo(2, 3) __access_ro(4, 5)
> int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
> 		   u8 *src, int src_len);
> 
> (And if "dst" will also be read, it could use __access_rw(2, 3) instead.)
> 
> These can inform the compile-time diagnostics of GCC including
> -Warray-bounds, -Wstringop-overflow, etc, and can affect
> __builtin_dynamic_object_size() results.
> 
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

--
Gustavo

> ---
>  include/linux/compiler_attributes.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 9a9907fad6fd..6f3d40f7ee5e 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -20,6 +20,22 @@
>   * Provide links to the documentation of each supported compiler, if it exists.
>   */
>  
> +/*
> + * Optional: only supported since gcc >= 10
> + * Optional: not supported by Clang
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-access-function-attribute
> + */
> +#if __has_attribute(__access__)
> +#define __access_rw(ptr, count)	__attribute__((__access__(read_write, ptr, count)))
> +#define __access_ro(ptr, count)	__attribute__((__access__(read_only,  ptr, count)))
> +#define __access_wo(ptr, count)	__attribute__((__access__(write_only, ptr, count)))
> +#else
> +#define __access_rw(ptr, count)
> +#define __access_ro(ptr, count)
> +#define __access_wo(ptr, count)
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
>   */
> -- 
> 2.34.1
> 
