Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF9CC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6544C610EA
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJFDY0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJFDY0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:24:26 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F33C06174E
        for <linux-hardening@vger.kernel.org>; Tue,  5 Oct 2021 20:22:34 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id x207so620790vke.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfp9VlLBc+DNVBQ774WyK5TigN2C4A/ShHU2p0epUU0=;
        b=LEjhlPYFjHruDYTUsq4TurbaNHPfy0KMlbnG7yN7hQLa/EmdfS12RnJ7uLPZa3yq/M
         Eoosy7S4MBCxCKB6G1ghYGyeYDaMmVmwmrOevJb5H4FC4oPnMrPc+qVbbrPLuaRI5ZpM
         ZL9/jczOedY4f2RBqj79ZG/+g9Vn8EHry3rhWwV6hQ7tJfBaoNQBh/Ix6ZDhnG/ikqFj
         /5mdSRbQin12U/GWL6hNKbI6yE1UYzEQV3MAaQvRtmeC/r81lzzlm95fsKuC0sHVYjfv
         pwd3/aU4KkrGekqJ5t3P+uiEiBHoe6DIoDv/+SR8kEOYr+QLs1S89BfLTwg0DoXiCpes
         2TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfp9VlLBc+DNVBQ774WyK5TigN2C4A/ShHU2p0epUU0=;
        b=Uyqmhn9Qj747UE8mTJcwXArck2bVEF9CImWqUHJe94igcG/fNUWMQ4R/vkAQkSMlPw
         Bq+5bbgEKkzmofTq0svOQYzSYY9dD3kKRzlgrfOR+o/Exg8z0IFE7DDJddC4IzDVsYKO
         cUWlCRcnL1TFR+O3qMtQRwDP7VPXLiFFOrBu8CSm+BlOxfiSnQLBNyGmIto7/CGIs/OO
         8fJFEv5qRvB0eH/kh1oeBrqvQ9pEdvQjdDZ3OnxO6AMBDyrA+JP+8tc7h8GenYn+iE4F
         3S+h7eOURd2OT3TnKTvcbgAlAihhB/aJferh3lqobtoOEwx9Jp1OVU696jU9PRlSFCfo
         BUZQ==
X-Gm-Message-State: AOAM531ZUMnNQ4/u3mSyAXhLfiOVK6eisAuCm5ftbC7zi/csyfYdD4ca
        Cl/KsQJ+TrxAniWUw1tX0INwPiN59uwIFLFBlXBfiQ==
X-Google-Smtp-Source: ABdhPJy9/Z43W2gW52EvzL7JzL8egBStaTb8m7rfiY4IGL09hpUTl1McOdlKXhKzRV+JUKpI7YYGufDTZeLOLeEMzK8=
X-Received: by 2002:a05:6122:201f:: with SMTP id l31mr4854778vkd.22.1633490553254;
 Tue, 05 Oct 2021 20:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222704.2631604-1-keescook@chromium.org>
 <20210930222704.2631604-5-keescook@chromium.org> <20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org>
 <202110052002.34E998B@keescook>
In-Reply-To: <202110052002.34E998B@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Oct 2021 05:22:06 +0200
Message-ID: <CAG48ez19raco+s+UF8eiXqTvaDEoMAo6_qmW2KdO24QDpmZpFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] slab: Add __alloc_size attributes for better
 bounds checking
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 6, 2021 at 5:06 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Oct 05, 2021 at 06:47:17PM -0700, Andrew Morton wrote:
> > On Thu, 30 Sep 2021 15:27:00 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> > > As already done in GrapheneOS, add the __alloc_size attribute for regular
> > > kmalloc interfaces, to provide additional hinting for better bounds
> > > checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> > > optimizations.
> >
> > x86_64 allmodconfig:
>
> What compiler and version?
>
> >
> > In file included from ./arch/x86/include/asm/preempt.h:7,
> >                  from ./include/linux/preempt.h:78,
> >                  from ./include/linux/spinlock.h:55,
> >                  from ./include/linux/mmzone.h:8,
> >                  from ./include/linux/gfp.h:6,
> >                  from ./include/linux/mm.h:10,
> >                  from ./include/linux/mman.h:5,
> >                  from lib/test_kasan_module.c:10:
> > In function 'check_copy_size',
> >     inlined from 'copy_user_test' at ./include/linux/uaccess.h:191:6:
> > ./include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >   213 |    __bad_copy_to();
> >       |    ^~~~~~~~~~~~~~~
> > In function 'check_copy_size',
> >     inlined from 'copy_user_test' at ./include/linux/uaccess.h:199:6:
> > ./include/linux/thread_info.h:211:4: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small
> >   211 |    __bad_copy_from();
> >       |    ^~~~~~~~~~~~~~~~~
> > make[1]: *** [lib/test_kasan_module.o] Error 1
> > make: *** [lib] Error 2
>
> Hah, yes, it caught an intentionally bad copy. This may bypass the
> check, as I've had to do in LKDTM before. I will test...
>
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index 7ebf433edef3..9fb2fb2937da 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -19,7 +19,12 @@ static noinline void __init copy_user_test(void)
>  {
>         char *kmem;
>         char __user *usermem;
> -       size_t size = 128 - KASAN_GRANULE_SIZE;
> +       /*
> +        * This is marked volatile to avoid __alloc_size()
> +        * noticing the intentionally out-of-bounds copys
> +        * being done on the allocation.
> +        */
> +       volatile size_t size = 128 - KASAN_GRANULE_SIZE;

Maybe OPTIMIZER_HIDE_VAR()? The normal version of that abuses an empty
asm statement to hide the value from the compiler.
