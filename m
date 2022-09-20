Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F7C6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Sep 2022 22:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiITWa2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiITWaN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Sep 2022 18:30:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37B5A2D2
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 15:30:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv3so4623019pjb.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UKSxoUS6VIIzYKH+SpWnYbcBjXQY18rL+go3ruU7WuU=;
        b=mIaOZseZxPFYE7/aRWOFcv08907GUG3l11RDeJ2wt/jehjgBt6artQamEbtyQH1ZRm
         3jFv0XgpJKt5zodkBnDn9Wkweya3Z4Sh3C1HN6abjs/OW2G5O5wJsUDFcOzKWO1nBDI9
         7tznOJkRlVwBz3YBT5sZHkjW2Gv22da35bQpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UKSxoUS6VIIzYKH+SpWnYbcBjXQY18rL+go3ruU7WuU=;
        b=D2BH2DHJJlBVpjjJSojaFBl3mayP2vZtEOp1ctzMcud3zaW1aeg+kPM84n11G0EsYp
         j+rQcb7mpqvmcQWqLlr4xGb6Bl9sDB19Iz0/ZKOI93BiSwl7chaO6U/0FjNVriAUuZ0O
         O4PXjhDdrGF2f7x6UtlFQQmj6fPogZ8mBtofY1xi0ExnLa7d4pVQ1w6m6Wjt+S9JApQY
         hfxNPxCtXuisehye3yV9aima4oG8kZ66VnF6oV07LCDf0/40lX92XsLyBwsDFbfe4nM/
         fS2Jb1AV0y2vzYCXU04heepvw7bpVMBRZ0B6HW+aPJulorSXRRQd93ldqtGCjK0ttukz
         qkVw==
X-Gm-Message-State: ACrzQf2LGZe/co1gEjSdHVGVCi4Vs8i3ZLyvmrYGtrDgsqppkBbCRO+g
        6s8UE6+7zuqAdJytid8pALC28A==
X-Google-Smtp-Source: AMsMyM7Big1rXY5V8NOkfR0/wd1kVaVTiOspSsPtjj1lkkWdxfTbJIOrY4rgVzo3lyyMmp7nuIw2Hw==
X-Received: by 2002:a17:903:120d:b0:178:a6ca:b974 with SMTP id l13-20020a170903120d00b00178a6cab974mr1741323plh.8.1663713007080;
        Tue, 20 Sep 2022 15:30:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090a73cf00b0020063e7d63asm436074pjk.30.2022.09.20.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:30:06 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:30:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dev@der-flo.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] x86/uaccess: Avoid check_object_size() in
 copy_from_user_nmi()
Message-ID: <202209201529.D90CDD898@keescook>
References: <20220919201648.2250764-1-keescook@chromium.org>
 <CAOUHufZpan+wVO7tHgMOkX--0JGhv-mqj2Y+QQKRB4GAGSR18w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZpan+wVO7tHgMOkX--0JGhv-mqj2Y+QQKRB4GAGSR18w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 20, 2022 at 04:23:00PM -0600, Yu Zhao wrote:
> On Mon, Sep 19, 2022 at 2:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
> > designed to skip any checks where the length is known at compile time as
> > a reasonable heuristic to avoid "likely known-good" cases. However, it can
> > only do this when the copy_*_user() helpers are, themselves, inline too.
> >
> > Using find_vmap_area() requires taking a spinlock. The check_object_size()
> > helper can call find_vmap_area() when the destination is in vmap memory.
> > If show_regs() is called in interrupt context, it will attempt a call to
> > copy_from_user_nmi(), which may call check_object_size() and then
> > find_vmap_area(). If something in normal context happens to be in the
> > middle of calling find_vmap_area() (with the spinlock held), the interrupt
> > handler will hang forever.
> >
> > The copy_from_user_nmi() call is actually being called with a fixed-size
> > length, so check_object_size() should never have been called in
> > the first place. Given the narrow constraints, just replace the
> > __copy_from_user_inatomic() call with an open-coded version that calls
> > only into the sanitizers and not check_object_size(), followed by a call
> > to raw_copy_from_user().
> >
> > Reported-by: Yu Zhao <yuzhao@google.com>
> > Link: https://lore.kernel.org/all/CAOUHufaPshtKrTWOz7T7QFYUNVGFm0JBjvM700Nhf9qEL9b3EQ@mail.gmail.com
> > Reported-by: dev@der-flo.net
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Fixes: 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: drop the call explicitly instead of using inline to do it
> > v1: https://lore.kernel.org/lkml/20220916135953.1320601-1-keescook@chromium.org
> > ---
> >  arch/x86/lib/usercopy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
> > index ad0139d25401..d2aff9b176cf 100644
> > --- a/arch/x86/lib/usercopy.c
> > +++ b/arch/x86/lib/usercopy.c
> > @@ -44,7 +44,8 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
> >          * called from other contexts.
> >          */
> >         pagefault_disable();
> > -       ret = __copy_from_user_inatomic(to, from, n);
> > +       instrument_copy_from_user(to, from, n);
> 
> Got a build error on top of mm-unstable:
> 
> arch/x86/lib/usercopy.c:47:2: error: call to undeclared function
> 'instrument_copy_from_user'; ISO C99 and later do not support implicit
> function declarations [-Wimplicit-function-declaration]
>         instrument_copy_from_user(to, from, n);
>         ^
> arch/x86/lib/usercopy.c:47:2: note: did you mean 'instrument_copy_to_user'?
> ./include/linux/instrumented.h:117:1: note: 'instrument_copy_to_user'
> declared here
> instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> ^
> 1 error generated.

Hm, I did test builds of this before sending. I wonder why this passed
for me. I suppose this is needed explicitly in arch/x86/lib/usercopy.c:

#include <linux/instrumented.h>

?

-- 
Kees Cook
