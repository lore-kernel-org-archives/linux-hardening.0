Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF12C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiBHXAo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiBHXAn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 18:00:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D57C061577
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 15:00:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so760163lfj.12
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQGz6t0law5MVgqGGrzII5NWEt2DOl/FdzL0iPkOG9k=;
        b=E9TiYK6DZsY1U5F0Tz/ZT9q4LEvVWT6mkphsbB6E0Y1n5Dlkxhz4SP8L5DIe0g0vw0
         TBjFERjJM/SoPlnnskAFnDAxXbaaA/VBkK3AwKQZZQoeH0aXbtWhAa4ckS8Msfw9sMt/
         L/hwgWpDqGuZ26Xz3UnMuQ0f1DPRvr8rAwZpmJYC3SezqbcKajn15tKuUHb/A4Kq6NtJ
         I8jIqfhBUMKDLr0ovEbwGyHpY7X8wJB35ug8ElrKLDs/jIZGeIop6uAXzkxw3U0KSBRP
         HRW0PcDbqGlJDKpseICjPdFOfuyB2wOlgkYr3/iFjOdIE6/GrzEpdpJLM2ZvF146Jr3D
         ToMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQGz6t0law5MVgqGGrzII5NWEt2DOl/FdzL0iPkOG9k=;
        b=ZO4rwFUURbmh4NxJN0ZUurX1aRcqSRgUD9+Hdh/q5g6MF9T0RJFXZPAqLJb47TBNFE
         WOpDfse5059KUnlRYRXde7ZDvD+2oRyyaUADbBFmxc4yHA1k2A32k/GP+3jdoq2bfIej
         Ca8PmKAUo+z07q/0qORnQBIU2nMLd5Y3BebH1YNyofbK1eFhMpj/P6IKZYB14d+o5NyV
         QrrrWSlCiqTnhsYN7zChLABiASx+GtxUc3cSwTr+hnvRYEHKGIcnVcYzKzJ6+hdGUqsA
         oRnaAH2m84H07xssxtI6qwLNnksUEJOgsoCgHatDoXZfouQkAVtjlFx/HueCXX/xe6WC
         uqeQ==
X-Gm-Message-State: AOAM530+89/hACz4arG9ZKkhATz39GZ+E/9cgT8eXKqdWAjzblrdP7bx
        0aivlQXf/HmE8oeqMxepN0mpCCGYp/SML+HeQOn2xw==
X-Google-Smtp-Source: ABdhPJx8HIMe+XoTHDDgW/Bf8ZuBvIj0tal1BRdAYtu9iAQbllOd6YD7uh/lhTuv7ckF9ZyKCebOEGMWskDEAM7zE8g=
X-Received: by 2002:a05:6512:3f97:: with SMTP id x23mr2035026lfa.550.1644361237277;
 Tue, 08 Feb 2022 15:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-3-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 15:00:25 -0800
Message-ID: <CAKwvOdn0huB+HYMCkO9VEryg0AwPA2gpwaUJHGEvV+4846ytSw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] Compiler Attributes: Add __pass_object_size for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> In order to gain greater visibility to type information when using
> __builtin_object_size(), Clang has a function attribute "pass_object_size"
> that will make size information available for marked arguments in
> a function by way of implicit additional function arguments that are
> then wired up the __builtin_object_size().
>
> This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
> to Clang's __builtin_object_size() having limited visibility[1] into types
> across function calls (even inlines).
>
> This attribute has an additional benefit that it can be used even on
> non-inline functions to gain argument size information.
>
> [1] https://github.com/llvm/llvm-project/issues/53516

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: llvm@lists.linux.dev
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 37e260020221..d0c503772061 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -263,6 +263,20 @@
>   */
>  #define __packed                        __attribute__((__packed__))
>
> +/*
> + * Note: the "type" argument should match any __builtin_object_size(p, type) usage.
> + *
> + * Optional: not supported by gcc.
> + * Optional: not supported by icc.
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
> + */
> +#if __has_attribute(__pass_object_size__)
> +# define __pass_object_size(type)      __attribute__((__pass_object_size__(type)))
> +#else
> +# define __pass_object_size(type)
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
>   */
> --
> 2.30.2
>
>


-- 
Thanks,
~Nick Desaulniers
