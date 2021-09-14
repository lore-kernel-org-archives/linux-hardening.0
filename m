Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8FC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59810610CE
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhINTdV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhINTdU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:33:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C045C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:32:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v2so40414plp.8
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HJuxS291se7h0pWa8RwOF5pMXHcq2hWKO/DuoK0nSw=;
        b=YcuSryWcll5qZWFgHfCzkDhCl/66XVdRjSv6JbOVPFPcgy0ifWt+iJ4I67uLoOfz96
         ljG8aT7RCWjDbEzYCmmjafKuNtT6gxSQ/6Iv1+q/yNgvNCrUTFxlctrM9ZfCehlbpHcB
         wE2alCrI13VE0W8/6XPfkD8d/v3z2M1+pF/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HJuxS291se7h0pWa8RwOF5pMXHcq2hWKO/DuoK0nSw=;
        b=ajr++401KPuaOtXYLBbLX4b9e/1JCP6h8Fpwxgff/4no8yTSKvq1C62AiOoP7OqmRG
         PhU8kl3AJCPSg7VDNidEWrE4Zo3ZqevBXIB4XuxTx/Ky2XLD+LxubTsChxZvGWw+8Tzt
         avG8SVuYstJB833yecbRNbgcd5NP1DrxQGut/C04PxHQUH4xGbCf2xI9Qh4BeFmCD5cU
         jb1gslOhFY9KNzpX/rLmHH+dApHJJPNE7xyppthLUjiYPf1SMPkdnlvx9AC2N3cbGoUc
         +/E7glCV+5gIlEhkRrenBCGkeVx4bekRpR4o5UMuRd0rOcSIHGM/T8r7V/N/JJxfrvZF
         tBQA==
X-Gm-Message-State: AOAM533loKaVB7FRY1XJGiJBOrGoMfd9FxSP/Pb/zkCSuHD3oO0sU+wI
        pykQa4ahj51Hb08AbXCWd4HMtE76pmq1LA==
X-Google-Smtp-Source: ABdhPJxAfgyQ+0BOY7pY+EQe0yRgyPOYJ2jE1ubX84l0DdSbIMZJuiU2yae5vGJ4DadJ6Ju+1sfzqw==
X-Received: by 2002:a17:902:ab5c:b0:13c:87ab:15f5 with SMTP id ij28-20020a170902ab5c00b0013c87ab15f5mr3703119plb.79.1631647922974;
        Tue, 14 Sep 2021 12:32:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5sm11377017pfp.218.2021.09.14.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:32:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:32:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 08/16] lkdtm: Use an opaque type for
 lkdtm_rodata_do_nothing
Message-ID: <202109141231.CD2DE05@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:37PM -0700, Sami Tolvanen wrote:
> Use an opaque type for lkdtm_rodata_do_nothing to stop the compiler
> from generating a CFI jump table entry that jumps to .rodata.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
