Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FEC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 23:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiBHX63 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiBHX63 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 18:58:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB1C061576
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 15:58:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso2562997pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Al312nSB11RWQ/fPz/oLtgMbGtxfQXub9WO/1WYfmpk=;
        b=QVhTkuP6g5ht0lSUDdZXX4ML54Png+mqetf03uPCTSZEbVJJRRik/1zcMYrH17WVc3
         bpnDG1ZupaKCXeN7lPCDGJ5EAv8dmXPG65CXGhHlRVFz0gJq0z1+3Q/Xv+P/D3bFVjZC
         pq+jYhiAV+G8dH8pK+8L0b1G59nytVkjzXk1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Al312nSB11RWQ/fPz/oLtgMbGtxfQXub9WO/1WYfmpk=;
        b=V1yf26P1f0DbHxneo8tsvwr1EMcYUQwgbn21huW5yGPLy0/gH206KM8govnC5I5AmV
         b/9SSM0IwUuLH+Ow7EbDvC3Cl5+3SionpV9eXuKyQYcaPbiAYTGelKWSgSt/MRrZzvM3
         fc+n0AFwXQsQQx5ZsE/COBchu7shOw1IUrNyCiv2hKfEuwcHQ8AdiprwiyOLVw0ybDTF
         qk+CW+L8p6UqyOsD6WBPFKoWVpsCf5+cHT5lHZ0pRvhZpTvyQYLNyOaJ4wIpCv7kRFst
         kUyIPDpZmgOl1C1XfTf7yv3cp51jA+3gfLMPgzmum5jMfSCWfdThlZtVk/OkOP3l7dwp
         7uoQ==
X-Gm-Message-State: AOAM533zRnzIRBCjpDoB30AaO8PoKEJX+Y/5L+V66W3kNjsv9xCZypW4
        Z/gHcR7cLoD3qmyCYyAK03h53Q==
X-Google-Smtp-Source: ABdhPJw+/mRo5ofjXEkCHagXxoE3e/S1IZPBO5qaKIqgxKt9qk6CwAf4EaSB4bnfRh2kzoYBWuaIAw==
X-Received: by 2002:a17:902:e88e:: with SMTP id w14mr6839434plg.95.1644364707754;
        Tue, 08 Feb 2022 15:58:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm6748208pgv.15.2022.02.08.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:58:27 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:58:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v7 7/8] fortify: Make sure strlen() may still be used as
 a constant expression
Message-ID: <202202081555.ED0C0658@keescook>
References: <20220208225350.1331628-1-keescook@chromium.org>
 <20220208225350.1331628-8-keescook@chromium.org>
 <CAKwvOd=wre3uzFVBFaOs4Oud+SobxiW_BwKXMsa5p0tEy6BsiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=wre3uzFVBFaOs4Oud+SobxiW_BwKXMsa5p0tEy6BsiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 08, 2022 at 03:17:13PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for enabling Clang FORTIFY_SOURCE support, redefine
> > strlen() as a macro that tests for being a constant expression
> > so that strlen() can still be used in static initializers, which is
> > lost when adding __pass_object_size and __overloadable.
> >
> > An example of this usage can be seen here:
> >         https://lore.kernel.org/all/202201252321.dRmWZ8wW-lkp@intel.com/
> >
> > Notably, this constant expression feature of strlen() is not available
> > for architectures that build with -ffreestanding. This means the kernel
> > currently does not universally expect strlen() to be used this way, but
> > since there _are_ some build configurations that depend on it, retain
> > the characteristic for Clang FORTIFY_SOURCE builds too.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fortify-string.h | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index db1ad1c1c79a..f77cf22e2d60 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _LINUX_FORTIFY_STRING_H_
> >  #define _LINUX_FORTIFY_STRING_H_
> >
> > +#include <linux/const.h>
> > +
> >  #define __FORTIFY_INLINE extern __always_inline __gnu_inline
> >  #define __RENAME(x) __asm__(#x)
> >
> > @@ -95,9 +97,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
> >         return ret;
> >  }
> >
> > -/* defined after fortified strnlen to reuse it. */
> > +/*
> > + * Defined after fortified strnlen to reuse it. However, it must still be
> > + * possible for strlen() to be used on compile-time strings for use in
> > + * static initializers (i.e. as a constant expression).
> > + */
> > +#define strlen(p)                                                      \
> > +       __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
> 
> Is `__is_constexpr(p) == __is_constexpr(__builtin_strlen(p))`? i.e.
> can we drop the first `__builtin_strlen`? It seems redundant.
> 
> So instead, we'd have:
> 
> #define strlen(p) __builtin_choose_expr(__is_constexpr(p),
> __builtin_strlen(p), __fortify_strlen(p))
> 
> Or is there some funny business where p isn't constexpr but strlen(p)
> somehow is? I doubt that.  (Or is it that p is constexpr, but
> strlen(p) is not?)
> 
> (Guess I'm wrong: https://godbolt.org/z/19ffz7vjx)

Yeah, as you've discovered ... funny business. :P

> Ok then.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-- 
Kees Cook
