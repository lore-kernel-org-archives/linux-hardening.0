Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA940C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC1F61350
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbhI3SxI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbhI3Swx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:52:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B229C06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:51:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y26so29513755lfa.11
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IO2yScWcP1V3nkSCAyqfJDaTb8wvqyBUDTytiX1OoYI=;
        b=soIWJ7+oT5oJYc/VTgT4oO8XQJsb/jD0w3MRT9k9qq1A9c1ZaQS3s4W/9o8W3j6V8p
         5pbIutFIOS6cJasSJhN7HM1fbbbS1EZuQNrp1sWV1O/EYelYQ3FYHKZUI1TkQ780sqnT
         u19dcZmAqeTRNMvKdNEa27nspq3S570gqBYkXrfvyQ/U+lKWVVR3vThrLKqp6vrKxPF5
         sLLrcLijrtzLw8qWLTxQ4Fy5SGVDtd2BvWqR/VpkNAGF/kZa9Vf+G36OzHJyJyKeTh6c
         36B8YtmmujuiiddyndiXgPesk2OsxgcSUoo/L4wl9kEpFWvicCQIK4PMFaypYyCPYhNS
         XKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IO2yScWcP1V3nkSCAyqfJDaTb8wvqyBUDTytiX1OoYI=;
        b=d/6X7lGWIiOiBac1rX3pKHjPl73FR+Sh98Y9wXQolsobivI8AgVzoJMmVy+SB0HJS0
         kYlZmMmP4baEQ7jebar1zv2mIfX1eCcwoCujmIWG/D9eEQNvu23r4dCAw1j1GUsbPcc0
         0/PSVpzM9w6EJKKZi8sq+WSqYOS0zksoBJ7aJe0fKTO3cOPBFpac2f9V09whx7O5Go0A
         xATZX7skS1oQyTKjD3IWovrGlBFHsrG+/swTi4E4MWrIwxp42rKHlb1kN3ICpptPGnVS
         RN7muj8JN8cuiS9VMLW01sB5TIBz5XDDQh9Fhc83d9e//Z0Ol29FfKeow9g5sXla+gmW
         JNqw==
X-Gm-Message-State: AOAM5304mqgDqGbqlC+2NSeDsJjUCJL0Z4kj/Ng4Tt0tCRA2Kz/QF76D
        YGD5NIdbBTKKtpI/T9/gN1jDNZ7OECbDEh5nBkdRoA==
X-Google-Smtp-Source: ABdhPJwliirpZ6GgdbLM//GKHu/jI+FUv6Eo6sSVuFPqLNLIXYKUMrEJTAvhFCRFN+Qnuok9jzqx8j5kXlYAdUyYD+s=
X-Received: by 2002:a2e:9b98:: with SMTP id z24mr7204666lji.339.1633027868339;
 Thu, 30 Sep 2021 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-6-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-6-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 11:50:57 -0700
Message-ID: <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> If allocate_probes fails, func_remove replaces the old function
> with a pointer to tp_stub_func, which is called using a mismatching
> function pointer that will always trip indirect call checks with
> CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> tp_stub_func to allow it to pass CFI checking.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  kernel/tracepoint.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 64ea283f2f86..58acc7d86c3f 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c

looking at 4+5/15 together, I wonder if this TU should explicitly
include linux/cfi.h?

> @@ -99,10 +99,7 @@ struct tp_probes {
>  };
>
>  /* Called in removal of a func but failed to allocate a new tp_funcs */
> -static void tp_stub_func(void)
> -{
> -       return;
> -}
> +static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
>
>  static inline void *allocate_probes(int count)
>  {
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
