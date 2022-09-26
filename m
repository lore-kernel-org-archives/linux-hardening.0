Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F547C6FA82
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 20:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIZURd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIZURd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 16:17:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69CA3457
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 13:17:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so7562092pgs.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LBF//pAX5WHcz7xdaQr4Nf4d4GrRr37crvjLDzbblIk=;
        b=Bji77umcsdJeihjx85Wx1yJAb732Oz1ZA1q21x7/tJcnTUW/8fZte+SBOWKRr2y2X4
         t7UYhPhE3DC/SUmvxlRXNayEpDUn6fkDZy7UDvvNDbtu4owhre655mCikZL0f8jsHtqv
         cGn9ctLsI5otDOKjNY0EQMprAXB1loNeikeBDNXuhf21Gc6YNSGymHqhwg97uF5tGFMe
         IZ94nsGJZnj+0Ru0uhnDDrRz3FETUQWktqxCIkpnHZcyY5l8qG/NsoDS/+XHrgbZsJr4
         SbniuV3EE/E7bFBu3CiLO4p6FpJn/FlCsxGzzDKgRIkz5AdRBT3N+leywHBff6krEQW8
         RNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LBF//pAX5WHcz7xdaQr4Nf4d4GrRr37crvjLDzbblIk=;
        b=M5PzyFgt8bY3GG9offM5AXNAdIktVeU1LU2g1feCe7Bb/lu0qdOePgejl3RHfszWXY
         AGzVn4JmY+pNzo00CWuth4ANkLXaYzAVsupW+bFzwRyuRSngSX726vvx/Duu8zKgEfFn
         oTiBlg1R12G+h1lKwEGf57dehv04c7x0bgOAiWLZ27dObyzlE5i7xHt16iHmSyc5J5nu
         5GSWR1jUmmhGcohqf2w/n95EfNCbCcALKfkNvQ6Ym2Mg62WqO5sgGQ9VlfCkTOf+5pFh
         nlwoqe/pps/FkjmJJPy/T3PHLy5QkBkHnAZtBeMBMjsARzqazbUWwY6yC96oQagxyAdp
         +haA==
X-Gm-Message-State: ACrzQf1OEB9zPdmn17sn+pfCc8JKTc4Zvsexo7cLzyZQRkDNEPRMv6Tg
        cNeR7IqveKiuGXYG435RyjThiXCyRA2p4rR1iFYg1g==
X-Google-Smtp-Source: AMsMyM5Uwpd0MxiH9sRDQzapR2kQfL6PV2oxZumBsqYgeO5TWDHdWVPWGZZxNuX11VhdUYgOQnkrigoKWNVoBnjDEtY=
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id
 s201-20020a632cd2000000b0041c590167d8mr21300624pgs.365.1664223450163; Mon, 26
 Sep 2022 13:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220926191109.1803094-1-keescook@chromium.org>
In-Reply-To: <20220926191109.1803094-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 13:17:18 -0700
Message-ID: <CAKwvOdmCjAQpaF40VStbFNf1ZqmTxTTZzy2v4TwSF0LVO08GYw@mail.gmail.com>
Subject: Re: [PATCH v2] overflow: Introduce overflows_type() and castable_to_type()
To:     Kees Cook <keescook@chromium.org>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-sparse@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

+ Arnd

On Mon, Sep 26, 2022 at 12:11 PM Kees Cook <keescook@chromium.org> wrote:
> ---
> v2:
>  - fix comment typo
>  - wrap clang pragma to avoid GCC warnings
>  - style nit cleanups
>  - rename __castable_to_type() to castable_to_type()
>  - remove prior overflows_type() definition
> v1: https://lore.kernel.org/lkml/20220926003743.409911-1-keescook@chromium.org
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index f385ca652b74..fffc3f86181d 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,6 +16,11 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>
> +/* We're expecting to do a lot of "always true" or "always false" tests. */
> +#ifdef CONFIG_CC_IS_CLANG
> +#pragma clang diagnostic ignored "-Wtautological-constant-out-of-range-compare"
> +#endif

Any chance we can reuse parts of __diag_ignore or __diag_clang from
include/linux/compiler_types.h or include/linux/compiler-clang.h
respectively?

Those are needed for pragmas within preprocessor macros, which we
don't have here, but I suspect they may be more concise to use here.

> +#define TEST_SAME_TYPE(t1, t2, same)                   do {    \
> +       typeof(t1) __t1h = type_max(t1);                        \
> +       typeof(t1) __t1l = type_min(t1);                        \
> +       typeof(t2) __t2h = type_max(t2);                        \
> +       typeof(t2) __t2l = type_min(t2);                        \

Can we use __auto_type here rather than typeof(macro expansion)?
-- 
Thanks,
~Nick Desaulniers
