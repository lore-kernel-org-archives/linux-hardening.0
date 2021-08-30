Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F9C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E518260F44
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhH3Spv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhH3Spu (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 14:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C42B60F3A;
        Mon, 30 Aug 2021 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349096;
        bh=LtTJKZ/nDmnOgKVis3WLUMr+KoCayI+9HgyvZySnxLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIenoLLyVAS+i6cujE8l6cJwEIsV1bmiRG9P+prmjn8S3FUHfZsQHGb85HwQl8B0m
         oIY2XIuQjeED8yzmQct6OVY+ONatrINvelb5MVrmYo7KQVZ2ueShDTw/q20Io+nL7R
         J9K0oio3GJdul3pgs0LYMOqX8QGCqk8S5CH3kr/lFD78/MjxrGEI/eShnVuFMPYWWv
         Q4MfnMGtlP8dXMRjzoGDmNomJ83R6JFR6XjQww9S+QNbXk25lDD1nB8gmJQTus6Qso
         V5284apjrl4SKcuPigJcuuJbqp1jjd9y0K2peNgAbTn/tcG6c4ztN5JnpaZ97QWT5T
         8WWy9t+6XNrWw==
Date:   Mon, 30 Aug 2021 11:44:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Message-ID: <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
References: <20210827163015.3141722-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827163015.3141722-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 27, 2021 at 09:30:10AM -0700, Kees Cook wrote:
> v3:
> - fix typo in treewide conversion (u8 should have been __u8)
> - improve changelog for DECLARE_FLEX_ARRAY patch
> - add acks/reviews
> v2: https://lore.kernel.org/lkml/20210826050458.1540622-1-keescook@chromium.org/
> v1: https://lore.kernel.org/lkml/20210818081118.1667663-1-keescook@chromium.org/
> 
> Hi,
> 
> In support of the improved buffer overflow detection for memcpy(),
> this enables -Warray-bounds and -Wzero-length-bounds globally. Mostly
> it involves some struct member tricks with the new DECLARE_FLEX_ARRAY()
> macro. Everything else is just replacing stacked 0-element arrays
> with actual unions in two related treewide patches. There is one set of
> special cases that were fixed separately[1] and are needed as well.
> 
> I'm expecting to carry this series with the memcpy() series in my
> "overflow" tree. Reviews appreciated! :)

Hi Kees,

I ran this series through my local build tests and uncovered two
warnings in the same file that appear to be unhandled as of
next-20210830. This is from ARCH=powerpc pseries_defconfig with
clang-14, I did not try earlier versions of clang.

arch/powerpc/kernel/signal_32.c:780:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
        unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:85:29: note: expanded from macro 'unsafe_put_sigset_t'
#define unsafe_put_sigset_t     unsafe_put_compat_sigset
                                ^
./include/linux/compat.h:455:19: note: expanded from macro 'unsafe_put_compat_sigset'
                unsafe_put_user(__s->sig[3] >> 32, &__c->sig[7], label);        \
                                ^        ~
./arch/powerpc/include/asm/uaccess.h:426:42: note: expanded from macro 'unsafe_put_user'
        __put_user_size_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
                                                ^
./arch/powerpc/include/asm/uaccess.h:114:30: note: expanded from macro '__put_user_size_goto'
        case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;        \
                                    ^
./arch/powerpc/include/asm/uaccess.h:89:10: note: expanded from macro '__put_user_asm_goto'
                : "r" (x), "m"UPD_CONSTR (*addr)                \
                       ^
./include/linux/compiler_types.h:254:42: note: expanded from macro 'asm_volatile_goto'
#define asm_volatile_goto(x...) asm goto(x)
                                         ^
./arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
        unsigned long sig[_NSIG_WORDS];
        ^
arch/powerpc/kernel/signal_32.c:1044:3: error: array index 2 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
                unsafe_put_sigset_t(&old_ctx->uc_sigmask, &current->blocked, failed);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:85:29: note: expanded from macro 'unsafe_put_sigset_t'
#define unsafe_put_sigset_t     unsafe_put_compat_sigset
                                ^
./include/linux/compat.h:459:19: note: expanded from macro 'unsafe_put_compat_sigset'
                unsafe_put_user(__s->sig[2] >> 32, &__c->sig[5], label);        \
                                ^        ~
./arch/powerpc/include/asm/uaccess.h:426:42: note: expanded from macro 'unsafe_put_user'
        __put_user_size_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
                                                ^
./arch/powerpc/include/asm/uaccess.h:116:30: note: expanded from macro '__put_user_size_goto'
        case 4: __put_user_asm_goto(x, __pus_addr, label, "stw"); break;        \
                                    ^
./arch/powerpc/include/asm/uaccess.h:89:10: note: expanded from macro '__put_user_asm_goto'
                : "r" (x), "m"UPD_CONSTR (*addr)                \
                       ^
./include/linux/compiler_types.h:254:42: note: expanded from macro 'asm_volatile_goto'
#define asm_volatile_goto(x...) asm goto(x)
                                         ^
./arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
        unsigned long sig[_NSIG_WORDS];
        ^

Cheers,
Nathan
