Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56160C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbiBCUSi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiBCUSi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:18:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C280C06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:18:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u14so8302721lfo.11
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCptFjFQyDLvAsPO3z/ZgorjPLk8kmB9BpzPLd3AoP4=;
        b=oU0+M7arecnlMXbVakVlEAbRXu94xUaFY0/OPRW2P+9kwSq7vW/H9modIRA0te7zvl
         JmOP8qNowSrOi0+Ai5wnmVtBGBXoHOQAMC7R+IMa9lX6pqg35ZxG0eFiwl3AsUa+I3WL
         FB4uceRGDMwEe14GkECpf1T7X/hjtPbiB5AxQYkKB4xptkLaF4FWjyKDmSxHiJ9V7cvj
         OFWM8FDPOKuTXS7xOTrc9SlWJHPULVyS0ngCXxwr98p60xtKSefJQV4APo4xPAC9Igp6
         q7/jmw2s7gttwrXaesVHXCrvW6ZhUxMgJJnPgxFhuQlbNu4+xMFtqlTz10cY6W5rm6EK
         FsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCptFjFQyDLvAsPO3z/ZgorjPLk8kmB9BpzPLd3AoP4=;
        b=zy6oOAtwnjlhTtQISsPAqhrhd7igMU26tH4uVxGqjD1xjjhKbIQp9ol/qJVfM+of/Q
         oPBqcPuutbU255zJiEXSrg/4abbplXWumByMh07WtKIOYn/dytmlkak6rPon/EhkS/Tu
         UotwagRqMj9dkXnQJ3MHd/RpGe719Eib8SGNkIYhTDN1w0stKl643iuU9skDJLfHOvgG
         FvIvPqRRrv8wQOrGaWmcnz0FnPjxDdO4d9gq6N4gj35WJR/DDiKZP/bq6F6JxYL6Sb0G
         mrC+LMYrYoDSv74Ho9hANOzxNliI/Xwj+Kc9ZlVdxFmixwLk3qPU87SgwHoG8k0mKYxB
         RbRQ==
X-Gm-Message-State: AOAM531k3pKXicguYwlaCnUSrc0OjUvy17Gt3bwQWCfoNQ6U7RCrle4a
        x4SCMVbBAZiR770jVs/v+VLJAKSIJRoLmXaHys9bVL1D6llzfg==
X-Google-Smtp-Source: ABdhPJxVkEe48Bneez3y/gwEVbiSzb9e1vqBKgmV8jcTS2K/OQOrlZbIlrPKyO/N9wxFVDUCW6uI4ZY1VHbPi3L9vDA=
X-Received: by 2002:a05:6512:e87:: with SMTP id bi7mr28833062lfb.550.1643919516107;
 Thu, 03 Feb 2022 12:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org> <20220203173307.1033257-2-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:18:24 -0800
Message-ID: <CAKwvOdmzdQ+X2BsUbuVBWzFtaE2Vst4=ihNNR=LmOdozqQ5Ukg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] Compiler Attributes: Add __pass_object_size for Clang
To:     Kees Cook <keescook@chromium.org>,
        George Burgess IV <gbiv@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order to gain greater visibility to type information when using
> __builtin_object_size(), Clang has a function attribute "pass_object_size=
"
> that will make size information available for marked arguments in
> a function by way of implicit additional function arguments that are
> then wired up the __builtin_object_size().
>
> This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
> to Clang's __builtin_object_size() having limited visibility[1] into type=
s
> across function calls (even inlines).
>
> Since any usage must also be const, include it in the macro.

I really don't like hiding the qualifier in the argument-attribute
macro like that.  I'd rather we be more explicit about changing the
function interfaces in include/linux/fortify-string.h.

For instance, in patch 4/4, let's take a look at this hunk:

-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t siz=
e)
...
+__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
+char *strncpy(char * POS p, const char *q, __kernel_size_t size)

manually expanded, this has changed the qualifiers on the type of the
first parameter from `char *` to `char * const`.

I think it might be helpful to quote the docs
(https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-=
dynamic-object-size)

>> Additionally, any parameter that pass_object_size is applied to must be =
marked const at its function=E2=80=99s definition.

One thing that's concerning to me is though:

>> It is an error to take the address of a function with pass_object_size o=
n any of its parameters.

Surely the kernel has indirect calls to some of these functions
somewhere? Is that just an issue for C++ name-mangling perhaps?

>
> This attribute has an additional benefit that it can be used even on
> non-inline functions to gain argument size information.
>
> [1] https://github.com/llvm/llvm-project/issues/53516
>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler=
_attributes.h
> index 37e260020221..4ce370094e3a 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -263,6 +263,20 @@
>   */
>  #define __packed                        __attribute__((__packed__))
>
> +/*
> + * Note: the "type" argument should match any __builtin_object_size(p, t=
ype) usage.
> + *
> + * Optional: not supported by gcc.
> + * Optional: not supported by icc.
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-objec=
t-size-pass-dynamic-object-size
> + */
> +#if __has_attribute(__pass_object_size__)
> +# define __pass_object_size(type)      const __attribute__((__pass_objec=
t_size__(type)))
> +#else
> +# define __pass_object_size(type)
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.=
html#index-pure-function-attribute
>   */
> --
> 2.30.2
>


--=20
Thanks,
~Nick Desaulniers
