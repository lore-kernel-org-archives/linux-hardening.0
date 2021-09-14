Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E1C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EE6610CE
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhINTrk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhINTrj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:47:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE772C061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:46:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i4so846665lfv.4
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJoP/OqIzovh+f7RN/ZmhSCTt8+2LJh5ljOOfisx8/A=;
        b=CCXklwHg9kiNvnZWRukTby2pDIPeoMSxmSeHJzt+vLgD8NR5uPjZwbE6bx7MH4vGHZ
         QY1wW/6RJzP6zW7pfLxLTSw+QnhAbhj+XtHwjkJRVCqUsLQ7WTLcEr3rhT8fp1IAGUR/
         z3ksXpK5imnJv2Xzo5Nz4/p1ysDmSUwVGZS3HgEsoYYHKQ+OJ3oyqbOUvLViN4hZEvbs
         afwNVOmQGGTyCJOf9WsOaSB237K1IdfgmZIWgQ7CAbgXO9h2xo5DID/FvNVQLOmoC/Wd
         P5fJcPNEgddzeiE6a5ZiNE3kYhwlVatVfen/Nue2r9zMfroBicCRPstvt89qbsQszfHp
         lQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJoP/OqIzovh+f7RN/ZmhSCTt8+2LJh5ljOOfisx8/A=;
        b=l3bhVJuof3Fv6imp8QInlmfWuXsbGoX+2tXT89FfoCA7PVME+LLIeI6naCvC0tRBIO
         epaUy40S9QyYx/4knNYu5pTwseBdRtItVUIQKnO53CKZIHXMU2F/uEgCNGVUz0iyikS+
         03yk9vw5vb6e4BHPFUAhTPWQo4RJP+foDi44hjISREP3EMCaKCMnfkr1PVXUxu21pMt/
         b3g+D0jqmuONgiNVmTQ1nlcMN5g267xGdtnMzb1CZBM5Qwsz1Y05ZKO7JvheQtcIv3Zo
         mcYg36oM0nBVL/aSt2SfzskebEvuzQFSA5UfEMavTh8q8dmcEf3BpTMDfaDX6tLn45Af
         CZYg==
X-Gm-Message-State: AOAM531vzOm6pCxFbnUOq7EgDjgGuH8A6vlX0ySH1HRj51U0LrQBvORH
        LO325dNmYA9n1HFnqIsgCluqlKHtAQm68vrq2OFT9Q==
X-Google-Smtp-Source: ABdhPJwxMW3WhfPkamXqYeMSjNTgE7RuclPcDOmDe8a9WaD1GnvpXOb90wRrGwAG4pV7hkqsRsXFiR5LDQ/Egb+xexI=
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr14633288lfu.489.1631648779874;
 Tue, 14 Sep 2021 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-15-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-15-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:46:08 -0700
Message-ID: <CAKwvOdm1dy7RiSfP1Ra1ek08OQ=8o8FDnrMdW44e6ZssgPbCAw@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] x86, cpu: Use LTO for cpu.c with CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
> indirect call failures. CFI requires Clang >= 13, which doesn't have the
> stack protector inlining bug.

True, that was fixed in clang-12. I hope to one day use
__attribute__((no_stack_protector)) to clean up this chem spill.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Technically, GCC still has this bug.

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/power/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
> index 379777572bc9..a0532851fed7 100644
> --- a/arch/x86/power/Makefile
> +++ b/arch/x86/power/Makefile
> @@ -4,9 +4,11 @@
>  # itself be stack-protected
>  CFLAGS_cpu.o   := -fno-stack-protector
>
> +ifndef CONFIG_CFI_CLANG
>  # Clang may incorrectly inline functions with stack protector enabled into
>  # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
>  CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
> +endif
>
>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
>  obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
