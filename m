Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F6C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  4 May 2022 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiEDQqB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 May 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353565AbiEDQqA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 May 2022 12:46:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA172B258
        for <linux-hardening@vger.kernel.org>; Wed,  4 May 2022 09:42:20 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7c424c66cso22010407b3.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 May 2022 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E92Kc9QSviCU9YuL/lueHEE6ZF2RofRyLsLK9SHZEnk=;
        b=R8J/TT07oYrufV49kAQ3YHUSBYTRi7VEcKUu2DfAyEmJj8PSITMqzsIwsc42rLW0Z0
         8nbWQlU/3RQsgiPhNrJHyn+j7/r1tHvcdC6pOIDDLMIUbbuQvWvEJ4v0ZwdnCpqcnsPy
         IHt0rZWHVl/W+W61m/2q9L4SKno8dnBt1LDMp/DSlvHFouKxP9qED+QMAElGsdC7DfnT
         EI2ogF/23MepFXVgjP+dbKj0WscxN2MPaSE6Hq2SP2VvUE7CEX0KNydbZL0JAY1rsn0A
         qaimhFH3XvY8D6dEErQUro/i8/3eN0G150VIlkGrGf3Zt+8rLud9fme683BmVndhj7Rf
         TTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E92Kc9QSviCU9YuL/lueHEE6ZF2RofRyLsLK9SHZEnk=;
        b=1nIHvl/UNuUjo9oEutv2TLIt0ZF1ZQMSpmNd2XUdjsQKWF6/Wq3nc7GB8ewK9EUtN3
         +QGeUkMXPbZAKMHko4qw0nIkIO5thTqGa8NxMryggKyLBM0QjIRz17lGt2icLtWma84N
         IcMuijaH/KBriCzQGeLXDutBP2Q1ZZkBKi7wNSlhSCXcr4VGiQpOA6rTHzyahzi5NRDp
         8v/g/dmKQVtwMY2ucfFE0D8X5Ie46CUulxujgz7+Y6iCYHsZkxtHLbHuaQra5isHevZr
         Bf3Db87SSj3oLN1HTmOKFyXr5vuHjE+SpGXEVJiiUXrKM4E2KFiggUUMaF6PF9CpBbcV
         oOYQ==
X-Gm-Message-State: AOAM5303lIqXWIYE97ysKtMU95b2bUY3w3q4+vV1gfzxzYrRNh8UaCqL
        0ritAnZJX9VtXYSC26pEh570losIcZmr8/Htv2X34Q==
X-Google-Smtp-Source: ABdhPJwB5M3V9c+Qv29Mq6hOLNSkS/Cx5S+8NXTtckXjYvD9wrbuciGbXqgPOAtbV19GJMbODjTK/MWJYRMmEhMP+pU=
X-Received: by 2002:a81:1e14:0:b0:2f8:c348:9c62 with SMTP id
 e20-20020a811e14000000b002f8c3489c62mr20003528ywe.291.1651682539258; Wed, 04
 May 2022 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com> <YnKnLyyXPJl5Llc0@FVFF77S0Q05N>
In-Reply-To: <YnKnLyyXPJl5Llc0@FVFF77S0Q05N>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 09:41:43 -0700
Message-ID: <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
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

Hi Mark,

On Wed, May 4, 2022 at 9:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> I wanted to give this a spin on arm64, but I'm seeing some very odd toolchain
> behaviour. I'm not sure if I've done something wrong, or if I'm just hitting an
> edge-case, but it looks like using -fsanitize=kcfi causes the toolchain to hit
> out-of-memory errors and other issues which look like they could be memory
> corruption.

Thanks for the detailed bug report! It definitely looks like something
is wrong with the recent switch from std::string to Twine in the Clang
code. I didn't see this issue when compiling the arm64 kernel, but
I'll take a closer look and see if I can reproduce it.

Sami
