Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6FC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B393760F92
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhJZRPe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJZRPe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 13:15:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE7C061745
        for <linux-hardening@vger.kernel.org>; Tue, 26 Oct 2021 10:13:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so2258856pjb.5
        for <linux-hardening@vger.kernel.org>; Tue, 26 Oct 2021 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yrmkCQHJFs7jT3j4srCwuTFxT46fq1JYlYNnrrYQVwY=;
        b=dEb0XmqzOGgneeeAnDHgpvf7/T4ug97tqG/wcagI88zsdX1nnM8z8ny9kqiUkmIaQQ
         dBBvPCW5KDjlEvUvd24xijGpjGwXPPSYyg34w7xjS1JjRFfEXgAMUjnyd+Q++i7/E6dz
         I+Iv8mf4nE82ZCM9SltM8U0gACz2REhi/oyCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrmkCQHJFs7jT3j4srCwuTFxT46fq1JYlYNnrrYQVwY=;
        b=h950L50/999B1RxXGOwtbp+A8/fPfPNyNTB6Kk/SGmchMpazJCYEAtvq1y1VYftaRr
         4xePJr0DR1Ia2StkpycqFWICBIGu1bqprOVGRmE31P8smQgHfXg+jABIolsqvbxs+0/E
         cNkkPhlqjlyZxrgiY0vZMFoMrbV8jLFhZdxcx0JJHCoiETjpCKBgSmwksMWQkcEOS8J4
         3tLhhRj69HB6sRmvhNljqbOj33x8CHDgqsczr1soquh0RQ1LtsRM5MJGcfS2ewsJdQ+B
         XT8CxjUkHz5+/zkJXPN7jF6GmSRUVLHD79eBs6r8qbH7LimL6sVjlY+orfKwb2xRCb2v
         xDVw==
X-Gm-Message-State: AOAM530p2Y2Tif4tELjWiosVFEAdrcVsn/3zAbodASicEeBoPR47BFxv
        qTpgyf6QH7Hr3un1VqLAujqcVkhFDj6jhg==
X-Google-Smtp-Source: ABdhPJzq2ESzZvY6bhf9nD4fcZtnlCpjEftXf9IRdl90S+tI7clQXqI4SIlRgvrwB25kGz9PWIneow==
X-Received: by 2002:a17:90a:7607:: with SMTP id s7mr30763991pjk.59.1635268389943;
        Tue, 26 Oct 2021 10:13:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm3561118pfv.123.2021.10.26.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:13:09 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:13:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>, Qing Zhao <qing.zhao@oracle.com>
Cc:     linux-hardening@vger.kernel.org,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: Re: [PATCH v3 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Message-ID: <202110260959.25C44F4@keescook>
References: <20211026081836.3518758-1-ardb@kernel.org>
 <20211026081836.3518758-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026081836.3518758-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 26, 2021 at 10:18:36AM +0200, Ard Biesheuvel wrote:
> Add support for accessing the stack canary value via the TLS register,
> so that multiple threads running in the same address space can use
> distinct canary values. This is intended for the Linux kernel running in
> SMP mode, where processes entering the kernel are essentially threads
> running the same program concurrently: using a global variable for the
> canary in that context is problematic because it can never be rotated,
> and so the OS is forced to use the same value as long as it remains up.
> 
> Using the TLS register to index the stack canary helps with this, as it
> allows each CPU to context switch the TLS register along with the rest
> of the process, permitting each process to use its own value for the
> stack canary.
> 
> 2021-10-21 Ard Biesheuvel <ardb@kernel.org>
> 
> 	* config/arm/arm-opts.h (enum stack_protector_guard): New
> 	* config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> 	New
> 	* config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define
> 	(arm_option_override_internal): Handle and put in error checks
> 	for stack protector guard options.
> 	(arm_option_reconfigure_globals): Likewise
> 	(arm_stack_protect_tls_canary_mem): New
> 	(arm_stack_protect_guard): New
> 	* config/arm/arm.md (stack_protect_set): New
> 	(stack_protect_set_tls): Likewise
> 	(stack_protect_test): Likewise
> 	(stack_protect_test_tls): Likewise
> 	* config/arm/arm.opt (-mstack-protector-guard): New
> 	(-mstack-protector-guard-offset): New.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I can't speak to the specific implementation details here, but this
builds for me, and behaves as expected. I get a working kernel[1],
and have verified[2] that we have per-task canaries for arm32. :) Yay!

Tested-by: Kees Cook <keescook@chromium.org>

Who's best to review and commit this? Qing, is something you're able to
review?

Thanks!

-Kees

[1] https://lore.kernel.org/linux-arm-kernel/20211021142516.1843042-1-ardb@kernel.org/
[2] https://lore.kernel.org/linux-hardening/20211022223826.330653-3-keescook@chromium.org/

-- 
Kees Cook
