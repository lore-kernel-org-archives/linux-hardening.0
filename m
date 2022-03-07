Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B48C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Mar 2022 19:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiCGT5i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiCGT5i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Mar 2022 14:57:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2AB8933C
        for <linux-hardening@vger.kernel.org>; Mon,  7 Mar 2022 11:56:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so15277836pfv.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Mar 2022 11:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=824w31sz3AEThlb14ikJs21AnVwPrOxIQO0R0+Md1/A=;
        b=HndUH1Xb9cowgiuAXkvKN+0oL9Mvyg+dNEvZzV5bYrd+whqiHS1WKyVIAKTlTywur2
         JawTwVaKQDro31jXhHitKZju/U8Zqfsj6I0vftpI4J3YgDuvm4jZQ0rEj9RnAKq0Il+m
         sZDafCgOTzehP8uErNlnGCfHJdd593ME2FJJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=824w31sz3AEThlb14ikJs21AnVwPrOxIQO0R0+Md1/A=;
        b=UnJ52orLnwLBs0uJ+Mp59iF1ZNiEeMqO5QjaYUygbWEtPQZV7ccW8p+VASMxJqFh1J
         PhHByiFKA7N65QWyEaeCF9fTyCqoXSmMeHvrRUZ15T5a1IU6j4tHrDfduHFSScLhLKJt
         KqH3Iske0zuJWqHQxPoY0Iqxybsxotgo0Ruh1ofy5GtbuAIfwTFnQilEvN474LoY8DBH
         OpneA9vjfUv/C1e24+Ifq38/dbSLOQjK9g4RxMTPxPJumtRM2dA9JdyXaPsjESvFvnYX
         ASyAfe660k7w5O2COAM1EUKEO0sWIwBuOHlvwGhhts1rRvEEZphDjiZgoL08Z4eA7dDB
         5cWg==
X-Gm-Message-State: AOAM532yqtuaSQ1tyPK1iG/FNCfeJyPYlP1nKcKA7iS/R3/v5SQfTX6+
        mKQvSmfhQ0uXcG2oFBuoTgth+Q==
X-Google-Smtp-Source: ABdhPJzdkqQ8s7un6gcUXYfuo/RDufjZ6e7iolH5Pb3pzTaALVy2YruWUkI2UuOj3GWsAbEDTqpBqQ==
X-Received: by 2002:a63:2c53:0:b0:373:7234:adf2 with SMTP id s80-20020a632c53000000b003737234adf2mr11138988pgs.111.1646683003219;
        Mon, 07 Mar 2022 11:56:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c34-20020a630d22000000b0034cb89e4695sm12838449pgl.28.2022.03.07.11.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:56:42 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:56:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] xtensa: use XCHAL_NUM_AREGS as pt_regs::areg size
Message-ID: <202203071156.8BA231E@keescook>
References: <20220306064435.256328-1-jcmvbkbc@gmail.com>
 <20220306064435.256328-3-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306064435.256328-3-jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Mar 05, 2022 at 10:44:35PM -0800, Max Filippov wrote:
> struct pt_regs is used to access both kernel and user exception frames.
> User exception frames may contain up to XCHAL_NUM_AREG registers that
> task creation and signal delivery code may access, but pt_regs::areg
> array has only 16 entries that cover only the kernel exception frame.
> This results in the following build error:
> 
> arch/xtensa/kernel/process.c: In function 'copy_thread':
> arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above
>            array bounds of 'long unsigned int[16]' [-Werror=array-bounds]
>   262 |                                 put_user(regs->areg[caller_ars+1],
> 
> Change struct pt_regs::areg size to XCHAL_NUM_AREGS so that it covers
> the whole user exception frame. Adjust task_pt_regs and drop additional
> register copying code from copy_thread now that the whole user exception
> stack frame is copied.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/include/asm/ptrace.h |  7 +++----
>  arch/xtensa/kernel/process.c     | 10 ----------
>  2 files changed, 3 insertions(+), 14 deletions(-)
                                     ^^^^^^^^^^^^

Well that's always nice to see in a fix. :) Thanks for digging into
this!

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
