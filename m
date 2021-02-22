Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFCC433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A506464E74
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 15:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBVPrI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:47:08 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26805 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhBVPrH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Feb 2021 10:47:07 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 11MFk2Ev004320;
        Tue, 23 Feb 2021 00:46:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11MFk2Ev004320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614008763;
        bh=89wXumCMVcs8ybK5qsD235XsMdw1h/Bx6pEH2/t7rnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oiMhYH+0j6BkMUJA290YpMySryyjfMcfeeiuWCz86lIarNDqfkBiTlmYTuSvEZ9dl
         HcfdeG+jzZrOMlG5vjYFyT86f/29c5HpeYDVK0lwHGjAUBWc4j/C5Q2Cae+vJRVjDl
         R0MBmT0eGzGdlBBaq21UHZ8C8yuBxMrGjJMZWNKtlSeh8Gzhcxb7Ew4jPmvw/suxgt
         +U7tDq4TRVYB/QmN6DAt93KLevII+aS01yPQgCwxhO8RTt+L9mJR2juN6YnTm4+50L
         YSEqGBn4ZBo4yoHLLSx9schIg153y1JZfO3rbqH5l6Ayf3zokBcEW2sIT3Hn2H+kb6
         yJkVUwBqXNoCA==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id q20so6810088pfu.8;
        Mon, 22 Feb 2021 07:46:02 -0800 (PST)
X-Gm-Message-State: AOAM5334Ocp9qyott/8iLmtoaFN5om3vybWuAWb2mSfMvkFDWItwxwf3
        JGP+gf4WzG5NbpIEkjke4xo3gCgOk37Y6t/EViQ=
X-Google-Smtp-Source: ABdhPJzRmIyw260Ejwv7qPbx7qeo5vmns2SqcnJEbfDHbdafquX12mF+gI9XQfntZze1Pa/WhLzvxu8pU8CwjF7J7S8=
X-Received: by 2002:a62:d454:0:b029:1ed:a6d6:539d with SMTP id
 u20-20020a62d4540000b02901eda6d6539dmr5123963pfl.63.1614008761620; Mon, 22
 Feb 2021 07:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20210221225650.33134-1-linux@roeck-us.net> <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
In-Reply-To: <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Feb 2021 00:45:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
Message-ID: <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 23, 2021 at 12:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/22/21 4:05 AM, Heiko Carstens wrote:
> > On Sun, Feb 21, 2021 at 02:56:50PM -0800, Guenter Roeck wrote:
> >> Commit 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") disabled
> >> COMPILE_TEST for s390. At the same time, "make allmodconfig/allyesconfig" for
> >> s390 is still supported. However, it generates thousands of compiler
> >> messages such as the following, making it highly impractical to run.
> >>
> >> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:main
> >> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:_GLOBAL__sub_I_00100_0_main
> >>
> >> Since GCC_PLUGIN_CYC_COMPLEXITY is primarily used for testing, disable it
> >> when building s390 images.
> >>
> >> Cc: Arnd Bergmann <arnd@kernel.org>
> >> Cc: Heiko Carstens <hca@linux.ibm.com>
> >> Fixes: 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>  scripts/gcc-plugins/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> >> index ab9eb4cbe33a..5e9bb500f443 100644
> >> --- a/scripts/gcc-plugins/Kconfig
> >> +++ b/scripts/gcc-plugins/Kconfig
> >> @@ -21,7 +21,7 @@ if GCC_PLUGINS
> >>
> >>  config GCC_PLUGIN_CYC_COMPLEXITY
> >>      bool "Compute the cyclomatic complexity of a function" if EXPERT
> >> -    depends on !COMPILE_TEST        # too noisy
> >> +    depends on !COMPILE_TEST && !S390       # too noisy
> >
> > I don't see a reason to disable this in general for s390. COMPILE_TEST
> > was only disabled for s390 because a lot of irrelevant configs didn't
> > compile and it would cause a lot of unnecessary work to fix that.
> >
> > However the !COMPILE_TEST dependency here looks more like it was
> > misused in lack of a possibility to detect if the config was generated
> > with allyesconfig/allmodconfig. Maybe that could be added somehow to
> > Kconfig?
> >
>
> That is what COMPILE_TEST used to be for. Not setting it for s390 doesn't
> just cause this config to be disabled. Lots of other compile tests
> for s390 are now disabled as well, and code which should be disabled
> is now enabled. Looking at it, I'd be a bit surprised if allmodconfig/
> allyesconfig with COMPILE_TEST=y still builds for s390.
>
> I agree that COMPILE_TEST it is being misused. However, I think what
> you'd be looking for is something like COMPILE_TEST_RANDCONFIG.
> FWIW, in my opinion, randconfig should not enable COMPILE_TEST
> to start with. But that is a different discussion.
>
> Anyway, I can disable GCC_PLUGIN_CYC_COMPLEXITY manually in my own
> build tests, so this isn't that much of a problem for me, so feel
> free to drop this patch.
>
> Guenter


Maybe, we can add something like CONFIG_SUPPRESS_NOISY_TESTS,
which is set to y by all{yes,mod}config.

This is self-documenting, so we do not need the '# too noisy' comment.



config SUPPRESS_NOISY_TESTS
       bool "suppress noisy test"


config GCC_PLUGIN_CYC_COMPLEXITY
        bool "Compute the cyclomatic complexity of a function" if EXPERT
        depends on !SUPPRESS_NOISY_TESTS





-- 
Best Regards
Masahiro Yamada
