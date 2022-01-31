Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7720C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 19:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiAaTEv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 14:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357946AbiAaTEu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 14:04:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CFCC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 11:04:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z19so28780421lfq.13
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7D810g+YtIFKHpIEkKZbUB8LHPefSFy/Cofo1oMsBQ=;
        b=EAwy9jHAqpGEf65pb3fSBDWQnW7n8nbU2haUVLOp7KYjIOUsEeGAI4/O/QQyTUel/J
         T/fyl8w+9SNDPbtoyNjNT3xylwe4knJsGIHExj6Ib/df92/YY1la3x8cAFAdkxxGGgOa
         nIN9aVk0V1Fh/5hJns4WnY8eL15utdOLqL49fLMlEdUfaa2bHdimXpR8qNz7XGd5Eill
         xBdrDKvJwDON+AP+5/ctOcfR3H1pqV5RiQVLAGuwxxoYxkdxL3p7oujqAj24byEOz3i7
         ROCkU4ZhDWJ9c154emV6G7Q6EdOwVNknFsRzHo5SSLKQ4xZKq8VnCjkvnB+D9fDl/qW0
         I/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7D810g+YtIFKHpIEkKZbUB8LHPefSFy/Cofo1oMsBQ=;
        b=Xk46WbHe6u4okWOA1bIO7G+FevTVV+er6YkpgrvQB5wwDsGgQEaPAkZan5xIcTQFpc
         kLTbX1KTZjVpAiVKl8pv4Hl//2sm+D9mzFWgBHzkLw/rlMZj5CPO+NgxjG2CxaMliY7Y
         wmxXiIQ4For0pIFqIBv4sz7gG3aRqfsNYYuq1OIsqTCYeg2fGhK5SGsLfqBC6l/jKULr
         hvrX6n858EGaogxttIzo4webVh4fByBOOAqu8n/zVzH9+AeTzRJnJOp1dzc4V2sun3En
         /hUqhwMwnKzIS65eMbUu84YD529/Hw2yrbCSWPzC4ygXU134WluMt1cjRiX/bmB1VfPG
         +f8g==
X-Gm-Message-State: AOAM5337MBPn55g2fnSzfZv0x9bg3RKfrCCPfbWc6qhyk+0/MKgPFr3S
        p5azj3H/iF77PAjDICzE88nBzF3n7dncPgIbJlH5CA==
X-Google-Smtp-Source: ABdhPJwB3A+CMUaytWKzeKMvWkUXsOxPbl9gFTdNMGyeMXxmOEOObWpWOXHNsQQQNZ6hpaAieycxW0JBpJ4cNNG6Scw=
X-Received: by 2002:ac2:4e10:: with SMTP id e16mr17074200lfr.444.1643655887933;
 Mon, 31 Jan 2022 11:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20220130182204.420775-1-keescook@chromium.org>
In-Reply-To: <20220130182204.420775-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Jan 2022 11:04:36 -0800
Message-ID: <CAKwvOdmrzO9U9Cu5zB07t1C+Xh-kAzk_F-MisAxsrArhJVhSNw@mail.gmail.com>
Subject: Re: [PATCH v4] fortify: Work around Clang inlining bugs
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 30, 2022 at 10:22 AM Kees Cook <keescook@chromium.org> wrote:
>
> To enable FORTIFY_SOURCE support for Clang, the kernel must work around
> a pair of bugs, related to Clang's inlining:
>
> 1) Change all the fortified string APIs into macros with different
> inline names to bypass Clang's broken inline-of-a-builtin detection:
> https://bugs.llvm.org/show_bug.cgi?id=50322
>
> 2) Lift all misbehaving __builtin_object_size() calls into the macros
> to bypass Clang's broken __builtin_object_size() arguments-of-an-inline
> visibility:
> https://github.com/ClangBuiltLinux/linux/issues/1401

^ mentions a difference in compilers for mode 1. I wonder if this
patch could "hoist" the BOS calls into the macro ONLY for mode 1 and
not mode 0 usage? i.e. the str* functions, not the mem* functions.

It's too late to fix these in clang-13.  If we get a fix in clang-14
or later, what does that look like for this header?  Is there a way we
can provide a different header than include/linux/fortify-string.h
just for clang-13 (or whatever versions until the above are fixed)?

I don't see this series getting backported to stable, where older
versions of clang may still be in use.

I'm tempted to say "let's get get these 2 fixed in clang-14" but we'll
probably have to trade something off the existing TODO list.
-- 
Thanks,
~Nick Desaulniers
