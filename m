Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25198C433E9
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023DD64FA3
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCLCnz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhCLCna (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:43:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E20C061765
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso7795388pjb.4
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=fS3ImwrxxM2DE3EPiSqkkSbtg7AkezrPZEd01kE1dWcZszmGj9zSpFTelfDiqstTga
         WftPqqERieBGyxCVAYbjYrgDbk6A5YKAfLzSpkArBkvYk41+DSZTjZOqaRsE43dgsGh6
         xNgvTqcdZWxl1z22bhI6cbBrEqddMCMIaR2WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=Vabog2CHOF0NPFjdf9OqrH8s+w8mRPlMdRqe7pYhPBBJnxZ6juqFtixdEQLKYKe1tl
         FFw57UJRTO4OdhI7osTRQ42egeyeOLRirI3/tfiBdAqTx4VNeVIaUZbbfbrVDIXKFbaq
         zGxUEtTR54lfkg52eJwQmZCCA+xxYc46dg9XGl6ULsWXX2Y3KwFDiQUmLeyUE+XaD2XJ
         ppts5Mqs/o2rKz6XA+5QwsBfMiPJzi4yC7V3M0Eb7VY1aM67vuSHrAWZc3plmGWi6j6a
         XjZ95Oo4jYbTUjukSGW6p82q18lSuiJFuNogo5rPglNGmFT5S9OrWMRSKs2OnJ92RYLM
         5z/g==
X-Gm-Message-State: AOAM532dTNxf6Z00NNUTpHsj7wnu8rMzYW0HouYBRthOpn9B+ZF29YwS
        ukCc4S2rRlILOEvBcl0mMS39Ig==
X-Google-Smtp-Source: ABdhPJwJNeCPNAMR2ch3Yz24PwKhscrbLVrh74rWQAy51W9PeIe5O7weL/Cd+eYEYu9YKFOgM7LJSw==
X-Received: by 2002:a17:90b:686:: with SMTP id m6mr11513193pjz.26.1615517009803;
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s19sm3652536pfh.168.2021.03.11.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:43:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with
 modules
Message-ID: <202103111843.9456B460@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __kthread_queue_delayed_work from a module points to a jump table
> entry defined in the module instead of the one used in the core
> kernel, which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
