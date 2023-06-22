Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA919EB64D7
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 03:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFVDLX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 23:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFVDLX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 23:11:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342D1BD3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 20:11:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so3712635a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687403478; x=1689995478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAqfKy9L7gl2qfZmHwhpMjSx7czuoKau/UFIXqH952U=;
        b=Ux9IDPHbFSScf+uqQMasT6bNz9Ff2jg/GwkYrg0QL2Hg6USun6agaDett+qxyqxyat
         pMIF6usSBX6lKywrdZJZdb/n/R+LVUewkhGsf35GPCsRXGSvg7X/XlPbGvdUUHLNQPE3
         Bb8sMkFiWTcFd/SfMYOAGAkbmRMJBt97skYLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687403478; x=1689995478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAqfKy9L7gl2qfZmHwhpMjSx7czuoKau/UFIXqH952U=;
        b=a0uiJCHRLg/buUobgnWGFMyYU8m9wHkXRsnDpK+4seS3XuDSsyhCTb5ykfl6Ily1LP
         xu64yCa8YRiov46k63iiwqWvi0vQL5vo1yWOnWlpRHWWMBO6d0fzV+blei88ZMVnTkti
         j31ISe0pKiSXbfJusAYkvqezbio7eorFW9yrKnoigwdSviMbpsw5X0gjqO2ZbgBqVXUf
         dVdN0xB5l2o5H7WH1KdjHkGI95pJZCo72eseT3cz/Y50Gm1d3dZeqQHCF0KycrPIGOSG
         wiXWSDDaRLx/4q+98NCFEtdJ3ZGd8EiqjqdrnTfUzZmx4xKFWpFd8KVR+oxAcraVl8bd
         fQGQ==
X-Gm-Message-State: AC+VfDyrNW5wm1Wz7x4LXS/ue+Qbjs+zdZmvJV4GgarKI3SAk2LQv12I
        kKawzUPna8KQ2Ggbp1b+XqC4cQ==
X-Google-Smtp-Source: ACHHUZ4vMlPLBOvhTnJarXHJcpoo4MCFhQd8JrGzTMgDccm3BRjpYcAhpJYvO9CJvJ4TSIFEuQmTgw==
X-Received: by 2002:a17:90a:974c:b0:25e:c420:6a71 with SMTP id i12-20020a17090a974c00b0025ec4206a71mr12453181pjw.32.1687403478670;
        Wed, 21 Jun 2023 20:11:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d51100b001aaef9d0102sm4161321plg.197.2023.06.21.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 20:11:17 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:11:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ubsan: Tighten UBSAN_BOUNDS on GCC
Message-ID: <202306212011.435B7C8ED@keescook>
References: <20230405022356.gonna.338-kees@kernel.org>
 <07dea91f-9b93-4227-9fec-728a9e7a0d55@roeck-us.net>
 <202306211051.1D4038323@keescook>
 <5fbe4977-c56d-2d97-bea3-28148807b5d9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbe4977-c56d-2d97-bea3-28148807b5d9@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 05:50:53PM -0700, Guenter Roeck wrote:
> On 6/21/23 10:52, Kees Cook wrote:
> > On Wed, Jun 21, 2023 at 09:42:01AM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Tue, Apr 04, 2023 at 07:23:59PM -0700, Kees Cook wrote:
> > > > The use of -fsanitize=bounds on GCC will ignore some trailing arrays,
> > > > leaving a gap in coverage. Switch to using -fsanitize=bounds-strict to
> > > > match Clang's stricter behavior.
> > > > 
> > > > Cc: Marco Elver <elver@google.com>
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > > > Cc: Tom Rix <trix@redhat.com>
> > > > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > > > Cc: Miroslav Benes <mbenes@suse.cz>
> > > > Cc: linux-kbuild@vger.kernel.org
> > > > Cc: llvm@lists.linux.dev
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > 
> > > This patch, presumably as side effect, enables CONFIG_ARCH_STM32
> > > for arm64:allmodconfig. As consequence, CONFIG_STM32_RPROC is enabled
> > > as well. This in turn results in the following build error.
> > > 
> > > Building arm64:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > In file included from include/linux/printk.h:564,
> > >                   from include/asm-generic/bug.h:22,
> > >                   from arch/arm64/include/asm/bug.h:26,
> > >                   from include/linux/bug.h:5,
> > >                   from include/linux/fortify-string.h:5,
> > >                   from include/linux/string.h:254,
> > >                   from include/linux/dma-mapping.h:7,
> > >                   from drivers/remoteproc/stm32_rproc.c:9:
> > > drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
> > > drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t'
> > > 
> > > I did not try to understand what is going on, but reverting this
> > > patch fixes the problem.
> > 
> > Well that is really weird! I will investigate... this patch should be
> > pretty self-contained...
> > 
> Meh, it is. Sorry for the noise. My bisect script was wrong.

Oh, okay; whew! I was really scratching my head. :)

-- 
Kees Cook
