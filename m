Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88CEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 17:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjFURzf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjFURzP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 13:55:15 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C5E2960
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 10:54:16 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-39eb3af4d8cso3826145b6e.2
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687369943; x=1689961943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=we88AZ15mcIhWAQhZKhKoOix1+2t83No85BbQaNBI9o=;
        b=IeBCuTt+RMOZwbG28Mu4isxocs+vieKJsA6ntfbga7OwV1FmKXU9+YrNcHYpaU0+PV
         4GUjxlMBHHgdrRtJ38cHYUPaL0N+FeNKC8g09fSd8p+1j/v3BDZlBbvhtFp1WZsc07bP
         6OWPnwpYQnozQ3/d5jgnDvASME/ULVK97nABA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369943; x=1689961943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we88AZ15mcIhWAQhZKhKoOix1+2t83No85BbQaNBI9o=;
        b=kFVNOHtaiNnnaXuZhj9jXTvltTq0XJkawhtQ3dyutcNW1kU62a+l5juYFPH/WYio0L
         0ormPenifs0wnAG2+unIi8LI1J+s/8/ErQ2Nvau0WhTE6In1e70/LxpqThVx/4yZT9Pp
         aznxH0S9ZNMnDLQlpoF0EB0Sq3lxmiB8Bf9o1FXC36v2YuANcL8PnYRIqcvXTAXFpRo/
         7UeA+rzu2xiBiBu4BUqGuBh4P2G2rhYDSPYECDpdfqJVmgqyBYqwcBFubazRkBqDTb/1
         AapUVGE0pYAJcmJzijm9zjEXKdliD/s+2bgRDqzflnUm8El8gkHbh+GeAcnFGyfhecOP
         309A==
X-Gm-Message-State: AC+VfDw1xTQT0qz0H/L7LnPZD77TAnwM6euvcI7cy6vmk0/2JhataR2L
        zw3s5vmOJ+sZDx105ovAoeC7MA==
X-Google-Smtp-Source: ACHHUZ7FPiX6xbICfcQfnlk5NeoX1flf6bmaMMZg8oXO6UnONtdYZQiohoWdvvq5ofdLlbveSOSdOg==
X-Received: by 2002:a54:4091:0:b0:398:2f06:329 with SMTP id i17-20020a544091000000b003982f060329mr15283734oii.9.1687369943179;
        Wed, 21 Jun 2023 10:52:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w36-20020a634924000000b0053491d92b65sm3398139pga.84.2023.06.21.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:52:22 -0700 (PDT)
Date:   Wed, 21 Jun 2023 10:52:21 -0700
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
Message-ID: <202306211051.1D4038323@keescook>
References: <20230405022356.gonna.338-kees@kernel.org>
 <07dea91f-9b93-4227-9fec-728a9e7a0d55@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dea91f-9b93-4227-9fec-728a9e7a0d55@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 09:42:01AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Apr 04, 2023 at 07:23:59PM -0700, Kees Cook wrote:
> > The use of -fsanitize=bounds on GCC will ignore some trailing arrays,
> > leaving a gap in coverage. Switch to using -fsanitize=bounds-strict to
> > match Clang's stricter behavior.
> > 
> > Cc: Marco Elver <elver@google.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: Tom Rix <trix@redhat.com>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Miroslav Benes <mbenes@suse.cz>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> This patch, presumably as side effect, enables CONFIG_ARCH_STM32
> for arm64:allmodconfig. As consequence, CONFIG_STM32_RPROC is enabled
> as well. This in turn results in the following build error.
> 
> Building arm64:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/printk.h:564,
>                  from include/asm-generic/bug.h:22,
>                  from arch/arm64/include/asm/bug.h:26,
>                  from include/linux/bug.h:5,
>                  from include/linux/fortify-string.h:5,
>                  from include/linux/string.h:254,
>                  from include/linux/dma-mapping.h:7,
>                  from drivers/remoteproc/stm32_rproc.c:9:
> drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
> drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t'
> 
> I did not try to understand what is going on, but reverting this
> patch fixes the problem.

Well that is really weird! I will investigate... this patch should be
pretty self-contained...

-- 
Kees Cook
