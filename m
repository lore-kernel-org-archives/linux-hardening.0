Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422BBC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F25661108
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhINTl2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINTl1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:41:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B8C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:40:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v2so56841plp.8
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcEmJONXzFctWoWAbmoyFCWtMu++a2TB+LdKgluV5F8=;
        b=b67l9+LmGiNJMncgt37heGIa5UQNPduT93QdVJx5GAJ47eIMnEysXAK67zMtur4ffr
         kmwp2SMskf750h8rbaW2gKeA9RbZxn2pgByKKIBkWHmbsDqBni80cuhkQjdWGap7rUkg
         A7PRp6V9lRIT5Kn6iFNaEs1/fij2HOq1ve17k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tcEmJONXzFctWoWAbmoyFCWtMu++a2TB+LdKgluV5F8=;
        b=jr/ozjZauw2d4VByg716siDEUPW91F7I8kxrJvZSJ+8gi+vLs82TxH2FwYwd8Xp8km
         TFXxjSq5lO/NSUYnPL65+NFsL3f4QzNiiSL9ZZNxoBbKHBIe3nbEfe93xp10hEM5gwiH
         gnfhX5QZbKFvT5puejnwdeRzYEIwhV6NG/sUuVjqAN6P8pZpl6WXOUis/v4BrwzrJx58
         xYrb6OgoFCP+zHXjgmwlqKl5wgVUmvw2yccTS/DV2ifb7tBWbXlU8V6dOR1P/sYVn+D/
         TEqWAWhJtQAccAklh2vTT1GrdjqFAMC6DivJ0GBeBrFIBs7VaI4kEvx1yJw/Q4v9U4Kn
         Oitw==
X-Gm-Message-State: AOAM5319zdLE+RCEmtR4ItyPwBKWKZ4C9TwHp17WzGxTCPB+9k5MpCxL
        DmGTmDKSSZOZXJY+1DFRvIvT9w==
X-Google-Smtp-Source: ABdhPJyQ2jde2kQCG8xG2FpSQla1sqvqKIfFblIQE21QUYBOqODtnpyqi+wdRz0ZEUo2GLzDt4e3+w==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr3968880pji.87.1631648409751;
        Tue, 14 Sep 2021 12:40:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm2464895pjg.7.2021.09.14.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:40:08 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:40:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 15/16] x86, kprobes: Fix optprobe_template_func type
 mismatch
Message-ID: <202109141240.4843E7A9@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:44PM -0700, Sami Tolvanen wrote:
> The optprobe_template_func symbol is defined in inline assembly,
> but it's not marked global, which conflicts with the C declaration
> needed for STACK_FRAME_NON_STANDARD and confuses the compiler when
> CONFIG_CFI_CLANG is enabled.
> 
> Marking the symbol global would make the compiler happy, but as the
> compiler also generates a CFI jump table entry for all address-taken
> functions, the jump table ends up containing a jump to the .rodata
> section where optprobe_template_func resides, which results in an
> objtool warning.
> 
> Use ASM_STACK_FRAME_NON_STANDARD instead to avoid both issues.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
