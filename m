Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF88C77B6C
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 22:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbjDFWyk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDFWyh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 18:54:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93095FE1
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 15:54:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so42007709pjl.4
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680821676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddhR6+oUYGca7zw93PItA+MSDwJf6Lso9EL7yAdWkX4=;
        b=P1Ugi1b6Xxzzuet4IzuM3ZjbAvbQhOrx+V7wtelYwAmZmNsjfDcOhkg7hmjW5yzSGW
         EgFmzT6tbS7Cr6Uowxz4tTS/SloYuoWFdqz0gye2pdV3Z5TF+YRH14OFtu9rD/zEYYuV
         9C2dIBBQVH0Tfo6vSKuYEYGOqP2mLoxiGDZ24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddhR6+oUYGca7zw93PItA+MSDwJf6Lso9EL7yAdWkX4=;
        b=znnECSu+XtEG4Wbi/MyAY1pIoQnwKti9Z4GLwuMSnNBFjqFa9h+t58DxpwwlO8fDpA
         O0jdOzeBI7cQSi8gmff+iQdiQcf4RiovFZ7n868HrCHnVZEslECu2M6ixRAzDCFUBwrk
         XhRsPNN/v1BT3Y2z7MhgWXGfFg7V+jFgZUaPhCgcQAxNFI9XOW0pHeXFhRc6CIYwVEM2
         cX3BWP7gHpS34vYGNUESsix6agHtQYvtioi0e6M5O2nWeWx9Vdhm0ljEDeBgnE108hRO
         +QOlAC/p+PFoAes0Z5px/JKcwlOP28T4U6/O+LjC9QbsNw5yDxKOdn1ckoG6de0QA0EO
         Oo7g==
X-Gm-Message-State: AAQBX9ebiJob4IRDsn7wjTYFBkFx42PSmLaBgXPou2od+GzsxYkTnKMv
        ihvtxWBWHSq4IwQeToM6LFp0nQ==
X-Google-Smtp-Source: AKy350ZLZEGz7zbNaIteL6wjM9WlP82hiJ35jClrdUnQuyiZPe+d8X/8wfsWNVUUEmKQR0izFhHdZw==
X-Received: by 2002:a17:90b:4a83:b0:236:99c4:6096 with SMTP id lp3-20020a17090b4a8300b0023699c46096mr156831pjb.35.1680821676418;
        Thu, 06 Apr 2023 15:54:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n32-20020a17090a2ca300b00227223c58ecsm1626609pjd.42.2023.04.06.15.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:54:35 -0700 (PDT)
Message-ID: <642f4dab.170a0220.97691.39c9@mx.google.com>
X-Google-Original-Message-ID: <202304061554.@keescook>
Date:   Thu, 6 Apr 2023 15:54:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
 <CANiq72=Awa4B1qL+Zdkuj1-EX+Tv=fK=pRM_DMdYCDmByEVOHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=Awa4B1qL+Zdkuj1-EX+Tv=fK=pRM_DMdYCDmByEVOHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 06, 2023 at 03:44:54PM +0200, Miguel Ojeda wrote:
> On Thu, Apr 6, 2023 at 2:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +void __fortify_report(u8 reason);
> > +void __fortify_panic(u8 reason) __cold __noreturn;
> 
> (snip)
> 
> > +void __fortify_report(u8 reason)
> 
> (snip)
> 
> > +void __fortify_panic(const u8 reason)
> 
> I am curious: for some reason (no pun intended :) the `reason`s above
> are not `const` except this one, but then in a later patch they become
> `const` (including the declarations).
> 
> So perhaps make everything `const` when they are introduced? Or is
> there some other reason? (e.g. I saw one patch that moved a function,
> so there it seemed to make sense to keep things as they are to make
> the copy 1:1).

I will adjust it -- this was an artifact of splitting up my patches.

Thanks!

-- 
Kees Cook
