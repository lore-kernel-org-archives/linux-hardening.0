Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D6C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750F060C4B
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 09:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBJys (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKBJyn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 05:54:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F75C061714
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 02:52:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k1so5974827ilo.7
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2nGFtzDaXHyeOZl97W40HgCMEByRYpy5y6YeQ7i06E=;
        b=U7cr5ih4yEnzRsMP9dz4FZ+o2tbuJF1cO1WaSNg8J/rnIZIFp+gs7+mYsvlz9bcPxt
         gWdgCSLK9JuqJU3g6i4X4FqR77+sAP8Rqt5EdZulsRLZCHKxt9ExM/m8uRK+nRsB8fDK
         Z9xVbYpTwYjdLJLNaDlqtTkoOnffkZzUmEI7T/HaNxpQfTPxroweaYyQYMiHH66x1h5d
         aMwSNjdS4/MU/67XsGBJqVb/5aqTWT7APSwNW3uC4BB8i16/hMDUC4UD9Dpty0vnWndN
         V3awWhGJkoFEx1iq2AtXoT5wdAA8/EQpIPiDHR40MY17Veui2UKVZito8Bw0chDc8xSI
         wXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2nGFtzDaXHyeOZl97W40HgCMEByRYpy5y6YeQ7i06E=;
        b=14Av/cRJBN1TkZqy7QBPpIucAsLXlueLPpTYgx6/3Wara+XbxKATdm9F/FsueR4Avy
         EbXNXsqgK72FLwyxF3/B58orYXiDyAfU4LLcDXGJ/dLtFvJsYvvX5U9wlPJirAp/uMBH
         TgdrcbYK8K8R6F4Ty+Y8qbV5chhcNH02P+R5EhKRA89h5rp6Fz3iqWkrWKyv248jleLs
         H/yA6jU4j2Df9+QPlK9lTpn6AsNWeqzecJ7IAix+fQnYesYPvMJQHrDKvP1pHxKxLt4x
         tRk97V/r5hHDSyYgg/t2voMnQGvWJiGXy+aCB4w61h7bet0QmdPAA+xCuf1gn0dumIuf
         jA8w==
X-Gm-Message-State: AOAM530zPbEkBrDOGep7YiPKma7cW0nbXh5S5fnJ0l6TM9jphxNbOwWP
        oA29LuGNvc4R/4ZjaJCCl6k5eCVAo+AzUDLSL1o=
X-Google-Smtp-Source: ABdhPJx3Ovni2QkIuB18vdAxewaOt4cyMM0hg55RN2KyVoE5eVIfOOm1mPxYJeYeBQC3gdZKEwi0Q9EGFOPVghkW0IU=
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr24491131ili.237.1635846726316;
 Tue, 02 Nov 2021 02:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211102075812.122715-1-ashimida@linux.alibaba.com>
In-Reply-To: <20211102075812.122715-1-ashimida@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Nov 2021 10:51:55 +0100
Message-ID: <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        yifeifz2@illinois.edu, Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 2, 2021 at 8:58 AM Dan Li <ashimida@linux.alibaba.com> wrote:
>
> I tried to submit a patch[1] to add compiler's SCS support on gcc-11.1.0.

This would go into GCC 12, right?

> [1] https://gcc.gnu.org/pipermail/gcc-patches/2021-November/583062.html

Nit: you can use the `Link: ` tag for this.

>  # Supported by clang >= 7.0

We should add a comment here saying the minimum version too, e.g. GCC
>= 12 (assuming it will be merged)

>  config CC_HAVE_SHADOW_CALL_STACK
> -       def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> +       def_bool CC_IS_CLANG || $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)

This is changing the default for Clang (which looks fine due to our
minimum Clang version), but if the test for GCC works the same way,
why not just keep the line as it was since it covers both?

> +#if __has_attribute(__no_sanitize_shadow_call_stack__)
> +#define __noscs __attribute__((no_sanitize_shadow_call_stack))
> +#else
> +#define __noscs
> +#endif

No need for the `else` branch here, it is done in `compiler_types.h`
(to be consistent with Clang).

Also, I hope one day GCC and Clang doing the same for these
sanitize-related bits...

Cheers,
Miguel
