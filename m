Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B35C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCBA61168
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhINTex (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhINTex (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:34:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31BC061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mi6-20020a17090b4b4600b00199280a31cbso2717570pjb.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HtM5LJiLlnoib4lYiLRFHMJjkrTtS7BIKN49Lg7zyU=;
        b=RHFMNiuVUUspmr+lhdCReOoOs7+PeEiR7YxvRBK+bOaJjHyjmsWEsHDDfPvqOW5yDt
         zDszNFdSaCO9MJJDSYfPopSCiem5AU0gZoCRKqDh/QvdN2Ymcesw1yLpXVJaTU6eUXqv
         npcnYs7mz2Z5E88V5YhqqQwtlO4PQG7pJ5e0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HtM5LJiLlnoib4lYiLRFHMJjkrTtS7BIKN49Lg7zyU=;
        b=3j+Y3hFRlEpnhyuelNUDT0oJhrxDsALlAzprZ2zY67NJohL+gSkAF0LPg3Ggn6k2Rv
         +/r3jWLMh9Ef7Vl1z7zKrEQnLAoiFciKtDHKXBz7PsxpFTGlNHIj0qvJA6ICXiV53BlX
         e8K/CXHiJ/bZjJRa51Ott60JLf/sWBgvUiadHTOEyA/fkPi3WZRo9GTgbylJuvaw1bc0
         RJsepAGmRC0EEV72H7mmLRumVdFvP3e61rAB2Vf654kmbhtmCZBXbTv3mKo9EN5+GqI5
         XKW92SQGVsQI9/jRUrjig1bkdYO0cEUZVY1wHdTAz8ziMQlWY8B6L//5VsSEqt2rOELg
         Ygiw==
X-Gm-Message-State: AOAM532XvLR7qbGKOFdhZkBb+HXTXhN0hgW3zaus16oT+hgUGUBukFqy
        0e+1npfN5BJDZfBGacs0MPaKLw==
X-Google-Smtp-Source: ABdhPJxt3I/wU2dbM+lhO1fHQtKXL2+tDL6MvOTSBjT+HagDNkkLLV/diGyDZV6HNqrasy3yCjtLNw==
X-Received: by 2002:a17:90b:4c8f:: with SMTP id my15mr3924149pjb.131.1631648015192;
        Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm2464576pjs.31.2021.09.14.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:33:34 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:33:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 09/16] x86: Use an opaque type for functions not
 callable from C
Message-ID: <202109141233.01761C8@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:38PM -0700, Sami Tolvanen wrote:
> The kernel has several assembly functions that are not directly callable
> from C. Use an opaque type for these function prototypes to make misuse
> harder, and to avoid the need to annotate references to these functions
> for Clang's Control-Flow Integrity (CFI).
> 
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This looks clean to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
