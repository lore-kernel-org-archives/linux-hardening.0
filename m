Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C30C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD560E08
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhINUDi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhINUDc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 16:03:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD7CC061767
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:02:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f2so914042ljn.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbWkolcm+ANzoV9xuDvSV9WrohIVsxKiIB6DNRxGuYQ=;
        b=AumVqFTPEOpwx/P01HDSDl0Xyg9EZjukpRm4GjNnTxYi4iflx8ADSvZYffaWzo6YRX
         ZlUPMpQATGWyZ1ymbyqu+Y6A8p/ZyiaEjbs8428eLfoRyWqoArZf0Lgc0mv2n3fHfuA7
         QdHyKbFtIF6C2xzsgZHoB67ZBy2bxmxdrQVKZvTQdPzS0LgRbGylCT5dQszKRQb1btUP
         TKMz1/TYe9Mokaf2zDFhR7pOhOlu661WSTCEWEyGBh9JZ0l84CoOTMDjeeocYnZdCbiH
         5sJq0K/cPviZeLfsgxoWFa3mOqyNIgDWabCPWdMZ1es8uEpGhWgrBm9rmUpF3iGlRS2J
         QUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbWkolcm+ANzoV9xuDvSV9WrohIVsxKiIB6DNRxGuYQ=;
        b=IyDtcFtu53VVeYWezNHUAm0fqtSvNJ9m8aFg4lBRX64njvg8RX6qV7QsDaVNURLAGW
         LZijqhza6LZPMe/4feV72cgEkYZaZnGJKJdsGW4pLjnryoIQ45AMP/+GfunaLeQv723Q
         waCvyLLDH5mM2BlSXQAHmr4pZ3UPEwVZvOgbtHQQCaG91mt1oBD9eU7IXiAepUgub3vc
         fCiutrOuqd5fJex2uXzyyvZ8un1o/o0ybNsmlIME/sHV+GIQYhSg8Fii4awvd18jMrYq
         KLO9H0XUppDWtzFHpCjoIzQxiJVg/t1IEEZnLj2qlojhP8jWOMs+ZDaBeUvf5Wb/AEUY
         cmaw==
X-Gm-Message-State: AOAM530XdxJKs5Wd0Euruow5LiEsE2d7tDYbDeJj8q4ayMNESxYJVbXj
        uC/ZoVH9085QMM56Kwgp41ZD7JO0d5Os35B9WGlAcmAxsPIsvg==
X-Google-Smtp-Source: ABdhPJw4LtQ05rJ+hXSjPwQcTef45Tg42XsJIXLFX5Za0EUr6bqFR/mLTAL/6ZogeLtnD6KV3CulDGGwOquR7AbFCUA=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr16766504ljc.338.1631649732696;
 Tue, 14 Sep 2021 13:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-12-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-12-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 13:02:01 -0700
Message-ID: <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I kind of prefer the existing convention that has explicit guards on
specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
which configs may introduce which flags that are problematic. This
patch is ok as is, but it kind of makes this Makefile more
inconsistent.  I would prefer we had the explicit checks.

Does CFI actually do any instrumentation in these object files? I
guess issues in purgatory cause silent/hard to debug kexec failures?

> ---
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..ed46ad780130 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
>  # These are adjustments to the compiler flags used for objects that
>  # make up the standalone purgatory.ro
>
> -PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
>  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += -fno-stack-protector
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
