Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D52C63797
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Jan 2023 10:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAPKb4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAPKbz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Jan 2023 05:31:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB04D1A972
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 02:31:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d62so13587700ybh.8
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 02:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VUQbpg5HItyWZZQATZnM4RSqQnbK+YIpF8+VzAqkd5I=;
        b=IstoYocSG5xOkpunE8iwoJn5VW1Lf6txDYxlwbE9gLBA4UUbZcr2TsYfEIb7+6bVpa
         p31BAHAWnZz/ffgjLfOi2kZ4218d3P0P5yNcCSIE21W4PgPo5RAyXQLO2zSXfX9lBEVJ
         qiwvYlGO/06zz8euC5RyVJ0KBJf845R8Qj4egFcq3aSwfSh/bpuCy/XnYYAXMFid96pZ
         rXqqE6/KPqIisaVgCxYJLJFK3YOcw+xfWLgCvuR3DDL6oANtpDmhxtBFshAbp/XKksZr
         ltv8rLiFpujyenRrpCAR1IB0yInd9y73VzdZgyKNDbgqQBnxwvdx3R5nSuVQ/0c+BsZ3
         AY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUQbpg5HItyWZZQATZnM4RSqQnbK+YIpF8+VzAqkd5I=;
        b=Rp5cCWFF2trPECC3u/fKG+eyfVTdvquzfVkrub5FLw0dZuxN27wOE5ME9f5WrLKI6I
         ktc/xUz9EEJKEJD77taAGzEr8YfSuwz2nEEgdTT4zHhnZ5bqYVECg9lVSTHSK+f8cQBv
         gtTBZecMO/g8LeoaXFwG7R1pjOgBRW3DCBRGIMvpQd578LWh3mFvxL0oE7caE1qEcl+j
         UnUcrHDjBYPkXeMOAxSE192IMR5j9Ruro9PJ/Qzv02yMSfit8rJQaKjL/lELaiUnnkwQ
         e6ZJRVznvk4OS6uPmEAJ3HmE01a4bIVXWFJrY4M55Qr+D3VQmu0NW0Wjdmz9oeWJ8qq6
         CGYQ==
X-Gm-Message-State: AFqh2koi7QEEsHjSv6MZkJn5PMQivfQec7XPB4A3VwzwjVxhft5+O66f
        5TCWbjtNH1zISdSzbfDnwPXfh1AM29pT+jjEBCyb+g==
X-Google-Smtp-Source: AMrXdXtm3G4lKafxGxvq3NBWSBSPmy4LNh0BElo99Uxgk7TClAhifk5n9ULTCijISaHOiEGO3x4inVbPGzqsOcccfgk=
X-Received: by 2002:a25:6b0b:0:b0:7d2:8687:aea5 with SMTP id
 g11-20020a256b0b000000b007d28687aea5mr1186817ybc.210.1673865114014; Mon, 16
 Jan 2023 02:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105215706.never.027-kees@kernel.org> <CACRpkdYfsY7K8GksccDunCfKHbq_Df8ddrYGRg2gmeu6CVCF5w@mail.gmail.com>
 <202301121452.14D1A95CA@keescook>
In-Reply-To: <202301121452.14D1A95CA@keescook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 11:31:42 +0100
Message-ID: <CACRpkdb7VcxgZKVYZJAU4mFS1RPwxpDTxvLjFRGFuEiyVgbE2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: ixp4xx: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 11:54 PM Kees Cook <keescook@chromium.org> wrote:
> On Sun, Jan 08, 2023 at 12:58:37AM +0100, Linus Walleij wrote:
> > On Thu, Jan 5, 2023 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > > Zero-length arrays are deprecated[1]. Replace npe_load_firmware's
> > > union of 0-length arrays with flexible arrays. Detected with GCC 13,
> > > using -fstrict-flex-arrays=3:
> > >
> > > drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'npe_load_firmware':
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:570:60: warning: array subscript i is outside array bounds of 'u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
> > >   570 |                         image->data[i] = swab32(image->data[i]);
> > > include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
> > >   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> > >       |                                                      ^
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:570:42: note: in expansion of macro 'swab32'
> > >   570 |                         image->data[i] = swab32(image->data[i]);
> > >       |                                          ^~~~~~
> > > drivers/soc/ixp4xx/ixp4xx-npe.c:522:29: note: while referencing 'data'
> > >   522 |                         u32 data[0];
> > >       |                             ^~~~
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > >
> > > Cc: Krzysztof Halasa <khalasa@piap.pl>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Looks good to me:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks!
>
> > Do you need me to funnel this to the SoC tree or do you have
> > some quickpath for fixes like this?
>
> I'll take it via my tree if unless you'd rather it go through yours.
> Most maintainers take these directly, but some don't want to. I'm
> flexible! :)

Just pick it into your tree, the IXP4xx is low activity and I do not
submit new material every merge window, so this is easiest.

Thanks!
Linus Walleij
