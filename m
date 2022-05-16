Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B6C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbiEPS5z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiEPS5z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 14:57:55 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704F3EABF
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 11:57:53 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2fefb051547so35960047b3.5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0lDvgtygkUQt/MUd8knhUulQHn3vRN7wQxbpMX/7kc=;
        b=OtkZKug+pHgQ2UZ/72x5bHwTEdoqxCQfEkm1QUCKIEgRffjKW3KbMb3c/K0hbgw8Hh
         4snt1OZnOFAGl+LpQ4hpHFIJxYGrgyUHb3MpltCQAyohc4EBc2K3cVdSQIPXWZTMCpAo
         xvkF6YXXSdLtGnt7ynxNOqwGwVVTZspuksDC6xnRRp98ABNh0U+IV0ZaF0Dke8RLQ2hY
         0zwsUzPrYM4NS77Te/aQXLi3uZ8/Pe1REWifevXQA7rgTj6p6tmReRBxgn3R2O7hm2fZ
         OJ6CVb4R6Yse/fCzJP36XXgjWUGVUJLUzzJC39/+B4Yu2HI44XK9AEZhZ/l6VNqETlCG
         d/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0lDvgtygkUQt/MUd8knhUulQHn3vRN7wQxbpMX/7kc=;
        b=X0y+HxhR5LEB9FSWtV1d8dgMQ9M2LnsIL+9v41P/BYfxPkASFHbdmkQEc/NMYLzJo1
         i5AlVg6hdx9Ko4NiUO5ysZGF7uqobyexXujadtqzJ2KI35EKNObk32br8h1qZ565taE6
         TOBYDaL9PQir5rPLZv9gU6YmXXAkoY1LEyO2mv67/3ksFc2pioyz9WaDNb8FM5NSG7KK
         fKz+a+h3t9sdRQ5y8Wiy5XAbeT8GizmfvPyaokK9HLaAahKnQ4AUG5URfVxuSPLrKZit
         CpSkg7jzHGA4EmiNERuVXnhtD++Q2OmehKFC9uJTWrjFix8SiqPz3vmcuePXP9Kexb6R
         sqIw==
X-Gm-Message-State: AOAM533C0jFjnXbtwr2p9pLnynJnUNoKiIM8+UbCOd6BOSl0n0KmlTuq
        zYTz0ADF2Bw4x2RVbJhsAH+tEfFkqhXi2D2mbpp6Pg==
X-Google-Smtp-Source: ABdhPJyxnegSHSL4esR4Y8T2LGVa+WGgTYoK2/N/07nmR8fbjF1kDUJlLs7zXniWb3x4daFZGwyj8JCag7XedUMNBVU=
X-Received: by 2002:a81:7953:0:b0:2fe:f8a9:7e45 with SMTP id
 u80-20020a817953000000b002fef8a97e45mr7139331ywc.23.1652727472248; Mon, 16
 May 2022 11:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <202205141501.92A22264B4@keescook>
In-Reply-To: <202205141501.92A22264B4@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 11:57:16 -0700
Message-ID: <CABCJKudiLBjsNHUTH6zqhYik0WQZwsM4OceYJadYKoDQYOFRXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
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
> On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > +#ifdef CONFIG_CFI_CLANG
> > +static void decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
> > +                         unsigned long *type)
> > +{
> > +     char buffer[MAX_INSN_SIZE];
> > +     struct insn insn;
> > +     int offset;
> > +
> > +     *target = *type = 0;
>
> Should report_cfi_failure() have some additional hinting for the case
> where target/type are zero? Like, "hey, got an inexplicable CFI failure
> here, but preamble decode failed. Yikes!"

Good point, I'll add an error message here.

Sami
