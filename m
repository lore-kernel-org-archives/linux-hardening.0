Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C2C05027
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 16:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBCQc1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBCQcX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 11:32:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F17A8409
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 08:32:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso5426041pjb.4
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kpK6KgZXQ54pBMdUsHP+HUpnEsKdgQDEGB4BNBeZB9M=;
        b=gEmQGizGKZQHCA1ytHRM6UDGT97glHo2J7W9naosZ1VMVQbEFAURGR1sGpP6uwVbvt
         4FjCWBQ64s0+iMVMRk/Pdg87ZmByxjnhEqBvknvFlw31g48ojNq2Q0J04MnoArHb71ip
         WlF5qPrqDiZDdq6oiyt694Dpp6cDfmOXnqHQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpK6KgZXQ54pBMdUsHP+HUpnEsKdgQDEGB4BNBeZB9M=;
        b=NPi7WDD6Yf20LjedQZzC71OQrODQQqbqASuEtZ9ENqZY7MFRbHY1ISLpoYAWVuoYfa
         dfYKNeTg1fwyP63eCDF5NlxNM9ntJyAQUaBKXl/aXzAspXStEf1Lx935PuE4xcLaKq+J
         UTo5QxMPmbnnGj/njEuMSww7RaEb/DpHaBACle8jNW+ddCQ9zk2ucZrniIObzwBveGKy
         9o2/wvGBzYwHaSLbvcO6fCQaGjWn5pK092C8PC++eas+fVAQ9obpnDgHZU+0/u4DLAHW
         F3Km2gCLSI97k4YOxPsOZ07I3+uKh1QtIlMDGkotU0NTbtJZQTxSc3+tiyx3jSuSM25J
         /KfA==
X-Gm-Message-State: AO0yUKVEKxsq6xudOCxpY6d2faq7wRAlV0eG4gVQ+hKOba1ry4AIoDX1
        JeFyMyxPZVZMain6YRSBWeqaMg==
X-Google-Smtp-Source: AK7set8qwbVjBH5W+V+grJP9ndtfdT04u2cUvUjM4C67XgmP2kzzkMLxlD4daBx8I9135CQ3ShRNSQ==
X-Received: by 2002:a05:6a20:8bb0:b0:b8:5f00:bbdc with SMTP id m48-20020a056a208bb000b000b85f00bbdcmr10653610pzh.50.1675441937646;
        Fri, 03 Feb 2023 08:32:17 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b00198ac2769aesm1803803plm.135.2023.02.03.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:32:17 -0800 (PST)
Message-ID: <63dd3711.170a0220.c22c8.349c@mx.google.com>
X-Google-Original-Message-ID: <202302031631.@keescook>
Date:   Fri, 3 Feb 2023 16:32:16 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better
 reporting
References: <20230202223653.never.473-kees@kernel.org>
 <Y9zawkok2AWy/brZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zawkok2AWy/brZ@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 03, 2023 at 09:58:26AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2023 at 10:36:57PM +0000, Kees Cook wrote:
> > On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> > and actually report UBSAN traps with some specificity when building with
> > CONFIG_UBSAN_TRAP. Before:
> 
> Really minor nit, but could we mention CONFIG_UBSAN_TRAP at the start, e.g.
> change that first sentence to:
> 
> | When CONFIG_UBSAN_TRAP=y on arm64, Clang encodes the UBSAN check type into a
> | BRK immediate, which is reported in the ESR.
> 
> I was initially confused since I was aware that there are usually direct
> function calls for the reporting.

Sure, I can rearrange the commit log.

> 
> Other than that, this looks fine to me, and regardless of the above:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-Kees

-- 
Kees Cook
