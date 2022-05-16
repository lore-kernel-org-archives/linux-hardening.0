Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E1CC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiEPQdd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbiEPQdS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:33:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A93B3F5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:33:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a3so8934179ybg.5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVOWBi2MNBuehei9huBnd/8loFbnwhqAiuOC/hCYUtE=;
        b=UMpVvjAskWnfR6g3ci4cMkPkNEchbPVQCDFZURqGgdGBGtyEU0+pfkHuIEsLxzzdxa
         B18bBKbFeo2JcX6Nz0IkEdagX64XxF2YEDcGnalbPkbzsdXHnZZGaCAZvltIUt8sXuPo
         zc+e8B4SuenU8MISBWZpTrjTRFvYcwbYxq6tk/fA+vLgbNtNdpbpv9n/FFbrhrGyS4/A
         hl891Clm6zzMg1ByvOjCgkYC1CBLqqCMd5UMKl7fYoxLVwfMTVOj3WL8d9fGHLWJxHp1
         HFHt9MPjqwqb5TyctUJdvK/tYMZpC5GtaKZHEttGWXNLnXoDb1+0WTqUO3MYlQIJ76Hw
         42MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVOWBi2MNBuehei9huBnd/8loFbnwhqAiuOC/hCYUtE=;
        b=GLM3jWvJE1OQbORdNGyEesRst0lbq9KAZqo+TSla0jmDnU6QOnmoek73gR8vGbuj/L
         8Qnxgdg2oWPET7kHL02o6p9J/Q4z8W1WYOORC0XPW1EiZBKogpQb9btpOo2TLuot/u6j
         4gazS22kRxtxMHywU6LNqcWg7b9CEwrypFbgh3gMW0c2Bfb2bCIdPJKqhYHFOwiaQHSd
         4iuFI71J9EHRROC0feeZ79GOYAXnHNHkF87O03FIC7/fz20k09Y9eZVXcazQ1RdiuohH
         MIrmp6KJpLXio8DnNH2b5r85Slro7J+SdJOth6UQ7pINLcmAToFCxb1OPkTjs62ww+rv
         a2nQ==
X-Gm-Message-State: AOAM533b0KbWlNAOwIsb2VjYP43neBb3//9t4uPjsbLypu9oFN1mFidJ
        mhoDYqi4NERljml9qsPD7VDGISmOyx2/FbvMEX1FPQ==
X-Google-Smtp-Source: ABdhPJxnm0eijYHOVmrixfo245yISpWoVL7JodzT9EqGHwvEuWoWte/Watn8vMd89vUvUVL2y2IhRQzqqpGLJpOURZA=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr18090305ybb.428.1652718783727; Mon, 16
 May 2022 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-15-samitolvanen@google.com> <202205141455.0A6F409@keescook>
In-Reply-To: <202205141455.0A6F409@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:32:27 -0700
Message-ID: <CABCJKudyuB3doGwcRpYNm-LrdEzjgwR3MTys3MmSs+vMkxhsPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/21] treewide: Drop __cficanonical
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, May 14, 2022 at 2:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:52PM -0700, Sami Tolvanen wrote:
> > CONFIG_CFI_CLANG doesn't use a jump table anymore and therefore,
> > won't change function references to point elsewhere. Remove the
> > __cficanonical attribute and all uses of it.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/linux/compiler_types.h | 4 ----
> >  include/linux/init.h           | 4 ++--
> >  include/linux/pci.h            | 4 ++--
> >  3 files changed, 4 insertions(+), 8 deletions(-)
>
> I think this is missing removing it from include/linux/compiler-clang.h ?

That was removed in the earlier patch that switched the CFI implementation.

> With that done (or explained why not):

I'll add a note about it to the commit message.

Sami
