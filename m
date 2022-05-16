Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08099C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiEPRRD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiEPRRC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 13:17:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177F35DC6
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:17:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e78so7122575ybc.12
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXOnPvl8QcJEDWbi0XN3Lq19sfoQAsf+gUr01P/rvlk=;
        b=OM8kgeKWnkTLRBZ7RTDJtDZ0OhbvjKtrtPVbHiJv9VobLZNWVHWGgo4QzJUZykXSZV
         S978AF1P+/+TQwUaWw5r4iAwDc1TIqRPVZfN1U/fYopNiHC0uAC28XABNd1kdXGW/Cn9
         Gzzz9IacrdlQD2sQ8SN0iUKwmUj7CDUv2AQqwHCBdIW+MTQRZO6d1YJo05tPskMcsXRK
         6bHxZTPRNql9kT25XB+YzCb9HV5qM8t/bbn/OP++K53Zdm1sI9eoAErldOq/3+coa2/H
         g7PnWG4un2TUvBbf5ZxcHBq0UFRQF7bpmF3t6OdWsOOkZt3u3dTwaYtW+RnaDr3VwLWH
         RLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXOnPvl8QcJEDWbi0XN3Lq19sfoQAsf+gUr01P/rvlk=;
        b=LjxmxpKHIutU2AFnvANw3uZGi8cdpoy5eyIaEx8II3kmvWpNo6uUZobJAruQkwiwe1
         iWmLNgwjIKaIiijSllUSDu8Zm/IEAYaXJoFa098nfb5ft1QP+pQiondTyk0Qxt6axaiQ
         Tn67bl0wrxTBNoCiHAA+naKJx+clJS23jZe9lvtN9pVRIMUMOoRsISpebVK/wtDwzlwJ
         syhm/8d3seTziBHPTYkiUYkaw2SMsI4/TEO4W1dENSudwFlyAbbL/f8yydZQiH6s60s6
         6OMhJAUqcB9If9U1jp4kV1cLn2Xr7wt6qSdZOjx1YDYwCFRi63y4gZ+CtWMi6uOoluZ0
         5vVA==
X-Gm-Message-State: AOAM531pTKYM8UpnczW4yFqPlQEXwHgdjrI3w/7/6XOSNYQs5DbJDMEO
        LiYLzRH+3oIgSUvNUlUhLtvj30yjYSM1cGWLwJpTew==
X-Google-Smtp-Source: ABdhPJwErdMw9lIEVb8u38lNc4NgNXjt+kXxu9dBYmAQWe/u7yXSrIRYHJOVxdd0pqgjysXHBrZd7vzZ6OxxZCayB/s=
X-Received: by 2002:a25:dc93:0:b0:64d:9c5d:d43 with SMTP id
 y141-20020a25dc93000000b0064d9c5d0d43mr6954243ybe.560.1652721420662; Mon, 16
 May 2022 10:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-22-samitolvanen@google.com> <202205141503.3D87637B85@keescook>
In-Reply-To: <202205141503.3D87637B85@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 10:16:24 -0700
Message-ID: <CABCJKud1j8RCa2khJBcDxpJA-kmhb1XYU8rJLca658oduEMeoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
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

On Sat, May 14, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:59PM -0700, Sami Tolvanen wrote:
> > It's no longer necessary to disable CFI checking for all __init
> > functions. Drop the __nocfi attribute.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Maybe move this up after patch 11 (the arm64-wide __nocfi removal)?

Yes, that makes sense. I'll move it.

Sami
