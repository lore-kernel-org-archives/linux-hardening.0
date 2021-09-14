Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D2C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3057F600CD
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhINTbr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhINTbq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:31:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CBC061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:30:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so2687370pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrjLDI3rk3n/iE7R3MDi8dHAYy5wuiJVn0w/n/EsYnA=;
        b=eE3ivPTpv/AGUvvkvem+4BezTjlWB3LRwXtHtijRSpJTfq9lv0x5uV/h7BWRSAhuQK
         9+FOmrRELlQYIuBiz1kFK23lOXIOF+J4MNqXsHmU2GCgTum7uH1m4EeXygGkJsU93nJI
         9SUXjo03R/RbBR/hF90ZY6JVNrPRvJcNrnShk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrjLDI3rk3n/iE7R3MDi8dHAYy5wuiJVn0w/n/EsYnA=;
        b=gokEy1J4eVgrd1eTVfm2bZevUx/kBgSAlluFToc2eIam2a5axDup7hhRULFZOC6gEg
         JeW9z71h3eBME7SXH7t1SQgCXPp87lxnXnb7i4ERJx5BliRw5wb7l+XIsnxHE8G5cFzM
         cvnHKzVeV1hxCBNgWqC9mOR8sNchBGa+sppCBvzTCwbA+08QqCJve26fIUcZRqIGW3Nv
         BsBe0/IxRMYz0IApZFcBb+KADZtERX/CkIfCajiNgycTCbkbMWu2MezTIJMRUOfQ6PJ7
         ztE88C2x302i6MdtDE71jJUXO0E3v3qDz4MP2qAhEPbZixy4zkYf4NnVyIa1Na/yISv0
         aYsw==
X-Gm-Message-State: AOAM532dShx8hUr7+SWt4hvUxuxgOQk+b839FDWpsbqAvHvSgrZJC48v
        +31t4UqQrpfdYTDWuM3UNgpo/Q==
X-Google-Smtp-Source: ABdhPJzX3GhfqYzv0s5WHJWHkFG36qgWwQqhOl130l2VJDgrtTrXppJ5+WcAXUMMbHlrTw7AqYonbw==
X-Received: by 2002:a17:902:7c8d:b0:13a:768b:d6c0 with SMTP id y13-20020a1709027c8d00b0013a768bd6c0mr16583479pll.83.1631647828551;
        Tue, 14 Sep 2021 12:30:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cl16sm2411732pjb.23.2021.09.14.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:30:28 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:30:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 07/16] lkdtm: Disable UNSET_SMEP with CFI
Message-ID: <202109141229.F1710D3A@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:36PM -0700, Sami Tolvanen wrote:
> Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
> jumping to a call gadget would always trip CFI instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Yeah, (thankfully) this test can't work sanely under CFI.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
