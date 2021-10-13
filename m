Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9077DC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D4661130
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhJMSMs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSMs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:12:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509BEC061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:10:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z11so14796863lfj.4
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5TEQck0sZT4Ta6tLRdPV0UEutrCTFu6Cme/v+Sjxeo=;
        b=SaBwLltyOmUvlw+l0jpPn7wVhVSDwOsS8Hu5rEK9OpOug+BYojmm5wqKNl0BTrxZaQ
         3h1GTB5AWGNWSheykrLTlOKQc/h7OJN0mmXmyVOTNL1j3vc+i5dyekCsELRnoZWlrrB9
         Iw7hrQBF+bsu/Fyt8bUUy/myKxarefszUTnNk6HsDIaaLmRgo/fCZ3UybZoXGAWoLjky
         j0sOhUYP/lnrNgPIAH09BzTXQDDMj8YUBb9nVfrk6jb4Ra2LBOb4mPLa9aH4rVv7Z3a+
         DaSfJ3Buol8PVepBofHzT48F3ygzpBC8vjNwkHrUJfEWpm0g2FewUZzsX1bHyeCdzjgK
         NNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5TEQck0sZT4Ta6tLRdPV0UEutrCTFu6Cme/v+Sjxeo=;
        b=pjKyClXMgDVz+zlrZ30RHJ1bZXQLY+mYlKElY5ZpiQSw0MPkVdlyegRRMH3rtgiiv9
         9uA+vh8JIRqc+KI3133qbSWkeboCmzVt5CIpVsoPx9URa2dqU5GqbYNvz6lOdWWGyRKH
         v68wpIVMmKuoOr//9zQZbRBPQ4y0KHUnuIZeb10G8B18ts6VkXI0g1emFFNznIG3TGqQ
         jxnJvZKo1Zv8OK972NNY+otLNw47ZjFc5/VAuonhdh/VGGTDSjX39h6RxSTnlI/n6Cqg
         8qu946G9jLnFDle3GNsV0B/m4k6T3I+Qvi7WFPS21CXCPy3S51Lqa9GvU1mUT+9CF7VL
         3FvA==
X-Gm-Message-State: AOAM531kh4Dx6o9urX+AbbNzdwwryJiIx1oceP5z+D8rtUstK8h3L9c8
        E5ldkoYckw4KXB0FjGV1HQi0IAIkBnji2fBMv4S+gg==
X-Google-Smtp-Source: ABdhPJw5L7jyVnMlYlOYxjOH7TmSjBEYG/z0/c0zDFSzwpz1g92FtKbr0u/AksA/tbj34qCNAzrLecP/Pacty/C8bC0=
X-Received: by 2002:a05:6512:4c7:: with SMTP id w7mr517901lfq.444.1634148642379;
 Wed, 13 Oct 2021 11:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211013175742.1197608-1-keescook@chromium.org> <20211013175742.1197608-3-keescook@chromium.org>
In-Reply-To: <20211013175742.1197608-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 11:10:31 -0700
Message-ID: <CAKwvOdmczBu286Ju2+gZK2h=hmELeX0K55pMOwMK4dtH89bU9g@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86/boot: Allow a "silent" kaslr random byte fetch
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 10:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> Under earlyprintk, each RNG call produces a debug report line. To support
> the future FGKASLR feature, which will fetch random bytes during function
> shuffling, this is not useful information (each line is identical and
> tells us nothing new), needlessly spamming the console. Instead, allow
> for a NULL "purpose" to suppress the debug reporting.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/lib/kaslr.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
> index a53665116458..2b3eb8c948a3 100644
> --- a/arch/x86/lib/kaslr.c
> +++ b/arch/x86/lib/kaslr.c
> @@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         unsigned long raw, random = get_boot_seed();
>         bool use_i8254 = true;
>
> -       debug_putstr(purpose);
> -       debug_putstr(" KASLR using");
> +       if (purpose) {
> +               debug_putstr(purpose);
> +               debug_putstr(" KASLR using");
> +       }
>
>         if (has_cpuflag(X86_FEATURE_RDRAND)) {
> -               debug_putstr(" RDRAND");
> +               if (purpose)
> +                       debug_putstr(" RDRAND");
>                 if (rdrand_long(&raw)) {
>                         random ^= raw;
>                         use_i8254 = false;
> @@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         }
>
>         if (has_cpuflag(X86_FEATURE_TSC)) {
> -               debug_putstr(" RDTSC");
> +               if (purpose)
> +                       debug_putstr(" RDTSC");
>                 raw = rdtsc();
>
>                 random ^= raw;
> @@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         }
>
>         if (use_i8254) {
> -               debug_putstr(" i8254");
> +               if (purpose)
> +                       debug_putstr(" i8254");
>                 random ^= i8254();
>         }
>
> @@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>             : "a" (random), "rm" (mix_const));
>         random += raw;
>
> -       debug_putstr("...\n");
> +       if (purpose)
> +               debug_putstr("...\n");
>
>         return random;
>  }
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
