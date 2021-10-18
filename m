Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD3C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 20:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F03D61206
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 20:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJRULi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhJRULi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 16:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ED2161206;
        Mon, 18 Oct 2021 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634587766;
        bh=vP/q8RAdwKPOaVadQ+zBGMSPKsA6SzxEBfr5WcIOjGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dz7ITajDyNGZb0OpVqVG3EXS45e16zdG+PDOFEDg+Fi2zxEWN01Ts/+YoKs6BV6bP
         0ybkaW9sVT7heZEOmjM2qs8iDYXFlHdGS+wpKB1eJzn96xQFDpvW70G+5qPSMwZC/W
         aluxIzGeYuhD30bfaX+fYAWwd0yjlc9JLN7z7nKxReMxdCLpXn9HIbMavdGjJSq+Ah
         LS+ZuKw+HON06LSQtn9/o6z9zOWcKsu0daoAF+3H4U+i4vym8K20CNknY1Tvg4uN6d
         EnAcam42k+VeQllPnAycyjZQgDVzZ+GWUtjmwQzKGohwnWXnFT9BliSOaiTTqZhfWY
         KG1n2ynkUjr/g==
Received: by mail-wm1-f54.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so368250wms.0;
        Mon, 18 Oct 2021 13:09:26 -0700 (PDT)
X-Gm-Message-State: AOAM533Yfp21BXZ/STsKMmk+ub0pREdLVGHYccxRckDIwt+94eaS+Y8Q
        B9cwoejsBVfsYEmMpCtteIJbRx8rp2v3Oq0J4x4=
X-Google-Smtp-Source: ABdhPJyJnJ+uE/FeRlOWARcqSSVWZ/9aNle2g3RzqpCnvsVM6fYU6uv54ImfAtoK/Ra8YO1pvPF8xF0ZojLEEw9T+3w=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr1129122wmg.35.1634587765086;
 Mon, 18 Oct 2021 13:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013150025.2875883-1-arnd@kernel.org> <20211013150025.2875883-2-arnd@kernel.org>
 <202110181247.8F53380@keescook>
In-Reply-To: <202110181247.8F53380@keescook>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Oct 2021 22:09:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2wO+diAvRXtZKq+z84sfson6GhxgL9gpBG_BP4h5bSQA@mail.gmail.com>
Message-ID: <CAK8P3a2wO+diAvRXtZKq+z84sfson6GhxgL9gpBG_BP4h5bSQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: use fortified strings for hwaddress sanitizer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 18, 2021 at 9:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 13, 2021 at 05:00:06PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > GCC has separate macros for -fsanitize=kernel-address and
> > -fsanitize=kernel-hwaddress, and the check in the arm64 string.h
> > gets this wrong, which leads to string functions not getting
> > fortified with gcc. The newly added tests find this:
> >
> > warning: unsafe memchr() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memchr.c
> > warning: unsafe memchr_inv() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memchr_inv.c
> > warning: unsafe memcmp() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memcmp.c
> > warning: unsafe memscan() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memscan.c
> > warning: unsafe memcmp() usage lacked '__read_overflow2' warning in /git/arm-soc/lib/test_fortify/read_overflow2-memcmp.c
> > warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memcpy.c
> > warning: unsafe memmove() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memmove.c
> > warning: unsafe memcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memcpy.c
> > warning: unsafe memmove() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memmove.c
> > warning: unsafe memset() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memset.c
> > warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy-lit.c
> > warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy.c
> > warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy-src.c
> > warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy.c
> > warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy-src.c
> > warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy.c
> > warning: unsafe strscpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strscpy.c
> >
>
> What is the build config that trips these warnings?

It's a randconfig build, I've uploaded one .config to
https://pastebin.com/raw/4TKB9mhs,
but I have other ones if you can't reproduce with that one.

> In trying to understand this, I see in arch/arm64/include/asm/string.h:
>
> #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
>         !defined(__SANITIZE_ADDRESS__)
>
> other architectures (like arm32) do:
>
> #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)

Yes, that is exactly the thing that goes wrong. With clang, __SANITIZE_ADDRESS__
gets set here, but gcc sets __SANITIZE_HWADDRESS__ instead
for CONFIG_KASAN_SW_TAGS, so the condition is always true.

> > Add a workaround to include/linux/compiler_types.h so we always
> > define __SANITIZE_ADDRESS__ for either mode, as we already do
> > for clang.
>
> Where is the clang work-around? (Or is this a statement that clang,
> under -fsanitize=kernel-hwaddress, already sets __SANITIZE_ADDRESS__ by
> default?

I mean this snippet:

#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
#define __SANITIZE_ADDRESS__
#endif

Without that, clang sets neither __SANITIZE_ADDRESS__ nor
__SANITIZE_HWADDRESS__

> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index aad6f6408bfa..2f2776fffefe 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -178,6 +178,13 @@ struct ftrace_likely_data {
> >   */
> >  #define noinline_for_stack noinline
> >
> > +/*
> > + * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel
> > + */
> > +#ifdef __SANITIZE_HWADDRESS__
> > +#define __SANITIZE_ADDRESS__
> > +#endif
>
> Should this go into compiler-gcc.h instead?

Yes, that might be clearer, but the effect is the same, as no other
compiler defines
those macros.

       Arnd
