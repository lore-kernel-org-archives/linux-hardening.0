Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593CBC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbiFJXoH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351133AbiFJXoG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:44:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E43F4674
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:44:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i29so784420lfp.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LsNMVk4QkQcHLkW7ut/k0O0Yaykk6wclPSmWZ5ifsY=;
        b=AXZAoRjCkVTGzxCFmAzh/oJWaoE94oMVuck4U6PkHFXm8Manqvzoox91KP0798a6Vm
         Iif2fnd5/zxMLU0WowWFmFD02PIvRdYbdM8AOKWN07FLf7W3i8ZgvaVIN6ZqOrxJi+Q+
         SNwkOFBnJdiJ/iMD4ZIHySibtDyYLWJnDV2Jl+l/OlObxnNJPZ+Gp3oKP77OD8CHjZwZ
         K23us6sh34xesB0jnd7qxO7B7+aQb/9BDyvvn90C40zKoUSvdukZv2F1wed/pqp4HhyW
         RyYE0sGw1Hex9gbwwYSWvCdaNw4UJ2EJraztGTA91vxlzFCYZr6g/lyW+aOzEEe+E3Xp
         PqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LsNMVk4QkQcHLkW7ut/k0O0Yaykk6wclPSmWZ5ifsY=;
        b=szkPM+CMEWEXa/QkPcf1tEF0J3Ig6RVie/h5BkEYJV1pjuuEIVQrdDRrBILTLRY7Md
         iPTxUYvwfyTwnkbFwGeO8TJI2I9Dvx2w0yvaD1PCrbOKYkMM/N7dLJQhGxFXGx2l5O6/
         gVF2hXpTsvRg01M8lpnvKWT8VBtGe4SwALrNj8l3RS/CFQ2HJzR3Vz53WFZUGKdin2U3
         1UBG8Ww0wllVG9en7HP2f/zoBRx/6dj2ujUKQ1druZkfyzkfwr2lty/3xpeGOfw++8Vt
         pozWwy5l749GbJbxK0B4jJZCeMRCHCMmIaD9C7URZuNbPt9T3CNUqkDlV8/i9c8RAL11
         1i9g==
X-Gm-Message-State: AOAM532nlLaBvsI8YOHeQTJJNJ23ey4e7kQPU1WP0f7gh7px3AapxwIZ
        fig+/GcmicRUQGq2/oZb6a5FJSoL7ZiJaDIEmqCALQ==
X-Google-Smtp-Source: ABdhPJzmnqMLhs1bfP/6LgEEcErMYRF7zruVcTTGgghAvhoIJQutFqUZdi12symO64L5cd0aKgb51yl0Fh7DWLzLDco=
X-Received: by 2002:a05:6512:3f94:b0:478:7abe:de4a with SMTP id
 x20-20020a0565123f9400b004787abede4amr63212721lfa.401.1654904641567; Fri, 10
 Jun 2022 16:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com> <20220610233513.1798771-8-samitolvanen@google.com>
In-Reply-To: <20220610233513.1798771-8-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jun 2022 16:43:50 -0700
Message-ID: <CAKwvOd=GRwL6K7GxhiLhRhJVaD3a1VT6MD5fMR4kcYPpd5=0PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/20] lkdtm: Emit an indirect call for CFI tests
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 10, 2022 at 4:35 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
> direct calls. Move the call into a noinline function that accepts the
> target address as an argument to ensure the compiler actually emits an
> indirect call instead.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  drivers/misc/lkdtm/cfi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index 666a7f4bc137..b6b375112a2a 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -20,6 +20,13 @@ static noinline int lkdtm_increment_int(int *counter)
>
>         return *counter;
>  }
> +
> +/* Don't allow the compiler to inline the calls. */
> +static noinline void lkdtm_indirect_call(void (*func)(int *))
> +{
> +       func(&called_count);
> +}
> +
>  /*
>   * This tries to call an indirect function with a mismatched prototype.
>   */
> @@ -29,15 +36,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>          * Matches lkdtm_increment_void()'s prototype, but not
>          * lkdtm_increment_int()'s prototype.
>          */
> -       void (*func)(int *);
> -
>         pr_info("Calling matched prototype ...\n");
> -       func = lkdtm_increment_void;
> -       func(&called_count);
> +       lkdtm_indirect_call(lkdtm_increment_void);
>
>         pr_info("Calling mismatched prototype ...\n");
> -       func = (void *)lkdtm_increment_int;
> -       func(&called_count);
> +       lkdtm_indirect_call((void *)lkdtm_increment_int);
>
>         pr_err("FAIL: survived mismatched prototype function call!\n");
>         pr_expected_config(CONFIG_CFI_CLANG);
> --
> 2.36.1.476.g0c4daa206d-goog
>


-- 
Thanks,
~Nick Desaulniers
