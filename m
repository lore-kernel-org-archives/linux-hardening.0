Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8506C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 22:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381624AbiD2W4h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381623AbiD2W4g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 18:56:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA847B3C64
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q76so4485757pgq.10
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JrJ5Up6tIRRW5Mxs+/9PXH6BK6Q48YyALZseWmr3avA=;
        b=esBlUhglB9jCI2Ncth42eo2IMjtAy4YW4mTLvt3OzArSE3z90VovKH/o+BFbP3EssP
         JaCdFvrUUP7i40tzjcYF0lquuriKN1llnUUyvzwFwrGkI7j8MjvoA0RgJ17uWCOe5j77
         +igUVwBVzTTxT7qU1IAL9BiZ2pi/eoIAUusFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JrJ5Up6tIRRW5Mxs+/9PXH6BK6Q48YyALZseWmr3avA=;
        b=Ox7qTvu13AaS927dStjmsEWVEh8IbgAt1aG3oioqbi0OC2w30QnDZO5O2SC1fw/1pv
         8ZFY6hZFt77okHwchYtNq36x3qJ0k9ADgUqrsXH3z/66FlhVNkRHxgF4ObUS/29i8KDU
         cv/RPMGAftfCFDc1b2TwYGDiLcjci6+oZZr7GNSrHYBPdGYsaYoF/KBzqsOpMM+n1VvF
         sPQyHCzP3mGKPejCwGwUyZPliyBif4Dcm3CeK47MjimO2ZNbzLRmqIaG+HF64s9t28v3
         Z7n7inlccYDH7DCsTIDOjlh/o3wfsu/QBgY92rhDUbfI2H5Yi8RkCk1hVPGujJ30qN8F
         Eqlg==
X-Gm-Message-State: AOAM531DZP5gpWFB2x6UHgLkCTeteHeaQ3dxmDNIhhKUFsr19AaGwHvm
        n+RlPyda8dFDFRvQejkS0OmvAA==
X-Google-Smtp-Source: ABdhPJxRF8uHZoIH/chjk/MDQLywii0fw4j6ZVHcIMULfWZu1kPW+qVQqzNUfgv+DrkE51BUzUaAxQ==
X-Received: by 2002:a63:dd54:0:b0:3a8:f358:5b3f with SMTP id g20-20020a63dd54000000b003a8f3585b3fmr1141335pgj.97.1651272794165;
        Fri, 29 Apr 2022 15:53:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78808000000b0050dc7628172sm200051pfo.76.2022.04.29.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:53:13 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:53:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <202204291545.47C6A97EA2@keescook>
References: <20220429203644.2868448-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:23PM -0700, Sami Tolvanen wrote:
> KCFI is a proposed forward-edge control-flow integrity scheme for
> Clang, which is more suitable for kernel use than the existing CFI
> scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> alter function references to point to a jump table, and won't break
> function address equality.

🎉 :)

> The latest LLVM patches are here:
> 
>   https://reviews.llvm.org/D119296
>   https://reviews.llvm.org/D124211
> 
> [...]
> To test this series, you'll need to compile your own Clang toolchain
> with the patches linked above. You can also find the complete source
> tree here:
> 
>   https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc

And note that this RFC is seeking to break a bit of a circular dependency
with regard to the design of __builtin_kcfi_call_unchecked (D124211
above), as the implementation has gone around a few times in review within
LLVM, and we want to make sure that kernel folks are okay with what was
settled on. If there are no objections on the kernel side, then we can
land the KCFI patches, as this is basically the only remaining blocker.

-Kees

-- 
Kees Cook
