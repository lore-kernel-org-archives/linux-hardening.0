Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE7C77B6C
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 22:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjDFW5m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjDFW5k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 18:57:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F15594
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 15:57:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso87988pjm.3
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680821859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3GKUQjQbagpE6YHTTFKMOdYbnnJw+93fjlpuKePTGp4=;
        b=BnUl7njLD5FTU7/4mu5GqRsMACbCcdSoroWoOj7MBjrFNfCwzY7gVeRA5T48LDVjko
         +NJyReBzh8vH2rtR//8/zxIhRUhXIbjiX5ICtFuIBtz4lv9clgdSs3+BdkiL1JoRdVb2
         i1IHidb1Rj4MKWEt36IJCcDhY6GNVoJ1wbN1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GKUQjQbagpE6YHTTFKMOdYbnnJw+93fjlpuKePTGp4=;
        b=fNcTbOP+P6Gfn0MEXNj/UxG6AofurBYOIgEUIbl7bOvAx1VZL2O/3QQuwlIE0HXqiH
         n9Q0C/gSE7ht2fFtccFKqhRHojanhUIbWgfTv5WtXqMj+YrdsCHDKtZcTnbcw4s6dFoj
         36fxYgwPlASUzaUIsfvc5IecMauAJEVbcETnBSer/0HB3EOQMHtx69qZv4SPXnnSOW2P
         Ft5EyVxT0lHDHhn9apOtmBA/OZf4Re2wULpmdaaZNlwp+CP4/A/DLLhHJwQOhmqHBim6
         DrCnVM8pjnuNUV4n1ioF41FGky1VIDykISG1SH9WGcpR2lz/+lwHdxeumxG6JCEBamIG
         pViw==
X-Gm-Message-State: AAQBX9esrLHcCoLf5SIR1xyaATcqsNexVBMoonUGUwJ5ZR1MJ/scUMqI
        qKBUJ4x9koG2f+PcFzZGzqCg+Q==
X-Google-Smtp-Source: AKy350YyOPIqIP+baKYuUtYZr4axPZY8DTucdHt1X5A+hsmOgIFnvGFKt3oLkFSEwe1HOByoBgFzrw==
X-Received: by 2002:a17:90b:164f:b0:240:67d5:aea1 with SMTP id il15-20020a17090b164f00b0024067d5aea1mr246700pjb.14.1680821858773;
        Thu, 06 Apr 2023 15:57:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mr23-20020a17090b239700b0023f9782333fsm1684277pjb.13.2023.04.06.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:57:38 -0700 (PDT)
Message-ID: <642f4e62.170a0220.1f11f.36df@mx.google.com>
X-Google-Original-Message-ID: <202304061554.@keescook>
Date:   Thu, 6 Apr 2023 15:57:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string
 pointer
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-6-keescook@chromium.org>
 <CAHp75Vf-nG865UwbVjwFjVTtXA7mAdi4FfKCpTHDx55eFnbvAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf-nG865UwbVjwFjVTtXA7mAdi4FfKCpTHDx55eFnbvAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 06, 2023 at 01:20:52PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 6, 2023 at 3:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for KUnit testing and further improvements in fortify
> > failure reporting, split out the report and encode the function and
> > access failure (read or write overflow) into a single int argument. This
> > mainly ends up saving some space in the data segment. For a defconfig
> > with FORTIFY_SOURCE enabled:
> >
> > $ size gcc/vmlinux.before gcc/vmlinux.after
> >    text           data     bss     dec              hex filename
> > 26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.before
> > 26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after
> 
> ...
> 
> > +       const char *name;
> > +       const bool write = !!(reason & 0x1);
> 
> Perhaps define that as
> 
> FORTIFY_READ_WRITE  BIT(0)
> FORTIFY_FUNC_SHIFT  1
> 
> const bool write = reason & FORTIFY_READ_WRITE; // and note no need for !! part

Yeah, that reads better. The FIELD_GET suggestion down-thread is
probably how I'll go.

> 
> switch (reason >> FORTIFY_FUNC_SHIFT) {
> 
> > +       switch (reason >> 1) {
> > +       case FORTIFY_FUNC_strncpy:
> > +               name = "strncpy";
> > +               break;
> > +       case FORTIFY_FUNC_strnlen:
> > +               name = "strnlen";
> > +               break;
> > +       case FORTIFY_FUNC_strlen:
> > +               name = "strlen";
> > +               break;
> > +       case FORTIFY_FUNC_strlcpy:
> > +               name = "strlcpy";
> > +               break;
> > +       case FORTIFY_FUNC_strscpy:
> > +               name = "strscpy";
> > +               break;
> > +       case FORTIFY_FUNC_strlcat:
> > +               name = "strlcat";
> > +               break;
> > +       case FORTIFY_FUNC_strcat:
> > +               name = "strcat";
> > +               break;
> > +       case FORTIFY_FUNC_strncat:
> > +               name = "strncat";
> > +               break;
> > +       case FORTIFY_FUNC_memset:
> > +               name = "memset";
> > +               break;
> > +       case FORTIFY_FUNC_memcpy:
> > +               name = "memcpy";
> > +               break;
> > +       case FORTIFY_FUNC_memmove:
> > +               name = "memmove";
> > +               break;
> > +       case FORTIFY_FUNC_memscan:
> > +               name = "memscan";
> > +               break;
> > +       case FORTIFY_FUNC_memcmp:
> > +               name = "memcmp";
> > +               break;
> > +       case FORTIFY_FUNC_memchr:
> > +               name = "memchr";
> > +               break;
> > +       case FORTIFY_FUNC_memchr_inv:
> > +               name = "memchr_inv";
> > +               break;
> > +       case FORTIFY_FUNC_kmemdup:
> > +               name = "kmemdup";
> > +               break;
> > +       case FORTIFY_FUNC_strcpy:
> > +               name = "strcpy";
> > +               break;
> > +       default:
> > +               name = "unknown";
> > +       }
> 
> ...
> 
> > +       WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write" : "read");
> 
> Using str_read_write() ?
> 
> Dunno if it's already there or needs to be added. I have some patches
> to move those str_*() to string_choices.h. We can also prepend yours
> with those.

Oh! Hah. I totally forgot about str_read_write. :) I will use that.

-- 
Kees Cook
