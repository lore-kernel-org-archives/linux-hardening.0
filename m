Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECCBC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  4 May 2022 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbiEDUVk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 May 2022 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbiEDUVj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 May 2022 16:21:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4434553B
        for <linux-hardening@vger.kernel.org>; Wed,  4 May 2022 13:18:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7ca2ce255so28119017b3.7
        for <linux-hardening@vger.kernel.org>; Wed, 04 May 2022 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQdnNmzv4usFcCEslqJZULlg/FXfYALoeT9o7toWf+k=;
        b=qxZZQ6AsGHlKFFmOKUtmMByudpi1JNcM2xDw70w505LXnF7lLC/fAGH//lR/VZSrlR
         bzYODkJGL2C4z48gkOhr1/f+95RehMweBA2jJko7pnpROeEw4lFeekw/gjN1Sr37kxgi
         VOMlKjWfiWZVgzx71URL6y09ubNYGY2jqAqF8+kHrivs8kT+ROvGvq/omyFx6GiYzqnh
         2HFIhB+NVMjgQxOjfu7xbPQLIRCzspV8NJf8VjKSPTDxgkMvVCPk7/5bkBeytyd4UZ3g
         nvxpwS5oICYNm4lV3uFPcMoYAXHHXPd6xQUHQRffNQmcC4ERg/4fgc/qsJtYGU/9DGZP
         TTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQdnNmzv4usFcCEslqJZULlg/FXfYALoeT9o7toWf+k=;
        b=pcq+Vzvdgs5oiJOWv1BJ0BSgRfEwUxr+RbgxY2TmzP5C1R4IMsUjw1EJDRmxoPf3pV
         apEpc5FYmkKzkbBeqummNNIjuiB2dqKlXaMxwAgTTcAr5+Qf9uDQZP+1VufyEAwQVc34
         +b7OqxORtp73diz9RaGO9BQiNAxRla4LKJnurYM3WbXP4U2Q0hpSLCKiRKaaYrEEPxl8
         ZZ9Mw2JjGe7IFK/Ls+gHSSSgR3JelPnhBW6fqqavY1dknIxGYZ0k+HAzzTt2Zz5OHgPH
         LZTIVdSfrmlQrzEUHFO59GHi4VZYIcUxXWZqnZ6pP0ohd7cLQNC2FShQgc8+L/9hAELH
         caBg==
X-Gm-Message-State: AOAM531N/48xr+2heQyussw3s53sHavB9Wa8unLus0uWfpGN75d5bYRk
        7zOOMM1N2CW4AtMbIU3BLCz/d6b6gpq1fHdeIMWwSA==
X-Google-Smtp-Source: ABdhPJyFwC10hGfB50VlWpxYYTkP/wq9NopFODyumnAGFAWmCLhvv/zUfhxhlo8Okdy8beVJXyf/MQoiY2U1PO5ibCw=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr20076337ywk.243.1651695481261; Wed, 04
 May 2022 13:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <YnKnLyyXPJl5Llc0@FVFF77S0Q05N> <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
In-Reply-To: <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 13:17:25 -0700
Message-ID: <CABCJKuc-6daZd8N6hQV6i_TtCtVpfzxJ2UW6xwxC2vxTmJ2deg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 4, 2022 at 9:41 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Mark,
>
> On Wed, May 4, 2022 at 9:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I wanted to give this a spin on arm64, but I'm seeing some very odd toolchain
> > behaviour. I'm not sure if I've done something wrong, or if I'm just hitting an
> > edge-case, but it looks like using -fsanitize=kcfi causes the toolchain to hit
> > out-of-memory errors and other issues which look like they could be memory
> > corruption.
>
> Thanks for the detailed bug report! It definitely looks like something
> is wrong with the recent switch from std::string to Twine in the Clang
> code. I didn't see this issue when compiling the arm64 kernel, but
> I'll take a closer look and see if I can reproduce it.

I was able to reproduce this by turning off assertions in Clang. It
seems to work fine with -DLLVM_ENABLE_ASSERTIONS=ON. I'll go fix.

Sami
