Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760BC43217
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B960619EC
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbhI3TH4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbhI3THz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 15:07:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12407C06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 12:06:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b20so29767982lfv.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gCA8R/q8DA5l/Yv1Vf3OioGIfO849q423Tpx5LPaTM=;
        b=AECqIrUylRKEXCIN5T+00SF+0yJ8GxO/5Agylwk+EUD5TXDWvWc9SUhEh+QdyepOCF
         JPrIGC96e+MeBJ9zmDLh1QGETXM6EfAdKicHFpyRhX6JBv0LJdAdJGHWgBkrO9iA/5nB
         2k9Z+EmR+JJQlScEIAfrpAhXWE9yhHU2gY03pTxXTmVz0t1csyMutOc0oPWHwYYFwtkW
         awy0OAB3G0YzSf8Ij8kREE1a1S4dXle1vXTEAl1ZEJljKw3EvDleYVzIjO58TCxZ3p+I
         D4LBkltjSBPDo/xHrgill2DgT658i7/jxgkxOjyKyuK3PAGF26Gk0ckenc7PV4p2fOX7
         7ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gCA8R/q8DA5l/Yv1Vf3OioGIfO849q423Tpx5LPaTM=;
        b=x3LrZBQ8Hb+PdQEYMASlz4nl1ixVSy/QfUFocZBOMIITzpXmIjlGK3PviDHD8hXdtO
         0gpC/aOSZdfi41pq+DRIeP1zrCzkH3HXqjpBEx1DESBZJ3czpIw7i3/CAUq5DmHpKpqQ
         5vtFcxquvy/90FQhFDKaLaINa9HVrabNkXkrqF591ZWAIlFNO6NgvOl+CbESe4Tcy/LA
         d6hT7o5BVeBX309WKrybCvmBD1kO0a9iuINlXROzO49b51QwPXw7KnOtobxGPA9MT5EO
         8cnTf5NY70E1Y35smp6rUUX9zQx/XMF5DeAlheWtuOLAAAZiicoLmFuMZLZON56Ru32e
         HrKA==
X-Gm-Message-State: AOAM530OJ24n5VuUpqZ2VGq9XlFYnpbnoYwXzaDsWzRMJ+evDH6DOLNo
        fTqsfLPbF7f+JkOQ7L4BuGTl74ZJELkGdxwprlkPdQ==
X-Google-Smtp-Source: ABdhPJy9zs84yOnD/x9yZpPrFP29J5YMCsH3vIcOjsBghvbxT/aOAXOzDmJlgx+sg0EByBaMvjAzsaR0WMTd9DlVW/4=
X-Received: by 2002:a05:6512:2294:: with SMTP id f20mr814723lfu.489.1633028770167;
 Thu, 30 Sep 2021 12:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-11-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-11-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 12:05:58 -0700
Message-ID: <CAKwvOdkcjAAzxTvYGSi4XD3DEFfESDTyCynQNWjdQ2zssF9sHw@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] x86/purgatory: Disable CFI
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

On Thu, Sep 30, 2021 at 11:06 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..911954fec31c 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
>  PURGATORY_CFLAGS_REMOVE                += $(RETPOLINE_CFLAGS)
>  endif
>
> +ifdef CONFIG_CFI_CLANG
> +PURGATORY_CFLAGS_REMOVE                += $(CC_FLAGS_CFI)
> +endif
> +
>  CFLAGS_REMOVE_purgatory.o      += $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_purgatory.o             += $(PURGATORY_CFLAGS)
>
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
