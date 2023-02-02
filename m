Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BDEC05027
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBBWtE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBBWtD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Feb 2023 17:49:03 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFCE23C49
        for <linux-hardening@vger.kernel.org>; Thu,  2 Feb 2023 14:49:02 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m199so4227401ybm.4
        for <linux-hardening@vger.kernel.org>; Thu, 02 Feb 2023 14:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gNA4C4UihjneUIjcFqX08gIYJikAuQ32UbK2Pru/1I=;
        b=eXEV/h9ck3KRFOC0ByQf7K9dBgY69UZLz6azXFp3xsXycbPYGy4+XbeA+lIwQ8gFPz
         T8ZcTs1vb8v2RnQgTIvkWTEaL5b0+nBGUzd68TC7jljIiOutc1V3EwFUULs1pUFJ45AV
         CcKKJiSlBY8SLLL7SpFcwclCggdDLgDKxIMqc//u6FrzcrEQ/6G4O1Jt5JkBJfRGHDKd
         3UCUso5eZg15Xs4buGiqqGRtssbGFcpBEopEn05zq7B/YmjtqtcHiwweYToTp/W5cXl5
         px2m3nQ/kpbK6joPU/xzDE+g6KOaSKlC1Mr1eUtrXpLCO8jddY1iHOQxiak/G+NC1MIE
         ujkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gNA4C4UihjneUIjcFqX08gIYJikAuQ32UbK2Pru/1I=;
        b=3mJB6Q1J1WjcIvI8W5VanNZBQ5VjJtyHPy9joRKoR9PD0ftV10kpPeXeVCDGC0sQS2
         oxlm2TrdIOeMu12v10Yd8WUbNdevL7fPc6iVkL2vp30ekWamJ+d190VzsiiuJJsBtKEA
         ZsfwzgzD8GHiwn+p2shBl1NLdh1nl83/gq2edZnTN9v/Q3zqEWVoW6aZhglCMwI2fGG3
         /H2fkXBCEfrxlf/ptsjFAvndePhCpDnp96GjqjwBYUpTDTs3KuvLo2R21BoPr6lRtrPs
         ktBJY11vbZqU4OXaQnHUyZzJvtD4nTtlGeOyV89RsHNI4VPVmzof1nNyLc7f5Ra/yOZX
         L50A==
X-Gm-Message-State: AO0yUKU8taQXiYzXlv89jmChCTDqbGwsjDGacdHQZ4Xdbh+qtU2Omw5L
        H/xHDBAc+i57m3BsmeeHXzJpm2DosHFachQ/+W47
X-Google-Smtp-Source: AK7set8DpBR6h3vjqBWo+Zrt62eyBKF1nPb5+u0iZqS7mgjSxrSv1ddMq4XIo9cKGrMGhsBe38+jCvOh+DzpO2R2LHE=
X-Received: by 2002:a25:ace6:0:b0:84f:45b:b39c with SMTP id
 x38-20020a25ace6000000b0084f045bb39cmr652328ybd.49.1675378141857; Thu, 02 Feb
 2023 14:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20230202223653.never.473-kees@kernel.org>
In-Reply-To: <20230202223653.never.473-kees@kernel.org>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 2 Feb 2023 14:48:50 -0800
Message-ID: <CANDhNCpz+vCqXMDES+_cu8PuTi2c9jhcFqZ8TCVJimAOABjCrg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better reporting
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 2, 2023 at 2:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> and actually report UBSAN traps with some specificity when building with
> CONFIG_UBSAN_TRAP. Before:
>
>   Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
>
> After:
>
>   Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP
>

This is really great ! When I brought up the opaque error messages
just a few hours ago, I didn't imagine you'd have a solution so
quickly!

I really appreciate your lightning fast effort here!

Really, thanks so much! I think this will have a big impact for folks
running into these new bug catchers.
-john
