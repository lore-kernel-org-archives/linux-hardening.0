Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA975C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Mar 2022 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiCIRyj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiCIRyi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Mar 2022 12:54:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D23E2353
        for <linux-hardening@vger.kernel.org>; Wed,  9 Mar 2022 09:53:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e6so2609643pgn.2
        for <linux-hardening@vger.kernel.org>; Wed, 09 Mar 2022 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qmSmgs55XaXk15bGqog/U8JOQMvKGJQ0ikFM8ua87j4=;
        b=OSKDu/ib+3J2AKmp/olwVlOwOaCZPVW39eJ1BbNAHYCtFuzwmo8AYW9BwMNHgNA1tX
         lcaDZkkAohVeZmWLjkr8x5xnqS/ODlijPMxkfvWzWmWUAXTkdVO3hkPYGFFBS+rjzjlf
         MdRUQO1ELSotENGcSBwi4pS8B7Fhbs/+OfdaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qmSmgs55XaXk15bGqog/U8JOQMvKGJQ0ikFM8ua87j4=;
        b=iYKbdEg7wNZ18LF8ITWvokTQ4cdQrFHNxKgxH0Mlg8MigEdPhXQ0PXBNcADyhJwdsz
         1iJpXU3vwSGnQ+Fvuq8oTYJ981Q7sPN2vBbRj8Au18eFzkEcCWdhfsi7Hc7+E1XJz5xU
         FHrER5oWkgxdTuhUhJsyDFhzkkM2YcAXPh5vHVvYHUWJa/5wASfpVMIyH6NqqPwtUiNE
         E3CQ2127ZlYY9jwcHC5A9iP8mvZvdZ9hrIOZ52SKJ1weKKLAbyBbls4X9Ca0fxpdZVVK
         0Ay3diOym957eoEUabM7zXvh+0lAbbVGr82wQxXd9llZLV9f09V7u2ujAv6ufHtaGAHR
         SrKw==
X-Gm-Message-State: AOAM532QtaOZamIN9U+9dtcgABtcOB2eDR1m+TDDHf6euCO+ckhenIjP
        yqL6JZAFKl4xg4UPCk5eGbKmsA==
X-Google-Smtp-Source: ABdhPJyN4DQkJeA+BsHZknL/wPsqjWVAlxLMty4dze+Issnd8d9INcekBICbrX/aLQMKpE5jpH50pQ==
X-Received: by 2002:a63:4e52:0:b0:380:7c35:fc9a with SMTP id o18-20020a634e52000000b003807c35fc9amr726462pgl.376.1646848418509;
        Wed, 09 Mar 2022 09:53:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm3893798pfv.51.2022.03.09.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:53:38 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:53:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: next/master build: 224 builds: 30 failed, 194 passed, 97 errors,
 370 warnings (next-20220309)
Message-ID: <202203090952.70BFAA32B@keescook>
References: <6228d80a.1c69fb81.538eb.96f2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6228d80a.1c69fb81.538eb.96f2@mx.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 09, 2022 at 08:38:34AM -0800, kernelci.org bot wrote:
> [...]
> am200epdkit_defconfig (arm, gcc-10) — PASS, 0 errors, 4 warnings, 0 section mismatches
> 
> Warnings:
>     arch/arm/mm/dma-mapping.c:395:15: warning: array subscript <unknown> is outside array bounds of ‘struct dma_contig_early_reserve[0]’ [-Warray-bounds]
>     arch/arm/mm/dma-mapping.c:396:15: warning: array subscript <unknown> is outside array bounds of ‘struct dma_contig_early_reserve[0]’ [-Warray-bounds]
>     arch/arm/mm/dma-mapping.c:404:36: warning: array subscript i is outside array bounds of ‘struct dma_contig_early_reserve[0]’ [-Warray-bounds]
>     arch/arm/mm/dma-mapping.c:405:42: warning: array subscript i is outside array bounds of ‘struct dma_contig_early_reserve[0]’ [-Warray-bounds]

This should be fixed by:

https://lore.kernel.org/linux-hardening/20220309175107.195182-1-keescook@chromium.org/

-- 
Kees Cook
