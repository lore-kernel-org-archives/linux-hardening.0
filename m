Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1BC433FE
	for <linux-hardening@archiver.kernel.org>; Sun, 30 Jan 2022 20:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbiA3Ueo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 30 Jan 2022 15:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiA3Uen (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 30 Jan 2022 15:34:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF76C06173B
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 12:34:43 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k17so10815847plk.0
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7IOZHCJNZdVLsKlAN8UmMORGXdNGmY4XG9mnrfmJGuw=;
        b=QV4Fu43qCgBQrge/+g0f+BFyeec7tqd+zZb+KsIVqjyPa2+8KTmQsBjFmKMa4GKe40
         l+YCP1RGk7CDYKX/F/bBg6XL0WJ5kED64GEhx7PaLymQi5WSoZ1ByUuhZ4/TEM/59JKP
         FdbOeQ1g4JR2P9So2fmDn2lkxdqRX/5OPsoX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IOZHCJNZdVLsKlAN8UmMORGXdNGmY4XG9mnrfmJGuw=;
        b=SGtzxHtvcb5JF8XKhpFopxS/qjHL08RzgHWUJV85VL/7DPzEuKyidkQfbMBkm7PBzx
         DWx+zEEVrfrfSBO54wfGfceAFMdt++W5+e4LZvW4TFXykDK8XlKayN7M9DMt8iG86E4M
         X+3wDZbXP0Ae1QbEVOsb/AtU0uelk/GTNzZf+NXUySleYndk7JYjJFlNWEyzS5E5toky
         w/8sYMoZlTswAwCeIwOK2SG3+oYSpIpGCXDrn0PO7ItHRBpOI3dwEkPGAxWD4tyBBp20
         ld8RYvHBeQyDDN98wyv378bVh8SYyg6qUgTkNuXzCBfiedooIkHyxRShCxEJTY2kKWpu
         xESg==
X-Gm-Message-State: AOAM530C+zIMofjYo9JHv+HSm6OV9jh9cbFaoSpekOpLgdyBxUyidagj
        TBPq/Oe9JM572nBMo4rSPHEopg==
X-Google-Smtp-Source: ABdhPJw4yBDg3uS7cAcZfMh1IewxVhrjRAZxYuWwvIIw8kVlS7S/z6VsdX895ZYK9QDlZEQDnCeZAg==
X-Received: by 2002:a17:902:758c:: with SMTP id j12mr17852607pll.34.1643574882799;
        Sun, 30 Jan 2022 12:34:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm9157814pfl.71.2022.01.30.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:34:42 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:34:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202201301220.529465D6@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <CAHp75Vf9S8jKQGAYRrmSET7YJQNoHMzUC6VVTAOT7DbwcCcc4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf9S8jKQGAYRrmSET7YJQNoHMzUC6VVTAOT7DbwcCcc4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 30, 2022 at 08:56:40PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 8:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Add a simple test for strlen() functionality, including using it as a
> > constant expression.
> 
> ...
> 
> > +/*
> > + * Unlike many other string functions, strlen() can be used in
> > + * static initializers when string lengths are known at compile
> > + * time. (i.e. Under these conditions, strlen() is a constant
> > + * expression.) Make sure it can be used this way.
> > + */
> > +static const int strlen_ce = strlen("tada, a constant expression");
> 
> So, the compiler will replace this by a constant and then eliminate
> the condition completely from the code. Did I understand this
> correctly?

Yup! See: https://godbolt.org/z/nTqPaszTh

There a few rare places in the kernel that do this, which is how
I noticed. (I broke strlen() with the recent FORTIFY changes.)

> > +static __init int strlen_selftest(void)
> > +{
> > +       /* String length ruler:         123456789012345 */
> > +       static const char normal[]   = "I am normal";
> > +       static const char *ptr       = "where do I go?";
> > +       static const char trailing[] = "hidden NULLs\0\0\0";
> > +       static const char leading[]  = "\0\0hidden text";
> > +
> > +       if (strlen(normal) != 11)
> > +               return 0x100001;
> > +       if (strlen(ptr++) != 14)
> > +               return 0x100002;
> > +       if (strlen(ptr++) != 13)
> > +               return 0x100003;
> > +       if (strlen(trailing) != 12)
> > +               return 0x100004;
> > +       if (strlen(leading) != 0)
> > +               return 0x100005;
> 
> > +       if (strlen_ce != 27)
> > +               return 0x100006;
> 
> ...so this part won't ever appear in the assembly (assuming -O2).

Correct, unless strlen() breaks.

> Same to the rest? If so, why is this not a part of the compiler tests?

I wanted to keep everything together -- this includes a macro
side-effect test as well ("ptr++").

-Kees

-- 
Kees Cook
