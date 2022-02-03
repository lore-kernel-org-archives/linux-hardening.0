Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE2C4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354901AbiBCUrF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356625AbiBCUqc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C11C061744
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:45:38 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l13so3243995plg.9
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ax+zgGQyyKWqqmUNa+Gr/NFN1a356webih9nQCbtRlA=;
        b=lq4mnyUfUnu0BzR6Wiz2LqRbI6UXI+AlM29AzDRsgBJJEGxcudKiSVmcZVkBdH1V5R
         H9ihEHFWxShy/iMqODNdF03wxTXBQYKV/ZiBFz64MRdzRlBLWokuqPF3y8/2M49e7xEO
         8cpdAI1hx+7n5zGDn6/weEZdRv67FbbRqt0zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ax+zgGQyyKWqqmUNa+Gr/NFN1a356webih9nQCbtRlA=;
        b=suvpyVCih4ov+2iiUbDuM/UOIyxGGZeJ9Hoe2NRwh2xqFpZHo4nxOuIjl0txZeryT2
         VaeNpDVQI/WcCyQRdfW+RWK9NEieoXZjwJdPZcXTD8Y+JlgtPTSPYuW2HUAO/dL9I9v4
         NSjJpI+N2Wc97rGpMAVvXPRDzHzGR7ZfsTjBPvb3TwK7RcBl8Hs4PFQ17RDNnSr6Bn8k
         tLW0k9ZXLIG+b/XxGlgkTQ43QEaQM91jo/EAHtkQObW2JlQU9VfvVOT+1k/qtZS9bEI+
         09L11bncrZ2A1+PMKd1ZxLAVj9W3u1YTRxIISylyaKEhs9JfMam2EAnn4MQaH5SJavnd
         yvjw==
X-Gm-Message-State: AOAM531esly421Zzhjin15Hxm73DN9bv3neQhuXgvYPopL+LgK+dJtet
        ExAL17yP7R4dxczMlO8Tkp4C1w==
X-Google-Smtp-Source: ABdhPJzyIjueAdPLPELPYzMN0XC6MvF7sAwGHIqciSmxWkbnOpbPZS4x4gmcwTPLeXlwCj4QQRQGWA==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr37649101plk.137.1643921137797;
        Thu, 03 Feb 2022 12:45:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm30543226pfu.93.2022.02.03.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:45:37 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:45:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202031242.45A7F5704@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook>
 <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
 <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 11:50:34AM -0800, Nick Desaulniers wrote:
> The kernel does not link against a libc; but it does provide many
> symbols that libc would provide, with the same or similar enough
> semantics that I would strongly recommend we _don't_ use
> -ffreestanding in order to get such libcall optimizations (there are a
> lot; see https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp
> for some examples) and simply use -fno-builtin-* when necessary, or
> fix the kernel implementations individually.

Right, we really don't want -ffreestanding. Rather, we want to not link
against libgcc. This is mostly true already, though some of the smaller
architectures still do:

$ git grep print-libgcc
arch/arc/Makefile:LIBGCC        = $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
arch/csky/Makefile:     $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
arch/h8300/boot/compressed/Makefile:LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/null)
arch/nios2/Makefile:LIBGCC         := $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
arch/openrisc/Makefile:LIBGCC           := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
arch/parisc/Makefile:LIBGCC             := $(shell $(CC) -print-libgcc-file-name)
arch/xtensa/Makefile:LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
arch/xtensa/boot/boot-redboot/Makefile:LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)

-- 
Kees Cook
