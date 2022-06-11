Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F5C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Jun 2022 06:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiFKGBI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 11 Jun 2022 02:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiFKGBF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 11 Jun 2022 02:01:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D998108E
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 23:01:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so1244514pjo.1
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3GFcFwqnFGmcRNmokcZ6QcxITcGcLvGSBnxe2xUhRi8=;
        b=IhYK9SJrhXq+qv1WiqB9FLLyFfKRj6/LONo25ON2I+xiq7D8kxxiuRj370SIb/01Km
         4gLaz5vOJBdR/vDD8jKvcf0cfGJsH0IormapMgd6vYFQTTxeSk0C9taU8BoZGD4Jj5fa
         4u6bRx3oHK3wCWS/+jm6BcndC/WKUqku29P2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GFcFwqnFGmcRNmokcZ6QcxITcGcLvGSBnxe2xUhRi8=;
        b=o39Ri6f1aIXT1T5MJMOjqvDVEP1Uyxw+XCULIrrMrTa/BuDs+SED/vepBD8FYbJGfS
         113JBJHxoFTrYibDP861+XK5Hy0Z+Tta4d/uAOCZOlFWu2LSaCW2FpLqR+J4z3mpFI5x
         3wiZmZ4aEUM8PSq3m6WXap3w4Z8U+zxUZiWN9RPSRCBR6V3g9n8CiDrwxTI8rEKnM3Vl
         cxz2IjXK3Qju6FYHWspmT9icQ044vOmm/ozJRwy/Wxb2Fzqbxzy4ZV1PWHFGZKlFEHRw
         1bsQiHSTGtciIM0UN5BVYkBjrp6lQ6rVS+0dtDX1NY08i8FJgUDfzV8VKEppiSnZnCae
         +/Dg==
X-Gm-Message-State: AOAM533y3ZgEuCTj+thM5QcSBOFBYujQa2QRuzQS0629J/Yo16Cye14l
        PEIKb/Jb3TqDllVgp7vvPdYCMg==
X-Google-Smtp-Source: ABdhPJzinXa+z54InZrO9Ii73d7aTXsD66k55pj7PtXI/jz+hh/xNWPtX9cuYHlcPAVY6EjcgVgLAw==
X-Received: by 2002:a17:902:7611:b0:168:cb95:fd27 with SMTP id k17-20020a170902761100b00168cb95fd27mr1051867pll.126.1654927261517;
        Fri, 10 Jun 2022 23:01:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b00168b4b550f2sm726508pln.54.2022.06.10.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:01:00 -0700 (PDT)
Date:   Fri, 10 Jun 2022 23:01:00 -0700
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
Subject: Re: [RFC PATCH v3 07/20] lkdtm: Emit an indirect call for CFI tests
Message-ID: <202206102300.26A43F5D8@keescook>
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610233513.1798771-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 10, 2022 at 04:35:00PM -0700, Sami Tolvanen wrote:
> Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
> direct calls. Move the call into a noinline function that accepts the
> target address as an argument to ensure the compiler actually emits an
> indirect call instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
