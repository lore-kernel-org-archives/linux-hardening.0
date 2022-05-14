Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7ABC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiENV46 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiENV4e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:56:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7519287
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:56:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x18so11106360plg.6
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRz+GXXZaKOMrKydUY42JkbUz0KXbswZCunobIsh+ok=;
        b=EMGxS7CubkSoRXJvbmCOUMnABXzcITd5+nEUdRyvBWZr0Ejfu0faLMdmwYhOM8pXx4
         qOvD2ibBSHZJuEbw1khfAuvievTdhMLKWyGiMShRtK8Ll3XYbrif7r38L2UQePBNmqGc
         wDzdnSTxfK8uDgCLXMc/+iLNVxeUASGOOeNys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRz+GXXZaKOMrKydUY42JkbUz0KXbswZCunobIsh+ok=;
        b=pG2yYvrplnoS1P3I1SEkgi4czoNH7QtSfIl6BidcFjQOnUOVorkfoZsw3zpgEcZiB5
         znb/kWJnsUpJuqOs3c8Q+Pk9UUoiLbzVL3oQndWOAwoXfLjLKVkXKIL2mPRI06ZWqBVm
         8uddvjII6YNdm91hzq4/qaIQVVyZ9MaMJThz8sZsJRsLauXbW7OVgr0yXyABPFscaPtC
         noBlrL72qYK0uH1izjOX9EWhjO/OrGUXIbfkQ3BQLY9834/5ebQ40gLvwOOUkL+gspj1
         o+Q90ns8vqxHMlKuhtCQRCrAXhGNGTkDnLUyFfOZlWtQrOEv+Zi0adM5PfNtohnR2JlV
         /Kfg==
X-Gm-Message-State: AOAM532d9XFLr1tZ9h095oruz7yYEU8OKBqxUKH0+J7CTrbYG9UKrFV4
        fxTMunneBrXPsTLXlrMRPkaslQ==
X-Google-Smtp-Source: ABdhPJwN6qwi59HdCtNsN1hdnIt3qawy44T1UkLBIVUFePlqWn8+tMNJ68vLHuPdKrk2BA5cYKH36g==
X-Received: by 2002:a17:90b:3510:b0:1dc:88d2:6a1b with SMTP id ls16-20020a17090b351000b001dc88d26a1bmr23153588pjb.158.1652565363278;
        Sat, 14 May 2022 14:56:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b0016162e01553sm495864plz.168.2022.05.14.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:56:03 -0700 (PDT)
Date:   Sat, 14 May 2022 14:56:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 14/21] treewide: Drop __cficanonical
Message-ID: <202205141455.0A6F409@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:52PM -0700, Sami Tolvanen wrote:
> CONFIG_CFI_CLANG doesn't use a jump table anymore and therefore,
> won't change function references to point elsewhere. Remove the
> __cficanonical attribute and all uses of it.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/compiler_types.h | 4 ----
>  include/linux/init.h           | 4 ++--
>  include/linux/pci.h            | 4 ++--
>  3 files changed, 4 insertions(+), 8 deletions(-)

I think this is missing removing it from include/linux/compiler-clang.h ?

With that done (or explained why not):

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
