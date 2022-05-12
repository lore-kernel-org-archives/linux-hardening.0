Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D4C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 12 May 2022 21:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358906AbiELVyw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 May 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358996AbiELVyh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 May 2022 17:54:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BE54BE1
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 14:54:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f83983782fso72140267b3.6
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1VU58MHQqP+/7H+d1w/E+L2ZvFeIXOvlm41/oypmL0=;
        b=sOYt/Gx0hkqvhlgblLEO/HYJxZTdK226ravqNQqKOZQ4UJ5y4ThWbN3ehEwwngDlYf
         11tzgbu0WDOYcy1r8mukQ0ovGT+JvnNid4hvM/mwJSBL9p6kxhhMPl1VxGiE1H/Brvx6
         sapouRkIaz3YQWLwT6VqH4XBSxiLo/uPAiRrSo/Sc0ntI2pRCWlzprmHwvostLXD2a1k
         qhLlOWMG5cY3OqsqNkLjwCh4XSsVHyjdQAiYDfTxJxahxf6nPPoJvTrjufeZHC9GpGfR
         af8bi9WIHNWL/KF5rHUcdbfZUiKC9vjY0PXp3N2S78bHVYiW6GXw6Cvfpo82kcxnTVm/
         Ec4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1VU58MHQqP+/7H+d1w/E+L2ZvFeIXOvlm41/oypmL0=;
        b=m1SZIr4TlYnE0T0OVB0Fr3PhzV80i9ScqXvHkKCvsQfJe/u4FdVYqSS9dt2j4JGwia
         6oyYZwXBYxFtCkKuvyIi+c7nWdH3jal5Tr0lDoPntfnBF3ckBwkrByQIu7cavfR55U8p
         0QR8ifdvAaoXfJJuZdw3xIo/FJ+9qIw6kaA8WpzRGnaY0IjdeDWuGRCvTefTagGlH5yI
         nT4cr5ICQNIW3Y7+5ticWy22wnBzIpLieLid4dTCGEbfzcpsg38X8yYZDtJpeFTJSczl
         yqlfU6k/2r4SnYiApwnDj5t8tXf8xZ3h9R0e/b1jDYTp3v0Zc6+aIL4bbs8WQPOE9mlU
         QSxQ==
X-Gm-Message-State: AOAM531myCmxSAHsO5g+zfR2slVn8L2Vtzw0lEvpej3eeiGlR+wA2WDi
        LBHix0fXiz1VfbNk+MVIbNfJ2zO1BPM2zFoEOvhSqw==
X-Google-Smtp-Source: ABdhPJzvEO0jiVxrIG+1xE2X6cZ/BJG2CWgwTmUY1c9wQnpnOTd/I357N8dayLCf00VtX03B0P1jTijf3GPai6A5/ak=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr2377894ywd.118.1652392475988; Thu, 12
 May 2022 14:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
 <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com> <YmpedDjzZXz2t6NS@smile.fi.intel.com>
 <DA101ED8-F99F-4DCB-9CB7-370A62C44B65@linux.microsoft.com>
In-Reply-To: <DA101ED8-F99F-4DCB-9CB7-370A62C44B65@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 May 2022 23:54:23 +0200
Message-ID: <CACRpkdadjPn82G4TMKyyQtkju=oA4EX=GNxs8KRtrQ7CcqVOog@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        olivier.dautricourt@orolia.com, sr@denx.de,
        Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com, afaerber@suse.de,
        mani@kernel.org, logang@deltatee.com, sanju.mehta@amd.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        green.wan@sifive.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 6, 2022 at 7:43 PM Allen Pais <apais@linux.microsoft.com> wrote:

>  - Concerns regarding throughput, would workqueues be as efficient as tasklets (Vinod)

You need to ask the scheduler people about this.

The workqueues goes deep into the scheduler and I can't make
out how they are prioritized, but they are certainly not treated
like any other task.

Yours,
Linus Walleij
