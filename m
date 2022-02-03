Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B28C433FE
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355887AbiBCUnz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356542AbiBCUly (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:41:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9902FC0613B7
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:37:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o12so8390637lfg.12
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VrxapYZdFw5zNLlkG7gwQPQd4MEqlLeWHHaNG101EE=;
        b=iCzeaUDYVxkrKStctnh8zTlYnJAAnFTeTA+LUgTna1b2xHj7nYwsZzrWUq+lpOMu83
         hFYTUH1t2BGH0R0K84qzSGj7WZfSb0zOJ2HX2O59nvLkeAlgQkjs9bUMrtHGXFVhvmdc
         qbDBPiIfo/AIUQsTRKQ2xTIEHF3zDJM1D3Yzqtk4pigP8J+2t0QRhWVAfLHGALrVdDfB
         4I78e9t1ZCyXsLUOqKmlUn0qY2tsP1rPnrag0+pKS/h0LkzxSWvPQ4BYmVAPzXL3YLyk
         +epwFz/vCNK8khzRX+jNkDsGrbrZDaLCjSyTMAQUzHPPvzoQLjMbxNsKu2AjBSyTbvm8
         Qkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VrxapYZdFw5zNLlkG7gwQPQd4MEqlLeWHHaNG101EE=;
        b=7/LnvRJd3n5yAEnhpXrbEHlF8As4SLsm5s1dBOT0OAgP+mohmP9KUkfl+OdQGPP9wT
         9TJOfavXkA4bUbH1JVQ1bc/zcd1IT2ipwONhoOGpA/UqgQCvA1ktpzDCnIChsfNye9Y6
         3dCJj4rLQ5pqofM4J0BpPRZxyLwb45kgBP5Mi8f4wRUkD3BbimbvANIfHs7nqq5k5WsA
         whDsdetrxnzVB3PqHL10blb8VxOCw8hQ8Gp97pe3LDNRd6m4y99ZZEl/qPzBzAImDUIy
         plYMIkpwadXmoNDhEkOz04G1oROzMra0ArgRlhqj+MBCo+Ebu34lNaDOpO3Aq4/1usYF
         A83g==
X-Gm-Message-State: AOAM533VplDok5XzWymsub39ijpVZv83rJe3il/PvktjmAKG1JOQ2pmu
        +xEacHtEy8jWsZwQts8UL+k5VFhclh/UBxw5VlEkfA==
X-Google-Smtp-Source: ABdhPJyEO7toB9Xk7e12MVsMQizH8I6uc0Z/+GxXMZU3C+7qqlJE+19v8i3RwheJW1fHMv6ZQfY04Q/j+HvgjnlzS2w=
X-Received: by 2002:a05:6512:3c96:: with SMTP id h22mr28020130lfv.489.1643920672718;
 Thu, 03 Feb 2022 12:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org> <20220203173307.1033257-5-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:37:41 -0800
Message-ID: <CAKwvOdk0UMAaw2j9OmjXN0Jc6FBOhfMP3JmSqMps2_MQFQLq-g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> Enable FORTIFY_SOURCE support for Clang:
>
> Use the new __pass_object_size and __overloadable attributes so
> that Clang will have appropriate visibility into argument sizes such
> that __builtin_object_size(p, 1) will behave correctly. Additional
> details here:
>     https://github.com/llvm/llvm-project/issues/53516
>     https://github.com/ClangBuiltLinux/linux/issues/1401
>
> When available, use the new __diagnose_as attribute to make sure no
> compile-time diagnostic warnings are lost due to the effectively renamed
> string functions.

Consider adding something along the lines of the following to the
above paragraph:
Without diagnose_as, compile time error messages won't be as precise
as they could be, but at least users of older toolchains will have
fortified routines. That is more valuable, but certainly a tradeoff.

>
> Redefine strlen() as a macro that tests for being a constant expression
> so that strlen() can still be used in static initializers, which was
> lost when adding __pass_object_size and __overloadable.

I'd like to see `const` changes explicit in 4/4; I suspect that's
_why_ __overloadable is even needed? If so, then a comment here about
that wouldn't hurt.

Having const be more explicit in the signature will make it more
obvious why the definition cannot modify the parameter.


-- 
Thanks,
~Nick Desaulniers
