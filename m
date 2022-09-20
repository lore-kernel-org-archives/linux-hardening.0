Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E40C6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Sep 2022 22:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiITWXl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiITWXk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Sep 2022 18:23:40 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6CF5283B
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 15:23:38 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m66so4737049vsm.12
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Bmjjq9da2ZZQv+bFqrfQD4q9L5cTlcfvUlJYV0gue+Q=;
        b=kC8GcBSEzpY3ni0r7gLE0rdV1zCZyCYXgZWHDP/hxtmnrW1WDQxRM4VqgQpe8y0TKO
         zjCJFs2v9gY50RO00olwxtS7GsFOLaTahcZ1RnjMTUIcM/ilbRKt8h6olpkh2HHEBomD
         LuD3AUSauSkc56m9cM7q8UrSV7BHKxlmClLls40HrJdDYwICXqCIGDj2he6rM4xrg7Lx
         Q26JxSbuymA2G8s94MT1OjHrfBWD6PUona0GuUuu6rWvXM+bDppNwd2ickOKoGXKwwUh
         r8Pg/Dj2bxtbu65OSsbCfFhK8hIlGXLGLbdAKoJ5kglB2scI+H5/pUt2e28k3saBXBqz
         np3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bmjjq9da2ZZQv+bFqrfQD4q9L5cTlcfvUlJYV0gue+Q=;
        b=j8J0qGN8UrFIJM21ZQDh2M/dHzgTlQExEKxSgmvmnQMijReE435DDh9DNuGF8MoyA6
         bv2PrB9yBAjMwaDJzLSaRUnDGJja8mITGG4qy/uT9UhzX/PWsnT2TdDg2SdEnPAgdhAu
         gPaCF+bIRD2GTDX8LgmaP2FPWeT5CcgnljBAxf7iru89ITDSFNrGlRmNs6Kev++twjix
         l/p9ac+1qGbrHrsOQl/LIa40KxAPY9zmprFTSldnWDZmg7h8G3X3i56d3ALyFhfTXIhF
         VCVBmV6EgMBEMNvTZeFAKTEoPk2GtKseWXY3TIZqGFHWtnGh+WOTSWvgaLfSizJNxU2Y
         NLbw==
X-Gm-Message-State: ACrzQf3yW00K5J/KRHGNvqj85jUy4mrJbk3e2ZoaiGTUhVgOHEZmUbZt
        rDWxbUFvC3Tqk3wMoNxoPle2Ooefc0vy9HAmaU8pKg==
X-Google-Smtp-Source: AMsMyM7Vf/QRcnAyBz+54K5dEI3RtDnKBzaPFQ0uwrc7uBvxnfJRLEgGe8C4ePJRpBzkc96kaDDLlRGb1AzNpRFIiK8=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr5799386vse.9.1663712617046; Tue, 20 Sep
 2022 15:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220919201648.2250764-1-keescook@chromium.org>
In-Reply-To: <20220919201648.2250764-1-keescook@chromium.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 20 Sep 2022 16:23:00 -0600
Message-ID: <CAOUHufZpan+wVO7tHgMOkX--0JGhv-mqj2Y+QQKRB4GAGSR18w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/uaccess: Avoid check_object_size() in copy_from_user_nmi()
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, dev@der-flo.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        stable <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 19, 2022 at 2:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
> designed to skip any checks where the length is known at compile time as
> a reasonable heuristic to avoid "likely known-good" cases. However, it can
> only do this when the copy_*_user() helpers are, themselves, inline too.
>
> Using find_vmap_area() requires taking a spinlock. The check_object_size()
> helper can call find_vmap_area() when the destination is in vmap memory.
> If show_regs() is called in interrupt context, it will attempt a call to
> copy_from_user_nmi(), which may call check_object_size() and then
> find_vmap_area(). If something in normal context happens to be in the
> middle of calling find_vmap_area() (with the spinlock held), the interrupt
> handler will hang forever.
>
> The copy_from_user_nmi() call is actually being called with a fixed-size
> length, so check_object_size() should never have been called in
> the first place. Given the narrow constraints, just replace the
> __copy_from_user_inatomic() call with an open-coded version that calls
> only into the sanitizers and not check_object_size(), followed by a call
> to raw_copy_from_user().
>
> Reported-by: Yu Zhao <yuzhao@google.com>
> Link: https://lore.kernel.org/all/CAOUHufaPshtKrTWOz7T7QFYUNVGFm0JBjvM700Nhf9qEL9b3EQ@mail.gmail.com
> Reported-by: dev@der-flo.net
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Fixes: 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: drop the call explicitly instead of using inline to do it
> v1: https://lore.kernel.org/lkml/20220916135953.1320601-1-keescook@chromium.org
> ---
>  arch/x86/lib/usercopy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
> index ad0139d25401..d2aff9b176cf 100644
> --- a/arch/x86/lib/usercopy.c
> +++ b/arch/x86/lib/usercopy.c
> @@ -44,7 +44,8 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
>          * called from other contexts.
>          */
>         pagefault_disable();
> -       ret = __copy_from_user_inatomic(to, from, n);
> +       instrument_copy_from_user(to, from, n);

Got a build error on top of mm-unstable:

arch/x86/lib/usercopy.c:47:2: error: call to undeclared function
'instrument_copy_from_user'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
        instrument_copy_from_user(to, from, n);
        ^
arch/x86/lib/usercopy.c:47:2: note: did you mean 'instrument_copy_to_user'?
./include/linux/instrumented.h:117:1: note: 'instrument_copy_to_user'
declared here
instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
^
1 error generated.
