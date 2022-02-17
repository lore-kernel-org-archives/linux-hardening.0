Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C9C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Feb 2022 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBQAhd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:37:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBQAhd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 19:37:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52368E6D91;
        Wed, 16 Feb 2022 16:37:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E142161C55;
        Thu, 17 Feb 2022 00:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F37CC004E1;
        Thu, 17 Feb 2022 00:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645058239;
        bh=Jse37Gv/FnjBWQ3ysuSP5HtMYEFNEpKn11Uwq/2SITw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQDBnsc2JFAmf6I3DvnJry/b1qFlhqSRrrFtSBB3uQgkYn8rLSjH4TmDwEgspboEp
         ZYudBDEFFc/d0gunx8OYqyarmMB1WqTd/UF43t/syGPIMCThVcK/ZLk8fULXkRP08p
         3XHnOniUr6envfAoU3S/pPlak535axWtN5PvsXi4VSPMKZO+Z6kg2PCetkkmQdQu0A
         pfe/5pcoFCmw9oyifU6HBc1wJ3N7LiF+6FpkC49SzJZT3h71FCKc54zM+NQpOqELCV
         uozqEDiyNmqF6/Shv33feDH8lF1+c0386LCaq5iOiwBEakHU6NYUMGUnw772yjAyRJ
         QMe4TbQBOfXHw==
Date:   Wed, 16 Feb 2022 17:37:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um: Allow builds with Clang
Message-ID: <Yg2YubZxvYvx7/nm@dev-arch.archlinux-ax161>
References: <20220217002843.2312603-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217002843.2312603-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 04:28:43PM -0800, Kees Cook wrote:
> Add x86-64 target for Clang+um and update user-offsets.c to use
> Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81

Clang-friendly assembly?

> ("kbuild: fix asm-offset generation to work with clang").
> 
> This lets me run KUnit tests with Clang:
> 
> $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> ...
> $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> ...
> 
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-um@lists.infradead.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

I am not super familiar with UML but this seems reasonable.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small nit below if you have to send a v2, not sure it is worth it
otherwise.

> ---
>  arch/x86/um/user-offsets.c | 4 ++--
>  scripts/Makefile.clang     | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index bae61554abcc..d9071827b515 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -10,10 +10,10 @@
>  #include <asm/types.h>
>  
>  #define DEFINE(sym, val) \
> -	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
>  
>  #define DEFINE_LONGS(sym, val) \
> -	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
>  
>  void foo(void)
>  {
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 51fc23e2e9e5..857b23de51c6 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
>  CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
> +CLANG_TARGET_FLAGS_um		:= x86_64-linux-gnu

It might be nice to keep this in alphabetical order.

>  CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
>  
>  ifeq ($(CROSS_COMPILE),)
> -- 
> 2.30.2
> 
> 
