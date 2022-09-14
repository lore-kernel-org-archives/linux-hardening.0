Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435BECAAD8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Sep 2022 12:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINMnt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiINMnf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Sep 2022 08:43:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BB6F549
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 05:43:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b23so14782562pfp.9
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=6HaMASJeI7VMr+J/w1U/7Y+iVc+bp9rpXJjlWqnTPLw=;
        b=YIzBzY+v6xs/YMxj4iWLDwa/3sG54JjLXtKkP9SzybDnugjQ28MomQ7Q/1eCEwNC0l
         VjL/D3oz6nEQD4tjY7KbciMn3W941OhfguH0LVJkHs54gr+hW0n/a4HySJ0ImiyiOKzZ
         AsfRjH/LDlJLXTpTJ/BNyk9Bzi3jUoZVhK4Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6HaMASJeI7VMr+J/w1U/7Y+iVc+bp9rpXJjlWqnTPLw=;
        b=s9GqKUBEvp/gX0ZiiYkjlUHUn4yKaIA7ghNTnH36OAMIn0BiFtRtKil0T23n8jeHFa
         WJirtL7tUYqHv1n4DofaT4iEKoLevZ5gJldu/jsCZCdBL2aAf99iGrvfLmH3q+zUwXCU
         /nCNq3b4mEdITk0qw6eG3GlI1Scr/7iDN250rY7UT3b3LNZ35Jx0c7vJuS8DhnvOMPnf
         a4mudFtMWke60M2uRXK5uuRiyVJnbpMrbAlVo8UOzjYI70xf6ShoQA+7ZJH+omkehPwK
         RHGRGmGvCh1Wfnjuhrquju9aQdKpPNbc8nFBHRkMOP4OC+Lf//er6H+Rj1UDbq1w2WTG
         KrQg==
X-Gm-Message-State: ACgBeo1mb0+qXBiPBhDMlgaI4oOeMBFusAK6cz4VKkpW99FBNlZFM533
        HIoFBmtJkiOcN5FLSAMYr0FwCQ==
X-Google-Smtp-Source: AA6agR4TiCsN6kfTl9U6YZK5ujamfmLJAVu9hWCyUWJgdB0M34FkD50z4FEUai9qGVAHCkR35ai09w==
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id d9-20020a056a00244900b005283a29e79dmr37892836pfj.39.1663159413849;
        Wed, 14 Sep 2022 05:43:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12-20020a63440c000000b00439103a6c3bsm5614212pga.94.2022.09.14.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:43:33 -0700 (PDT)
Date:   Wed, 14 Sep 2022 05:43:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     linux-hardening@vger.kernel.org, j.koschel@vu.nl
Subject: -fanalyzer thoughts
Message-ID: <202209140501.412181C969@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

Thanks for the talk today! I sent a patch for the aic79xx_osm.c issue
you mentioned:
https://lore.kernel.org/linux-hardening/20220914115953.3854029-1-keescook@chromium.org/

I didn't have a chance to add some more comments and ask a question
before the session ended, so here I am in email, CCing the kernel
hardening list in case other folks want to chime in. :)

You asked, "Should I try to have GCC type-check __user vs __kernel,
or leave it to sparse?" I would *love* to get this in the compiler
proper. Not nearly enough people are running sparse, so its output has
become quite noisy, which means more and more regressions are slipping
into the kernel. I was surprised a while back to discover that kernel's
use of the address_space and noderef attributes weren't supported by
GCC. It does seems like it'd make a good attribute (for which there
is existing precedent), rather than polluting the global namespace,
as AVR does:
https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html

Clang seems to support the address_space and noderef attributes:
https://clang.llvm.org/docs/LanguageExtensions.html#memory-references-to-specified-segments
https://clang.llvm.org/docs/AttributeReference.html#noderef
But when I tried a while back to make it work, it fell over:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=clang/address_space&id=beff911c13390a71b3f7921fd82ec6a71ca75c02
If these get implemented in GCC, it'd be good to coordinate with Clang
too, to make sure it works sanely in the kernel.


The question I had was if you had seen this LPC presentation:
https://lpc.events/event/16/contributions/1211/
"How I started chasing speculative type confusion bugs in the kernel and
ended up with 'real' ones"

The authors used Clang's "Data Flow Sanitizer" and built a working
taint/sink system that seems like it could be used for MUCH more analysis
than just what they were looking it (as they hint at too).
https://clang.llvm.org/docs/DataFlowSanitizer.html
https://github.com/vusec/kdfsan-linux/commit/45614ee1a3a0d7b98c5cecb1b747184279bc615c

I wonder if DFSan could be ported to GCC? It seems to overlap logically
with some of the -fanalyzer work, but I don't know the internals for
either, so I likely have no idea what I'm talking about. ;)


Related, I wonder if LTO builds would help with -fanalyzer's control
flow analysis? (DFSan requires LTO.) Getting the kernel built with LTO
under GCC seems to be an on-going project, but no pull requests have
been sent lately:
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/log/?h=lto
Maybe poking them from your side might help that get landed? I think
people are interested in having LTO for the kernel for the performance
gains it can provide.

The second-to-last slide in my presentation (in the "bonus slides"
section) has slightly more context about LTO and the kernel:
https://lpc.events/event/16/contributions/1173/
https://outflux.net/slides/2022/lpc/features.pdf

Thanks!

-Kees

-- 
Kees Cook
