Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855CC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiFMTKh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiFMTIF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:08:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852F2BD0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:04:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 123so6077642pgb.5
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYjZASrY0U2vsg4+Z3fayp87EJ3UDw4wIJr7nvni9Ek=;
        b=kNia3fP4ii7v3FKDIFgRBPRWs8JCjCOQhwBs1YRrgihciGcfP3UczdQ1NP3WROY9gc
         SZq3nrWT95sCnM+OdH/rH54w6vklvee85Zaway/3supSPaXdEbvAZ28Zcq2Eshaug/N/
         holljJi3raKp7VZN0MKBK/+0OmDZGbgPymy7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYjZASrY0U2vsg4+Z3fayp87EJ3UDw4wIJr7nvni9Ek=;
        b=uBy1MN5cECBczZ99fvlp2XrkHTB+5w6zsJgyeC8rVB70qN4J+VBUogGr7oxNq1ZNOs
         IxHPTMK72Pj8ZBaPnFhiszmZcQ6Un/lcJNcFOkfcV4KvttZRFzOWKGhDaAo9PZjlBBNv
         KlNEOmbqr/zL/fyIHd5dJLOSZP5GcGiZbanZychVLSdPdCs+5I0yqBDvTHWemcxNsjoa
         stGVAb5iDx5KkJKFh19LUaojtKU8o2RrP3LsI/Hkd8cDPo7yaQbLx+auiiMKxFPFQsLr
         qlR2aSdEADcPNVfZ0GFpXonChT1bNRn1RyBWNlrbgKVgfACZqfS4BVxIE272WZfI+dEM
         b7Rw==
X-Gm-Message-State: AOAM531M+zgztykqXfY3dotcQJec+rkLxyTsWABY+Dbp6AfPPhsoP40w
        vmeQSXRA5Bsetc4DdZsl0toq0g==
X-Google-Smtp-Source: ABdhPJxK4IuPlzJj4yZnVw7e7eKF60w/wpE1r9dvdOhFJv4qrE5RYKrR7ZvbsO0AYyeNTkD2MhrnGQ==
X-Received: by 2002:a05:6a00:8d3:b0:51e:740f:8d60 with SMTP id s19-20020a056a0008d300b0051e740f8d60mr269277pfu.55.1655139853944;
        Mon, 13 Jun 2022 10:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b00519cfca8e30sm5615501pfr.209.2022.06.13.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:04:13 -0700 (PDT)
Date:   Mon, 13 Jun 2022 10:04:12 -0700
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
Subject: Re: [RFC PATCH v3 00/20] KCFI support
Message-ID: <202206131001.6BA9933C@keescook>
References: <20220610233513.1798771-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 10, 2022 at 04:34:53PM -0700, Sami Tolvanen wrote:
> KCFI is a proposed forward-edge control-flow integrity scheme for
> Clang, which is more suitable for kernel use than the existing CFI
> scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> alter function references to point to a jump table, and won't break
> function address equality. The latest LLVM patch is here:
> 
>   https://reviews.llvm.org/D119296
> 
> This RFC series replaces the current arm64 CFI implementation with
> KCFI and adds support for x86_64.

I think the "RFC" prefix for this series can be dropped. :)

It looks to me like all of Peter's concerns have been addressed. I'd say
let's get the Clang side landed, and once that's done, land this via x86
-tip?

Peter and Will does this sound right to you? It touches arm64, so if
-tip isn't okay, I could take it in one of my trees?

-- 
Kees Cook
