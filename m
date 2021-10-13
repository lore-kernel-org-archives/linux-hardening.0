Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C98C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A06E60E96
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJMTGN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJMTGM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 15:06:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23488C061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:04:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so5158524pjb.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aGF0syKET/14pAZ283IwwssrcdQD4oceHIsj+/z6tks=;
        b=LnqQnYl3SGc8N9da5oJ7HSa9JQluc0g0UMXaBb59l0VvGm3rZTsDEJ3cWkzZmxjid/
         YJNnC+reIBHb27GLFgvmXO/GujmCskpdflq1rRdb/vMqb8PA26FHlXzR+mnQSz8fnRGI
         UrA48mlhSXLYQxTJEcuJCIvV3bQ4XLqFKLR54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGF0syKET/14pAZ283IwwssrcdQD4oceHIsj+/z6tks=;
        b=DAF0cG8lQcDUh/HIchOiMt3xullp2hLLVdHn4UzYiXRQDGVCu8g7EbIePfAPFA4YS1
         4djVmsQStw3a/t0jhX5/aZFpP/MK72QoQV8wdCSF3F5dipZhy1rda5IJM6ennV4V23Op
         GTl7JtWhjGJrEkwpYzl1VnFxrDjzvC0SWNHB8XL2DNZCSJfJ03rY0DJ3iDKIGsTxP6GV
         gv6u4yiZxJ1krdQGlkVOBw7wxwsYWSe+DIBG7nRJ1Q5KuDgA63JVqDkK3WeF6Q/ID5bp
         TC9wX9SFml9FP4nOUKJiCcDOXBmKkpIubjdrCOp4rnaNALGo8+pxTq/G8Y2C7hYtEk6L
         xVIA==
X-Gm-Message-State: AOAM530iZVBWKKBJM5bHykWWTXaXrDB/pK1jXteWRCH6BaLgpsn7zzkJ
        NQC0PkCw4WLgBX1kMseYul0iiA==
X-Google-Smtp-Source: ABdhPJx5pfyX8v7LhaYjRI5CoTPdMyHqAmlRIlZV4O0fS14bFrkrUzbhDoAM/N5JvBN2YmHRPA8MzQ==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr1137541pjb.135.1634151848679;
        Wed, 13 Oct 2021 12:04:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm248494pga.71.2021.10.13.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:04:08 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <202110131203.2BA230B8@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:49AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler changes function references to
> point to the CFI jump table. As ftrace_call, ftrace_regs_call, and
> mcount_call are not called by C code, but are trampolines injected
> as calls replacing the nops at the start of functions added by the
> compiler, use DECLARE_NOT_CALLED_FROM_C to declare them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks right to me...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
